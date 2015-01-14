Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix issue with switching BR/EDR back on when disabled
Date: Wed, 14 Jan 2015 14:40:42 -0800
Message-Id: <1421275242-18674-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For dual-mode controllers it is possible to disable BR/EDR and operate
as LE single mode controllers with a static random address. If that is
the case, then refuse switching BR/EDR back on after the controller has
been powered.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e531da805923..cae612658ba9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4683,6 +4683,21 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		err = cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
 				 MGMT_STATUS_REJECTED);
 		goto unlock;
+	} else {
+		/* When configuring a dual-mode controller to operate
+		 * with LE only and using a static address, then switching
+		 * BR/EDR back on is not allowed.
+		 *
+		 * Dual-mode controllers shall operate with the public
+		 * address as its identity address for BR/EDR and LE. So
+		 * reject the attempt to create an invalid configuration.
+		 */
+		if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
+		    bacmp(&hdev->static_addr, BDADDR_ANY)) {
+			err = cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
+					 MGMT_STATUS_REJECTED);
+			goto unlock;
+		}
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_BREDR, hdev)) {
-- 
2.1.0

