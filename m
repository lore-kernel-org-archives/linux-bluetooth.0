Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v5 14/16] Bluetooth: Implement Set ADV set random address
Date: Thu, 19 Jul 2018 17:09:45 +0530
Message-Id: <1532000387-3649-15-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This basically sets the random address for the adv instance
Random address can be set only if the instance is created which
is done in Set ext adv param.

Random address and rpa expire timer and flags have been added
to adv instance which will be used when the respective
instance is scheduled.

This introduces a hci_get_random_address() which returns the
own address type and random address (rpa or nrpa) based
on the instance flags and hdev flags. New function is required
since own address type should be known before setting adv params
but address can be set only after setting params.

< HCI Command: LE Set Advertising Set Random Address (0x08|0x0035) plen 7
        Advertising handle: 0x00
        Advertising random address: 3C:8E:56:9B:77:84 (OUI 3C-8E-56)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Advertising Set Random Address (0x08|0x0035) ncmd 1
        Status: Success (0x00)

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h      |   6 ++
 include/net/bluetooth/hci_core.h |   4 ++
 net/bluetooth/hci_conn.c         |  23 +++++++
 net/bluetooth/hci_core.c         |  33 +++++++++-
 net/bluetooth/hci_event.c        |  37 ++++++++++-
 net/bluetooth/hci_request.c      | 128 ++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_request.h      |   3 +
 net/bluetooth/mgmt.c             |   2 +
 8 files changed, 233 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index faa2922..8d348d0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1649,6 +1649,12 @@ struct hci_cp_le_set_ext_scan_rsp_data {
 
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
index ad35183..0db1b9b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -172,6 +172,9 @@ struct adv_info {
 	__u16	scan_rsp_len;
 	__u8	scan_rsp_data[HCI_MAX_AD_LENGTH];
 	__s8	tx_power;
+	bdaddr_t	random_addr;
+	bool 		rpa_expired;
+	struct delayed_work	rpa_expired_cb;
 };
 
 #define HCI_MAX_ADV_INSTANCES		5
@@ -1113,6 +1116,7 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 			 u16 scan_rsp_len, u8 *scan_rsp_data,
 			 u16 timeout, u16 duration);
 int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance);
+void hci_adv_instances_set_rpa_expired(struct hci_dev *hdev, bool rpa_expired);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5c37d38..bd4978c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -873,6 +873,14 @@ static void hci_req_directed_advertising(struct hci_request *req,
 
 	if (ext_adv_capable(hdev)) {
 		struct hci_cp_le_set_ext_adv_params cp;
+		bdaddr_t random_addr;
+
+		/* Set require_privacy to false so that the remote device has a
+		 * chance of identifying us.
+		 */
+		if (hci_get_random_address(hdev, false, conn_use_rpa(conn), NULL,
+					   &own_addr_type, &random_addr) < 0)
+			return;
 
 		memset(&cp, 0, sizeof(cp));
 
@@ -889,6 +897,21 @@ static void hci_req_directed_advertising(struct hci_request *req,
 
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
 		__hci_req_enable_ext_advertising(req);
 	} else {
 		struct hci_cp_le_set_adv_param cp;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 944d4fe..840e8fd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1471,6 +1471,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	if (!ret) {
 		hci_dev_hold(hdev);
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
+		hci_adv_instances_set_rpa_expired(hdev, true);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_sock_dev_event(hdev, HCI_DEV_UP);
 		hci_leds_update_powered(hdev, true);
@@ -1626,9 +1627,15 @@ int hci_dev_do_close(struct hci_dev *hdev)
 	if (hci_dev_test_and_clear_flag(hdev, HCI_SERVICE_CACHE))
 		cancel_delayed_work(&hdev->service_cache);
 
-	if (hci_dev_test_flag(hdev, HCI_MGMT))
+	if (hci_dev_test_flag(hdev, HCI_MGMT)) {
+		struct adv_info *adv_instance;
+
 		cancel_delayed_work_sync(&hdev->rpa_expired);
 
+		list_for_each_entry(adv_instance, &hdev->adv_instances, list)
+			cancel_delayed_work_sync(&adv_instance->rpa_expired_cb);
+	}
+
 	/* Avoid potential lockdep warnings from the *_flush() calls by
 	 * ensuring the workqueue is empty up front.
 	 */
@@ -2704,6 +2711,8 @@ int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance)
 		hdev->cur_adv_instance = 0x00;
 	}
 
+	cancel_delayed_work_sync(&adv_instance->rpa_expired_cb);
+
 	list_del(&adv_instance->list);
 	kfree(adv_instance);
 
@@ -2712,6 +2721,14 @@ int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance)
 	return 0;
 }
 
+void hci_adv_instances_set_rpa_expired(struct hci_dev *hdev, bool rpa_expired)
+{
+	struct adv_info *adv_instance, *n;
+
+	list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances, list)
+		adv_instance->rpa_expired = rpa_expired;
+}
+
 /* This function requires the caller holds hdev->lock */
 void hci_adv_instances_clear(struct hci_dev *hdev)
 {
@@ -2723,6 +2740,7 @@ void hci_adv_instances_clear(struct hci_dev *hdev)
 	}
 
 	list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances, list) {
+		cancel_delayed_work_sync(&adv_instance->rpa_expired_cb);
 		list_del(&adv_instance->list);
 		kfree(adv_instance);
 	}
@@ -2731,6 +2749,16 @@ void hci_adv_instances_clear(struct hci_dev *hdev)
 	hdev->cur_adv_instance = 0x00;
 }
 
+static void adv_instance_rpa_expired(struct work_struct *work)
+{
+	struct adv_info *adv_instance = container_of(work, struct adv_info,
+						     rpa_expired_cb.work);
+
+	BT_DBG("");
+
+	adv_instance->rpa_expired = true;
+}
+
 /* This function requires the caller holds hdev->lock */
 int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 			 u16 adv_data_len, u8 *adv_data,
@@ -2781,6 +2809,9 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 
 	adv_instance->tx_power = HCI_TX_POWER_INVALID;
 
+	INIT_DELAYED_WORK(&adv_instance->rpa_expired_cb,
+			  adv_instance_rpa_expired);
+
 	BT_DBG("%s for %dMR", hdev->name, instance);
 
 	return 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a78d1dd..392c9d8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1064,6 +1064,35 @@ static void hci_cc_le_set_default_phy(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_set_adv_set_random_addr(struct hci_dev *hdev,
+                                              struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+	struct hci_cp_le_set_adv_set_rand_addr *cp;
+	struct adv_info *adv_instance;
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
+	if (!hdev->cur_adv_instance) {
+		/* Store in hdev for instance 0 (Set adv and Directed advs) */
+		bacpy(&hdev->random_addr, &cp->bdaddr);
+	} else {
+		adv_instance = hci_find_adv_instance(hdev,
+						     hdev->cur_adv_instance);
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
@@ -2830,8 +2859,10 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	/* We should disregard the current RPA and generate a new one
 	 * whenever the encryption procedure fails.
 	 */
-	if (ev->status && conn->type == LE_LINK)
+	if (ev->status && conn->type == LE_LINK) {
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
+		hci_adv_instances_set_rpa_expired(hdev, true);
+	}
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
@@ -3283,6 +3314,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
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
index 96e1e05..c72fd92 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1440,6 +1440,87 @@ static void adv_timeout_expire(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
+int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
+			   bool use_rpa, struct adv_info *adv_instance,
+			   u8 *own_addr_type, bdaddr_t *rand_addr)
+{
+	int err;
+
+	bacpy(rand_addr, BDADDR_ANY);
+
+	/* If privacy is enabled use a resolvable private address. If
+	 * current RPA has expired then generate a new one.
+	 */
+	if (use_rpa) {
+		int to;
+
+		*own_addr_type = ADDR_LE_DEV_RANDOM;
+
+		if (adv_instance) {
+			if (!adv_instance->rpa_expired &&
+			    !bacmp(&adv_instance->random_addr, &hdev->rpa))
+				return 0;
+
+			adv_instance->rpa_expired = false;
+		} else {
+			if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
+			    !bacmp(&hdev->random_addr, &hdev->rpa))
+				return 0;
+		}
+
+		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
+		if (err < 0) {
+			BT_ERR("%s failed to generate new RPA", hdev->name);
+			return err;
+		}
+
+		bacpy(rand_addr, &hdev->rpa);
+
+		to = msecs_to_jiffies(hdev->rpa_timeout * 1000);
+		if (adv_instance)
+			queue_delayed_work(hdev->workqueue,
+					   &adv_instance->rpa_expired_cb, to);
+		else
+			queue_delayed_work(hdev->workqueue,
+					   &hdev->rpa_expired, to);
+
+		return 0;
+	}
+
+	/* In case of required privacy without resolvable private address,
+	 * use an non-resolvable private address. This is useful for
+	 * non-connectable advertising.
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
+	/* No privacy so use a public address. */
+	*own_addr_type = ADDR_LE_DEV_PUBLIC;
+
+	return 0;
+}
+
 void __hci_req_clear_ext_adv_sets(struct hci_request *req)
 {
 	hci_req_add(req, HCI_OP_LE_CLEAR_ADV_SETS, 0, NULL);
@@ -1451,9 +1532,21 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 	struct hci_dev *hdev = req->hdev;
 	bool connectable;
 	u32 flags;
+	bdaddr_t random_addr;
+	u8 own_addr_type;
+	int err;
+	struct adv_info *adv_instance;
 	/* In ext adv set param interval is 3 octets */
 	const u8 adv_interval[3] = { 0x00, 0x08, 0x00 };
 
+	if (instance > 0) {
+		adv_instance = hci_find_adv_instance(hdev, instance);
+		if (!adv_instance)
+			return -EINVAL;
+	} else {
+		adv_instance = NULL;
+	}
+
 	flags = get_adv_instance_flags(hdev, instance);
 
 	/* If the "connectable" instance flag was not set, then choose between
@@ -1465,6 +1558,16 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 	 if (!is_advertising_allowed(hdev, connectable))
 		return -EPERM;
 
+	/* Set require_privacy to true only when non-connectable
+	 * advertising is used. In that case it is fine to use a
+	 * non-resolvable private address.
+	 */
+	err = hci_get_random_address(hdev, !connectable,
+				     adv_use_rpa(hdev, flags), adv_instance,
+				     &own_addr_type, &random_addr);
+	if (err < 0)
+		return err;
+
 	memset(&cp, 0, sizeof(cp));
 
 	memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
@@ -1477,7 +1580,7 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 	else
 		cp.evt_properties = cpu_to_le16(LE_LEGACY_NONCONN_IND);
 
-	cp.own_addr_type = BDADDR_LE_PUBLIC;
+	cp.own_addr_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
 	cp.tx_power = 127;
 	cp.primary_phy = HCI_ADV_PHY_1M;
@@ -1486,6 +1589,29 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 
 	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
 
+	if (own_addr_type == ADDR_LE_DEV_RANDOM &&
+	    bacmp(&random_addr, BDADDR_ANY)) {
+		struct hci_cp_le_set_adv_set_rand_addr cp;
+
+		/* Check if random address need to be updated */
+		if (adv_instance) {
+			if (!bacmp(&random_addr, &adv_instance->random_addr))
+				return 0;
+		} else {
+			if (!bacmp(&random_addr, &hdev->random_addr))
+				return 0;
+		}
+
+		memset(&cp, 0, sizeof(cp));
+
+		cp.handle = 0;
+		bacpy(&cp.bdaddr, &random_addr);
+
+		hci_req_add(req,
+			    HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
+			    sizeof(cp), &cp);
+	}
+
 	return 0;
 }
 
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 2451861..692cc8b 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -84,6 +84,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance);
 int __hci_req_start_ext_adv(struct hci_request *req, u8 instance);
 void __hci_req_enable_ext_advertising(struct hci_request *req);
 void __hci_req_clear_ext_adv_sets(struct hci_request *req);
+int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
+			   bool use_rpa, struct adv_info *adv_instance,
+			   u8 *own_addr_type, bdaddr_t *rand_addr);
 
 void __hci_req_update_class(struct hci_request *req);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c283f03..9499867 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4972,6 +4972,7 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 		changed = !hci_dev_test_and_set_flag(hdev, HCI_PRIVACY);
 		memcpy(hdev->irk, cp->irk, sizeof(hdev->irk));
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
+		hci_adv_instances_set_rpa_expired(hdev, true);
 		if (cp->privacy == 0x02)
 			hci_dev_set_flag(hdev, HCI_LIMITED_PRIVACY);
 		else
@@ -4980,6 +4981,7 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 		changed = hci_dev_test_and_clear_flag(hdev, HCI_PRIVACY);
 		memset(hdev->irk, 0, sizeof(hdev->irk));
 		hci_dev_clear_flag(hdev, HCI_RPA_EXPIRED);
+		hci_adv_instances_set_rpa_expired(hdev, false);
 		hci_dev_clear_flag(hdev, HCI_LIMITED_PRIVACY);
 	}
 
-- 
2.7.4
