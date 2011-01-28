Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH] Bluetooth: Support SCO over HCI for Atheros AR300x Bluetooth device
Date: Fri, 28 Jan 2011 16:19:04 +0530
Message-ID: <1296211744-2487-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds SCO over HCI support to Atheros AR300x HCI transport
driver.

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 drivers/bluetooth/hci_ath.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 6a160c1..161bd20 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -162,11 +162,6 @@ static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 {
 	struct ath_struct *ath = hu->priv;
 
-	if (bt_cb(skb)->pkt_type == HCI_SCODATA_PKT) {
-		kfree_skb(skb);
-		return 0;
-	}
-
 	/*
 	 * Update power management enable flag with parameters of
 	 * HCI sleep enable vendor specific HCI command.
@@ -183,10 +178,15 @@ static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	/* Prepend skb with frame type */
 	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
 
-	skb_queue_tail(&ath->txq, skb);
-	set_bit(HCI_UART_SENDING, &hu->tx_state);
-
-	schedule_work(&ath->ctxtsw);
+	if (bt_cb(skb)->pkt_type == HCI_SCODATA_PKT) {
+		skb_queue_head(&ath->txq, skb);
+		clear_bit(HCI_UART_SENDING, &hu->tx_state);
+		hci_uart_tx_wakeup(hu);
+	} else {
+		skb_queue_tail(&ath->txq, skb);
+		set_bit(HCI_UART_SENDING, &hu->tx_state);
+		schedule_work(&ath->ctxtsw);
+	}
 
 	return 0;
 }
-- 
1.7.0.4

