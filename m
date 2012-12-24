Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Subject: [PATCH] lib: use %m instead of strerror
Date: Mon, 24 Dec 2012 12:25:30 -0300
Message-Id: <1356362730-16557-1-git-send-email-crrodriguez@opensuse.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unlike strerror, %m is thread safe and we do not know
to what kind of program libbluetooh is being linked too.
---
 lib/sdp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index a760b73..e1e37ed 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1719,7 +1719,7 @@ int sdp_send_req_w4_rsp(sdp_session_t *session, uint8_t *reqbuf,
 
 	SDPDBG("");
 	if (0 > sdp_send_req(session, reqbuf, reqsize)) {
-		SDPERR("Error sending data:%s", strerror(errno));
+		SDPERR("Error sending data:%m");
 		return -1;
 	}
 	n = sdp_read_rsp(session, rspbuf, SDP_RSP_BUFFER_SIZE);
@@ -3787,7 +3787,7 @@ int sdp_service_search_async(sdp_session_t *session, const sdp_list_t *search, u
 	reqhdr->plen = htons((t->reqsize + cstate_len) - sizeof(sdp_pdu_hdr_t));
 
 	if (sdp_send_req(session, t->reqbuf, t->reqsize + cstate_len) < 0) {
-		SDPERR("Error sendind data:%s", strerror(errno));
+		SDPERR("Error sendind data:%m");
 		t->err = errno;
 		goto end;
 	}
@@ -3898,7 +3898,7 @@ int sdp_service_attr_async(sdp_session_t *session, uint32_t handle, sdp_attrreq_
 	reqhdr->plen = htons((t->reqsize + cstate_len) - sizeof(sdp_pdu_hdr_t));
 
 	if (sdp_send_req(session, t->reqbuf, t->reqsize + cstate_len) < 0) {
-		SDPERR("Error sendind data:%s", strerror(errno));
+		SDPERR("Error sendind data:%m");
 		t->err = errno;
 		goto end;
 	}
@@ -4014,7 +4014,7 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 	reqhdr->plen = htons((t->reqsize + cstate_len) - sizeof(sdp_pdu_hdr_t));
 
 	if (sdp_send_req(session, t->reqbuf, t->reqsize + cstate_len) < 0) {
-		SDPERR("Error sendind data:%s", strerror(errno));
+		SDPERR("Error sendind data:%m");
 		t->err = errno;
 		goto end;
 	}
@@ -4090,8 +4090,7 @@ int sdp_process(sdp_session_t *session)
 
 	rspbuf = malloc(SDP_RSP_BUFFER_SIZE);
 	if (!rspbuf) {
-		SDPERR("Response buffer alloc failure:%s (%d)",
-				strerror(errno), errno);
+		SDPERR("Response buffer alloc failure:%m (%d)", errno);
 		return -1;
 	}
 
@@ -4105,7 +4104,7 @@ int sdp_process(sdp_session_t *session)
 
 	n = sdp_read_rsp(session, rspbuf, SDP_RSP_BUFFER_SIZE);
 	if (n < 0) {
-		SDPERR("Read response:%s (%d)", strerror(errno), errno);
+		SDPERR("Read response:%m (%d)", errno);
 		t->err = errno;
 		goto end;
 	}
@@ -4232,7 +4231,7 @@ int sdp_process(sdp_session_t *session)
 		reqhdr->plen = htons(reqsize - sizeof(sdp_pdu_hdr_t));
 
 		if (sdp_send_req(session, t->reqbuf, reqsize) < 0) {
-			SDPERR("Error sendind data:%s(%d)", strerror(errno), errno);
+			SDPERR("Error sendind data:%m(%d)", errno);
 			status = 0xffff;
 			t->err = errno;
 			goto end;
@@ -4498,7 +4497,7 @@ int sdp_general_inquiry(inquiry_info *ii, int num_dev, int duration, uint8_t *fo
 {
 	int n = hci_inquiry(-1, 10, num_dev, NULL, &ii, 0);
 	if (n < 0) {
-		SDPERR("Inquiry failed:%s", strerror(errno));
+		SDPERR("Inquiry failed:%m");
 		return -1;
 	}
 	*found = n;
-- 
1.8.0.2

