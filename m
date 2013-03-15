Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 18/26] Bluetooth: Add proper flag for fast connectable mode
Date: Fri, 15 Mar 2013 17:07:08 -0500
Message-Id: <1363385236-25704-19-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
References: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In order to be able to represent fast connectable mode in the mgmt
settings we need to have a HCI dev flag for it. This patch adds the flag
and makes sure its value is changed whenever a mgmt_set_fast_connectable
command completes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |    4 +++-
 net/bluetooth/mgmt.c        |   16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1e40222..b854506 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -120,12 +120,14 @@ enum {
 	HCI_DISCOVERABLE,
 	HCI_LINK_SECURITY,
 	HCI_PERIODIC_INQ,
+	HCI_FAST_CONNECTABLE,
 };
 
 /* A mask for the flags that are supposed to remain when a reset happens
  * or the HCI device is closed.
  */
-#define HCI_PERSISTENT_MASK (BIT(HCI_LE_SCAN) | BIT(HCI_PERIODIC_INQ))
+#define HCI_PERSISTENT_MASK (BIT(HCI_LE_SCAN) | BIT(HCI_PERIODIC_INQ) | \
+			      BIT(HCI_FAST_CONNECTABLE))
 
 /* HCI ioctl defines */
 #define HCIDEVUP	_IOW('H', 201, int)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e89938e0..b6a33c5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -410,6 +410,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
 		settings |= MGMT_SETTING_CONNECTABLE;
 
+	if (test_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags))
+		settings |= MGMT_SETTING_FAST_CONNECTABLE;
+
 	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
 		settings |= MGMT_SETTING_DISCOVERABLE;
 
@@ -2913,6 +2916,13 @@ static void fast_connectable_complete(struct hci_dev *hdev, u8 status)
 		cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 			   mgmt_status(status));
 	} else {
+		struct mgmt_mode *cp = cmd->param;
+
+		if (cp->val)
+			set_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags);
+		else
+			clear_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags);
+
 		send_settings_rsp(cmd->sk, MGMT_OP_SET_FAST_CONNECTABLE, hdev);
 		new_settings(hdev, cmd->sk);
 	}
@@ -2959,6 +2969,12 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
+	if (!!cp->val == test_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags)) {
+		err = send_settings_rsp(sk, MGMT_OP_SET_FAST_CONNECTABLE,
+					hdev);
+		goto unlock;
+	}
+
 	if (cp->val) {
 		type = PAGE_SCAN_TYPE_INTERLACED;
 
-- 
1.7.10.4

