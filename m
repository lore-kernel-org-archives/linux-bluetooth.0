Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/5] lib/sdp: Fix typo
Date: Wed,  3 Sep 2014 10:56:37 +0200
Message-Id: <1409734601-8078-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index e5e4622..1f19953 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -3859,7 +3859,7 @@ int sdp_service_search_async(sdp_session_t *session, const sdp_list_t *search, u
 	reqhdr->plen = htons((t->reqsize + cstate_len) - sizeof(sdp_pdu_hdr_t));
 
 	if (sdp_send_req(session, t->reqbuf, t->reqsize + cstate_len) < 0) {
-		SDPERR("Error sendind data:%m");
+		SDPERR("Error sending data:%m");
 		t->err = errno;
 		goto end;
 	}
@@ -3970,7 +3970,7 @@ int sdp_service_attr_async(sdp_session_t *session, uint32_t handle, sdp_attrreq_
 	reqhdr->plen = htons((t->reqsize + cstate_len) - sizeof(sdp_pdu_hdr_t));
 
 	if (sdp_send_req(session, t->reqbuf, t->reqsize + cstate_len) < 0) {
-		SDPERR("Error sendind data:%m");
+		SDPERR("Error sending data:%m");
 		t->err = errno;
 		goto end;
 	}
@@ -4086,7 +4086,7 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 	reqhdr->plen = htons((t->reqsize + cstate_len) - sizeof(sdp_pdu_hdr_t));
 
 	if (sdp_send_req(session, t->reqbuf, t->reqsize + cstate_len) < 0) {
-		SDPERR("Error sendind data:%m");
+		SDPERR("Error sending data:%m");
 		t->err = errno;
 		goto end;
 	}
@@ -4327,7 +4327,7 @@ int sdp_process(sdp_session_t *session)
 		reqhdr->plen = htons(reqsize - sizeof(sdp_pdu_hdr_t));
 
 		if (sdp_send_req(session, t->reqbuf, reqsize) < 0) {
-			SDPERR("Error sendind data:%m(%d)", errno);
+			SDPERR("Error sending data:%m(%d)", errno);
 			status = 0xffff;
 			t->err = errno;
 			goto end;
-- 
1.9.1

