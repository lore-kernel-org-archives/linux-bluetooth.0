Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 14/62] Replace bt_get_be16() by get_be16()
Date: Thu, 20 Mar 2014 11:42:39 -0300
Message-Id: <1395326607-27068-15-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avrcp-lib.c     |  3 ++-
 lib/sdp.c               | 25 +++++++++++++------------
 monitor/sdp.c           | 44 +++++++++++++++++++++++---------------------
 profiles/audio/avrcp.c  | 30 +++++++++++++++---------------
 profiles/network/bnep.c |  5 +++--
 profiles/sap/server.c   |  3 ++-
 src/sdpd-request.c      | 12 +++++++-----
 src/sdpd-service.c      |  5 +++--
 8 files changed, 68 insertions(+), 59 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 3f44315..06aa552 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -31,6 +31,7 @@
 
 #include "lib/bluetooth.h"
 
+#include "src/shared/util.h"
 #include "src/log.h"
 
 #include "avctp.h"
@@ -561,7 +562,7 @@ static ssize_t set_addressed(struct avrcp *session, uint8_t transaction,
 	if (!player->ind || !player->ind->set_addressed)
 		return -ENOSYS;
 
-	id = bt_get_be16(params);
+	id = get_be16(params);
 
 	return player->ind->set_addressed(session, transaction, id,
 							player->user_data);
diff --git a/lib/sdp.c b/lib/sdp.c
index e5e4622..fec658a 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -48,6 +48,7 @@
 #include "l2cap.h"
 #include "sdp.h"
 #include "sdp_lib.h"
+#include "src/shared/util.h"
 
 #define SDPINF(fmt, arg...) syslog(LOG_INFO, fmt "\n", ## arg)
 #define SDPERR(fmt, arg...) syslog(LOG_ERR, "%s: " fmt "\n", __func__ , ## arg)
@@ -1010,7 +1011,7 @@ int sdp_uuid_extract(const uint8_t *p, int bufsize, uuid_t *uuid, int *scanned)
 			SDPERR("Not enough room for 16-bit UUID");
 			return -1;
 		}
-		sdp_uuid16_create(uuid, bt_get_be16(p));
+		sdp_uuid16_create(uuid, get_be16(p));
 		*scanned += sizeof(uint16_t);
 	} else if (type == SDP_UUID32) {
 		if (bufsize < (int) sizeof(uint32_t)) {
@@ -1072,7 +1073,7 @@ static sdp_data_t *extract_int(const void *p, int bufsize, int *len)
 			return NULL;
 		}
 		*len += sizeof(uint16_t);
-		d->val.uint16 = bt_get_be16(p);
+		d->val.uint16 = get_be16(p);
 		break;
 	case SDP_INT32:
 	case SDP_UINT32:
@@ -1175,7 +1176,7 @@ static sdp_data_t *extract_str(const void *p, int bufsize, int *len)
 			free(d);
 			return NULL;
 		}
-		n = bt_get_be16(p);
+		n = get_be16(p);
 		p += sizeof(uint16_t);
 		*len += sizeof(uint16_t);
 		bufsize -= sizeof(uint16_t);
@@ -1245,7 +1246,7 @@ int sdp_extract_seqtype(const uint8_t *buf, int bufsize, uint8_t *dtdp, int *siz
 			SDPERR("Unexpected end of packet");
 			return 0;
 		}
-		*size = bt_get_be16(buf);
+		*size = get_be16(buf);
 		scanned += sizeof(uint16_t);
 		break;
 	case SDP_SEQ32:
@@ -1421,7 +1422,7 @@ sdp_record_t *sdp_extract_pdu(const uint8_t *buf, int bufsize, int *scanned)
 		}
 
 		dtd = *(uint8_t *) p;
-		attr = bt_get_be16(p + n);
+		attr = get_be16(p + n);
 		n += sizeof(uint16_t);
 
 		SDPDBG("DTD of attrId : %d Attr id : 0x%x ", dtd, attr);
@@ -3482,7 +3483,7 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 		pdata += sizeof(uint16_t);
 		scanned += sizeof(uint16_t);
 		pdata_len -= sizeof(uint16_t);
-		rec_count = bt_get_be16(pdata);
+		rec_count = get_be16(pdata);
 		pdata += sizeof(uint16_t);
 		scanned += sizeof(uint16_t);
 		pdata_len -= sizeof(uint16_t);
@@ -3648,7 +3649,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 			goto end;
 		}
 
-		rsp_count = bt_get_be16(pdata);
+		rsp_count = get_be16(pdata);
 		attr_list_len += rsp_count;
 		pdata += sizeof(uint16_t);
 		pdata_len -= sizeof(uint16_t);
@@ -4198,9 +4199,9 @@ int sdp_process(sdp_session_t *session)
 		 * CSRC: Current Service Record Count (2 bytes)
 		 */
 		ssr_pdata = pdata;
-		tsrc = bt_get_be16(ssr_pdata);
+		tsrc = get_be16(ssr_pdata);
 		ssr_pdata += sizeof(uint16_t);
-		csrc = bt_get_be16(ssr_pdata);
+		csrc = get_be16(ssr_pdata);
 
 		/* csrc should never be larger than tsrc */
 		if (csrc > tsrc) {
@@ -4245,7 +4246,7 @@ int sdp_process(sdp_session_t *session)
 		break;
 	case SDP_SVC_ATTR_RSP:
 	case SDP_SVC_SEARCH_ATTR_RSP:
-		rsp_count = bt_get_be16(pdata);
+		rsp_count = get_be16(pdata);
 		SDPDBG("Attrlist byte count : %d", rsp_count);
 
 		/* Valid range for rsp_count is 0x0002-0xFFFF */
@@ -4266,7 +4267,7 @@ int sdp_process(sdp_session_t *session)
 		status = 0x0000;
 		break;
 	case SDP_ERROR_RSP:
-		status = bt_get_be16(pdata);
+		status = get_be16(pdata);
 		size = ntohs(rsphdr->plen);
 
 		goto end;
@@ -4502,7 +4503,7 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 			goto end;
 		}
 
-		rsp_count = bt_get_be16(pdata);
+		rsp_count = get_be16(pdata);
 		attr_list_len += rsp_count;
 		pdata += sizeof(uint16_t); /* pdata points to attribute list */
 		pdata_len -= sizeof(uint16_t);
diff --git a/monitor/sdp.c b/monitor/sdp.c
index dd72393..a5e8ff4 100644
--- a/monitor/sdp.c
+++ b/monitor/sdp.c
@@ -33,6 +33,8 @@
 
 #include <bluetooth/bluetooth.h>
 
+#include "src/shared/util.h"
+
 #include "bt.h"
 #include "packet.h"
 #include "display.h"
@@ -89,7 +91,7 @@ static void print_uint(uint8_t indent, const uint8_t *data, uint32_t size)
 		print_field("%*c0x%2.2x", indent, ' ', data[0]);
 		break;
 	case 2:
-		print_field("%*c0x%4.4x", indent, ' ', bt_get_be16(data));
+		print_field("%*c0x%4.4x", indent, ' ', get_be16(data));
 		break;
 	case 4:
 		print_field("%*c0x%8.8x", indent, ' ', bt_get_be32(data));
@@ -114,7 +116,7 @@ static void print_uuid(uint8_t indent, const uint8_t *data, uint32_t size)
 	switch (size) {
 	case 2:
 		print_field("%*c%s (0x%4.4x)", indent, ' ',
-			uuid16_to_str(bt_get_be16(data)), bt_get_be16(data));
+			uuid16_to_str(get_be16(data)), get_be16(data));
 		break;
 	case 4:
 		print_field("%*c%s (0x%8.8x)", indent, ' ',
@@ -124,13 +126,13 @@ static void print_uuid(uint8_t indent, const uint8_t *data, uint32_t size)
 		/* BASE_UUID = 00000000-0000-1000-8000-00805F9B34FB */
 		print_field("%*c%8.8x-%4.4x-%4.4x-%4.4x-%4.4x%8.4x",
 				indent, ' ',
-				bt_get_be32(data), bt_get_be16(data + 4),
-				bt_get_be16(data + 6), bt_get_be16(data + 8),
-				bt_get_be16(data + 10), bt_get_be32(data + 12));
-		if (bt_get_be16(data + 4) == 0x0000 &&
-				bt_get_be16(data + 6) == 0x1000 &&
-				bt_get_be16(data + 8) == 0x8000 &&
-				bt_get_be16(data + 10) == 0x0080 &&
+				bt_get_be32(data), get_be16(data + 4),
+				get_be16(data + 6), get_be16(data + 8),
+				get_be16(data + 10), bt_get_be32(data + 12));
+		if (get_be16(data + 4) == 0x0000 &&
+				get_be16(data + 6) == 0x1000 &&
+				get_be16(data + 8) == 0x8000 &&
+				get_be16(data + 10) == 0x0080 &&
 				bt_get_be32(data + 12) == 0x5F9B34FB)
 			print_field("%*c%s", indent, ' ',
 				uuid32_to_str(bt_get_be32(data)));
@@ -233,7 +235,7 @@ static uint32_t get_size(const uint8_t *data, uint32_t size)
 			case 8:
 				return data[1];
 			case 16:
-				return bt_get_be16(data + 1);
+				return get_be16(data + 1);
 			case 32:
 				return bt_get_be32(data + 1);
 			default:
@@ -319,7 +321,7 @@ static uint32_t get_bytes(const uint8_t *data, uint32_t size)
 	case 5:
 		return 2 + data[1];
 	case 6:
-		return 3 + bt_get_be16(data + 1);
+		return 3 + get_be16(data + 1);
 	case 7:
 		return 5 + bt_get_be32(data + 1);
 	}
@@ -354,7 +356,7 @@ static void print_attr(uint32_t position, uint8_t indent, uint8_t type,
 	int i;
 
 	if ((position % 2) == 0) {
-		uint16_t id = bt_get_be16(data);
+		uint16_t id = get_be16(data);
 		const char *str = "Unknown";
 
 		for (i = 0; attribute_table[i].str; i++) {
@@ -509,7 +511,7 @@ static uint16_t common_rsp(const struct l2cap_frame *frame,
 		return 0;
 	}
 
-	bytes = bt_get_be16(frame->data);
+	bytes = get_be16(frame->data);
 	print_field("Attribute bytes: %d", bytes);
 
 	if (bytes > frame->size - 2) {
@@ -533,7 +535,7 @@ static void error_rsp(const struct l2cap_frame *frame, struct tid_data *tid)
 		return;
 	}
 
-	error = bt_get_be16(frame->data);
+	error = get_be16(frame->data);
 
 	print_field("Error code: 0x%2.2x", error);
 }
@@ -554,7 +556,7 @@ static void service_req(const struct l2cap_frame *frame, struct tid_data *tid)
 	decode_data_elements(0, 2, frame->data, search_bytes, NULL);
 
 	print_field("Max record count: %d",
-				bt_get_be16(frame->data + search_bytes));
+				get_be16(frame->data + search_bytes));
 
 	print_continuation(frame->data + search_bytes + 2,
 					frame->size - search_bytes - 2);
@@ -573,9 +575,9 @@ static void service_rsp(const struct l2cap_frame *frame, struct tid_data *tid)
 		return;
 	}
 
-	count = bt_get_be16(frame->data + 2);
+	count = get_be16(frame->data + 2);
 
-	print_field("Total record count: %d", bt_get_be16(frame->data));
+	print_field("Total record count: %d", get_be16(frame->data));
 	print_field("Current record count: %d", count);
 
 	for (i = 0; i < count; i++)
@@ -597,7 +599,7 @@ static void attr_req(const struct l2cap_frame *frame, struct tid_data *tid)
 	}
 
 	print_field("Record handle: 0x%4.4x", bt_get_be32(frame->data));
-	print_field("Max attribute bytes: %d", bt_get_be16(frame->data + 4));
+	print_field("Max attribute bytes: %d", get_be16(frame->data + 4));
 
 	attr_bytes = get_bytes(frame->data + 6, frame->size - 6);
 	print_field("Attribute list: [len %d]", attr_bytes);
@@ -643,7 +645,7 @@ static void search_attr_req(const struct l2cap_frame *frame,
 	decode_data_elements(0, 2, frame->data, search_bytes, NULL);
 
 	print_field("Max record count: %d",
-				bt_get_be16(frame->data + search_bytes));
+				get_be16(frame->data + search_bytes));
 
 	attr_bytes = get_bytes(frame->data + search_bytes + 2,
 				frame->size - search_bytes - 2);
@@ -703,8 +705,8 @@ void sdp_packet(const struct l2cap_frame *frame, uint16_t channel)
 	}
 
 	pdu = *((uint8_t *) frame->data);
-	tid = bt_get_be16(frame->data + 1);
-	plen = bt_get_be16(frame->data + 3);
+	tid = get_be16(frame->data + 1);
+	plen = get_be16(frame->data + 3);
 
 	if (frame->size != plen + 5) {
 		print_text(COLOR_ERROR, "invalid frame size");
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index c7f2f0b..8487682 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1993,10 +1993,10 @@ static void avrcp_parse_attribute_list(struct avrcp_player *player,
 		id = bt_get_be32(&operands[i]);
 		i += sizeof(uint32_t);
 
-		charset = bt_get_be16(&operands[i]);
+		charset = get_be16(&operands[i]);
 		i += sizeof(uint16_t);
 
-		len = bt_get_be16(&operands[i]);
+		len = get_be16(&operands[i]);
 		i += sizeof(uint16_t);
 
 		if (charset == 106) {
@@ -2128,7 +2128,7 @@ static struct media_item *parse_media_element(struct avrcp *session,
 
 	uid = bt_get_be64(&operands[0]);
 
-	namelen = MIN(bt_get_be16(&operands[11]), sizeof(name) - 1);
+	namelen = MIN(get_be16(&operands[11]), sizeof(name) - 1);
 	if (namelen > 0) {
 		memcpy(name, &operands[13], namelen);
 		name[namelen] = '\0';
@@ -2165,7 +2165,7 @@ static struct media_item *parse_media_folder(struct avrcp *session,
 	type = operands[8];
 	playable = operands[9];
 
-	namelen = MIN(bt_get_be16(&operands[12]), sizeof(name) - 1);
+	namelen = MIN(get_be16(&operands[12]), sizeof(name) - 1);
 	if (namelen > 0) {
 		memcpy(name, &operands[14], namelen);
 		name[namelen] = '\0';
@@ -2212,7 +2212,7 @@ static gboolean avrcp_list_items_rsp(struct avctp *conn, uint8_t *operands,
 		goto done;
 	}
 
-	count = bt_get_be16(&operands[6]);
+	count = get_be16(&operands[6]);
 	if (count == 0)
 		goto done;
 
@@ -2222,7 +2222,7 @@ static gboolean avrcp_list_items_rsp(struct avctp *conn, uint8_t *operands,
 		uint16_t len;
 
 		type = operands[i++];
-		len = bt_get_be16(&operands[i]);
+		len = get_be16(&operands[i]);
 		i += 2;
 
 		if (type != 0x03 && type != 0x02) {
@@ -2354,7 +2354,7 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 							operand_count < 13)
 		return FALSE;
 
-	player->uid_counter = bt_get_be16(&pdu->params[1]);
+	player->uid_counter = get_be16(&pdu->params[1]);
 	player->browsed = true;
 
 	items = bt_get_be32(&pdu->params[3]);
@@ -2680,7 +2680,7 @@ static gboolean avrcp_search_rsp(struct avctp *conn, uint8_t *operands,
 		goto done;
 	}
 
-	player->uid_counter = bt_get_be16(&pdu->params[1]);
+	player->uid_counter = get_be16(&pdu->params[1]);
 	ret = bt_get_be32(&pdu->params[3]);
 
 done:
@@ -2894,7 +2894,7 @@ avrcp_parse_media_player_item(struct avrcp *session, uint8_t *operands,
 	if (len < 28)
 		return NULL;
 
-	id = bt_get_be16(&operands[0]);
+	id = get_be16(&operands[0]);
 
 	player = find_ct_player(session, id);
 	if (player == NULL) {
@@ -2922,7 +2922,7 @@ avrcp_parse_media_player_item(struct avrcp *session, uint8_t *operands,
 
 	avrcp_player_parse_features(player, &operands[8]);
 
-	namelen = bt_get_be16(&operands[26]);
+	namelen = get_be16(&operands[26]);
 	if (namelen > 0 && namelen + 28 == len) {
 		namelen = MIN(namelen, sizeof(name) - 1);
 		memcpy(name, &operands[28], namelen);
@@ -2982,7 +2982,7 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
 		return FALSE;
 
 	removed = g_slist_copy(session->controller->players);
-	count = bt_get_be16(&operands[6]);
+	count = get_be16(&operands[6]);
 
 	for (i = 8; count && i < operand_count; count--) {
 		struct avrcp_player *player;
@@ -2990,7 +2990,7 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
 		uint16_t len;
 
 		type = operands[i++];
-		len = bt_get_be16(&operands[i]);
+		len = get_be16(&operands[i]);
 		i += 2;
 
 		if (type != 0x01) {
@@ -3112,7 +3112,7 @@ static void avrcp_addressed_player_changed(struct avrcp *session,
 						struct avrcp_header *pdu)
 {
 	struct avrcp_player *player = session->controller->player;
-	uint16_t id = bt_get_be16(&pdu->params[1]);
+	uint16_t id = get_be16(&pdu->params[1]);
 
 	if (player != NULL && player->id == id)
 		return;
@@ -3124,7 +3124,7 @@ static void avrcp_addressed_player_changed(struct avrcp *session,
 			return;
 	}
 
-	player->uid_counter = bt_get_be16(&pdu->params[3]);
+	player->uid_counter = get_be16(&pdu->params[3]);
 	session->controller->player = player;
 
 	if (player->features != NULL)
@@ -3137,7 +3137,7 @@ static void avrcp_uids_changed(struct avrcp *session, struct avrcp_header *pdu)
 {
 	struct avrcp_player *player = session->controller->player;
 
-	player->uid_counter = bt_get_be16(&pdu->params[1]);
+	player->uid_counter = get_be16(&pdu->params[1]);
 }
 
 static gboolean avrcp_handle_event(struct avctp *conn,
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index b93027a..8c95406 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -43,6 +43,7 @@
 #include <glib.h>
 
 #include "src/log.h"
+#include "src/shared/util.h"
 #include "lib/uuid.h"
 #include "btio/btio.h"
 
@@ -634,8 +635,8 @@ uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
 
 	switch (req->uuid_size) {
 	case 2: /* UUID16 */
-		*dst = bt_get_be16(dest);
-		*src = bt_get_be16(source);
+		*dst = get_be16(dest);
+		*src = get_be16(source);
 		break;
 	case 16: /* UUID128 */
 		/* Check that the bytes in the UUID, except the service ID
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 711853f..6b27cfa 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -40,6 +40,7 @@
 #include "src/log.h"
 #include "src/error.h"
 #include "src/dbus-common.h"
+#include "src/shared/util.h"
 #include "sap.h"
 #include "server.h"
 
@@ -312,7 +313,7 @@ static void connect_req(struct sap_server *server,
 
 	stop_guard_timer(server);
 
-	maxmsgsize = bt_get_be16(&param->val);
+	maxmsgsize = get_be16(&param->val);
 
 	DBG("Connect MaxMsgSize: 0x%04x", maxmsgsize);
 
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index fbeb488..d2ec9e1 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -37,6 +37,8 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include "src/shared/util.h"
+
 #include "sdpd.h"
 #include "log.h"
 
@@ -174,7 +176,7 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 				struct attrid *aid;
 				aid = malloc(sizeof(struct attrid));
 				aid->dtd = dataType;
-				aid->uint16 = bt_get_be16(p);
+				aid->uint16 = get_be16(p);
 				pElem = (char *) aid;
 			} else {
 				uint16_t tmp;
@@ -392,7 +394,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 		goto done;
 	}
 
-	expected = bt_get_be16(pdata);
+	expected = get_be16(pdata);
 
 	SDPDBG("Expected count: %d", expected);
 	SDPDBG("Bytes scanned : %d", scanned);
@@ -479,7 +481,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 			if (pCache) {
 				pCacheBuffer = pCache->data;
 				/* get the rsp_count from the cached buffer */
-				rsp_count = bt_get_be16(pCacheBuffer);
+				rsp_count = get_be16(pCacheBuffer);
 
 				/* get index of the last sdp_record_t sent */
 				lastIndex = cstate->cStateValue.lastIndexSent;
@@ -656,7 +658,7 @@ static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 		goto done;
 	}
 
-	max_rsp_size = bt_get_be16(pdata);
+	max_rsp_size = get_be16(pdata);
 
 	pdata += sizeof(uint16_t);
 	data_left -= sizeof(uint16_t);
@@ -813,7 +815,7 @@ static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 		goto done;
 	}
 
-	max = bt_get_be16(pdata);
+	max = get_be16(pdata);
 
 	pdata += sizeof(uint16_t);
 	data_left -= sizeof(uint16_t);
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index 38bf808..06df94e 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -39,6 +39,7 @@
 
 #include <glib.h>
 
+#include "src/shared/util.h"
 #include "sdpd.h"
 #include "log.h"
 
@@ -320,7 +321,7 @@ static sdp_record_t *extract_pdu_server(bdaddr_t *device, uint8_t *p,
 		return NULL;
 	}
 
-	lookAheadAttrId = bt_get_be16(p + sizeof(uint8_t));
+	lookAheadAttrId = get_be16(p + sizeof(uint8_t));
 
 	SDPDBG("Look ahead attr id : %d", lookAheadAttrId);
 
@@ -365,7 +366,7 @@ static sdp_record_t *extract_pdu_server(bdaddr_t *device, uint8_t *p,
 							seqlen, localExtractedLength);
 		dtd = *(uint8_t *) p;
 
-		attrId = bt_get_be16(p + attrSize);
+		attrId = get_be16(p + attrSize);
 		attrSize += sizeof(uint16_t);
 
 		SDPDBG("DTD of attrId : %d Attr id : 0x%x", dtd, attrId);
-- 
1.8.3.1

