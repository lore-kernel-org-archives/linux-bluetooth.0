Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/9] Bluetooth: Refactor set_connectable settings update to separate function
Date: Sat, 19 Oct 2013 23:38:18 +0300
Message-Id: <1382215103-6968-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
References: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We will need to directly update the device flags and notify user space
of the new settings not just when we're powered off but also if it turns
out that there are no HCI commands to send (which can happen in
particular when BR/EDR is disabled). Since this is a considerable amount
of code, refactor it to a separate function so it can be reused for the
"no HCI commands to send" case.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c363285..b74a157 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1381,6 +1381,32 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static int set_connectable_update_settings(struct hci_dev *hdev,
+					   struct sock *sk, u8 val)
+{
+	bool changed = false;
+	int err;
+
+	if (!!val != test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+		changed = true;
+
+	if (val) {
+		set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+	} else {
+		clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+		clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+	}
+
+	err = send_settings_rsp(sk, MGMT_OP_SET_CONNECTABLE, hdev);
+	if (err < 0)
+		return err;
+
+	if (changed)
+		return new_settings(hdev, sk);
+
+	return 0;
+}
+
 static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 			   u16 len)
 {
@@ -1404,25 +1430,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		bool changed = false;
-
-		if (!!cp->val != test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
-			changed = true;
-
-		if (cp->val) {
-			set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
-		} else {
-			clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
-			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
-		}
-
-		err = send_settings_rsp(sk, MGMT_OP_SET_CONNECTABLE, hdev);
-		if (err < 0)
-			goto failed;
-
-		if (changed)
-			err = new_settings(hdev, sk);
-
+		err = set_connectable_update_settings(hdev, sk, cp->val);
 		goto failed;
 	}
 
-- 
1.8.3.1

