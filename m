Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/bluetooth: Add support for getting remote device UUIDs property
Date: Fri, 13 Dec 2013 15:20:41 +0100
Message-Id: <1386944441-785-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to query for remote device UUIDs property.
---
 android/bluetooth.c | 91 ++++++++++++++++++++++++++---------------------------
 1 file changed, 45 insertions(+), 46 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index c60c9a2..97d4aae 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -75,6 +75,8 @@ struct device {
 
 	uint32_t class;
 	int32_t rssi;
+
+	GSList *uuids;
 };
 
 struct browse_req {
@@ -166,6 +168,7 @@ static void free_device(struct device *dev)
 {
 	g_free(dev->name);
 	g_free(dev->friendly_name);
+	g_slist_free_full(dev->uuids, g_free);
 	g_free(dev);
 }
 
@@ -383,40 +386,50 @@ static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
 	}
 }
 
-static void browse_req_free(struct browse_req *req)
+static  void send_device_property(const bdaddr_t *bdaddr, uint8_t type,
+						uint16_t len, const void *val)
 {
-	g_slist_free_full(req->uuids, g_free);
-	g_free(req);
+	uint8_t buf[BASELEN_REMOTE_DEV_PROP + len];
+	struct hal_ev_remote_device_props *ev = (void *) buf;
+
+	ev->status = HAL_STATUS_SUCCESS;
+	bdaddr2android(bdaddr, ev->bdaddr);
+	ev->num_props = 1;
+	ev->props[0].type = type;
+	ev->props[0].len = len;
+	memcpy(ev->props[0].val, val, len);
+
+	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_REMOTE_DEVICE_PROPS,
+							sizeof(buf), buf);
 }
 
-static void fill_uuids(GSList *list, void *buf)
+static void send_device_uuids_notif(struct device *dev)
 {
-	for (; list; list = g_slist_next(list)) {
-		memcpy(buf, list->data, sizeof(uint128_t));
-		buf += sizeof(uint128_t);
+	uint8_t buf[sizeof(uint128_t) * g_slist_length(dev->uuids)];
+	uint8_t *ptr = buf;
+	GSList *l;
+
+	for (l = dev->uuids; l; l = g_slist_next(l)) {
+		memcpy(ptr, l->data, sizeof(uint128_t));
+		ptr += sizeof(uint128_t);
 	}
+
+	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_UUIDS, sizeof(buf),
+									buf);
 }
 
-static void remote_uuids_callback(struct browse_req *req)
+static void set_device_uuids(struct device *dev, GSList *uuids)
 {
-	struct hal_ev_remote_device_props *ev;
-	int len;
-
-	len = sizeof(*ev) + sizeof(struct hal_property) + (sizeof(uint128_t) *
-						g_slist_length(req->uuids));
-	ev = g_malloc(len);
+	g_slist_free_full(dev->uuids, g_free);
+	dev->uuids = uuids;
 
-	ev->status = HAL_STATUS_SUCCESS;
-	bdaddr2android(&req->bdaddr, &ev->bdaddr);
-	ev->num_props = 1;
-	ev->props[0].type = HAL_PROP_DEVICE_UUIDS;
-	ev->props[0].len = sizeof(uint128_t) * g_slist_length(req->uuids);
-	fill_uuids(req->uuids, ev->props[0].val);
-
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_REMOTE_DEVICE_PROPS,
-								len, ev);
+	send_device_uuids_notif(dev);
+}
 
-	g_free(ev);
+static void browse_req_free(struct browse_req *req)
+{
+	g_slist_free_full(req->uuids, g_free);
+	g_free(req);
 }
 
 static int uuid_128_cmp(gconstpointer a, gconstpointer b)
@@ -476,6 +489,7 @@ static void update_records(struct browse_req *req, sdp_list_t *recs)
 static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 {
 	struct browse_req *req = user_data;
+	struct device *dev;
 	uuid_t uuid;
 
 	/* If we have a valid response and req->search_uuid == 2, then L2CAP
@@ -500,7 +514,11 @@ static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 	}
 
 done:
-	remote_uuids_callback(req);
+	dev = find_device(&req->bdaddr);
+	if (dev) {
+		set_device_uuids(dev, req->uuids);
+		req->uuids = NULL;
+	}
 
 	browse_reqs = g_slist_remove(browse_reqs, req);
 	browse_req_free(req);
@@ -573,23 +591,6 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 	browse_remote_sdp(&addr->bdaddr);
 }
 
-static  void send_device_property(const bdaddr_t *bdaddr, uint8_t type,
-						uint16_t len, const void *val)
-{
-	uint8_t buf[BASELEN_REMOTE_DEV_PROP + len];
-	struct hal_ev_remote_device_props *ev = (void *) buf;
-
-	ev->status = HAL_STATUS_SUCCESS;
-	bdaddr2android(bdaddr, ev->bdaddr);
-	ev->num_props = 1;
-	ev->props[0].type = type;
-	ev->props[0].len = len;
-	memcpy(ev->props[0].val, val, len);
-
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_REMOTE_DEVICE_PROPS,
-							sizeof(buf), buf);
-}
-
 static uint8_t get_device_name(struct device *dev)
 {
 	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_NAME,
@@ -2288,11 +2289,9 @@ static void handle_get_adapter_props_cmd(const void *buf, uint16_t len)
 
 static uint8_t get_device_uuids(struct device *dev)
 {
-	DBG("Not implemented");
+	send_device_uuids_notif(dev);
 
-	/* TODO */
-
-	return HAL_STATUS_FAILED;
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t get_device_class(struct device *dev)
-- 
1.8.3.2

