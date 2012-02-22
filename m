Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: mgmt: Make Set Link Security callable while powered off
Date: Wed, 22 Feb 2012 13:12:50 +0200
Message-Id: <1329909172-19958-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch makes it possible to change the Link Security setting while
powered off and have it automatically enabled when powering on a device.
To track the desired state once powered on a new HCI_LINK_SECURITY flag
is added.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/hci_event.c   |    6 ++++++
 net/bluetooth/mgmt.c        |   33 ++++++++++++++++++++++++++++-----
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 169d2f8..806eb41 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -98,6 +98,7 @@ enum {
 	HCI_HS_ENABLED,
 	HCI_CONNECTABLE,
 	HCI_DISCOVERABLE,
+	HCI_LINK_SECURITY,
 };
 
 /* HCI ioctl defines */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2a5d05c..5fb1ee5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -594,6 +594,12 @@ static void hci_setup(struct hci_dev *hdev)
 							sizeof(cp), &cp);
 	}
 
+	if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags)) {
+		u8 enable = 1;
+		hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE,
+						sizeof(enable), &enable);
+	}
+
 	if (hdev->features[4] & LMP_LE)
 		hci_set_le_support(hdev);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e8f890d..69d4e1a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -410,7 +410,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (hdev->host_features[0] & LMP_HOST_LE)
 		settings |= MGMT_SETTING_LE;
 
-	if (test_bit(HCI_AUTH, &hdev->flags))
+	if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags))
 		settings |= MGMT_SETTING_LINK_SECURITY;
 
 	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
@@ -1067,8 +1067,21 @@ static int set_link_security(struct sock *sk, u16 index, void *data, u16 len)
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_LINK_SECURITY,
-						MGMT_STATUS_NOT_POWERED);
+		bool changed = false;
+
+		if (!!cp->val != test_bit(HCI_LINK_SECURITY,
+							&hdev->dev_flags)) {
+			change_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
+			changed = true;
+		}
+
+		err = send_settings_rsp(sk, MGMT_OP_SET_LINK_SECURITY, hdev);
+		if (err < 0)
+			goto failed;
+
+		if (changed)
+			err = new_settings(hdev, sk);
+
 		goto failed;
 	}
 
@@ -3338,7 +3351,8 @@ int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
-	int err;
+	bool changed = false;
+	int err = 0;
 
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
@@ -3347,10 +3361,19 @@ int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 		return 0;
 	}
 
+	if (test_bit(HCI_AUTH, &hdev->flags)) {
+		if (!test_and_set_bit(HCI_LINK_SECURITY, &hdev->dev_flags))
+			changed = true;
+	} else {
+		if (test_and_clear_bit(HCI_LINK_SECURITY, &hdev->dev_flags))
+			changed = true;
+	}
+
 	mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev, settings_rsp,
 								&match);
 
-	err = new_settings(hdev, match.sk);
+	if (changed)
+		err = new_settings(hdev, match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
-- 
1.7.9

