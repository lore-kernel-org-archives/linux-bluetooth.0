Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 18/62] Replace bt_put_be32() by put_be32()
Date: Thu, 20 Mar 2014 11:42:43 -0300
Message-Id: <1395326607-27068-19-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avrcp-lib.c    |  6 +++---
 android/avrcp.c        |  2 +-
 lib/sdp.c              | 12 ++++++------
 profiles/audio/avrcp.c |  4 ++--
 src/sdpd-request.c     |  4 ++--
 src/sdpd-service.c     |  2 +-
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 5e9bb1a..c7b8b6a 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -713,7 +713,7 @@ int avrcp_register_notification(struct avrcp *session, uint8_t event,
 	uint8_t params[5];
 
 	params[0] = event;
-	bt_put_be32(interval, &params[1]);
+	put_be32(interval, &params[1]);
 
 	return avrcp_send_req(session, AVC_CTYPE_NOTIFY, AVC_SUBUNIT_PANEL,
 					AVRCP_REGISTER_NOTIFICATION,
@@ -915,8 +915,8 @@ int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 {
 	uint8_t pdu[9];
 
-	bt_put_be32(position, &pdu[0]);
-	bt_put_be32(duration, &pdu[4]);
+	put_be32(position, &pdu[0]);
+	put_be32(duration, &pdu[4]);
 	pdu[8] = status;
 
 	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
diff --git a/android/avrcp.c b/android/avrcp.c
index 046a959..45268a5 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -180,7 +180,7 @@ static size_t write_element_text(uint8_t id, uint8_t text_len, uint8_t *text,
 	uint16_t charset = 106;
 	size_t len = 0;
 
-	bt_put_be32(id, pdu);
+	put_be32(id, pdu);
 	pdu += 4;
 	len += 4;
 
diff --git a/lib/sdp.c b/lib/sdp.c
index 4a1f69b..4a67a89 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -633,7 +633,7 @@ void sdp_set_seq_len(uint8_t *ptr, uint32_t length)
 	case SDP_ALT32:
 	case SDP_TEXT_STR32:
 	case SDP_URL_STR32:
-		bt_put_be32(length, ptr);
+		put_be32(length, ptr);
 		break;
 	}
 }
@@ -2860,7 +2860,7 @@ void sdp_append_to_buf(sdp_buf_t *dst, uint8_t *data, uint32_t len)
 		put_be16(dst->data_size - sizeof(uint8_t) - sizeof(uint16_t), p);
 		break;
 	case SDP_SEQ32:
-		bt_put_be32(dst->data_size - sizeof(uint8_t) - sizeof(uint32_t), p);
+		put_be32(dst->data_size - sizeof(uint8_t) - sizeof(uint32_t), p);
 		break;
 	}
 }
@@ -3040,7 +3040,7 @@ int sdp_device_record_unregister_binary(sdp_session_t *session, bdaddr_t *device
 
 	p = reqbuf + sizeof(sdp_pdu_hdr_t);
 	reqsize = sizeof(sdp_pdu_hdr_t);
-	bt_put_be32(handle, p);
+	put_be32(handle, p);
 	reqsize += sizeof(uint32_t);
 
 	reqhdr->plen = htons(reqsize - sizeof(sdp_pdu_hdr_t));
@@ -3138,7 +3138,7 @@ int sdp_device_record_update(sdp_session_t *session, bdaddr_t *device, const sdp
 	p = reqbuf + sizeof(sdp_pdu_hdr_t);
 	reqsize = sizeof(sdp_pdu_hdr_t);
 
-	bt_put_be32(handle, p);
+	put_be32(handle, p);
 	reqsize += sizeof(uint32_t);
 	p += sizeof(uint32_t);
 
@@ -3592,7 +3592,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 	reqsize = sizeof(sdp_pdu_hdr_t);
 
 	/* add the service record handle */
-	bt_put_be32(handle, pdata);
+	put_be32(handle, pdata);
 	reqsize += sizeof(uint32_t);
 	pdata += sizeof(uint32_t);
 
@@ -3944,7 +3944,7 @@ int sdp_service_attr_async(sdp_session_t *session, uint32_t handle, sdp_attrreq_
 	t->reqsize = sizeof(sdp_pdu_hdr_t);
 
 	/* add the service record handle */
-	bt_put_be32(handle, pdata);
+	put_be32(handle, pdata);
 	t->reqsize += sizeof(uint32_t);
 	pdata += sizeof(uint32_t);
 
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 913d2be..1d439ec 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2283,8 +2283,8 @@ static void avrcp_list_items(struct avrcp *session, uint32_t start,
 
 	pdu->params[0] = player->scope;
 
-	bt_put_be32(start, &pdu->params[1]);
-	bt_put_be32(end, &pdu->params[5]);
+	put_be32(start, &pdu->params[1]);
+	put_be32(end, &pdu->params[5]);
 
 	pdu->params[9] = 1;
 
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 600237a..3e58c22 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -212,7 +212,7 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 				memcpy(&tmp, p, sizeof(tmp));
 
 				pElem = malloc(sizeof(uint32_t));
-				bt_put_be32(tmp, pElem);
+				put_be32(tmp, pElem);
 			}
 			p += sizeof(uint32_t);
 			seqlen += sizeof(uint32_t);
@@ -442,7 +442,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 			if (sdp_match_uuid(pattern, rec->pattern) > 0 &&
 					sdp_check_access(rec->handle, &req->device)) {
 				rsp_count++;
-				bt_put_be32(rec->handle, pdata);
+				put_be32(rec->handle, pdata);
 				pdata += sizeof(uint32_t);
 				handleSize += sizeof(uint32_t);
 			}
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index e001c30..a90b299 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -457,7 +457,7 @@ success:
 	update_db_timestamp();
 
 	/* Build a rsp buffer */
-	bt_put_be32(rec->handle, rsp->data);
+	put_be32(rec->handle, rsp->data);
 	rsp->data_size = sizeof(uint32_t);
 
 	return 0;
-- 
1.8.3.1

