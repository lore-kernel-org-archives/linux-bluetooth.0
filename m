Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 4/8] Bluetooth:  Do endianness conversion on MPS configuration value before doing comparisons.
Date: Mon,  2 Aug 2010 12:20:06 -0700
Message-Id: <1280776810-18213-5-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 44bc6ee..9780ab0 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2708,10 +2708,10 @@ done:
 		case L2CAP_MODE_ERTM:
 			pi->remote_tx_win = rfc.txwin_size;
 			pi->remote_max_tx = rfc.max_transmit;
-			if (rfc.max_pdu_size > pi->conn->mtu - 10)
-				rfc.max_pdu_size = le16_to_cpu(pi->conn->mtu - 10);
 
 			pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);
+			if (pi->remote_mps > pi->conn->mtu - 10)
+				pi->remote_mps = pi->conn->mtu - 10;
 
 			rfc.retrans_timeout =
 				le16_to_cpu(L2CAP_DEFAULT_RETRANS_TO);
@@ -2726,10 +2726,9 @@ done:
 			break;
 
 		case L2CAP_MODE_STREAMING:
-			if (rfc.max_pdu_size > pi->conn->mtu - 10)
-				rfc.max_pdu_size = le16_to_cpu(pi->conn->mtu - 10);
-
 			pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);
+			if (pi->remote_mps > pi->conn->mtu - 10)
+				pi->remote_mps = pi->conn->mtu - 10;
 
 			pi->conf_state |= L2CAP_CONF_MODE_DONE;
 
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
