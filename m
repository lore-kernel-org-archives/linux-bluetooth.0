Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] Bluetooth: btmrvl: Do not send vendor events to bluetooth stack
Date: Fri, 15 Jun 2012 09:10:54 +0300
Message-Id: <1339740654-5930-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <477F20668A386D41ADCC57781B1F7043083A8A6E5F@SC-VEXCH1.marvell.com>
References: <477F20668A386D41ADCC57781B1F7043083A8A6E5F@SC-VEXCH1.marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Vendor-specific events shall be processed in driver and not sent
to bluetooth stack where they screw up HCI command countings.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Tested-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/btmrvl_drv.h  |    2 +-
 drivers/bluetooth/btmrvl_main.c |   18 +++++++++++++++---
 drivers/bluetooth/btmrvl_sdio.c |    9 ++++++---
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 94f2d65..27068d1 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -136,7 +136,7 @@ int btmrvl_remove_card(struct btmrvl_private *priv);
 
 void btmrvl_interrupt(struct btmrvl_private *priv);
 
-void btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb);
+bool btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb);
 int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb);
 
 int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, int subcmd);
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 681ca9d..3a4343b 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -44,23 +44,35 @@ void btmrvl_interrupt(struct btmrvl_private *priv)
 }
 EXPORT_SYMBOL_GPL(btmrvl_interrupt);
 
-void btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb)
+bool btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *) skb->data;
-	struct hci_ev_cmd_complete *ec;
-	u16 opcode, ocf;
 
 	if (hdr->evt == HCI_EV_CMD_COMPLETE) {
+		struct hci_ev_cmd_complete *ec;
+		u16 opcode, ocf, ogf;
+
 		ec = (void *) (skb->data + HCI_EVENT_HDR_SIZE);
 		opcode = __le16_to_cpu(ec->opcode);
 		ocf = hci_opcode_ocf(opcode);
+		ogf = hci_opcode_ogf(opcode);
+
 		if (ocf == BT_CMD_MODULE_CFG_REQ &&
 					priv->btmrvl_dev.sendcmdflag) {
 			priv->btmrvl_dev.sendcmdflag = false;
 			priv->adapter->cmd_complete = true;
 			wake_up_interruptible(&priv->adapter->cmd_wait_q);
 		}
+
+		if (ogf == OGF) {
+			BT_DBG("vendor event skipped: ogf 0x%4.4x ocf 0x%4.4x",
+			       ogf, ocf);
+			kfree_skb(skb);
+			return false;
+		}
 	}
+
+	return true;
 }
 EXPORT_SYMBOL_GPL(btmrvl_check_evtpkt);
 
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 3b9a8a3..e602cbd 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -565,10 +565,13 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 		skb_put(skb, buf_len);
 		skb_pull(skb, SDIO_HEADER_LEN);
 
-		if (type == HCI_EVENT_PKT)
-			btmrvl_check_evtpkt(priv, skb);
+		if (type == HCI_EVENT_PKT) {
+			if (btmrvl_check_evtpkt(priv, skb))
+				hci_recv_frame(skb);
+		} else {
+			hci_recv_frame(skb);
+		}
 
-		hci_recv_frame(skb);
 		hdev->stat.byte_rx += buf_len;
 		break;
 
-- 
1.7.9.5

