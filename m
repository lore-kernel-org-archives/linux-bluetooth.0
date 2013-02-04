Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/3] lib: Fix buffer overflow when processing SDP response
Date: Sun,  3 Feb 2013 21:20:43 -0400
Message-Id: <1359940845-14451-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1359940845-14451-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1359940845-14451-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

rsp_count is either read or calculated from untrusted input, and
therefore needs to be checked before being used as offset. The "plen"
variable is appropriate because it is calculated as the sum of fixed and
variable length fields, excluding the continuation state field, which
has at least 1 byte for its own length field.
---
 lib/sdp.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/sdp.c b/lib/sdp.c
index b87f392..f3a0c17 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4189,6 +4189,17 @@ int sdp_process(sdp_session_t *session)
 		goto end;
 	}
 
+	/*
+	 * Out of bound check before using rsp_count as offset for continuation
+	 * state, which has at least a one byte size field.
+	 */
+	if ((n - (int) sizeof(sdp_pdu_hdr_t)) < plen + 1) {
+		t->err = EPROTO;
+		SDPERR("Protocol error: invalid PDU size");
+		status = SDP_INVALID_PDU_SIZE;
+		goto end;
+	}
+
 	pcstate = (sdp_cstate_t *) (pdata + rsp_count);
 
 	SDPDBG("Cstate length : %d\n", pcstate->length);
-- 
1.7.9.5

