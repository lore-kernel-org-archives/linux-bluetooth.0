Return-Path: <cyrus@holtmann.org>
Subject: [PATCH 2/2] Removed unnecessary assignment of ENOMEM to errno when
 malloc fails in SDP
From: Santiago Carot-Nemesio <scarot@libresoft.es>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1272395759.1914.3.camel@mosquito>
References: <1272395759.1914.3.camel@mosquito>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 21:20:24 +0200
Message-ID: <1272396024.1914.6.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch remove unnecessary assignment of ENOMEM when malloc fails

>>From 51fd53c35a860910ddcaf2d528ddd1978484468c Mon Sep 17 00:00:00 2001
From: Santiago Carot-Nemesio <sancane@gmail.com>
Date: Tue, 27 Apr 2010 21:03:36 +0200
Subject: [PATCH 2/2] Removed unnecessary assignment of ENOMEM to errno when malloc fails in SDP

---
 lib/sdp.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 0def315..ec194a4 100755
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2865,7 +2865,6 @@ int sdp_device_record_register_binary(sdp_session_t *session, bdaddr_t *device,
 	rsp = malloc(SDP_RSP_BUFFER_SIZE);
 	if (req == NULL || rsp == NULL) {
 		status = -1;
-		errno = ENOMEM;
 		goto end;
 	}
 
@@ -2992,7 +2991,6 @@ int sdp_device_record_unregister_binary(sdp_session_t *session, bdaddr_t *device
 	reqbuf = malloc(SDP_REQ_BUFFER_SIZE);
 	rspbuf = malloc(SDP_RSP_BUFFER_SIZE);
 	if (!reqbuf || !rspbuf) {
-		errno = ENOMEM;
 		status = -1;
 		goto end;
 	}
@@ -3087,7 +3085,6 @@ int sdp_device_record_update(sdp_session_t *session, bdaddr_t *device, const sdp
 	reqbuf = malloc(SDP_REQ_BUFFER_SIZE);
 	rspbuf = malloc(SDP_RSP_BUFFER_SIZE);
 	if (!reqbuf || !rspbuf) {
-		errno = ENOMEM;
 		status = -1;
 		goto end;
 	}
@@ -3369,7 +3366,6 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 	reqbuf = malloc(SDP_REQ_BUFFER_SIZE);
 	rspbuf = malloc(SDP_RSP_BUFFER_SIZE);
 	if (!reqbuf || !rspbuf) {
-		errno = ENOMEM;
 		status = -1;
 		goto end;
 	}
@@ -3543,10 +3539,9 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 
 	reqbuf = malloc(SDP_REQ_BUFFER_SIZE);
 	rspbuf = malloc(SDP_RSP_BUFFER_SIZE);
-	if (!reqbuf || !rspbuf) {
-		errno = ENOMEM;
+	if (!reqbuf || !rspbuf)
 		goto end;
-	}
+
 	reqhdr = (sdp_pdu_hdr_t *) reqbuf;
 	reqhdr->pdu_id = SDP_SVC_ATTR_REQ;
 
@@ -3692,10 +3687,9 @@ sdp_session_t *sdp_create(int sk, uint32_t flags)
 	struct sdp_transaction *t;
 
 	session = malloc(sizeof(sdp_session_t));
-	if (!session) {
-		errno = ENOMEM;
+	if (!session)
 		return NULL;
-	}
+
 	memset(session, 0, sizeof(*session));
 
 	session->flags = flags;
@@ -3703,7 +3697,6 @@ sdp_session_t *sdp_create(int sk, uint32_t flags)
 
 	t = malloc(sizeof(struct sdp_transaction));
 	if (!t) {
-		errno = ENOMEM;
 		free(session);
 		return NULL;
 	}
@@ -4365,7 +4358,6 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 	reqbuf = malloc(SDP_REQ_BUFFER_SIZE);
 	rspbuf = malloc(SDP_RSP_BUFFER_SIZE);
 	if (!reqbuf || !rspbuf) {
-		errno = ENOMEM;
 		status = -1;
 		goto end;
 	}
-- 
1.6.3.3

