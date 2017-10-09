Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <59db4643.86cd620a.89ea7.d1f8@mx.google.com>
Date: Mon, 9 Oct 2017 15:21:28 +0530
From: Shermin Joy <shermin.joy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 1/3] Add HCI commands to enable address resolution in
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add HCI commands  : LE Read Resolving List Size,
LE Add Device to Resolving List, LE Delete Device from Resolving List,
LE Clear Resolving List, LE Set Address Resolution Enable

Signed-off-by: Shermin Joy <shermin.joy@gmail.com>
---
 include/net/bluetooth/hci.h      | 25 ++++++++++
 include/net/bluetooth/hci_core.h | 12 +++++
 net/bluetooth/hci_core.c         | 20 ++++++++
 net/bluetooth/hci_event.c        | 98 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.c      | 62 +++++++++++++++++++++++++
 net/bluetooth/hci_request.h      |  8 ++++
 6 files changed, 225 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fe98f0a..1ef3ae8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -398,6 +398,7 @@ enum {
 #define HCI_LE_SLAVE_FEATURES		0x08
 #define HCI_LE_PING			0x10
 #define HCI_LE_DATA_LEN_EXT		0x20
+#define HCI_LE_LL_PRIVACY		0x40
 #define HCI_LE_EXT_SCAN_POLICY		0x80
 #define HCI_LE_CHAN_SEL_ALG2		0x40
 
@@ -1506,6 +1507,30 @@ struct hci_cp_le_set_default_phy {
 	__u8    rx_phys;
 } __packed;
 
+#define HCI_OP_LE_ADD_TO_RESOLVING_LIST		0x2027
+struct hci_cp_le_add_to_resolving_list {
+	__u8		peer_bdaddr_type;
+	bdaddr_t	peer_bdaddr;
+	__u8		peer_irk[16];
+	__u8		local_irk[16];
+} __packed;
+
+#define HCI_OP_LE_DEL_FROM_RESOLVING_LIST	0x2028
+struct hci_cp_le_del_from_resolving_list {
+	__u8		peer_bdaddr_type;
+	bdaddr_t	peer_bdaddr;
+} __packed;
+
+#define HCI_OP_LE_CLEAR_RESOLVING_LIST		0x2029
+
+#define HCI_OP_LE_READ_RESOLVING_LIST_SIZE	0x202A
+struct hci_rp_le_read_resolving_list_size {
+	__u8	status;
+	__u8	size;
+} __packed;
+
+#define HCI_OP_LE_SET_ADDR_RESOL_ENABLE		0x202D
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 95ccc1e..65ba086 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -139,6 +139,13 @@ struct smp_irk {
 	u8 val[16];
 };
 
+struct hci_irk {
+	struct list_head list;
+	bdaddr_t bdaddr;
+	u8 addr_type;
+	u8 val[16];
+};
+
 struct link_key {
 	struct list_head list;
 	struct rcu_head rcu;
@@ -221,6 +228,7 @@ struct hci_dev {
 	__u8		features[HCI_MAX_PAGES][8];
 	__u8		le_features[8];
 	__u8		le_white_list_size;
+	__u8		le_resolving_list_size;
 	__u8		le_states[8];
 	__u8		commands[64];
 	__u8		hci_ver;
@@ -259,6 +267,7 @@ struct hci_dev {
 	__u8		ssp_debug_mode;
 	__u8		hw_error_code;
 	__u32		clock;
+	bool		le_ll_addr_resolve_enabled;
 
 	__u16		devid_source;
 	__u16		devid_vendor;
@@ -361,6 +370,7 @@ struct hci_dev {
 	struct list_head	mgmt_pending;
 	struct list_head	blacklist;
 	struct list_head	whitelist;
+	struct list_head	resolvinglist;
 	struct list_head	uuids;
 	struct list_head	link_keys;
 	struct list_head	long_term_keys;
@@ -1536,6 +1546,8 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
 
+void hci_clear_resolving_list(struct hci_dev *hdev);
+
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6bc679c..bfeeb18 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -731,6 +731,24 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 			hci_req_add(req, HCI_OP_LE_READ_DEF_DATA_LEN, 0, NULL);
 		}
 
+		if (hdev->le_features[0] & HCI_LE_LL_PRIVACY) {
+			if (hdev->commands[34] & 0x40)
+				/* Read LE Resolving List Size */
+				hci_req_add(req,
+					    HCI_OP_LE_READ_RESOLVING_LIST_SIZE,
+					    0, NULL);
+			if (hdev->commands[35] & 0x02)
+				/* Enable Address Resolution in Controller */
+				hci_req_add(req,
+					    HCI_OP_LE_SET_ADDR_RESOL_ENABLE,
+					    0, NULL);
+			if (hdev->commands[34] & 0x20)
+				/* Clear LE Resolving List */
+				hci_req_add(req,
+					    HCI_OP_LE_CLEAR_RESOLVING_LIST,
+					    0, NULL);
+			}
+
 		hci_set_le_support(req);
 	}
 
@@ -3021,6 +3039,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 	INIT_LIST_HEAD(&hdev->blacklist);
 	INIT_LIST_HEAD(&hdev->whitelist);
+	INIT_LIST_HEAD(&hdev->resolvinglist);
 	INIT_LIST_HEAD(&hdev->uuids);
 	INIT_LIST_HEAD(&hdev->link_keys);
 	INIT_LIST_HEAD(&hdev->long_term_keys);
@@ -3221,6 +3240,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_dev_lock(hdev);
 	hci_bdaddr_list_clear(&hdev->blacklist);
 	hci_bdaddr_list_clear(&hdev->whitelist);
+	hci_clear_resolving_list(hdev);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
 	hci_smp_ltks_clear(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0b4dba0..6252307 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1442,6 +1442,84 @@ static void hci_cc_write_ssp_debug_mode(struct hci_dev *hdev, struct sk_buff *sk
 		hdev->ssp_debug_mode = *mode;
 }
 
+static void hci_cc_le_read_resolving_list_size(struct hci_dev *hdev,
+					       struct sk_buff *skb)
+{
+	struct hci_rp_le_read_resolving_list_size *rp = (void *)skb->data;
+
+	BT_DBG("%s status 0x%2.2x size %u", hdev->name, rp->status, rp->size);
+
+	if (rp->status)
+		return;
+
+	hdev->le_resolving_list_size = rp->size;
+}
+
+static void hci_cc_le_clear_resolving_list(struct hci_dev *hdev,
+					   struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *)skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	/* Clear all entries in the resolving list.*/
+	hci_clear_resolving_list(hdev);
+}
+
+static void hci_cc_le_add_to_resolving_list(struct hci_dev *hdev,
+					    struct sk_buff *skb)
+{
+	struct hci_cp_le_add_to_resolving_list *sent;
+	__u8 status = *((__u8 *)skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_ADD_TO_RESOLVING_LIST);
+	if (!sent)
+		return;
+
+	hci_update_resolving_list(hdev, sent->peer_bdaddr_type,
+				  &sent->peer_bdaddr, sent->peer_irk);
+}
+
+static void hci_cc_le_del_from_resolving_list(struct hci_dev *hdev,
+					      struct sk_buff *skb)
+{
+	struct hci_cp_le_del_from_resolving_list *sent;
+	__u8 status = *((__u8 *)skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_DEL_FROM_RESOLVING_LIST);
+	if (!sent)
+		return;
+
+	hci_delete_from_resolving_list(hdev, sent->peer_bdaddr_type,
+				       &sent->peer_bdaddr);
+}
+
+static void hci_cc_le_set_address_resolution_enable(struct hci_dev *hdev,
+						    struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *)skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	hdev->le_ll_addr_resolve_enabled = true;
+}
+
 static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
@@ -3039,6 +3117,26 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_write_ssp_debug_mode(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_RESOLVING_LIST_SIZE:
+		hci_cc_le_read_resolving_list_size(hdev, skb);
+		break;
+
+	case HCI_OP_LE_CLEAR_RESOLVING_LIST:
+		hci_cc_le_clear_resolving_list(hdev, skb);
+		break;
+
+	case HCI_OP_LE_ADD_TO_RESOLVING_LIST:
+		hci_cc_le_add_to_resolving_list(hdev, skb);
+		break;
+
+	case HCI_OP_LE_DEL_FROM_RESOLVING_LIST:
+		hci_cc_le_del_from_resolving_list(hdev, skb);
+		break;
+
+	case HCI_OP_LE_SET_ADDR_RESOL_ENABLE:
+		hci_cc_le_set_address_resolution_enable(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index b73ac14..8bdc22b 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -773,6 +773,68 @@ static u8 update_white_list(struct hci_request *req)
 	return 0x01;
 }
 
+struct hci_irk *hci_resolving_list_lookup(struct hci_dev *hdev,
+					  bdaddr_t *bdaddr, u8 type)
+{
+	struct hci_irk *b;
+
+	list_for_each_entry(b, &hdev->resolvinglist, list) {
+		if (!bacmp(&b->bdaddr, bdaddr) && b->addr_type == type)
+			return b;
+	}
+
+	return NULL;
+}
+
+int hci_update_resolving_list(struct hci_dev *hdev, u8 addr_type,
+			      bdaddr_t *bdaddr, u8 irk_val[16])
+{
+	struct hci_irk *irk;
+
+	irk = hci_resolving_list_lookup(hdev, bdaddr, addr_type);
+	if (irk) {
+		/* If present, remove the entry from current position.*/
+		list_del(&irk->list);
+	} else {
+		irk = kzalloc(sizeof(*irk), GFP_KERNEL);
+		if (!irk)
+			return -ENOMEM;
+		bacpy(&irk->bdaddr, bdaddr);
+		irk->addr_type = addr_type;
+	}
+
+	memcpy(irk->val, irk_val, 16);
+
+	/* Add the entry to the end of the list.*/
+	list_add_tail(&irk->list, &hdev->resolvinglist);
+	return 0;
+}
+
+int hci_delete_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
+				   bdaddr_t *bdaddr)
+{
+	struct hci_irk *irk;
+
+	irk = hci_resolving_list_lookup(hdev, bdaddr, addr_type);
+	if (!irk)
+		return -ENOENT;
+
+	/* If present, remove the entry from current position.*/
+	list_del(&irk->list);
+
+	return 0;
+}
+
+void hci_clear_resolving_list(struct hci_dev *hdev)
+{
+	struct hci_irk *irk;
+
+	list_for_each_entry(irk, &hdev->resolvinglist, list) {
+		list_del(&irk->list);
+		kfree(irk);
+	}
+}
+
 static bool scan_use_rpa(struct hci_dev *hdev)
 {
 	return hci_dev_test_flag(hdev, HCI_PRIVACY);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index dde77bd..ab4aac6 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -66,6 +66,14 @@ struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 void hci_req_add_le_scan_disable(struct hci_request *req);
 void hci_req_add_le_passive_scan(struct hci_request *req);
 
+struct hci_irk *hci_resolving_list_lookup(struct hci_dev *hdev,
+					  bdaddr_t *bdaddr, u8 type);
+int hci_update_resolving_list(struct hci_dev *hdev, u8 addr_type,
+			      bdaddr_t *bdaddr, u8 irk_val[16]);
+int hci_delete_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
+				   bdaddr_t *bdaddr);
+void hci_clear_resolving_list(struct hci_dev *hdev);
+
 void hci_req_reenable_advertising(struct hci_dev *hdev);
 void __hci_req_enable_advertising(struct hci_request *req);
 void __hci_req_disable_advertising(struct hci_request *req);
-- 
1.9.1

