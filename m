Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 3/5 v3] Parse pin codes starting with '$' as hexadecimal encoded strings
Date: Thu,  5 May 2011 22:10:30 +0200
Message-Id: <1304626230-30992-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a pin code is retrieved from an agent and the first character is
a dollar sign '$', then the pin is decoded as following:
 - The first character (dollar sign) is stripped from the pin
 - The rest is parsed as hexadecimal numbers, where each two characters
   will be converted into a one byte integer. If an odd number of
   characters follows, then the last character is stripped.
Parser is case insensitive. Pins not starting with '$' are parsed
as usual.

For instance:
 pin: $0A3e005067
is decoded into a 5 byte pin:
 decoded: 0x0a 0x3e 0x00 0x50 0x67
---
This removes support for empty PINs (pin = "$") as suggested by Johan
since HCI specs forbid it.

 src/event.c |   35 ++++++++++++++++++++++++++++++++---
 1 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/src/event.c b/src/event.c
index c238392..a8dbafc 100644
--- a/src/event.c
+++ b/src/event.c
@@ -101,24 +101,53 @@ static gboolean get_adapter_and_device(bdaddr_t *src, bdaddr_t *dst,
  *
  *****************************************************************/
 
+static size_t decode_hex(const char *pin, char *out)
+{
+	size_t i;
+
+	for (i = 0; i < 16 && pin[i * 2] && pin[i * 2 + 1]; i++)
+		sscanf(&pin[i * 2], "%02hhX", &out[i]);
+
+	return i;
+}
+
+static size_t decode_pin(const char *pin, char *out)
+{
+	size_t len;
+
+	if (!pin)
+		return 0;
+
+	if (pin[0] == '$') {
+		len = decode_hex(&pin[1], out);
+	} else {
+		len = strnlen(pin, 16);
+		memcpy(out, pin, len);
+	}
+
+	return len;
+}
+
 static void pincode_cb(struct agent *agent, DBusError *derr,
 				const char *pincode, struct btd_device *device)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	bdaddr_t dba;
 	int err;
+	size_t len;
+	char rawpin[16];
 
 	device_get_address(device, &dba);
 
-	if (derr) {
+	len = decode_pin(pincode, rawpin);
+	if (derr || !len) {
 		err = btd_adapter_pincode_reply(adapter, &dba, NULL, 0);
 		if (err < 0)
 			goto fail;
 		return;
 	}
 
-	err = btd_adapter_pincode_reply(adapter, &dba, pincode,
-						pincode ? strlen(pincode) : 0);
+	err = btd_adapter_pincode_reply(adapter, &dba, rawpin, len);
 	if (err < 0)
 		goto fail;
 
-- 
1.7.5

