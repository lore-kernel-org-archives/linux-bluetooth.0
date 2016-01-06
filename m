Return-Path: <root@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <marcel@holtmann.org>,
        Chin-Ran Lo
	<crlo@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH 2/2] Bluetooth: btmrvl: don't send data to firmware while processing suspend
Date: Wed, 6 Jan 2016 06:34:38 -0800
Message-ID: <1452090878-19586-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1452090878-19586-1-git-send-email-akarwar@marvell.com>
References: <1452090878-19586-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chin-Ran Lo <crlo@marvell.com>

Usually when driver sends data to firmware it receives TX_DONE
(DN_LD_HOST_INT_STATUS) interrupt from firmware right away.
It's also observed that some times the fireware could delay
sending DN_LD_HOST_INT_STATUS interrupt. If driver sends data to
firmware during suspend processing and the TX_DONE interrupt is
delayed, it may come back at wrong time when SDIO host driver is
in the middle of suspending.

Block any data from stack while suspending. Also skip sending
data that are already in driver tx_queue.

Don't purge the skb queue on suspend to avoid intermittent music
after system resumes from S3.

Signed-off-by: Chin-Ran Lo <crlo@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_drv.h  |  1 +
 drivers/bluetooth/btmrvl_main.c | 11 +++++++++--
 drivers/bluetooth/btmrvl_sdio.c |  3 ++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 27a9aac..0590473 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -89,6 +89,7 @@ struct btmrvl_adapter {
 	wait_queue_head_t event_hs_wait_q;
 	u8 cmd_complete;
 	bool is_suspended;
+	bool is_suspending;
 };
 
 struct btmrvl_private {
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index b2a567b..f25a825 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -436,6 +436,11 @@ static int btmrvl_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("type=%d, len=%d", hci_skb_pkt_type(skb), skb->len);
 
+	if (priv->adapter->is_suspending || priv->adapter->is_suspended) {
+		BT_ERR("%s: Device is suspending or suspended", __func__);
+		return -EBUSY;
+	}
+
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
 		hdev->stat.cmd_tx++;
@@ -452,7 +457,8 @@ static int btmrvl_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	skb_queue_tail(&priv->adapter->tx_queue, skb);
 
-	wake_up_interruptible(&priv->main_thread.wait_q);
+	if (!priv->adapter->is_suspended)
+		wake_up_interruptible(&priv->main_thread.wait_q);
 
 	return 0;
 }
@@ -643,7 +649,8 @@ static int btmrvl_service_main_thread(void *data)
 		if (adapter->ps_state == PS_SLEEP)
 			continue;
 
-		if (!priv->btmrvl_dev.tx_dnld_rdy)
+		if (!priv->btmrvl_dev.tx_dnld_rdy ||
+		    priv->adapter->is_suspended)
 			continue;
 
 		skb = skb_dequeue(&adapter->tx_queue);
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 73a1c27..6ed8acf 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1545,10 +1545,10 @@ static int btmrvl_sdio_suspend(struct device *dev)
 	}
 
 	priv = card->priv;
+	priv->adapter->is_suspending = true;
 	hcidev = priv->btmrvl_dev.hcidev;
 	BT_DBG("%s: SDIO suspend", hcidev->name);
 	hci_suspend_dev(hcidev);
-	skb_queue_purge(&priv->adapter->tx_queue);
 
 	if (priv->adapter->hs_state != HS_ACTIVATED) {
 		if (btmrvl_enable_hs(priv)) {
@@ -1557,6 +1557,7 @@ static int btmrvl_sdio_suspend(struct device *dev)
 		}
 	}
 
+	priv->adapter->is_suspending = false;
 	priv->adapter->is_suspended = true;
 
 	/* We will keep the power when hs enabled successfully */
-- 
1.8.1.4
