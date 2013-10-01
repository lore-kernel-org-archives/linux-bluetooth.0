Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Send new settings event when changing high speed option
Date: Mon, 30 Sep 2013 22:17:38 -0700
Message-Id: <1380604658-34364-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When enabling or disabling high speed setting it is required to send
a new settings event to inform other management interface users about
the changed settings.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1b5b10f..13b5435 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1341,6 +1341,8 @@ failed:
 static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
+	bool changed;
+	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
@@ -1352,12 +1354,23 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
 				  MGMT_STATUS_INVALID_PARAMS);
 
+	hci_dev_lock(hdev);
+
 	if (cp->val)
-		set_bit(HCI_HS_ENABLED, &hdev->dev_flags);
+		changed = !test_and_set_bit(HCI_HS_ENABLED, &hdev->dev_flags);
 	else
-		clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
+		changed = test_and_clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
+
+	err = send_settings_rsp(sk, MGMT_OP_SET_HS, hdev);
+	if (err < 0)
+		goto unlock;
 
-	return send_settings_rsp(sk, MGMT_OP_SET_HS, hdev);
+	if (changed)
+		err = new_settings(hdev, sk);
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
 }
 
 static void le_enable_complete(struct hci_dev *hdev, u8 status)
-- 
1.8.3.1

