Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ankit Navik <ankit.p.navik@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.b.panda@intel.com, ankit.p.navik@intel.com
Subject: [PATCH 1/2] Bluetooth: Store Resolv list size
Date: Fri, 29 Jun 2018 12:12:50 +0530
Message-Id: <1530254570-32458-1-git-send-email-ankit.p.navik@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the controller supports the Read LE Resolv List size feature, the
maximum list size are read and now stored.

Before patch:
< HCI Command: LE Read White List... (0x08|0x000f) plen 0  #55 [hci0] 17.979791
> HCI Event: Command Complete (0x0e) plen 5                #56 [hci0] 17.980629
      LE Read White List Size (0x08|0x000f) ncmd 1
        Status: Success (0x00)
        Size: 25
< HCI Command: LE Clear White List (0x08|0x0010) plen 0    #57 [hci0] 17.980786
> HCI Event: Command Complete (0x0e) plen 4                #58 [hci0] 17.981627
      LE Clear White List (0x08|0x0010) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Maximum Dat.. (0x08|0x002f) plen 0  #59 [hci0] 17.981786
> HCI Event: Command Complete (0x0e) plen 12               #60 [hci0] 17.982636
      LE Read Maximum Data Length (0x08|0x002f) ncmd 1
        Status: Success (0x00)
        Max TX octets: 251
        Max TX time: 17040
        Max RX octets: 251
        Max RX time: 17040

After patch:
< HCI Command: LE Read White List... (0x08|0x000f) plen 0  #55 [hci0] 13.338168
> HCI Event: Command Complete (0x0e) plen 5                #56 [hci0] 13.338842
      LE Read White List Size (0x08|0x000f) ncmd 1
        Status: Success (0x00)
        Size: 25
< HCI Command: LE Clear White List (0x08|0x0010) plen 0    #57 [hci0] 13.339029
> HCI Event: Command Complete (0x0e) plen 4                #58 [hci0] 13.339939
      LE Clear White List (0x08|0x0010) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Resolving L.. (0x08|0x002a) plen 0  #59 [hci0] 13.340152
> HCI Event: Command Complete (0x0e) plen 5                #60 [hci0] 13.340952
      LE Read Resolving List Size (0x08|0x002a) ncmd 1
        Status: Success (0x00)
        Size: 25
< HCI Command: LE Read Maximum Dat.. (0x08|0x002f) plen 0  #61 [hci0] 13.341180
> HCI Event: Command Complete (0x0e) plen 12               #62 [hci0] 13.341898
      LE Read Maximum Data Length (0x08|0x002f) ncmd 1
        Status: Success (0x00)
        Max TX octets: 251
        Max TX time: 17040
        Max RX octets: 251
        Max RX time: 17040

Signed-off-by: Ankit Navik <ankit.p.navik@intel.com>
---
 include/net/bluetooth/hci.h      |  6 ++++++
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         |  8 ++++++++
 net/bluetooth/hci_debugfs.c      | 19 +++++++++++++++++++
 net/bluetooth/hci_event.c        | 18 ++++++++++++++++++
 5 files changed, 53 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1668211..484f24c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1490,6 +1490,12 @@ struct hci_cp_le_write_def_data_len {
 	__le16	tx_time;
 } __packed;
 
+#define HCI_OP_LE_READ_RESOLV_LIST_SIZE	0x202a
+struct hci_rp_le_read_resolv_list_size {
+	__u8	status;
+	__u8	size;
+} __packed;
+
 #define HCI_OP_LE_READ_MAX_DATA_LEN	0x202f
 struct hci_rp_le_read_max_data_len {
 	__u8	status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b619a19..3a1ae0d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -221,6 +221,7 @@ struct hci_dev {
 	__u8		features[HCI_MAX_PAGES][8];
 	__u8		le_features[8];
 	__u8		le_white_list_size;
+	__u8		le_resolv_list_size;
 	__u8		le_states[8];
 	__u8		commands[64];
 	__u8		hci_ver;
@@ -367,6 +368,7 @@ struct hci_dev {
 	struct list_head	identity_resolving_keys;
 	struct list_head	remote_oob_data;
 	struct list_head	le_white_list;
+	struct list_head	le_resolv_list;
 	struct list_head	le_conn_params;
 	struct list_head	pend_le_conns;
 	struct list_head	pend_le_reports;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 40d260f..51efc4a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -723,6 +723,12 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 			hci_req_add(req, HCI_OP_LE_CLEAR_WHITE_LIST, 0, NULL);
 		}
 
+		if (hdev->commands[34] & 0x40) {
+			/* Read LE Resolv List Size */
+			hci_req_add(req, HCI_OP_LE_READ_RESOLV_LIST_SIZE,
+				    0, NULL);
+		}
+
 		if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
 			/* Read LE Maximum Data Length */
 			hci_req_add(req, HCI_OP_LE_READ_MAX_DATA_LEN, 0, NULL);
@@ -3026,6 +3032,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->identity_resolving_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 	INIT_LIST_HEAD(&hdev->le_white_list);
+	INIT_LIST_HEAD(&hdev->le_resolv_list);
 	INIT_LIST_HEAD(&hdev->le_conn_params);
 	INIT_LIST_HEAD(&hdev->pend_le_conns);
 	INIT_LIST_HEAD(&hdev->pend_le_reports);
@@ -3227,6 +3234,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_remote_oob_data_clear(hdev);
 	hci_adv_instances_clear(hdev);
 	hci_bdaddr_list_clear(&hdev->le_white_list);
+	hci_bdaddr_list_clear(&hdev->le_resolv_list);
 	hci_conn_params_clear_all(hdev);
 	hci_discovery_filter_clear(hdev);
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 418b76e..fa12108 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -702,6 +702,21 @@ static int white_list_show(struct seq_file *f, void *ptr)
 
 DEFINE_SHOW_ATTRIBUTE(white_list);
 
+static int resolv_list_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+	struct bdaddr_list *b;
+
+	hci_dev_lock(hdev);
+	list_for_each_entry(b, &hdev->le_resolv_list, list)
+		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(resolv_list);
+
 static int identity_resolving_keys_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -963,6 +978,10 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
 			  &hdev->le_white_list_size);
 	debugfs_create_file("white_list", 0444, hdev->debugfs, hdev,
 			    &white_list_fops);
+	debugfs_create_u8("resolv_list_size", 0444, hdev->debugfs,
+			  &hdev->le_resolv_list_size);
+	debugfs_create_file("resolv_list", 0444, hdev->debugfs, hdev,
+			    &resolv_list_fops);
 	debugfs_create_file("identity_resolving_keys", 0400, hdev->debugfs,
 			    hdev, &identity_resolving_keys_fops);
 	debugfs_create_file("long_term_keys", 0400, hdev->debugfs, hdev,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 139707c..c57969a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -221,6 +221,7 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 	hdev->ssp_debug_mode = 0;
 
 	hci_bdaddr_list_clear(&hdev->le_white_list);
+	hci_bdaddr_list_clear(&hdev->le_resolv_list);
 }
 
 static void hci_cc_read_stored_link_key(struct hci_dev *hdev,
@@ -1306,6 +1307,19 @@ static void hci_cc_le_write_def_data_len(struct hci_dev *hdev,
 	hdev->le_def_tx_time = le16_to_cpu(sent->tx_time);
 }
 
+static void hci_cc_le_read_resolv_list_size(struct hci_dev *hdev,
+					   struct sk_buff *skb)
+{
+	struct hci_rp_le_read_resolv_list_size *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x size %u", hdev->name, rp->status, rp->size);
+
+	if (rp->status)
+		return;
+
+	hdev->le_resolv_list_size = rp->size;
+}
+
 static void hci_cc_le_read_max_data_len(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
@@ -3015,6 +3029,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_write_def_data_len(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_RESOLV_LIST_SIZE:
+		hci_cc_le_read_resolv_list_size(hdev, skb);
+		break;
+
 	case HCI_OP_LE_READ_MAX_DATA_LEN:
 		hci_cc_le_read_max_data_len(hdev, skb);
 		break;
-- 
1.9.1

