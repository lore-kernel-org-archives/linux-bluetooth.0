Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCHv2 5/5] android: Pass found uuids to remote_device_properties_cb
Date: Mon, 4 Nov 2013 08:30:34 +0100
Message-ID: <1383550234-14790-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1383550234-14790-1-git-send-email-marcin.kraglak@tieto.com>
References: <1383550234-14790-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/android/adapter.c b/android/adapter.c
index 689dd54..0b6fc43 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -1486,9 +1486,87 @@ static void browse_req_free(struct browse_req *req)
 	g_free(req);
 }
 
+static void fill_uuids(GSList *list, void *buf)
+{
+	for (; list; list = (GSList *)g_list_next(list)) {
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
@@ -1518,6 +1596,7 @@ static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 	}
 
 done:
+	remote_uuids_callback(req);
 	sdp_req_list = g_list_remove(sdp_req_list, req->bdaddr);
 	browse_req_free(req);
 }
-- 
1.8.4.1

