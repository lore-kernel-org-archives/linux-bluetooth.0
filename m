Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/4] android/gatt: Fix sending device to (dis)connect callback
Date: Thu, 10 Apr 2014 16:34:52 +0200
Message-Id: <1397140494-4023-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1397140494-4023-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397140494-4023-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes casting void* at wrong structure. We pass device, not bdaddr
as user data.
---
 android/gatt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index ff19767..525ad41 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -760,12 +760,11 @@ static void put_device_on_disc_list(struct gatt_device *dev)
 static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-	bdaddr_t *addr = user_data;
-	struct gatt_device *dev;
+	struct gatt_device *dev = user_data;
 	int sock, err = 0;
 	socklen_t len;
 
-	dev = queue_remove_if(conn_list, match_dev_by_bdaddr, addr);
+	queue_remove(conn_list, dev);
 
 	sock = g_io_channel_unix_get_fd(io);
 	len = sizeof(err);
@@ -811,16 +810,14 @@ static void send_client_connect_notify(void *data, void *user_data)
 
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
-	bdaddr_t *addr = user_data;
-	struct gatt_device *dev;
+	struct gatt_device *dev = user_data;
 	struct hal_ev_gatt_client_connect ev;
 	GAttrib *attrib;
 	static uint32_t conn_id = 0;
 	int32_t status;
 
 	/* Take device from conn waiting queue */
-	dev = queue_remove_if(conn_wait_queue, match_dev_by_bdaddr, addr);
-	if (!dev) {
+	if (!queue_remove(conn_wait_queue, dev)) {
 		error("gatt: Device not on the connect wait queue!?");
 		g_io_channel_shutdown(io, TRUE, NULL);
 		return;
-- 
1.9.1

