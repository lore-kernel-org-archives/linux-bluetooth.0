Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/device: Don't persist private devices
Date: Fri,  1 Jul 2016 17:31:00 +0300
Message-Id: <1467383460-13498-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Device which address is private should not be allowed to reset the
temporary flag since it settings cannot be stored and the address
may never be used again after disconnecting.
---
 src/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/device.c b/src/device.c
index 5506bc9..82704f8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5141,6 +5141,9 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
 	if (device->temporary == temporary)
 		return;
 
+	if (device_address_is_private(device))
+		return;
+
 	DBG("temporary %d", temporary);
 
 	device->temporary = temporary;
-- 
2.7.4

