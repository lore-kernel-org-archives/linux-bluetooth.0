Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Fix adding BR/EDR devices to auto connect list
Date: Thu, 13 Mar 2014 16:17:42 +0200
Message-Id: <1394720262-460-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This can happen with devices that export ATT profiles as SDP records
such BlackBerry phones causing drivers to get probed which then call
btd_device_add_attio_callback to get notified once connected.
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index e624445..46e881c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3908,7 +3908,7 @@ static void device_set_auto_connect(struct btd_device *device, gboolean enable)
 {
 	char addr[18];
 
-	if (!device)
+	if (!device || !device->le)
 		return;
 
 	ba2str(&device->bdaddr, addr);
-- 
1.8.5.3

