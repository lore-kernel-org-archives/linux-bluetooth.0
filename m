Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix validating IO capability values in mgmt commands
Date: Tue, 17 Jun 2014 15:14:48 +0300
Message-Id: <1403007288-7152-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The valid range of IO capabilities for the Set IO Capability and Pair
Device mgmt commands is 0-4 (4 being the KeyboarDisplay capability for
SMP). We should return an invalid parameters error if user space gives
us a value outside of this range.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 99eb845865ef..5bf032d9bce1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2766,6 +2766,10 @@ static int set_io_capability(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("");
 
+	if (cp->io_capability > SMP_IO_KEYBOARD_DISPLAY)
+		return cmd_complete(sk, hdev->id, MGMT_OP_SET_IO_CAPABILITY,
+				    MGMT_STATUS_INVALID_PARAMS, NULL, 0);
+
 	hci_dev_lock(hdev);
 
 	hdev->io_capability = cp->io_capability;
@@ -2878,6 +2882,11 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 				    MGMT_STATUS_INVALID_PARAMS,
 				    &rp, sizeof(rp));
 
+	if (cp->io_cap > SMP_IO_KEYBOARD_DISPLAY)
+		return cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
+				    MGMT_STATUS_INVALID_PARAMS,
+				    &rp, sizeof(rp));
+
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-- 
1.9.3

