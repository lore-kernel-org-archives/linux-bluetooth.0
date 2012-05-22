Return-Path: <cyrus@holtmann.org>
From: Arek Lichwa <Arkadiusz.Lichwa@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Arek Lichwa <Arkadiusz.Lichwa@tieto.com>
Subject: [PATCH] sdp/build: Build fails when SDP_DEBUG enabled
Date: Tue, 22 May 2012 14:21:34 +0200
Message-ID: <1337689294-20099-1-git-send-email-Arkadiusz.Lichwa@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Enabling SDP_DEBUG prevents build to be done.
---
 lib/sdp.c          |    3 +--
 src/sdpd-request.c |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 3dcef60..de5277f 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1387,7 +1387,7 @@ static void attr_print_func(void *value, void *userData)
 
 	SDPDBG("=====================================\n");
 	SDPDBG("ATTRIBUTE IDENTIFIER : 0x%x\n",  d->attrId);
-	SDPDBG("ATTRIBUTE VALUE PTR : 0x%x\n", (uint32_t)value);
+	SDPDBG("ATTRIBUTE VALUE PTR : %p\n", value);
 	if (d)
 		sdp_data_print(d);
 	else
@@ -3410,7 +3410,6 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 		scanned += sizeof(uint16_t);
 		pdata_len -= sizeof(uint16_t);
 
-		SDPDBG("Total svc count: %d\n", total_rec_count);
 		SDPDBG("Current svc count: %d\n", rec_count);
 		SDPDBG("ResponseLength: %d\n", rsplen);
 
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 93acb24..6a903c6 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -1037,7 +1037,7 @@ send_rsp:
 	if (send(req->sock, rsp.data, rsp.data_size, 0) < 0)
 		error("send: %s (%d)", strerror(errno), errno);
 
-	SDPDBG("Bytes Sent : %d", sent);
+	SDPDBG("Bytes Sent : %d", rsp.data_size);
 
 	free(rsp.data);
 	free(req->buf);
-- 
1.7.9

