Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: mgmt: Fix managing AMP device
Date: Fri,  8 Jun 2012 11:09:57 +0300
Message-Id: <1339142997-6387-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20120607151803.GA24609@x220.docomointertouch.net>
References: <20120607151803.GA24609@x220.docomointertouch.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

AMP device shall not be managed by user space for now.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_core.c         |    6 ++++--
 net/bluetooth/mgmt.c             |   20 ++++++++++++++++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 288eaa8..78d5fe2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1080,7 +1080,7 @@ int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_interleaved_discovery(struct hci_dev *hdev);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
-
+bool mgmt_valid_hdev(struct hci_dev *hdev);
 int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent);
 
 /* HCI info for socket */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 88d996b..25a86cd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -699,7 +699,8 @@ int hci_dev_open(__u16 dev)
 		hci_dev_hold(hdev);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
-		if (!test_bit(HCI_SETUP, &hdev->dev_flags)) {
+		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
+		    mgmt_valid_hdev(hdev)) {
 			hci_dev_lock(hdev);
 			mgmt_powered(hdev, 1);
 			hci_dev_unlock(hdev);
@@ -801,7 +802,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	 * and no tasks are scheduled. */
 	hdev->close(hdev);
 
-	if (!test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
+	if (!test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags) &&
+	    mgmt_valid_hdev(hdev)) {
 		hci_dev_lock(hdev);
 		mgmt_powered(hdev, 0);
 		hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 958f764..5ea1305 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -193,6 +193,11 @@ static u8 mgmt_status_table[] = {
 	MGMT_STATUS_CONNECT_FAILED,	/* MAC Connection Failed */
 };
 
+bool mgmt_valid_hdev(struct hci_dev *hdev)
+{
+	return hdev->amp_type == HCI_BREDR;
+}
+
 static u8 mgmt_status(u8 hci_status)
 {
 	if (hci_status < ARRAY_SIZE(mgmt_status_table))
@@ -329,6 +334,9 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	count = 0;
 	list_for_each(p, &hci_dev_list) {
+		if (!mgmt_valid_hdev(hdev))
+			continue;
+
 		count++;
 	}
 
@@ -346,6 +354,9 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_SETUP, &d->dev_flags))
 			continue;
 
+		if (!mgmt_valid_hdev(hdev))
+			continue;
+
 		rp->index[i++] = cpu_to_le16(d->id);
 		BT_DBG("Added hci%u", d->id);
 	}
@@ -2135,6 +2146,9 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("");
 
+	if (hdev->amp_type != HCI_BREDR)
+		return -ENOTSUPP;
+
 	hci_dev_lock(hdev);
 
 	memcpy(hdev->short_name, cp->short_name, sizeof(hdev->short_name));
@@ -2813,6 +2827,9 @@ static void cmd_status_rsp(struct pending_cmd *cmd, void *data)
 
 int mgmt_index_added(struct hci_dev *hdev)
 {
+	if (!mgmt_valid_hdev(hdev))
+		return -ENOTSUPP;
+
 	return mgmt_event(MGMT_EV_INDEX_ADDED, hdev, NULL, 0, NULL);
 }
 
@@ -2820,6 +2837,9 @@ int mgmt_index_removed(struct hci_dev *hdev)
 {
 	u8 status = MGMT_STATUS_INVALID_INDEX;
 
+	if (!mgmt_valid_hdev(hdev))
+		return -ENOTSUPP;
+
 	mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
 
 	return mgmt_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0, NULL);
-- 
1.7.9.5

