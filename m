Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 3/8] android: Pass mode parameter to registered services
Date: Mon,  3 Mar 2014 00:50:44 +0100
Message-Id: <1393804249-12392-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393804249-12392-1-git-send-email-szymon.janc@tieto.com>
References: <1393804249-12392-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/a2dp.c      |  2 +-
 android/a2dp.h      |  2 +-
 android/avrcp.c     |  2 +-
 android/avrcp.h     |  2 +-
 android/bluetooth.c |  2 +-
 android/bluetooth.h |  2 +-
 android/handsfree.c |  2 +-
 android/handsfree.h |  2 +-
 android/hidhost.c   |  2 +-
 android/hidhost.h   |  2 +-
 android/main.c      | 14 +++++++-------
 android/pan.c       |  2 +-
 android/pan.h       |  2 +-
 android/socket.c    |  2 +-
 android/socket.h    |  2 +-
 15 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 180d015..4ea16e2 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1564,7 +1564,7 @@ retry:
 						audio_disconnected);
 }
 
-bool bt_a2dp_register(struct ipc *ipc, const bdaddr_t *addr)
+bool bt_a2dp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
 	GError *err = NULL;
 	sdp_record_t *rec;
diff --git a/android/a2dp.h b/android/a2dp.h
index b41a178..8a70407 100644
--- a/android/a2dp.h
+++ b/android/a2dp.h
@@ -21,5 +21,5 @@
  *
  */
 
-bool bt_a2dp_register(struct ipc *ipc, const bdaddr_t *addr);
+bool bt_a2dp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
 void bt_a2dp_unregister(void);
diff --git a/android/avrcp.c b/android/avrcp.c
index 678c321..b65f35c 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -364,7 +364,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	DBG("%s connected", address);
 }
 
-bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr)
+bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
 	GError *err = NULL;
 	sdp_record_t *rec;
diff --git a/android/avrcp.h b/android/avrcp.h
index 3dcffeb..11e79b7 100644
--- a/android/avrcp.h
+++ b/android/avrcp.h
@@ -21,7 +21,7 @@
  *
  */
 
-bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr);
+bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
 void bt_avrcp_unregister(void);
 
 void bt_avrcp_connect(const bdaddr_t *dst);
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 8ad7d5d..6d94904 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3285,7 +3285,7 @@ static const struct ipc_handler cmd_handlers[] = {
 	{ handle_le_test_mode_cmd, true, sizeof(struct hal_cmd_le_test_mode) },
 };
 
-void bt_bluetooth_register(struct ipc *ipc)
+void bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 {
 	DBG("");
 
diff --git a/android/bluetooth.h b/android/bluetooth.h
index fbc850d..1c177be 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -31,7 +31,7 @@ void bt_bluetooth_cleanup(void);
 
 void bt_bluetooth_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-void bt_bluetooth_register(struct ipc *ipc);
+void bt_bluetooth_register(struct ipc *ipc, uint8_t mode);
 void bt_bluetooth_unregister(void);
 
 int bt_adapter_add_record(sdp_record_t *rec, uint8_t svc_hint);
diff --git a/android/handsfree.c b/android/handsfree.c
index 81ddcc7..cfdcc1a 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -532,7 +532,7 @@ static sdp_record_t *handsfree_ag_record(void)
 	return record;
 }
 
-bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr)
+bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
 	sdp_record_t *rec;
 	GError *err = NULL;
diff --git a/android/handsfree.h b/android/handsfree.h
index 3ede819..e5eff47 100644
--- a/android/handsfree.h
+++ b/android/handsfree.h
@@ -21,5 +21,5 @@
  *
  */
 
-bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr);
+bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
 void bt_handsfree_unregister(void);
diff --git a/android/hidhost.c b/android/hidhost.c
index e469210..4226f69 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1330,7 +1330,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 }
 
-bool bt_hid_register(struct ipc *ipc, const bdaddr_t *addr)
+bool bt_hid_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
 	GError *err = NULL;
 
diff --git a/android/hidhost.h b/android/hidhost.h
index 1017195..e6b87ed 100644
--- a/android/hidhost.h
+++ b/android/hidhost.h
@@ -21,5 +21,5 @@
  *
  */
 
-bool bt_hid_register(struct ipc *ipc, const bdaddr_t *addr);
+bool bt_hid_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
 void bt_hid_unregister(void);
diff --git a/android/main.c b/android/main.c
index f7fe9c8..c6e08eb 100644
--- a/android/main.c
+++ b/android/main.c
@@ -84,43 +84,43 @@ static void service_register(const void *buf, uint16_t len)
 
 	switch (m->service_id) {
 	case HAL_SERVICE_ID_BLUETOOTH:
-		bt_bluetooth_register(hal_ipc);
+		bt_bluetooth_register(hal_ipc, m->mode);
 
 		break;
 	case HAL_SERVICE_ID_SOCKET:
-		bt_socket_register(hal_ipc, &adapter_bdaddr);
+		bt_socket_register(hal_ipc, &adapter_bdaddr, m->mode);
 
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
-		if (!bt_hid_register(hal_ipc, &adapter_bdaddr)) {
+		if (!bt_hid_register(hal_ipc, &adapter_bdaddr, m->mode)) {
 			status = HAL_STATUS_FAILED;
 			goto failed;
 		}
 
 		break;
 	case HAL_SERVICE_ID_A2DP:
-		if (!bt_a2dp_register(hal_ipc, &adapter_bdaddr)) {
+		if (!bt_a2dp_register(hal_ipc, &adapter_bdaddr, m->mode)) {
 			status = HAL_STATUS_FAILED;
 			goto failed;
 		}
 
 		break;
 	case HAL_SERVICE_ID_PAN:
-		if (!bt_pan_register(hal_ipc, &adapter_bdaddr)) {
+		if (!bt_pan_register(hal_ipc, &adapter_bdaddr, m->mode)) {
 			status = HAL_STATUS_FAILED;
 			goto failed;
 		}
 
 		break;
 	case HAL_SERVICE_ID_AVRCP:
-		if (!bt_avrcp_register(hal_ipc, &adapter_bdaddr)) {
+		if (!bt_avrcp_register(hal_ipc, &adapter_bdaddr, m->mode)) {
 			status = HAL_STATUS_FAILED;
 			goto failed;
 		}
 
 		break;
 	case HAL_SERVICE_ID_HANDSFREE:
-		if (!bt_handsfree_register(hal_ipc, &adapter_bdaddr)) {
+		if (!bt_handsfree_register(hal_ipc, &adapter_bdaddr, m->mode)) {
 			status = HAL_STATUS_FAILED;
 			goto failed;
 		}
diff --git a/android/pan.c b/android/pan.c
index 1e404ab..ce1f677 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -779,7 +779,7 @@ static sdp_record_t *pan_record(void)
 	return record;
 }
 
-bool bt_pan_register(struct ipc *ipc, const bdaddr_t *addr)
+bool bt_pan_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
 	sdp_record_t *rec;
 	int err;
diff --git a/android/pan.h b/android/pan.h
index 2045ac5..cfbea96 100644
--- a/android/pan.h
+++ b/android/pan.h
@@ -21,5 +21,5 @@
  *
  */
 
-bool bt_pan_register(struct ipc *ipc, const bdaddr_t *addr);
+bool bt_pan_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
 void bt_pan_unregister(void);
diff --git a/android/socket.c b/android/socket.c
index afa2008..7bc77ed 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -1129,7 +1129,7 @@ static const struct ipc_handler cmd_handlers[] = {
 	{ handle_connect, false, sizeof(struct hal_cmd_socket_connect) },
 };
 
-void bt_socket_register(struct ipc *ipc, const bdaddr_t *addr)
+void bt_socket_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
 	size_t i;
 
diff --git a/android/socket.h b/android/socket.h
index a1eca5a..b0e78c6 100644
--- a/android/socket.h
+++ b/android/socket.h
@@ -28,5 +28,5 @@ struct hal_sock_connect_signal {
 	int     status;
 } __attribute__((packed));
 
-void bt_socket_register(struct ipc *ipc, const bdaddr_t *addr);
+void bt_socket_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
 void bt_socket_unregister(void);
-- 
1.8.5.3

