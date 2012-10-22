Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Peter Olson <peter.olson@gmail.com>,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH bluez] wiimote: add Wii-Remote-Plus ID and name detection
Date: Mon, 22 Oct 2012 10:31:20 +0200
Message-Id: <1350894680-3947-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Nintendo Wii Remote Plus uses a new product ID and name. To detect
them properly, we need to add them to the wiimote-module.

To avoid an overlong "if" statement, this converts the match-function to
walk over an array and check all VID/PID pairs and device-names. This
makes adding new devices much easier.
---
Hi Johan

I am actually not sure why Nintendo changed the VID/PID for the new revisions of
the WiimotePlus. I have a WiimotePlus which still uses the old numbers and works
here quite well. However, I have now got multiple requests from people with the
new device name and IDs. Unfortunately, I cannot test these so I'd like to have
a "Tested-by" by Peter (CC'ed) before this is applied.

Thanks
David

 plugins/wiimote.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index 5708bf8..f506ed6 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2011  David Herrmann <dh.herrmann@googlemail.com>
+ *  Copyright (C) 2011-2012 David Herrmann <dh.herrmann@googlemail.com>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -58,11 +58,23 @@
  * is pressed.
  */
 
+static uint16_t wii_ids[][2] = {
+	{ 0x057e, 0x0306 },
+	{ 0x057e, 0x0330 },
+};
+
+static const char *wii_names[] = {
+	"Nintendo RVL-CNT-01",
+	"Nintendo RVL-CNT-01-TR",
+	"Nintendo RVL-WBC-01",
+};
+
 static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
 						char *pinbuf, gboolean *display)
 {
 	uint16_t vendor, product;
 	char addr[18], name[25];
+	unsigned int i, len;
 
 	ba2str(device_get_address(device), addr);
 
@@ -72,15 +84,24 @@ static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
 	device_get_name(device, name, sizeof(name));
 	name[sizeof(name) - 1] = 0;
 
-	if (g_str_equal(name, "Nintendo RVL-CNT-01") ||
-				g_str_equal(name, "Nintendo RVL-WBC-01") ||
-				(vendor == 0x057e && product == 0x0306)) {
-		DBG("Forcing fixed pin on detected wiimote %s", addr);
-		memcpy(pinbuf, adapter_get_address(adapter), 6);
-		return 6;
+	len = sizeof(wii_ids) / sizeof(wii_ids[0]);
+	for (i = 0; i < len; ++i) {
+		if (vendor == wii_ids[i][0] && product == wii_ids[i][1])
+			goto found;
+	}
+
+	len = sizeof(wii_names) / sizeof(wii_names[0]);
+	for (i = 0; i < len; ++i) {
+		if (g_str_equal(name, wii_names[i]))
+			goto found;
 	}
 
 	return 0;
+
+found:
+	DBG("Forcing fixed pin on detected wiimote %s", addr);
+	memcpy(pinbuf, adapter_get_address(adapter), 6);
+	return 6;
 }
 
 static int wii_probe(struct btd_adapter *adapter)
-- 
1.7.12.4

