Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/3] lib: Check if SDP buffer has enough data on partial responses
Date: Sun,  3 Feb 2013 21:20:45 -0400
Message-Id: <1359940845-14451-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1359940845-14451-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1359940845-14451-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before manipulating data from previous partial responses, make sure the
buffer has enough data.
---
 lib/sdp.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index e212c29..3855381 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4144,7 +4144,7 @@ int sdp_process(sdp_session_t *session)
 		if (t->rsp_concat_buf.data_size == 0) {
 			/* first fragment */
 			rsp_count = sizeof(tsrc) + sizeof(csrc) + csrc * 4;
-		} else {
+		} else if (t->rsp_concat_buf.data_size >= sizeof(uint16_t) * 2) {
 			/* point to the first csrc */
 			uint8_t *pcsrc = t->rsp_concat_buf.data + 2;
 			uint16_t tcsrc, tcsrc2;
@@ -4161,6 +4161,11 @@ int sdp_process(sdp_session_t *session)
 
 			pdata += sizeof(uint16_t); /* point to the first handle */
 			rsp_count = csrc * 4;
+		} else {
+			t->err = EPROTO;
+			SDPERR("Protocol error: invalid PDU size");
+			status = SDP_INVALID_PDU_SIZE;
+			goto end;
 		}
 		status = 0x0000;
 		break;
-- 
1.7.9.5

