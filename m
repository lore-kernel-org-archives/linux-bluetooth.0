Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Introduce hci_dev_set_flag helper macro
Date: Fri, 13 Mar 2015 02:11:01 -0700
Message-Id: <1426237866-8329-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of manually coding set_bit on hdev->dev_flags all the time,
use hci_dev_set_flag helper macro.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         |  2 +-
 net/bluetooth/hci_core.c         | 24 ++++++++++++------------
 net/bluetooth/hci_event.c        | 14 +++++++-------
 net/bluetooth/hci_request.c      |  2 +-
 net/bluetooth/mgmt.c             | 39 +++++++++++++++++++--------------------
 6 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 05e95a75aba5..bc2a7e918da7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -502,6 +502,7 @@ extern struct list_head hci_cb_list;
 extern rwlock_t hci_dev_list_lock;
 extern struct mutex hci_cb_list_lock;
 
+#define hci_dev_set_flag(hdev, nr)    set_bit((nr), &(hdev)->dev_flags)
 #define hci_dev_test_flag(hdev, nr)   test_bit((nr), &(hdev)->dev_flags)
 
 /* ----- HCI interface to upper protocols ----- */
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5444e194eb4e..c0fd42ceff61 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -842,7 +842,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 		hci_req_add_le_scan_disable(&req);
-		set_bit(HCI_LE_SCAN_INTERRUPTED, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
 	}
 
 	hci_req_add_le_create_conn(&req, conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 20fe5ef6abc5..252b597362eb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -501,7 +501,7 @@ static void le_setup(struct hci_request *req)
 
 	/* LE-only controllers have LE implicitly enabled */
 	if (!lmp_bredr_capable(hdev))
-		set_bit(HCI_LE_ENABLED, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_LE_ENABLED);
 }
 
 static void hci_setup_event_mask(struct hci_request *req)
@@ -1448,7 +1448,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		 */
 		if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
 		    test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks))
-			set_bit(HCI_UNCONFIGURED, &hdev->dev_flags);
+			hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
 
 		/* For an unconfigured controller it is required to
 		 * read at least the version information provided by
@@ -1485,7 +1485,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 
 	if (!ret) {
 		hci_dev_hold(hdev);
-		set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
 		if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
@@ -1571,7 +1571,7 @@ int hci_dev_open(__u16 dev)
 	 */
 	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
 	    !hci_dev_test_flag(hdev, HCI_MGMT))
-		set_bit(HCI_BONDABLE, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_BONDABLE);
 
 	err = hci_dev_do_open(hdev);
 
@@ -1856,7 +1856,7 @@ static void hci_update_scan_state(struct hci_dev *hdev, u8 scan)
 
 	if (conn_changed || discov_changed) {
 		/* In case this was disabled through mgmt */
-		set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_BREDR_ENABLED);
 
 		if (hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 			mgmt_update_adv_data(hdev);
@@ -2082,7 +2082,7 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 		return -EBUSY;
 
 	if (blocked) {
-		set_bit(HCI_RFKILLED, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_RFKILLED);
 		if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
 		    !hci_dev_test_flag(hdev, HCI_CONFIG))
 			hci_dev_do_close(hdev);
@@ -3189,16 +3189,16 @@ int hci_register_dev(struct hci_dev *hdev)
 	}
 
 	if (hdev->rfkill && rfkill_blocked(hdev->rfkill))
-		set_bit(HCI_RFKILLED, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_RFKILLED);
 
-	set_bit(HCI_SETUP, &hdev->dev_flags);
-	set_bit(HCI_AUTO_OFF, &hdev->dev_flags);
+	hci_dev_set_flag(hdev, HCI_SETUP);
+	hci_dev_set_flag(hdev, HCI_AUTO_OFF);
 
 	if (hdev->dev_type == HCI_BREDR) {
 		/* Assume BR/EDR support until proven otherwise (such as
 		 * through reading supported features during init.
 		 */
-		set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_BREDR_ENABLED);
 	}
 
 	write_lock(&hci_dev_list_lock);
@@ -3209,7 +3209,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	 * and should not be included in normal operation.
 	 */
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
-		set_bit(HCI_UNCONFIGURED, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
 
 	hci_notify(hdev, HCI_DEV_REG);
 	hci_dev_hold(hdev);
@@ -3235,7 +3235,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
-	set_bit(HCI_UNREGISTER, &hdev->dev_flags);
+	hci_dev_set_flag(hdev, HCI_UNREGISTER);
 
 	id = hdev->id;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f1ed3fe9e0df..b01a93efada8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -70,7 +70,7 @@ static void hci_cc_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 	if (status)
 		return;
 
-	set_bit(HCI_PERIODIC_INQ, &hdev->dev_flags);
+	hci_dev_set_flag(hdev, HCI_PERIODIC_INQ);
 }
 
 static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
@@ -501,7 +501,7 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 		mgmt_ssp_enable_complete(hdev, sent->mode, status);
 	else if (!status) {
 		if (sent->mode)
-			set_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
+			hci_dev_set_flag(hdev, HCI_SSP_ENABLED);
 		else
 			clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
 	}
@@ -531,7 +531,7 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!hci_dev_test_flag(hdev, HCI_MGMT) && !status) {
 		if (sent->support)
-			set_bit(HCI_SC_ENABLED, &hdev->dev_flags);
+			hci_dev_set_flag(hdev, HCI_SC_ENABLED);
 		else
 			clear_bit(HCI_SC_ENABLED, &hdev->dev_flags);
 	}
@@ -1109,7 +1109,7 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	if (*sent) {
 		struct hci_conn *conn;
 
-		set_bit(HCI_LE_ADV, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_LE_ADV);
 
 		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
 		if (conn)
@@ -1192,7 +1192,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	switch (cp->enable) {
 	case LE_SCAN_ENABLE:
-		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_LE_SCAN);
 		if (hdev->le_scan_type == LE_SCAN_ACTIVE)
 			clear_pending_adv_report(hdev);
 		break;
@@ -1388,7 +1388,7 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 
 	if (sent->le) {
 		hdev->features[1][0] |= LMP_HOST_LE;
-		set_bit(HCI_LE_ENABLED, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_LE_ENABLED);
 	} else {
 		hdev->features[1][0] &= ~LMP_HOST_LE;
 		clear_bit(HCI_LE_ENABLED, &hdev->dev_flags);
@@ -2608,7 +2608,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 * whenever the encryption procedure fails.
 	 */
 	if (ev->status && conn->type == LE_LINK)
-		set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 42fa10522e89..fd7b2a97740b 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -307,7 +307,7 @@ static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
 	    hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT)) {
 		BT_DBG("Deferring random address update");
-		set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 		return;
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 596b36111e64..924bf3ee6261 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1163,7 +1163,7 @@ static void rpa_expired(struct work_struct *work)
 
 	BT_DBG("");
 
-	set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
+	hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 
 	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return;
@@ -1723,7 +1723,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	/* Limited discoverable mode */
 	if (cp->val == 0x02)
-		set_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 	else
 		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
 
@@ -1874,7 +1874,7 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 		changed = true;
 
 	if (val) {
-		set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_CONNECTABLE);
 	} else {
 		clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
 		clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
@@ -4410,7 +4410,7 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
 	}
 
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-		set_bit(HCI_ADVERTISING, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_ADVERTISING);
 	else
 		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
 
@@ -4467,8 +4467,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 			changed = !test_and_set_bit(HCI_ADVERTISING,
 						    &hdev->dev_flags);
 			if (cp->val == 0x02)
-				set_bit(HCI_ADVERTISING_CONNECTABLE,
-					&hdev->dev_flags);
+				hci_dev_set_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 			else
 				clear_bit(HCI_ADVERTISING_CONNECTABLE,
 					  &hdev->dev_flags);
@@ -4505,7 +4504,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_req_init(&req, hdev);
 
 	if (cp->val == 0x02)
-		set_bit(HCI_ADVERTISING_CONNECTABLE, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 	else
 		clear_bit(HCI_ADVERTISING_CONNECTABLE, &hdev->dev_flags);
 
@@ -4644,7 +4643,7 @@ static void fast_connectable_complete(struct hci_dev *hdev, u8 status,
 		struct mgmt_mode *cp = cmd->param;
 
 		if (cp->val)
-			set_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags);
+			hci_dev_set_flag(hdev, HCI_FAST_CONNECTABLE);
 		else
 			clear_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags);
 
@@ -4846,7 +4845,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	/* We need to flip the bit already here so that update_adv_data
 	 * generates the correct flags.
 	 */
-	set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
+	hci_dev_set_flag(hdev, HCI_BREDR_ENABLED);
 
 	hci_req_init(&req, hdev);
 
@@ -4894,12 +4893,12 @@ static void sc_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 		clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
 		break;
 	case 0x01:
-		set_bit(HCI_SC_ENABLED, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_SC_ENABLED);
 		clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
 		break;
 	case 0x02:
-		set_bit(HCI_SC_ENABLED, &hdev->dev_flags);
-		set_bit(HCI_SC_ONLY, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_SC_ENABLED);
+		hci_dev_set_flag(hdev, HCI_SC_ONLY);
 		break;
 	}
 
@@ -4948,7 +4947,7 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 			changed = !test_and_set_bit(HCI_SC_ENABLED,
 						    &hdev->dev_flags);
 			if (cp->val == 0x02)
-				set_bit(HCI_SC_ONLY, &hdev->dev_flags);
+				hci_dev_set_flag(hdev, HCI_SC_ONLY);
 			else
 				clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
 		} else {
@@ -5074,12 +5073,12 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 	/* If user space supports this command it is also expected to
 	 * handle IRKs. Therefore, set the HCI_RPA_RESOLVING flag.
 	 */
-	set_bit(HCI_RPA_RESOLVING, &hdev->dev_flags);
+	hci_dev_set_flag(hdev, HCI_RPA_RESOLVING);
 
 	if (cp->privacy) {
 		changed = !test_and_set_bit(HCI_PRIVACY, &hdev->dev_flags);
 		memcpy(hdev->irk, cp->irk, sizeof(hdev->irk));
-		set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 	} else {
 		changed = test_and_clear_bit(HCI_PRIVACY, &hdev->dev_flags);
 		memset(hdev->irk, 0, sizeof(hdev->irk));
@@ -5172,7 +5171,7 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 			    BDADDR_ANY);
 	}
 
-	set_bit(HCI_RPA_RESOLVING, &hdev->dev_flags);
+	hci_dev_set_flag(hdev, HCI_RPA_RESOLVING);
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_IRKS, 0, NULL, 0);
 
@@ -6106,8 +6105,8 @@ static int set_external_config(struct sock *sk, struct hci_dev *hdev,
 		mgmt_index_removed(hdev);
 
 		if (test_and_change_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
-			set_bit(HCI_CONFIG, &hdev->dev_flags);
-			set_bit(HCI_AUTO_OFF, &hdev->dev_flags);
+			hci_dev_set_flag(hdev, HCI_CONFIG);
+			hci_dev_set_flag(hdev, HCI_AUTO_OFF);
 
 			queue_work(hdev->req_workqueue, &hdev->power_on);
 		} else {
@@ -6162,8 +6161,8 @@ static int set_public_address(struct sock *sk, struct hci_dev *hdev,
 
 		clear_bit(HCI_UNCONFIGURED, &hdev->dev_flags);
 
-		set_bit(HCI_CONFIG, &hdev->dev_flags);
-		set_bit(HCI_AUTO_OFF, &hdev->dev_flags);
+		hci_dev_set_flag(hdev, HCI_CONFIG);
+		hci_dev_set_flag(hdev, HCI_AUTO_OFF);
 
 		queue_work(hdev->req_workqueue, &hdev->power_on);
 	}
-- 
2.1.0

