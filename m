Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/9] Bluetooth: mgmt: Allow connectable/discoverable changes in off state
Date: Tue, 21 Feb 2012 17:59:59 +0200
Message-Id: <1329840005-4977-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
References: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch makes it possible to toggle the connectable & discoverable
settings when powered off. Two new hdev->dev_flags flags are added to
track what the scan mode should be when the device is finally powered
on.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |    2 +
 net/bluetooth/hci_core.c    |    1 +
 net/bluetooth/mgmt.c        |   86 ++++++++++++++++++++++++++++++++++---------
 3 files changed, 71 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ec37049..169d2f8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -96,6 +96,8 @@ enum {
 	HCI_LE_SCAN,
 	HCI_SSP_ENABLED,
 	HCI_HS_ENABLED,
+	HCI_CONNECTABLE,
+	HCI_DISCOVERABLE,
 };
 
 /* HCI ioctl defines */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a787c9c..9d19949 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -737,6 +737,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	if (hdev->discov_timeout > 0) {
 		cancel_delayed_work(&hdev->discov_off);
 		hdev->discov_timeout = 0;
+		clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
 	}
 
 	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 03a1384..54df0c0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -398,10 +398,10 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (!test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
 		settings |= MGMT_SETTING_POWERED;
 
-	if (test_bit(HCI_PSCAN, &hdev->flags))
+	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
 		settings |= MGMT_SETTING_CONNECTABLE;
 
-	if (test_bit(HCI_ISCAN, &hdev->flags))
+	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
 		settings |= MGMT_SETTING_DISCOVERABLE;
 
 	if (test_bit(HCI_PAIRABLE, &hdev->dev_flags))
@@ -796,6 +796,7 @@ static int set_discoverable(struct sock *sk, u16 index, void *data, u16 len)
 	struct mgmt_cp_set_discoverable *cp = data;
 	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
+	u16 timeout;
 	u8 scan;
 	int err;
 
@@ -810,9 +811,11 @@ static int set_discoverable(struct sock *sk, u16 index, void *data, u16 len)
 		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
 						MGMT_STATUS_INVALID_PARAMS);
 
+	timeout = get_unaligned_le16(&cp->timeout);
+
 	hci_dev_lock(hdev);
 
-	if (!hdev_is_powered(hdev)) {
+	if (!hdev_is_powered(hdev) && timeout > 0) {
 		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
@@ -825,8 +828,17 @@ static int set_discoverable(struct sock *sk, u16 index, void *data, u16 len)
 		goto failed;
 	}
 
-	if (cp->val == test_bit(HCI_ISCAN, &hdev->flags) &&
-					test_bit(HCI_PSCAN, &hdev->flags)) {
+	if (!hdev_is_powered(hdev)) {
+		if (cp->val) {
+			set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+			set_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+		} else
+			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+		err = send_settings_rsp(sk, MGMT_OP_SET_DISCOVERABLE, hdev);
+		goto failed;
+	}
+
+	if (!!cp->val == test_bit(HCI_DISCOVERABLE, &hdev->dev_flags)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_DISCOVERABLE, hdev);
 		goto failed;
 	}
@@ -849,7 +861,7 @@ static int set_discoverable(struct sock *sk, u16 index, void *data, u16 len)
 		mgmt_pending_remove(cmd);
 
 	if (cp->val)
-		hdev->discov_timeout = get_unaligned_le16(&cp->timeout);
+		hdev->discov_timeout = timeout;
 
 failed:
 	hci_dev_unlock(hdev);
@@ -880,8 +892,13 @@ static int set_connectable(struct sock *sk, u16 index, void *data, u16 len)
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE,
-						MGMT_STATUS_NOT_POWERED);
+		if (cp->val)
+			set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+		else {
+			clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+		}
+		err = send_settings_rsp(sk, MGMT_OP_SET_CONNECTABLE, hdev);
 		goto failed;
 	}
 
@@ -892,7 +909,7 @@ static int set_connectable(struct sock *sk, u16 index, void *data, u16 len)
 		goto failed;
 	}
 
-	if (cp->val == test_bit(HCI_PSCAN, &hdev->flags)) {
+	if (!!cp->val == test_bit(HCI_PSCAN, &hdev->flags)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_CONNECTABLE, hdev);
 		goto failed;
 	}
@@ -2866,9 +2883,22 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 	__le32 ev;
 	int err;
 
+	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+		return 0;
+
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
-	if (!powered) {
+	if (powered) {
+		u8 scan = 0;
+
+		if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+			scan |= SCAN_PAGE;
+		if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
+			scan |= SCAN_INQUIRY;
+
+		if (scan)
+			hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+	} else {
 		u8 status = ENETDOWN;
 		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
 	}
@@ -2887,15 +2917,25 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 {
 	struct cmd_lookup match = { NULL, hdev };
-	__le32 ev;
-	int err;
+	bool changed = false;
+	int err = 0;
 
 	mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, hdev, settings_rsp, &match);
 
-	ev = cpu_to_le32(get_current_settings(hdev));
+	if (discoverable) {
+		if (!test_and_set_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
+			changed = true;
+	} else {
+		if (test_and_clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
+			changed = true;
+	}
 
-	err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev),
+	if (changed) {
+		__le32 ev = cpu_to_le32(get_current_settings(hdev));
+		err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev),
 								match.sk);
+	}
+
 	if (match.sk)
 		sock_put(match.sk);
 
@@ -2904,16 +2944,26 @@ int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 
 int mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 {
-	__le32 ev;
 	struct cmd_lookup match = { NULL, hdev };
-	int err;
+	bool changed = false;
+	int err = 0;
 
 	mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, hdev, settings_rsp,
 								&match);
 
-	ev = cpu_to_le32(get_current_settings(hdev));
+	if (connectable) {
+		if (!test_and_set_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+			changed = true;
+	} else {
+		if (test_and_clear_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+			changed = true;
+	}
 
-	err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), match.sk);
+	if (changed) {
+		__le32 ev = cpu_to_le32(get_current_settings(hdev));
+		err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev),
+								match.sk);
+	}
 
 	if (match.sk)
 		sock_put(match.sk);
-- 
1.7.9

