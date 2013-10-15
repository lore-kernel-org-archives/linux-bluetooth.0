Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for entering limited discoverable mode
Date: Tue, 15 Oct 2013 09:13:39 -0700
Message-Id: <1381853619-42234-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The limited discoverable mode should be used when a device is only
discoverable for a certain amount of time and after that it returns
back into being non-discoverable.

This adds another option to the set discoverable management command
to clearly distinguish limited discoverable from general discoverable
mode.

While the general discoverable mode can be set with a specific
timeout or as permanent setting, the limited discoverable mode
requires a timeout. The timeout is flexible and the kernel will
not enforce any specific limitations. That GAP part of this is
required by userspace to enforce according to the Bluetooth core
specification.

Devices in limited discoverable mode can still be found by the
general discovery procedure. It is mandatory that a device sets
both GIAC and LIAC when entering limited discoverable mode.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c |  8 ++++++
 net/bluetooth/mgmt.c     | 67 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a49ca48..7a3d179 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1282,6 +1282,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		cancel_delayed_work(&hdev->discov_off);
 		hdev->discov_timeout = 0;
 		clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
 	}
 
 	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
@@ -1717,6 +1718,13 @@ static void hci_discov_off(struct work_struct *work)
 	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
 	hci_req_run(&req, NULL);
 
+	/* When discoverable timeout triggers, then just make sure
+	 * the limited discoverable flag is cleared. Even in the case
+	 * of a timeout triggered from general discoverable, it is
+	 * safe to unconditionally clear the flag.
+	 */
+	clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+
 	hdev->discov_timeout = 0;
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1d608ca..c700940 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1039,6 +1039,7 @@ static void set_discoverable_complete(struct hci_dev *hdev, u8 status)
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
 		cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
+		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
 		goto remove_cmd;
 	}
 
@@ -1094,12 +1095,17 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
 				  status);
 
-	if (cp->val != 0x00 && cp->val != 0x01)
+	if (cp->val != 0x00 && cp->val != 0x01 && cp->val != 0x02)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
 				  MGMT_STATUS_INVALID_PARAMS);
 
 	timeout = __le16_to_cpu(cp->timeout);
-	if (!cp->val && timeout > 0)
+
+	/* Disabling discoverable requires that no timeout is set,
+	 * and enabling limited discoverable requires a timeout.
+	 */
+	if ((cp->val == 0x00 && timeout > 0) ||
+	    (cp->val == 0x02 && timeout == 0))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
 				  MGMT_STATUS_INVALID_PARAMS);
 
@@ -1127,6 +1133,10 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (!hdev_is_powered(hdev)) {
 		bool changed = false;
 
+		/* Setting limited discoverable when powered off is
+		 * not a valid operation since it requires a timeout
+		 * and so no need to check HCI_LIMITED_DISCOVERABLE.
+		 */
 		if (!!cp->val != test_bit(HCI_DISCOVERABLE, &hdev->dev_flags)) {
 			change_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
 			changed = true;
@@ -1142,7 +1152,13 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (!!cp->val == test_bit(HCI_DISCOVERABLE, &hdev->dev_flags)) {
+	/* If the current mode is the same, then just update the timeout
+	 * value with the new value. And if only the timeout gets updated,
+	 * then no need for any HCI transactions.
+	 */
+	if (!!cp->val == test_bit(HCI_DISCOVERABLE, &hdev->dev_flags) &&
+	    (cp->val == 0x02) == test_bit(HCI_LIMITED_DISCOVERABLE,
+					  &hdev->dev_flags)) {
 		cancel_delayed_work(&hdev->discov_off);
 		hdev->discov_timeout = timeout;
 
@@ -1162,24 +1178,55 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
+	/* Cancel any potential discoverable timeout that might be
+	 * still active and store new timeout value. The arming of
+	 * the timeout happens in the complete handler.
+	 */
+	cancel_delayed_work(&hdev->discov_off);
+	hdev->discov_timeout = timeout;
+
 	hci_req_init(&req, hdev);
 
 	scan = SCAN_PAGE;
 
-	if (cp->val)
+	if (cp->val) {
+		struct hci_cp_write_current_iac_lap hci_cp;
+
+		if (cp->val == 0x02) {
+			/* Limited discoverable mode */
+			set_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+
+			hci_cp.num_iac = 2;
+			hci_cp.iac_lap[0] = 0x00;	/* LIAC */
+			hci_cp.iac_lap[1] = 0x8b;
+			hci_cp.iac_lap[2] = 0x9e;
+			hci_cp.iac_lap[3] = 0x33;	/* GIAC */
+			hci_cp.iac_lap[4] = 0x8b;
+			hci_cp.iac_lap[5] = 0x9e;
+		} else {
+			/* General discoverable mode */
+			clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+
+			hci_cp.num_iac = 1;
+			hci_cp.iac_lap[0] = 0x33;	/* GIAC */
+			hci_cp.iac_lap[1] = 0x8b;
+			hci_cp.iac_lap[2] = 0x9e;
+		}
+
+		hci_req_add(&req, HCI_OP_WRITE_CURRENT_IAC_LAP,
+			    (hci_cp.num_iac * 3) + 1, &hci_cp);
+
 		scan |= SCAN_INQUIRY;
-	else
-		cancel_delayed_work(&hdev->discov_off);
+	} else {
+		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+	}
 
-	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
 
 	err = hci_req_run(&req, set_discoverable_complete);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-	if (cp->val)
-		hdev->discov_timeout = timeout;
-
 failed:
 	hci_dev_unlock(hdev);
 	return err;
-- 
1.8.3.1

