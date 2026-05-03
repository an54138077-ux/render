#!/usr/bin/env bash
set -euo pipefail

# 1. دانلود و نصب V2Ray اگه وجود نداشت
if [ ! -f /usr/bin/v2ray/v2ray ]; then
  echo "V2Ray پیدا نشد. در حال نصب..."
  V2RAY_URL="https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip"
  wget -q -O /tmp/v2ray.zip "$V2RAY_URL"
  mkdir -p /usr/bin/v2ray
  unzip -q /tmp/v2ray.zip -d /usr/bin/v2ray/
  chmod +x /usr/bin/v2ray/v2ray
  rm /tmp/v2ray.zip
  echo "نصب تموم شد."
fi

# 2. تنظیمات پیش‌فرض
UUID_VAL="${UUID:-139256ab-37c7-412f-9e46-0d0495fefc9f}"
WSPATH_VAL="${WSPATH:-/vless}"
PORT_VAL="${PORT:-8080}"

# 3. ساخت فایل کانفیگ
mkdir -p /etc/v2ray
cat > /etc/v2ray/config.json << EOF
{
  "inbounds": [{
    "port": ${PORT_VAL},
    "protocol": "vless",
    "settings": {
      "clients": [
        {"id": "${UUID_VAL}"}
      ],
      "decryption": "none"
    },
    "streamSettings": {
      "network": "ws",
      "wsSettings": {
        "path": "${WSPATH_VAL}"
      }
    }
  }],
  "outbounds": [{
    "protocol": "freedom"
  }]
}
EOF

# 4. اجرای V2Ray
/usr/bin/v2ray/v2ray -config /etc/v2ray/config.json
