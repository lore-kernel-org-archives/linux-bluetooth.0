Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Introduce hci_dev_test_and_clear_flag helper macro
Date: Fri, 13 Mar 2015 02:11:05 -0700
Message-Id: <1426237866-8329-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of manually coding test_and_clear_bit on hdev->dev_flags all the
time, use hci_dev_test_and_clear_flag helper macro.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 20 ++++++------
 net/bluetooth/hci_event.c        |  3 +-
 net/bluetooth/hci_request.c      |  2 +-
 net/bluetooth/mgmt.c             | 66 +++++++++++++++++++---------------------
 5 files changed, 44 insertions(+), 48 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cd2682c64a4c..4b7632b15051 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -507,6 +507,7 @@ extern struct mutex hci_cb_list_lock;
 #define hci_dev_change_flag(hdev, nr) change_bit((nr), &(hdev)->dev_flags)
 #define hci_dev_test_flag(hdev, nr)   test_bit((nr), &(hdev)->dev_flags)
 
+#define hci_dev_test_and_clear_flag(hdev, nr)  test_and_clear_bit((nr), &(hdev)->dev_flags)
 #define hci_dev_test_and_change_flag(hdev, nr) test_and_change_bit((nr), &(hdev)->dev_flags)
 
 /* ----- HCI interface to upper protocols ----- */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 01710698e547..85d5222c70ae 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1554,7 +1554,7 @@ int hci_dev_open(__u16 dev)
 	 * particularly important if the setup procedure has not yet
 	 * completed.
 	 */
-	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+	if (hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF))
 		cancel_delayed_work(&hdev->power_off);
 
 	/* After this call it is guaranteed that the setup procedure
@@ -1629,7 +1629,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 	}
 
-	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
+	if (hci_dev_test_and_clear_flag(hdev, HCI_SERVICE_CACHE))
 		cancel_delayed_work(&hdev->service_cache);
 
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
@@ -1647,7 +1647,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 
-	if (!test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
+	if (!hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF)) {
 		if (hdev->dev_type == HCI_BREDR)
 			mgmt_powered(hdev, 0);
 	}
@@ -1728,7 +1728,7 @@ int hci_dev_close(__u16 dev)
 		goto done;
 	}
 
-	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+	if (hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF))
 		cancel_delayed_work(&hdev->power_off);
 
 	err = hci_dev_do_close(hdev);
@@ -1839,16 +1839,16 @@ static void hci_update_scan_state(struct hci_dev *hdev, u8 scan)
 		conn_changed = !test_and_set_bit(HCI_CONNECTABLE,
 						 &hdev->dev_flags);
 	else
-		conn_changed = test_and_clear_bit(HCI_CONNECTABLE,
-						  &hdev->dev_flags);
+		conn_changed = hci_dev_test_and_clear_flag(hdev,
+							   HCI_CONNECTABLE);
 
 	if ((scan & SCAN_INQUIRY)) {
 		discov_changed = !test_and_set_bit(HCI_DISCOVERABLE,
 						   &hdev->dev_flags);
 	} else {
 		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
-		discov_changed = test_and_clear_bit(HCI_DISCOVERABLE,
-						    &hdev->dev_flags);
+		discov_changed = hci_dev_test_and_clear_flag(hdev,
+							     HCI_DISCOVERABLE);
 	}
 
 	if (!hci_dev_test_flag(hdev, HCI_MGMT))
@@ -2128,7 +2128,7 @@ static void hci_power_on(struct work_struct *work)
 				   HCI_AUTO_OFF_TIMEOUT);
 	}
 
-	if (test_and_clear_bit(HCI_SETUP, &hdev->dev_flags)) {
+	if (hci_dev_test_and_clear_flag(hdev, HCI_SETUP)) {
 		/* For unconfigured devices, set the HCI_RAW flag
 		 * so that userspace can easily identify them.
 		 */
@@ -2143,7 +2143,7 @@ static void hci_power_on(struct work_struct *work)
 		 * and no event will be send.
 		 */
 		mgmt_index_added(hdev);
-	} else if (test_and_clear_bit(HCI_CONFIG, &hdev->dev_flags)) {
+	} else if (hci_dev_test_and_clear_flag(hdev, HCI_CONFIG)) {
 		/* When the controller is now configured, then it
 		 * is important to clear the HCI_RAW flag.
 		 */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 808b78cf8ad0..4958b24ae5c7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1226,8 +1226,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		 * been disabled because of active scanning, so
 		 * re-enable it again if necessary.
 		 */
-		if (test_and_clear_bit(HCI_LE_SCAN_INTERRUPTED,
-				       &hdev->dev_flags))
+		if (hci_dev_test_and_clear_flag(hdev, HCI_LE_SCAN_INTERRUPTED))
 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 		else if (!hci_dev_test_flag(hdev, HCI_LE_ADV) &&
 			 hdev->discovery.state == DISCOVERY_FINDING)
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index fd7b2a97740b..e85f9ec9f73a 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -329,7 +329,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 
 		*own_addr_type = ADDR_LE_DEV_RANDOM;
 
-		if (!test_and_clear_bit(HCI_RPA_EXPIRED, &hdev->dev_flags) &&
+		if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
 		    !bacmp(&hdev->random_addr, &hdev->rpa))
 			return 0;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3c579a45cff0..cc5c04728848 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1140,7 +1140,7 @@ static void service_cache_off(struct work_struct *work)
 					    service_cache.work);
 	struct hci_request req;
 
-	if (!test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
+	if (!hci_dev_test_and_clear_flag(hdev, HCI_SERVICE_CACHE))
 		return;
 
 	hci_req_init(&req, hdev);
@@ -1419,7 +1419,7 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
+	if (hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF)) {
 		cancel_delayed_work(&hdev->power_off);
 
 		if (cp->val) {
@@ -1588,8 +1588,7 @@ static void set_discoverable_complete(struct hci_dev *hdev, u8 status,
 					   to);
 		}
 	} else {
-		changed = test_and_clear_bit(HCI_DISCOVERABLE,
-					     &hdev->dev_flags);
+		changed = hci_dev_test_and_clear_flag(hdev, HCI_DISCOVERABLE);
 	}
 
 	send_settings_rsp(cmd->sk, MGMT_OP_SET_DISCOVERABLE, hdev);
@@ -1841,10 +1840,10 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status,
 						 &hdev->dev_flags);
 		discov_changed = false;
 	} else {
-		conn_changed = test_and_clear_bit(HCI_CONNECTABLE,
-						  &hdev->dev_flags);
-		discov_changed = test_and_clear_bit(HCI_DISCOVERABLE,
-						    &hdev->dev_flags);
+		conn_changed = hci_dev_test_and_clear_flag(hdev,
+							   HCI_CONNECTABLE);
+		discov_changed = hci_dev_test_and_clear_flag(hdev,
+							     HCI_DISCOVERABLE);
 	}
 
 	send_settings_rsp(cmd->sk, MGMT_OP_SET_CONNECTABLE, hdev);
@@ -2007,7 +2006,7 @@ static int set_bondable(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (cp->val)
 		changed = !test_and_set_bit(HCI_BONDABLE, &hdev->dev_flags);
 	else
-		changed = test_and_clear_bit(HCI_BONDABLE, &hdev->dev_flags);
+		changed = hci_dev_test_and_clear_flag(hdev, HCI_BONDABLE);
 
 	err = send_settings_rsp(sk, MGMT_OP_SET_BONDABLE, hdev);
 	if (err < 0)
@@ -2120,11 +2119,11 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 			changed = !test_and_set_bit(HCI_SSP_ENABLED,
 						    &hdev->dev_flags);
 		} else {
-			changed = test_and_clear_bit(HCI_SSP_ENABLED,
-						     &hdev->dev_flags);
+			changed = hci_dev_test_and_clear_flag(hdev,
+							      HCI_SSP_ENABLED);
 			if (!changed)
-				changed = test_and_clear_bit(HCI_HS_ENABLED,
-							     &hdev->dev_flags);
+				changed = hci_dev_test_and_clear_flag(hdev,
+								      HCI_HS_ENABLED);
 			else
 				hci_dev_clear_flag(hdev, HCI_HS_ENABLED);
 		}
@@ -2213,7 +2212,7 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 			goto unlock;
 		}
 
-		changed = test_and_clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
+		changed = hci_dev_test_and_clear_flag(hdev, HCI_HS_ENABLED);
 	}
 
 	err = send_settings_rsp(sk, MGMT_OP_SET_HS, hdev);
@@ -2629,7 +2628,7 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_req_init(&req, hdev);
 
-	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags)) {
+	if (hci_dev_test_and_clear_flag(hdev, HCI_SERVICE_CACHE)) {
 		hci_dev_unlock(hdev);
 		cancel_delayed_work_sync(&hdev->service_cache);
 		hci_dev_lock(hdev);
@@ -2718,8 +2717,8 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 		changed = !test_and_set_bit(HCI_KEEP_DEBUG_KEYS,
 					    &hdev->dev_flags);
 	else
-		changed = test_and_clear_bit(HCI_KEEP_DEBUG_KEYS,
-					     &hdev->dev_flags);
+		changed = hci_dev_test_and_clear_flag(hdev,
+						      HCI_KEEP_DEBUG_KEYS);
 
 	if (changed)
 		new_settings(hdev, NULL);
@@ -4471,8 +4470,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 			else
 				hci_dev_clear_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 		} else {
-			changed = test_and_clear_bit(HCI_ADVERTISING,
-						     &hdev->dev_flags);
+			changed = hci_dev_test_and_clear_flag(hdev, HCI_ADVERTISING);
 			hci_dev_clear_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 		}
 
@@ -4949,8 +4947,8 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 			else
 				hci_dev_clear_flag(hdev, HCI_SC_ONLY);
 		} else {
-			changed = test_and_clear_bit(HCI_SC_ENABLED,
-						     &hdev->dev_flags);
+			changed = hci_dev_test_and_clear_flag(hdev,
+							      HCI_SC_ENABLED);
 			hci_dev_clear_flag(hdev, HCI_SC_ONLY);
 		}
 
@@ -5016,15 +5014,15 @@ static int set_debug_keys(struct sock *sk, struct hci_dev *hdev,
 		changed = !test_and_set_bit(HCI_KEEP_DEBUG_KEYS,
 					    &hdev->dev_flags);
 	else
-		changed = test_and_clear_bit(HCI_KEEP_DEBUG_KEYS,
-					     &hdev->dev_flags);
+		changed = hci_dev_test_and_clear_flag(hdev,
+						      HCI_KEEP_DEBUG_KEYS);
 
 	if (cp->val == 0x02)
 		use_changed = !test_and_set_bit(HCI_USE_DEBUG_KEYS,
 						&hdev->dev_flags);
 	else
-		use_changed = test_and_clear_bit(HCI_USE_DEBUG_KEYS,
-						 &hdev->dev_flags);
+		use_changed = hci_dev_test_and_clear_flag(hdev,
+							  HCI_USE_DEBUG_KEYS);
 
 	if (hdev_is_powered(hdev) && use_changed &&
 	    hci_dev_test_flag(hdev, HCI_SSP_ENABLED)) {
@@ -5078,7 +5076,7 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 		memcpy(hdev->irk, cp->irk, sizeof(hdev->irk));
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 	} else {
-		changed = test_and_clear_bit(HCI_PRIVACY, &hdev->dev_flags);
+		changed = hci_dev_test_and_clear_flag(hdev, HCI_PRIVACY);
 		memset(hdev->irk, 0, sizeof(hdev->irk));
 		hci_dev_clear_flag(hdev, HCI_RPA_EXPIRED);
 	}
@@ -6087,8 +6085,7 @@ static int set_external_config(struct sock *sk, struct hci_dev *hdev,
 		changed = !test_and_set_bit(HCI_EXT_CONFIGURED,
 					    &hdev->dev_flags);
 	else
-		changed = test_and_clear_bit(HCI_EXT_CONFIGURED,
-					     &hdev->dev_flags);
+		changed = hci_dev_test_and_clear_flag(hdev, HCI_EXT_CONFIGURED);
 
 	err = send_options_rsp(sk, MGMT_OP_SET_EXTERNAL_CONFIG, hdev);
 	if (err < 0)
@@ -7096,8 +7093,7 @@ void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 		changed = !test_and_set_bit(HCI_LINK_SECURITY,
 					    &hdev->dev_flags);
 	else
-		changed = test_and_clear_bit(HCI_LINK_SECURITY,
-					     &hdev->dev_flags);
+		changed = hci_dev_test_and_clear_flag(hdev, HCI_LINK_SECURITY);
 
 	mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev, settings_rsp,
 			     &match);
@@ -7133,8 +7129,8 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
 
-		if (enable && test_and_clear_bit(HCI_SSP_ENABLED,
-						 &hdev->dev_flags)) {
+		if (enable && hci_dev_test_and_clear_flag(hdev,
+							  HCI_SSP_ENABLED)) {
 			hci_dev_clear_flag(hdev, HCI_HS_ENABLED);
 			new_settings(hdev, NULL);
 		}
@@ -7147,10 +7143,10 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	if (enable) {
 		changed = !test_and_set_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
 	} else {
-		changed = test_and_clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
+		changed = hci_dev_test_and_clear_flag(hdev, HCI_SSP_ENABLED);
 		if (!changed)
-			changed = test_and_clear_bit(HCI_HS_ENABLED,
-						     &hdev->dev_flags);
+			changed = hci_dev_test_and_clear_flag(hdev,
+							      HCI_HS_ENABLED);
 		else
 			hci_dev_clear_flag(hdev, HCI_HS_ENABLED);
 	}
-- 
2.1.0

