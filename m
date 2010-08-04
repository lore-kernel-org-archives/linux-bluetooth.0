Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 5/9] Bluetooth:  Fix incorrect setting of remote_tx_win for L2CAP ERTM.
Date: Wed,  4 Aug 2010 15:49:02 -0700
Message-Id: <1280962146-22604-6-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
References: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

remote_tx_win is intended to be set on receipt of an L2CAP
configuration request.  The value is used to determine the size of the
transmit window on the remote side of an ERTM connection, so L2CAP
can stop sending frames when that remote window is full.

An incorrect remote_tx_win value will cause the stack to not fully
utilize the tx window (performance impact), or to overfill the remote
tx window (causing dropped frames or a disconnect).

This patch removes an extra setting of remote_tx_win when a
configuration response is received.  The transmit window has a
different meaning in a response - it is an informational value
less than or equal to the local tx_win.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 8cf9569..f0f3c7c 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2808,7 +2808,6 @@ static int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, void *data,
 	if (*result == L2CAP_CONF_SUCCESS) {
 		switch (rfc.mode) {
 		case L2CAP_MODE_ERTM:
-			pi->remote_tx_win   = rfc.txwin_size;
 			pi->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
 			pi->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
 			pi->mps    = le16_to_cpu(rfc.max_pdu_size);
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
