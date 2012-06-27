Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 16/17] Bluetooth: Remove unnecessary h5_build_pkt function
Date: Wed, 27 Jun 2012 14:26:06 +0300
Message-Id: <1340796367-10321-17-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
References: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The implementation of h5_build_packet can be moved into
h5_prepare_pkt since all h5_prepare_pkt does is determine whether the
packet is reliable and then call h5_build_packet.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/hci_h5.c |   49 +++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 630ed70..e036278 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -556,14 +556,33 @@ static void h5_slip_one_byte(struct sk_buff *skb, u8 c)
 	}
 }
 
-static struct sk_buff *h5_build_pkt(struct hci_uart *hu, bool rel, u8 pkt_type,
-				    const u8 *data, size_t len)
+static bool valid_packet_type(u8 type)
+{
+	switch (type) {
+	case HCI_ACLDATA_PKT:
+	case HCI_COMMAND_PKT:
+	case HCI_SCODATA_PKT:
+	case HCI_3WIRE_LINK_PKT:
+	case HCI_3WIRE_ACK_PKT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static struct sk_buff *h5_prepare_pkt(struct hci_uart *hu, u8 pkt_type,
+				      const u8 *data, size_t len)
 {
 	struct h5 *h5 = hu->priv;
 	struct sk_buff *nskb;
 	u8 hdr[4];
 	int i;
 
+	if (!valid_packet_type(pkt_type)) {
+		BT_ERR("Unknown packet type %u", pkt_type);
+		return NULL;
+	}
+
 	/*
 	 * Max len of packet: (original len + 4 (H5 hdr) + 2 (crc)) * 2
 	 * (because bytes 0xc0 and 0xdb are escaped, worst case is when
@@ -581,7 +600,8 @@ static struct sk_buff *h5_build_pkt(struct hci_uart *hu, bool rel, u8 pkt_type,
 	hdr[0] = h5->tx_ack << 3;
 	h5->tx_ack_req = false;
 
-	if (rel) {
+	/* Reliable packet? */
+	if (pkt_type == HCI_ACLDATA_PKT || pkt_type == HCI_COMMAND_PKT) {
 		hdr[0] |= 1 << 7;
 		hdr[0] |= h5->tx_seq;
 		h5->tx_seq = (h5->tx_seq + 1) % 8;
@@ -607,29 +627,6 @@ static struct sk_buff *h5_build_pkt(struct hci_uart *hu, bool rel, u8 pkt_type,
 	return nskb;
 }
 
-static struct sk_buff *h5_prepare_pkt(struct hci_uart *hu, u8 pkt_type,
-				      const u8 *data, size_t len)
-{
-	bool rel;
-
-	switch (pkt_type) {
-	case HCI_ACLDATA_PKT:
-	case HCI_COMMAND_PKT:
-		rel = true;
-		break;
-	case HCI_SCODATA_PKT:
-	case HCI_3WIRE_LINK_PKT:
-	case HCI_3WIRE_ACK_PKT:
-		rel = false;
-		break;
-	default:
-		BT_ERR("Unknown packet type %u", pkt_type);
-		return NULL;
-	}
-
-	return h5_build_pkt(hu, rel, pkt_type, data, len);
-}
-
 static struct sk_buff *h5_dequeue(struct hci_uart *hu)
 {
 	struct h5 *h5 = hu->priv;
-- 
1.7.10.4

