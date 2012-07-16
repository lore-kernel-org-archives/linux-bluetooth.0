Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/18 v2] Bluetooth: Improve rx debug logs for Three-wire UART
Date: Mon, 16 Jul 2012 16:12:13 +0300
Message-Id: <1342444339-1627-12-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1342444339-1627-1-git-send-email-johan.hedberg@gmail.com>
References: <1342444339-1627-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Remove unnecessary debug logs and add some to more centralized places.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/hci_h5.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index a668b32..87c5ae6 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -246,8 +246,6 @@ static void h5_complete_rx_pkt(struct hci_uart *hu)
 	struct h5 *h5 = hu->priv;
 	const unsigned char *hdr = h5->rx_skb->data;
 
-	BT_DBG("%s", hu->hdev->name);
-
 	if (H5_HDR_RELIABLE(hdr)) {
 		h5->tx_ack = (h5->tx_ack + 1) % 8;
 		h5->tx_ack_req = true;
@@ -284,8 +282,6 @@ static int h5_rx_crc(struct hci_uart *hu, unsigned char c)
 {
 	struct h5 *h5 = hu->priv;
 
-	BT_DBG("%s 0x%02hhx", hu->hdev->name, c);
-
 	h5_complete_rx_pkt(hu);
 	h5_reset_rx(h5);
 
@@ -297,8 +293,6 @@ static int h5_rx_payload(struct hci_uart *hu, unsigned char c)
 	struct h5 *h5 = hu->priv;
 	const unsigned char *hdr = h5->rx_skb->data;
 
-	BT_DBG("%s 0x%02hhx", hu->hdev->name, c);
-
 	if (H5_HDR_CRC(hdr)) {
 		h5->rx_func = h5_rx_crc;
 		h5->rx_pending = 2;
@@ -315,8 +309,6 @@ static int h5_rx_3wire_hdr(struct hci_uart *hu, unsigned char c)
 	struct h5 *h5 = hu->priv;
 	const unsigned char *hdr = h5->rx_skb->data;
 
-	BT_DBG("%s 0x%02hhx", hu->hdev->name, c);
-
 	BT_DBG("%s rx: seq %u ack %u crc %u rel %u type %u len %u",
 	       hu->hdev->name, H5_HDR_SEQ(hdr), H5_HDR_ACK(hdr),
 	       H5_HDR_CRC(hdr), H5_HDR_RELIABLE(hdr), H5_HDR_PKT_TYPE(hdr),
@@ -345,8 +337,6 @@ static int h5_rx_pkt_start(struct hci_uart *hu, unsigned char c)
 {
 	struct h5 *h5 = hu->priv;
 
-	BT_DBG("%s 0x%02hhx", hu->hdev->name, c);
-
 	if (c == SLIP_DELIMITER)
 		return 1;
 
@@ -369,8 +359,6 @@ static int h5_rx_delimiter(struct hci_uart *hu, unsigned char c)
 {
 	struct h5 *h5 = hu->priv;
 
-	BT_DBG("%s 0x%02hhx", hu->hdev->name, c);
-
 	if (c == SLIP_DELIMITER)
 		h5->rx_func = h5_rx_pkt_start;
 
@@ -407,7 +395,7 @@ static void h5_unslip_one_byte(struct h5 *h5, unsigned char c)
 	memcpy(skb_put(h5->rx_skb, 1), byte, 1);
 	h5->rx_pending--;
 
-	BT_DBG("unsliped 0x%02hhx", *byte);
+	BT_DBG("unsliped 0x%02hhx, rx_pending %zu", *byte, h5->rx_pending);
 }
 
 static void h5_reset_rx(struct h5 *h5)
@@ -427,7 +415,8 @@ static int h5_recv(struct hci_uart *hu, void *data, int count)
 	struct h5 *h5 = hu->priv;
 	unsigned char *ptr = data;
 
-	BT_DBG("%s count %d", hu->hdev->name, count);
+	BT_DBG("%s pending %zu count %d", hu->hdev->name, h5->rx_pending,
+	       count);
 
 	while (count > 0) {
 		int processed;
-- 
1.7.10.4

