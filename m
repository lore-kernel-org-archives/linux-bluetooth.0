Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Gracefully response to enabling LE on LE only devices
Date: Wed, 18 Mar 2015 16:15:07 -0700
Message-Id: <1426720507-28458-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently the enabling of LE on LE only devices causes an error. This
is a bit difference from other commands where trying to set the same
existing settings causes a positive response. Fix this behavior for
this single corner case.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f3a957905193..cee9bc9735af 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2209,10 +2209,22 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
 				       MGMT_STATUS_INVALID_PARAMS);
 
-	/* LE-only devices do not allow toggling LE on/off */
-	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+	/* Bluetooth single mode LE only controllers or dual-mode
+	 * controllers configured as LE only devices, do not allow
+	 * switching LE off. These have either LE enabled explicitly
+	 * or BR/EDR has been previously switched off.
+	 *
+	 * When trying to enable an already enabled LE, then gracefully
+	 * send a positive response. Trying to disable it however will
+	 * result into rejection.
+	 */
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
+		if (cp->val == 0x01)
+			return send_settings_rsp(sk, MGMT_OP_SET_LE, hdev);
+
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
 				       MGMT_STATUS_REJECTED);
+	}
 
 	hci_dev_lock(hdev);
 
-- 
2.1.0

