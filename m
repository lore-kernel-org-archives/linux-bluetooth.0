Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3 v2] core/device: Don't call btd_service_disconnect on device_remove
Date: Tue,  9 Jul 2013 15:03:53 +0300
Message-Id: <1373371433-11800-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373371433-11800-1-git-send-email-luiz.dentz@gmail.com>
References: <1373371433-11800-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

device_remove is called to cleanup/free the device objects so the
services should be disconnected before hand.
---
 src/device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index dbaf548..88a7b86 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2381,8 +2381,6 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	if (device->browse)
 		browse_request_cancel(device->browse);
 
-	g_slist_foreach(device->services, dev_disconn_service, NULL);
-
 	while (device->services != NULL) {
 		struct btd_service *service = device->services->data;
 
-- 
1.8.1.4

