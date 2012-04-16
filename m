Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 1/3] sdp: Fix compilation warning due to data type
 mismatch
Date: Mon, 16 Apr 2012 18:31:36 +0530
Message-id: <1334581298-11877-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1334581298-11877-1-git-send-email-s.syam@samsung.com>
References: <1334581298-11877-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In certain cross compiling environment, if we build the code with
enabling the maintainer mode, the following error happens.

cc1: warnings being treated as errors
lib/sdp.c: In function 'sdp_process':
lib/sdp.c:4111:6: error: comparison between signed and unsigned integer
expressions
make[2]: *** [lib/sdp.lo] Error 1
make[1]: *** [all] Error 2
---
 lib/sdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index eaf8d00..81e328e 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4108,7 +4108,7 @@ int sdp_process(sdp_session_t *session)
 	}
 
 	if (n == 0 || reqhdr->tid != rsphdr->tid ||
-		(n != (ntohs(rsphdr->plen) + (int) sizeof(sdp_pdu_hdr_t)))) {
+		(n != (int) (ntohs(rsphdr->plen) + sizeof(sdp_pdu_hdr_t)))) {
 		t->err = EPROTO;
 		SDPERR("Protocol error.");
 		goto end;
-- 
1.7.4.1

