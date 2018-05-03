Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] Bluetooth: Re-use kstrtobool_from_user()
Date: Thu,  3 May 2018 14:46:47 +0300
Message-Id: <20180503114647.30315-1-andriy.shevchenko@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Re-use kstrtobool_from_user() instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bluetooth/btmrvl_debugfs.c | 12 ++++--------
 net/bluetooth/hci_core.c           | 23 +++++++----------------
 net/bluetooth/hci_debugfs.c        | 24 ++++++++----------------
 net/bluetooth/smp.c                | 12 ++++--------
 4 files changed, 23 insertions(+), 48 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index 1828ed8cae7a..2f15546dd4fa 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -171,16 +171,12 @@ static ssize_t btmrvl_fwdump_write(struct file *file, const char __user *ubuf,
 				   size_t count, loff_t *ppos)
 {
 	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
 	bool result;
+	int err;
 
-	memset(buf, 0, sizeof(buf));
-
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
-	if (strtobool(buf, &result))
-		return -EINVAL;
+	err = kstrtobool_from_user(ubuf, count, &result);
+	if (err)
+		return err;
 
 	if (!result)
 		return -EINVAL;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b0ee9edaae35..1dec33790198 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -76,19 +76,15 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 {
 	struct hci_dev *hdev = file->private_data;
 	struct sk_buff *skb;
-	char buf[32];
-	size_t buf_size = min(count, (sizeof(buf)-1));
 	bool enable;
+	int err;
 
 	if (!test_bit(HCI_UP, &hdev->flags))
 		return -ENETDOWN;
 
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-	if (strtobool(buf, &enable))
-		return -EINVAL;
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
 
 	if (enable == hci_dev_test_flag(hdev, HCI_DUT_MODE))
 		return -EALREADY;
@@ -135,17 +131,12 @@ static ssize_t vendor_diag_write(struct file *file, const char __user *user_buf,
 				 size_t count, loff_t *ppos)
 {
 	struct hci_dev *hdev = file->private_data;
-	char buf[32];
-	size_t buf_size = min(count, (sizeof(buf)-1));
 	bool enable;
 	int err;
 
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-	if (strtobool(buf, &enable))
-		return -EINVAL;
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
 
 	/* When the diagnostic flags are not persistent and the transport
 	 * is not active or in user channel operation, then there is no need
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 418b76e557b0..0d8ab5b3c177 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -47,19 +47,15 @@ static ssize_t __name ## _write(struct file *file,			      \
 				 size_t count, loff_t *ppos)		      \
 {									      \
 	struct hci_dev *hdev = file->private_data;			      \
-	char buf[32];							      \
-	size_t buf_size = min(count, (sizeof(buf) - 1));		      \
 	bool enable;							      \
+	int err;							      \
 									      \
 	if (test_bit(HCI_UP, &hdev->flags))				      \
 		return -EBUSY;						      \
 									      \
-	if (copy_from_user(buf, user_buf, buf_size))			      \
-		return -EFAULT;						      \
-									      \
-	buf[buf_size] = '\0';						      \
-	if (strtobool(buf, &enable))					      \
-		return -EINVAL;						      \
+	err = kstrtobool_from_user(user_buf, count, &enable);		      \
+	if (err)							      \
+		return err;						      \
 									      \
 	if (enable == test_bit(__quirk, &hdev->quirks))			      \
 		return -EALREADY;					      \
@@ -658,19 +654,15 @@ static ssize_t force_static_address_write(struct file *file,
 					  size_t count, loff_t *ppos)
 {
 	struct hci_dev *hdev = file->private_data;
-	char buf[32];
-	size_t buf_size = min(count, (sizeof(buf)-1));
 	bool enable;
+	int err;
 
 	if (test_bit(HCI_UP, &hdev->flags))
 		return -EBUSY;
 
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-	if (strtobool(buf, &enable))
-		return -EINVAL;
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
 
 	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR))
 		return -EALREADY;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a2ddae2f37d7..ae91e2d40056 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3315,16 +3315,12 @@ static ssize_t force_bredr_smp_write(struct file *file,
 				     size_t count, loff_t *ppos)
 {
 	struct hci_dev *hdev = file->private_data;
-	char buf[32];
-	size_t buf_size = min(count, (sizeof(buf)-1));
 	bool enable;
+	int err;
 
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-	if (strtobool(buf, &enable))
-		return -EINVAL;
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
 
 	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
 		return -EALREADY;
-- 
2.17.0

