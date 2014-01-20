Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH v2 3/5] core: Add flags parameter to bt_search_service
Date: Mon, 20 Jan 2014 12:08:34 +0100
Message-Id: <1390216116-23670-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1390216116-23670-1-git-send-email-szymon.janc@tieto.com>
References: <1390216116-23670-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

This allows to pass custom SDP flags to sdp_connect.
---
 android/bluetooth.c        | 4 ++--
 android/hidhost.c          | 4 ++--
 android/socket.c           | 2 +-
 profiles/health/hdp_util.c | 6 +++---
 src/device.c               | 5 +++--
 src/profile.c              | 2 +-
 src/sdp-client.c           | 8 ++++----
 src/sdp-client.h           | 2 +-
 8 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 505d5a7..83612b4 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -693,7 +693,7 @@ static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 	if (uuid_list[req->search_uuid]) {
 		sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
 		bt_search_service(&adapter.bdaddr, &req->bdaddr, &uuid,
-						browse_cb, user_data, NULL);
+						browse_cb, user_data, NULL, 0);
 		return;
 	}
 
@@ -729,7 +729,7 @@ static uint8_t browse_remote_sdp(const bdaddr_t *addr)
 	sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
 
 	if (bt_search_service(&adapter.bdaddr,
-			&req->bdaddr, &uuid, browse_cb, req, NULL) < 0) {
+			&req->bdaddr, &uuid, browse_cb, req, NULL , 0) < 0) {
 		browse_req_free(req);
 		return HAL_STATUS_FAILED;
 	}
diff --git a/android/hidhost.c b/android/hidhost.c
index aed9899..d66e863 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -751,7 +751,7 @@ static void bt_hid_connect(const void *buf, uint16_t len)
 
 	bt_string2uuid(&uuid, HID_UUID);
 	if (bt_search_service(&adapter_addr, &dev->dst, &uuid,
-					hid_sdp_search_cb, dev, NULL) < 0) {
+					hid_sdp_search_cb, dev, NULL, 0) < 0) {
 		error("Failed to search sdp details");
 		hid_device_free(dev);
 		status = HAL_STATUS_FAILED;
@@ -1254,7 +1254,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 		bt_string2uuid(&uuid, HID_UUID);
 		if (bt_search_service(&src, &dev->dst, &uuid,
-					hid_sdp_search_cb, dev, NULL) < 0) {
+					hid_sdp_search_cb, dev, NULL, 0) < 0) {
 			error("failed to search sdp details");
 			hid_device_free(dev);
 			return;
diff --git a/android/socket.c b/android/socket.c
index 69b39ee..f662e79 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -1091,7 +1091,7 @@ static uint8_t connect_rfcomm(const bdaddr_t *addr, int chan,
 		rfsock->profile = get_profile_by_uuid(uuid);
 
 		if (bt_search_service(&adapter_addr, &rfsock->dst, &uu,
-					sdp_search_cb, rfsock, NULL) < 0) {
+					sdp_search_cb, rfsock, NULL, 0) < 0) {
 			error("Failed to search SDP records");
 			goto failed;
 		}
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 7de87a8..b9a09e9 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -864,7 +864,7 @@ gboolean hdp_get_mdep(struct hdp_device *device, struct hdp_application *app,
 
 	bt_string2uuid(&uuid, HDP_UUID);
 	if (bt_search_service(src, dst, &uuid, get_mdep_cb, mdep_data,
-							free_mdep_data) < 0) {
+						free_mdep_data, 0) < 0) {
 		g_set_error(err, HDP_ERROR, HDP_CONNECTION_ERROR,
 						"Can't get remote SDP record");
 		g_free(mdep_data);
@@ -1092,7 +1092,7 @@ gboolean hdp_establish_mcl(struct hdp_device *device,
 
 	bt_string2uuid(&uuid, HDP_UUID);
 	if (bt_search_service(src, dst, &uuid, search_cb, conn_data,
-						destroy_con_mcl_data) < 0) {
+					destroy_con_mcl_data, 0) < 0) {
 		g_set_error(err, HDP_ERROR, HDP_CONNECTION_ERROR,
 						"Can't get remote SDP record");
 		g_free(conn_data);
@@ -1161,7 +1161,7 @@ gboolean hdp_get_dcpsm(struct hdp_device *device, hdp_continue_dcpsm_f func,
 
 	bt_string2uuid(&uuid, HDP_UUID);
 	if (bt_search_service(src, dst, &uuid, get_dcpsm_cb, dcpsm_data,
-							free_dcpsm_data) < 0) {
+						free_dcpsm_data, 0) < 0) {
 		g_set_error(err, HDP_ERROR, HDP_CONNECTION_ERROR,
 						"Can't get remote SDP record");
 		g_free(dcpsm_data);
diff --git a/src/device.c b/src/device.c
index bcc5561..1bd27a1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2971,7 +2971,7 @@ static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 		sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
 		bt_search_service(btd_adapter_get_address(adapter),
 						&device->bdaddr, &uuid,
-						browse_cb, user_data, NULL);
+						browse_cb, user_data, NULL, 0);
 		return;
 	}
 
@@ -3513,7 +3513,8 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
 	sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
 
 	err = bt_search_service(btd_adapter_get_address(adapter),
-				&device->bdaddr, &uuid, browse_cb, req, NULL);
+				&device->bdaddr, &uuid, browse_cb, req, NULL,
+				0);
 	if (err < 0) {
 		browse_request_free(req);
 		return err;
diff --git a/src/profile.c b/src/profile.c
index 3c0d27c..e833181 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1605,7 +1605,7 @@ static int resolve_service(struct ext_io *conn, const bdaddr_t *src,
 	bt_string2uuid(&uuid, ext->remote_uuid);
 	sdp_uuid128_to_uuid(&uuid);
 
-	err = bt_search_service(src, dst, &uuid, record_cb, conn, NULL);
+	err = bt_search_service(src, dst, &uuid, record_cb, conn, NULL, 0);
 	if (err == 0)
 		conn->resolving = true;
 
diff --git a/src/sdp-client.c b/src/sdp-client.c
index 0599626..ff06b4d 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -264,7 +264,7 @@ failed:
 static int create_search_context(struct search_context **ctxt,
 					const bdaddr_t *src,
 					const bdaddr_t *dst,
-					uuid_t *uuid)
+					uuid_t *uuid, uint16_t flags)
 {
 	sdp_session_t *s;
 	GIOChannel *chan;
@@ -276,7 +276,7 @@ static int create_search_context(struct search_context **ctxt,
 
 	s = get_cached_sdp_session(src, dst);
 	if (!s)
-		s = sdp_connect(src, dst, SDP_NON_BLOCKING);
+		s = sdp_connect(src, dst, SDP_NON_BLOCKING | flags);
 
 	if (!s)
 		return -errno;
@@ -311,7 +311,7 @@ static int create_search_context(struct search_context **ctxt,
 
 int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
 			uuid_t *uuid, bt_callback_t cb, void *user_data,
-			bt_destroy_t destroy)
+			bt_destroy_t destroy, uint16_t flags)
 {
 	struct search_context *ctxt = NULL;
 	int err;
@@ -319,7 +319,7 @@ int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
 	if (!cb)
 		return -EINVAL;
 
-	err = create_search_context(&ctxt, src, dst, uuid);
+	err = create_search_context(&ctxt, src, dst, uuid, flags);
 	if (err < 0)
 		return err;
 
diff --git a/src/sdp-client.h b/src/sdp-client.h
index 9191594..9aa5a4d 100644
--- a/src/sdp-client.h
+++ b/src/sdp-client.h
@@ -26,6 +26,6 @@ typedef void (*bt_destroy_t) (gpointer user_data);
 
 int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
 			uuid_t *uuid, bt_callback_t cb, void *user_data,
-			bt_destroy_t destroy);
+			bt_destroy_t destroy, uint16_t flags);
 int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst);
 void bt_clear_cached_session(const bdaddr_t *src, const bdaddr_t *dst);
-- 
1.8.3.2

