Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amit K Bag <amit.k.bag@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: sukumar.ghorai@intel.com, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH] Bluetooth: btusb: Avoid race condition during controller recovery
Date: Wed,  6 Jun 2018 11:52:48 +0530
Message-Id: <1528266168-10351-1-git-send-email-amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chethan T N <chethan.tumkur.narayan@intel.com>

Observed race condition during controller recovery mechanism
resulting the controller not responding to the reset command.

To avoid such race condition need a delay of 2ms soon after the
USB re-enumeration and before sending the Reset command which shall
allow controller to completely recover and process the Reset command.

BUG=b:64035404
TEST=Magic tethering, P0 and P1 santiy test cases, kernel-boot log

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 drivers/bluetooth/btusb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f73a27ea28cc..2303ac037240 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1743,6 +1743,15 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	/* Observed race condition during controller recovery mechanism
+	 * resulting the controller not responding to the reset command.
+	 *
+	 * To avoid such race condition need a delay of 2ms soon after the
+	 * USB re-enumeration and before sending the Reset command which shall
+	 * allow controller to completely recover and process the Reset command.
+	 */
+	mdelay(5);
+
 	/* The controller has a bug with the first HCI command sent to it
 	 * returning number of completed commands as zero. This would stall the
 	 * command processing in the Bluetooth core.
-- 
2.7.4

