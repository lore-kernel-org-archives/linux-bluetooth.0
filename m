Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ] core: Fix connecting to an already connected device on pairing
Date: Thu, 11 Oct 2012 02:30:46 -0300
Message-Id: <1349933446-10391-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index d85d41c..0635dee 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2940,7 +2940,7 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 	device->bonding = bonding;
 	bonding->device = device;
 
-	if (device_is_le(device)) {
+	if (device_is_le(device) && !device_is_connected(device)) {
 		adapter_connect_list_add(adapter, device);
 		return NULL;
 	}
-- 
1.7.11.4

