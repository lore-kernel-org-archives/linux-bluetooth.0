Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: sunnyk@codeaurora.org
Subject: [RFCv1 17/20] Bluetooth: Ignore BR/EDR packet size constraints when fragmenting for AMP
Date: Tue, 11 Sep 2012 11:21:28 -0700
Message-Id: <1347387691-5285-18-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
References: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When operating over BR/EDR, ERTM accounts for the maximum over-the-air
packet size when setting the PDU size.  AMP controllers do not use the
same over-the-air packets, so the PDU size should only be based on the
HCI MTU of the AMP controller.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e7c2efc..3fd2eac 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2230,7 +2230,9 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 	/* PDU size is derived from the HCI MTU */
 	pdu_len = chan->conn->mtu;
 
-	pdu_len = min_t(size_t, pdu_len, L2CAP_BREDR_MAX_PAYLOAD);
+	/* Constrain PDU size for BR/EDR connections */
+	if (!chan->hs_hcon)
+		pdu_len = min_t(size_t, pdu_len, L2CAP_BREDR_MAX_PAYLOAD);
 
 	/* Adjust for largest possible L2CAP overhead. */
 	if (chan->fcs)
-- 
1.7.12

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
