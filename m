Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 09/18] sdpd-request: Fix build errors due to unaligned memory access
Date: Tue, 4 Sep 2012 16:41:28 +0200
Message-ID: <1346769697-9930-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
References: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix number of build errors on ARM similar to one below.

  CC     src/bluetooth-sdpd-request.o
src/sdpd-request.c: In function extra_des:
src/sdpd-request.c:181:5: error: cast increases required alignment
    of targettype [-Werror=cast-align]

---
 src/sdpd-request.c |   62 ++++++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 6a903c6..2af743e 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -139,6 +139,7 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 	for (;;) {
 		char *pElem = NULL;
 		int localSeqLength = 0;
+		uuid_t *puuid;
 
 		if (bufsize < sizeof(uint8_t)) {
 			SDPDBG("->Unexpected end of buffer");
@@ -178,11 +179,11 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 				struct attrid *aid;
 				aid = malloc(sizeof(struct attrid));
 				aid->dtd = dataType;
-				bt_put_unaligned(ntohs(bt_get_unaligned((uint16_t *)p)), (uint16_t *)&aid->uint16);
+				aid->uint16 = bt_get_be16(p);
 				pElem = (char *) aid;
 			} else {
 				pElem = malloc(sizeof(uint16_t));
-				bt_put_unaligned(ntohs(bt_get_unaligned((uint16_t *)p)), (uint16_t *)pElem);
+				bt_put_be16(bt_get_unaligned((uint16_t *)p), pElem);
 			}
 			p += sizeof(uint16_t);
 			seqlen += sizeof(uint16_t);
@@ -201,11 +202,12 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 				struct attrid *aid;
 				aid = malloc(sizeof(struct attrid));
 				aid->dtd = dataType;
-				bt_put_unaligned(ntohl(bt_get_unaligned((uint32_t *)p)), (uint32_t *)&aid->uint32);
+				aid->uint32 = bt_get_be32(p);
+
 				pElem = (char *) aid;
 			} else {
 				pElem = malloc(sizeof(uint32_t));
-				bt_put_unaligned(ntohl(bt_get_unaligned((uint32_t *)p)), (uint32_t *)pElem);
+				bt_put_be32(bt_get_unaligned((uint32_t *)p), pElem);
 			}
 			p += sizeof(uint32_t);
 			seqlen += sizeof(uint32_t);
@@ -214,12 +216,14 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 		case SDP_UUID16:
 		case SDP_UUID32:
 		case SDP_UUID128:
-			pElem = malloc(sizeof(uuid_t));
-			status = sdp_uuid_extract(p, bufsize, (uuid_t *) pElem, &localSeqLength);
+			puuid = malloc(sizeof(uuid_t));
+			status = sdp_uuid_extract(p, bufsize, puuid, &localSeqLength);
 			if (status < 0) {
-				free(pElem);
+				free(puuid);
 				goto failed;
 			}
+
+			pElem = (char *) puuid;
 			seqlen += localSeqLength;
 			p += localSeqLength;
 			bufsize -= localSeqLength;
@@ -359,7 +363,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 	uint8_t *pCacheBuffer = NULL;
 	int handleSize = 0;
 	uint32_t cStateId = 0;
-	short *pTotalRecordCount, *pCurrentRecordCount;
+	uint8_t *pTotalRecordCount, *pCurrentRecordCount;
 	uint8_t *pdata = req->buf + sizeof(sdp_pdu_hdr_t);
 	size_t data_left = req->len - sizeof(sdp_pdu_hdr_t);
 
@@ -385,7 +389,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 		goto done;
 	}
 
-	expected = ntohs(bt_get_unaligned((uint16_t *)pdata));
+	expected = bt_get_be16(pdata);
 
 	SDPDBG("Expected count: %d", expected);
 	SDPDBG("Bytes scanned : %d", scanned);
@@ -409,14 +413,14 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 	pdata = buf->data;
 
 	/* total service record count = 0 */
-	pTotalRecordCount = (short *)pdata;
-	bt_put_unaligned(0, (uint16_t *)pdata);
+	pTotalRecordCount = pdata;
+	bt_put_be16(0, pdata);
 	pdata += sizeof(uint16_t);
 	buf->data_size += sizeof(uint16_t);
 
 	/* current service record count = 0 */
-	pCurrentRecordCount = (short *)pdata;
-	bt_put_unaligned(0, (uint16_t *)pdata);
+	pCurrentRecordCount = pdata;
+	bt_put_be16(0, pdata);
 	pdata += sizeof(uint16_t);
 	buf->data_size += sizeof(uint16_t);
 
@@ -433,7 +437,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 			if (sdp_match_uuid(pattern, rec->pattern) > 0 &&
 					sdp_check_access(rec->handle, &req->device)) {
 				rsp_count++;
-				bt_put_unaligned(htonl(rec->handle), (uint32_t *)pdata);
+				bt_put_be32(rec->handle, pdata);
 				pdata += sizeof(uint32_t);
 				handleSize += sizeof(uint32_t);
 			}
@@ -442,8 +446,8 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 		SDPDBG("Match count: %d", rsp_count);
 
 		buf->data_size += handleSize;
-		bt_put_unaligned(htons(rsp_count), (uint16_t *)pTotalRecordCount);
-		bt_put_unaligned(htons(rsp_count), (uint16_t *)pCurrentRecordCount);
+		bt_put_be16(rsp_count, pTotalRecordCount);
+		bt_put_be16(rsp_count, pCurrentRecordCount);
 
 		if (rsp_count > actual) {
 			/* cache the rsp and generate a continuation state */
@@ -472,7 +476,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 			if (pCache) {
 				pCacheBuffer = pCache->data;
 				/* get the rsp_count from the cached buffer */
-				rsp_count = ntohs(bt_get_unaligned((uint16_t *)pCacheBuffer));
+				rsp_count = bt_get_be16(pCacheBuffer);
 
 				/* get index of the last sdp_record_t sent */
 				lastIndex = cstate->cStateValue.lastIndexSent;
@@ -490,7 +494,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 		 * current record count and increment the cached
 		 * buffer pointer to beyond the counters
 		 */
-		pdata = (uint8_t *) pCurrentRecordCount + sizeof(uint16_t);
+		pdata = pCurrentRecordCount + sizeof(uint16_t);
 
 		/* increment beyond the totalCount and the currentCount */
 		pCacheBuffer += 2 * sizeof(uint16_t);
@@ -498,7 +502,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 		if (cstate) {
 			handleSize = 0;
 			for (i = lastIndex; (i - lastIndex) < actual && i < rsp_count; i++) {
-				bt_put_unaligned(bt_get_unaligned((uint32_t *)(pCacheBuffer + i * sizeof(uint32_t))), (uint32_t *)pdata);
+				memcpy(pdata, pCacheBuffer + i * sizeof(uint32_t), sizeof(uint32_t));
 				pdata += sizeof(uint32_t);
 				handleSize += sizeof(uint32_t);
 			}
@@ -508,8 +512,8 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 		}
 
 		buf->data_size += handleSize;
-		bt_put_unaligned(htons(rsp_count), (uint16_t *)pTotalRecordCount);
-		bt_put_unaligned(htons(i - lastIndex), (uint16_t *)pCurrentRecordCount);
+		bt_put_be16(rsp_count, pTotalRecordCount);
+		bt_put_be16(i - lastIndex, pCurrentRecordCount);
 
 		if (i == rsp_count) {
 			/* set "null" continuationState */
@@ -571,12 +575,12 @@ static int extract_attrs(sdp_record_t *rec, sdp_list_t *seq, sdp_buf_t *buf)
 		SDPDBG("AttrDataType : %d", aid->dtd);
 
 		if (aid->dtd == SDP_UINT16) {
-			uint16_t attr = bt_get_unaligned((uint16_t *)&aid->uint16);
+			uint16_t attr = aid->uint16;
 			sdp_data_t *a = sdp_data_get(rec, attr);
 			if (a)
 				sdp_append_to_pdu(buf, a);
 		} else if (aid->dtd == SDP_UINT32) {
-			uint32_t range = bt_get_unaligned((uint32_t *)&aid->uint32);
+			uint32_t range = aid->uint32;
 			uint16_t attr;
 			uint16_t low = (0xffff0000 & range) >> 16;
 			uint16_t high = 0x0000ffff & range;
@@ -639,7 +643,7 @@ static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 		goto done;
 	}
 
-	handle = ntohl(bt_get_unaligned((uint32_t *)pdata));
+	handle = bt_get_be32(pdata);
 
 	pdata += sizeof(uint32_t);
 	data_left -= sizeof(uint32_t);
@@ -649,7 +653,7 @@ static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 		goto done;
 	}
 
-	max_rsp_size = ntohs(bt_get_unaligned((uint16_t *)pdata));
+	max_rsp_size = bt_get_be16(pdata);
 
 	pdata += sizeof(uint16_t);
 	data_left -= sizeof(uint16_t);
@@ -765,7 +769,7 @@ done:
 		return status;
 
 	/* set attribute list byte count */
-	bt_put_unaligned(htons(buf->data_size - cstate_size), (uint16_t *)buf->data);
+	bt_put_be16(buf->data_size - cstate_size, buf->data);
 	buf->data_size += sizeof(uint16_t);
 	return 0;
 }
@@ -806,7 +810,7 @@ static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 		goto done;
 	}
 
-	max = ntohs(bt_get_unaligned((uint16_t *)pdata));
+	max = bt_get_be16(pdata);
 
 	pdata += sizeof(uint16_t);
 	data_left -= sizeof(uint16_t);
@@ -936,7 +940,7 @@ static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 
 	if (!status) {
 		/* set attribute list byte count */
-		bt_put_unaligned(htons(buf->data_size - cstate_size), (uint16_t *)buf->data);
+		bt_put_be16(buf->data_size - cstate_size, buf->data);
 		buf->data_size += sizeof(uint16_t);
 	}
 
@@ -1020,7 +1024,7 @@ static void process_request(sdp_req_t *req)
 send_rsp:
 	if (status) {
 		rsphdr->pdu_id = SDP_ERROR_RSP;
-		bt_put_unaligned(htons(status), (uint16_t *)rsp.data);
+		bt_put_be16(status, rsp.data);
 		rsp.data_size = sizeof(uint16_t);
 	}
 
-- 
1.7.9.5

