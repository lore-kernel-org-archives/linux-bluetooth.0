Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] core/device: Fix not handling notification
Date: Fri, 13 Mar 2015 10:54:11 +0200
Message-Id: <1426236852-10501-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1426236852-10501-1-git-send-email-luiz.dentz@gmail.com>
References: <1426236852-10501-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

attio callbacks needs to be triggered as soon as possible once connected
otherwise profiles such as HoG may miss notification that are sent while
bt_gatt_client is doing MTU exchange.
---
 src/device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 831efea..0dc8c86 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3984,8 +3984,6 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 
 	device_accept_gatt_profiles(device);
 
-	g_slist_foreach(device->attios, attio_connected, device->attrib);
-
 	btd_gatt_client_ready(device->client_dbus);
 }
 
@@ -4007,6 +4005,9 @@ static void gatt_client_init(struct btd_device *device)
 		return;
 	}
 
+	/* Notify attio so it can react to notifications */
+	g_slist_foreach(device->attios, attio_connected, device->attrib);
+
 	if (!bt_gatt_client_set_ready_handler(device->client,
 							gatt_client_ready_cb,
 							device, NULL)) {
-- 
2.1.0

