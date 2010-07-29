Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: Don't send RFC for Basic Mode if only it is supported
Date: Thu, 29 Jul 2010 15:00:44 -0300
Message-Id: <1280426444-20469-1-git-send-email-gustavo@padovan.org>
In-Reply-To: <4C5020D7.7080005@nokia.com>
References: <4C5020D7.7080005@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

If the remote side doesn't support Enhanced Retransmission Mode neither
Streaming Mode, we shall not send the RFC option.
Some devices that only supports Basic Mode do not understanding the RFC
option. This patch fix the regression found with that devices.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 9ba1e8e..0f34e12 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2527,6 +2527,10 @@ done:
 		if (pi->imtu != L2CAP_DEFAULT_MTU)
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);
 
+		if (!(pi->conn->feat_mask & L2CAP_FEAT_ERTM) &&
+				!(pi->conn->feat_mask & L2CAP_FEAT_STREAMING))
+			break;
+
 		rfc.mode            = L2CAP_MODE_BASIC;
 		rfc.txwin_size      = 0;
 		rfc.max_transmit    = 0;
@@ -2534,6 +2538,8 @@ done:
 		rfc.monitor_timeout = 0;
 		rfc.max_pdu_size    = 0;
 
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
+							(unsigned long) &rfc);
 		break;
 
 	case L2CAP_MODE_ERTM:
@@ -2546,6 +2552,9 @@ done:
 		if (L2CAP_DEFAULT_MAX_PDU_SIZE > pi->conn->mtu - 10)
 			rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
 
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
+							(unsigned long) &rfc);
+
 		if (!(pi->conn->feat_mask & L2CAP_FEAT_FCS))
 			break;
 
@@ -2566,6 +2575,9 @@ done:
 		if (L2CAP_DEFAULT_MAX_PDU_SIZE > pi->conn->mtu - 10)
 			rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
 
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
+							(unsigned long) &rfc);
+
 		if (!(pi->conn->feat_mask & L2CAP_FEAT_FCS))
 			break;
 
@@ -2577,9 +2589,6 @@ done:
 		break;
 	}
 
-	l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
-						(unsigned long) &rfc);
-
 	/* FIXME: Need actual value of the flush timeout */
 	//if (flush_to != L2CAP_DEFAULT_FLUSH_TO)
 	//   l2cap_add_conf_opt(&ptr, L2CAP_CONF_FLUSH_TO, 2, pi->flush_to);
-- 
1.7.1.1

