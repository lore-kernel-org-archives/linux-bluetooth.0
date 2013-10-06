Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Send new settings only when pairable changes
Date: Sun,  6 Oct 2013 16:11:57 -0700
Message-Id: <1381101117-64767-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case the current value of pairable is already configured, do not
send a new settings event indicating that something has changed while
in reality everything is the same.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9702079..3f628fd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1188,6 +1188,7 @@ static int set_pairable(struct sock *sk, struct hci_dev *hdev, void *data,
 			u16 len)
 {
 	struct mgmt_mode *cp = data;
+	bool changed;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
@@ -1199,17 +1200,18 @@ static int set_pairable(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	if (cp->val)
-		set_bit(HCI_PAIRABLE, &hdev->dev_flags);
+		changed = !test_and_set_bit(HCI_PAIRABLE, &hdev->dev_flags);
 	else
-		clear_bit(HCI_PAIRABLE, &hdev->dev_flags);
+		changed = test_and_clear_bit(HCI_PAIRABLE, &hdev->dev_flags);
 
 	err = send_settings_rsp(sk, MGMT_OP_SET_PAIRABLE, hdev);
 	if (err < 0)
-		goto failed;
+		goto unlock;
 
-	err = new_settings(hdev, sk);
+	if (changed)
+		err = new_settings(hdev, sk);
 
-failed:
+unlock:
 	hci_dev_unlock(hdev);
 	return err;
 }
-- 
1.8.3.1

