Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [RFC 7/7] Bluetooth: Do not limit enhanced L2CAP max PDU size to HCI MTU.
Date: Tue, 10 Aug 2010 12:15:04 -0700
Message-Id: <1281467704-5378-8-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

HCI MTU and PDU size have no relationship, since ERTM and streaming PDUs
can be fragmented over HCI just like other L2CAP frames.  The only
applicable limit for PDU size is the L2CAP MTU, which is now checked
during L2CAP configuration.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 0212035..15fbb1d 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2621,8 +2621,8 @@ done:
 		rfc.retrans_timeout = 0;
 		rfc.monitor_timeout = 0;
 		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_PDU_SIZE);
-		if (L2CAP_DEFAULT_MAX_PDU_SIZE > pi->conn->mtu - 10)
-			rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
+		if (L2CAP_DEFAULT_MAX_PDU_SIZE > pi->imtu)
+			rfc.max_pdu_size = cpu_to_le16(pi->imtu);
 
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
 							(unsigned long) &rfc);
@@ -2644,8 +2644,8 @@ done:
 		rfc.retrans_timeout = 0;
 		rfc.monitor_timeout = 0;
 		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_PDU_SIZE);
-		if (L2CAP_DEFAULT_MAX_PDU_SIZE > pi->conn->mtu - 10)
-			rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
+		if (L2CAP_DEFAULT_MAX_PDU_SIZE > pi->imtu)
+			rfc.max_pdu_size = cpu_to_le16(pi->imtu);
 
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
 							(unsigned long) &rfc);
@@ -2778,8 +2778,8 @@ done:
 			pi->remote_tx_win = rfc.txwin_size;
 			pi->remote_max_tx = rfc.max_transmit;
 
-			if (le16_to_cpu(rfc.max_pdu_size) > pi->conn->mtu - 10)
-				rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
+			if (le16_to_cpu(rfc.max_pdu_size) > pi->omtu)
+				rfc.max_pdu_size = cpu_to_le16(pi->omtu);
 
 			pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
@@ -2796,8 +2796,8 @@ done:
 			break;
 
 		case L2CAP_MODE_STREAMING:
-			if (le16_to_cpu(rfc.max_pdu_size) > pi->conn->mtu - 10)
-				rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
+			if (le16_to_cpu(rfc.max_pdu_size) > pi->omtu)
+				rfc.max_pdu_size = cpu_to_le16(pi->omtu);
 
 			pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
