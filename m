Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/gatt: Remove reconnect feature
Date: Wed, 16 Apr 2014 22:18:31 +0200
Message-Id: <1397679511-16947-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes reconnect try when remote BLE device got
disconnected.
This is to avoid confusion of Android framework which now get ACL
states changed event with state disconnected on Bluetooth HAL but no
disconnected Event on GATT HAL.
---
 android/gatt.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f52cb36..fa664cd 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -864,25 +864,9 @@ static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
 
 	sock = g_io_channel_unix_get_fd(io);
 	len = sizeof(err);
-	if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len) < 0)
-		goto done;
-
-	DBG("%s (%d)", strerror(err), err);
-
-	/* Keep scanning/re-connection active if disconnection reason
-	 * is connection timeout, remote user terminated connection or local
-	 * initiated disconnection.
-	 */
-	if (err == ETIMEDOUT || err == ECONNRESET || err == ECONNABORTED) {
-		if (!queue_push_tail(conn_wait_queue, dev)) {
-			error("gatt: Cannot push data");
-		} else {
-			bt_le_discovery_start(le_device_found_handler);
-			return FALSE;
-		}
-	}
+	if (!getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len))
+		DBG("%s (%d)", strerror(err), err);
 
-done:
 	connection_cleanup(dev);
 
 	queue_foreach(dev->clients, client_disconnect_notify, dev);
-- 
1.8.4

