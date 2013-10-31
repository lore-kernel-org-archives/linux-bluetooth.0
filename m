Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 5/5] android: Pass found uuids to remote_device_properties_cb
Date: Thu, 31 Oct 2013 16:25:52 +0100
Message-ID: <1383233152-15040-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383233152-15040-1-git-send-email-szymon.janc@tieto.com>
References: <1383233152-15040-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

Change-Id: I21221033cf3510113b4014bdacb64e25b7d16ba9
---
 android/adapter.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/android/adapter.c b/android/adapter.c
index 48e5e95..3d3cd72 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -1242,9 +1242,89 @@ static void browse_req_free(struct browse_req *req)
 	g_free(req);
 }
 
+static void fill_uuids(GSList *list, void *buf)
+{
+	int i, len = g_slist_length(list);
+
+	for (i = 0; i < len; i++) {
+		memcpy(buf, g_slist_nth_data(list, i), sizeof(uint128_t));
+		buf += sizeof(uint128_t);
+	}
+}
+
+static void remote_uuids_callback(struct browse_req *req)
+{
+	struct hal_ev_remote_device_props *ev;
+	int len;
+
+	len = sizeof(*ev) + sizeof(struct hal_property) + (sizeof(uint128_t) *
+						g_slist_length(req->uuids));
+	ev = g_malloc(len);
+
+	ev->status = HAL_STATUS_SUCCESS;
+	bdaddr2android(req->bdaddr, &ev->bdaddr);
+	ev->num_props = 1;
+	ev->props[0].type = HAL_PROP_DEVICE_UUIDS;
+	ev->props[0].len = sizeof(uint128_t) * g_slist_length(req->uuids);
+	fill_uuids(req->uuids, ev->props[0].val);
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_REMOTE_DEVICE_PROPS, len, ev, -1);
+
+	g_free(ev);
+}
+
+static int uuid_128_cmp(gconstpointer a, gconstpointer b)
+{
+	return memcmp(a, b, sizeof(uint128_t));
+}
+
 static void update_records(struct browse_req *req, sdp_list_t *recs)
 {
-	/* TODO cache found uuids */
+	for (; recs; recs = recs->next) {
+		sdp_record_t *rec = (sdp_record_t *) recs->data;
+		sdp_list_t *svcclass = NULL;
+		uuid_t uuid128;
+		uuid_t *temp;
+		uint8_t *u;
+
+		if (!rec)
+			break;
+
+		if (sdp_get_service_classes(rec, &svcclass) < 0)
+			continue;
+
+		if (svcclass == NULL)
+			continue;
+
+		temp = svcclass->data;
+
+		switch (temp->type) {
+		case SDP_UUID16:
+			sdp_uuid16_to_uuid128(&uuid128, temp);
+			break;
+		case SDP_UUID32:
+			sdp_uuid32_to_uuid128(&uuid128, temp);
+			break;
+		case SDP_UUID128:
+			memcpy(&uuid128, temp, sizeof(uuid_t));
+			break;
+		default:
+			continue;
+		}
+
+		u = g_malloc(16);/* size of 128 bit uuid */
+		memcpy(u, &uuid128.value.uuid128,
+				sizeof(uuid128.value.uuid128));
+
+		/* Check if uuid is already added */
+		if (g_slist_find_custom(req->uuids, u, uuid_128_cmp))
+			g_free(u);
+		else
+			req->uuids = g_slist_append(req->uuids, u);
+
+		sdp_list_free(svcclass, free);
+	}
 }
 
 static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
@@ -1274,6 +1354,7 @@ static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 	}
 
 done:
+	remote_uuids_callback(req);
 	sdp_req_list = g_list_remove(sdp_req_list, req->bdaddr);
 	browse_req_free(req);
 }
-- 
1.8.4.1

