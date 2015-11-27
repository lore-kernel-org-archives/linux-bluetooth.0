Return-Path: <loic.poulain@intel.com>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH 4/5] Bluetooth: hci_intel: Enter manufacturing mode if requested
Date: Fri, 27 Nov 2015 19:56:02 +0100
Message-Id: <1448650563-9075-4-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1448650563-9075-1-git-send-email-loic.poulain@intel.com>
References: <1448650563-9075-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

LhP controller only sends manufacturing error if not correctly
configured (after first boot), nothing else.
In order to avoid a read intel version command timeout due to missing
command complete event, inject the event with an error status.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_intel.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 98beacb..95bc57c 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -49,6 +49,7 @@
 #define STATE_TX_ACTIVE		6
 #define STATE_SUSPENDED		7
 #define STATE_LPM_TRANSACTION	8
+#define STATE_REQ_MANUFACTURING	9
 
 #define HCI_LPM_WAKE_PKT 0xf0
 #define HCI_LPM_PKT 0xf1
@@ -889,6 +890,7 @@ no_lpm:
 
 static int intel_setup(struct hci_uart *hu)
 {
+	static const u8 mfg_enable[] = { 0x01, 0x00 };
 	struct intel_data *intel = hu->priv;
 	struct hci_dev *hdev = hu->hdev;
 	struct sk_buff *skb;
@@ -911,6 +913,7 @@ static int intel_setup(struct hci_uart *hu)
 
 	set_bit(STATE_BOOTLOADER, &intel->flags);
 
+setup:
 	/* Read the Intel version information to determine if the device
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
@@ -919,6 +922,21 @@ static int intel_setup(struct hci_uart *hu)
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
+
+		/* Command has failed because controller requests manufacturing.
+		 * Enable manufacturing mode and try again.
+		 */
+		if (test_and_clear_bit(STATE_REQ_MANUFACTURING, &intel->flags)) {
+			bt_dev_info(hdev, "Enable Manufacturing and try again");
+
+			skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(mfg_enable),
+					     mfg_enable, HCI_CMD_TIMEOUT);
+			if (!IS_ERR(skb)) {
+				kfree_skb(skb);
+				goto setup;
+			}
+		}
+
 		return PTR_ERR(skb);
 	}
 
@@ -1009,6 +1027,19 @@ static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 			smp_mb__after_atomic();
 			wake_up_bit(&intel->flags, STATE_BOOTING);
 		}
+
+	/* After booting, the LhP controller requests manufacturing and does
+	 * not respond to HCI command with a HCI command complete event but with
+	 * a Intel manufacturing error event. In that case, inject the command
+	 * complete event with manufacturing error as status. This should only
+	 * happens with the read intel version cmd (0xfc05) which is always the
+	 * first command sent to the controller.
+	 */
+	} else if (skb->len >= 4 && hdr->evt == 0xff && hdr->plen >= 2 &&
+		   skb->data[2] == 0x05 && skb->data[3] == 0x02) {
+		bt_dev_err(hdev, "Controller requests manufacturing");
+		set_bit(STATE_REQ_MANUFACTURING, &intel->flags);
+		inject_cmd_complete(hdev, 0xfc05, 0x01);
 	}
 recv:
 	return hci_recv_frame(hdev, skb);
-- 
1.9.1
