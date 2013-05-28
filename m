Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix mgmt handling of power on failures
Date: Tue, 28 May 2013 10:07:47 +0300
Message-Id: <1369724867-31011-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If hci_dev_open fails we need to ensure that the corresponding
mgmt_set_powered command gets an appropriate response. This patch fixes
the missing response by adding a new mgmt_set_powered_failed function
that's used to indicate a power on failure to mgmt.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |    6 +++++-
 net/bluetooth/mgmt.c             |   16 ++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 606615c..f77885e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1118,6 +1118,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 int mgmt_index_added(struct hci_dev *hdev);
 int mgmt_index_removed(struct hci_dev *hdev);
+int mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
 int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
 int mgmt_connectable(struct hci_dev *hdev, u8 connectable);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 21ad85d..d7c2dbd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1598,11 +1598,15 @@ static const struct rfkill_ops hci_rfkill_ops = {
 static void hci_power_on(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, power_on);
+	int err;
 
 	BT_DBG("%s", hdev->name);
 
-	if (hci_dev_open(hdev->id) < 0)
+	err = hci_dev_open(hdev->id);
+	if (err < 0) {
+		mgmt_set_powered_failed(hdev, err);
 		return;
+	}
 
 	if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
 		queue_delayed_work(hdev->req_workqueue, &hdev->power_off,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5cd3aee..00b006b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3533,6 +3533,22 @@ new_settings:
 	return err;
 }
 
+int mgmt_set_powered_failed(struct hci_dev *hdev, int err)
+{
+	struct pending_cmd *cmd;
+
+	cmd = mgmt_pending_find(MGMT_OP_SET_POWERED, hdev);
+	if (!cmd)
+		return -ENOENT;
+
+	err = cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_POWERED,
+			 MGMT_STATUS_FAILED);
+
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
+
 int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 {
 	struct cmd_lookup match = { NULL, hdev };
-- 
1.7.10.4

