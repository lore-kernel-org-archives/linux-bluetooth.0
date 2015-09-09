Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: Bluetooth: hci_intel: Give priority to LPM packets
Date: Wed,  9 Sep 2015 19:08:02 +0200
Message-Id: <1441818482-16357-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change the way to insert LPM packets into the txq.
Use skb_queue_head instead of skb_queue_tail to always prioritise LPM
packets over potential tx queue content.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_intel.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 3314823..21f339f 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -190,7 +190,8 @@ static int intel_lpm_suspend(struct hci_uart *hu)
 
 	set_bit(STATE_LPM_TRANSACTION, &intel->flags);
 
-	skb_queue_tail(&intel->txq, skb);
+	/* LPM flow is a priority, enqueue packet at list head */
+	skb_queue_head(&intel->txq, skb);
 	hci_uart_tx_wakeup(hu);
 
 	intel_wait_lpm_transaction(hu);
@@ -233,7 +234,8 @@ static int intel_lpm_resume(struct hci_uart *hu)
 
 	set_bit(STATE_LPM_TRANSACTION, &intel->flags);
 
-	skb_queue_tail(&intel->txq, skb);
+	/* LPM flow is a priority, enqueue packet at list head */
+	skb_queue_head(&intel->txq, skb);
 	hci_uart_tx_wakeup(hu);
 
 	intel_wait_lpm_transaction(hu);
@@ -272,7 +274,8 @@ static int intel_lpm_host_wake(struct hci_uart *hu)
 	       sizeof(lpm_resume_ack));
 	bt_cb(skb)->pkt_type = HCI_LPM_PKT;
 
-	skb_queue_tail(&intel->txq, skb);
+	/* LPM flow is a priority, enqueue packet at list head */
+	skb_queue_head(&intel->txq, skb);
 	hci_uart_tx_wakeup(hu);
 
 	bt_dev_dbg(hu->hdev, "Resumed by controller");
-- 
1.9.1

