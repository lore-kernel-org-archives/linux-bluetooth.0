Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Replace own_address_type with force_static_address debugfs
Date: Wed, 19 Feb 2014 19:31:26 -0800
Message-Id: <1392867086-23388-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The own_address_type debugfs option does not providing enough
flexibity for interacting with the upcoming LE privacy support.

What really is needed is an option to force using the static address
compared to the public address. The new force_static_address debugfs
option does exactly that. In addition it is also only available when
the controller does actually have a public address. For single mode
LE only controllers this option will not be available.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_core.c    | 95 +++++++++++++++++++++++++++++----------------
 2 files changed, 63 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index d3a8fff50f69..fe4b06bfc150 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -118,6 +118,7 @@ enum {
 	HCI_DEBUG_KEYS,
 	HCI_DUT_MODE,
 	HCI_FORCE_SC,
+	HCI_FORCE_STATIC_ADDR,
 	HCI_UNREGISTER,
 	HCI_USER_CHANNEL,
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3711c7626cb2..b25a36c3064b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -571,33 +571,52 @@ static const struct file_operations static_address_fops = {
 	.release	= single_release,
 };
 
-static int own_address_type_set(void *data, u64 val)
+static ssize_t force_static_address_read(struct file *file,
+					 char __user *user_buf,
+					 size_t count, loff_t *ppos)
 {
-	struct hci_dev *hdev = data;
-
-	if (val != 0 && val != 1)
-		return -EINVAL;
-
-	hci_dev_lock(hdev);
-	hdev->own_addr_type = val;
-	hci_dev_unlock(hdev);
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
 
-	return 0;
+	buf[0] = test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
 }
 
-static int own_address_type_get(void *data, u64 *val)
+static ssize_t force_static_address_write(struct file *file,
+					  const char __user *user_buf,
+					  size_t count, loff_t *ppos)
 {
-	struct hci_dev *hdev = data;
+	struct hci_dev *hdev = file->private_data;
+	char buf[32];
+	size_t buf_size = min(count, (sizeof(buf)-1));
+	bool enable;
 
-	hci_dev_lock(hdev);
-	*val = hdev->own_addr_type;
-	hci_dev_unlock(hdev);
+	if (test_bit(HCI_UP, &hdev->flags))
+		return -EBUSY;
 
-	return 0;
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	if (strtobool(buf, &enable))
+		return -EINVAL;
+
+	if (enable == test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags))
+		return -EALREADY;
+
+	change_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags);
+
+	return count;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(own_address_type_fops, own_address_type_get,
-			own_address_type_set, "%llu\n");
+static const struct file_operations force_static_address_fops = {
+	.open		= simple_open,
+	.read		= force_static_address_read,
+	.write		= force_static_address_write,
+	.llseek		= default_llseek,
+};
 
 static int identity_resolving_keys_show(struct seq_file *f, void *ptr)
 {
@@ -1406,17 +1425,19 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 		hci_setup_link_policy(req);
 
 	if (lmp_le_capable(hdev)) {
-		if (test_bit(HCI_SETUP, &hdev->dev_flags)) {
-			/* If the controller has a public BD_ADDR, then
-			 * by default use that one. If this is a LE only
-			 * controller without a public address, default
-			 * to the random address.
-			 */
-			if (bacmp(&hdev->bdaddr, BDADDR_ANY))
-				hdev->own_addr_type = ADDR_LE_DEV_PUBLIC;
-			else
-				hdev->own_addr_type = ADDR_LE_DEV_RANDOM;
-		}
+		/* If the controller has a public BD_ADDR, then by default
+		 * use that one. If this is a LE only controller without
+		 * a public address, default to the random address.
+		 *
+		 * For debugging purposes it is possible to force
+		 * controllers with a public address to use the
+		 * random address instead.
+		 */
+		if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ||
+		    !bacmp(&hdev->bdaddr, BDADDR_ANY))
+			hdev->own_addr_type = ADDR_LE_DEV_RANDOM;
+		else
+			hdev->own_addr_type = ADDR_LE_DEV_PUBLIC;
 
 		hci_set_le_support(req);
 	}
@@ -1536,12 +1557,20 @@ static int __hci_init(struct hci_dev *hdev)
 	}
 
 	if (lmp_le_capable(hdev)) {
+		debugfs_create_file("static_address", 0444, hdev->debugfs,
+				    hdev, &static_address_fops);
+
+		/* For controllers with a public address, provide a debug
+		 * option to force the usage of the configured static
+		 * address. By default the public address is used.
+		 */
+		if (bacmp(&hdev->bdaddr, BDADDR_ANY))
+			debugfs_create_file("force_static_address", 0644,
+					    hdev->debugfs, hdev,
+					    &force_static_address_fops);
+
 		debugfs_create_u8("white_list_size", 0444, hdev->debugfs,
 				  &hdev->le_white_list_size);
-		debugfs_create_file("static_address", 0444, hdev->debugfs,
-				   hdev, &static_address_fops);
-		debugfs_create_file("own_address_type", 0644, hdev->debugfs,
-				    hdev, &own_address_type_fops);
 		debugfs_create_file("identity_resolving_keys", 0400,
 				    hdev->debugfs, hdev,
 				    &identity_resolving_keys_fops);
-- 
1.8.5.3

