Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <patila@marvell.com>, Cathy Luo <cluo@marvell.com>,
        Marc Yang <yangyang@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH 3/4] Bluetooth: btmrvl: add surprise_removed flag
Date: Wed, 31 Dec 2014 03:14:01 -0800
Message-ID: <1420024442-12137-3-git-send-email-akarwar@marvell.com>
In-Reply-To: <1420024442-12137-1-git-send-email-akarwar@marvell.com>
References: <1420024442-12137-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This flag will be set in unload path to make sure that we skip
sending further commands, ignore interrupts and stop main thread
when unload starts.

Signed-off-by: Cathy Luo <cluo@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_drv.h  | 1 +
 drivers/bluetooth/btmrvl_main.c | 9 +++++++--
 drivers/bluetooth/btmrvl_sdio.c | 4 ++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 330f8f8..5513204 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -104,6 +104,7 @@ struct btmrvl_private {
 #ifdef CONFIG_DEBUG_FS
 	void *debugfs_data;
 #endif
+	bool surprise_removed;
 };
 
 #define MRVL_VENDOR_PKT			0xFE
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index c435b58..c4a542c 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -178,6 +178,11 @@ static int btmrvl_send_sync_cmd(struct btmrvl_private *priv, u16 opcode,
 	struct sk_buff *skb;
 	struct hci_command_hdr *hdr;
 
+	if (priv->surprise_removed) {
+		BT_ERR("Card is removed");
+		return -EFAULT;
+	}
+
 	skb = bt_skb_alloc(HCI_COMMAND_HDR_SIZE + len, GFP_ATOMIC);
 	if (skb == NULL) {
 		BT_ERR("No free skb");
@@ -600,7 +605,7 @@ static int btmrvl_service_main_thread(void *data)
 		add_wait_queue(&thread->wait_q, &wait);
 
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (kthread_should_stop()) {
+		if (kthread_should_stop() || priv->surprise_removed) {
 			BT_DBG("main_thread: break from main thread");
 			break;
 		}
@@ -619,7 +624,7 @@ static int btmrvl_service_main_thread(void *data)
 
 		BT_DBG("main_thread woke up");
 
-		if (kthread_should_stop()) {
+		if (kthread_should_stop() || priv->surprise_removed) {
 			BT_DBG("main_thread: break from main thread");
 			break;
 		}
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 0057c0b..80ec200 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -798,6 +798,9 @@ static void btmrvl_sdio_interrupt(struct sdio_func *func)
 
 	priv = card->priv;
 
+	if (priv->surprise_removed)
+		return;
+
 	if (card->reg->int_read_to_clear)
 		ret = btmrvl_sdio_read_to_clear(card, &ireg);
 	else
@@ -1466,6 +1469,7 @@ static void btmrvl_sdio_remove(struct sdio_func *func)
 				btmrvl_sdio_disable_host_int(card);
 			}
 			BT_DBG("unregester dev");
+			card->priv->surprise_removed = true;
 			btmrvl_sdio_unregister_dev(card);
 			btmrvl_remove_card(card->priv);
 		}
-- 
1.8.1.4
