Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Introduce hci_dev_test_and_change_flag helper macro
Date: Fri, 13 Mar 2015 02:11:04 -0700
Message-Id: <1426237866-8329-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of manually coding test_and_change_bit on hdev->dev_flags all the
time, use hci_dev_test_and_change_flag helper macro.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 2 ++
 net/bluetooth/mgmt.c             | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 92b2148702e6..cd2682c64a4c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -507,6 +507,8 @@ extern struct mutex hci_cb_list_lock;
 #define hci_dev_change_flag(hdev, nr) change_bit((nr), &(hdev)->dev_flags)
 #define hci_dev_test_flag(hdev, nr)   test_bit((nr), &(hdev)->dev_flags)
 
+#define hci_dev_test_and_change_flag(hdev, nr) test_and_change_bit((nr), &(hdev)->dev_flags)
+
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c3af3b87dbb5..3c579a45cff0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6102,7 +6102,7 @@ static int set_external_config(struct sock *sk, struct hci_dev *hdev,
 	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED) == is_configured(hdev)) {
 		mgmt_index_removed(hdev);
 
-		if (test_and_change_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
+		if (hci_dev_test_and_change_flag(hdev, HCI_UNCONFIGURED)) {
 			hci_dev_set_flag(hdev, HCI_CONFIG);
 			hci_dev_set_flag(hdev, HCI_AUTO_OFF);
 
-- 
2.1.0

