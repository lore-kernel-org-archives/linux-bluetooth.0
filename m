Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Remove duplicated NULL check and debug message
Date: Fri, 4 Mar 2011 19:33:07 +0100
Message-ID: <1299263587-25273-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sdpd-request.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 668e190..1722f78 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -557,17 +557,13 @@ static int extract_attrs(sdp_record_t *rec, sdp_list_t *seq, sdp_buf_t *buf)
 	if (!rec)
 		return SDP_INVALID_RECORD_HANDLE;
 
-	if (seq) {
-		SDPDBG("Entries in attr seq : %d", sdp_list_len(seq));
-	} else {
-		SDPDBG("NULL attribute descriptor");
-	}
-
 	if (seq == NULL) {
 		SDPDBG("Attribute sequence is NULL");
 		return 0;
 	}
 
+	SDPDBG("Entries in attr seq : %d", sdp_list_len(seq));
+
 	sdp_gen_record_pdu(rec, &pdu);
 
 	for (; seq; seq = seq->next) {
-- 
1.7.0.4
on behalf of ST-Ericsson
