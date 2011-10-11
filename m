Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 16/16] Bluetooth: EWS: fix max_pdu calculation
Date: Tue, 11 Oct 2011 13:37:56 +0300
Message-Id: <1318329476-30153-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fix max_pdu_size calculationin for RFC. Change magic number to human readable
defines.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   42 ++++++++++++++++++++++++++++--------------
 1 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a703301..d418ddb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1947,6 +1947,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 	struct l2cap_conf_req *req = data;
 	struct l2cap_conf_rfc rfc = { .mode = chan->mode };
 	void *ptr = req->data;
+	u16 size;
 
 	BT_DBG("chan %p", chan);
 
@@ -1991,9 +1992,12 @@ done:
 		rfc.max_transmit    = chan->max_tx;
 		rfc.retrans_timeout = 0;
 		rfc.monitor_timeout = 0;
-		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_PDU_SIZE);
-		if (L2CAP_DEFAULT_MAX_PDU_SIZE > chan->conn->mtu - 10)
-			rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
+
+		size = min_t(u16, L2CAP_DEFAULT_MAX_PDU_SIZE, chan->conn->mtu -
+						L2CAP_EXT_HDR_SIZE -
+						L2CAP_SDULEN_SIZE -
+						L2CAP_FCS_SIZE);
+		rfc.max_pdu_size = cpu_to_le16(size);
 
 		l2cap_txwin_setup(chan);
 
@@ -2023,9 +2027,12 @@ done:
 		rfc.max_transmit    = 0;
 		rfc.retrans_timeout = 0;
 		rfc.monitor_timeout = 0;
-		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_PDU_SIZE);
-		if (L2CAP_DEFAULT_MAX_PDU_SIZE > chan->conn->mtu - 10)
-			rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
+
+		size = min_t(u16, L2CAP_DEFAULT_MAX_PDU_SIZE, chan->conn->mtu -
+						L2CAP_EXT_HDR_SIZE -
+						L2CAP_SDULEN_SIZE -
+						L2CAP_FCS_SIZE);
+		rfc.max_pdu_size = cpu_to_le16(size);
 
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
 							(unsigned long) &rfc);
@@ -2058,6 +2065,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	u16 mtu = L2CAP_DEFAULT_MTU;
 	u16 result = L2CAP_CONF_SUCCESS;
+	u16 size;
 
 	BT_DBG("chan %p", chan);
 
@@ -2167,10 +2175,13 @@ done:
 
 			chan->remote_max_tx = rfc.max_transmit;
 
-			if (le16_to_cpu(rfc.max_pdu_size) > chan->conn->mtu - 10)
-				rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
-
-			chan->remote_mps = le16_to_cpu(rfc.max_pdu_size);
+			size = min_t(u16, le16_to_cpu(rfc.max_pdu_size),
+						chan->conn->mtu -
+						L2CAP_EXT_HDR_SIZE -
+						L2CAP_SDULEN_SIZE -
+						L2CAP_FCS_SIZE);
+			rfc.max_pdu_size = cpu_to_le16(size);
+			chan->remote_mps = size;
 
 			rfc.retrans_timeout =
 				le16_to_cpu(L2CAP_DEFAULT_RETRANS_TO);
@@ -2185,10 +2196,13 @@ done:
 			break;
 
 		case L2CAP_MODE_STREAMING:
-			if (le16_to_cpu(rfc.max_pdu_size) > chan->conn->mtu - 10)
-				rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
-
-			chan->remote_mps = le16_to_cpu(rfc.max_pdu_size);
+			size = min_t(u16, le16_to_cpu(rfc.max_pdu_size),
+						chan->conn->mtu -
+						L2CAP_EXT_HDR_SIZE -
+						L2CAP_SDULEN_SIZE -
+						L2CAP_FCS_SIZE);
+			rfc.max_pdu_size = cpu_to_le16(size);
+			chan->remote_mps = size;
 
 			set_bit(CONF_MODE_DONE, &chan->conf_state);
 
-- 
1.7.4.1

