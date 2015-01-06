Return-Path: <cyrus@holtmann.org>
From: Tristan Lelong <tristan@lelong.xyz>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Tristan Lelong <tristan@lelong.xyz>
Subject: [PATCH v2 2/2] bcsp: Change tx window size in configuration
Date: Mon,  5 Jan 2015 23:17:46 -0800
Message-Id: <1420528666-4846-3-git-send-email-tristan@lelong.xyz>
In-Reply-To: <1420528666-4846-1-git-send-email-tristan@lelong.xyz>
References: <1420528666-4846-1-git-send-email-tristan@lelong.xyz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch make the TX window size configurable using the kernel configuration interface
or a module parameter: txwin.
The default value used is the previous value: 4

Signed-off-by: Tristan Lelong <tristan@lelong.xyz>
---
 drivers/bluetooth/Kconfig    | 18 ++++++++++++++++++
 drivers/bluetooth/hci_bcsp.c | 10 ++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 364f080..3204ac6 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -59,6 +59,24 @@ config BT_HCIUART_BCSP
 
 	  Say Y here to compile support for HCI BCSP protocol.
 
+config BT_HCIUART_BCSP_WINSIZE
+	int "BCSP reliable packet TX window size"
+	default 4
+	depends on BT_HCIUART_BCSP
+	help
+	  The BCSP stack handles packet retransmission and acknowledgment.
+	  For this it is tagging every packet with a sequence id coded
+	  on 3 bits, and uses uses a ack to tell the other endpoint what is
+	  the next expected packet.  As soon as the number of non-ack'd
+	  messages is equal to the TX window, the stack will put all
+	  following packets on hold until the other endpoint sends an ack.
+
+	  This parameter defines the size of the transmit window size,
+	  thus, the number of consecutive messages that can be sent
+	  without being acked.
+
+	  This can also be configured at runtime using txwin module param.
+
 config BT_HCIUART_ATH3K
 	bool "Atheros AR300x serial support"
 	depends on BT_HCIUART
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 2685ab9..7d9aa1d 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -54,14 +54,13 @@
 
 static bool txcrc = 1;
 static bool hciextn = 1;
+static char txwin = CONFIG_BT_HCIUART_BCSP_WINSIZE;
 
 static const u8 conf_pkt[4]     = { 0xad, 0xef, 0xac, 0xed };
 static const u8 conf_rsp_pkt[4] = { 0xde, 0xad, 0xd0, 0xd0 };
 static const u8 sync_pkt[4]     = { 0xda, 0xdc, 0xed, 0xed };
 static const u8 sync_rsp_pkt[4] = { 0xac, 0xaf, 0xef, 0xee };
 
-#define BCSP_TXWINSIZE	4
-
 #define BCSP_PKT_LEN(data)	((data[1] >> 4) + (data[2]))
 #define BCSP_LE_PKT_LEN	0x04
 
@@ -335,7 +334,7 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 
 	spin_lock_irqsave_nested(&bcsp->unack.lock, flags, SINGLE_DEPTH_NESTING);
 
-	if (bcsp->unack.qlen < BCSP_TXWINSIZE) {
+	if (bcsp->unack.qlen < txwin) {
 		skb = skb_dequeue(&bcsp->rel);
 		if (skb != NULL) {
 			struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len,
@@ -428,7 +427,7 @@ static void bcsp_pkt_cull(struct hci_uart *hu)
 	/* Some reliable packets might be queued in ack queue,
 	 * but not sent since the tx window was full.
 	 * try to process them now. */
-	if (bcsp->unack.qlen < BCSP_TXWINSIZE)
+	if (bcsp->unack.qlen < txwin)
 		if (skb_queue_len(&bcsp->rel))
 			hci_uart_tx_wakeup(hu);
 
@@ -901,3 +900,6 @@ MODULE_PARM_DESC(txcrc, "Transmit CRC with every BCSP packet");
 
 module_param(hciextn, bool, 0644);
 MODULE_PARM_DESC(hciextn, "Convert HCI Extensions into BCSP packets");
+
+module_param(txwin, byte, 0644);
+MODULE_PARM_DESC(txwin, "Change TX window size.");
-- 
2.1.3

