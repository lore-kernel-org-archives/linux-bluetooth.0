Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amit K Bag <amit.k.bag@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: sukumar.ghorai@intel.com, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com
Subject: [PATCH] Bluetooth: btusb: Avoid race condition during controller recovery
Date: Thu, 31 May 2018 15:20:13 +0530
Message-Id: <1527760213-8877-1-git-send-email-amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chethan T N <chethan.tumkur.narayan@intel.com>

Observed race condition during controller recovery mechanism
resulting the controller not responding to the reset command.

To avoid such race condition need a delay of 2ms soon after the
USB re-enumeration and before sending the Reset command which shall
allow controller to completely recover and process the Reset command.

Change-Id: Ifbc387d4377bc79081244d444d45ba6effc95f23
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
---
 drivers/bluetooth/btusb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f73a27ea28cc..844b4145ff76 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1741,6 +1741,15 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	int disable_patch, err;
 	struct intel_version ver;
 
+	/* Observed race condition during controller recovery mechanism
+	 * resulting the controller not responding to the reset command.
+	 *
+	 * To avoid such race condition need a delay of 2ms soon after the
+	 * USB re-enumeration and before sending the Reset command which shall
+	 * allow controller to completely recover and process the Reset command.
+	 */
+	mdelay(2);
+
 	BT_DBG("%s", hdev->name);
 
 	/* The controller has a bug with the first HCI command sent to it
-- 
2.7.4

