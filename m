Return-Path: <cyrus@holtmann.org>
From: Angela Bartholomaus <angelab@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	Angela Bartholomaus <angelab@codeaurora.org>
Subject: [PATCH 4/4] Send Invalid Syntax Error if Resp Size Less Than 0x07
Date: Tue, 24 Aug 2010 15:14:20 -0700
Message-Id: <1282688060-10727-5-git-send-email-angelab@codeaurora.org>
In-Reply-To: <1282688060-10727-1-git-send-email-angelab@codeaurora.org>
References: <1282688060-10727-1-git-send-email-angelab@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Added in error catching, when a badly formed request comes in
---
 src/sdpd-request.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 8547939..205b27b 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -684,6 +684,15 @@ static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 	SDPDBG("max_rsp_size : %d", max_rsp_size);
 
 	/*
+	 * Check that max_rsp_size is within valid range
+	 * a minimum size of 0x0007 has to be used for data field
+	 */
+	if (max_rsp_size < 0x0007) {
+		status = SDP_INVALID_SYNTAX;
+		goto done;
+	}
+
+	/*
 	 * Calculate Attribute size acording to MTU
 	 * We can send only (MTU - sizeof(sdp_pdu_hdr_t) - sizeof(sdp_cont_state_t))
 	 */
-- 
1.7.0.2
--
Angela Bartholomaus
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
