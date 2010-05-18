Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Subject: [PATCH] Bluetooth: Add debugfs support for showing the blacklist
Date: Tue, 18 May 2010 13:54:49 +0200
Message-Id: <1274183689-28238-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds a debugfs blacklist entry for each HCI device which can
be used to list the current content of the blacklist.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_sysfs.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 0e8e1a5..4fd47e9 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -444,6 +444,41 @@ static const struct file_operations inquiry_cache_fops = {
 	.release	= single_release,
 };
 
+static int blacklist_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	struct bdaddr_list *blacklist = &hdev->blacklist;
+	struct list_head *l;
+
+	hci_dev_lock_bh(hdev);
+
+	list_for_each(l, &blacklist->list) {
+		struct bdaddr_list *b;
+		bdaddr_t bdaddr;
+
+		b = list_entry(l, struct bdaddr_list, list);
+
+		baswap(&bdaddr, &b->bdaddr);
+
+		seq_printf(f, "%s\n", batostr(&bdaddr));
+	}
+
+	hci_dev_unlock_bh(hdev);
+
+	return 0;
+}
+
+static int blacklist_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, blacklist_show, inode->i_private);
+}
+
+static const struct file_operations blacklist_fops = {
+	.open		= blacklist_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 int hci_register_sysfs(struct hci_dev *hdev)
 {
 	struct device *dev = &hdev->dev;
@@ -473,6 +508,9 @@ int hci_register_sysfs(struct hci_dev *hdev)
 	debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
 						hdev, &inquiry_cache_fops);
 
+	debugfs_create_file("blacklist", 0444, hdev->debugfs,
+						hdev, &blacklist_fops);
+
 	return 0;
 }
 
-- 
1.7.0.4

