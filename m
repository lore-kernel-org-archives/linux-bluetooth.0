Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: L2CAP: Add missing checks for invalid LE DCID
Date: Mon,  2 Nov 2015 14:39:17 +0200
Message-Id: <1446467957-19646-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1446467957-19646-1-git-send-email-johan.hedberg@gmail.com>
References: <1446467957-19646-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When receiving a connect response we should make sure that the DCID is
within the valid range and that we don't already have another channel
allocated for the same DCID.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fdb7989e2997..66e8b6ee19a5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5250,7 +5250,9 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 	credits = __le16_to_cpu(rsp->credits);
 	result  = __le16_to_cpu(rsp->result);
 
-	if (result == L2CAP_CR_SUCCESS && (mtu < 23 || mps < 23))
+	if (result == L2CAP_CR_SUCCESS && (mtu < 23 || mps < 23 ||
+					   dcid < L2CAP_CID_DYN_START ||
+					   dcid > L2CAP_CID_LE_DYN_END))
 		return -EPROTO;
 
 	BT_DBG("dcid 0x%4.4x mtu %u mps %u credits %u result 0x%2.2x",
@@ -5270,6 +5272,11 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
+		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
+			err = -EBADSLT;
+			break;
+		}
+
 		chan->ident = 0;
 		chan->dcid = dcid;
 		chan->omtu = mtu;
-- 
2.5.0

