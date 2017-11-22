Return-Path: <andriy.shevchenko@linux.intel.com>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] Bluetooth: introduce DEFINE_SHOW_ATTRIBUTE() macro
Date: Wed, 22 Nov 2017 23:15:46 +0200
Message-Id: <20171122211546.5682-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This macro deduplicates a lot of similar code across the hci_debugfs.c
module. Targeting to be moved to seq_file.h eventually.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 net/bluetooth/hci_debugfs.c | 184 +++++---------------------------------------
 1 file changed, 18 insertions(+), 166 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 63df63ebfb24..d4174d508cbf 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -88,6 +88,9 @@ static int __name ## _show(struct seq_file *f, void *ptr)		      \
 	return 0;							      \
 }									      \
 									      \
+DEFINE_SHOW_ATTRIBUTE(__name)
+
+#define DEFINE_SHOW_ATTRIBUTE(__name)					      \
 static int __name ## _open(struct inode *inode, struct file *file)	      \
 {									      \
 	return single_open(file, __name ## _show, inode->i_private);	      \
@@ -126,17 +129,7 @@ static int features_show(struct seq_file *f, void *ptr)
 	return 0;
 }
 
-static int features_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, features_show, inode->i_private);
-}
-
-static const struct file_operations features_fops = {
-	.open		= features_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(features);
 
 static int device_id_show(struct seq_file *f, void *ptr)
 {
@@ -150,17 +143,7 @@ static int device_id_show(struct seq_file *f, void *ptr)
 	return 0;
 }
 
-static int device_id_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, device_id_show, inode->i_private);
-}
-
-static const struct file_operations device_id_fops = {
-	.open		= device_id_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(device_id);
 
 static int device_list_show(struct seq_file *f, void *ptr)
 {
@@ -180,17 +163,7 @@ static int device_list_show(struct seq_file *f, void *ptr)
 	return 0;
 }
 
-static int device_list_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, device_list_show, inode->i_private);
-}
-
-static const struct file_operations device_list_fops = {
-	.open		= device_list_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(device_list);
 
 static int blacklist_show(struct seq_file *f, void *p)
 {
@@ -205,17 +178,7 @@ static int blacklist_show(struct seq_file *f, void *p)
 	return 0;
 }
 
-static int blacklist_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, blacklist_show, inode->i_private);
-}
-
-static const struct file_operations blacklist_fops = {
-	.open		= blacklist_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(blacklist);
 
 static int uuids_show(struct seq_file *f, void *p)
 {
@@ -240,17 +203,7 @@ static int uuids_show(struct seq_file *f, void *p)
        return 0;
 }
 
-static int uuids_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, uuids_show, inode->i_private);
-}
-
-static const struct file_operations uuids_fops = {
-	.open		= uuids_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(uuids);
 
 static int remote_oob_show(struct seq_file *f, void *ptr)
 {
@@ -269,17 +222,7 @@ static int remote_oob_show(struct seq_file *f, void *ptr)
 	return 0;
 }
 
-static int remote_oob_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, remote_oob_show, inode->i_private);
-}
-
-static const struct file_operations remote_oob_fops = {
-	.open		= remote_oob_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(remote_oob);
 
 static int conn_info_min_age_set(void *data, u64 val)
 {
@@ -443,17 +386,7 @@ static int inquiry_cache_show(struct seq_file *f, void *p)
 	return 0;
 }
 
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
+DEFINE_SHOW_ATTRIBUTE(inquiry_cache);
 
 static int link_keys_show(struct seq_file *f, void *ptr)
 {
@@ -469,17 +402,7 @@ static int link_keys_show(struct seq_file *f, void *ptr)
 	return 0;
 }
 
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
+DEFINE_SHOW_ATTRIBUTE(link_keys);
 
 static int dev_class_show(struct seq_file *f, void *ptr)
 {
@@ -493,17 +416,7 @@ static int dev_class_show(struct seq_file *f, void *ptr)
 	return 0;
 }
 
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
+DEFINE_SHOW_ATTRIBUTE(dev_class);
 
 static int voice_setting_get(void *data, u64 *val)
 {
@@ -692,17 +605,7 @@ static int identity_show(struct seq_file *f, void *p)
 	return 0;
 }
 
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
+DEFINE_SHOW_ATTRIBUTE(identity);
 
 static int rpa_timeout_set(void *data, u64 val)
 {
@@ -746,17 +649,7 @@ static int random_address_show(struct seq_file *f, void *p)
 	return 0;
 }
 
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
+DEFINE_SHOW_ATTRIBUTE(random_address);
 
 static int static_address_show(struct seq_file *f, void *p)
 {
@@ -769,17 +662,7 @@ static int static_address_show(struct seq_file *f, void *p)
 	return 0;
 }
 
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
+DEFINE_SHOW_ATTRIBUTE(static_address);
 
 static ssize_t force_static_address_read(struct file *file,
 					 char __user *user_buf,
@@ -841,17 +724,7 @@ static int white_list_show(struct seq_file *f, void *ptr)
 	return 0;
 }
 
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
+DEFINE_SHOW_ATTRIBUTE(white_list);
 
 static int identity_resolving_keys_show(struct seq_file *f, void *ptr)
 {
@@ -869,18 +742,7 @@ static int identity_resolving_keys_show(struct seq_file *f, void *ptr)
 	return 0;
 }
 
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
+DEFINE_SHOW_ATTRIBUTE(identity_resolving_keys);
 
 static int long_term_keys_show(struct seq_file *f, void *ptr)
 {
@@ -898,17 +760,7 @@ static int long_term_keys_show(struct seq_file *f, void *ptr)
 	return 0;
 }
 
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
+DEFINE_SHOW_ATTRIBUTE(long_term_keys);
 
 static int conn_min_interval_set(void *data, u64 val)
 {
-- 
2.15.0
