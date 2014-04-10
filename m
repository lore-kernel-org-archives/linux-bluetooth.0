Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 5/6] android/gatt: Move put_device_on_disc_list up in the file
Date: Thu, 10 Apr 2014 10:43:00 +0200
Message-Id: <1397119381-13294-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397119381-13294-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397119381-13294-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed by following patch
---
 android/gatt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 769d392..d9c5773 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -568,6 +568,13 @@ static void remove_cl_from_connecting_dev_and_notify(void *data,
 		send_client_connect_notify(id, dev, GATT_FAILURE);
 }
 
+static void put_device_on_disc_list(struct gatt_device *dev)
+{
+	dev->conn_id = 0;
+	queue_remove_all(dev->clients, NULL, NULL, NULL);
+	queue_push_tail(disc_dev_list, dev);
+}
+
 static void remove_client_from_devices(int32_t client_id)
 {
 	queue_foreach(conn_list, remove_cl_from_connected_dev_and_notify,
@@ -820,13 +827,6 @@ connect:
 	bt_le_discovery_stop(bt_le_discovery_stop_cb);
 }
 
-static void put_device_on_disc_list(struct gatt_device *dev)
-{
-	dev->conn_id = 0;
-	queue_remove_all(dev->clients, NULL, NULL, NULL);
-	queue_push_tail(disc_dev_list, dev);
-}
-
 static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-- 
1.8.4

