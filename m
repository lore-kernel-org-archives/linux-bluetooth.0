Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, johan.hedberg@intel.com,
	Petri Gynther <pgynther@google.com>
Subject: [PATCH] Bluetooth: btbcm: Fix handling of firmware not found
Date: Wed, 10 Feb 2016 12:00:46 -0800
Message-Id: <1455134446-70401-1-git-send-email-pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the call to request_firmware() fails in btbcm_setup_patchram(),
the BCM chip will be operating with its default firmware.

In this case, btbcm_setup_patchram() should not return immediately
but instead should skip to btbcm_check_bdaddr() and quirk setup.

Signed-off-by: Petri Gynther <pgynther@google.com>
---
 drivers/bluetooth/btbcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 0b69794..7d82b1a 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -467,7 +467,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	err = request_firmware(&fw, fw_name, &hdev->dev);
 	if (err < 0) {
 		BT_INFO("%s: BCM: Patch %s not found", hdev->name, fw_name);
-		return 0;
+		goto check_bdaddr;
 	}
 
 	btbcm_patchram(hdev, fw);
@@ -501,6 +501,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	BT_INFO("%s: %s", hdev->name, (char *)(skb->data + 1));
 	kfree_skb(skb);
 
+check_bdaddr:
 	btbcm_check_bdaddr(hdev);
 
 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
-- 
2.7.0.rc3.207.g0ac5344

