Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Add variable SSP auto-accept delay support
Date: Wed, 27 Apr 2011 16:04:35 -0700
Message-Id: <1303945480-25756-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1303945480-25756-1-git-send-email-johan.hedberg@gmail.com>
References: <1303945480-25756-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

Some test systems require an arbitrary delay to the auto-accept test
cases for Secure Simple Pairing in order for the tests to pass.
Previously when this was handled in user space it was worked around by
code modifications and recompilation, but now that it's on the kernel
side it's more convenient if there's a debugfs interface for it.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    3 +++
 net/bluetooth/hci_conn.c         |   17 +++++++++++++++++
 net/bluetooth/hci_event.c        |   10 +++++++++-
 net/bluetooth/hci_sysfs.c        |   31 +++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 02e7256..09740c3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -126,6 +126,8 @@ struct hci_dev {
 	__u16		sniff_min_interval;
 	__u16		sniff_max_interval;
 
+	unsigned int	auto_accept_delay;
+
 	unsigned long	quirks;
 
 	atomic_t	cmd_cnt;
@@ -246,6 +248,7 @@ struct hci_conn {
 
 	struct timer_list disc_timer;
 	struct timer_list idle_timer;
+	struct timer_list auto_accept_timer;
 
 	struct work_struct work_add;
 	struct work_struct work_del;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 74cd755..7f5ad8a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -269,6 +269,19 @@ static void hci_conn_idle(unsigned long arg)
 	hci_conn_enter_sniff_mode(conn);
 }
 
+static void hci_conn_auto_accept(unsigned long arg)
+{
+	struct hci_conn *conn = (void *) arg;
+	struct hci_dev *hdev = conn->hdev;
+
+	hci_dev_lock(hdev);
+
+	hci_send_cmd(hdev, HCI_OP_USER_CONFIRM_REPLY, sizeof(conn->dst),
+								&conn->dst);
+
+	hci_dev_unlock(hdev);
+}
+
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 {
 	struct hci_conn *conn;
@@ -312,6 +325,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 
 	setup_timer(&conn->disc_timer, hci_conn_timeout, (unsigned long)conn);
 	setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
+	setup_timer(&conn->auto_accept_timer, hci_conn_auto_accept,
+							(unsigned long) conn);
 
 	atomic_set(&conn->refcnt, 0);
 
@@ -342,6 +357,8 @@ int hci_conn_del(struct hci_conn *conn)
 
 	del_timer(&conn->disc_timer);
 
+	del_timer(&conn->auto_accept_timer);
+
 	if (conn->type == ACL_LINK) {
 		struct hci_conn *sco = conn->link;
 		if (sco)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 038d70d..4f1e695 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2479,7 +2479,15 @@ static inline void hci_user_confirm_request_evt(struct hci_dev *hdev,
 	/* If no side requires MITM protection; auto-accept */
 	if ((!loc_mitm || conn->remote_cap == 0x03) &&
 				(!rem_mitm || conn->io_capability == 0x03)) {
-		BT_DBG("Auto-accept of user confirmation");
+		BT_DBG("Auto-accept of user confirmation with %ums delay",
+						hdev->auto_accept_delay);
+
+		if (hdev->auto_accept_delay > 0) {
+			int delay = msecs_to_jiffies(hdev->auto_accept_delay);
+			mod_timer(&conn->auto_accept_timer, jiffies + delay);
+			goto unlock;
+		}
+
 		hci_send_cmd(hdev, HCI_OP_USER_CONFIRM_REPLY,
 						sizeof(ev->bdaddr), &ev->bdaddr);
 		goto unlock;
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 8775933..a6c3aa8 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -511,6 +511,35 @@ static const struct file_operations uuids_fops = {
 	.release	= single_release,
 };
 
+static int auto_accept_delay_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock_bh(hdev);
+
+	hdev->auto_accept_delay = val;
+
+	hci_dev_unlock_bh(hdev);
+
+	return 0;
+}
+
+static int auto_accept_delay_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock_bh(hdev);
+
+	*val = hdev->auto_accept_delay;
+
+	hci_dev_unlock_bh(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
+					auto_accept_delay_set, "%llu\n");
+
 int hci_register_sysfs(struct hci_dev *hdev)
 {
 	struct device *dev = &hdev->dev;
@@ -545,6 +574,8 @@ int hci_register_sysfs(struct hci_dev *hdev)
 
 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
 
+	debugfs_create_file("auto_accept_delay", 0444, hdev->debugfs, hdev,
+						&auto_accept_delay_fops);
 	return 0;
 }
 
-- 
1.7.4.4

