Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amit K Bag <amit.k.bag@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH v2] Bluetooth: btusb: Release RF resource on BT shutdown
Date: Fri,  3 Aug 2018 12:43:20 +0530
Message-Id: <1533280400-11760-1-git-send-email-amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Issue description: Intel 7265 shares the same RF with Wifi and BT.
In the shutdown scenario turn off BT, followed by turn WiFi off
and on causing error in RF calibration in WiFi Module

Solution: before shutdown BT ensure any RF activity to clear by
HCI reset command.

Reference Logs:
ERR kernel: [ 386.193284] iwlwifi 0000:01:00.0: Failed to run INIT calibrations: -5
ERR kernel: [ 386.193298] iwlwifi 0000:01:00.0: Failed to run INIT ucode: -5
ERR kernel: [ 386.193309] iwlwifi 0000:01:00.0: Failed to start RT ucode: -5

Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
Singed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
---
 drivers/bluetooth/btusb.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 572fd75fbcf6..fcb31f20536d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2369,6 +2369,23 @@ static int btusb_shutdown_intel(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	long ret;
 
+	/* In the shutdown sequence where Bluetooth is turned off followed
+	 * by WiFi being turned off, turning WiFi back on causes issue with
+	 * the RF calibration.
+	 *
+	 * To ensure that any RF activity has been stopped, issue HCI Reset
+	 * command to clear all ongoing activity including advertising,
+	 * scanning etc.
+	 */
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		bt_dev_err(hdev, "HCI reset on shutdown failed");
+		return ret;
+	}
+	kfree_skb(skb);
+
 	/* Some platforms have an issue with BT LED when the interface is
 	 * down or BT radio is turned off, which takes 5 seconds to BT LED
 	 * goes off. This command turns off the BT LED immediately.
-- 
2.7.4

