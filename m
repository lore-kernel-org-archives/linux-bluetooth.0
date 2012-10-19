Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Cc: sunnyk@codeaurora.org,
	marcel@holtmann.org,
	andrei.emeltchenko.news@gmail.com,
	Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Subject: [PATCHv4 16/18] Bluetooth: Ignore BR/EDR packet size constraints when fragmenting for AMP
Date: Fri, 19 Oct 2012 14:34:07 -0700
Message-Id: <1350682449-24818-17-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1350682449-24818-1-git-send-email-mathewm@codeaurora.org>
References: <1350682449-24818-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

When operating over BR/EDR, ERTM accounts for the maximum over-the-air
packet size when setting the PDU size.  AMP controllers do not use the
same over-the-air packets, so the PDU size should only be based on the
HCI MTU of the AMP controller.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2d3fc42..84ab0db 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2285,7 +2285,9 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 	/* PDU size is derived from the HCI MTU */
 	pdu_len = chan->conn->mtu;
 
-	pdu_len = min_t(size_t, pdu_len, L2CAP_BREDR_MAX_PAYLOAD);
+	/* Constrain PDU size for BR/EDR connections */
+	if (!chan->hs_hcon)
+		pdu_len = min_t(size_t, pdu_len, L2CAP_BREDR_MAX_PAYLOAD);
 
 	/* Adjust for largest possible L2CAP overhead. */
 	if (chan->fcs)
-- 
1.7.12.3

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
