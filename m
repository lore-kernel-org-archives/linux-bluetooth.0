Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android/avrcp-lib: Use cpu_to_* and *_to_cpu
Date: Fri, 17 Oct 2014 11:08:29 +0200
Message-Id: <1413536909-13049-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

For PDU which have packed struct it is not necessary to use put_*
and get_* since it should be already aligned.
---
 android/avrcp-lib.c | 136 ++++++++++++++++++++++++++--------------------------
 1 file changed, 68 insertions(+), 68 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 2c3d2e9..cff37a8 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -929,7 +929,7 @@ static bool parse_attributes(uint32_t *params, uint16_t params_len,
 
 	for (i = 0; i < number && params_len >= sizeof(*attrs); i++,
 					params_len -= sizeof(*attrs)) {
-		attrs[i] = get_be32(&params[i]);
+		attrs[i] = be32_to_cpu(params[i]);
 
 		if (attrs[i] == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
 				attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST)
@@ -988,7 +988,7 @@ static ssize_t register_notification(struct avrcp *session, uint8_t transaction,
 
 	req = (void *) params;
 
-	interval = get_be32(&req->interval);
+	interval = be32_to_cpu(req->interval);
 
 	return player->ind->register_notification(session, transaction,
 							req->event, interval,
@@ -1037,7 +1037,7 @@ static ssize_t set_addressed(struct avrcp *session, uint8_t transaction,
 
 	req = (void *) params;
 
-	id = get_be16(&req->id);
+	id = be16_to_cpu(req->id);
 
 	return player->ind->set_addressed(session, transaction, id,
 							player->user_data);
@@ -1271,7 +1271,7 @@ static ssize_t set_browsed(struct avrcp *session, uint8_t transaction,
 
 	req = (void *) params;
 
-	id = get_be16(&req->id);
+	id = be16_to_cpu(req->id);
 
 	return player->ind->set_browsed(session, transaction, id,
 							player->user_data);
@@ -1301,16 +1301,16 @@ static ssize_t get_folder_items(struct avrcp *session, uint8_t transaction,
 	if (req->scope > AVRCP_MEDIA_NOW_PLAYING)
 		return -EBADRQC;
 
-	start = get_be32(&req->start);
-	end = get_be32(&req->end);
+	start = be32_to_cpu(req->start);
+	end = be32_to_cpu(req->end);
 
 	if (start > end)
 		return -ERANGE;
 
-	number = get_be16(&req->number);
+	number = be16_to_cpu(req->number);
 
 	for (i = 0; i < number; i++) {
-		attrs[i] = get_be32(&req->attrs[i]);
+		attrs[i] = be32_to_cpu(req->attrs[i]);
 
 		if (attrs[i] == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
 				attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST)
@@ -1341,8 +1341,8 @@ static ssize_t change_path(struct avrcp *session, uint8_t transaction,
 
 	req = (void *) params;
 
-	counter = get_be16(&req->counter);
-	uid = get_be64(&req->uid);
+	counter = be16_to_cpu(req->counter);
+	uid = be64_to_cpu(req->uid);
 
 	return player->ind->change_path(session, transaction, counter,
 					req->direction, uid, player->user_data);
@@ -1372,11 +1372,11 @@ static ssize_t get_item_attributes(struct avrcp *session, uint8_t transaction,
 	if (req->scope > AVRCP_MEDIA_NOW_PLAYING)
 		return -EBADRQC;
 
-	uid = get_be64(&req->uid);
-	counter = get_be16(&req->counter);
+	uid = be64_to_cpu(req->uid);
+	counter = be16_to_cpu(req->counter);
 
 	for (i = 0; i < req->number; i++) {
-		attrs[i] = get_be32(&req->attrs[i]);
+		attrs[i] = be32_to_cpu(req->attrs[i]);
 
 		if (attrs[i] == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
 				attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST)
@@ -1411,8 +1411,8 @@ static ssize_t play_item(struct avrcp *session, uint8_t transaction,
 	if (req->scope > AVRCP_MEDIA_NOW_PLAYING)
 		return -EBADRQC;
 
-	uid = get_be64(&params[1]);
-	counter = get_be16(&params[9]);
+	uid = be64_to_cpu(req->uid);
+	counter = be16_to_cpu(req->counter);
 
 	return player->ind->play_item(session, transaction, req->scope, uid,
 						counter, player->user_data);
@@ -1438,7 +1438,7 @@ static ssize_t search(struct avrcp *session, uint8_t transaction,
 
 	req = (void *) params;
 
-	len = get_be16(&req->len);
+	len = be16_to_cpu(req->len);
 	if (!len)
 		return -EINVAL;
 
@@ -1474,8 +1474,8 @@ static ssize_t add_to_now_playing(struct avrcp *session, uint8_t transaction,
 	if (req->scope > AVRCP_MEDIA_NOW_PLAYING)
 		return -EBADRQC;
 
-	uid = get_be64(&req->uid);
-	counter = get_be16(&req->counter);
+	uid = be64_to_cpu(req->uid);
+	counter = be16_to_cpu(req->counter);
 
 	return player->ind->add_to_now_playing(session, transaction, req->scope,
 							uid, counter,
@@ -1859,7 +1859,7 @@ int avrcp_register_notification(struct avrcp *session, uint8_t event,
 		return -EINVAL;
 
 	req.event = event;
-	put_be32(interval, &req.interval);
+	req.interval = cpu_to_be32(interval);
 
 	iov.iov_base = &req;
 	iov.iov_len = sizeof(req);
@@ -2345,8 +2345,8 @@ static gboolean get_play_status_rsp(struct avctp *conn,
 
 	rsp = (void *) pdu->params;
 
-	duration = get_be32(&rsp->duration);
-	position = get_be32(&rsp->position);
+	duration = be32_to_cpu(rsp->duration);
+	position = be32_to_cpu(rsp->position);
 	status = rsp->status;
 	err = 0;
 
@@ -2432,9 +2432,9 @@ static int parse_attribute_list(uint8_t *params, uint16_t params_len,
 	for (i = 0; i < number && params_len >= sizeof(*item); i++) {
 		item = (void *) params;
 
-		item->attr = get_be32(&item->attr);
-		item->charset = get_be16(&item->charset);
-		item->len = get_be16(&item->len);
+		item->attr = be32_to_cpu(item->attr);
+		item->charset = be16_to_cpu(item->charset);
+		item->len = be16_to_cpu(item->len);
 
 		params_len -= sizeof(*item);
 		params += sizeof(*item);
@@ -2584,7 +2584,7 @@ int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id)
 	struct iovec iov;
 	struct set_addressed_req req;
 
-	put_be16(player_id, &req.id);
+	req.id = cpu_to_be16(player_id);
 
 	iov.iov_base = &req;
 	iov.iov_len = sizeof(req);
@@ -2658,8 +2658,8 @@ static gboolean set_browsed_rsp(struct avctp *conn, uint8_t *operands,
 
 	rsp = (void *) pdu->params;
 
-	counter = get_be16(&rsp->counter);
-	items = get_be32(&rsp->items);
+	counter = be16_to_cpu(rsp->counter);
+	items = be32_to_cpu(rsp->items);
 
 	path = parse_folder_list(rsp->data, pdu->params_len - sizeof(*rsp),
 								rsp->depth);
@@ -2676,12 +2676,12 @@ done:
 int avrcp_set_browsed_player(struct avrcp *session, uint16_t player_id)
 {
 	struct iovec iov;
-	uint8_t pdu[2];
+	struct set_browsed_req req;
 
-	put_be16(player_id, pdu);
+	req.id = cpu_to_be16(player_id);
 
-	iov.iov_base = pdu;
-	iov.iov_len = sizeof(pdu);
+	iov.iov_base = &req;
+	iov.iov_len = sizeof(req);
 
 	return avrcp_send_browsing_req(session, AVRCP_SET_BROWSED_PLAYER,
 					&iov, 1, set_browsed_rsp, session);
@@ -2721,8 +2721,8 @@ static gboolean get_folder_items_rsp(struct avctp *conn,
 
 	rsp = (void *) pdu->params;
 
-	counter = get_be16(&rsp->counter);
-	number = get_be16(&rsp->number);
+	counter = be16_to_cpu(rsp->counter);
+	number = be16_to_cpu(rsp->number);
 	params = rsp->data;
 
 	/* FIXME: Add proper parsing for each item type */
@@ -2744,8 +2744,8 @@ int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
 	int i;
 
 	req.scope = scope;
-	put_be32(start, &req.start);
-	put_be32(end, &req.end);
+	req.start = cpu_to_be32(start);
+	req.end = cpu_to_be32(end);
 	req.number = number;
 
 	iov[0].iov_base = &req;
@@ -2757,7 +2757,7 @@ int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
 						session);
 
 	for (i = 0; i < number; i++)
-		put_be32(attrs[i], &attrs[i]);
+		attrs[i] = cpu_to_be32(attrs[i]);
 
 	iov[1].iov_base = attrs;
 	iov[1].iov_len = number * sizeof(*attrs);
@@ -2798,7 +2798,7 @@ static gboolean change_path_rsp(struct avctp *conn, uint8_t *operands,
 
 	rsp = (void *) pdu->params;
 
-	items = get_be32(&rsp->items);
+	items = be32_to_cpu(rsp->items);
 
 done:
 	player->cfm->change_path(session, err, items, player->user_data);
@@ -2812,9 +2812,9 @@ int avrcp_change_path(struct avrcp *session, uint8_t direction, uint64_t uid,
 	struct iovec iov;
 	struct change_path_req req;
 
-	put_be16(counter, &req.counter);
+	req.counter = cpu_to_be16(counter);
 	req.direction = direction;
-	put_be64(uid, &req.uid);
+	req.uid = cpu_to_be64(uid);
 
 	iov.iov_base = &req;
 	iov.iov_len = sizeof(req);
@@ -2867,8 +2867,8 @@ int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
 	int i;
 
 	req.scope = scope;
-	put_be64(uid, &req.uid);
-	put_be16(counter, &req.counter);
+	req.uid = cpu_to_be64(uid);
+	req.counter = cpu_to_be16(counter);
 	req.number = number;
 
 	iov[0].iov_base = &req;
@@ -2887,7 +2887,7 @@ int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
 		if (attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST ||
 				attrs[i] == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL)
 			return -EINVAL;
-		put_be32(attrs[i], &attrs[i]);
+		attrs[i] = cpu_to_be32(attrs[i]);
 	}
 
 	iov[1].iov_base = attrs;
@@ -2935,8 +2935,8 @@ int avrcp_play_item(struct avrcp *session, uint8_t scope, uint64_t uid,
 		return -EINVAL;
 
 	req.scope = scope;
-	put_be64(uid, &req.uid);
-	put_be16(counter, &req.counter);
+	req.uid = cpu_to_be64(uid);
+	req.counter = cpu_to_be16(counter);
 
 	iov.iov_base = &req;
 	iov.iov_len = sizeof(req);
@@ -2978,8 +2978,8 @@ static gboolean search_rsp(struct avctp *conn, uint8_t *operands,
 
 	rsp = (void *) pdu->params;
 
-	counter = get_be16(&rsp->counter);
-	items = get_be32(&rsp->items);
+	counter = be16_to_cpu(rsp->counter);
+	items = be32_to_cpu(rsp->items);
 
 	err = 0;
 
@@ -3000,8 +3000,8 @@ int avrcp_search(struct avrcp *session, const char *string)
 
 	len = strnlen(string, UINT8_MAX);
 
-	put_be16(AVRCP_CHARSET_UTF8, &req.charset);
-	put_be16(len, &req.len);
+	req.charset = cpu_to_be16(AVRCP_CHARSET_UTF8);
+	req.len = cpu_to_be16(len);
 
 	iov[0].iov_base = &req;
 	iov[0].iov_len = sizeof(req);
@@ -3050,8 +3050,8 @@ int avrcp_add_to_now_playing(struct avrcp *session, uint8_t scope, uint64_t uid,
 		return -EINVAL;
 
 	req.scope = scope;
-	put_be64(uid, &req.uid);
-	put_be16(counter, &req.counter);
+	req.uid = cpu_to_be64(uid);
+	req.counter = cpu_to_be16(counter);
 
 	iov.iov_base = &req;
 	iov.iov_len = sizeof(req);
@@ -3136,7 +3136,7 @@ int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
 			len = strlen(text[i]);
 
 		val[i].attr = attrs[i];
-		put_be16(AVRCP_CHARSET_UTF8, &val[i].charset);
+		val[i].charset = cpu_to_be16(AVRCP_CHARSET_UTF8);
 		val[i].len = len;
 
 		iov[i + 1].iov_base = &val[i];
@@ -3177,8 +3177,8 @@ int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 	struct iovec iov;
 	struct get_play_status_rsp rsp;
 
-	put_be32(duration, &rsp.duration);
-	put_be32(position, &rsp.position);
+	rsp.duration = cpu_to_be32(duration);
+	rsp.position = cpu_to_be32(position);
 	rsp.status = status;
 
 	iov.iov_base = &rsp;
@@ -3210,7 +3210,7 @@ int avrcp_get_player_values_text_rsp(struct avrcp *session,
 			len = strlen(text[i]);
 
 		val[i].attr = values[i];
-		put_be16(AVRCP_CHARSET_UTF8, &val[i].charset);
+		val[i].charset = cpu_to_be16(AVRCP_CHARSET_UTF8);
 		val[i].len = len;
 
 		iov[i + 1].iov_base = &val[i];
@@ -3314,8 +3314,8 @@ int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 			return -EINVAL;
 
 		player = data;
-		put_be16(player[0], &player[0]);
-		put_be16(player[1], &player[1]);
+		player[0] = cpu_to_be16(player[0]);
+		player[1] = cpu_to_be16(player[1]);
 
 		break;
 	case AVRCP_EVENT_SETTINGS_CHANGED:
@@ -3398,9 +3398,9 @@ int avrcp_set_browsed_player_rsp(struct avrcp *session, uint8_t transaction,
 					AVRCP_SET_BROWSED_PLAYER, status);
 
 	rsp.status = status;
-	put_be16(counter, &rsp.counter);
-	put_be32(items, &rsp.items);
-	put_be16(AVRCP_CHARSET_UTF8, &rsp.charset);
+	rsp.counter = cpu_to_be16(counter);
+	rsp.items = cpu_to_be32(items);
+	rsp.charset = cpu_to_be16(AVRCP_CHARSET_UTF8);
 	rsp.depth = depth;
 
 	iov[0].iov_base = &rsp;
@@ -3420,7 +3420,7 @@ int avrcp_set_browsed_player_rsp(struct avrcp *session, uint8_t transaction,
 		iov[i * 2 + 2].iov_base = (void *) folders[i];
 		iov[i * 2 + 2].iov_len = len[i];
 
-		put_be16(len[i], &len[i]);
+		len[i] = cpu_to_be16(len[i]);
 
 		iov[i * 2 + 1].iov_base = &len[i];
 		iov[i * 2 + 1].iov_len = sizeof(len[i]);
@@ -3446,8 +3446,8 @@ int avrcp_get_folder_items_rsp(struct avrcp *session, uint8_t transaction,
 					AVRCP_GET_FOLDER_ITEMS, status);
 
 	rsp.status = status;
-	put_be16(counter, &rsp.counter);
-	put_be16(number, &rsp.number);
+	rsp.counter = cpu_to_be16(counter);
+	rsp.number = cpu_to_be16(number);
 
 	iov[0].iov_base = &rsp;
 	iov[0].iov_len = sizeof(rsp);
@@ -3478,7 +3478,7 @@ int avrcp_change_path_rsp(struct avrcp *session, uint8_t transaction,
 									status);
 
 	rsp.status = status;
-	put_be32(items, &rsp.items);
+	rsp.items = cpu_to_be32(items);
 
 	iov.iov_base = &rsp;
 	iov.iov_len = sizeof(rsp);
@@ -3503,9 +3503,9 @@ static bool pack_attribute_list(struct iovec *iov, uint8_t number,
 		if (text[i])
 			len = strlen(text[i]);
 
-		put_be32(attrs[i], &val[i].attr);
-		put_be16(AVRCP_CHARSET_UTF8, &val[i].charset);
-		put_be16(len, &val[i].len);
+		val[i].attr = cpu_to_be32(attrs[i]);
+		val[i].charset = cpu_to_be16(AVRCP_CHARSET_UTF8);
+		val[i].len = cpu_to_be16(len);
 
 		iov[i].iov_base = &val[i];
 		iov[i].iov_len = sizeof(val[i]);
@@ -3563,8 +3563,8 @@ int avrcp_search_rsp(struct avrcp *session, uint8_t transaction, uint8_t status,
 								status);
 
 	rsp.status = status;
-	put_be16(counter, &rsp.counter);
-	put_be32(items, &rsp.items);
+	rsp.counter = cpu_to_be16(counter);
+	rsp.items = cpu_to_be32(items);
 
 	iov.iov_base = &rsp;
 	iov.iov_len = sizeof(rsp);
-- 
1.9.3

