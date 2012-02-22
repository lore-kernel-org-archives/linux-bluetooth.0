Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: mgmt: Allow local name changes while powered off
Date: Wed, 22 Feb 2012 21:06:55 +0200
Message-Id: <1329937615-29893-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329937615-29893-1-git-send-email-johan.hedberg@gmail.com>
References: <1329937615-29893-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch makes it possible to set the local name before powering on
the device. The name will be applied using the hci_write_local_name
command once the device gets powered on.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |   13 ++++++++++---
 net/bluetooth/mgmt.c      |   38 ++++++++++++++++++++++++++------------
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9917fe3..9b30587 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -209,11 +209,10 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (status == 0)
-		memcpy(hdev->dev_name, sent, HCI_MAX_NAME_LENGTH);
-
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_set_local_name_complete(hdev, sent, status);
+	else if (!status)
+		memcpy(hdev->dev_name, sent, HCI_MAX_NAME_LENGTH);
 
 	hci_dev_unlock(hdev);
 }
@@ -563,6 +562,14 @@ static void hci_setup(struct hci_dev *hdev)
 	if (hdev->hci_ver > BLUETOOTH_VER_1_1)
 		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
 
+	if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
+					test_bit(HCI_MGMT, &hdev->dev_flags)) {
+		struct hci_cp_write_local_name cp;
+
+		memcpy(cp.name, hdev->dev_name, sizeof(cp.name));
+		hci_send_cmd(hdev, HCI_OP_WRITE_LOCAL_NAME, sizeof(cp), &cp);
+	}
+
 	if (hdev->features[6] & LMP_SIMPLE_PAIR) {
 		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
 			u8 mode = 0x01;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3f6a2df..9c1f771 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2260,22 +2260,29 @@ static int set_local_name(struct sock *sk, u16 index, void *data,
 
 	hci_dev_lock(hdev);
 
+	memcpy(hdev->short_name, mgmt_cp->short_name,
+						sizeof(hdev->short_name));
+
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_LOCAL_NAME,
-						MGMT_STATUS_NOT_POWERED);
+		memcpy(hdev->dev_name, mgmt_cp->name, sizeof(hdev->dev_name));
+
+		err = cmd_complete(sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
+								data, len);
+		if (err < 0)
+			goto failed;
+
+		err = mgmt_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, data, len,
+									sk);
+
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LOCAL_NAME, hdev, data,
-									len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LOCAL_NAME, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
 	}
 
-	memcpy(hdev->short_name, mgmt_cp->short_name,
-						sizeof(hdev->short_name));
-
 	memcpy(hci_cp.name, mgmt_cp->name, sizeof(hci_cp.name));
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_LOCAL_NAME, sizeof(hci_cp),
 								&hci_cp);
@@ -3563,10 +3570,17 @@ int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_cp_set_local_name ev;
-	int err;
+	bool changed = false;
+	int err = 0;
+
+	if (memcmp(name, hdev->dev_name, sizeof(hdev->dev_name)) != 0) {
+		memcpy(hdev->dev_name, name, sizeof(hdev->dev_name));
+		changed = true;
+	}
 
 	memset(&ev, 0, sizeof(ev));
 	memcpy(ev.name, name, HCI_MAX_NAME_LENGTH);
+	memcpy(ev.short_name, hdev->short_name, HCI_MAX_SHORT_NAME_LENGTH);
 
 	cmd = mgmt_pending_find(MGMT_OP_SET_LOCAL_NAME, hdev);
 	if (!cmd)
@@ -3578,16 +3592,16 @@ int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 		goto failed;
 	}
 
-	update_eir(hdev);
-
 	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0, &ev,
 								sizeof(ev));
 	if (err < 0)
 		goto failed;
 
 send_event:
-	err = mgmt_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, &ev, sizeof(ev),
-							cmd ? cmd->sk : NULL);
+	if (changed)
+		err = mgmt_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, &ev,
+					sizeof(ev), cmd ? cmd->sk : NULL);
+
 	update_eir(hdev);
 
 failed:
-- 
1.7.9

