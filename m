Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 4/9] Bluetooth:  Fix endianness issue with L2CAP MPS configuration.
Date: Wed,  4 Aug 2010 15:49:01 -0700
Message-Id: <1280962146-22604-5-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
References: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Incoming configuration values must be converted to native CPU order
before use.  This fixes a bug where a little-endian MPS value is
compared to a native CPU value.  On big-endian processors, this
can cause ERTM and streaming mode segmentation to produce PDUs
that are larger than the remote stack is expecting, or that would
produce fragmented skbs that the current FCS code cannot handle.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 920a53f..8cf9569 100644
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

