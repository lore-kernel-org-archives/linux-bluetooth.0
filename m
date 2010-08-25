Return-Path: <cyrus@holtmann.org>
From: Angela Bartholomaus <angelab@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, Angela Bartholomaus <angelab@codeaurora.org>
Subject: [PATCH 1/4] Bluetooth: Send an Invalid PDU Size Error Response for Service Search Req
Date: Wed, 25 Aug 2010 10:01:42 -0700
Message-Id: <1282755705-28400-2-git-send-email-angelab@codeaurora.org>
In-Reply-To: <1282755705-28400-1-git-send-email-angelab@codeaurora.org>
References: <1282755705-28400-1-git-send-email-angelab@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send error code 0x04 per CoreSpecv2.1, sec 4.4 for TP/SERVER/SS/BI-01-C
---
 src/sdpd-request.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index d56ffc2..cc9fe82 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -367,7 +367,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 	mlen = scanned + sizeof(uint16_t) + 1;
 	// ensure we don't read past buffer
 	if (plen < mlen || plen != mlen + *(uint8_t *)(pdata+sizeof(uint16_t))) {
-		status = SDP_INVALID_SYNTAX;
+		status = SDP_INVALID_PDU_SIZE;
 		goto done;
 	}
 
-- 
1.7.2.2
--
Angela Bartholomaus
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
