Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Track the current configured random address
Date: Wed, 19 Feb 2014 19:52:13 -0800
Message-Id: <1392868333-37479-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For Bluetooth controllers with LE support, track the value of the
currently configured random address. It is important to know what
the current random address is to avoid unneeded attempts to set
a new address. This will become important when introducing the
LE privacy support in the future.

In addition expose the current configured random address via
debugfs for debugging purposes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 26 ++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        | 24 ++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3be2905010cd..3a8e22e9b25d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -151,6 +151,7 @@ struct hci_dev {
 	__u8		bus;
 	__u8		dev_type;
 	bdaddr_t	bdaddr;
+	bdaddr_t	random_addr;
 	bdaddr_t	static_addr;
 	__u8		own_addr_type;
 	__u8		dev_name[HCI_MAX_NAME_LENGTH];
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b25a36c3064b..877330b4876f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -548,6 +548,29 @@ static int sniff_max_interval_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(sniff_max_interval_fops, sniff_max_interval_get,
 			sniff_max_interval_set, "%llu\n");
 
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
 static int static_address_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
@@ -1557,6 +1580,8 @@ static int __hci_init(struct hci_dev *hdev)
 	}
 
 	if (lmp_le_capable(hdev)) {
+		debugfs_create_file("random_address", 0444, hdev->debugfs,
+				    hdev, &random_address_fops);
 		debugfs_create_file("static_address", 0444, hdev->debugfs,
 				    hdev, &static_address_fops);
 
@@ -2205,6 +2230,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 
 	memset(hdev->eir, 0, sizeof(hdev->eir));
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
+	bacpy(&hdev->random_addr, BDADDR_ANY);
 
 	hci_req_unlock(hdev);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7228fa100b1f..4327b129d38e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -959,6 +959,26 @@ static void hci_cc_read_local_oob_ext_data(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+
+static void hci_cc_le_set_random_addr(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+	bdaddr_t *sent;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_RANDOM_ADDR);
+	if (!sent)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (!status)
+		bacpy(&hdev->random_addr, sent);
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 *sent, status = *((__u8 *) skb->data);
@@ -2308,6 +2328,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_user_passkey_neg_reply(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_RANDOM_ADDR:
+		hci_cc_le_set_random_addr(hdev, skb);
+		break;
+
 	case HCI_OP_LE_SET_ADV_ENABLE:
 		hci_cc_le_set_adv_enable(hdev, skb);
 		break;
-- 
1.8.5.3

