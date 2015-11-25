Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Perform HCI update for power on synchronously
Date: Wed, 25 Nov 2015 16:15:44 +0200
Message-Id: <1448460944-17002-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1448460944-17002-1-git-send-email-johan.hedberg@gmail.com>
References: <1448460944-17002-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The request to update HCI during power on is always coming either from
hdev->req_workqueue or through an ioctl, so it's safe to use
hci_req_sync for it. This way we also eliminate potential races with
incoming mgmt commands or other actions while powering on.

Part of this refactoring is the splitting of mgmt_powered() into
mgmt_power_on() and __mgmt_power_off() functions. The main reason is
the different requirements as far as hdev locking is concerned, as
highlighted with the __ prefix of the power off API.

Since the power on in the case of clearing the AUTO_OFF flag cannot be
done synchronously in the set_powered mgmt handler, the hci_power_on
work callback is extended to cover this (which also simplifies the
set_powered helper a lot).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   3 +-
 net/bluetooth/hci_core.c         |  21 ++++--
 net/bluetooth/hci_request.c      | 100 ++++++++++++++++++++++++++++
 net/bluetooth/hci_request.h      |   2 +
 net/bluetooth/mgmt.c             | 136 +++------------------------------------
 5 files changed, 128 insertions(+), 134 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 319bf020cea6..c95e0326c41a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1435,7 +1435,8 @@ int mgmt_new_settings(struct hci_dev *hdev);
 void mgmt_index_added(struct hci_dev *hdev);
 void mgmt_index_removed(struct hci_dev *hdev);
 void mgmt_set_powered_failed(struct hci_dev *hdev, int err);
-int mgmt_powered(struct hci_dev *hdev, u8 powered);
+void mgmt_power_on(struct hci_dev *hdev, int err);
+void __mgmt_power_off(struct hci_dev *hdev);
 void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent);
 void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 484c75f3332c..eac3f6fa1272 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1399,10 +1399,10 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		    !hci_dev_test_flag(hdev, HCI_CONFIG) &&
 		    !hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
 		    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+		    hci_dev_test_flag(hdev, HCI_MGMT) &&
 		    hdev->dev_type == HCI_BREDR) {
-			hci_dev_lock(hdev);
-			mgmt_powered(hdev, 1);
-			hci_dev_unlock(hdev);
+			ret = __hci_req_hci_power_on(hdev);
+			mgmt_power_on(hdev, ret);
 		}
 	} else {
 		/* Init failed, cleanup */
@@ -1559,8 +1559,9 @@ int hci_dev_do_close(struct hci_dev *hdev)
 
 	auto_off = hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF);
 
-	if (!auto_off && hdev->dev_type == HCI_BREDR)
-		mgmt_powered(hdev, 0);
+	if (!auto_off && hdev->dev_type == HCI_BREDR &&
+	    hci_dev_test_flag(hdev, HCI_MGMT))
+		__mgmt_power_off(hdev);
 
 	hci_inquiry_cache_flush(hdev);
 	hci_pend_le_actions_clear(hdev);
@@ -2013,6 +2014,16 @@ static void hci_power_on(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
+	if (test_bit(HCI_UP, &hdev->flags) &&
+	    hci_dev_test_flag(hdev, HCI_MGMT) &&
+	    hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF)) {
+		hci_req_sync_lock(hdev);
+		err = __hci_req_hci_power_on(hdev);
+		hci_req_sync_unlock(hdev);
+		mgmt_power_on(hdev, err);
+		return;
+	}
+
 	err = hci_dev_do_open(hdev);
 	if (err < 0) {
 		hci_dev_lock(hdev);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 0abd83ddd4fb..7cc24f1448bd 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2181,6 +2181,106 @@ static void discov_off(struct work_struct *work)
 	mgmt_new_settings(hdev);
 }
 
+static int powered_update_hci(struct hci_request *req, unsigned long opt)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct adv_info *adv_instance;
+	u8 link_sec;
+
+	hci_dev_lock(hdev);
+
+	if (hci_dev_test_flag(hdev, HCI_SSP_ENABLED) &&
+	    !lmp_host_ssp_capable(hdev)) {
+		u8 mode = 0x01;
+
+		hci_req_add(req, HCI_OP_WRITE_SSP_MODE, sizeof(mode), &mode);
+
+		if (bredr_sc_enabled(hdev) && !lmp_host_sc_capable(hdev)) {
+			u8 support = 0x01;
+
+			hci_req_add(req, HCI_OP_WRITE_SC_SUPPORT,
+				    sizeof(support), &support);
+		}
+	}
+
+	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED) &&
+	    lmp_bredr_capable(hdev)) {
+		struct hci_cp_write_le_host_supported cp;
+
+		cp.le = 0x01;
+		cp.simul = 0x00;
+
+		/* Check first if we already have the right
+		 * host state (host features set)
+		 */
+		if (cp.le != lmp_host_le_capable(hdev) ||
+		    cp.simul != lmp_host_le_br_capable(hdev))
+			hci_req_add(req, HCI_OP_WRITE_LE_HOST_SUPPORTED,
+				    sizeof(cp), &cp);
+	}
+
+	if (lmp_le_capable(hdev)) {
+		/* Make sure the controller has a good default for
+		 * advertising data. This also applies to the case
+		 * where BR/EDR was toggled during the AUTO_OFF phase.
+		 */
+		if (hci_dev_test_flag(hdev, HCI_LE_ENABLED) &&
+		    (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+		     !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))) {
+			__hci_req_update_adv_data(req, HCI_ADV_CURRENT);
+			__hci_req_update_scan_rsp_data(req, HCI_ADV_CURRENT);
+		}
+
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
+		    hdev->cur_adv_instance == 0x00 &&
+		    !list_empty(&hdev->adv_instances)) {
+			adv_instance = list_first_entry(&hdev->adv_instances,
+							struct adv_info, list);
+			hdev->cur_adv_instance = adv_instance->instance;
+		}
+
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
+			__hci_req_enable_advertising(req);
+		else if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
+			 hdev->cur_adv_instance)
+			__hci_req_schedule_adv_instance(req,
+							hdev->cur_adv_instance,
+							true);
+	}
+
+	link_sec = hci_dev_test_flag(hdev, HCI_LINK_SECURITY);
+	if (link_sec != test_bit(HCI_AUTH, &hdev->flags))
+		hci_req_add(req, HCI_OP_WRITE_AUTH_ENABLE,
+			    sizeof(link_sec), &link_sec);
+
+	if (lmp_bredr_capable(hdev)) {
+		if (hci_dev_test_flag(hdev, HCI_FAST_CONNECTABLE))
+			__hci_req_write_fast_connectable(req, true);
+		else
+			__hci_req_write_fast_connectable(req, false);
+		__hci_req_update_scan(req);
+		__hci_req_update_class(req);
+		__hci_req_update_name(req);
+		__hci_req_update_eir(req);
+	}
+
+	hci_dev_unlock(hdev);
+	return 0;
+}
+
+int __hci_req_hci_power_on(struct hci_dev *hdev)
+{
+	/* Register the available SMP channels (BR/EDR and LE) only when
+	 * successfully powering on the controller. This late
+	 * registration is required so that LE SMP can clearly decide if
+	 * the public address or static address is used.
+	 */
+	smp_register(hdev);
+
+	return __hci_req_sync(hdev, powered_update_hci, 0, HCI_CMD_TIMEOUT,
+			      NULL);
+}
+
 void hci_request_setup(struct hci_dev *hdev)
 {
 	INIT_WORK(&hdev->discov_update, discov_update);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index d3dd24deca74..a24d3b55094c 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -55,6 +55,8 @@ void hci_req_sync_cancel(struct hci_dev *hdev, int err);
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				const void *param);
 
+int __hci_req_hci_power_on(struct hci_dev *hdev);
+
 void __hci_req_write_fast_connectable(struct hci_request *req, bool enable);
 void __hci_req_update_name(struct hci_request *req);
 void __hci_req_update_eir(struct hci_request *req);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0a7e6f4de383..468402ad933c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -961,17 +961,6 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF)) {
-		cancel_delayed_work(&hdev->power_off);
-
-		if (cp->val) {
-			mgmt_pending_add(sk, MGMT_OP_SET_POWERED, hdev,
-					 data, len);
-			err = mgmt_powered(hdev, 1);
-			goto failed;
-		}
-	}
-
 	if (!!cp->val == hdev_is_powered(hdev)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_POWERED, hdev);
 		goto failed;
@@ -6434,139 +6423,33 @@ static void restart_le_actions(struct hci_dev *hdev)
 	}
 }
 
-static void powered_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+void mgmt_power_on(struct hci_dev *hdev, int err)
 {
 	struct cmd_lookup match = { NULL, hdev };
 
-	BT_DBG("status 0x%02x", status);
+	BT_DBG("err %d", err);
 
-	if (!status) {
+	hci_dev_lock(hdev);
+
+	if (!err) {
 		restart_le_actions(hdev);
 		hci_update_background_scan(hdev);
 	}
 
-	hci_dev_lock(hdev);
-
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
 	new_settings(hdev, match.sk);
 
-	hci_dev_unlock(hdev);
-
 	if (match.sk)
 		sock_put(match.sk);
-}
 
-static int powered_update_hci(struct hci_dev *hdev)
-{
-	struct hci_request req;
-	struct adv_info *adv_instance;
-	u8 link_sec;
-
-	hci_req_init(&req, hdev);
-
-	if (hci_dev_test_flag(hdev, HCI_SSP_ENABLED) &&
-	    !lmp_host_ssp_capable(hdev)) {
-		u8 mode = 0x01;
-
-		hci_req_add(&req, HCI_OP_WRITE_SSP_MODE, sizeof(mode), &mode);
-
-		if (bredr_sc_enabled(hdev) && !lmp_host_sc_capable(hdev)) {
-			u8 support = 0x01;
-
-			hci_req_add(&req, HCI_OP_WRITE_SC_SUPPORT,
-				    sizeof(support), &support);
-		}
-	}
-
-	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED) &&
-	    lmp_bredr_capable(hdev)) {
-		struct hci_cp_write_le_host_supported cp;
-
-		cp.le = 0x01;
-		cp.simul = 0x00;
-
-		/* Check first if we already have the right
-		 * host state (host features set)
-		 */
-		if (cp.le != lmp_host_le_capable(hdev) ||
-		    cp.simul != lmp_host_le_br_capable(hdev))
-			hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED,
-				    sizeof(cp), &cp);
-	}
-
-	if (lmp_le_capable(hdev)) {
-		/* Make sure the controller has a good default for
-		 * advertising data. This also applies to the case
-		 * where BR/EDR was toggled during the AUTO_OFF phase.
-		 */
-		if (hci_dev_test_flag(hdev, HCI_LE_ENABLED) &&
-		    (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-		     !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))) {
-			__hci_req_update_adv_data(&req, HCI_ADV_CURRENT);
-			__hci_req_update_scan_rsp_data(&req, HCI_ADV_CURRENT);
-		}
-
-		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
-		    hdev->cur_adv_instance == 0x00 &&
-		    !list_empty(&hdev->adv_instances)) {
-			adv_instance = list_first_entry(&hdev->adv_instances,
-							struct adv_info, list);
-			hdev->cur_adv_instance = adv_instance->instance;
-		}
-
-		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
-			__hci_req_enable_advertising(&req);
-		else if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
-			 hdev->cur_adv_instance)
-			__hci_req_schedule_adv_instance(&req,
-							hdev->cur_adv_instance,
-							true);
-	}
-
-	link_sec = hci_dev_test_flag(hdev, HCI_LINK_SECURITY);
-	if (link_sec != test_bit(HCI_AUTH, &hdev->flags))
-		hci_req_add(&req, HCI_OP_WRITE_AUTH_ENABLE,
-			    sizeof(link_sec), &link_sec);
-
-	if (lmp_bredr_capable(hdev)) {
-		if (hci_dev_test_flag(hdev, HCI_FAST_CONNECTABLE))
-			__hci_req_write_fast_connectable(&req, true);
-		else
-			__hci_req_write_fast_connectable(&req, false);
-		__hci_req_update_scan(&req);
-		__hci_req_update_class(&req);
-		__hci_req_update_name(&req);
-		__hci_req_update_eir(&req);
-	}
-
-	return hci_req_run(&req, powered_complete);
+	hci_dev_unlock(hdev);
 }
 
-int mgmt_powered(struct hci_dev *hdev, u8 powered)
+void __mgmt_power_off(struct hci_dev *hdev)
 {
 	struct cmd_lookup match = { NULL, hdev };
 	u8 status, zero_cod[] = { 0, 0, 0 };
-	int err;
-
-	if (!hci_dev_test_flag(hdev, HCI_MGMT))
-		return 0;
-
-	if (powered) {
-		/* Register the available SMP channels (BR/EDR and LE) only
-		 * when successfully powering on the controller. This late
-		 * registration is required so that LE SMP can clearly
-		 * decide if the public address or static address is used.
-		 */
-		smp_register(hdev);
-
-		if (powered_update_hci(hdev) == 0)
-			return 0;
-
-		mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp,
-				     &match);
-		goto new_settings;
-	}
 
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
@@ -6588,13 +6471,10 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 		mgmt_generic_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
 				   zero_cod, sizeof(zero_cod), NULL);
 
-new_settings:
-	err = new_settings(hdev, match.sk);
+	new_settings(hdev, match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
-
-	return err;
 }
 
 void mgmt_set_powered_failed(struct hci_dev *hdev, int err)
-- 
2.5.0

