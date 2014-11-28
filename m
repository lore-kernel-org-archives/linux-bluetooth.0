Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] android/client: Add gatt server callbacks support for Android 5.0
Date: Fri, 28 Nov 2014 09:22:05 +0100
Message-Id: <1417162925-17511-7-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1417162925-17511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1417162925-17511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index b39a5ec..8593fd2 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -982,6 +982,27 @@ static void gatts_response_confirmation_cb(int status, int handle)
 	haltest_info("%s: status=%d handle=0x%x\n", __func__, status, handle);
 }
 
+/**
+ * Callback confirming that a notification or indication has been sent
+ * to a remote device.
+ */
+static void gatts_indication_sent_cb(int conn_id, int status)
+{
+	haltest_info("%s: status=%d conn_id=%d", __func__, status, conn_id);
+}
+
+/**
+ * Callback notifying an application that a remote device connection is
+ * currently congested and cannot receive any more data. An application
+ * should avoid sending more data until a further callback is received
+ * indicating the congestion status has been cleared.
+ */
+static void gatts_congestion_cb(int conn_id, bool congested)
+{
+	haltest_info("%s: conn_id=%d congested=%d", __func__, conn_id,
+								congested);
+}
+
 static const btgatt_server_callbacks_t btgatt_server_callbacks = {
 	.register_server_cb = gatts_register_server_cb,
 	.connection_cb = gatts_connection_cb,
@@ -995,7 +1016,11 @@ static const btgatt_server_callbacks_t btgatt_server_callbacks = {
 	.request_read_cb = gatts_request_read_cb,
 	.request_write_cb = gatts_request_write_cb,
 	.request_exec_write_cb = gatts_request_exec_write_cb,
-	.response_confirmation_cb = gatts_response_confirmation_cb
+	.response_confirmation_cb = gatts_response_confirmation_cb,
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	.indication_sent_cb = gatts_indication_sent_cb,
+	.congestion_cb = gatts_congestion_cb,
+#endif
 };
 
 static const btgatt_callbacks_t gatt_cbacks = {
-- 
1.9.3

