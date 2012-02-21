Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Only keep controller up after init if powered on
Date: Tue, 21 Feb 2012 12:14:25 +0100
Message-Id: <1329822865-12312-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a new controller gets added to the system, it needs to be brought
up briefly to read basic information like features, BD_ADDR etc. and
after a timeout it will be brought back down.

The only command that should overwrite this timeout is the set power
command from the management interface. Just reading the controller
list or information is not a good reason to keep the controller up.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a5a2a68..c25cb64 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -339,9 +339,6 @@ static int read_index_list(struct sock *sk)
 
 	i = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (test_and_clear_bit(HCI_AUTO_OFF, &d->dev_flags))
-			cancel_delayed_work(&d->power_off);
-
 		if (test_bit(HCI_SETUP, &d->dev_flags))
 			continue;
 
@@ -392,11 +389,12 @@ static u32 get_current_settings(struct hci_dev *hdev)
 {
 	u32 settings = 0;
 
-	if (test_bit(HCI_UP, &hdev->flags))
-		settings |= MGMT_SETTING_POWERED;
-	else
+	if (!test_bit(HCI_UP, &hdev->flags))
 		return settings;
 
+	if (!test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+		settings |= MGMT_SETTING_POWERED;
+
 	if (test_bit(HCI_PSCAN, &hdev->flags))
 		settings |= MGMT_SETTING_CONNECTABLE;
 
@@ -623,9 +621,6 @@ static int read_controller_info(struct sock *sk, u16 index)
 		return cmd_status(sk, index, MGMT_OP_READ_INFO,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
-		cancel_delayed_work_sync(&hdev->power_off);
-
 	hci_dev_lock(hdev);
 
 	if (test_and_clear_bit(HCI_PI_MGMT_INIT, &hci_pi(sk)->flags))
@@ -753,6 +748,16 @@ static int set_powered(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
+	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
+		cancel_delayed_work(&hdev->power_off);
+
+		if (cp->val) {
+			err = send_settings_rsp(sk, MGMT_OP_SET_POWERED, hdev);
+			mgmt_powered(hdev, 1);
+			goto failed;
+		}
+	}
+
 	up = test_bit(HCI_UP, &hdev->flags);
 	if ((cp->val && up) || (!cp->val && !up)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_POWERED, hdev);
-- 
1.7.7.6

