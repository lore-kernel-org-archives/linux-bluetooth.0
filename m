Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <59cb6924.4e67620a.9c561.2444@mx.google.com>
Date: Wed, 27 Sep 2017 14:34:23 +0530
From: Shermin Joy <shermin.joy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] Add HCI commands to enable address resolution in controller
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add HCI commands  : LE Read Resolving List Size,
LE Add Device to Resolving List, LE Delete Device from Resolving List,
LE Clear Resolving List, LE Set Address Resolution Enable

Signed-off-by: Shermin Joy <shermin.joy@gmail.com>
---
 include/net/bluetooth/hci.h      |  25 +++++++++
 include/net/bluetooth/hci_core.h |   3 ++
 net/bluetooth/hci_core.c         |  18 +++++++
 net/bluetooth/hci_event.c        | 107 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.c      |  64 +++++++++++++++++++++++
 net/bluetooth/hci_request.h      |   4 ++
 6 files changed, 221 insertions(+)

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
index 95ccc1e..82c9589 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -137,6 +137,7 @@ struct smp_irk {
 	bdaddr_t bdaddr;
 	u8 addr_type;
 	u8 val[16];
+	bool in_ll_resolving_list;
 };
 
 struct link_key {
@@ -221,6 +222,7 @@ struct hci_dev {
 	__u8		features[HCI_MAX_PAGES][8];
 	__u8		le_features[8];
 	__u8		le_white_list_size;
+	__u8		le_resolving_list_size;
 	__u8		le_states[8];
 	__u8		commands[64];
 	__u8		hci_ver;
@@ -259,6 +261,7 @@ struct hci_dev {
 	__u8		ssp_debug_mode;
 	__u8		hw_error_code;
 	__u32		clock;
+	bool		le_ll_addr_resolve_enabled;
 
 	__u16		devid_source;
 	__u16		devid_vendor;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6bc679c..ab16e71 100644
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
+		}
+
 		hci_set_le_support(req);
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0b4dba0..3e7bbbe 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1442,6 +1442,93 @@ static void hci_cc_write_ssp_debug_mode(struct hci_dev *hdev, struct sk_buff *sk
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
+	struct smp_irk *irk;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	/* Clear in_ll_resolving_list flag for all entries in the
+	 * identity_resolving_keys list.
+	 */
+	rcu_read_lock();
+	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
+		irk->in_ll_resolving_list = false;
+	}
+	rcu_read_unlock();
+}
+
+static void hci_cc_le_add_to_resolving_list(struct hci_dev *hdev,
+					    struct sk_buff *skb)
+{
+	struct hci_cp_le_add_to_white_list *sent;
+	__u8 status = *((__u8 *)skb->data);
+	struct smp_irk *irk;
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
+	if (hci_find_irk_by_addr(hdev, &sent->bdaddr, sent->bdaddr_type))
+		irk->in_ll_resolving_list = true;
+}
+
+static void hci_cc_le_del_from_resolving_list(struct hci_dev *hdev,
+					      struct sk_buff *skb)
+{
+	struct hci_cp_le_del_from_white_list *sent;
+	__u8 status = *((__u8 *)skb->data);
+	struct smp_irk *irk;
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
+	if (hci_find_irk_by_addr(hdev, &sent->bdaddr, sent->bdaddr_type))
+		irk->in_ll_resolving_list = false;
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
@@ -3039,6 +3126,26 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
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
index b73ac14..6dcc827 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -773,6 +773,70 @@ static u8 update_white_list(struct hci_request *req)
 	return 0x01;
 }
 
+static void add_to_resolving_list(struct hci_request *req, u8 addr_type,
+				  bdaddr_t *bdaddr, u8 irk[16])
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_add_to_resolving_list cp;
+
+	cp.peer_bdaddr_type = addr_type;
+	bacpy(&cp.peer_bdaddr, bdaddr);
+	memcpy(cp.peer_irk, irk, 16);
+	memcpy(cp.local_irk, hdev->irk, 16);
+
+	hci_req_add(req, HCI_OP_LE_ADD_TO_RESOLVING_LIST, sizeof(cp), &cp);
+}
+
+void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
+				     bdaddr_t *bdaddr)
+{
+	struct hci_cp_le_del_from_resolving_list cp;
+	struct hci_request req;
+
+	/* Nothing to be done if LL privacy is not supported. */
+	if (hdev->le_features[0] & HCI_LE_LL_PRIVACY)
+		return;
+
+	/* Resolving List cannot be updated if address resolution
+	 * in the controller is enabled and advertisement or scanning
+	 * or create connection command is ongoing.
+	 */
+	if ((hdev->le_ll_addr_resolve_enabled) &&
+	    ((hci_dev_test_flag(hdev, HCI_LE_ADV)) ||
+	    (hci_dev_test_flag(hdev, HCI_LE_SCAN)) ||
+	    (hci_lookup_le_connect(hdev))))
+		return;
+
+	hci_req_init(&req, hdev);
+	cp.peer_bdaddr_type = addr_type;
+	bacpy(&cp.peer_bdaddr, bdaddr);
+
+	hci_req_add(&req, HCI_OP_LE_DEL_FROM_RESOLVING_LIST, sizeof(cp), &cp);
+	hci_req_run(&req, NULL);
+}
+
+void hci_req_clear_resolving_list(struct hci_dev *hdev)
+{
+	struct hci_request req;
+
+	/* Nothing to be done if LL privacy is not supported. */
+	if (hdev->le_features[0] & HCI_LE_LL_PRIVACY)
+		return;
+
+	/* Resolving List cannot be updated if address resolution
+	 * in the controller is enabled and advertisement or scanning
+	 * or create connection command is ongoing.
+	 */
+	if ((hdev->le_ll_addr_resolve_enabled) &&
+	    ((hci_dev_test_flag(hdev, HCI_LE_ADV)) ||
+	    (hci_dev_test_flag(hdev, HCI_LE_SCAN)) ||
+	    (hci_lookup_le_connect(hdev))))
+		return;
+
+	hci_req_add(&req, HCI_OP_LE_CLEAR_RESOLVING_LIST, 0, NULL);
+	hci_req_run(&req, NULL);
+}
+
 static bool scan_use_rpa(struct hci_dev *hdev)
 {
 	return hci_dev_test_flag(hdev, HCI_PRIVACY);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index dde77bd..bf12dbf 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -66,6 +66,10 @@ struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 void hci_req_add_le_scan_disable(struct hci_request *req);
 void hci_req_add_le_passive_scan(struct hci_request *req);
 
+void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
+				     bdaddr_t *bdaddr);
+void hci_req_clear_resolving_list(struct hci_dev *hdev);
+
 void hci_req_reenable_advertising(struct hci_dev *hdev);
 void __hci_req_enable_advertising(struct hci_request *req);
 void __hci_req_disable_advertising(struct hci_request *req);
-- 
1.9.1

