Return-Path: <cyrus@holtmann.org>
From: Angela Bartholomaus <angelab@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	Angela Bartholomaus <angelab@codeaurora.org>
Subject: [PATCH 2/4] Send an Invalid PDU Size Error Response for Service Attr Req
Date: Tue, 24 Aug 2010 15:14:18 -0700
Message-Id: <1282688060-10727-3-git-send-email-angelab@codeaurora.org>
In-Reply-To: <1282688060-10727-1-git-send-email-angelab@codeaurora.org>
References: <1282688060-10727-1-git-send-email-angelab@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Send error code for an SDP request received with an invalid PDU size
---
 src/sdpd-request.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index cc9fe82..ccbd920 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -667,7 +667,7 @@ static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 	mlen = scanned + sizeof(uint32_t) + sizeof(uint16_t) + 1;
 	// ensure we don't read past buffer
 	if (plen < mlen || plen != mlen + *(uint8_t *)pdata) {
-		status = SDP_INVALID_SYNTAX;
+		status = SDP_INVALID_PDU_SIZE;
 		goto done;
 	}
 
-- 
1.7.0.2
--
Angela Bartholomaus
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
