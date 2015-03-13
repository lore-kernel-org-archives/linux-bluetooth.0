Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Introduce hci_dev_test_and_set_flag helper macro
Date: Fri, 13 Mar 2015 02:11:06 -0700
Message-Id: <1426237866-8329-7-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of manually coding test_and_set_bit on hdev->dev_flags all the
time, use hci_dev_test_and_set_flag helper macro.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  8 +++----
 net/bluetooth/hci_sock.c         |  2 +-
 net/bluetooth/mgmt.c             | 46 +++++++++++++++++-----------------------
 4 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4b7632b15051..6db1333a114f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -507,6 +507,7 @@ extern struct mutex hci_cb_list_lock;
 #define hci_dev_change_flag(hdev, nr) change_bit((nr), &(hdev)->dev_flags)
 #define hci_dev_test_flag(hdev, nr)   test_bit((nr), &(hdev)->dev_flags)
 
+#define hci_dev_test_and_set_flag(hdev, nr)    test_and_set_bit((nr), &(hdev)->dev_flags)
 #define hci_dev_test_and_clear_flag(hdev, nr)  test_and_clear_bit((nr), &(hdev)->dev_flags)
 #define hci_dev_test_and_change_flag(hdev, nr) test_and_change_bit((nr), &(hdev)->dev_flags)
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 85d5222c70ae..c6ed46c4f45a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1836,15 +1836,15 @@ static void hci_update_scan_state(struct hci_dev *hdev, u8 scan)
 	BT_DBG("%s scan 0x%02x", hdev->name, scan);
 
 	if ((scan & SCAN_PAGE))
-		conn_changed = !test_and_set_bit(HCI_CONNECTABLE,
-						 &hdev->dev_flags);
+		conn_changed = !hci_dev_test_and_set_flag(hdev,
+							  HCI_CONNECTABLE);
 	else
 		conn_changed = hci_dev_test_and_clear_flag(hdev,
 							   HCI_CONNECTABLE);
 
 	if ((scan & SCAN_INQUIRY)) {
-		discov_changed = !test_and_set_bit(HCI_DISCOVERABLE,
-						   &hdev->dev_flags);
+		discov_changed = !hci_dev_test_and_set_flag(hdev,
+							    HCI_DISCOVERABLE);
 	} else {
 		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 		discov_changed = hci_dev_test_and_clear_flag(hdev,
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index ca402a0a6740..b614543b4fe3 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -720,7 +720,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			goto done;
 		}
 
-		if (test_and_set_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+		if (hci_dev_test_and_set_flag(hdev, HCI_USER_CHANNEL)) {
 			err = -EUSERS;
 			hci_dev_put(hdev);
 			goto done;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cc5c04728848..d97719d04be0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1178,7 +1178,7 @@ static void rpa_expired(struct work_struct *work)
 
 static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 {
-	if (test_and_set_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_and_set_flag(hdev, HCI_MGMT))
 		return;
 
 	INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);
@@ -1579,8 +1579,7 @@ static void set_discoverable_complete(struct hci_dev *hdev, u8 status,
 
 	cp = cmd->param;
 	if (cp->val) {
-		changed = !test_and_set_bit(HCI_DISCOVERABLE,
-					    &hdev->dev_flags);
+		changed = !hci_dev_test_and_set_flag(hdev, HCI_DISCOVERABLE);
 
 		if (hdev->discov_timeout > 0) {
 			int to = msecs_to_jiffies(hdev->discov_timeout * 1000);
@@ -1836,8 +1835,8 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status,
 
 	cp = cmd->param;
 	if (cp->val) {
-		conn_changed = !test_and_set_bit(HCI_CONNECTABLE,
-						 &hdev->dev_flags);
+		conn_changed = !hci_dev_test_and_set_flag(hdev,
+							  HCI_CONNECTABLE);
 		discov_changed = false;
 	} else {
 		conn_changed = hci_dev_test_and_clear_flag(hdev,
@@ -2004,7 +2003,7 @@ static int set_bondable(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	if (cp->val)
-		changed = !test_and_set_bit(HCI_BONDABLE, &hdev->dev_flags);
+		changed = !hci_dev_test_and_set_flag(hdev, HCI_BONDABLE);
 	else
 		changed = hci_dev_test_and_clear_flag(hdev, HCI_BONDABLE);
 
@@ -2116,8 +2115,8 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		bool changed;
 
 		if (cp->val) {
-			changed = !test_and_set_bit(HCI_SSP_ENABLED,
-						    &hdev->dev_flags);
+			changed = !hci_dev_test_and_set_flag(hdev,
+							     HCI_SSP_ENABLED);
 		} else {
 			changed = hci_dev_test_and_clear_flag(hdev,
 							      HCI_SSP_ENABLED);
@@ -2204,7 +2203,7 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	}
 
 	if (cp->val) {
-		changed = !test_and_set_bit(HCI_HS_ENABLED, &hdev->dev_flags);
+		changed = !hci_dev_test_and_set_flag(hdev, HCI_HS_ENABLED);
 	} else {
 		if (hdev_is_powered(hdev)) {
 			err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
@@ -2487,7 +2486,7 @@ static bool enable_service_cache(struct hci_dev *hdev)
 	if (!hdev_is_powered(hdev))
 		return false;
 
-	if (!test_and_set_bit(HCI_SERVICE_CACHE, &hdev->dev_flags)) {
+	if (!hci_dev_test_and_set_flag(hdev, HCI_SERVICE_CACHE)) {
 		queue_delayed_work(hdev->workqueue, &hdev->service_cache,
 				   CACHE_TIMEOUT);
 		return true;
@@ -2714,8 +2713,7 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_link_keys_clear(hdev);
 
 	if (cp->debug_keys)
-		changed = !test_and_set_bit(HCI_KEEP_DEBUG_KEYS,
-					    &hdev->dev_flags);
+		changed = !hci_dev_test_and_set_flag(hdev, HCI_KEEP_DEBUG_KEYS);
 	else
 		changed = hci_dev_test_and_clear_flag(hdev,
 						      HCI_KEEP_DEBUG_KEYS);
@@ -4463,8 +4461,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 		bool changed;
 
 		if (cp->val) {
-			changed = !test_and_set_bit(HCI_ADVERTISING,
-						    &hdev->dev_flags);
+			changed = !hci_dev_test_and_set_flag(hdev, HCI_ADVERTISING);
 			if (cp->val == 0x02)
 				hci_dev_set_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 			else
@@ -4940,8 +4937,8 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 		bool changed;
 
 		if (cp->val) {
-			changed = !test_and_set_bit(HCI_SC_ENABLED,
-						    &hdev->dev_flags);
+			changed = !hci_dev_test_and_set_flag(hdev,
+							     HCI_SC_ENABLED);
 			if (cp->val == 0x02)
 				hci_dev_set_flag(hdev, HCI_SC_ONLY);
 			else
@@ -5011,15 +5008,14 @@ static int set_debug_keys(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (cp->val)
-		changed = !test_and_set_bit(HCI_KEEP_DEBUG_KEYS,
-					    &hdev->dev_flags);
+		changed = !hci_dev_test_and_set_flag(hdev, HCI_KEEP_DEBUG_KEYS);
 	else
 		changed = hci_dev_test_and_clear_flag(hdev,
 						      HCI_KEEP_DEBUG_KEYS);
 
 	if (cp->val == 0x02)
-		use_changed = !test_and_set_bit(HCI_USE_DEBUG_KEYS,
-						&hdev->dev_flags);
+		use_changed = !hci_dev_test_and_set_flag(hdev,
+							 HCI_USE_DEBUG_KEYS);
 	else
 		use_changed = hci_dev_test_and_clear_flag(hdev,
 							  HCI_USE_DEBUG_KEYS);
@@ -5072,7 +5068,7 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 	hci_dev_set_flag(hdev, HCI_RPA_RESOLVING);
 
 	if (cp->privacy) {
-		changed = !test_and_set_bit(HCI_PRIVACY, &hdev->dev_flags);
+		changed = !hci_dev_test_and_set_flag(hdev, HCI_PRIVACY);
 		memcpy(hdev->irk, cp->irk, sizeof(hdev->irk));
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 	} else {
@@ -6082,8 +6078,7 @@ static int set_external_config(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (cp->config)
-		changed = !test_and_set_bit(HCI_EXT_CONFIGURED,
-					    &hdev->dev_flags);
+		changed = !hci_dev_test_and_set_flag(hdev, HCI_EXT_CONFIGURED);
 	else
 		changed = hci_dev_test_and_clear_flag(hdev, HCI_EXT_CONFIGURED);
 
@@ -7090,8 +7085,7 @@ void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 	}
 
 	if (test_bit(HCI_AUTH, &hdev->flags))
-		changed = !test_and_set_bit(HCI_LINK_SECURITY,
-					    &hdev->dev_flags);
+		changed = !hci_dev_test_and_set_flag(hdev, HCI_LINK_SECURITY);
 	else
 		changed = hci_dev_test_and_clear_flag(hdev, HCI_LINK_SECURITY);
 
@@ -7141,7 +7135,7 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	}
 
 	if (enable) {
-		changed = !test_and_set_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
+		changed = !hci_dev_test_and_set_flag(hdev, HCI_SSP_ENABLED);
 	} else {
 		changed = hci_dev_test_and_clear_flag(hdev, HCI_SSP_ENABLED);
 		if (!changed)
-- 
2.1.0

