Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 17/62] Replace bt_put_be16() by put_be16()
Date: Thu, 20 Mar 2014 11:42:42 -0300
Message-Id: <1395326607-27068-18-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avrcp-lib.c    |  8 ++++----
 android/avrcp.c        |  4 ++--
 lib/sdp.c              | 18 +++++++++---------
 profiles/audio/avrcp.c | 12 ++++++------
 profiles/sap/server.c  |  2 +-
 src/sdpd-request.c     | 20 ++++++++++----------
 src/sdpd-service.c     |  6 +++---
 7 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 934106b..5e9bb1a 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -815,7 +815,7 @@ int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id,
 {
 	uint8_t params[2];
 
-	bt_put_be16(player_id, params);
+	put_be16(player_id, params);
 
 	return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
 				AVRCP_SET_ADDRESSED_PLAYER, params,
@@ -881,7 +881,7 @@ int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
 			len = strlen(text[i]);
 
 		ptr[0] = attrs[i];
-		bt_put_be16(AVRCP_CHARSET_UTF8, &ptr[1]);
+		put_be16(AVRCP_CHARSET_UTF8, &ptr[1]);
 		ptr[3] = len;
 		memcpy(&ptr[4], text[i], len);
 		ptr += 4 + len;
@@ -945,7 +945,7 @@ int avrcp_get_player_values_text_rsp(struct avrcp *session,
 			len = strlen(text[i]);
 
 		ptr[0] = values[i];
-		bt_put_be16(AVRCP_CHARSET_UTF8, &ptr[1]);
+		put_be16(AVRCP_CHARSET_UTF8, &ptr[1]);
 		ptr[3] = len;
 		memcpy(&ptr[4], text[i], len);
 		ptr += 4 + len;
@@ -1016,7 +1016,7 @@ int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op)
 		return avctp_send_passthrough(session->conn, op, NULL, 0);
 
 	hton24(params, vendor);
-	bt_put_be16(op, &params[3]);
+	put_be16(op, &params[3]);
 
 	return avctp_send_passthrough(session->conn, AVC_VENDOR_UNIQUE, params,
 								sizeof(params));
diff --git a/android/avrcp.c b/android/avrcp.c
index a435594..046a959 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -184,11 +184,11 @@ static size_t write_element_text(uint8_t id, uint8_t text_len, uint8_t *text,
 	pdu += 4;
 	len += 4;
 
-	bt_put_be16(charset, pdu);
+	put_be16(charset, pdu);
 	pdu += 2;
 	len += 2;
 
-	bt_put_be16(text_len, pdu);
+	put_be16(text_len, pdu);
 	pdu += 2;
 	len += 2;
 
diff --git a/lib/sdp.c b/lib/sdp.c
index 9fc2b92..4a1f69b 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -627,7 +627,7 @@ void sdp_set_seq_len(uint8_t *ptr, uint32_t length)
 	case SDP_ALT16:
 	case SDP_TEXT_STR16:
 	case SDP_URL_STR16:
-		bt_put_be16(length, ptr);
+		put_be16(length, ptr);
 		break;
 	case SDP_SEQ32:
 	case SDP_ALT32:
@@ -673,7 +673,7 @@ void sdp_set_attrid(sdp_buf_t *buf, uint16_t attr)
 	/* data type for attr */
 	*p++ = SDP_UINT16;
 	buf->data_size = sizeof(uint8_t);
-	bt_put_be16(attr, p);
+	put_be16(attr, p);
 	buf->data_size += sizeof(uint16_t);
 }
 
@@ -2857,7 +2857,7 @@ void sdp_append_to_buf(sdp_buf_t *dst, uint8_t *data, uint32_t len)
 		*(uint8_t *) p = dst->data_size - sizeof(uint8_t) - sizeof(uint8_t);
 		break;
 	case SDP_SEQ16:
-		bt_put_be16(dst->data_size - sizeof(uint8_t) - sizeof(uint16_t), p);
+		put_be16(dst->data_size - sizeof(uint8_t) - sizeof(uint16_t), p);
 		break;
 	case SDP_SEQ32:
 		bt_put_be32(dst->data_size - sizeof(uint8_t) - sizeof(uint32_t), p);
@@ -3430,7 +3430,7 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 	pdata += seqlen;
 
 	/* specify the maximum svc rec count that client expects */
-	bt_put_be16(max_rec_num, pdata);
+	put_be16(max_rec_num, pdata);
 	reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
@@ -3597,7 +3597,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 	pdata += sizeof(uint32_t);
 
 	/* specify the response limit */
-	bt_put_be16(65535, pdata);
+	put_be16(65535, pdata);
 	reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
@@ -3851,7 +3851,7 @@ int sdp_service_search_async(sdp_session_t *session, const sdp_list_t *search, u
 	t->reqsize += seqlen;
 	pdata += seqlen;
 
-	bt_put_be16(max_rec_num, pdata);
+	put_be16(max_rec_num, pdata);
 	t->reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
@@ -3949,7 +3949,7 @@ int sdp_service_attr_async(sdp_session_t *session, uint32_t handle, sdp_attrreq_
 	pdata += sizeof(uint32_t);
 
 	/* specify the response limit */
-	bt_put_be16(65535, pdata);
+	put_be16(65535, pdata);
 	t->reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
@@ -4064,7 +4064,7 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 	t->reqsize += seqlen;
 	pdata += seqlen;
 
-	bt_put_be16(SDP_MAX_ATTR_LEN, pdata);
+	put_be16(SDP_MAX_ATTR_LEN, pdata);
 	t->reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
@@ -4444,7 +4444,7 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 	reqsize += seqlen;
 	pdata += seqlen;
 
-	bt_put_be16(SDP_MAX_ATTR_LEN, pdata);
+	put_be16(SDP_MAX_ATTR_LEN, pdata);
 	reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index ebd10a9..913d2be 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2450,7 +2450,7 @@ static void avrcp_get_item_attributes(struct avrcp *session, uint64_t uid)
 	pdu->pdu_id = AVRCP_GET_ITEM_ATTRIBUTES;
 	pdu->params[0] = 0x03;
 	bt_put_be64(uid, &pdu->params[1]);
-	bt_put_be16(player->uid_counter, &pdu->params[9]);
+	put_be16(player->uid_counter, &pdu->params[9]);
 	pdu->param_len = htons(12);
 
 	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
@@ -2634,7 +2634,7 @@ static void avrcp_change_path(struct avrcp *session, uint8_t direction,
 	struct avrcp_browsing_header *pdu = (void *) buf;
 
 	memset(buf, 0, sizeof(buf));
-	bt_put_be16(player->uid_counter, &pdu->params[0]);
+	put_be16(player->uid_counter, &pdu->params[0]);
 	pdu->params[2] = direction;
 	bt_put_be64(uid, &pdu->params[3]);
 	pdu->pdu_id = AVRCP_CHANGE_PATH;
@@ -2700,8 +2700,8 @@ static void avrcp_search(struct avrcp *session, const char *string)
 	stringlen = strnlen(string, sizeof(buf) - len);
 	len += stringlen;
 
-	bt_put_be16(AVRCP_CHARSET_UTF8, &pdu->params[0]);
-	bt_put_be16(stringlen, &pdu->params[2]);
+	put_be16(AVRCP_CHARSET_UTF8, &pdu->params[0]);
+	put_be16(stringlen, &pdu->params[2]);
 	memcpy(&pdu->params[4], string, stringlen);
 	pdu->pdu_id = AVRCP_SEARCH;
 	pdu->param_len = htons(len - AVRCP_BROWSING_HEADER_LENGTH);
@@ -2739,7 +2739,7 @@ static void avrcp_play_item(struct avrcp *session, uint64_t uid)
 
 	pdu->params[0] = player->scope;
 	bt_put_be64(uid, &pdu->params[1]);
-	bt_put_be16(player->uid_counter, &pdu->params[9]);
+	put_be16(player->uid_counter, &pdu->params[9]);
 
 	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
 
@@ -2785,7 +2785,7 @@ static void avrcp_add_to_nowplaying(struct avrcp *session, uint64_t uid)
 
 	pdu->params[0] = player->scope;
 	bt_put_be64(uid, &pdu->params[1]);
-	bt_put_be16(player->uid_counter, &pdu->params[9]);
+	put_be16(player->uid_counter, &pdu->params[9]);
 
 	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
 
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 6b27cfa..20c6cab 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -668,7 +668,7 @@ int sap_connect_rsp(void *sap_device, uint8_t status)
 		param = (struct sap_parameter *) &buf[size];
 		param->id = SAP_PARAM_ID_MAX_MSG_SIZE;
 		param->len = htons(SAP_PARAM_ID_MAX_MSG_SIZE_LEN);
-		bt_put_be16(SAP_BUF_SIZE, &param->val);
+		put_be16(SAP_BUF_SIZE, &param->val);
 		size += PARAMETER_SIZE(SAP_PARAM_ID_MAX_MSG_SIZE_LEN);
 
 		/* fall */
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index a9d92a6..600237a 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -184,7 +184,7 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 				memcpy(&tmp, p, sizeof(tmp));
 
 				pElem = malloc(sizeof(uint16_t));
-				bt_put_be16(tmp, pElem);
+				put_be16(tmp, pElem);
 			}
 			p += sizeof(uint16_t);
 			seqlen += sizeof(uint16_t);
@@ -419,13 +419,13 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 
 	/* total service record count = 0 */
 	pTotalRecordCount = pdata;
-	bt_put_be16(0, pdata);
+	put_be16(0, pdata);
 	pdata += sizeof(uint16_t);
 	buf->data_size += sizeof(uint16_t);
 
 	/* current service record count = 0 */
 	pCurrentRecordCount = pdata;
-	bt_put_be16(0, pdata);
+	put_be16(0, pdata);
 	pdata += sizeof(uint16_t);
 	buf->data_size += sizeof(uint16_t);
 
@@ -451,8 +451,8 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 		SDPDBG("Match count: %d", rsp_count);
 
 		buf->data_size += handleSize;
-		bt_put_be16(rsp_count, pTotalRecordCount);
-		bt_put_be16(rsp_count, pCurrentRecordCount);
+		put_be16(rsp_count, pTotalRecordCount);
+		put_be16(rsp_count, pCurrentRecordCount);
 
 		if (rsp_count > actual) {
 			/* cache the rsp and generate a continuation state */
@@ -517,8 +517,8 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 		}
 
 		buf->data_size += handleSize;
-		bt_put_be16(rsp_count, pTotalRecordCount);
-		bt_put_be16(i - lastIndex, pCurrentRecordCount);
+		put_be16(rsp_count, pTotalRecordCount);
+		put_be16(i - lastIndex, pCurrentRecordCount);
 
 		if (i == rsp_count) {
 			/* set "null" continuationState */
@@ -774,7 +774,7 @@ done:
 		return status;
 
 	/* set attribute list byte count */
-	bt_put_be16(buf->data_size - cstate_size, buf->data);
+	put_be16(buf->data_size - cstate_size, buf->data);
 	buf->data_size += sizeof(uint16_t);
 	return 0;
 }
@@ -945,7 +945,7 @@ static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 
 	if (!status) {
 		/* set attribute list byte count */
-		bt_put_be16(buf->data_size - cstate_size, buf->data);
+		put_be16(buf->data_size - cstate_size, buf->data);
 		buf->data_size += sizeof(uint16_t);
 	}
 
@@ -1029,7 +1029,7 @@ static void process_request(sdp_req_t *req)
 send_rsp:
 	if (status) {
 		rsphdr->pdu_id = SDP_ERROR_RSP;
-		bt_put_be16(status, rsp.data);
+		put_be16(status, rsp.data);
 		rsp.data_size = sizeof(uint16_t);
 	}
 
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index f763436..e001c30 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -463,7 +463,7 @@ success:
 	return 0;
 
 invalid:
-	bt_put_be16(SDP_INVALID_SYNTAX, rsp->data);
+	put_be16(SDP_INVALID_SYNTAX, rsp->data);
 	rsp->data_size = sizeof(uint16_t);
 
 	return -1;
@@ -506,7 +506,7 @@ int service_update_req(sdp_req_t *req, sdp_buf_t *rsp)
 
 done:
 	p = rsp->data;
-	bt_put_be16(status, p);
+	put_be16(status, p);
 	rsp->data_size = sizeof(uint16_t);
 	return status;
 }
@@ -536,7 +536,7 @@ int service_remove_req(sdp_req_t *req, sdp_buf_t *rsp)
 	}
 
 	p = rsp->data;
-	bt_put_be16(status, p);
+	put_be16(status, p);
 	rsp->data_size = sizeof(uint16_t);
 
 	return status;
-- 
1.8.3.1

