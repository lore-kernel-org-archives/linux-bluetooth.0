Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 08/15] android/hardware: Update bt_gatt_server.h header
Date: Thu,  6 Nov 2014 17:05:53 +0200
Message-Id: <1415286360-26268-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hardware/bt_gatt_server.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/android/hardware/bt_gatt_server.h b/android/hardware/bt_gatt_server.h
index 1a5a400..2b1de27 100644
--- a/android/hardware/bt_gatt_server.h
+++ b/android/hardware/bt_gatt_server.h
@@ -104,6 +104,19 @@ typedef void (*request_exec_write_callback)(int conn_id, int trans_id,
  */
 typedef void (*response_confirmation_callback)(int status, int handle);
 
+/**
+ * Callback confirming that a notification or indication has been sent
+ * to a remote device.
+ */
+typedef void (*indication_sent_callback)(int conn_id, int status);
+
+/**
+ * Callback notifying an application that a remote device connection is currently congested
+ * and cannot receive any more data. An application should avoid sending more data until
+ * a further callback is received indicating the congestion status has been cleared.
+ */
+typedef void (*congestion_callback)(int conn_id, bool congested);
+
 typedef struct {
     register_server_callback        register_server_cb;
     connection_callback             connection_cb;
@@ -118,6 +131,8 @@ typedef struct {
     request_write_callback          request_write_cb;
     request_exec_write_callback     request_exec_write_cb;
     response_confirmation_callback  response_confirmation_cb;
+    indication_sent_callback        indication_sent_cb;
+    congestion_callback             congestion_cb;
 } btgatt_server_callbacks_t;
 
 /** Represents the standard BT-GATT server interface. */
@@ -129,7 +144,8 @@ typedef struct {
     bt_status_t (*unregister_server)(int server_if );
 
     /** Create a connection to a remote peripheral */
-    bt_status_t (*connect)(int server_if, const bt_bdaddr_t *bd_addr, bool is_direct );
+    bt_status_t (*connect)(int server_if, const bt_bdaddr_t *bd_addr,
+                            bool is_direct, int transport);
 
     /** Disconnect an established connection or cancel a pending one */
     bt_status_t (*disconnect)(int server_if, const bt_bdaddr_t *bd_addr,
@@ -168,6 +184,7 @@ typedef struct {
     /** Send a response to a read/write operation */
     bt_status_t (*send_response)(int conn_id, int trans_id,
                                  int status, btgatt_response_t *response);
+
 } btgatt_server_interface_t;
 
 __END_DECLS
-- 
1.9.1

