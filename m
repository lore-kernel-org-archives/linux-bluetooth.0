Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 4/6] android/gatt: Make sure GATT will reconnect after disconnection
Date: Wed,  3 Sep 2014 08:58:05 +0200
Message-Id: <1409727487-19074-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409727487-19074-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409727487-19074-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch once remote is disconnected there is decision taken if
BfA should wait for reconnect or not.

Removing device from the autoconnect list has been removed from
connect_cb as it is now handled during disconnection
---
 android/gatt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 542c9b4..0182c5d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -650,6 +650,13 @@ static void connection_cleanup(struct gatt_device *device)
 		queue_remove_all(device->services, NULL, NULL, destroy_service);
 
 	device_set_state(device, DEVICE_DISCONNECTED);
+
+	if (!queue_isempty(device->autoconnect_apps)) {
+		auto_connect_le(device);
+		device_set_state(device, DEVICE_CONNECT_INIT);
+	} else {
+		bt_auto_connect_remove(&device->bdaddr);
+	}
 }
 
 static void destroy_gatt_app(void *data)
@@ -1463,9 +1470,6 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	device_set_state(dev, DEVICE_CONNECTED);
 
-	if (queue_isempty(dev->autoconnect_apps))
-		bt_auto_connect_remove(&dev->bdaddr);
-
 	/* Send exchange mtu request as we assume being client and server */
 	/* TODO: Dont exchange mtu if no client apps */
 	send_exchange_mtu_request(dev);
-- 
1.8.4

