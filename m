Return-Path: <cyrus@holtmann.org>
From: Angela Bartholomaus <angelab@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	Angela Bartholomaus <angelab@codeaurora.org>
Subject: [PATCH 3/4] Send an Invalid PDU Size Error Resp for Service Attr Search Req
Date: Tue, 24 Aug 2010 15:14:19 -0700
Message-Id: <1282688060-10727-4-git-send-email-angelab@codeaurora.org>
In-Reply-To: <1282688060-10727-1-git-send-email-angelab@codeaurora.org>
References: <1282688060-10727-1-git-send-email-angelab@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Send error code for an SDP request received with an invalid PDU size
---
 src/sdpd-request.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index ccbd920..8547939 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -818,7 +818,7 @@ static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 
 	plen = ntohs(((sdp_pdu_hdr_t *)(req->buf))->plen);
 	if (plen < totscanned || plen != totscanned + *(uint8_t *)pdata) {
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
