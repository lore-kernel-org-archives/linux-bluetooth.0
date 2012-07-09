Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btmrvl: trivial style fixes
Date: Mon,  9 Jul 2012 13:57:18 +0300
Message-Id: <1341831438-19517-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20120630152856.GE1920@joana>
References: <20120630152856.GE1920@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Patch shortens locals scope and adds missing braces. This is a diff
between v1 which was applied and v2 of patch "Bluetooth: btmrvl: Do
not send vendor events to bluetooth stack".

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 drivers/bluetooth/btmrvl_main.c |    8 +++++---
 drivers/bluetooth/btmrvl_sdio.c |    3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index dc304de..3a4343b 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -47,10 +47,11 @@ EXPORT_SYMBOL_GPL(btmrvl_interrupt);
 bool btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *) skb->data;
-	struct hci_ev_cmd_complete *ec;
-	u16 opcode, ocf, ogf;
 
 	if (hdr->evt == HCI_EV_CMD_COMPLETE) {
+		struct hci_ev_cmd_complete *ec;
+		u16 opcode, ocf, ogf;
+
 		ec = (void *) (skb->data + HCI_EVENT_HDR_SIZE);
 		opcode = __le16_to_cpu(ec->opcode);
 		ocf = hci_opcode_ocf(opcode);
@@ -64,7 +65,8 @@ bool btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb)
 		}
 
 		if (ogf == OGF) {
-			BT_DBG("vendor event skipped: ogf 0x%4.4x", ogf);
+			BT_DBG("vendor event skipped: ogf 0x%4.4x ocf 0x%4.4x",
+			       ogf, ocf);
 			kfree_skb(skb);
 			return false;
 		}
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index cf7588ed..6a9e971 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -568,8 +568,9 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 		if (type == HCI_EVENT_PKT) {
 			if (btmrvl_check_evtpkt(priv, skb))
 				hci_recv_frame(skb);
-		} else
+		} else {
 			hci_recv_frame(skb);
+		}
 
 		hdev->stat.byte_rx += buf_len;
 		break;
-- 
1.7.9.5

