Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] sdp: Remove dead code
Date: Tue,  3 Dec 2013 17:53:12 +0200
Message-Id: <1386085993-22055-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386085993-22055-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386085993-22055-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

sdp_next_handle always returns value >= 0x10000.
---
 src/sdpd-service.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index 38bf808..448c76b 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -424,10 +424,6 @@ int service_register_req(sdp_req_t *req, sdp_buf_t *rsp)
 
 	if (rec->handle == 0xffffffff) {
 		rec->handle = sdp_next_handle();
-		if (rec->handle < 0x10000) {
-			sdp_record_free(rec);
-			goto invalid;
-		}
 	} else {
 		if (sdp_record_find(rec->handle)) {
 			/* extract_pdu_server will add the record handle
-- 
1.8.3.2

