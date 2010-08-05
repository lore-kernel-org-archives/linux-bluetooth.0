Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 4/9] Bluetooth: Fix endianness issue with L2CAP MPS configuration.
Date: Thu,  5 Aug 2010 15:54:22 -0700
Message-Id: <1281048867-32630-5-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1281048867-32630-1-git-send-email-mathewm@codeaurora.org>
References: <1281048867-32630-1-git-send-email-mathewm@codeaurora.org>
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
 net/bluetooth/l2cap.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 77ba106..5541b56 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2717,8 +2717,9 @@ done:
 		case L2CAP_MODE_ERTM:
 			pi->remote_tx_win = rfc.txwin_size;
 			pi->remote_max_tx = rfc.max_transmit;
-			if (rfc.max_pdu_size > pi->conn->mtu - 10)
-				rfc.max_pdu_size = le16_to_cpu(pi->conn->mtu - 10);
+
+			if (le16_to_cpu(rfc.max_pdu_size) > pi->conn->mtu - 10)
+				rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
 
 			pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
@@ -2735,8 +2736,8 @@ done:
 			break;
 
 		case L2CAP_MODE_STREAMING:
-			if (rfc.max_pdu_size > pi->conn->mtu - 10)
-				rfc.max_pdu_size = le16_to_cpu(pi->conn->mtu - 10);
+			if (le16_to_cpu(rfc.max_pdu_size) > pi->conn->mtu - 10)
+				rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
 
 			pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
