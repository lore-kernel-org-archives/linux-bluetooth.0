Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/5] Bluetooth: EWS: fix max_pdu calculation
Date: Fri, 16 Sep 2011 16:39:39 +0300
Message-Id: <1316180379-31607-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1316180379-31607-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1316180379-31607-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fix max_pdu_size calculationin for RFC. Change magic number to human readable
defines.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 195af69..7eebddd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2004,9 +2004,13 @@ done:
 		rfc.max_transmit    = chan->max_tx;
 		rfc.retrans_timeout = 0;
 		rfc.monitor_timeout = 0;
-		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_PDU_SIZE);
-		if (L2CAP_DEFAULT_MAX_PDU_SIZE > chan->conn->mtu - 10)
-			rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
+
+		rfc.max_pdu_size = cpu_to_le16(min_t(u16,
+						L2CAP_DEFAULT_MAX_PDU_SIZE,
+						chan->conn->mtu -
+						L2CAP_EXTENDED_HDR_SIZE -
+						L2CAP_SDULEN_SIZE -
+						L2CAP_FCS_SIZE));
 
 		l2cap_txwin_setup(chan);
 
@@ -2252,8 +2256,13 @@ done:
 
 			chan->remote_max_tx = rfc.max_transmit;
 
-			if (le16_to_cpu(rfc.max_pdu_size) > chan->conn->mtu - 10)
-				rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
+			rfc.max_pdu_size = cpu_to_le16(min_t(u16,
+						le16_to_cpu(rfc.max_pdu_size),
+						chan->conn->mtu -
+						L2CAP_EXTENDED_HDR_SIZE -
+						L2CAP_SDULEN_SIZE -
+						L2CAP_FCS_SIZE));
+
 
 			chan->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
@@ -2285,8 +2294,12 @@ done:
 			break;
 
 		case L2CAP_MODE_STREAMING:
-			if (le16_to_cpu(rfc.max_pdu_size) > chan->conn->mtu - 10)
-				rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
+			rfc.max_pdu_size = cpu_to_le16(min_t(u16,
+						le16_to_cpu(rfc.max_pdu_size),
+						chan->conn->mtu -
+						L2CAP_EXTENDED_HDR_SIZE -
+						L2CAP_SDULEN_SIZE -
+						L2CAP_FCS_SIZE));
 
 			chan->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
-- 
1.7.4.1

