Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Move BR/EDR debugfs file creation into hci_debugfs.c
Date: Sat, 20 Dec 2014 16:05:15 +0100
Message-Id: <1419087916-8968-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves the creation of the debugs files for BR/EDR controllers
into hci_debugfs.c file.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c    | 350 +-------------------------------------------
 net/bluetooth/hci_debugfs.c | 349 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 350 insertions(+), 349 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dde29f4bfaa9..d8976cb01b89 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -139,266 +139,6 @@ static const struct file_operations dut_mode_fops = {
 	.llseek		= default_llseek,
 };
 
-static int inquiry_cache_show(struct seq_file *f, void *p)
-{
-	struct hci_dev *hdev = f->private;
-	struct discovery_state *cache = &hdev->discovery;
-	struct inquiry_entry *e;
-
-	hci_dev_lock(hdev);
-
-	list_for_each_entry(e, &cache->all, all) {
-		struct inquiry_data *data = &e->data;
-		seq_printf(f, "%pMR %d %d %d 0x%.2x%.2x%.2x 0x%.4x %d %d %u\n",
-			   &data->bdaddr,
-			   data->pscan_rep_mode, data->pscan_period_mode,
-			   data->pscan_mode, data->dev_class[2],
-			   data->dev_class[1], data->dev_class[0],
-			   __le16_to_cpu(data->clock_offset),
-			   data->rssi, data->ssp_mode, e->timestamp);
-	}
-
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int inquiry_cache_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, inquiry_cache_show, inode->i_private);
-}
-
-static const struct file_operations inquiry_cache_fops = {
-	.open		= inquiry_cache_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int link_keys_show(struct seq_file *f, void *ptr)
-{
-	struct hci_dev *hdev = f->private;
-	struct link_key *key;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(key, &hdev->link_keys, list)
-		seq_printf(f, "%pMR %u %*phN %u\n", &key->bdaddr, key->type,
-			   HCI_LINK_KEY_SIZE, key->val, key->pin_len);
-	rcu_read_unlock();
-
-	return 0;
-}
-
-static int link_keys_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, link_keys_show, inode->i_private);
-}
-
-static const struct file_operations link_keys_fops = {
-	.open		= link_keys_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int dev_class_show(struct seq_file *f, void *ptr)
-{
-	struct hci_dev *hdev = f->private;
-
-	hci_dev_lock(hdev);
-	seq_printf(f, "0x%.2x%.2x%.2x\n", hdev->dev_class[2],
-		   hdev->dev_class[1], hdev->dev_class[0]);
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int dev_class_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dev_class_show, inode->i_private);
-}
-
-static const struct file_operations dev_class_fops = {
-	.open		= dev_class_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int voice_setting_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->voice_setting;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(voice_setting_fops, voice_setting_get,
-			NULL, "0x%4.4llx\n");
-
-static int auto_accept_delay_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	hdev->auto_accept_delay = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int auto_accept_delay_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->auto_accept_delay;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
-			auto_accept_delay_set, "%llu\n");
-
-static ssize_t force_sc_support_read(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[3];
-
-	buf[0] = test_bit(HCI_FORCE_SC, &hdev->dbg_flags) ? 'Y': 'N';
-	buf[1] = '\n';
-	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-static ssize_t force_sc_support_write(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
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
-	if (enable == test_bit(HCI_FORCE_SC, &hdev->dbg_flags))
-		return -EALREADY;
-
-	change_bit(HCI_FORCE_SC, &hdev->dbg_flags);
-
-	return count;
-}
-
-static const struct file_operations force_sc_support_fops = {
-	.open		= simple_open,
-	.read		= force_sc_support_read,
-	.write		= force_sc_support_write,
-	.llseek		= default_llseek,
-};
-
-static ssize_t force_lesc_support_read(struct file *file, char __user *user_buf,
-				       size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[3];
-
-	buf[0] = test_bit(HCI_FORCE_LESC, &hdev->dbg_flags) ? 'Y': 'N';
-	buf[1] = '\n';
-	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-static ssize_t force_lesc_support_write(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[32];
-	size_t buf_size = min(count, (sizeof(buf)-1));
-	bool enable;
-
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-	if (strtobool(buf, &enable))
-		return -EINVAL;
-
-	if (enable == test_bit(HCI_FORCE_LESC, &hdev->dbg_flags))
-		return -EALREADY;
-
-	change_bit(HCI_FORCE_LESC, &hdev->dbg_flags);
-
-	return count;
-}
-
-static const struct file_operations force_lesc_support_fops = {
-	.open		= simple_open,
-	.read		= force_lesc_support_read,
-	.write		= force_lesc_support_write,
-	.llseek		= default_llseek,
-};
-
-static ssize_t sc_only_mode_read(struct file *file, char __user *user_buf,
-				 size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[3];
-
-	buf[0] = test_bit(HCI_SC_ONLY, &hdev->dev_flags) ? 'Y': 'N';
-	buf[1] = '\n';
-	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-static const struct file_operations sc_only_mode_fops = {
-	.open		= simple_open,
-	.read		= sc_only_mode_read,
-	.llseek		= default_llseek,
-};
-
-static int idle_timeout_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	if (val != 0 && (val < 500 || val > 3600000))
-		return -EINVAL;
-
-	hci_dev_lock(hdev);
-	hdev->idle_timeout = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int idle_timeout_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->idle_timeout;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(idle_timeout_fops, idle_timeout_get,
-			idle_timeout_set, "%llu\n");
-
 static int rpa_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -430,62 +170,6 @@ static int rpa_timeout_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(rpa_timeout_fops, rpa_timeout_get,
 			rpa_timeout_set, "%llu\n");
 
-static int sniff_min_interval_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	if (val == 0 || val % 2 || val > hdev->sniff_max_interval)
-		return -EINVAL;
-
-	hci_dev_lock(hdev);
-	hdev->sniff_min_interval = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int sniff_min_interval_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->sniff_min_interval;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(sniff_min_interval_fops, sniff_min_interval_get,
-			sniff_min_interval_set, "%llu\n");
-
-static int sniff_max_interval_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
-		return -EINVAL;
-
-	hci_dev_lock(hdev);
-	hdev->sniff_max_interval = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int sniff_max_interval_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->sniff_max_interval;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(sniff_max_interval_fops, sniff_max_interval_get,
-			sniff_max_interval_set, "%llu\n");
-
 static int identity_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
@@ -1667,40 +1351,8 @@ static int __hci_init(struct hci_dev *hdev)
 
 	hci_debugfs_create_common(hdev);
 
-	if (lmp_bredr_capable(hdev)) {
-		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
-				    hdev, &inquiry_cache_fops);
-		debugfs_create_file("link_keys", 0400, hdev->debugfs,
-				    hdev, &link_keys_fops);
-		debugfs_create_file("dev_class", 0444, hdev->debugfs,
-				    hdev, &dev_class_fops);
-		debugfs_create_file("voice_setting", 0444, hdev->debugfs,
-				    hdev, &voice_setting_fops);
-
+	if (lmp_bredr_capable(hdev))
 		hci_debugfs_create_bredr(hdev);
-	}
-
-	if (lmp_ssp_capable(hdev)) {
-		debugfs_create_file("auto_accept_delay", 0644, hdev->debugfs,
-				    hdev, &auto_accept_delay_fops);
-		debugfs_create_file("force_sc_support", 0644, hdev->debugfs,
-				    hdev, &force_sc_support_fops);
-		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
-				    hdev, &sc_only_mode_fops);
-		if (lmp_le_capable(hdev))
-			debugfs_create_file("force_lesc_support", 0644,
-					    hdev->debugfs, hdev,
-					    &force_lesc_support_fops);
-	}
-
-	if (lmp_sniff_capable(hdev)) {
-		debugfs_create_file("idle_timeout", 0644, hdev->debugfs,
-				    hdev, &idle_timeout_fops);
-		debugfs_create_file("sniff_min_interval", 0644, hdev->debugfs,
-				    hdev, &sniff_min_interval_fops);
-		debugfs_create_file("sniff_max_interval", 0644, hdev->debugfs,
-				    hdev, &sniff_max_interval_fops);
-	}
 
 	if (lmp_le_capable(hdev)) {
 		debugfs_create_file("identity", 0400, hdev->debugfs,
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 4d06beef8c53..435f091301cd 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -232,8 +232,357 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
 			    &conn_info_max_age_fops);
 }
 
+static int inquiry_cache_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	struct discovery_state *cache = &hdev->discovery;
+	struct inquiry_entry *e;
+
+	hci_dev_lock(hdev);
+
+	list_for_each_entry(e, &cache->all, all) {
+		struct inquiry_data *data = &e->data;
+		seq_printf(f, "%pMR %d %d %d 0x%.2x%.2x%.2x 0x%.4x %d %d %u\n",
+			   &data->bdaddr,
+			   data->pscan_rep_mode, data->pscan_period_mode,
+			   data->pscan_mode, data->dev_class[2],
+			   data->dev_class[1], data->dev_class[0],
+			   __le16_to_cpu(data->clock_offset),
+			   data->rssi, data->ssp_mode, e->timestamp);
+	}
+
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int inquiry_cache_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, inquiry_cache_show, inode->i_private);
+}
+
+static const struct file_operations inquiry_cache_fops = {
+	.open		= inquiry_cache_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int link_keys_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+	struct link_key *key;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(key, &hdev->link_keys, list)
+		seq_printf(f, "%pMR %u %*phN %u\n", &key->bdaddr, key->type,
+			   HCI_LINK_KEY_SIZE, key->val, key->pin_len);
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int link_keys_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, link_keys_show, inode->i_private);
+}
+
+static const struct file_operations link_keys_fops = {
+	.open		= link_keys_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int dev_class_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+
+	hci_dev_lock(hdev);
+	seq_printf(f, "0x%.2x%.2x%.2x\n", hdev->dev_class[2],
+		   hdev->dev_class[1], hdev->dev_class[0]);
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int dev_class_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dev_class_show, inode->i_private);
+}
+
+static const struct file_operations dev_class_fops = {
+	.open		= dev_class_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int voice_setting_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->voice_setting;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(voice_setting_fops, voice_setting_get,
+			NULL, "0x%4.4llx\n");
+
+static int auto_accept_delay_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	hdev->auto_accept_delay = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int auto_accept_delay_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->auto_accept_delay;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
+			auto_accept_delay_set, "%llu\n");
+
+static ssize_t sc_only_mode_read(struct file *file, char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = test_bit(HCI_SC_ONLY, &hdev->dev_flags) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static const struct file_operations sc_only_mode_fops = {
+	.open		= simple_open,
+	.read		= sc_only_mode_read,
+	.llseek		= default_llseek,
+};
+
+static ssize_t force_sc_support_read(struct file *file, char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = test_bit(HCI_FORCE_SC, &hdev->dbg_flags) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_sc_support_write(struct file *file,
+				      const char __user *user_buf,
+				      size_t count, loff_t *ppos)
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
+	if (enable == test_bit(HCI_FORCE_SC, &hdev->dbg_flags))
+		return -EALREADY;
+
+	change_bit(HCI_FORCE_SC, &hdev->dbg_flags);
+
+	return count;
+}
+
+static const struct file_operations force_sc_support_fops = {
+	.open		= simple_open,
+	.read		= force_sc_support_read,
+	.write		= force_sc_support_write,
+	.llseek		= default_llseek,
+};
+
+static ssize_t force_lesc_support_read(struct file *file,
+				       char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = test_bit(HCI_FORCE_LESC, &hdev->dbg_flags) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_lesc_support_write(struct file *file,
+					const char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[32];
+	size_t buf_size = min(count, (sizeof(buf)-1));
+	bool enable;
+
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	if (strtobool(buf, &enable))
+		return -EINVAL;
+
+	if (enable == test_bit(HCI_FORCE_LESC, &hdev->dbg_flags))
+		return -EALREADY;
+
+	change_bit(HCI_FORCE_LESC, &hdev->dbg_flags);
+
+	return count;
+}
+
+static const struct file_operations force_lesc_support_fops = {
+	.open		= simple_open,
+	.read		= force_lesc_support_read,
+	.write		= force_lesc_support_write,
+	.llseek		= default_llseek,
+};
+
+static int idle_timeout_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val != 0 && (val < 500 || val > 3600000))
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->idle_timeout = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int idle_timeout_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->idle_timeout;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(idle_timeout_fops, idle_timeout_get,
+			idle_timeout_set, "%llu\n");
+
+static int sniff_min_interval_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val == 0 || val % 2 || val > hdev->sniff_max_interval)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->sniff_min_interval = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int sniff_min_interval_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->sniff_min_interval;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(sniff_min_interval_fops, sniff_min_interval_get,
+			sniff_min_interval_set, "%llu\n");
+
+static int sniff_max_interval_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->sniff_max_interval = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int sniff_max_interval_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->sniff_max_interval;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(sniff_max_interval_fops, sniff_max_interval_get,
+			sniff_max_interval_set, "%llu\n");
+
 void hci_debugfs_create_bredr(struct hci_dev *hdev)
 {
+	debugfs_create_file("inquiry_cache", 0444, hdev->debugfs, hdev,
+			    &inquiry_cache_fops);
+	debugfs_create_file("link_keys", 0400, hdev->debugfs, hdev,
+			    &link_keys_fops);
+	debugfs_create_file("dev_class", 0444, hdev->debugfs, hdev,
+			    &dev_class_fops);
+	debugfs_create_file("voice_setting", 0444, hdev->debugfs, hdev,
+			    &voice_setting_fops);
+
+	if (lmp_ssp_capable(hdev)) {
+		debugfs_create_file("auto_accept_delay", 0644, hdev->debugfs,
+				    hdev, &auto_accept_delay_fops);
+		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
+				    hdev, &sc_only_mode_fops);
+
+		debugfs_create_file("force_sc_support", 0644, hdev->debugfs,
+				    hdev, &force_sc_support_fops);
+
+		if (lmp_le_capable(hdev))
+			debugfs_create_file("force_lesc_support", 0644,
+					    hdev->debugfs, hdev,
+					    &force_lesc_support_fops);
+	}
+
+	if (lmp_sniff_capable(hdev)) {
+		debugfs_create_file("idle_timeout", 0644, hdev->debugfs,
+				    hdev, &idle_timeout_fops);
+		debugfs_create_file("sniff_min_interval", 0644, hdev->debugfs,
+				    hdev, &sniff_min_interval_fops);
+		debugfs_create_file("sniff_max_interval", 0644, hdev->debugfs,
+				    hdev, &sniff_max_interval_fops);
+	}
 }
 
 void hci_debugfs_create_le(struct hci_dev *hdev)
-- 
2.1.0

