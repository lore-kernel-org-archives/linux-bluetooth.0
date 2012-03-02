Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: mgmt: Fix updating local name when powering on
Date: Fri,  2 Mar 2012 14:33:10 -0800
Message-Id: <1330727590-27120-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1330727590-27120-1-git-send-email-johan.hedberg@gmail.com>
References: <1330727590-27120-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When powering on we need to apply whatever name has been set through
mgmt_set_local_name. The appropriate place for this is mgmt_powered()
and not hci_setup() since this needs to be applied also if the HCI init
sequence was already completed but the adapter was still "powered off"
from a mgmt perspective due the the HCI_AUTO_OFF still being set.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |    8 --------
 net/bluetooth/mgmt.c      |   22 ++++++++++++++--------
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d6c41bb..6a817da 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -552,14 +552,6 @@ static void hci_setup(struct hci_dev *hdev)
 	if (hdev->hci_ver > BLUETOOTH_VER_1_1)
 		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
 
-	if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
-					test_bit(HCI_MGMT, &hdev->dev_flags)) {
-		struct hci_cp_write_local_name cp;
-
-		memcpy(cp.name, hdev->dev_name, sizeof(cp.name));
-		hci_send_cmd(hdev, HCI_OP_WRITE_LOCAL_NAME, sizeof(cp), &cp);
-	}
-
 	if (hdev->features[6] & LMP_SIMPLE_PAIR) {
 		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
 			u8 mode = 0x01;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4b1efed..4ca0092 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2104,11 +2104,19 @@ static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
 					HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
 }
 
+static int update_name(struct hci_dev *hdev, const char *name)
+{
+	struct hci_cp_write_local_name cp;
+
+	memcpy(cp.name, name, sizeof(cp.name));
+
+	return hci_send_cmd(hdev, HCI_OP_WRITE_LOCAL_NAME, sizeof(cp), &cp);
+}
+
 static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 								u16 len)
 {
-	struct mgmt_cp_set_local_name *mgmt_cp = data;
-	struct hci_cp_write_local_name hci_cp;
+	struct mgmt_cp_set_local_name *cp = data;
 	struct pending_cmd *cmd;
 	int err;
 
@@ -2116,11 +2124,10 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	memcpy(hdev->short_name, mgmt_cp->short_name,
-						sizeof(hdev->short_name));
+	memcpy(hdev->short_name, cp->short_name, sizeof(hdev->short_name));
 
 	if (!hdev_is_powered(hdev)) {
-		memcpy(hdev->dev_name, mgmt_cp->name, sizeof(hdev->dev_name));
+		memcpy(hdev->dev_name, cp->name, sizeof(hdev->dev_name));
 
 		err = cmd_complete(sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
 								data, len);
@@ -2139,9 +2146,7 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	memcpy(hci_cp.name, mgmt_cp->name, sizeof(hci_cp.name));
-	err = hci_send_cmd(hdev, HCI_OP_WRITE_LOCAL_NAME, sizeof(hci_cp),
-								&hci_cp);
+	err = update_name(hdev, cp->name);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -2794,6 +2799,7 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 			hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 
 		update_class(hdev);
+		update_name(hdev, hdev->dev_name);
 		update_eir(hdev);
 	} else {
 		u8 status = MGMT_STATUS_NOT_POWERED;
-- 
1.7.9.1

