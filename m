Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [RFC 4/9] Bluetooth: Implement disable and removal of adv instance
Date: Mon,  4 Dec 2017 13:37:48 +0530
Message-Id: <1512374873-1956-5-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements hci_req_clear_ext_adv_instance() whose semantics
is same as hci_req_clear_adv_instance().

Also handles disable case of set scan enable complete.

Adv sets can be removed from the controller using two commands,
clear - which removes all the sets, remove - which removes only
the given set.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h |   7 +++
 net/bluetooth/hci_event.c   |  33 +++++++++++
 net/bluetooth/hci_request.c | 141 ++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.h |   3 +
 net/bluetooth/mgmt.c        |  17 ++++--
 5 files changed, 197 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 997995d..65d2124 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1611,6 +1611,13 @@ struct hci_cp_le_set_ext_scan_rsp_data {
 
 #define LE_SET_ADV_DATA_NO_FRAG		0x01
 
+#define HCI_OP_LE_REMOVE_ADV_SET	0x203c
+struct hci_cp_le_remove_adv_set {
+	__u8  handle;
+} __packed;
+
+#define HCI_OP_LE_CLEAR_ADV_SETS	0x203d
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 724c668..64873dd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1121,8 +1121,41 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
 
 			adv_set++;
 		}
+	} else {
+		/* If all instances are disabled */
+		if (!cp->num_of_sets) {
+			hci_dev_clear_flag(hdev, HCI_LE_ADV);
+
+			list_for_each_entry(adv_instance, &hdev->adv_instances,
+					    list)
+				clear_bit(ADV_INST_ENABLED,
+					  &adv_instance->state);
+
+			goto unlock;
+		}
+
+		for (i = 0; i < cp->num_of_sets; i++) {
+			adv_instance = hci_find_adv_instance(hdev,
+							     adv_set->handle);
+			if (adv_instance)
+				clear_bit(ADV_INST_ENABLED,
+                                          &adv_instance->state);
+
+			adv_set++;
+		}
+
+		list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
+			/* Dont clear HCI_LE_ADV if atleast one instance is
+			 * enabled
+			 */
+			if (test_bit(ADV_INST_ENABLED, &adv_instance->state))
+				goto unlock;
+		}
+
+		hci_dev_clear_flag(hdev, HCI_LE_ADV);
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 9c45cbf..ca235eb 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1423,6 +1423,55 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+void __hci_req_remove_ext_adv_set(struct hci_request *req, u8 instance)
+{
+	struct hci_cp_le_remove_adv_set cp;
+
+	memset(&cp, 0, sizeof(cp));
+
+	cp.handle = instance;
+
+	hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, sizeof(cp), &cp);
+}
+
+void __hci_req_clear_ext_adv_sets(struct hci_request *req)
+{
+	hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, 0, NULL);
+}
+
+void __hci_req_stop_ext_adv(struct hci_request *req, u8 instance,
+			    bool all_instances)
+{
+	if (all_instances) {
+		struct hci_cp_le_set_ext_adv_enable cp;
+
+		cp.enable = 0x00;
+		/* Disable all adv sets */
+		cp.num_of_sets = 0x00;
+
+		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_ENABLE, sizeof(cp), &cp);
+	} else {
+		struct hci_cp_le_set_ext_adv_enable *cp;
+		struct hci_cp_ext_adv_set *cp_adv_set;
+		u8 data[sizeof(*cp) + sizeof(*cp_adv_set)];
+
+		cp = (void *) data;
+		cp_adv_set = (void *) cp->data;
+
+		memset(cp, 0, sizeof(*cp));
+
+		cp->enable = 0x00;
+		cp->num_of_sets = 0x01;
+
+		memset(cp_adv_set, 0, sizeof(*cp_adv_set));
+
+		cp_adv_set->handle = instance;
+
+		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_ENABLE, sizeof(data),
+			    data);
+	}
+}
+
 static void __hci_req_setup_ext_adv_instance(struct hci_request *req,
 					     u8 instance)
 {
@@ -1554,6 +1603,10 @@ int __hci_req_start_ext_adv(struct hci_request *req, u8 instance,
 		if (list_empty(&hdev->adv_instances))
 			return -EPERM;
 
+		/* If atleast one adv is enabled then disable all */
+		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
+			__hci_req_stop_ext_adv(req, 0, true);
+
 		list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
 			/* If current instance doesn't need to be changed */
 			if (check_flag && !(adv_instance->flags & flags))
@@ -1565,6 +1618,27 @@ int __hci_req_start_ext_adv(struct hci_request *req, u8 instance,
 
 		__hci_req_enable_ext_advertising(req, 0, true);
 	} else {
+		if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
+			/* If instance 0 is going to be enabled then disable
+			 * all other instances. This is to be aligned with
+			 * the current design and and is not actually required
+			 * in case of extended adv where in all the instances
+			 * including 0 can be enabled at the same time
+			 */
+			if (!instance)
+				__hci_req_stop_ext_adv(req, 0, true);
+			else {
+				adv_instance = hci_find_adv_instance(hdev,
+								     instance);
+				if (!adv_instance)
+					return 0;
+
+				if (test_bit(ADV_INST_ENABLED,
+					     &adv_instance->state))
+					__hci_req_stop_ext_adv(req, instance,
+							       false);
+			}
+		}
 		__hci_req_setup_ext_adv_instance(req, instance);
 		__hci_req_enable_ext_advertising(req, instance, false);
 	}
@@ -1649,6 +1723,68 @@ static void cancel_adv_timeout(struct hci_dev *hdev)
  * For instance == 0x00:
  * - force == true: All instances will be removed regardless of their timeout
  *   setting.
+ * - force == false: All the instances will be disabled and only instances that
+ *   have a timeout will be removed. Instance state will be set to IDLE.
+ */
+static void hci_req_clear_ext_adv_instance(struct hci_dev *hdev,
+					   struct hci_request *req,
+					   struct sock *sk, u8 instance,
+					   bool force)
+{
+	struct adv_info *adv_instance, *n;
+	int err;
+	u8 rem_inst;
+
+	if (instance == 0x00) {
+		/* Disable and remove all instances from the controller */
+		if (req) {
+			__hci_req_stop_ext_adv(req, 0, true);
+			__hci_req_clear_ext_adv_sets(req);
+		}
+
+		/* Remove the instances which has a timeout */
+		list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances,
+					 list) {
+			if (force || adv_instance->timeout) {
+				rem_inst = adv_instance->instance;
+
+				err = hci_remove_adv_instance(hdev, rem_inst);
+				if (!err)
+					mgmt_advertising_removed(sk, hdev,
+								 rem_inst);
+			} else {
+				/* Set state to idle */
+				adv_instance->state = 0;
+			}
+		}
+	} else {
+		adv_instance = hci_find_adv_instance(hdev, instance);
+		if (!adv_instance)
+			return;
+
+		if (test_bit(ADV_INST_ENABLED, &adv_instance->state) && req)
+			__hci_req_stop_ext_adv(req, instance, false);
+
+		if (force) {
+			if (req)
+				__hci_req_remove_ext_adv_set(req, instance);
+
+			err = hci_remove_adv_instance(hdev, instance);
+			if (!err)
+				mgmt_advertising_removed(sk, hdev, instance);
+		}
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
  * - force == false: Only instances that have a timeout will be removed.
  */
 void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
@@ -1659,6 +1795,11 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
 	int err;
 	u8 rem_inst;
 
+	if (ext_adv_capable(hdev)) {
+		hci_req_clear_ext_adv_instance(hdev, req, sk, instance, force);
+		return;
+	}
+
 	/* Cancel any timeout concerning the removed instance(s). */
 	if (!instance || hdev->cur_adv_instance == instance)
 		cancel_adv_timeout(hdev);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 2f2dfad..936f6c5 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -84,6 +84,9 @@ int __hci_req_start_ext_adv(struct hci_request *req, u8 instance,
                             bool all_instances, bool check_flag, u32 flags);
 void __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance,
 				      bool all_instances);
+void __hci_req_stop_ext_adv(struct hci_request *req, u8 instance,
+			    bool all_instances);
+void __hci_req_clear_ext_adv_sets(struct hci_request *req);
 
 void __hci_req_update_class(struct hci_request *req);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 65e5131..120da46 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1824,8 +1824,14 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		hci_cp.le = val;
 		hci_cp.simul = 0x00;
 	} else {
-		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-			__hci_req_disable_advertising(&req);
+		if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
+			if (ext_adv_capable(hdev)) {
+				__hci_req_stop_ext_adv(&req, 0, true);
+				__hci_req_clear_ext_adv_sets(&req);
+			} else {
+				__hci_req_disable_advertising(&req);
+			}
+		}
 	}
 
 	hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
@@ -4065,7 +4071,10 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 			__hci_req_enable_advertising(&req);
 		}
 	} else {
-		__hci_req_disable_advertising(&req);
+		if (ext_adv_capable(hdev))
+			__hci_req_stop_ext_adv(&req, 0, false);
+		else
+			__hci_req_disable_advertising(&req);
 	}
 
 	err = hci_req_run(&req, set_advertising_complete);
@@ -6415,7 +6424,7 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 
 	hci_req_clear_adv_instance(hdev, sk, &req, cp->instance, true);
 
-	if (list_empty(&hdev->adv_instances))
+	if (list_empty(&hdev->adv_instances) && !ext_adv_capable(hdev))
 		__hci_req_disable_advertising(&req);
 
 	/* If no HCI commands have been collected so far or the HCI_ADVERTISING
-- 
2.7.4

