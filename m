Return-Path: <cyrus@holtmann.org>
From: Angela Bartholomaus <angelab@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, Angela Bartholomaus <angelab@codeaurora.org>
Subject: [PATCH 4/4] Bluetooth: Send Invalid Syntax Error if Resp Size Less Than 0x07
Date: Wed, 25 Aug 2010 10:01:45 -0700
Message-Id: <1282755705-28400-5-git-send-email-angelab@codeaurora.org>
In-Reply-To: <1282755705-28400-1-git-send-email-angelab@codeaurora.org>
References: <1282755705-28400-1-git-send-email-angelab@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Byte cnt range min 0x07 per Core v2.1, sec 4.61 for TP/SERVER/SA/BI-02-C
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
1.7.2.2
--
Angela Bartholomaus
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
