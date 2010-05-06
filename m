Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 3/6] Remove extra spaces from sdpd-request.c
Date: Fri,  7 May 2010 00:27:09 +0200
Message-Id: <1273184832-8265-3-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1273184832-8265-1-git-send-email-santoscadenas@gmail.com>
References: <1273184832-8265-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sdpd-request.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 88d0afa..a8af8e4 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -98,7 +98,7 @@ struct attrid {
 
 /*
  * Generic data element sequence extractor. Builds
- * a list whose elements are those found in the 
+ * a list whose elements are those found in the
  * sequence. The data type of elements found in the
  * sequence is returned in the reference pDataType
  */
@@ -301,8 +301,8 @@ static int sdp_cstate_get(uint8_t *buffer, size_t len,
  * specified in the "search pattern" must be present in the
  * "target pattern". Here "search pattern" is the set of UUIDs
  * specified by the service discovery client and "target pattern"
- * is the set of UUIDs present in a service record. 
- * 
+ * is the set of UUIDs present in a service record.
+ *
  * Return 1 if each and every UUID in the search
  * pattern exists in the target pattern, 0 if the
  * match succeeds and -1 on error.
@@ -420,7 +420,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 			sdp_record_t *rec = (sdp_record_t *) list->data;
 
 			SDPDBG("Checking svcRec : 0x%x", rec->handle);
-				
+
 			if (sdp_match_uuid(pattern, rec->pattern) > 0 &&
 					sdp_check_access(rec->handle, &req->device)) {
 				rsp_count++;
@@ -429,7 +429,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 				handleSize += sizeof(uint32_t);
 			}
 		}
-		
+
 		SDPDBG("Match count: %d", rsp_count);
 
 		buf->data_size += handleSize;
@@ -525,7 +525,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 		}
 	}
 
-done:	
+done:
 	if (cstate)
 		free(cstate);
 	if (pattern)
@@ -684,11 +684,11 @@ static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 	SDPDBG("SvcRecHandle : 0x%x", handle);
 	SDPDBG("max_rsp_size : %d", max_rsp_size);
 
-	/* 
+	/*
 	 * Calculate Attribute size acording to MTU
 	 * We can send only (MTU - sizeof(sdp_pdu_hdr_t) - sizeof(sdp_cont_state_t))
 	 */
-	max_rsp_size = MIN(max_rsp_size, req->mtu - sizeof(sdp_pdu_hdr_t) - 
+	max_rsp_size = MIN(max_rsp_size, req->mtu - sizeof(sdp_pdu_hdr_t) -
 			sizeof(uint32_t) - SDP_CONT_STATE_SIZE - sizeof(uint16_t));
 
 	/* pull header for AttributeList byte count */
@@ -840,7 +840,7 @@ static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 	tmpbuf.buf_size = USHRT_MAX;
 	memset(tmpbuf.data, 0, USHRT_MAX);
 
-	/* 
+	/*
 	 * Calculate Attribute size acording to MTU
 	 * We can send only (MTU - sizeof(sdp_pdu_hdr_t) - sizeof(sdp_cont_state_t))
 	 */
-- 
1.7.0.4

