Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 02/22] Replace bt_get_be32() by get_be32()
Date: Mon, 24 Mar 2014 16:25:23 -0300
Message-Id: <1395689143-11091-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avrcp-lib.c     |  4 ++--
 android/avrcp.c         |  1 +
 monitor/sdp.c           | 20 ++++++++++----------
 profiles/audio/avrcp.c  | 12 ++++++------
 profiles/network/bnep.c |  4 ++--
 src/sdpd-request.c      |  4 ++--
 src/sdpd-service.c      |  6 +++---
 7 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 06aa552..5e678ea 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -510,7 +510,7 @@ static ssize_t get_element_attributes(struct avrcp *session,
 	number = params[8];
 
 	for (i = 0; i < number; i++) {
-		attrs[i] = bt_get_be32(&params[9 + i * 4]);
+		attrs[i] = get_be32(&params[9 + i * 4]);
 
 		if (attrs[i] == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
 				attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST)
@@ -540,7 +540,7 @@ static ssize_t register_notification(struct avrcp *session, uint8_t transaction,
 	if (!player->ind || !player->ind->register_notification)
 		return -ENOSYS;
 
-	interval = bt_get_be32(&params[1]);
+	interval = get_be32(&params[1]);
 
 	return player->ind->register_notification(session, transaction,
 							params[0], interval,
diff --git a/android/avrcp.c b/android/avrcp.c
index abd1b03..c8b4ec0 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -35,6 +35,7 @@
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
 #include "src/sdp-client.h"
+#include "src/shared/util.h"
 #include "src/log.h"
 
 #include "avctp.h"
diff --git a/monitor/sdp.c b/monitor/sdp.c
index a5e8ff4..d729e1f 100644
--- a/monitor/sdp.c
+++ b/monitor/sdp.c
@@ -94,7 +94,7 @@ static void print_uint(uint8_t indent, const uint8_t *data, uint32_t size)
 		print_field("%*c0x%4.4x", indent, ' ', get_be16(data));
 		break;
 	case 4:
-		print_field("%*c0x%8.8x", indent, ' ', bt_get_be32(data));
+		print_field("%*c0x%8.8x", indent, ' ', get_be32(data));
 		break;
 	case 8:
 		print_field("%*c0x%16.16" PRIx64, indent, ' ',
@@ -120,22 +120,22 @@ static void print_uuid(uint8_t indent, const uint8_t *data, uint32_t size)
 		break;
 	case 4:
 		print_field("%*c%s (0x%8.8x)", indent, ' ',
-			uuid32_to_str(bt_get_be32(data)), bt_get_be32(data));
+			uuid32_to_str(get_be32(data)), get_be32(data));
 		break;
 	case 16:
 		/* BASE_UUID = 00000000-0000-1000-8000-00805F9B34FB */
 		print_field("%*c%8.8x-%4.4x-%4.4x-%4.4x-%4.4x%8.4x",
 				indent, ' ',
-				bt_get_be32(data), get_be16(data + 4),
+				get_be32(data), get_be16(data + 4),
 				get_be16(data + 6), get_be16(data + 8),
-				get_be16(data + 10), bt_get_be32(data + 12));
+				get_be16(data + 10), get_be32(data + 12));
 		if (get_be16(data + 4) == 0x0000 &&
 				get_be16(data + 6) == 0x1000 &&
 				get_be16(data + 8) == 0x8000 &&
 				get_be16(data + 10) == 0x0080 &&
-				bt_get_be32(data + 12) == 0x5F9B34FB)
+				get_be32(data + 12) == 0x5F9B34FB)
 			print_field("%*c%s", indent, ' ',
-				uuid32_to_str(bt_get_be32(data)));
+				uuid32_to_str(get_be32(data)));
 		break;
 	default:
 		packet_hexdump(data, size);
@@ -237,7 +237,7 @@ static uint32_t get_size(const uint8_t *data, uint32_t size)
 			case 16:
 				return get_be16(data + 1);
 			case 32:
-				return bt_get_be32(data + 1);
+				return get_be32(data + 1);
 			default:
 				return 0;
 			}
@@ -323,7 +323,7 @@ static uint32_t get_bytes(const uint8_t *data, uint32_t size)
 	case 6:
 		return 3 + get_be16(data + 1);
 	case 7:
-		return 5 + bt_get_be32(data + 1);
+		return 5 + get_be32(data + 1);
 	}
 
 	return 0;
@@ -582,7 +582,7 @@ static void service_rsp(const struct l2cap_frame *frame, struct tid_data *tid)
 
 	for (i = 0; i < count; i++)
 		print_field("Record handle: 0x%4.4x",
-				bt_get_be32(frame->data + 4 + (i * 4)));
+				get_be32(frame->data + 4 + (i * 4)));
 
 	print_continuation(frame->data + 4 + (count * 4),
 					frame->size - 4 - (count * 4));
@@ -598,7 +598,7 @@ static void attr_req(const struct l2cap_frame *frame, struct tid_data *tid)
 		return;
 	}
 
-	print_field("Record handle: 0x%4.4x", bt_get_be32(frame->data));
+	print_field("Record handle: 0x%4.4x", get_be32(frame->data));
 	print_field("Max attribute bytes: %d", get_be16(frame->data + 4));
 
 	attr_bytes = get_bytes(frame->data + 6, frame->size - 6);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 8487682..6772984 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1082,7 +1082,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp *session,
 		for (i = 0, len = 0, attr_ids = NULL; i < nattr; i++) {
 			uint32_t id;
 
-			id = bt_get_be32(&pdu->params[9] + (i * sizeof(id)));
+			id = get_be32(&pdu->params[9] + (i * sizeof(id)));
 
 			/* Don't add invalid attributes */
 			if (id == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
@@ -1990,7 +1990,7 @@ static void avrcp_parse_attribute_list(struct avrcp_player *player,
 		uint32_t id;
 		uint16_t charset, len;
 
-		id = bt_get_be32(&operands[i]);
+		id = get_be32(&operands[i]);
 		i += sizeof(uint32_t);
 
 		charset = get_be16(&operands[i]);
@@ -2319,7 +2319,7 @@ static gboolean avrcp_change_path_rsp(struct avctp *conn,
 		goto done;
 	}
 
-	ret = bt_get_be32(&pdu->params[1]);
+	ret = get_be32(&pdu->params[1]);
 
 done:
 	if (ret < 0) {
@@ -2357,7 +2357,7 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 	player->uid_counter = get_be16(&pdu->params[1]);
 	player->browsed = true;
 
-	items = bt_get_be32(&pdu->params[3]);
+	items = get_be32(&pdu->params[3]);
 
 	depth = pdu->params[9];
 
@@ -2681,7 +2681,7 @@ static gboolean avrcp_search_rsp(struct avctp *conn, uint8_t *operands,
 	}
 
 	player->uid_counter = get_be16(&pdu->params[1]);
-	ret = bt_get_be32(&pdu->params[3]);
+	ret = get_be32(&pdu->params[3]);
 
 done:
 	media_player_search_complete(mp, ret);
@@ -2908,7 +2908,7 @@ avrcp_parse_media_player_item(struct avrcp *session, uint8_t *operands,
 
 	media_player_set_type(mp, type_to_string(operands[2]));
 
-	subtype = bt_get_be32(&operands[3]);
+	subtype = get_be32(&operands[3]);
 
 	media_player_set_subtype(mp, subtype_to_string(subtype));
 
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 8c95406..87304c5 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -650,13 +650,13 @@ uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
 		/* Intentional no-break */
 
 	case 4: /* UUID32 */
-		val = bt_get_be32(dest);
+		val = get_be32(dest);
 		if (val > 0xffff)
 			return BNEP_CONN_INVALID_DST;
 
 		*dst = val;
 
-		val = bt_get_be32(source);
+		val = get_be32(source);
 		if (val > 0xffff)
 			return BNEP_CONN_INVALID_SRC;
 
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index d2ec9e1..a9d92a6 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -203,7 +203,7 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 				struct attrid *aid;
 				aid = malloc(sizeof(struct attrid));
 				aid->dtd = dataType;
-				aid->uint32 = bt_get_be32(p);
+				aid->uint32 = get_be32(p);
 
 				pElem = (char *) aid;
 			} else {
@@ -648,7 +648,7 @@ static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 		goto done;
 	}
 
-	handle = bt_get_be32(pdata);
+	handle = get_be32(pdata);
 
 	pdata += sizeof(uint32_t);
 	data_left -= sizeof(uint32_t);
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index 06df94e..f763436 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -331,7 +331,7 @@ static sdp_record_t *extract_pdu_server(bdaddr_t *device, uint8_t *p,
 			SDPDBG("Unexpected end of packet");
 			return NULL;
 		}
-		handle = bt_get_be32(p + sizeof(uint8_t) + sizeof(uint16_t) +
+		handle = get_be32(p + sizeof(uint8_t) + sizeof(uint16_t) +
 							sizeof(uint8_t));
 		SDPDBG("SvcRecHandle : 0x%x", handle);
 		rec = sdp_record_find(handle);
@@ -478,7 +478,7 @@ int service_update_req(sdp_req_t *req, sdp_buf_t *rsp)
 	int status = 0, scanned = 0;
 	uint8_t *p = req->buf + sizeof(sdp_pdu_hdr_t);
 	int bufsize = req->len - sizeof(sdp_pdu_hdr_t);
-	uint32_t handle = bt_get_be32(p);
+	uint32_t handle = get_be32(p);
 
 	SDPDBG("Svc Rec Handle: 0x%x", handle);
 
@@ -517,7 +517,7 @@ done:
 int service_remove_req(sdp_req_t *req, sdp_buf_t *rsp)
 {
 	uint8_t *p = req->buf + sizeof(sdp_pdu_hdr_t);
-	uint32_t handle = bt_get_be32(p);
+	uint32_t handle = get_be32(p);
 	sdp_record_t *rec;
 	int status = 0;
 
-- 
1.8.3.1

