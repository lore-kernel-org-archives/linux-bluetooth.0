Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Florian Grandel <fgrandel@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_core/mgmt: Change adv inst to list.
Date: Sun,  5 Apr 2015 20:21:20 +0200
Message-Id: <1428258080-6275-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1428162231-17940-1-git-send-email-fgrandel@gmail.com>
References: <1428162231-17940-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As a preparatory step towards multi-instance advertising it is
necessary to introduce a data structure that supports storing
multiple advertising info data structures for a bluetooth device.

This is introduced by refactoring the existing adv_instance member
of the hci_dev struct into a linked list and making the necessary
changes in the code to support this list.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---

v1 -> v2: add missing braces in read_adv_features()

 include/net/bluetooth/hci_core.h |  21 ++-
 net/bluetooth/hci_core.c         | 118 ++++++++++++-
 net/bluetooth/mgmt.c             | 345 +++++++++++++++++++++------------------
 3 files changed, 316 insertions(+), 168 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 93fd3e7..69a8f30 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -156,6 +156,8 @@ struct oob_data {
 };
 
 struct adv_info {
+	struct list_head list;
+	struct hci_dev *hdev;
 	struct delayed_work timeout_exp;
 	__u8	instance;
 	__u32	flags;
@@ -166,6 +168,8 @@ struct adv_info {
 	__u8	scan_rsp_data[HCI_MAX_AD_LENGTH];
 };
 
+#define HCI_MAX_ADV_INSTANCES		1
+
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
 /* Default LE RPA expiry time, 15 minutes */
@@ -375,7 +379,8 @@ struct hci_dev {
 	__u8			scan_rsp_data[HCI_MAX_AD_LENGTH];
 	__u8			scan_rsp_data_len;
 
-	struct adv_info		adv_instance;
+	struct list_head	adv_instances;
+	__u8			cur_adv_instance;
 
 	__u8			irk[16];
 	__u32			rpa_timeout;
@@ -563,11 +568,6 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
 	hdev->discovery.scan_duration = 0;
 }
 
-static inline void adv_info_init(struct hci_dev *hdev)
-{
-	memset(&hdev->adv_instance, 0, sizeof(struct adv_info));
-}
-
 bool hci_discovery_active(struct hci_dev *hdev);
 
 void hci_discovery_set_state(struct hci_dev *hdev, int state);
@@ -1009,6 +1009,15 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 bdaddr_type);
 
+int hci_num_adv_instances(struct hci_dev *hdev);
+void hci_adv_instances_clear(struct hci_dev *hdev);
+struct adv_info *hci_find_adv_instance(struct hci_dev *hdev, u8 instance);
+int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
+			 u16 adv_data_len, u8 *adv_data,
+			 u16 scan_rsp_len, u8 *scan_rsp_data,
+			 work_func_t timeout_work, u16 timeout);
+int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance);
+
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 46b114c..15ab2eb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2613,6 +2613,120 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return 0;
 }
 
+struct adv_info *hci_find_adv_instance(struct hci_dev *hdev, u8 instance)
+{
+	struct adv_info *adv_instance;
+
+	list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
+		if (adv_instance->instance != instance)
+			continue;
+		return adv_instance;
+	}
+
+	return NULL;
+}
+
+/* This function requires the caller holds hdev->lock */
+int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance)
+{
+	struct adv_info *adv_instance;
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+	if (!adv_instance)
+		return -ENOENT;
+
+	BT_DBG("%s removing %dMR", hdev->name, instance);
+
+	if (adv_instance->timeout)
+		cancel_delayed_work(&adv_instance->timeout_exp);
+
+	list_del(&adv_instance->list);
+	kfree(adv_instance);
+
+	return 0;
+}
+
+/* This function requires the caller holds hdev->lock */
+void hci_adv_instances_clear(struct hci_dev *hdev)
+{
+	struct adv_info *adv_instance, *n;
+
+	list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances, list) {
+		if (adv_instance->timeout)
+			cancel_delayed_work(&adv_instance->timeout_exp);
+
+		list_del(&adv_instance->list);
+		kfree(adv_instance);
+	}
+}
+
+int hci_num_adv_instances(struct hci_dev *hdev)
+{
+	struct adv_info *adv_instance;
+	int num = 0;
+
+	list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
+		num++;
+	}
+
+	return num;
+}
+
+/* This function requires the caller holds hdev->lock */
+int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
+			 u16 adv_data_len, u8 *adv_data,
+			 u16 scan_rsp_len, u8 *scan_rsp_data,
+			 work_func_t timeout_work, u16 timeout)
+{
+	struct adv_info *adv_instance;
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+	if (adv_instance) {
+		if (adv_instance->timeout)
+			cancel_delayed_work(&adv_instance->timeout_exp);
+
+		memset(adv_instance->adv_data, 0,
+		       sizeof(adv_instance->adv_data));
+		memset(adv_instance->scan_rsp_data, 0,
+		       sizeof(adv_instance->scan_rsp_data));
+	} else {
+		if (hci_num_adv_instances(hdev) >= HCI_MAX_ADV_INSTANCES)
+			return -EOVERFLOW;
+
+		adv_instance = kmalloc(sizeof(*adv_instance), GFP_KERNEL);
+		if (!adv_instance)
+			return -ENOMEM;
+
+		memset(adv_instance, 0, sizeof(*adv_instance));
+		adv_instance->hdev = hdev;
+		INIT_DELAYED_WORK(&adv_instance->timeout_exp, timeout_work);
+		adv_instance->instance = instance;
+		list_add(&adv_instance->list, &hdev->adv_instances);
+	}
+
+	adv_instance->flags = flags;
+	adv_instance->adv_data_len = adv_data_len;
+	adv_instance->scan_rsp_len = scan_rsp_len;
+
+	if (adv_data_len)
+		memcpy(adv_instance->adv_data, adv_data, adv_data_len);
+
+	if (scan_rsp_len)
+		memcpy(adv_instance->scan_rsp_data,
+		       scan_rsp_data, scan_rsp_len);
+
+	adv_instance->timeout = timeout;
+
+	if (timeout)
+		queue_delayed_work(hdev->workqueue,
+				   &adv_instance->timeout_exp,
+				   msecs_to_jiffies(timeout * 1000));
+
+	BT_DBG("%s for %dMR", hdev->name, instance);
+
+	return 0;
+}
+
 struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *bdaddr_list,
 					 bdaddr_t *bdaddr, u8 type)
 {
@@ -3016,6 +3130,7 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->manufacturer = 0xffff;	/* Default to internal use */
 	hdev->inq_tx_power = HCI_TX_POWER_INVALID;
 	hdev->adv_tx_power = HCI_TX_POWER_INVALID;
+	hdev->cur_adv_instance = 0x00;
 
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
@@ -3057,6 +3172,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->pend_le_conns);
 	INIT_LIST_HEAD(&hdev->pend_le_reports);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
+	INIT_LIST_HEAD(&hdev->adv_instances);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
@@ -3079,7 +3195,6 @@ struct hci_dev *hci_alloc_dev(void)
 
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
-	adv_info_init(hdev);
 
 	return hdev;
 }
@@ -3253,6 +3368,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_smp_ltks_clear(hdev);
 	hci_smp_irks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
+	hci_adv_instances_clear(hdev);
 	hci_bdaddr_list_clear(&hdev->le_white_list);
 	hci_conn_params_clear_all(hdev);
 	hci_discovery_filter_clear(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 845dfcc..6c11141 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -858,31 +858,53 @@ static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
 	return ad_len;
 }
 
-static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
+static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
+					u8 *ptr)
 {
-	/* TODO: Set the appropriate entries based on advertising instance flags
-	 * here once flags other than 0 are supported.
+	struct adv_info *adv_instance;
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+	if (adv_instance) {
+		/* TODO: Set the appropriate entries based on advertising instance flags
+		 * here once flags other than 0 are supported.
+		 */
+		memcpy(ptr, adv_instance->scan_rsp_data,
+		       adv_instance->scan_rsp_len);
+
+		return adv_instance->scan_rsp_len;
+	}
+
+	return 0;
+}
+
+static u8 get_current_adv_instance(struct hci_dev *hdev)
+{
+	/* The "Set Advertising" setting supersedes the "Add Advertising"
+	 * setting. Here we set the advertising data based on which
+	 * setting was set. When neither apply, default to the global settings,
+	 * represented by instance "0".
 	 */
-	memcpy(ptr, hdev->adv_instance.scan_rsp_data,
-	       hdev->adv_instance.scan_rsp_len);
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
+	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		return hdev->cur_adv_instance;
 
-	return hdev->adv_instance.scan_rsp_len;
+	return 0x00;
 }
 
-static void update_scan_rsp_data_for_instance(struct hci_request *req,
-					      u8 instance)
+static void update_scan_rsp_data(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_scan_rsp_data cp;
-	u8 len;
+	u8 instance, len;
 
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return;
 
 	memset(&cp, 0, sizeof(cp));
 
+	instance = get_current_adv_instance(hdev);
 	if (instance)
-		len = create_instance_scan_rsp_data(hdev, cp.data);
+		len = create_instance_scan_rsp_data(hdev, instance, cp.data);
 	else
 		len = create_default_scan_rsp_data(hdev, cp.data);
 
@@ -898,25 +920,6 @@ static void update_scan_rsp_data_for_instance(struct hci_request *req,
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
 }
 
-static void update_scan_rsp_data(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 instance;
-
-	/* The "Set Advertising" setting supersedes the "Add Advertising"
-	 * setting. Here we set the scan response data based on which
-	 * setting was set. When neither apply, default to the global settings,
-	 * represented by instance "0".
-	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
-	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		instance = 0x01;
-	else
-		instance = 0x00;
-
-	update_scan_rsp_data_for_instance(req, instance);
-}
-
 static u8 get_adv_discov_flags(struct hci_dev *hdev)
 {
 	struct mgmt_pending_cmd *cmd;
@@ -941,20 +944,6 @@ static u8 get_adv_discov_flags(struct hci_dev *hdev)
 	return 0;
 }
 
-static u8 get_current_adv_instance(struct hci_dev *hdev)
-{
-	/* The "Set Advertising" setting supersedes the "Add Advertising"
-	 * setting. Here we set the advertising data based on which
-	 * setting was set. When neither apply, default to the global settings,
-	 * represented by instance "0".
-	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
-	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		return 0x01;
-
-	return 0x00;
-}
-
 static bool get_connectable(struct hci_dev *hdev)
 {
 	struct mgmt_pending_cmd *cmd;
@@ -975,40 +964,52 @@ static bool get_connectable(struct hci_dev *hdev)
 static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
 {
 	u32 flags;
+	struct adv_info *adv_instance;
 
-	if (instance > 0x01)
-		return 0;
+	if (instance == 0x00) {
+		/* Instance 0 always manages the "Tx Power" and "Flags" fields */
+		flags = MGMT_ADV_FLAG_TX_POWER | MGMT_ADV_FLAG_MANAGED_FLAGS;
 
-	if (instance == 0x01)
-		return hdev->adv_instance.flags;
+		/* For instance 0, the HCI_ADVERTISING_CONNECTABLE setting corresponds
+		 * to the "connectable" instance flag.
+		 */
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
+			flags |= MGMT_ADV_FLAG_CONNECTABLE;
 
-	/* Instance 0 always manages the "Tx Power" and "Flags" fields */
-	flags = MGMT_ADV_FLAG_TX_POWER | MGMT_ADV_FLAG_MANAGED_FLAGS;
+		return flags;
+	}
 
-	/* For instance 0, the HCI_ADVERTISING_CONNECTABLE setting corresponds
-	 * to the "connectable" instance flag.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
-		flags |= MGMT_ADV_FLAG_CONNECTABLE;
+	adv_instance = hci_find_adv_instance(hdev, instance);
+	if (adv_instance)
+		return adv_instance->flags;
 
-	return flags;
+	return 0;
 }
 
-static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
+static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
 {
-	/* Ignore instance 0 and other unsupported instances */
-	if (instance != 0x01)
+	u8 instance = get_current_adv_instance(hdev);
+	struct adv_info *adv_instance;
+
+	/* Ignore instance 0 */
+	if (instance == 0x00)
+		return 0;
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+	if (!adv_instance)
 		return 0;
 
 	/* TODO: Take into account the "appearance" and "local-name" flags here.
 	 * These are currently being ignored as they are not supported.
 	 */
-	return hdev->adv_instance.scan_rsp_len;
+	return adv_instance->scan_rsp_len;
 }
 
-static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
+static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
 {
+	struct adv_info *adv_instance;
 	u8 ad_len = 0, flags = 0;
+	u8 instance = get_current_adv_instance(hdev);
 	u32 instance_flags = get_adv_instance_flags(hdev, instance);
 
 	/* The Add Advertising command allows userspace to set both the general
@@ -1044,11 +1045,13 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 	}
 
 	if (instance) {
-		memcpy(ptr, hdev->adv_instance.adv_data,
-		       hdev->adv_instance.adv_data_len);
-
-		ad_len += hdev->adv_instance.adv_data_len;
-		ptr += hdev->adv_instance.adv_data_len;
+		adv_instance = hci_find_adv_instance(hdev, instance);
+		if (adv_instance) {
+			memcpy(ptr, adv_instance->adv_data,
+			       adv_instance->adv_data_len);
+			ad_len += adv_instance->adv_data_len;
+			ptr += adv_instance->adv_data_len;
+		}
 	}
 
 	/* Provide Tx Power only if we can provide a valid value for it */
@@ -1065,7 +1068,7 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 	return ad_len;
 }
 
-static void update_adv_data_for_instance(struct hci_request *req, u8 instance)
+static void update_adv_data(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_adv_data cp;
@@ -1076,7 +1079,7 @@ static void update_adv_data_for_instance(struct hci_request *req, u8 instance)
 
 	memset(&cp, 0, sizeof(cp));
 
-	len = create_instance_adv_data(hdev, instance, cp.data);
+	len = create_adv_data(hdev, cp.data);
 
 	/* There's nothing to do if the data hasn't changed */
 	if (hdev->adv_data_len == len &&
@@ -1091,14 +1094,6 @@ static void update_adv_data_for_instance(struct hci_request *req, u8 instance)
 	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
 }
 
-static void update_adv_data(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 instance = get_current_adv_instance(hdev);
-
-	update_adv_data_for_instance(req, instance);
-}
-
 int mgmt_update_adv_data(struct hci_dev *hdev)
 {
 	struct hci_request req;
@@ -1237,9 +1232,9 @@ static void enable_advertising(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_adv_param cp;
+	u8 instance;
 	u8 own_addr_type, enable = 0x01;
 	bool connectable;
-	u8 instance;
 	u32 flags;
 
 	if (hci_conn_num(hdev, LE_LINK) > 0)
@@ -1277,7 +1272,7 @@ static void enable_advertising(struct hci_request *req)
 
 	if (connectable)
 		cp.type = LE_ADV_IND;
-	else if (get_adv_instance_scan_rsp_len(hdev, instance))
+	else if (get_cur_adv_instance_scan_rsp_len(hdev))
 		cp.type = LE_ADV_SCAN_IND;
 	else
 		cp.type = LE_ADV_NONCONN_IND;
@@ -1459,27 +1454,26 @@ static void advertising_removed(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_ADVERTISING_REMOVED, hdev, &ev, sizeof(ev), sk);
 }
 
-static void clear_adv_instance(struct hci_dev *hdev)
+static void clear_adv_instance(struct sock *sk, struct hci_dev *hdev, u8 instance)
 {
-	struct hci_request req;
-
-	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
-		return;
-
-	if (hdev->adv_instance.timeout)
-		cancel_delayed_work(&hdev->adv_instance.timeout_exp);
-
-	memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
-	advertising_removed(NULL, hdev, 1);
-	hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
-
-	if (!hdev_is_powered(hdev) ||
-	    hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		return;
+	struct adv_info *adv_instance, *n;
+	int err;
 
-	hci_req_init(&req, hdev);
-	disable_advertising(&req);
-	hci_req_run(&req, NULL);
+	/* A value of 0 indicates that all instances should be cleared. */
+	if (instance == 0x00) {
+		list_for_each_entry_safe(adv_instance, n,
+					 &hdev->adv_instances, list) {
+			err = hci_remove_adv_instance(hdev,
+						      adv_instance->instance);
+			if (err == 0)
+				advertising_removed(sk, hdev,
+						    adv_instance->instance);
+		}
+	} else {
+		err = hci_remove_adv_instance(hdev, instance);
+		if (err == 0)
+			advertising_removed(sk, hdev, instance);
+	}
 }
 
 static int clean_up_hci_state(struct hci_dev *hdev)
@@ -1497,8 +1491,7 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	}
 
-	if (hdev->adv_instance.timeout)
-		clear_adv_instance(hdev);
+	clear_adv_instance(NULL, hdev, 0x00);
 
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 		disable_advertising(&req);
@@ -4669,6 +4662,7 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
 {
 	struct cmd_lookup match = { NULL, hdev };
 	struct hci_request req;
+	struct adv_info *adv_instance;
 
 	hci_dev_lock(hdev);
 
@@ -4697,11 +4691,14 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
 	 * set up earlier, then enable the advertising instance.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
+	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) ||
+	    list_empty(&hdev->adv_instances))
 		goto unlock;
 
 	hci_req_init(&req, hdev);
-
+	adv_instance = list_first_entry(&hdev->adv_instances,
+					struct adv_info, list);
+	hdev->cur_adv_instance = adv_instance->instance;
 	update_adv_data(&req);
 	enable_advertising(&req);
 
@@ -4792,8 +4789,9 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	if (val) {
 		/* Switch to instance "0" for the Set Advertising setting. */
-		update_adv_data_for_instance(&req, 0);
-		update_scan_rsp_data_for_instance(&req, 0);
+		hdev->cur_adv_instance = 0x00;
+		update_adv_data(&req);
+		update_scan_rsp_data(&req);
 		enable_advertising(&req);
 	} else {
 		disable_advertising(&req);
@@ -6631,8 +6629,10 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_rp_read_adv_features *rp;
 	size_t rp_len;
-	int err;
+	int err, i;
 	bool instance;
+	int num_adv_instances = 0;
+	struct adv_info *adv_instance;
 	u32 supported_flags;
 
 	BT_DBG("%s", hdev->name);
@@ -6645,12 +6645,11 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 
 	rp_len = sizeof(*rp);
 
-	/* Currently only one instance is supported, so just add 1 to the
-	 * response length.
-	 */
 	instance = hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE);
-	if (instance)
-		rp_len++;
+	if (instance) {
+		num_adv_instances = hci_num_adv_instances(hdev);
+		rp_len += num_adv_instances;
+	}
 
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
@@ -6663,16 +6662,15 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	rp->supported_flags = cpu_to_le32(supported_flags);
 	rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
 	rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
-	rp->max_instances = 1;
+	rp->max_instances = HCI_MAX_ADV_INSTANCES;
+	rp->num_instances = num_adv_instances;
 
-	/* Currently only one instance is supported, so simply return the
-	 * current instance number.
-	 */
 	if (instance) {
-		rp->num_instances = 1;
-		rp->instance[0] = 1;
-	} else {
-		rp->num_instances = 0;
+		i = 0;
+		list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
+			rp->instance[i] = adv_instance->instance;
+			i++;
+		}
 	}
 
 	hci_dev_unlock(hdev);
@@ -6732,24 +6730,37 @@ static void add_advertising_complete(struct hci_dev *hdev, u8 status,
 				     u16 opcode)
 {
 	struct mgmt_pending_cmd *cmd;
+	struct mgmt_cp_add_advertising *cp = NULL;
 	struct mgmt_rp_add_advertising rp;
+	struct adv_info *adv_instance;
 
 	BT_DBG("status %d", status);
 
 	hci_dev_lock(hdev);
 
 	cmd = pending_find(MGMT_OP_ADD_ADVERTISING, hdev);
+	if (cmd)
+		cp = cmd->param;
 
 	if (status) {
+		/* TODO: Start advertising another adv instance if any? */
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
-		memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
-		advertising_removed(cmd ? cmd->sk : NULL, hdev, 1);
+
+		if (cmd) {
+			adv_instance = hci_find_adv_instance(hdev,
+							     cp->instance);
+			if (adv_instance) {
+				hci_remove_adv_instance(hdev, cp->instance);
+				advertising_removed(cmd ? cmd->sk : NULL, hdev,
+						    cp->instance);
+			}
+		}
 	}
 
 	if (!cmd)
 		goto unlock;
 
-	rp.instance = 0x01;
+	rp.instance = cp->instance;
 
 	if (status)
 		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
@@ -6766,13 +6777,33 @@ unlock:
 
 static void adv_timeout_expired(struct work_struct *work)
 {
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    adv_instance.timeout_exp.work);
+	struct adv_info *adv_instance;
+	struct hci_dev *hdev;
+	int err;
+	struct hci_request req;
+
+	adv_instance = container_of(work, struct adv_info, timeout_exp.work);
+	hdev = adv_instance->hdev;
 
-	hdev->adv_instance.timeout = 0;
+	adv_instance->timeout = 0;
 
 	hci_dev_lock(hdev);
-	clear_adv_instance(hdev);
+	err = hci_remove_adv_instance(hdev, adv_instance->instance);
+	if (err == 0)
+		advertising_removed(NULL, hdev, adv_instance->instance);
+
+	/* TODO: Schedule the next advertisement instance here if any. */
+	hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
+
+	if (!hdev_is_powered(hdev) ||
+	    hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		goto unlock;
+
+	hci_req_init(&req, hdev);
+	disable_advertising(&req);
+	hci_req_run(&req, NULL);
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -6831,38 +6862,30 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	INIT_DELAYED_WORK(&hdev->adv_instance.timeout_exp, adv_timeout_expired);
-
-	hdev->adv_instance.flags = flags;
-	hdev->adv_instance.adv_data_len = cp->adv_data_len;
-	hdev->adv_instance.scan_rsp_len = cp->scan_rsp_len;
-
-	if (cp->adv_data_len)
-		memcpy(hdev->adv_instance.adv_data, cp->data, cp->adv_data_len);
-
-	if (cp->scan_rsp_len)
-		memcpy(hdev->adv_instance.scan_rsp_data,
-		       cp->data + cp->adv_data_len, cp->scan_rsp_len);
-
-	if (hdev->adv_instance.timeout)
-		cancel_delayed_work(&hdev->adv_instance.timeout_exp);
-
-	hdev->adv_instance.timeout = timeout;
+	err = hci_add_adv_instance(hdev, cp->instance, flags,
+					 cp->adv_data_len, cp->data,
+					 cp->scan_rsp_len,
+					 cp->data + cp->adv_data_len,
+					 adv_timeout_expired, timeout);
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
+				      MGMT_STATUS_FAILED);
+		goto unlock;
+	}
 
-	if (timeout)
-		queue_delayed_work(hdev->workqueue,
-				   &hdev->adv_instance.timeout_exp,
-				   msecs_to_jiffies(timeout * 1000));
+	hdev->cur_adv_instance = cp->instance;
 
+	// TODO: Trigger an advertising added event even when instance
+	// advertising is already switched on?
 	if (!hci_dev_test_and_set_flag(hdev, HCI_ADVERTISING_INSTANCE))
-		advertising_added(sk, hdev, 1);
+		advertising_added(sk, hdev, cp->instance);
 
 	/* If the HCI_ADVERTISING flag is set or the device isn't powered then
 	 * we have no HCI communication to make. Simply return.
 	 */
 	if (!hdev_is_powered(hdev) ||
 	    hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
-		rp.instance = 0x01;
+		rp.instance = cp->instance;
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
 		goto unlock;
@@ -6933,12 +6956,11 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("%s", hdev->name);
 
-	/* The current implementation only allows modifying instance no 1. A
-	 * value of 0 indicates that all instances should be cleared.
-	 */
-	if (cp->instance > 1)
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADVERTISING,
-				       MGMT_STATUS_INVALID_PARAMS);
+	if (cp->instance != 0x00) {
+		if (!hci_find_adv_instance(hdev, cp->instance))
+			return mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADVERTISING,
+					       MGMT_STATUS_INVALID_PARAMS);
+	}
 
 	hci_dev_lock(hdev);
 
@@ -6956,21 +6978,22 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (hdev->adv_instance.timeout)
-		cancel_delayed_work(&hdev->adv_instance.timeout_exp);
-
-	memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
-
-	advertising_removed(sk, hdev, 1);
+	clear_adv_instance(sk, hdev, cp->instance);
 
+	/* TODO: Only switch off advertising if the instance list is empty
+	 * else switch to the next remaining adv instance. */
 	hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
 
-	/* If the HCI_ADVERTISING flag is set or the device isn't powered then
-	 * we have no HCI communication to make. Simply return.
+	/* If the HCI_ADVERTISING[_INSTANCE] flag is set or the device
+	 * isn't powered then we have no HCI communication to make.
+	 * Simply return.
+	 */
+	/* TODO: Only switch off instance advertising when the flag has
+	 * actually been unset (see TODO above).
 	 */
 	if (!hdev_is_powered(hdev) ||
 	    hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
-		rp.instance = 1;
+		rp.instance = cp->instance;
 		err = mgmt_cmd_complete(sk, hdev->id,
 					MGMT_OP_REMOVE_ADVERTISING,
 					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
-- 
1.9.1

