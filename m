Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [PATCH 09/12] Bluetooth: Enable support for broadcaster mode when powered off.
Date: Fri, 14 Dec 2012 14:51:35 -0400
Message-Id: <1355511098-10190-10-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>

We have to enable advertising in mgmt_powered if broadcaster mode is on.

We also need to update the advertising data in mgmt_powered if brodcaster
mode is on.

As the advertising data is already being updated on mgmt_powered function,
we don't need to update it also in hci_dev_open.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 net/bluetooth/hci_core.c |  3 ---
 net/bluetooth/mgmt.c     | 38 ++++++++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c692b14..518c916 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -764,9 +764,6 @@ int hci_dev_open(__u16 dev)
 		hci_dev_hold(hdev);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
-		hci_dev_lock(hdev);
-		__hci_update_ad(hdev);
-		hci_dev_unlock(hdev);
 		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
 		    mgmt_valid_hdev(hdev)) {
 			hci_dev_lock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e910b11..805ae3b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2720,12 +2720,6 @@ static int set_controller_data(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (!hdev_is_powered(hdev)) {
-		hci_dev_unlock(hdev);
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONTROLLER_DATA,
-				  MGMT_STATUS_NOT_POWERED);
-	}
-
 	room = HCI_MAX_AD_LENGTH - hdev->broadcast_data_len;
 	if (sizeof(cp->length) + sizeof(cp->type) + cp->length > room) {
 		hci_dev_unlock(hdev);
@@ -2757,12 +2751,6 @@ static int unset_controller_data(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (!hdev_is_powered(hdev)) {
-		hci_dev_unlock(hdev);
-		return cmd_status(sk, hdev->id, MGMT_OP_UNSET_CONTROLLER_DATA,
-				  MGMT_STATUS_NOT_POWERED);
-	}
-
 	removed = hci_broadcast_data_remove(hdev, cp->type);
 
 	if (removed && test_bit(HCI_BROADCASTER, &hdev->dev_flags))
@@ -2784,8 +2772,20 @@ static int set_broadcaster_le(struct sock *sk, struct hci_dev *hdev, u8 enable)
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_BROADCASTER,
-				  MGMT_STATUS_NOT_POWERED);
+		bool changed = false;
+
+		if (enable != test_bit(HCI_BROADCASTER, &hdev->dev_flags)) {
+			change_bit(HCI_BROADCASTER, &hdev->dev_flags);
+			changed = true;
+		}
+
+		err = send_settings_rsp(sk, MGMT_OP_SET_BROADCASTER, hdev);
+		if (err < 0)
+			goto unlock;
+
+		if (changed)
+			err = new_settings(hdev, sk);
+
 		goto unlock;
 	}
 
@@ -3068,6 +3068,16 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 				hci_send_cmd(hdev,
 					     HCI_OP_WRITE_LE_HOST_SUPPORTED,
 					     sizeof(cp), &cp);
+
+			__hci_update_ad(hdev);
+
+			if (test_bit(HCI_BROADCASTER, &hdev->dev_flags)) {
+				u8 enable = 1;
+				hdev->le_adv_req_reason =
+						LE_ADV_REQ_REASON_BROADCASTER;
+				hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+					     sizeof(enable), &enable);
+			}
 		}
 
 		if (lmp_bredr_capable(hdev)) {
-- 
1.8.0.2

