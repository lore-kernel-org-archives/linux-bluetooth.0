Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/5] lib/sdp: Split error handing for length and transaction id
Date: Thu,  4 Sep 2014 17:24:03 +0300
Message-Id: <1409840644-32200-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1409840644-32200-1-git-send-email-luiz.dentz@gmail.com>
References: <1409840644-32200-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This split the handling of invalid PDU length and not matching
transaction id adding proper debug logs.
---
 lib/sdp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 1f19953..2107e28 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4181,10 +4181,15 @@ int sdp_process(sdp_session_t *session)
 		goto end;
 	}
 
-	if (n == 0 || reqhdr->tid != rsphdr->tid ||
-		(n != (int) (ntohs(rsphdr->plen) + sizeof(sdp_pdu_hdr_t)))) {
+	if (reqhdr->tid != rsphdr->tid) {
 		t->err = EPROTO;
-		SDPERR("Protocol error.");
+		SDPERR("Protocol error: transaction id does not match");
+		goto end;
+	}
+
+	if (n != (int) (ntohs(rsphdr->plen) + sizeof(sdp_pdu_hdr_t))) {
+		t->err = EPROTO;
+		SDPERR("Protocol error: invalid length");
 		goto end;
 	}
 
-- 
1.9.3

