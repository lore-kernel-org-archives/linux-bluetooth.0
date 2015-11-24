Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 24 Nov 2015 14:05:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: Move advertising instance management to
 hci_request.c
Message-ID: <20151124120543.GA30180@t440s.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448366527-29714-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This paves the way for eventually performing advertising changes
through the hdev->req_workqueue. Some new APIs need to be exposed from
mgmt.c to hci_request.c and vice-versa, but many of them will go away
once hdev->req_workqueue gets used.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   9 +-
 net/bluetooth/hci_conn.c         |   2 +-
 net/bluetooth/hci_core.c         |  19 +-
 net/bluetooth/hci_event.c        |   4 +-
 net/bluetooth/hci_request.c      | 533 +++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_request.h      |  14 +
 net/bluetooth/mgmt.c             | 574 +++------------------------------------
 7 files changed, 589 insertions(+), 566 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index eda809a5c3df..b56085b6ecce 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1434,9 +1434,7 @@ void mgmt_index_added(struct hci_dev *hdev);
 void mgmt_index_removed(struct hci_dev *hdev);
 void mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
-int mgmt_update_adv_data(struct hci_dev *hdev);
 void mgmt_discoverable_timeout(struct hci_dev *hdev);
-void mgmt_adv_timeout_expired(struct hci_dev *hdev);
 void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent);
 void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
@@ -1491,8 +1489,13 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			 u8 bdaddr_type, u8 store_hint, u16 min_interval,
 			 u16 max_interval, u16 latency, u16 timeout);
-void mgmt_reenable_advertising(struct hci_dev *hdev);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
+bool mgmt_get_connectable(struct hci_dev *hdev);
+u8 mgmt_get_adv_discov_flags(struct hci_dev *hdev);
+void mgmt_advertising_added(struct sock *sk, struct hci_dev *hdev,
+			    u8 instance);
+void mgmt_advertising_removed(struct sock *sk, struct hci_dev *hdev,
+			      u8 instance);
 
 u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 		      u16 to_multiplier);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2d334e07fd77..e2600213cd50 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -683,7 +683,7 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	/* Re-enable advertising in case this was a failed connection
 	 * attempt as a peripheral.
 	 */
-	mgmt_reenable_advertising(hdev);
+	hci_req_reenable_advertising(hdev);
 }
 
 static void create_le_conn_complete(struct hci_dev *hdev, u8 status, u16 opcode)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 89af7e4fac02..bab8958bf46e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1549,11 +1549,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		cancel_delayed_work_sync(&hdev->rpa_expired);
 
-	if (hdev->adv_instance_timeout) {
-		cancel_delayed_work_sync(&hdev->adv_instance_expire);
-		hdev->adv_instance_timeout = 0;
-	}
-
 	/* Avoid potential lockdep warnings from the *_flush() calls by
 	 * ensuring the workqueue is empty up front.
 	 */
@@ -1774,7 +1769,7 @@ static void hci_update_scan_state(struct hci_dev *hdev, u8 scan)
 		hci_dev_set_flag(hdev, HCI_BREDR_ENABLED);
 
 		if (hci_dev_test_flag(hdev, HCI_LE_ENABLED))
-			mgmt_update_adv_data(hdev);
+			hci_req_update_adv_data(hdev, HCI_ADV_CURRENT);
 
 		mgmt_new_settings(hdev);
 	}
@@ -2112,17 +2107,6 @@ static void hci_discov_off(struct work_struct *work)
 	mgmt_discoverable_timeout(hdev);
 }
 
-static void hci_adv_timeout_expire(struct work_struct *work)
-{
-	struct hci_dev *hdev;
-
-	hdev = container_of(work, struct hci_dev, adv_instance_expire.work);
-
-	BT_DBG("%s", hdev->name);
-
-	mgmt_adv_timeout_expired(hdev);
-}
-
 void hci_uuids_clear(struct hci_dev *hdev)
 {
 	struct bt_uuid *uuid, *tmp;
@@ -3003,7 +2987,6 @@ struct hci_dev *hci_alloc_dev(void)
 
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
-	INIT_DELAYED_WORK(&hdev->adv_instance_expire, hci_adv_timeout_expire);
 
 	skb_queue_head_init(&hdev->rx_q);
 	skb_queue_head_init(&hdev->cmd_q);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 703e37f1a955..7554da5b7a8f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1183,7 +1183,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 		else if (!hci_dev_test_flag(hdev, HCI_LE_ADV) &&
 			 hdev->discovery.state == DISCOVERY_FINDING)
-			mgmt_reenable_advertising(hdev);
+			hci_req_reenable_advertising(hdev);
 
 		break;
 
@@ -2401,7 +2401,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 * is timed out due to Directed Advertising."
 	 */
 	if (type == LE_LINK)
-		mgmt_reenable_advertising(hdev);
+		hci_req_reenable_advertising(hdev);
 
 unlock:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 7c85435b8982..e6622bd1926d 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -23,6 +23,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/mgmt.h>
 
 #include "smp.h"
 #include "hci_request.h"
@@ -580,6 +581,524 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 		    &enable_cp);
 }
 
+static u8 get_current_adv_instance(struct hci_dev *hdev)
+{
+	/* The "Set Advertising" setting supersedes the "Add Advertising"
+	 * setting. Here we set the advertising data based on which
+	 * setting was set. When neither apply, default to the global settings,
+	 * represented by instance "0".
+	 */
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
+	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		return hdev->cur_adv_instance;
+
+	return 0x00;
+}
+
+static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
+{
+	u8 instance = get_current_adv_instance(hdev);
+	struct adv_info *adv_instance;
+
+	/* Ignore instance 0 */
+	if (instance == 0x00)
+		return 0;
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+	if (!adv_instance)
+		return 0;
+
+	/* TODO: Take into account the "appearance" and "local-name" flags here.
+	 * These are currently being ignored as they are not supported.
+	 */
+	return adv_instance->scan_rsp_len;
+}
+
+void __hci_req_disable_advertising(struct hci_request *req)
+{
+	u8 enable = 0x00;
+
+	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
+}
+
+static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
+{
+	u32 flags;
+	struct adv_info *adv_instance;
+
+	if (instance == 0x00) {
+		/* Instance 0 always manages the "Tx Power" and "Flags"
+		 * fields
+		 */
+		flags = MGMT_ADV_FLAG_TX_POWER | MGMT_ADV_FLAG_MANAGED_FLAGS;
+
+		/* For instance 0, the HCI_ADVERTISING_CONNECTABLE setting
+		 * corresponds to the "connectable" instance flag.
+		 */
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
+			flags |= MGMT_ADV_FLAG_CONNECTABLE;
+
+		return flags;
+	}
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+
+	/* Return 0 when we got an invalid instance identifier. */
+	if (!adv_instance)
+		return 0;
+
+	return adv_instance->flags;
+}
+
+void __hci_req_enable_advertising(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_adv_param cp;
+	u8 own_addr_type, enable = 0x01;
+	bool connectable;
+	u8 instance;
+	u32 flags;
+
+	if (hci_conn_num(hdev, LE_LINK) > 0)
+		return;
+
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
+		__hci_req_disable_advertising(req);
+
+	/* Clear the HCI_LE_ADV bit temporarily so that the
+	 * hci_update_random_address knows that it's safe to go ahead
+	 * and write a new random address. The flag will be set back on
+	 * as soon as the SET_ADV_ENABLE HCI command completes.
+	 */
+	hci_dev_clear_flag(hdev, HCI_LE_ADV);
+
+	instance = get_current_adv_instance(hdev);
+	flags = get_adv_instance_flags(hdev, instance);
+
+	/* If the "connectable" instance flag was not set, then choose between
+	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
+	 */
+	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
+		      mgmt_get_connectable(hdev);
+
+	/* Set require_privacy to true only when non-connectable
+	 * advertising is used. In that case it is fine to use a
+	 * non-resolvable private address.
+	 */
+	if (hci_update_random_address(req, !connectable, &own_addr_type) < 0)
+		return;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
+	cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
+
+	if (connectable)
+		cp.type = LE_ADV_IND;
+	else if (get_cur_adv_instance_scan_rsp_len(hdev))
+		cp.type = LE_ADV_SCAN_IND;
+	else
+		cp.type = LE_ADV_NONCONN_IND;
+
+	cp.own_address_type = own_addr_type;
+	cp.channel_map = hdev->le_adv_channel_map;
+
+	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
+
+	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
+}
+
+static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
+{
+	u8 ad_len = 0;
+	size_t name_len;
+
+	name_len = strlen(hdev->dev_name);
+	if (name_len > 0) {
+		size_t max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
+
+		if (name_len > max_len) {
+			name_len = max_len;
+			ptr[1] = EIR_NAME_SHORT;
+		} else
+			ptr[1] = EIR_NAME_COMPLETE;
+
+		ptr[0] = name_len + 1;
+
+		memcpy(ptr + 2, hdev->dev_name, name_len);
+
+		ad_len += (name_len + 2);
+		ptr += (name_len + 2);
+	}
+
+	return ad_len;
+}
+
+static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
+					u8 *ptr)
+{
+	struct adv_info *adv_instance;
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+	if (!adv_instance)
+		return 0;
+
+	/* TODO: Set the appropriate entries based on advertising instance flags
+	 * here once flags other than 0 are supported.
+	 */
+	memcpy(ptr, adv_instance->scan_rsp_data,
+	       adv_instance->scan_rsp_len);
+
+	return adv_instance->scan_rsp_len;
+}
+
+static void update_inst_scan_rsp_data(struct hci_request *req, u8 instance)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_scan_rsp_data cp;
+	u8 len;
+
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		return;
+
+	memset(&cp, 0, sizeof(cp));
+
+	if (instance)
+		len = create_instance_scan_rsp_data(hdev, instance, cp.data);
+	else
+		len = create_default_scan_rsp_data(hdev, cp.data);
+
+	if (hdev->scan_rsp_data_len == len &&
+	    !memcmp(cp.data, hdev->scan_rsp_data, len))
+		return;
+
+	memcpy(hdev->scan_rsp_data, cp.data, sizeof(cp.data));
+	hdev->scan_rsp_data_len = len;
+
+	cp.length = len;
+
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
+}
+
+void __hci_req_update_scan_rsp_data(struct hci_request *req, int instance)
+{
+	if (instance == HCI_ADV_CURRENT)
+		instance = get_current_adv_instance(req->hdev);
+
+	update_inst_scan_rsp_data(req, get_current_adv_instance(req->hdev));
+}
+
+static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
+{
+	struct adv_info *adv_instance = NULL;
+	u8 ad_len = 0, flags = 0;
+	u32 instance_flags;
+
+	/* Return 0 when the current instance identifier is invalid. */
+	if (instance) {
+		adv_instance = hci_find_adv_instance(hdev, instance);
+		if (!adv_instance)
+			return 0;
+	}
+
+	instance_flags = get_adv_instance_flags(hdev, instance);
+
+	/* The Add Advertising command allows userspace to set both the general
+	 * and limited discoverable flags.
+	 */
+	if (instance_flags & MGMT_ADV_FLAG_DISCOV)
+		flags |= LE_AD_GENERAL;
+
+	if (instance_flags & MGMT_ADV_FLAG_LIMITED_DISCOV)
+		flags |= LE_AD_LIMITED;
+
+	if (flags || (instance_flags & MGMT_ADV_FLAG_MANAGED_FLAGS)) {
+		/* If a discovery flag wasn't provided, simply use the global
+		 * settings.
+		 */
+		if (!flags)
+			flags |= mgmt_get_adv_discov_flags(hdev);
+
+		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+			flags |= LE_AD_NO_BREDR;
+
+		/* If flags would still be empty, then there is no need to
+		 * include the "Flags" AD field".
+		 */
+		if (flags) {
+			ptr[0] = 0x02;
+			ptr[1] = EIR_FLAGS;
+			ptr[2] = flags;
+
+			ad_len += 3;
+			ptr += 3;
+		}
+	}
+
+	if (adv_instance) {
+		memcpy(ptr, adv_instance->adv_data,
+		       adv_instance->adv_data_len);
+		ad_len += adv_instance->adv_data_len;
+		ptr += adv_instance->adv_data_len;
+	}
+
+	/* Provide Tx Power only if we can provide a valid value for it */
+	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID &&
+	    (instance_flags & MGMT_ADV_FLAG_TX_POWER)) {
+		ptr[0] = 0x02;
+		ptr[1] = EIR_TX_POWER;
+		ptr[2] = (u8)hdev->adv_tx_power;
+
+		ad_len += 3;
+		ptr += 3;
+	}
+
+	return ad_len;
+}
+
+static void update_inst_adv_data(struct hci_request *req, u8 instance)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_adv_data cp;
+	u8 len;
+
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		return;
+
+	memset(&cp, 0, sizeof(cp));
+
+	len = create_instance_adv_data(hdev, instance, cp.data);
+
+	/* There's nothing to do if the data hasn't changed */
+	if (hdev->adv_data_len == len &&
+	    memcmp(cp.data, hdev->adv_data, len) == 0)
+		return;
+
+	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
+	hdev->adv_data_len = len;
+
+	cp.length = len;
+
+	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
+}
+
+void __hci_req_update_adv_data(struct hci_request *req, int instance)
+{
+	if (instance == HCI_ADV_CURRENT)
+		instance = get_current_adv_instance(req->hdev);
+
+	update_inst_adv_data(req, instance);
+}
+
+int hci_req_update_adv_data(struct hci_dev *hdev, int instance)
+{
+	struct hci_request req;
+
+	hci_req_init(&req, hdev);
+	__hci_req_update_adv_data(&req, instance);
+
+	return hci_req_run(&req, NULL);
+}
+
+static void adv_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+{
+	BT_DBG("%s status %u", hdev->name, status);
+}
+
+void hci_req_reenable_advertising(struct hci_dev *hdev)
+{
+	struct hci_request req;
+	u8 instance;
+
+	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
+	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
+		return;
+
+	instance = get_current_adv_instance(hdev);
+
+	hci_req_init(&req, hdev);
+
+	if (instance) {
+		__hci_req_schedule_adv_instance(&req, instance, true);
+	} else {
+		__hci_req_update_adv_data(&req, HCI_ADV_CURRENT);
+		__hci_req_update_scan_rsp_data(&req, HCI_ADV_CURRENT);
+		__hci_req_enable_advertising(&req);
+	}
+
+	hci_req_run(&req, adv_enable_complete);
+}
+
+static void adv_timeout_expire(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    adv_instance_expire.work);
+
+	struct hci_request req;
+	u8 instance;
+
+	BT_DBG("%s", hdev->name);
+
+	hci_dev_lock(hdev);
+
+	hdev->adv_instance_timeout = 0;
+
+	instance = get_current_adv_instance(hdev);
+	if (instance == 0x00)
+		goto unlock;
+
+	hci_req_init(&req, hdev);
+
+	hci_req_clear_adv_instance(hdev, &req, instance, false);
+
+	if (list_empty(&hdev->adv_instances))
+		__hci_req_disable_advertising(&req);
+
+	if (!skb_queue_empty(&req.cmd_q))
+		hci_req_run(&req, NULL);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
+				    bool force)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct adv_info *adv_instance = NULL;
+	u16 timeout;
+
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
+		return -EPERM;
+
+	if (hdev->adv_instance_timeout)
+		return -EBUSY;
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+	if (!adv_instance)
+		return -ENOENT;
+
+	/* A zero timeout means unlimited advertising. As long as there is
+	 * only one instance, duration should be ignored. We still set a timeout
+	 * in case further instances are being added later on.
+	 *
+	 * If the remaining lifetime of the instance is more than the duration
+	 * then the timeout corresponds to the duration, otherwise it will be
+	 * reduced to the remaining instance lifetime.
+	 */
+	if (adv_instance->timeout == 0 ||
+	    adv_instance->duration <= adv_instance->remaining_time)
+		timeout = adv_instance->duration;
+	else
+		timeout = adv_instance->remaining_time;
+
+	/* The remaining time is being reduced unless the instance is being
+	 * advertised without time limit.
+	 */
+	if (adv_instance->timeout)
+		adv_instance->remaining_time =
+				adv_instance->remaining_time - timeout;
+
+	hdev->adv_instance_timeout = timeout;
+	queue_delayed_work(hdev->req_workqueue,
+			   &hdev->adv_instance_expire,
+			   msecs_to_jiffies(timeout * 1000));
+
+	/* If we're just re-scheduling the same instance again then do not
+	 * execute any HCI commands. This happens when a single instance is
+	 * being advertised.
+	 */
+	if (!force && hdev->cur_adv_instance == instance &&
+	    hci_dev_test_flag(hdev, HCI_LE_ADV))
+		return 0;
+
+	hdev->cur_adv_instance = instance;
+	__hci_req_update_adv_data(req, HCI_ADV_CURRENT);
+	__hci_req_update_scan_rsp_data(req, HCI_ADV_CURRENT);
+	__hci_req_enable_advertising(req);
+
+	return 0;
+}
+
+static void cancel_adv_timeout(struct hci_dev *hdev)
+{
+	if (hdev->adv_instance_timeout) {
+		hdev->adv_instance_timeout = 0;
+		cancel_delayed_work(&hdev->adv_instance_expire);
+	}
+}
+
+/* For a single instance:
+ * - force == true: The instance will be removed even when its remaining
+ *   lifetime is not zero.
+ * - force == false: the instance will be deactivated but kept stored unless
+ *   the remaining lifetime is zero.
+ *
+ * For instance == 0x00:
+ * - force == true: All instances will be removed regardless of their timeout
+ *   setting.
+ * - force == false: Only instances that have a timeout will be removed.
+ */
+void hci_req_clear_adv_instance(struct hci_dev *hdev, struct hci_request *req,
+				u8 instance, bool force)
+{
+	struct adv_info *adv_instance, *n, *next_instance = NULL;
+	int err;
+	u8 rem_inst;
+
+	/* Cancel any timeout concerning the removed instance(s). */
+	if (!instance || hdev->cur_adv_instance == instance)
+		cancel_adv_timeout(hdev);
+
+	/* Get the next instance to advertise BEFORE we remove
+	 * the current one. This can be the same instance again
+	 * if there is only one instance.
+	 */
+	if (instance && hdev->cur_adv_instance == instance)
+		next_instance = hci_get_next_instance(hdev, instance);
+
+	if (instance == 0x00) {
+		list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances,
+					 list) {
+			if (!(force || adv_instance->timeout))
+				continue;
+
+			rem_inst = adv_instance->instance;
+			err = hci_remove_adv_instance(hdev, rem_inst);
+			if (!err)
+				mgmt_advertising_removed(NULL, hdev, rem_inst);
+		}
+		hdev->cur_adv_instance = 0x00;
+	} else {
+		adv_instance = hci_find_adv_instance(hdev, instance);
+
+		if (force || (adv_instance && adv_instance->timeout &&
+			      !adv_instance->remaining_time)) {
+			/* Don't advertise a removed instance. */
+			if (next_instance &&
+			    next_instance->instance == instance)
+				next_instance = NULL;
+
+			err = hci_remove_adv_instance(hdev, instance);
+			if (!err)
+				mgmt_advertising_removed(NULL, hdev, instance);
+		}
+	}
+
+	if (list_empty(&hdev->adv_instances)) {
+		hdev->cur_adv_instance = 0x00;
+		hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
+	}
+
+	if (!req || !hdev_is_powered(hdev) ||
+	    hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		return;
+
+	if (next_instance)
+		__hci_req_schedule_adv_instance(req, next_instance->instance,
+						false);
+}
+
 static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -1031,14 +1550,6 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static void cancel_adv_timeout(struct hci_dev *hdev)
-{
-	if (hdev->adv_instance_timeout) {
-		hdev->adv_instance_timeout = 0;
-		cancel_delayed_work(&hdev->adv_instance_expire);
-	}
-}
-
 static void disable_advertising(struct hci_request *req)
 {
 	u8 enable = 0x00;
@@ -1280,6 +1791,7 @@ void hci_request_setup(struct hci_dev *hdev)
 	INIT_WORK(&hdev->scan_update, scan_update_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
+	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
 }
 
 void hci_request_cancel_all(struct hci_dev *hdev)
@@ -1291,4 +1803,9 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->scan_update);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
+
+	if (hdev->adv_instance_timeout) {
+		cancel_delayed_work_sync(&hdev->adv_instance_expire);
+		hdev->adv_instance_timeout = 0;
+	}
 }
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index cc8275520fb2..5358b1b12ca0 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -58,6 +58,20 @@ struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 void hci_req_add_le_scan_disable(struct hci_request *req);
 void hci_req_add_le_passive_scan(struct hci_request *req);
 
+#define HCI_ADV_CURRENT (-1)
+
+void hci_req_reenable_advertising(struct hci_dev *hdev);
+void __hci_req_enable_advertising(struct hci_request *req);
+void __hci_req_disable_advertising(struct hci_request *req);
+void __hci_req_update_adv_data(struct hci_request *req, int instance);
+int hci_req_update_adv_data(struct hci_dev *hdev, int instance);
+void __hci_req_update_scan_rsp_data(struct hci_request *req, int instance);
+
+int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
+				    bool force);
+void hci_req_clear_adv_instance(struct hci_dev *hdev, struct hci_request *req,
+				u8 instance, bool force);
+
 /* Returns true if HCI commands were queued */
 bool hci_req_stop_discovery(struct hci_request *req);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0d20e1328528..6d0f0025052f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -841,98 +841,7 @@ static struct mgmt_pending_cmd *pending_find_data(u16 opcode,
 	return mgmt_pending_find_data(HCI_CHANNEL_CONTROL, opcode, hdev, data);
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
-		return hdev->cur_adv_instance;
-
-	return 0x00;
-}
-
-static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
-{
-	u8 ad_len = 0;
-	size_t name_len;
-
-	name_len = strlen(hdev->dev_name);
-	if (name_len > 0) {
-		size_t max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
-
-		if (name_len > max_len) {
-			name_len = max_len;
-			ptr[1] = EIR_NAME_SHORT;
-		} else
-			ptr[1] = EIR_NAME_COMPLETE;
-
-		ptr[0] = name_len + 1;
-
-		memcpy(ptr + 2, hdev->dev_name, name_len);
-
-		ad_len += (name_len + 2);
-		ptr += (name_len + 2);
-	}
-
-	return ad_len;
-}
-
-static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
-					u8 *ptr)
-{
-	struct adv_info *adv_instance;
-
-	adv_instance = hci_find_adv_instance(hdev, instance);
-	if (!adv_instance)
-		return 0;
-
-	/* TODO: Set the appropriate entries based on advertising instance flags
-	 * here once flags other than 0 are supported.
-	 */
-	memcpy(ptr, adv_instance->scan_rsp_data,
-	       adv_instance->scan_rsp_len);
-
-	return adv_instance->scan_rsp_len;
-}
-
-static void update_inst_scan_rsp_data(struct hci_request *req, u8 instance)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_scan_rsp_data cp;
-	u8 len;
-
-	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
-		return;
-
-	memset(&cp, 0, sizeof(cp));
-
-	if (instance)
-		len = create_instance_scan_rsp_data(hdev, instance, cp.data);
-	else
-		len = create_default_scan_rsp_data(hdev, cp.data);
-
-	if (hdev->scan_rsp_data_len == len &&
-	    !memcmp(cp.data, hdev->scan_rsp_data, len))
-		return;
-
-	memcpy(hdev->scan_rsp_data, cp.data, sizeof(cp.data));
-	hdev->scan_rsp_data_len = len;
-
-	cp.length = len;
-
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
-}
-
-static void update_scan_rsp_data(struct hci_request *req)
-{
-	update_inst_scan_rsp_data(req, get_current_adv_instance(req->hdev));
-}
-
-static u8 get_adv_discov_flags(struct hci_dev *hdev)
+u8 mgmt_get_adv_discov_flags(struct hci_dev *hdev)
 {
 	struct mgmt_pending_cmd *cmd;
 
@@ -956,7 +865,7 @@ static u8 get_adv_discov_flags(struct hci_dev *hdev)
 	return 0;
 }
 
-static bool get_connectable(struct hci_dev *hdev)
+bool mgmt_get_connectable(struct hci_dev *hdev)
 {
 	struct mgmt_pending_cmd *cmd;
 
@@ -973,163 +882,6 @@ static bool get_connectable(struct hci_dev *hdev)
 	return hci_dev_test_flag(hdev, HCI_CONNECTABLE);
 }
 
-static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
-{
-	u32 flags;
-	struct adv_info *adv_instance;
-
-	if (instance == 0x00) {
-		/* Instance 0 always manages the "Tx Power" and "Flags"
-		 * fields
-		 */
-		flags = MGMT_ADV_FLAG_TX_POWER | MGMT_ADV_FLAG_MANAGED_FLAGS;
-
-		/* For instance 0, the HCI_ADVERTISING_CONNECTABLE setting
-		 * corresponds to the "connectable" instance flag.
-		 */
-		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
-			flags |= MGMT_ADV_FLAG_CONNECTABLE;
-
-		return flags;
-	}
-
-	adv_instance = hci_find_adv_instance(hdev, instance);
-
-	/* Return 0 when we got an invalid instance identifier. */
-	if (!adv_instance)
-		return 0;
-
-	return adv_instance->flags;
-}
-
-static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
-{
-	u8 instance = get_current_adv_instance(hdev);
-	struct adv_info *adv_instance;
-
-	/* Ignore instance 0 */
-	if (instance == 0x00)
-		return 0;
-
-	adv_instance = hci_find_adv_instance(hdev, instance);
-	if (!adv_instance)
-		return 0;
-
-	/* TODO: Take into account the "appearance" and "local-name" flags here.
-	 * These are currently being ignored as they are not supported.
-	 */
-	return adv_instance->scan_rsp_len;
-}
-
-static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
-{
-	struct adv_info *adv_instance = NULL;
-	u8 ad_len = 0, flags = 0;
-	u32 instance_flags;
-
-	/* Return 0 when the current instance identifier is invalid. */
-	if (instance) {
-		adv_instance = hci_find_adv_instance(hdev, instance);
-		if (!adv_instance)
-			return 0;
-	}
-
-	instance_flags = get_adv_instance_flags(hdev, instance);
-
-	/* The Add Advertising command allows userspace to set both the general
-	 * and limited discoverable flags.
-	 */
-	if (instance_flags & MGMT_ADV_FLAG_DISCOV)
-		flags |= LE_AD_GENERAL;
-
-	if (instance_flags & MGMT_ADV_FLAG_LIMITED_DISCOV)
-		flags |= LE_AD_LIMITED;
-
-	if (flags || (instance_flags & MGMT_ADV_FLAG_MANAGED_FLAGS)) {
-		/* If a discovery flag wasn't provided, simply use the global
-		 * settings.
-		 */
-		if (!flags)
-			flags |= get_adv_discov_flags(hdev);
-
-		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-			flags |= LE_AD_NO_BREDR;
-
-		/* If flags would still be empty, then there is no need to
-		 * include the "Flags" AD field".
-		 */
-		if (flags) {
-			ptr[0] = 0x02;
-			ptr[1] = EIR_FLAGS;
-			ptr[2] = flags;
-
-			ad_len += 3;
-			ptr += 3;
-		}
-	}
-
-	if (adv_instance) {
-		memcpy(ptr, adv_instance->adv_data,
-		       adv_instance->adv_data_len);
-		ad_len += adv_instance->adv_data_len;
-		ptr += adv_instance->adv_data_len;
-	}
-
-	/* Provide Tx Power only if we can provide a valid value for it */
-	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID &&
-	    (instance_flags & MGMT_ADV_FLAG_TX_POWER)) {
-		ptr[0] = 0x02;
-		ptr[1] = EIR_TX_POWER;
-		ptr[2] = (u8)hdev->adv_tx_power;
-
-		ad_len += 3;
-		ptr += 3;
-	}
-
-	return ad_len;
-}
-
-static void update_inst_adv_data(struct hci_request *req, u8 instance)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_adv_data cp;
-	u8 len;
-
-	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
-		return;
-
-	memset(&cp, 0, sizeof(cp));
-
-	len = create_instance_adv_data(hdev, instance, cp.data);
-
-	/* There's nothing to do if the data hasn't changed */
-	if (hdev->adv_data_len == len &&
-	    memcmp(cp.data, hdev->adv_data, len) == 0)
-		return;
-
-	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
-	hdev->adv_data_len = len;
-
-	cp.length = len;
-
-	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
-}
-
-static void update_adv_data(struct hci_request *req)
-{
-	update_inst_adv_data(req, get_current_adv_instance(req->hdev));
-}
-
-int mgmt_update_adv_data(struct hci_dev *hdev)
-{
-	struct hci_request req;
-
-	hci_req_init(&req, hdev);
-	update_adv_data(&req);
-
-	return hci_req_run(&req, NULL);
-}
-
 static void create_eir(struct hci_dev *hdev, u8 *data)
 {
 	u8 *ptr = data;
@@ -1247,70 +999,6 @@ static void update_class(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
 }
 
-static void disable_advertising(struct hci_request *req)
-{
-	u8 enable = 0x00;
-
-	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
-}
-
-static void enable_advertising(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_adv_param cp;
-	u8 own_addr_type, enable = 0x01;
-	bool connectable;
-	u8 instance;
-	u32 flags;
-
-	if (hci_conn_num(hdev, LE_LINK) > 0)
-		return;
-
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-		disable_advertising(req);
-
-	/* Clear the HCI_LE_ADV bit temporarily so that the
-	 * hci_update_random_address knows that it's safe to go ahead
-	 * and write a new random address. The flag will be set back on
-	 * as soon as the SET_ADV_ENABLE HCI command completes.
-	 */
-	hci_dev_clear_flag(hdev, HCI_LE_ADV);
-
-	instance = get_current_adv_instance(hdev);
-	flags = get_adv_instance_flags(hdev, instance);
-
-	/* If the "connectable" instance flag was not set, then choose between
-	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
-	 */
-	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
-		      get_connectable(hdev);
-
-	/* Set require_privacy to true only when non-connectable
-	 * advertising is used. In that case it is fine to use a
-	 * non-resolvable private address.
-	 */
-	if (hci_update_random_address(req, !connectable, &own_addr_type) < 0)
-		return;
-
-	memset(&cp, 0, sizeof(cp));
-	cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
-	cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
-
-	if (connectable)
-		cp.type = LE_ADV_IND;
-	else if (get_cur_adv_instance_scan_rsp_len(hdev))
-		cp.type = LE_ADV_SCAN_IND;
-	else
-		cp.type = LE_ADV_NONCONN_IND;
-
-	cp.own_address_type = own_addr_type;
-	cp.channel_map = hdev->le_adv_channel_map;
-
-	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
-
-	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
-}
-
 static void service_cache_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
@@ -1346,10 +1034,11 @@ static void rpa_expired(struct work_struct *work)
 		return;
 
 	/* The generation of a new RPA and programming it into the
-	 * controller happens in the enable_advertising() function.
+	 * controller happens in the hci_req_enable_advertising()
+	 * function.
 	 */
 	hci_req_init(&req, hdev);
-	enable_advertising(&req);
+	__hci_req_enable_advertising(&req);
 	hci_req_run(&req, NULL);
 }
 
@@ -1417,8 +1106,7 @@ static void clean_up_hci_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 	}
 }
 
-static void advertising_added(struct sock *sk, struct hci_dev *hdev,
-			      u8 instance)
+void mgmt_advertising_added(struct sock *sk, struct hci_dev *hdev, u8 instance)
 {
 	struct mgmt_ev_advertising_added ev;
 
@@ -1427,8 +1115,8 @@ static void advertising_added(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_ADVERTISING_ADDED, hdev, &ev, sizeof(ev), sk);
 }
 
-static void advertising_removed(struct sock *sk, struct hci_dev *hdev,
-				u8 instance)
+void mgmt_advertising_removed(struct sock *sk, struct hci_dev *hdev,
+			      u8 instance)
 {
 	struct mgmt_ev_advertising_removed ev;
 
@@ -1437,65 +1125,6 @@ static void advertising_removed(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_ADVERTISING_REMOVED, hdev, &ev, sizeof(ev), sk);
 }
 
-static int schedule_adv_instance(struct hci_request *req, u8 instance,
-				 bool force) {
-	struct hci_dev *hdev = req->hdev;
-	struct adv_info *adv_instance = NULL;
-	u16 timeout;
-
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
-		return -EPERM;
-
-	if (hdev->adv_instance_timeout)
-		return -EBUSY;
-
-	adv_instance = hci_find_adv_instance(hdev, instance);
-	if (!adv_instance)
-		return -ENOENT;
-
-	/* A zero timeout means unlimited advertising. As long as there is
-	 * only one instance, duration should be ignored. We still set a timeout
-	 * in case further instances are being added later on.
-	 *
-	 * If the remaining lifetime of the instance is more than the duration
-	 * then the timeout corresponds to the duration, otherwise it will be
-	 * reduced to the remaining instance lifetime.
-	 */
-	if (adv_instance->timeout == 0 ||
-	    adv_instance->duration <= adv_instance->remaining_time)
-		timeout = adv_instance->duration;
-	else
-		timeout = adv_instance->remaining_time;
-
-	/* The remaining time is being reduced unless the instance is being
-	 * advertised without time limit.
-	 */
-	if (adv_instance->timeout)
-		adv_instance->remaining_time =
-				adv_instance->remaining_time - timeout;
-
-	hdev->adv_instance_timeout = timeout;
-	queue_delayed_work(hdev->workqueue,
-			   &hdev->adv_instance_expire,
-			   msecs_to_jiffies(timeout * 1000));
-
-	/* If we're just re-scheduling the same instance again then do not
-	 * execute any HCI commands. This happens when a single instance is
-	 * being advertised.
-	 */
-	if (!force && hdev->cur_adv_instance == instance &&
-	    hci_dev_test_flag(hdev, HCI_LE_ADV))
-		return 0;
-
-	hdev->cur_adv_instance = instance;
-	update_adv_data(req);
-	update_scan_rsp_data(req);
-	enable_advertising(req);
-
-	return 0;
-}
-
 static void cancel_adv_timeout(struct hci_dev *hdev)
 {
 	if (hdev->adv_instance_timeout) {
@@ -1504,76 +1133,6 @@ static void cancel_adv_timeout(struct hci_dev *hdev)
 	}
 }
 
-/* For a single instance:
- * - force == true: The instance will be removed even when its remaining
- *   lifetime is not zero.
- * - force == false: the instance will be deactivated but kept stored unless
- *   the remaining lifetime is zero.
- *
- * For instance == 0x00:
- * - force == true: All instances will be removed regardless of their timeout
- *   setting.
- * - force == false: Only instances that have a timeout will be removed.
- */
-static void clear_adv_instance(struct hci_dev *hdev, struct hci_request *req,
-			       u8 instance, bool force)
-{
-	struct adv_info *adv_instance, *n, *next_instance = NULL;
-	int err;
-	u8 rem_inst;
-
-	/* Cancel any timeout concerning the removed instance(s). */
-	if (!instance || hdev->cur_adv_instance == instance)
-		cancel_adv_timeout(hdev);
-
-	/* Get the next instance to advertise BEFORE we remove
-	 * the current one. This can be the same instance again
-	 * if there is only one instance.
-	 */
-	if (instance && hdev->cur_adv_instance == instance)
-		next_instance = hci_get_next_instance(hdev, instance);
-
-	if (instance == 0x00) {
-		list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances,
-					 list) {
-			if (!(force || adv_instance->timeout))
-				continue;
-
-			rem_inst = adv_instance->instance;
-			err = hci_remove_adv_instance(hdev, rem_inst);
-			if (!err)
-				advertising_removed(NULL, hdev, rem_inst);
-		}
-		hdev->cur_adv_instance = 0x00;
-	} else {
-		adv_instance = hci_find_adv_instance(hdev, instance);
-
-		if (force || (adv_instance && adv_instance->timeout &&
-			      !adv_instance->remaining_time)) {
-			/* Don't advertise a removed instance. */
-			if (next_instance &&
-			    next_instance->instance == instance)
-				next_instance = NULL;
-
-			err = hci_remove_adv_instance(hdev, instance);
-			if (!err)
-				advertising_removed(NULL, hdev, instance);
-		}
-	}
-
-	if (list_empty(&hdev->adv_instances)) {
-		hdev->cur_adv_instance = 0x00;
-		hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
-	}
-
-	if (!req || !hdev_is_powered(hdev) ||
-	    hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		return;
-
-	if (next_instance)
-		schedule_adv_instance(req, next_instance->instance, false);
-}
-
 static int clean_up_hci_state(struct hci_dev *hdev)
 {
 	struct hci_request req;
@@ -1589,10 +1148,10 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	}
 
-	clear_adv_instance(hdev, NULL, 0x00, false);
+	hci_req_clear_adv_instance(hdev, NULL, 0x00, false);
 
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-		disable_advertising(&req);
+		__hci_req_disable_advertising(&req);
 
 	discov_stopped = hci_req_stop_discovery(&req);
 
@@ -1975,7 +1534,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
 
 update_ad:
-	update_adv_data(&req);
+	__hci_req_update_adv_data(&req, HCI_ADV_CURRENT);
 
 	err = hci_req_run(&req, set_discoverable_complete);
 	if (err < 0)
@@ -2060,7 +1619,7 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status,
 		new_settings(hdev, cmd->sk);
 		hci_req_update_scan(hdev);
 		if (discov_changed)
-			mgmt_update_adv_data(hdev);
+			hci_req_update_adv_data(hdev, HCI_ADV_CURRENT);
 		hci_update_background_scan(hdev);
 	}
 
@@ -2151,7 +1710,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 			hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 			hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
 		}
-		update_adv_data(&req);
+		__hci_req_update_adv_data(&req, HCI_ADV_CURRENT);
 	} else if (cp->val != test_bit(HCI_PSCAN, &hdev->flags)) {
 		if (cp->val) {
 			scan = SCAN_PAGE;
@@ -2181,7 +1740,7 @@ no_scan_update:
 	/* Update the advertising parameters if necessary */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
 	    hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
-		enable_advertising(&req);
+		__hci_req_enable_advertising(&req);
 
 	err = hci_req_run(&req, set_connectable_complete);
 	if (err < 0) {
@@ -2466,8 +2025,8 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 		struct hci_request req;
 
 		hci_req_init(&req, hdev);
-		update_adv_data(&req);
-		update_scan_rsp_data(&req);
+		__hci_req_update_adv_data(&req, HCI_ADV_CURRENT);
+		__hci_req_update_scan_rsp_data(&req, HCI_ADV_CURRENT);
 		hci_req_run(&req, NULL);
 		hci_update_background_scan(hdev);
 	}
@@ -2518,7 +2077,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	enabled = lmp_host_le_capable(hdev);
 
 	if (!val)
-		clear_adv_instance(hdev, NULL, 0x00, true);
+		hci_req_clear_adv_instance(hdev, NULL, 0x00, true);
 
 	if (!hdev_is_powered(hdev) || val == enabled) {
 		bool changed = false;
@@ -2565,7 +2124,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		hci_cp.simul = 0x00;
 	} else {
 		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-			disable_advertising(&req);
+			__hci_req_disable_advertising(&req);
 	}
 
 	hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
@@ -3856,7 +3415,7 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 	 * no need to udpate the advertising data here.
 	 */
 	if (lmp_le_capable(hdev))
-		update_scan_rsp_data(&req);
+		__hci_req_update_scan_rsp_data(&req, HCI_ADV_CURRENT);
 
 	err = hci_req_run(&req, set_name_complete);
 	if (err < 0)
@@ -4600,7 +4159,7 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
 
 	hci_req_init(&req, hdev);
 
-	err = schedule_adv_instance(&req, instance, true);
+	err = __hci_req_schedule_adv_instance(&req, instance, true);
 
 	if (!err)
 		err = hci_req_run(&req, enable_advertising_instance);
@@ -4697,11 +4256,11 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * We cannot use update_[adv|scan_rsp]_data() here as the
 		 * HCI_ADVERTISING flag is not yet set.
 		 */
-		update_inst_adv_data(&req, 0x00);
-		update_inst_scan_rsp_data(&req, 0x00);
-		enable_advertising(&req);
+		__hci_req_update_adv_data(&req, 0x00);
+		__hci_req_update_scan_rsp_data(&req, 0x00);
+		__hci_req_enable_advertising(&req);
 	} else {
-		disable_advertising(&req);
+		__hci_req_disable_advertising(&req);
 	}
 
 	err = hci_req_run(&req, set_advertising_complete);
@@ -5033,8 +4592,8 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto unlock;
 	}
 
-	/* We need to flip the bit already here so that update_adv_data
-	 * generates the correct flags.
+	/* We need to flip the bit already here so that
+	 * hci_req_update_adv_data generates the correct flags.
 	 */
 	hci_dev_set_flag(hdev, HCI_BREDR_ENABLED);
 
@@ -5046,7 +4605,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	/* Since only the advertising data flags will change, there
 	 * is no need to update the scan response data.
 	 */
-	update_adv_data(&req);
+	__hci_req_update_adv_data(&req, HCI_ADV_CURRENT);
 
 	err = hci_req_run(&req, set_bredr_complete);
 	if (err < 0)
@@ -6583,7 +6142,7 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
 						  rand, sizeof(rand));
 		}
 
-		flags = get_adv_discov_flags(hdev);
+		flags = mgmt_get_adv_discov_flags(hdev);
 
 		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 			flags |= LE_AD_NO_BREDR;
@@ -6772,7 +6331,7 @@ static void add_advertising_complete(struct hci_dev *hdev, u8 status,
 			cancel_adv_timeout(hdev);
 
 		hci_remove_adv_instance(hdev, instance);
-		advertising_removed(cmd ? cmd->sk : NULL, hdev, instance);
+		mgmt_advertising_removed(cmd ? cmd->sk : NULL, hdev, instance);
 	}
 
 	if (!cmd)
@@ -6794,31 +6353,6 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-void mgmt_adv_timeout_expired(struct hci_dev *hdev)
-{
-	u8 instance;
-	struct hci_request req;
-
-	hdev->adv_instance_timeout = 0;
-
-	instance = get_current_adv_instance(hdev);
-	if (instance == 0x00)
-		return;
-
-	hci_dev_lock(hdev);
-	hci_req_init(&req, hdev);
-
-	clear_adv_instance(hdev, &req, instance, false);
-
-	if (list_empty(&hdev->adv_instances))
-		disable_advertising(&req);
-
-	if (!skb_queue_empty(&req.cmd_q))
-		hci_req_run(&req, NULL);
-
-	hci_dev_unlock(hdev);
-}
-
 static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 data_len)
 {
@@ -6897,7 +6431,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	 * actually added.
 	 */
 	if (hdev->adv_instance_cnt > prev_instance_cnt)
-		advertising_added(sk, hdev, cp->instance);
+		mgmt_advertising_added(sk, hdev, cp->instance);
 
 	hci_dev_set_flag(hdev, HCI_ADVERTISING_INSTANCE);
 
@@ -6944,7 +6478,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 
 	hci_req_init(&req, hdev);
 
-	err = schedule_adv_instance(&req, schedule_instance, true);
+	err = __hci_req_schedule_adv_instance(&req, schedule_instance, true);
 
 	if (!err)
 		err = hci_req_run(&req, add_advertising_complete);
@@ -7024,10 +6558,10 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 
 	hci_req_init(&req, hdev);
 
-	clear_adv_instance(hdev, &req, cp->instance, true);
+	hci_req_clear_adv_instance(hdev, &req, cp->instance, true);
 
 	if (list_empty(&hdev->adv_instances))
-		disable_advertising(&req);
+		__hci_req_disable_advertising(&req);
 
 	/* If no HCI commands have been collected so far or the HCI_ADVERTISING
 	 * flag is set or the device isn't powered then we have no HCI
@@ -7367,8 +6901,8 @@ static int powered_update_hci(struct hci_dev *hdev)
 		if (hci_dev_test_flag(hdev, HCI_LE_ENABLED) &&
 		    (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
 		     !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))) {
-			update_adv_data(&req);
-			update_scan_rsp_data(&req);
+			__hci_req_update_adv_data(&req, HCI_ADV_CURRENT);
+			__hci_req_update_scan_rsp_data(&req, HCI_ADV_CURRENT);
 		}
 
 		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
@@ -7380,11 +6914,12 @@ static int powered_update_hci(struct hci_dev *hdev)
 		}
 
 		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
-			enable_advertising(&req);
+			__hci_req_enable_advertising(&req);
 		else if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
 			 hdev->cur_adv_instance)
-			schedule_adv_instance(&req, hdev->cur_adv_instance,
-					      true);
+			__hci_req_schedule_adv_instance(&req,
+							hdev->cur_adv_instance,
+							true);
 	}
 
 	link_sec = hci_dev_test_flag(hdev, HCI_LINK_SECURITY);
@@ -7505,7 +7040,7 @@ void mgmt_discoverable_timeout(struct hci_dev *hdev)
 	 * only update AD if advertising was enabled using Set Advertising.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		update_adv_data(&req);
+		__hci_req_update_adv_data(&req, HCI_ADV_CURRENT);
 
 	hci_req_run(&req, NULL);
 
@@ -8352,35 +7887,6 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 	mgmt_event(MGMT_EV_DISCOVERING, hdev, &ev, sizeof(ev), NULL);
 }
 
-static void adv_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
-{
-	BT_DBG("%s status %u", hdev->name, status);
-}
-
-void mgmt_reenable_advertising(struct hci_dev *hdev)
-{
-	struct hci_request req;
-	u8 instance;
-
-	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
-	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
-		return;
-
-	instance = get_current_adv_instance(hdev);
-
-	hci_req_init(&req, hdev);
-
-	if (instance) {
-		schedule_adv_instance(&req, instance, true);
-	} else {
-		update_adv_data(&req);
-		update_scan_rsp_data(&req);
-		enable_advertising(&req);
-	}
-
-	hci_req_run(&req, adv_enable_complete);
-}
-
 static struct hci_mgmt_chan chan = {
 	.channel	= HCI_CHANNEL_CONTROL,
 	.handler_count	= ARRAY_SIZE(mgmt_handlers),
-- 
2.5.0

