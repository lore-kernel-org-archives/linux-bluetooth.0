Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Explicitly clear EIR data upon hci_dev setup
Date: Wed, 22 Feb 2012 16:02:43 +0200
Message-Id: <1329919363-23660-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329919363-23660-1-git-send-email-johan.hedberg@gmail.com>
References: <1329919363-23660-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Some controllers preserve their EIR data even after a reset so we need
to explicitly clear this during the device setup procedure.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 240dc16..3476d5c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -557,10 +557,19 @@ static void hci_setup(struct hci_dev *hdev)
 	if (hdev->hci_ver > BLUETOOTH_VER_1_1)
 		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
 
-	if (hdev->features[6] & LMP_SIMPLE_PAIR &&
-				test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
-		u8 mode = 0x01;
-		hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, sizeof(mode), &mode);
+	if (hdev->features[6] & LMP_SIMPLE_PAIR) {
+		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
+			u8 mode = 0x01;
+			hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE,
+							sizeof(mode), &mode);
+		} else {
+			struct hci_cp_write_eir cp;
+
+			memset(hdev->eir, 0, sizeof(hdev->eir));
+			memset(&cp, 0, sizeof(cp));
+
+			hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
+		}
 	}
 
 	if (hdev->features[3] & LMP_RSSI_INQ)
-- 
1.7.9

