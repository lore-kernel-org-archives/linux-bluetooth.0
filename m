Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 19/22] sdp: Fix clang compiler warnings related to unaligned memory access
Date: Fri, 10 Feb 2012 18:40:04 -0300
Message-Id: <1328910007-25604-20-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sdpd-request.c |   42 +++++++++++++++++++++---------------------
 src/sdpd-service.c |   21 ++++++++++-----------
 2 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index ff00df7..dae6ec6 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -178,11 +178,11 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 				struct attrid *aid;
 				aid = malloc(sizeof(struct attrid));
 				aid->dtd = dataType;
-				bt_put_unaligned(ntohs(bt_get_unaligned((uint16_t *)p)), (uint16_t *)&aid->uint16);
+				bt_put_be16(bt_get_h16(p), &aid->uint16);
 				pElem = (char *) aid;
 			} else {
 				pElem = malloc(sizeof(uint16_t));
-				bt_put_unaligned(ntohs(bt_get_unaligned((uint16_t *)p)), (uint16_t *)pElem);
+				bt_put_be16(bt_get_h16(p), pElem);
 			}
 			p += sizeof(uint16_t);
 			seqlen += sizeof(uint16_t);
@@ -201,11 +201,11 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 				struct attrid *aid;
 				aid = malloc(sizeof(struct attrid));
 				aid->dtd = dataType;
-				bt_put_unaligned(ntohl(bt_get_unaligned((uint32_t *)p)), (uint32_t *)&aid->uint32);
+				bt_put_be32(bt_get_h32(p), &aid->uint32);
 				pElem = (char *) aid;
 			} else {
 				pElem = malloc(sizeof(uint32_t));
-				bt_put_unaligned(ntohl(bt_get_unaligned((uint32_t *)p)), (uint32_t *)pElem);
+				bt_put_be32(bt_get_h32(p), pElem);
 			}
 			p += sizeof(uint32_t);
 			seqlen += sizeof(uint32_t);
@@ -215,7 +215,7 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 		case SDP_UUID32:
 		case SDP_UUID128:
 			pElem = malloc(sizeof(uuid_t));
-			status = sdp_uuid_extract(p, bufsize, (uuid_t *) pElem, &localSeqLength);
+			status = sdp_uuid_extract(p, bufsize, (void *) pElem, &localSeqLength);
 			if (status < 0) {
 				free(pElem);
 				goto failed;
@@ -385,7 +385,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 		goto done;
 	}
 
-	expected = ntohs(bt_get_unaligned((uint16_t *)pdata));
+	expected = bt_get_be16(pdata);
 
 	SDPDBG("Expected count: %d", expected);
 	SDPDBG("Bytes scanned : %d", scanned);
@@ -409,14 +409,14 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 	pdata = buf->data;
 
 	/* total service record count = 0 */
-	pTotalRecordCount = (short *)pdata;
-	bt_put_unaligned(0, (uint16_t *)pdata);
+	pTotalRecordCount = (void *) pdata;
+	bt_put_h16(0, pdata);
 	pdata += sizeof(uint16_t);
 	buf->data_size += sizeof(uint16_t);
 
 	/* current service record count = 0 */
-	pCurrentRecordCount = (short *)pdata;
-	bt_put_unaligned(0, (uint16_t *)pdata);
+	pCurrentRecordCount = (void *) pdata;
+	bt_put_h16(0, pdata);
 	pdata += sizeof(uint16_t);
 	buf->data_size += sizeof(uint16_t);
 
@@ -433,7 +433,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 			if (sdp_match_uuid(pattern, rec->pattern) > 0 &&
 					sdp_check_access(rec->handle, &req->device)) {
 				rsp_count++;
-				bt_put_unaligned(htonl(rec->handle), (uint32_t *)pdata);
+				bt_put_be32(rec->handle, pdata);
 				pdata += sizeof(uint32_t);
 				handleSize += sizeof(uint32_t);
 			}
@@ -442,8 +442,8 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 		SDPDBG("Match count: %d", rsp_count);
 
 		buf->data_size += handleSize;
-		bt_put_unaligned(htons(rsp_count), (uint16_t *)pTotalRecordCount);
-		bt_put_unaligned(htons(rsp_count), (uint16_t *)pCurrentRecordCount);
+		bt_put_be16(rsp_count, pTotalRecordCount);
+		bt_put_be16(rsp_count, pCurrentRecordCount);
 
 		if (rsp_count > actual) {
 			/* cache the rsp and generate a continuation state */
@@ -472,7 +472,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 			if (pCache) {
 				pCacheBuffer = pCache->data;
 				/* get the rsp_count from the cached buffer */
-				rsp_count = ntohs(bt_get_unaligned((uint16_t *)pCacheBuffer));
+				rsp_count = bt_get_be16(pCacheBuffer);
 
 				/* get index of the last sdp_record_t sent */
 				lastIndex = cstate->cStateValue.lastIndexSent;
@@ -498,7 +498,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 		if (cstate) {
 			handleSize = 0;
 			for (i = lastIndex; (i - lastIndex) < actual && i < rsp_count; i++) {
-				bt_put_unaligned(bt_get_unaligned((uint32_t *)(pCacheBuffer + i * sizeof(uint32_t))), (uint32_t *)pdata);
+				bt_put_h32(bt_get_h32((pCacheBuffer + i * sizeof(uint32_t))), pdata);
 				pdata += sizeof(uint32_t);
 				handleSize += sizeof(uint32_t);
 			}
@@ -639,7 +639,7 @@ static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 		goto done;
 	}
 
-	handle = ntohl(bt_get_unaligned((uint32_t *)pdata));
+	handle = bt_get_be32(pdata);
 
 	pdata += sizeof(uint32_t);
 	data_left -= sizeof(uint32_t);
@@ -649,7 +649,7 @@ static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 		goto done;
 	}
 
-	max_rsp_size = ntohs(bt_get_unaligned((uint16_t *)pdata));
+	max_rsp_size = bt_get_be16(pdata);
 
 	pdata += sizeof(uint16_t);
 	data_left -= sizeof(uint16_t);
@@ -765,7 +765,7 @@ done:
 		return status;
 
 	/* set attribute list byte count */
-	bt_put_unaligned(htons(buf->data_size - cstate_size), (uint16_t *)buf->data);
+	bt_put_be16(buf->data_size - cstate_size, buf->data);
 	buf->data_size += sizeof(uint16_t);
 	return 0;
 }
@@ -806,7 +806,7 @@ static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 		goto done;
 	}
 
-	max = ntohs(bt_get_unaligned((uint16_t *)pdata));
+	max = bt_get_be16(pdata);
 
 	pdata += sizeof(uint16_t);
 	data_left -= sizeof(uint16_t);
@@ -936,7 +936,7 @@ static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 
 	if (!status) {
 		/* set attribute list byte count */
-		bt_put_unaligned(htons(buf->data_size - cstate_size), (uint16_t *)buf->data);
+		bt_put_be16(buf->data_size - cstate_size, buf->data);
 		buf->data_size += sizeof(uint16_t);
 	}
 
@@ -1020,7 +1020,7 @@ static void process_request(sdp_req_t *req)
 send_rsp:
 	if (status) {
 		rsphdr->pdu_id = SDP_ERROR_RSP;
-		bt_put_unaligned(htons(status), (uint16_t *)rsp.data);
+		bt_put_be16(status, rsp.data);
 		rsp.data_size = sizeof(uint16_t);
 	}
 
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index de11562..7977043 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -313,7 +313,7 @@ static sdp_record_t *extract_pdu_server(bdaddr_t *device, uint8_t *p,
 		return NULL;
 	}
 
-	lookAheadAttrId = ntohs(bt_get_unaligned((uint16_t *) (p + sizeof(uint8_t))));
+	lookAheadAttrId = bt_get_be16(p + sizeof(uint8_t));
 
 	SDPDBG("Look ahead attr id : %d", lookAheadAttrId);
 
@@ -323,9 +323,8 @@ static sdp_record_t *extract_pdu_server(bdaddr_t *device, uint8_t *p,
 			SDPDBG("Unexpected end of packet");
 			return NULL;
 		}
-		handle = ntohl(bt_get_unaligned((uint32_t *) (p +
-				sizeof(uint8_t) + sizeof(uint16_t) +
-				sizeof(uint8_t))));
+		handle = bt_get_be32(p + sizeof(uint8_t) + sizeof(uint16_t) +
+				sizeof(uint8_t));
 		SDPDBG("SvcRecHandle : 0x%x", handle);
 		rec = sdp_record_find(handle);
 	} else if (handleExpected != 0xffffffff)
@@ -359,7 +358,7 @@ static sdp_record_t *extract_pdu_server(bdaddr_t *device, uint8_t *p,
 							seqlen, localExtractedLength);
 		dtd = *(uint8_t *) p;
 
-		attrId = ntohs(bt_get_unaligned((uint16_t *) (p + attrSize)));
+		attrId = bt_get_be16(p + attrSize);
 		attrSize += sizeof(uint16_t);
 
 		SDPDBG("DTD of attrId : %d Attr id : 0x%x", dtd, attrId);
@@ -450,13 +449,13 @@ success:
 	update_db_timestamp();
 
 	/* Build a rsp buffer */
-	bt_put_unaligned(htonl(rec->handle), (uint32_t *) rsp->data);
+	bt_put_be32(rec->handle, rsp->data);
 	rsp->data_size = sizeof(uint32_t);
 
 	return 0;
 
 invalid:
-	bt_put_unaligned(htons(SDP_INVALID_SYNTAX), (uint16_t *) rsp->data);
+	bt_put_be16(SDP_INVALID_SYNTAX, rsp->data);
 	rsp->data_size = sizeof(uint16_t);
 
 	return -1;
@@ -471,7 +470,7 @@ int service_update_req(sdp_req_t *req, sdp_buf_t *rsp)
 	int status = 0, scanned = 0;
 	uint8_t *p = req->buf + sizeof(sdp_pdu_hdr_t);
 	int bufsize = req->len - sizeof(sdp_pdu_hdr_t);
-	uint32_t handle = ntohl(bt_get_unaligned((uint32_t *) p));
+	uint32_t handle = bt_get_be32(p);
 
 	SDPDBG("Svc Rec Handle: 0x%x", handle);
 
@@ -499,7 +498,7 @@ int service_update_req(sdp_req_t *req, sdp_buf_t *rsp)
 
 done:
 	p = rsp->data;
-	bt_put_unaligned(htons(status), (uint16_t *) p);
+	bt_put_be16(status, p);
 	rsp->data_size = sizeof(uint16_t);
 	return status;
 }
@@ -510,7 +509,7 @@ done:
 int service_remove_req(sdp_req_t *req, sdp_buf_t *rsp)
 {
 	uint8_t *p = req->buf + sizeof(sdp_pdu_hdr_t);
-	uint32_t handle = ntohl(bt_get_unaligned((uint32_t *) p));
+	uint32_t handle = bt_get_be32(p);
 	sdp_record_t *rec;
 	int status = 0;
 
@@ -529,7 +528,7 @@ int service_remove_req(sdp_req_t *req, sdp_buf_t *rsp)
 	}
 
 	p = rsp->data;
-	bt_put_unaligned(htons(status), (uint16_t *) p);
+	bt_put_be16(status, p);
 	rsp->data_size = sizeof(uint16_t);
 
 	return status;
-- 
1.7.8.1

