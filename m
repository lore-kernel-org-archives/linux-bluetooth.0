Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/4] Bluetooth: btusb: Fix calls to __hci_cmd_sync()
Date: Fri, 15 May 2015 11:58:40 +0200
Message-Id: <1431683922-20418-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1431683922-20418-1-git-send-email-frederic.danis@linux.intel.com>
References: <1431683922-20418-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove test of command reply status as it is already performed by
__hci_cmd_sync().

__hci_cmd_sync_ev() function already returns an error if it got a
non-zero status either through a Command Complete or a Command
Status event.

For both of these events the status is collected up in the event
handlers called by hci_event_packet() and then passed as the second
parameter to req_complete_skb(). The req_complete_skb() callback in
turn is hci_req_sync_complete() for __hci_cmd_sync_ev() which stores
the status in hdev->req_result. The hdev->req_result is then further
converted through bt_to_errno() back in __hci_cmd_sync_ev().

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/btusb.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index df87016..b9f2821 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1577,12 +1577,6 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	}
 
 	ver = (struct intel_version *)skb->data;
-	if (ver->status) {
-		BT_ERR("%s Intel fw version event failed (%02x)", hdev->name,
-		       ver->status);
-		kfree_skb(skb);
-		return -bt_to_errno(ver->status);
-	}
 
 	BT_INFO("%s: read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
 		hdev->name, ver->hw_platform, ver->hw_variant,
@@ -1630,15 +1624,6 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 		return PTR_ERR(skb);
 	}
 
-	if (skb->data[0]) {
-		u8 evt_status = skb->data[0];
-
-		BT_ERR("%s enable Intel manufacturer mode event failed (%02x)",
-		       hdev->name, evt_status);
-		kfree_skb(skb);
-		release_firmware(fw);
-		return -bt_to_errno(evt_status);
-	}
 	kfree_skb(skb);
 
 	disable_patch = 1;
@@ -1984,13 +1969,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	}
 
 	ver = (struct intel_version *)skb->data;
-	if (ver->status) {
-		BT_ERR("%s: Intel version command failure (%02x)",
-		       hdev->name, ver->status);
-		err = -bt_to_errno(ver->status);
-		kfree_skb(skb);
-		return err;
-	}
 
 	/* The hardware platform number has a fixed value of 0x37 and
 	 * for now only accept this single value.
@@ -2065,13 +2043,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	}
 
 	params = (struct intel_boot_params *)skb->data;
-	if (params->status) {
-		BT_ERR("%s: Intel boot parameters command failure (%02x)",
-		       hdev->name, params->status);
-		err = -bt_to_errno(params->status);
-		kfree_skb(skb);
-		return err;
-	}
 
 	BT_INFO("%s: Device revision is %u", hdev->name,
 		le16_to_cpu(params->dev_revid));
@@ -2304,13 +2275,6 @@ static void btusb_hw_error_intel(struct hci_dev *hdev, u8 code)
 		return;
 	}
 
-	if (skb->data[0] != 0x00) {
-		BT_ERR("%s: Exception info command failure (%02x)",
-		       hdev->name, skb->data[0]);
-		kfree_skb(skb);
-		return;
-	}
-
 	BT_ERR("%s: Exception info %s", hdev->name, (char *)(skb->data + 1));
 
 	kfree_skb(skb);
-- 
1.9.1

