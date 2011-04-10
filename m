Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, hadess@hadess.net, dforsi@gmail.com,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 3/4] Parse pin codes starting with '$' as hexadecimal encoded strings
Date: Sun, 10 Apr 2011 19:11:16 +0200
Message-Id: <1302455477-27664-4-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1302455477-27664-1-git-send-email-dh.herrmann@googlemail.com>
References: <1302455477-27664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a pin code is retrieved from an agent and the first character is
a dollar sign '$', then the pin is decoded as following:
  - The first character (dollar sign) is stripped from the pin
  - The rest is parsed as hexadecimal numbers, where each two characters
    will be converted into a one byte integer. If an odd number of
    characters follows, then the last character is stripped. Empty
    pins are valid. Parser is case insensitive.
Pins not starting with '$' are parsed as usual.

For instance:
  pin: $0A3e005067
is decoded into a 5 byte pin:
  decoded: 0x0a 0x3e 0x00 0x50 0x67
---
 src/event.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/src/event.c b/src/event.c
index 248fb78..f2fc688 100644
--- a/src/event.c
+++ b/src/event.c
@@ -101,12 +101,52 @@ static gboolean get_adapter_and_device(bdaddr_t *src, bdaddr_t *dst,
  *
  *****************************************************************/
 
+static char hex2dec(char c)
+{
+	if (c >= '0' && c <= '9')
+		return  c - '0';
+	else if (c >= 'A' && c <= 'F')
+		return c - 'A' + 10;
+	else if (c >= 'a' && c <= 'f')
+		return c - 'a' + 10;
+	else
+		return 0;
+}
+
+static size_t decode_hex(const char *pin, char *out)
+{
+	size_t i;
+
+	for (i = 0; i < 16 && pin[i * 2] && pin[i * 2 + 1]; ++i)
+		out[i] = hex2dec(pin[i * 2]) * 16 + hex2dec(pin[i * 2 + 1]);
+	return i;
+}
+
+static size_t decode_pin(const char *pin, char *out)
+{
+	size_t len;
+
+	if (!pin) {
+		return 0;
+	}
+	else if (pin[0] == '$') {
+		len = decode_hex(&pin[1], out);
+	}
+	else {
+		len = strnlen(pin, 16);
+		memcpy(out, pin, len);
+	}
+	return len;
+}
+
 static void pincode_cb(struct agent *agent, DBusError *derr,
 				const char *pincode, struct btd_device *device)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	bdaddr_t sba, dba;
 	int err;
+	size_t len;
+	char rawpin[16];
 
 	device_get_address(device, &dba);
 
@@ -117,7 +157,8 @@ static void pincode_cb(struct agent *agent, DBusError *derr,
 		return;
 	}
 
-	err = btd_adapter_pincode_reply(adapter, &dba, pincode, pincode ? strlen(pincode) : 0);
+	len = decode_pin(pincode, rawpin);
+	err = btd_adapter_pincode_reply(adapter, &dba, rawpin, len);
 	if (err < 0)
 		goto fail;
 
-- 
1.7.4.4

