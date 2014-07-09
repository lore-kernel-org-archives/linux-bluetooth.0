Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Introduce a whitelist for BR/EDR devices
Date: Wed,  9 Jul 2014 11:18:33 +0300
Message-Id: <1404893918-6908-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404893918-6908-1-git-send-email-johan.hedberg@gmail.com>
References: <1404893918-6908-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch extends the Add/Remove device commands by letting user space
pass BR/EDR addresses to them. The resulting entries get stored in a new
hdev->whitelist list. The idea is that we can now selectively accept
connections from devices in the list even though HCI_CONNECTABLE is not
set (the actual implementation of this is coming in a subsequent patch).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 29 ++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 48 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3a1caf10cc8d..cba4837dcaa5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -305,6 +305,7 @@ struct hci_dev {
 
 	struct list_head	mgmt_pending;
 	struct list_head	blacklist;
+	struct list_head	whitelist;
 	struct list_head	uuids;
 	struct list_head	link_keys;
 	struct list_head	long_term_keys;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 60b2f9b67751..4fd0f9b67dd4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -191,6 +191,31 @@ static const struct file_operations blacklist_fops = {
 	.release	= single_release,
 };
 
+static int whitelist_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	struct bdaddr_list *b;
+
+	hci_dev_lock(hdev);
+	list_for_each_entry(b, &hdev->whitelist, list)
+		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int whitelist_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, whitelist_show, inode->i_private);
+}
+
+static const struct file_operations whitelist_fops = {
+	.open		= whitelist_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int uuids_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
@@ -1707,6 +1732,8 @@ static int __hci_init(struct hci_dev *hdev)
 	debugfs_create_u16("hci_revision", 0444, hdev->debugfs, &hdev->hci_rev);
 	debugfs_create_file("blacklist", 0444, hdev->debugfs, hdev,
 			    &blacklist_fops);
+	debugfs_create_file("whitelist", 0444, hdev->debugfs, hdev,
+			    &whitelist_fops);
 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
 
 	debugfs_create_file("conn_info_min_age", 0644, hdev->debugfs, hdev,
@@ -3825,6 +3852,7 @@ struct hci_dev *hci_alloc_dev(void)
 
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 	INIT_LIST_HEAD(&hdev->blacklist);
+	INIT_LIST_HEAD(&hdev->whitelist);
 	INIT_LIST_HEAD(&hdev->uuids);
 	INIT_LIST_HEAD(&hdev->link_keys);
 	INIT_LIST_HEAD(&hdev->long_term_keys);
@@ -4036,6 +4064,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_dev_lock(hdev);
 	hci_bdaddr_list_clear(&hdev->blacklist);
+	hci_bdaddr_list_clear(&hdev->whitelist);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
 	hci_smp_ltks_clear(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 592e73eea76d..431d5e4aa34b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5219,7 +5219,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("%s", hdev->name);
 
-	if (!bdaddr_type_is_le(cp->addr.type) ||
+	if (!bdaddr_type_is_valid(cp->addr.type) ||
 	    !bacmp(&cp->addr.bdaddr, BDADDR_ANY))
 		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
 				    MGMT_STATUS_INVALID_PARAMS,
@@ -5230,8 +5230,26 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 				    MGMT_STATUS_INVALID_PARAMS,
 				    &cp->addr, sizeof(cp->addr));
 
+	if (cp->action != 0x00 && cp->action != 0x01)
+
 	hci_dev_lock(hdev);
 
+	if (cp->addr.type == BDADDR_BREDR) {
+		/* Only "connect" action supported for now */
+		if (cp->action != 0x01) {
+			err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
+					   MGMT_STATUS_INVALID_PARAMS,
+					   &cp->addr, sizeof(cp->addr));
+			goto unlock;
+		}
+
+		err = hci_bdaddr_list_add(&hdev->whitelist, &cp->addr.bdaddr,
+					  cp->addr.type);
+		if (err)
+			goto unlock;
+		goto added;
+	}
+
 	if (cp->addr.type == BDADDR_LE_PUBLIC)
 		addr_type = ADDR_LE_DEV_PUBLIC;
 	else
@@ -5253,6 +5271,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
+added:
 	device_added(sk, hdev, &cp->addr.bdaddr, cp->addr.type, cp->action);
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
@@ -5288,13 +5307,30 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		struct hci_conn_params *params;
 		u8 addr_type;
 
-		if (!bdaddr_type_is_le(cp->addr.type)) {
+		if (!bdaddr_type_is_valid(cp->addr.type)) {
 			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
 					   MGMT_STATUS_INVALID_PARAMS,
 					   &cp->addr, sizeof(cp->addr));
 			goto unlock;
 		}
 
+		if (cp->addr.type == BDADDR_BREDR) {
+			err = hci_bdaddr_list_del(&hdev->whitelist,
+						  &cp->addr.bdaddr,
+						  cp->addr.type);
+			if (err) {
+				err = cmd_complete(sk, hdev->id,
+						   MGMT_OP_REMOVE_DEVICE,
+						   MGMT_STATUS_INVALID_PARAMS,
+						   &cp->addr, sizeof(cp->addr));
+				goto unlock;
+			}
+
+			device_removed(sk, hdev, &cp->addr.bdaddr,
+				       cp->addr.type);
+			goto complete;
+		}
+
 		if (cp->addr.type == BDADDR_LE_PUBLIC)
 			addr_type = ADDR_LE_DEV_PUBLIC;
 		else
@@ -5324,6 +5360,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		device_removed(sk, hdev, &cp->addr.bdaddr, cp->addr.type);
 	} else {
 		struct hci_conn_params *p, *tmp;
+		struct bdaddr_list *b, *btmp;
 
 		if (cp->addr.type) {
 			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
@@ -5332,6 +5369,12 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
+		list_for_each_entry_safe(b, btmp, &hdev->whitelist, list) {
+			device_removed(sk, hdev, &b->bdaddr, b->bdaddr_type);
+			list_del(&b->list);
+			kfree(b);
+		}
+
 		list_for_each_entry_safe(p, tmp, &hdev->le_conn_params, list) {
 			if (p->auto_connect == HCI_AUTO_CONN_DISABLED)
 				continue;
@@ -5346,6 +5389,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		hci_update_background_scan(hdev);
 	}
 
+complete:
 	err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
 			   MGMT_STATUS_SUCCESS, &cp->addr, sizeof(cp->addr));
 
-- 
1.9.3

