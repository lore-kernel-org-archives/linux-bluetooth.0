Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Move LE debugfs file creation into hci_debugfs.c
Date: Sat, 20 Dec 2014 16:05:16 +0100
Message-Id: <1419087916-8968-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves the creation of the debugs files for LE controllers
into hci_debugfs.c file.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c    | 478 --------------------------------------------
 net/bluetooth/hci_debugfs.c | 474 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 474 insertions(+), 478 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d8976cb01b89..2db071b2f0f4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -139,438 +139,6 @@ static const struct file_operations dut_mode_fops = {
 	.llseek		= default_llseek,
 };
 
-static int rpa_timeout_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	/* Require the RPA timeout to be at least 30 seconds and at most
-	 * 24 hours.
-	 */
-	if (val < 30 || val > (60 * 60 * 24))
-		return -EINVAL;
-
-	hci_dev_lock(hdev);
-	hdev->rpa_timeout = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int rpa_timeout_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->rpa_timeout;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(rpa_timeout_fops, rpa_timeout_get,
-			rpa_timeout_set, "%llu\n");
-
-static int identity_show(struct seq_file *f, void *p)
-{
-	struct hci_dev *hdev = f->private;
-	bdaddr_t addr;
-	u8 addr_type;
-
-	hci_dev_lock(hdev);
-
-	hci_copy_identity_address(hdev, &addr, &addr_type);
-
-	seq_printf(f, "%pMR (type %u) %*phN %pMR\n", &addr, addr_type,
-		   16, hdev->irk, &hdev->rpa);
-
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int identity_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, identity_show, inode->i_private);
-}
-
-static const struct file_operations identity_fops = {
-	.open		= identity_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int random_address_show(struct seq_file *f, void *p)
-{
-	struct hci_dev *hdev = f->private;
-
-	hci_dev_lock(hdev);
-	seq_printf(f, "%pMR\n", &hdev->random_addr);
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int random_address_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, random_address_show, inode->i_private);
-}
-
-static const struct file_operations random_address_fops = {
-	.open		= random_address_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int static_address_show(struct seq_file *f, void *p)
-{
-	struct hci_dev *hdev = f->private;
-
-	hci_dev_lock(hdev);
-	seq_printf(f, "%pMR\n", &hdev->static_addr);
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int static_address_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, static_address_show, inode->i_private);
-}
-
-static const struct file_operations static_address_fops = {
-	.open		= static_address_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static ssize_t force_static_address_read(struct file *file,
-					 char __user *user_buf,
-					 size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[3];
-
-	buf[0] = test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ? 'Y': 'N';
-	buf[1] = '\n';
-	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-static ssize_t force_static_address_write(struct file *file,
-					  const char __user *user_buf,
-					  size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[32];
-	size_t buf_size = min(count, (sizeof(buf)-1));
-	bool enable;
-
-	if (test_bit(HCI_UP, &hdev->flags))
-		return -EBUSY;
-
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-	if (strtobool(buf, &enable))
-		return -EINVAL;
-
-	if (enable == test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags))
-		return -EALREADY;
-
-	change_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags);
-
-	return count;
-}
-
-static const struct file_operations force_static_address_fops = {
-	.open		= simple_open,
-	.read		= force_static_address_read,
-	.write		= force_static_address_write,
-	.llseek		= default_llseek,
-};
-
-static int white_list_show(struct seq_file *f, void *ptr)
-{
-	struct hci_dev *hdev = f->private;
-	struct bdaddr_list *b;
-
-	hci_dev_lock(hdev);
-	list_for_each_entry(b, &hdev->le_white_list, list)
-		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int white_list_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, white_list_show, inode->i_private);
-}
-
-static const struct file_operations white_list_fops = {
-	.open		= white_list_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int identity_resolving_keys_show(struct seq_file *f, void *ptr)
-{
-	struct hci_dev *hdev = f->private;
-	struct smp_irk *irk;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
-		seq_printf(f, "%pMR (type %u) %*phN %pMR\n",
-			   &irk->bdaddr, irk->addr_type,
-			   16, irk->val, &irk->rpa);
-	}
-	rcu_read_unlock();
-
-	return 0;
-}
-
-static int identity_resolving_keys_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, identity_resolving_keys_show,
-			   inode->i_private);
-}
-
-static const struct file_operations identity_resolving_keys_fops = {
-	.open		= identity_resolving_keys_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int long_term_keys_show(struct seq_file *f, void *ptr)
-{
-	struct hci_dev *hdev = f->private;
-	struct smp_ltk *ltk;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(ltk, &hdev->long_term_keys, list)
-		seq_printf(f, "%pMR (type %u) %u 0x%02x %u %.4x %.16llx %*phN\n",
-			   &ltk->bdaddr, ltk->bdaddr_type, ltk->authenticated,
-			   ltk->type, ltk->enc_size, __le16_to_cpu(ltk->ediv),
-			   __le64_to_cpu(ltk->rand), 16, ltk->val);
-	rcu_read_unlock();
-
-	return 0;
-}
-
-static int long_term_keys_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, long_term_keys_show, inode->i_private);
-}
-
-static const struct file_operations long_term_keys_fops = {
-	.open		= long_term_keys_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int conn_min_interval_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval)
-		return -EINVAL;
-
-	hci_dev_lock(hdev);
-	hdev->le_conn_min_interval = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int conn_min_interval_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->le_conn_min_interval;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(conn_min_interval_fops, conn_min_interval_get,
-			conn_min_interval_set, "%llu\n");
-
-static int conn_max_interval_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval)
-		return -EINVAL;
-
-	hci_dev_lock(hdev);
-	hdev->le_conn_max_interval = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int conn_max_interval_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->le_conn_max_interval;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(conn_max_interval_fops, conn_max_interval_get,
-			conn_max_interval_set, "%llu\n");
-
-static int conn_latency_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	if (val > 0x01f3)
-		return -EINVAL;
-
-	hci_dev_lock(hdev);
-	hdev->le_conn_latency = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int conn_latency_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->le_conn_latency;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(conn_latency_fops, conn_latency_get,
-			conn_latency_set, "%llu\n");
-
-static int supervision_timeout_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	if (val < 0x000a || val > 0x0c80)
-		return -EINVAL;
-
-	hci_dev_lock(hdev);
-	hdev->le_supv_timeout = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int supervision_timeout_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->le_supv_timeout;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(supervision_timeout_fops, supervision_timeout_get,
-			supervision_timeout_set, "%llu\n");
-
-static int adv_channel_map_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	if (val < 0x01 || val > 0x07)
-		return -EINVAL;
-
-	hci_dev_lock(hdev);
-	hdev->le_adv_channel_map = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int adv_channel_map_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->le_adv_channel_map;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(adv_channel_map_fops, adv_channel_map_get,
-			adv_channel_map_set, "%llu\n");
-
-static int adv_min_interval_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interval)
-		return -EINVAL;
-
-	hci_dev_lock(hdev);
-	hdev->le_adv_min_interval = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int adv_min_interval_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->le_adv_min_interval;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(adv_min_interval_fops, adv_min_interval_get,
-			adv_min_interval_set, "%llu\n");
-
-static int adv_max_interval_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interval)
-		return -EINVAL;
-
-	hci_dev_lock(hdev);
-	hdev->le_adv_max_interval = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int adv_max_interval_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->le_adv_max_interval;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(adv_max_interval_fops, adv_max_interval_get,
-			adv_max_interval_set, "%llu\n");
-
 /* ---- HCI requests ---- */
 
 static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
@@ -1355,53 +923,7 @@ static int __hci_init(struct hci_dev *hdev)
 		hci_debugfs_create_bredr(hdev);
 
 	if (lmp_le_capable(hdev)) {
-		debugfs_create_file("identity", 0400, hdev->debugfs,
-				    hdev, &identity_fops);
-		debugfs_create_file("rpa_timeout", 0644, hdev->debugfs,
-				    hdev, &rpa_timeout_fops);
-		debugfs_create_file("random_address", 0444, hdev->debugfs,
-				    hdev, &random_address_fops);
-		debugfs_create_file("static_address", 0444, hdev->debugfs,
-				    hdev, &static_address_fops);
-
-		/* For controllers with a public address, provide a debug
-		 * option to force the usage of the configured static
-		 * address. By default the public address is used.
-		 */
-		if (bacmp(&hdev->bdaddr, BDADDR_ANY))
-			debugfs_create_file("force_static_address", 0644,
-					    hdev->debugfs, hdev,
-					    &force_static_address_fops);
-
-		debugfs_create_u8("white_list_size", 0444, hdev->debugfs,
-				  &hdev->le_white_list_size);
-		debugfs_create_file("white_list", 0444, hdev->debugfs, hdev,
-				    &white_list_fops);
-		debugfs_create_file("identity_resolving_keys", 0400,
-				    hdev->debugfs, hdev,
-				    &identity_resolving_keys_fops);
-		debugfs_create_file("long_term_keys", 0400, hdev->debugfs,
-				    hdev, &long_term_keys_fops);
-		debugfs_create_file("conn_min_interval", 0644, hdev->debugfs,
-				    hdev, &conn_min_interval_fops);
-		debugfs_create_file("conn_max_interval", 0644, hdev->debugfs,
-				    hdev, &conn_max_interval_fops);
-		debugfs_create_file("conn_latency", 0644, hdev->debugfs,
-				    hdev, &conn_latency_fops);
-		debugfs_create_file("supervision_timeout", 0644, hdev->debugfs,
-				    hdev, &supervision_timeout_fops);
-		debugfs_create_file("adv_channel_map", 0644, hdev->debugfs,
-				    hdev, &adv_channel_map_fops);
-		debugfs_create_file("adv_min_interval", 0644, hdev->debugfs,
-				    hdev, &adv_min_interval_fops);
-		debugfs_create_file("adv_max_interval", 0644, hdev->debugfs,
-				    hdev, &adv_max_interval_fops);
-		debugfs_create_u16("discov_interleaved_timeout", 0644,
-				   hdev->debugfs,
-				   &hdev->discov_interleaved_timeout);
-
 		hci_debugfs_create_le(hdev);
-
 		smp_register(hdev);
 	}
 
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 435f091301cd..a7a0db03b0b8 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -585,6 +585,480 @@ void hci_debugfs_create_bredr(struct hci_dev *hdev)
 	}
 }
 
+static int identity_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	bdaddr_t addr;
+	u8 addr_type;
+
+	hci_dev_lock(hdev);
+
+	hci_copy_identity_address(hdev, &addr, &addr_type);
+
+	seq_printf(f, "%pMR (type %u) %*phN %pMR\n", &addr, addr_type,
+		   16, hdev->irk, &hdev->rpa);
+
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int identity_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, identity_show, inode->i_private);
+}
+
+static const struct file_operations identity_fops = {
+	.open		= identity_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int rpa_timeout_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	/* Require the RPA timeout to be at least 30 seconds and at most
+	 * 24 hours.
+	 */
+	if (val < 30 || val > (60 * 60 * 24))
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->rpa_timeout = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int rpa_timeout_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->rpa_timeout;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(rpa_timeout_fops, rpa_timeout_get,
+			rpa_timeout_set, "%llu\n");
+
+static int random_address_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+
+	hci_dev_lock(hdev);
+	seq_printf(f, "%pMR\n", &hdev->random_addr);
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int random_address_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, random_address_show, inode->i_private);
+}
+
+static const struct file_operations random_address_fops = {
+	.open		= random_address_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int static_address_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+
+	hci_dev_lock(hdev);
+	seq_printf(f, "%pMR\n", &hdev->static_addr);
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int static_address_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, static_address_show, inode->i_private);
+}
+
+static const struct file_operations static_address_fops = {
+	.open		= static_address_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static ssize_t force_static_address_read(struct file *file,
+					 char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_static_address_write(struct file *file,
+					  const char __user *user_buf,
+					  size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[32];
+	size_t buf_size = min(count, (sizeof(buf)-1));
+	bool enable;
+
+	if (test_bit(HCI_UP, &hdev->flags))
+		return -EBUSY;
+
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	if (strtobool(buf, &enable))
+		return -EINVAL;
+
+	if (enable == test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags))
+		return -EALREADY;
+
+	change_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags);
+
+	return count;
+}
+
+static const struct file_operations force_static_address_fops = {
+	.open		= simple_open,
+	.read		= force_static_address_read,
+	.write		= force_static_address_write,
+	.llseek		= default_llseek,
+};
+
+static int white_list_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+	struct bdaddr_list *b;
+
+	hci_dev_lock(hdev);
+	list_for_each_entry(b, &hdev->le_white_list, list)
+		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int white_list_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, white_list_show, inode->i_private);
+}
+
+static const struct file_operations white_list_fops = {
+	.open		= white_list_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int identity_resolving_keys_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+	struct smp_irk *irk;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
+		seq_printf(f, "%pMR (type %u) %*phN %pMR\n",
+			   &irk->bdaddr, irk->addr_type,
+			   16, irk->val, &irk->rpa);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int identity_resolving_keys_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, identity_resolving_keys_show,
+			   inode->i_private);
+}
+
+static const struct file_operations identity_resolving_keys_fops = {
+	.open		= identity_resolving_keys_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int long_term_keys_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+	struct smp_ltk *ltk;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ltk, &hdev->long_term_keys, list)
+		seq_printf(f, "%pMR (type %u) %u 0x%02x %u %.4x %.16llx %*phN\n",
+			   &ltk->bdaddr, ltk->bdaddr_type, ltk->authenticated,
+			   ltk->type, ltk->enc_size, __le16_to_cpu(ltk->ediv),
+			   __le64_to_cpu(ltk->rand), 16, ltk->val);
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int long_term_keys_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, long_term_keys_show, inode->i_private);
+}
+
+static const struct file_operations long_term_keys_fops = {
+	.open		= long_term_keys_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int conn_min_interval_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_conn_min_interval = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int conn_min_interval_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_conn_min_interval;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(conn_min_interval_fops, conn_min_interval_get,
+			conn_min_interval_set, "%llu\n");
+
+static int conn_max_interval_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_conn_max_interval = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int conn_max_interval_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_conn_max_interval;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(conn_max_interval_fops, conn_max_interval_get,
+			conn_max_interval_set, "%llu\n");
+
+static int conn_latency_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val > 0x01f3)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_conn_latency = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int conn_latency_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_conn_latency;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(conn_latency_fops, conn_latency_get,
+			conn_latency_set, "%llu\n");
+
+static int supervision_timeout_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 0x000a || val > 0x0c80)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_supv_timeout = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int supervision_timeout_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_supv_timeout;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(supervision_timeout_fops, supervision_timeout_get,
+			supervision_timeout_set, "%llu\n");
+
+static int adv_channel_map_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 0x01 || val > 0x07)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_adv_channel_map = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int adv_channel_map_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_adv_channel_map;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(adv_channel_map_fops, adv_channel_map_get,
+			adv_channel_map_set, "%llu\n");
+
+static int adv_min_interval_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interval)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_adv_min_interval = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int adv_min_interval_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_adv_min_interval;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(adv_min_interval_fops, adv_min_interval_get,
+			adv_min_interval_set, "%llu\n");
+
+static int adv_max_interval_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interval)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_adv_max_interval = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int adv_max_interval_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_adv_max_interval;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(adv_max_interval_fops, adv_max_interval_get,
+			adv_max_interval_set, "%llu\n");
+
 void hci_debugfs_create_le(struct hci_dev *hdev)
 {
+	debugfs_create_file("identity", 0400, hdev->debugfs, hdev,
+			    &identity_fops);
+	debugfs_create_file("rpa_timeout", 0644, hdev->debugfs, hdev,
+			    &rpa_timeout_fops);
+	debugfs_create_file("random_address", 0444, hdev->debugfs, hdev,
+			    &random_address_fops);
+	debugfs_create_file("static_address", 0444, hdev->debugfs, hdev,
+			    &static_address_fops);
+
+	/* For controllers with a public address, provide a debug
+	 * option to force the usage of the configured static
+	 * address. By default the public address is used.
+	 */
+	if (bacmp(&hdev->bdaddr, BDADDR_ANY))
+		debugfs_create_file("force_static_address", 0644,
+				    hdev->debugfs, hdev,
+				    &force_static_address_fops);
+
+	debugfs_create_u8("white_list_size", 0444, hdev->debugfs,
+			  &hdev->le_white_list_size);
+	debugfs_create_file("white_list", 0444, hdev->debugfs, hdev,
+			    &white_list_fops);
+	debugfs_create_file("identity_resolving_keys", 0400, hdev->debugfs,
+			    hdev, &identity_resolving_keys_fops);
+	debugfs_create_file("long_term_keys", 0400, hdev->debugfs, hdev,
+			    &long_term_keys_fops);
+	debugfs_create_file("conn_min_interval", 0644, hdev->debugfs, hdev,
+			    &conn_min_interval_fops);
+	debugfs_create_file("conn_max_interval", 0644, hdev->debugfs, hdev,
+			    &conn_max_interval_fops);
+	debugfs_create_file("conn_latency", 0644, hdev->debugfs, hdev,
+			    &conn_latency_fops);
+	debugfs_create_file("supervision_timeout", 0644, hdev->debugfs, hdev,
+			    &supervision_timeout_fops);
+	debugfs_create_file("adv_channel_map", 0644, hdev->debugfs, hdev,
+			    &adv_channel_map_fops);
+	debugfs_create_file("adv_min_interval", 0644, hdev->debugfs, hdev,
+			    &adv_min_interval_fops);
+	debugfs_create_file("adv_max_interval", 0644, hdev->debugfs, hdev,
+			    &adv_max_interval_fops);
+	debugfs_create_u16("discov_interleaved_timeout", 0644, hdev->debugfs,
+			   &hdev->discov_interleaved_timeout);
 }
-- 
2.1.0

