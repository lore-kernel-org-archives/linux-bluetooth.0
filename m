Return-Path: <cyrus@holtmann.org>
Subject: [PATCH 1/3] SDP
From: Santiago Carot Nemesio <scarot@libresoft.es>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 15:34:25 +0200
Message-ID: <1272375265.2157.17.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes some blanks spaces in sdp source code.

>>From a915f0ca83f4b1424eb986f7b4314a2ff09a56fc Mon Sep 17 00:00:00 2001
From: Santiago Carot Nemesio <sancane@gmail.com>
Date: Tue, 27 Apr 2010 13:56:29 +0200
Subject: [PATCH 1/3] Removed blank spaces


Signed-off-by: Santiago Carot Nemesio <sancane@gmail.com>
---
 lib/sdp.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 7cf710b..ca16118 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -3254,7 +3254,7 @@ static int copy_cstate(uint8_t *pdata, int pdata_len, const sdp_cstate_t *cstate
 }
 
 /*
- * This is a service search request. 
+ * This is a service search request.
  *
  * INPUT :
  *
@@ -3417,7 +3417,7 @@ end:
 }
 
 /*
- * This is a service attribute request. 
+ * This is a service attribute request.
  *
  * INPUT :
  *
@@ -3438,7 +3438,7 @@ end:
  *
  *   sdp_list_t *attrid
  *     Singly linked list containing attribute identifiers desired.
- *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)  
+ *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)
  *     or a uint32_t(attrSpec=SDP_ATTR_REQ_RANGE)
  *
  * OUTPUT :
@@ -3448,7 +3448,7 @@ end:
  *     !0:
  *	 The service record
  */
-sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle, 
+sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 			sdp_attrreq_type_t reqtype, const sdp_list_t *attrids)
 {
 	uint32_t reqsize = 0, _reqsize;
@@ -3494,7 +3494,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 	pdata += sizeof(uint16_t);
 
 	// get attr seq PDU form
-	seqlen = gen_attridseq_pdu(pdata, attrids, 
+	seqlen = gen_attridseq_pdu(pdata, attrids,
 		reqtype == SDP_ATTR_REQ_INDIVIDUAL? SDP_UINT16 : SDP_UINT32);
 	if (seqlen == -1) {
 		errno = EINVAL;
@@ -3558,7 +3558,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 		SDPDBG("sdp_cstate_t length : %d\n", cstate_len);
 
 		/*
-		 * a split response: concatenate intermediate responses 
+		 * a split response: concatenate intermediate responses
 		 * and the last one (which has cstate_len == 0)
 		 */
 		if (cstate_len > 0 || rsp_concat_buf.data_size != 0) {
@@ -3583,7 +3583,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 		}
 		rec = sdp_extract_pdu(pdata, pdata_len, &scanned);
 	}
-	
+
 end:
 	if (reqbuf)
 		free(reqbuf);
@@ -3676,7 +3676,7 @@ int sdp_set_notify(sdp_session_t *session, sdp_callback_t *func, void *udata)
 
 /*
  * This function starts an asynchronous service search request.
- * The incomming and outgoing data are stored in the transaction structure 
+ * The incomming and outgoing data are stored in the transaction structure
  * buffers. When there is incomming data the sdp_process function must be
  * called to get the data and handle the continuation state.
  *
@@ -3771,7 +3771,7 @@ end:
 
 /*
  * This function starts an asynchronous service attribute request.
- * The incomming and outgoing data are stored in the transaction structure 
+ * The incomming and outgoing data are stored in the transaction structure
  * buffers. When there is incomming data the sdp_process function must be
  * called to get the data and handle the continuation state.
  *
@@ -3796,7 +3796,7 @@ end:
  *
  *   sdp_list_t *attrid_list
  *     Singly linked list containing attribute identifiers desired.
- *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)  
+ *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)
  *     or a uint32_t(attrSpec=SDP_ATTR_REQ_RANGE)
  *
  * OUTPUT :
@@ -3912,7 +3912,7 @@ end:
  *
  *   sdp_list_t *attrid_list
  *     Singly linked list containing attribute identifiers desired.
- *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)  
+ *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)
  *     or a uint32_t(attrSpec=SDP_ATTR_REQ_RANGE)
  *
 
@@ -4130,7 +4130,7 @@ int sdp_process(sdp_session_t *session)
 			pdata += sizeof(uint16_t); /* point to csrc */
 
 			/* the first csrc contains the sum of partial csrc responses */
-			*pcsrc += bt_get_unaligned((uint16_t *) pdata); 
+			*pcsrc += bt_get_unaligned((uint16_t *) pdata);
 
 			pdata += sizeof(uint16_t); /* point to the first handle */
 			rsp_count = csrc * 4;
@@ -4141,8 +4141,8 @@ int sdp_process(sdp_session_t *session)
 	case SDP_SVC_SEARCH_ATTR_RSP:
 		rsp_count = ntohs(bt_get_unaligned((uint16_t *) pdata));
 		SDPDBG("Attrlist byte count : %d\n", rsp_count);
-	
-		/* 
+
+		/*
 		 * Number of bytes in the AttributeLists parameter(without
 		 * continuation state) + AttributeListsByteCount field size.
 		 */
@@ -4168,7 +4168,7 @@ int sdp_process(sdp_session_t *session)
 
 	SDPDBG("Cstate length : %d\n", pcstate->length);
 
-	/* 
+	/*
 	 * Check out of bound. Continuation state must have at least
 	 * 1 byte: ZERO to indicate that it is not a partial response.
 	 */
@@ -4202,7 +4202,7 @@ int sdp_process(sdp_session_t *session)
 
 		// set the request header's param length
 		reqhdr->plen = htons(reqsize - sizeof(sdp_pdu_hdr_t));
-	
+
 		if (sdp_send_req(session, t->reqbuf, reqsize) < 0) {
 			SDPERR("Error sendind data:%s(%d)", strerror(errno), errno);
 			status = 0xffff;
@@ -4253,7 +4253,7 @@ end:
  *
  *   sdp_list_t *attrids
  *     Singly linked list containing attribute identifiers desired.
- *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)  
+ *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)
  *     or a uint32_t(attrSpec=SDP_ATTR_REQ_RANGE)
  *
  * OUTPUT :
-- 
1.6.3.3

