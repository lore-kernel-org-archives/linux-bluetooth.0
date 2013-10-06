Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove mgmt_valid_hdev() helper function
Date: Sun,  6 Oct 2013 08:25:01 -0700
Message-Id: <1381073101-53030-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The helper function mgmt_valid_hdev() is more obfuscating the code
then it makes it easier to read. So intead of this helper, use the
direct check for BR/EDR device type.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         |  4 ++--
 net/bluetooth/mgmt.c             | 24 ++++++++----------------
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 30e0fbb..d80d431 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1148,7 +1148,6 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
-bool mgmt_valid_hdev(struct hci_dev *hdev);
 int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent);
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bf3c5b0..d9626aa 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1254,7 +1254,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		hci_notify(hdev, HCI_DEV_UP);
 		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
 		    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags) &&
-		    mgmt_valid_hdev(hdev)) {
+		    hdev->dev_type == HCI_BREDR) {
 			hci_dev_lock(hdev);
 			mgmt_powered(hdev, 1);
 			hci_dev_unlock(hdev);
@@ -1394,7 +1394,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hdev->dev_flags &= ~HCI_PERSISTENT_MASK;
 
 	if (!test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags) &&
-	    mgmt_valid_hdev(hdev)) {
+	    hdev->dev_type == HCI_BREDR) {
 		hci_dev_lock(hdev);
 		mgmt_powered(hdev, 0);
 		hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dd48e2a..9702079 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -182,11 +182,6 @@ static u8 mgmt_status_table[] = {
 	MGMT_STATUS_CONNECT_FAILED,	/* MAC Connection Failed */
 };
 
-bool mgmt_valid_hdev(struct hci_dev *hdev)
-{
-	return hdev->dev_type == HCI_BREDR;
-}
-
 static u8 mgmt_status(u8 hci_status)
 {
 	if (hci_status < ARRAY_SIZE(mgmt_status_table))
@@ -322,10 +317,8 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (!mgmt_valid_hdev(d))
-			continue;
-
-		count++;
+		if (d->dev_type == HCI_BREDR)
+			count++;
 	}
 
 	rp_len = sizeof(*rp) + (2 * count);
@@ -343,11 +336,10 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_USER_CHANNEL, &d->dev_flags))
 			continue;
 
-		if (!mgmt_valid_hdev(d))
-			continue;
-
-		rp->index[count++] = cpu_to_le16(d->id);
-		BT_DBG("Added hci%u", d->id);
+		if (d->dev_type == HCI_BREDR) {
+			rp->index[count++] = cpu_to_le16(d->id);
+			BT_DBG("Added hci%u", d->id);
+		}
 	}
 
 	rp->num_controllers = cpu_to_le16(count);
@@ -3790,7 +3782,7 @@ done:
 
 int mgmt_index_added(struct hci_dev *hdev)
 {
-	if (!mgmt_valid_hdev(hdev))
+	if (hdev->dev_type != HCI_BREDR)
 		return -ENOTSUPP;
 
 	return mgmt_event(MGMT_EV_INDEX_ADDED, hdev, NULL, 0, NULL);
@@ -3800,7 +3792,7 @@ int mgmt_index_removed(struct hci_dev *hdev)
 {
 	u8 status = MGMT_STATUS_INVALID_INDEX;
 
-	if (!mgmt_valid_hdev(hdev))
+	if (hdev->dev_type != HCI_BREDR)
 		return -ENOTSUPP;
 
 	mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
-- 
1.8.3.1

