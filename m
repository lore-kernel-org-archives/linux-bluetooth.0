Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Detect Wii Remotes by device name
Date: Wed, 22 Feb 2012 21:29:51 +0100
Message-Id: <1329942591-2485-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We currently detect Wii Remotes by DID information. However, not all Wii Remotes
(especially 3rd party Wii Remotes) provide DID information. Moreover, they
provide no way of identifying them aside from their device name. Hence, this
adds an experimental name-detection for Wii Remotes.
---
 plugins/wiimote.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index 1ae638b..568bfd5 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -26,6 +26,7 @@
 #endif
 
 #include <bluetooth/bluetooth.h>
+#include <glib.h>
 
 #include "plugin.h"
 #include "adapter.h"
@@ -60,18 +61,20 @@ static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
 {
 	uint16_t vendor, product;
 	bdaddr_t sba, dba;
-	char addr[18];
+	char addr[18], name[25];
 
 	adapter_get_address(adapter, &sba);
 	device_get_address(device, &dba, NULL);
 	ba2str(&dba, addr);
 
 	vendor = btd_device_get_vendor(device);
-	if (vendor != 0x057e)
-		return 0;
-
 	product = btd_device_get_product(device);
-	if (product == 0x0306) {
+
+	device_get_name(device, name, sizeof(name));
+	name[sizeof(name) - 1] = 0;
+
+	if (g_str_equal(name, "Nintendo RVL-CNT-01") ||
+				(vendor == 0x057e && product == 0x0306)) {
 		DBG("Forcing fixed pin on detected wiimote %s", addr);
 		memcpy(pinbuf, &sba, 6);
 		return 6;
-- 
1.7.8.1
