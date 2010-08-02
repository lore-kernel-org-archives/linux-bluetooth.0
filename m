Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 5/8] Bluetooth:  Don't modify remote_tx_win when receiving a config response. Only config requests should set remote_tx_win.
Date: Mon,  2 Aug 2010 12:20:07 -0700
Message-Id: <1280776810-18213-6-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 9780ab0..582975b 100644
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
