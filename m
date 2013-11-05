Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCHv2 3/6] android: Pass found uuids to remote_device_properties_cb
Date: Tue, 5 Nov 2013 14:21:37 +0100
Message-ID: <1383657700-22313-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1383657700-22313-1-git-send-email-marcin.kraglak@tieto.com>
References: <1383657700-22313-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send remote device's uuids in remote_device_properties_cb.
This patch will pack found uuids to buffer containing property
with list of uuids and send it to notification socket.
---
 android/adapter.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/android/adapter.c b/android/adapter.c
index cf22e5f..0f24cac 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -288,9 +288,87 @@ static void browse_req_free(struct browse_req *req)
 	g_free(req);
 }
 
+static void fill_uuids(GSList *list, void *buf)
+{
+	for (; list; list = g_slist_next(list)) {
+		memcpy(buf, list->data, sizeof(uint128_t));
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
+	bdaddr2android(&req->bdaddr, &ev->bdaddr);
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
+		uuid_t *tmp;
+		uint8_t *new_uuid;
+
+		if (!rec)
+			break;
+
+		if (sdp_get_service_classes(rec, &svcclass) < 0)
+			continue;
+
+		if (!svcclass)
+			continue;
+
+		tmp = svcclass->data;
+
+		switch (tmp->type) {
+		case SDP_UUID16:
+			sdp_uuid16_to_uuid128(&uuid128, tmp);
+			break;
+		case SDP_UUID32:
+			sdp_uuid32_to_uuid128(&uuid128, tmp);
+			break;
+		case SDP_UUID128:
+			memcpy(&uuid128, tmp, sizeof(uuid_t));
+			break;
+		default:
+			continue;
+		}
+
+		new_uuid = g_malloc(16);/* size of 128 bit uuid */
+		memcpy(new_uuid, &uuid128.value.uuid128,
+				sizeof(uuid128.value.uuid128));
+
+		/* Check if uuid is already added */
+		if (g_slist_find_custom(req->uuids, new_uuid, uuid_128_cmp))
+			g_free(new_uuid);
+		else
+			req->uuids = g_slist_append(req->uuids, new_uuid);
+
+		sdp_list_free(svcclass, free);
+	}
 }
 
 static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
@@ -320,6 +398,8 @@ static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 	}
 
 done:
+	remote_uuids_callback(req);
+
 	browse_reqs = g_slist_remove(browse_reqs, req);
 	browse_req_free(req);
 }
-- 
1.8.4.1

