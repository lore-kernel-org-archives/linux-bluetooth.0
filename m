Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [RFC 7/9] Bluetooth: Implement Set ADV set random address
Date: Mon,  4 Dec 2017 13:37:51 +0530
Message-Id: <1512374873-1956-8-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This basically sets the random address for an instance.
Random address can be set only if the instance is created which
is done in Set ext adv param.

This introduces a hci_get_random_address() which returns the
own address type and random address (rpa, nrpa or static) based
on the instance flags and hdev flags.

Also introduces random address and address type to adv instance
structure which can be used when a connection gets created
to a particular adv set.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h      |   6 +++
 include/net/bluetooth/hci_core.h |   1 +
 net/bluetooth/hci_conn.c         |  23 ++++++++
 net/bluetooth/hci_event.c        |  33 ++++++++++++
 net/bluetooth/hci_request.c      | 110 ++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_request.h      |   3 ++
 6 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 2ee16f7..1337fbf 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1618,6 +1618,12 @@ struct hci_cp_le_remove_adv_set {
 
 #define HCI_OP_LE_CLEAR_ADV_SETS	0x203d
 
+#define HCI_OP_LE_SET_ADV_SET_RAND_ADDR	0x2035
+struct hci_cp_le_set_adv_set_rand_addr {
+	__u8  handle;
+	bdaddr_t  bdaddr;
+} __packed;
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 610172a..da7609b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -171,6 +171,7 @@ struct adv_info {
 	__u8	scan_rsp_data[HCI_MAX_EXT_AD_LENGTH];
 	__u8	addr_type;
 	unsigned long state;
+	bdaddr_t random_addr;
 };
 
 /* Adv instance states */
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 789a91a..d7e6b0e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -832,6 +832,14 @@ static void hci_req_directed_advertising(struct hci_request *req,
 
 	if (ext_adv_capable(hdev)) {
 		struct hci_cp_le_set_ext_adv_params cp;
+		bdaddr_t random_addr;
+
+		/* Set require_privacy to false so that the remote device has a
+		 * chance of identifying us.
+		 */
+		if (hci_get_random_address(hdev, false, conn_use_rpa(conn),
+					   &own_addr_type, &random_addr) < 0)
+			return;
 
 		memset(&cp, 0, sizeof(cp));
 
@@ -848,6 +856,21 @@ static void hci_req_directed_advertising(struct hci_request *req,
 
 		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
 
+		if (own_addr_type == ADDR_LE_DEV_RANDOM &&
+		    bacmp(&random_addr, BDADDR_ANY) &&
+		    bacmp(&random_addr, &hdev->random_addr)) {
+			struct hci_cp_le_set_adv_set_rand_addr cp;
+
+			memset(&cp, 0, sizeof(cp));
+
+			cp.handle = 0;
+			bacpy(&cp.bdaddr, &random_addr);
+
+			hci_req_add(req,
+				    HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
+				    sizeof(cp), &cp);
+		}
+
 		__hci_req_enable_ext_advertising(req, 0, false);
 	} else {
 		struct hci_cp_le_set_adv_param cp;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8a118c1..67081ab 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1041,6 +1041,35 @@ static void hci_cc_le_set_random_addr(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_set_adv_set_random_addr(struct hci_dev *hdev,
+					      struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+	struct hci_cp_le_set_adv_set_rand_addr *cp;
+	struct adv_info *adv_instance;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADV_SET_RAND_ADDR);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (!cp->handle) {
+		bacpy(&hdev->random_addr, &cp->bdaddr);
+	} else {
+		adv_instance = hci_find_adv_instance(hdev, cp->handle);
+		if (adv_instance)
+			bacpy(&adv_instance->random_addr, &cp->bdaddr);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 *sent, status = *((__u8 *) skb->data);
@@ -3268,6 +3297,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_set_ext_adv_enable(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_ADV_SET_RAND_ADDR:
+		hci_cc_le_set_adv_set_random_addr(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index ca235eb..9d0a940 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1423,6 +1423,83 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
+			   bool use_rpa, u8 *own_addr_type, bdaddr_t *rand_addr)
+{
+	int err;
+
+	bacpy(rand_addr, BDADDR_ANY);
+
+	/* If privacy is enabled use a resolvable private address. If
+	 * current RPA has expired then generate a new one.
+	 */
+	if (use_rpa) {
+		*own_addr_type = ADDR_LE_DEV_RANDOM;
+
+		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
+		if (err < 0) {
+			BT_ERR("%s failed to generate new RPA", hdev->name);
+			return err;
+		}
+
+		bacpy(rand_addr, &hdev->rpa);
+
+		return 0;
+	}
+
+	/* In case of required privacy without resolvable private address,
+	 * use an non-resolvable private address. This is useful for active
+	 * scanning and non-connectable advertising.
+	 */
+	if (require_privacy) {
+		bdaddr_t nrpa;
+
+		while (true) {
+			/* The non-resolvable private address is generated
+			 * from random six bytes with the two most significant
+			 * bits cleared.
+			 */
+			get_random_bytes(&nrpa, 6);
+			nrpa.b[5] &= 0x3f;
+
+			/* The non-resolvable private address shall not be
+			 * equal to the public address.
+			 */
+			if (bacmp(&hdev->bdaddr, &nrpa))
+				break;
+		}
+
+		*own_addr_type = ADDR_LE_DEV_RANDOM;
+		bacpy(rand_addr, &nrpa);
+
+		return 0;
+	}
+
+	/* If forcing static address is in use or there is no public
+	 * address use the static address as random address
+	 *
+	 * In case BR/EDR has been disabled on a dual-mode controller
+	 * and a static address has been configured, then use that
+	 * address instead of the public BR/EDR address.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ||
+	    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
+	    (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
+	     bacmp(&hdev->static_addr, BDADDR_ANY))) {
+		*own_addr_type = ADDR_LE_DEV_RANDOM;
+		bacpy(rand_addr, &hdev->static_addr);
+
+		return 0;
+	}
+
+	/* Neither privacy nor static address is being used so use a
+	 * public address.
+	 */
+	*own_addr_type = ADDR_LE_DEV_PUBLIC;
+
+	return 0;
+}
+
 void __hci_req_remove_ext_adv_set(struct hci_request *req, u8 instance)
 {
 	struct hci_cp_le_remove_adv_set cp;
@@ -1483,6 +1560,8 @@ static void __hci_req_setup_ext_adv_instance(struct hci_request *req,
 	const u8 adv_interval[3] = { 0x00, 0x08, 0x00 };
 	struct adv_info *adv_inst;
 	bool secondary_adv;
+	bdaddr_t random_addr, *current_addr;
+	u8 own_addr_type;
 
 	flags = get_adv_instance_flags(hdev, instance);
 
@@ -1492,6 +1571,15 @@ static void __hci_req_setup_ext_adv_instance(struct hci_request *req,
 	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
 		      mgmt_get_connectable(hdev);
 
+	/* Set require_privacy to true only when non-connectable
+	 * advertising is used. In that case it is fine to use a
+	 * non-resolvable private address.
+	 */
+	if (hci_get_random_address(hdev, !connectable,
+				   adv_use_rpa(hdev, flags),
+				   &own_addr_type, &random_addr) < 0)
+		return;
+
 	memset(&cp, 0, sizeof(cp));
 
 	memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
@@ -1521,7 +1609,7 @@ static void __hci_req_setup_ext_adv_instance(struct hci_request *req,
 			cp.evt_properties = cpu_to_le16(LE_LEGACY_NONCONN_IND);
 	}
 
-	cp.own_addr_type = BDADDR_LE_PUBLIC;
+	cp.own_addr_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
 	cp.tx_power = 127;
 	cp.primary_phy = LE_PHY_1M;
@@ -1530,6 +1618,26 @@ static void __hci_req_setup_ext_adv_instance(struct hci_request *req,
 
 	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
 
+	if (!instance)
+		current_addr = &hdev->random_addr;
+	else
+		current_addr = &adv_inst->random_addr;
+
+	if (own_addr_type == ADDR_LE_DEV_RANDOM &&
+	    bacmp(&random_addr, BDADDR_ANY) &&
+	    bacmp(&random_addr, current_addr)) {
+		struct hci_cp_le_set_adv_set_rand_addr cp;
+
+		memset(&cp, 0, sizeof(cp));
+
+		cp.handle = instance;
+		bacpy(&cp.bdaddr, &random_addr);
+
+		hci_req_add(req,
+			    HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
+			    sizeof(cp), &cp);
+	}
+
 	__hci_req_update_adv_data(req, instance);
 	__hci_req_update_scan_rsp_data(req, instance);
 }
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 936f6c5..0e7c760 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -87,6 +87,9 @@ void __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance,
 void __hci_req_stop_ext_adv(struct hci_request *req, u8 instance,
 			    bool all_instances);
 void __hci_req_clear_ext_adv_sets(struct hci_request *req);
+int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
+                           bool use_rpa, u8 *own_addr_type,
+			   bdaddr_t *rand_addr);
 
 void __hci_req_update_class(struct hci_request *req);
 
-- 
2.7.4

