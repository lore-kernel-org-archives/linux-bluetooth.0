Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Wed, 24 Aug 2011 10:05:01 -0400
Subject: [RFC 2/4] Bluetooth: Expose hci connections through debugfs
Message-ID: <1314194701.2219.15.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add "connections" file to "hciX" debugfs directory and output
hci_conn internal state.
---
 net/bluetooth/hci_sysfs.c |   46 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 22f1a6c..3d00769 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -542,6 +542,49 @@ static int auto_accept_delay_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
 					auto_accept_delay_set, "%llu\n");
 
+static int connections_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct list_head *l;
+	
+	hci_dev_lock_bh(hdev);
+
+	seq_printf(f, "                          s            a     p\n");
+	seq_printf(f, "                  h   t   t  o  s  k   u  s  s  p  r\n");
+	seq_printf(f, "                  n   y   a  u  s  e   t  e  e  i  e\n");
+	seq_printf(f, "Dest              l   p   t  t  p  y   h  c  c  n  f\n");
+
+	list_for_each(l, &h->list) {
+		struct hci_conn *c;
+		c = list_entry(l, struct hci_conn, list);
+
+		seq_printf(f, "%s %-3d %3s %d  %d  %d 0x%.2x %d  %d  %d %2d  %d\n",
+				batostr(&c->dst), c->handle, 
+				link_typetostr(c->type),
+				c->state, c->out, c->ssp_mode,
+				c->key_type, c->auth_type, c->sec_level,
+				c->pending_sec_level, c->pin_length,
+				atomic_read(&c->devref));
+	}
+
+	hci_dev_unlock_bh(hdev);
+
+	return 0;
+}
+
+static int connections_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, connections_show, inode->i_private);
+}
+
+static const struct file_operations connections_fops = {
+	.open		= connections_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 int hci_register_sysfs(struct hci_dev *hdev)
 {
 	struct device *dev = &hdev->dev;
@@ -578,6 +621,9 @@ int hci_register_sysfs(struct hci_dev *hdev)
 
 	debugfs_create_file("auto_accept_delay", 0444, hdev->debugfs, hdev,
 						&auto_accept_delay_fops);
+
+	debugfs_create_file("connections", 0444, hdev->debugfs, hdev,
+						&connections_fops);
 	return 0;
 }
 
-- 
1.7.4.1

