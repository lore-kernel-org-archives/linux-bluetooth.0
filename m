Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Remove unneeded val variable when setting SSP
Date: Thu, 10 Oct 2013 03:08:10 -0700
Message-Id: <1381399691-42391-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The variable val in the set_ssp() function of the management interface
is not needed. Just use cp->val directly since its input values have
already been validated.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a9d7506..2fb4d35 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1290,7 +1290,7 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
-	u8 val, status;
+	u8 status;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
@@ -1309,8 +1309,6 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	val = !!cp->val;
-
 	if (!hdev_is_powered(hdev)) {
 		bool changed = false;
 
@@ -1335,7 +1333,7 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto failed;
 	}
 
-	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) == val) {
+	if (!!cp->val == test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_SSP, hdev);
 		goto failed;
 	}
@@ -1346,7 +1344,7 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto failed;
 	}
 
-	err = hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, sizeof(val), &val);
+	err = hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, 1, &cp->val);
 	if (err < 0) {
 		mgmt_pending_remove(cmd);
 		goto failed;
-- 
1.8.3.1

