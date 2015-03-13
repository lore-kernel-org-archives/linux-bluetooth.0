Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: Introduce hci_dev_clear_flag helper macro
Date: Fri, 13 Mar 2015 02:11:02 -0700
Message-Id: <1426237866-8329-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of manually coding clear_bit on hdev->dev_flags all the time,
use hci_dev_clear_flag helper macro.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         |  2 +-
 net/bluetooth/hci_core.c         | 12 +++----
 net/bluetooth/hci_event.c        | 16 +++++-----
 net/bluetooth/hci_sock.c         |  4 +--
 net/bluetooth/mgmt.c             | 68 +++++++++++++++++++---------------------
 6 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bc2a7e918da7..535b23c73c92 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -503,6 +503,7 @@ extern rwlock_t hci_dev_list_lock;
 extern struct mutex hci_cb_list_lock;
 
 #define hci_dev_set_flag(hdev, nr)    set_bit((nr), &(hdev)->dev_flags)
+#define hci_dev_clear_flag(hdev, nr)  clear_bit((nr), &(hdev)->dev_flags)
 #define hci_dev_test_flag(hdev, nr)   test_bit((nr), &(hdev)->dev_flags)
 
 /* ----- HCI interface to upper protocols ----- */
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c0fd42ceff61..ee5e59839b02 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -700,7 +700,7 @@ static void hci_req_directed_advertising(struct hci_request *req,
 	 * and write a new random address. The flag will be set back on
 	 * as soon as the SET_ADV_ENABLE HCI command completes.
 	 */
-	clear_bit(HCI_LE_ADV, &hdev->dev_flags);
+	hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
 	/* Set require_privacy to false so that the remote device has a
 	 * chance of identifying us.
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 252b597362eb..01710698e547 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -591,7 +591,7 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
 	if (lmp_bredr_capable(hdev))
 		bredr_setup(req);
 	else
-		clear_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_BREDR_ENABLED);
 
 	if (lmp_le_capable(hdev))
 		le_setup(req);
@@ -1625,8 +1625,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	if (hdev->discov_timeout > 0) {
 		cancel_delayed_work(&hdev->discov_off);
 		hdev->discov_timeout = 0;
-		clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
-		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
+		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 	}
 
 	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
@@ -1846,7 +1846,7 @@ static void hci_update_scan_state(struct hci_dev *hdev, u8 scan)
 		discov_changed = !test_and_set_bit(HCI_DISCOVERABLE,
 						   &hdev->dev_flags);
 	} else {
-		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 		discov_changed = test_and_clear_bit(HCI_DISCOVERABLE,
 						    &hdev->dev_flags);
 	}
@@ -2087,7 +2087,7 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 		    !hci_dev_test_flag(hdev, HCI_CONFIG))
 			hci_dev_do_close(hdev);
 	} else {
-		clear_bit(HCI_RFKILLED, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_RFKILLED);
 	}
 
 	return 0;
@@ -2121,7 +2121,7 @@ static void hci_power_on(struct work_struct *work)
 	    (hdev->dev_type == HCI_BREDR &&
 	     !bacmp(&hdev->bdaddr, BDADDR_ANY) &&
 	     !bacmp(&hdev->static_addr, BDADDR_ANY))) {
-		clear_bit(HCI_AUTO_OFF, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_AUTO_OFF);
 		hci_dev_do_close(hdev);
 	} else if (hci_dev_test_flag(hdev, HCI_AUTO_OFF)) {
 		queue_delayed_work(hdev->req_workqueue, &hdev->power_off,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b01a93efada8..808b78cf8ad0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -82,7 +82,7 @@ static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 	if (status)
 		return;
 
-	clear_bit(HCI_PERIODIC_INQ, &hdev->dev_flags);
+	hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);
 
 	hci_conn_check_pending(hdev);
 }
@@ -503,7 +503,7 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 		if (sent->mode)
 			hci_dev_set_flag(hdev, HCI_SSP_ENABLED);
 		else
-			clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
+			hci_dev_clear_flag(hdev, HCI_SSP_ENABLED);
 	}
 
 	hci_dev_unlock(hdev);
@@ -533,7 +533,7 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
 		if (sent->support)
 			hci_dev_set_flag(hdev, HCI_SC_ENABLED);
 		else
-			clear_bit(HCI_SC_ENABLED, &hdev->dev_flags);
+			hci_dev_clear_flag(hdev, HCI_SC_ENABLED);
 	}
 
 	hci_dev_unlock(hdev);
@@ -1117,7 +1117,7 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 					   &conn->le_conn_timeout,
 					   conn->conn_timeout);
 	} else {
-		clear_bit(HCI_LE_ADV, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_LE_ADV);
 	}
 
 	hci_dev_unlock(hdev);
@@ -1217,7 +1217,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		 */
 		cancel_delayed_work(&hdev->le_scan_disable);
 
-		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_LE_SCAN);
 
 		/* The HCI_LE_SCAN_INTERRUPTED flag indicates that we
 		 * interrupted scanning due to a connect request. Mark
@@ -1391,8 +1391,8 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 		hci_dev_set_flag(hdev, HCI_LE_ENABLED);
 	} else {
 		hdev->features[1][0] &= ~LMP_HOST_LE;
-		clear_bit(HCI_LE_ENABLED, &hdev->dev_flags);
-		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_LE_ENABLED);
+		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
 	}
 
 	if (sent->simul)
@@ -4409,7 +4409,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	/* All controllers implicitly stop advertising in the event of a
 	 * connection, so ensure that the state bit is cleared.
 	 */
-	clear_bit(HCI_LE_ADV, &hdev->dev_flags);
+	hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
 	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
 	if (!conn) {
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index b297709d82bf..ca402a0a6740 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -474,7 +474,7 @@ static int hci_sock_release(struct socket *sock)
 	if (hdev) {
 		if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
 			mgmt_index_added(hdev);
-			clear_bit(HCI_USER_CHANNEL, &hdev->dev_flags);
+			hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
 			hci_dev_close(hdev->id);
 		}
 
@@ -730,7 +730,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 
 		err = hci_dev_open(hdev->id);
 		if (err) {
-			clear_bit(HCI_USER_CHANNEL, &hdev->dev_flags);
+			hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
 			mgmt_index_added(hdev);
 			hci_dev_put(hdev);
 			goto done;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 924bf3ee6261..aa233e37fc93 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1108,7 +1108,7 @@ static void enable_advertising(struct hci_request *req)
 	 * and write a new random address. The flag will be set back on
 	 * as soon as the SET_ADV_ENABLE HCI command completes.
 	 */
-	clear_bit(HCI_LE_ADV, &hdev->dev_flags);
+	hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
 		connectable = true;
@@ -1189,7 +1189,7 @@ static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 	 * for mgmt we require user-space to explicitly enable
 	 * it
 	 */
-	clear_bit(HCI_BONDABLE, &hdev->dev_flags);
+	hci_dev_clear_flag(hdev, HCI_BONDABLE);
 }
 
 static int read_controller_info(struct sock *sk, struct hci_dev *hdev,
@@ -1573,7 +1573,7 @@ static void set_discoverable_complete(struct hci_dev *hdev, u8 status,
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
 		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
-		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 		goto remove_cmd;
 	}
 
@@ -1725,7 +1725,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (cp->val == 0x02)
 		hci_dev_set_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 	else
-		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 
 	hci_req_init(&req, hdev);
 
@@ -1762,7 +1762,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		scan |= SCAN_INQUIRY;
 	} else {
-		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 	}
 
 	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
@@ -1876,8 +1876,8 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 	if (val) {
 		hci_dev_set_flag(hdev, HCI_CONNECTABLE);
 	} else {
-		clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
-		clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_CONNECTABLE);
+		hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
 	}
 
 	err = send_settings_rsp(sk, MGMT_OP_SET_CONNECTABLE, hdev);
@@ -1941,8 +1941,8 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	 */
 	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
 		if (!cp->val) {
-			clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
-			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+			hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
+			hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
 		}
 		update_adv_data(&req);
 	} else if (cp->val != test_bit(HCI_PSCAN, &hdev->flags)) {
@@ -2126,7 +2126,7 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 				changed = test_and_clear_bit(HCI_HS_ENABLED,
 							     &hdev->dev_flags);
 			else
-				clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
+				hci_dev_clear_flag(hdev, HCI_HS_ENABLED);
 		}
 
 		err = send_settings_rsp(sk, MGMT_OP_SET_SSP, hdev);
@@ -2306,7 +2306,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		}
 
 		if (!val && hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
-			clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
+			hci_dev_clear_flag(hdev, HCI_ADVERTISING);
 			changed = true;
 		}
 
@@ -4412,7 +4412,7 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 		hci_dev_set_flag(hdev, HCI_ADVERTISING);
 	else
-		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
 
 	mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev, settings_rsp,
 			     &match);
@@ -4469,13 +4469,11 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 			if (cp->val == 0x02)
 				hci_dev_set_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 			else
-				clear_bit(HCI_ADVERTISING_CONNECTABLE,
-					  &hdev->dev_flags);
+				hci_dev_clear_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 		} else {
 			changed = test_and_clear_bit(HCI_ADVERTISING,
 						     &hdev->dev_flags);
-			clear_bit(HCI_ADVERTISING_CONNECTABLE,
-				  &hdev->dev_flags);
+			hci_dev_clear_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 		}
 
 		err = send_settings_rsp(sk, MGMT_OP_SET_ADVERTISING, hdev);
@@ -4506,7 +4504,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (cp->val == 0x02)
 		hci_dev_set_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 	else
-		clear_bit(HCI_ADVERTISING_CONNECTABLE, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 
 	if (val)
 		enable_advertising(&req);
@@ -4645,7 +4643,7 @@ static void fast_connectable_complete(struct hci_dev *hdev, u8 status,
 		if (cp->val)
 			hci_dev_set_flag(hdev, HCI_FAST_CONNECTABLE);
 		else
-			clear_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags);
+			hci_dev_clear_flag(hdev, HCI_FAST_CONNECTABLE);
 
 		send_settings_rsp(cmd->sk, MGMT_OP_SET_FAST_CONNECTABLE, hdev);
 		new_settings(hdev, cmd->sk);
@@ -4740,7 +4738,7 @@ static void set_bredr_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 		/* We need to restore the flag if related HCI commands
 		 * failed.
 		 */
-		clear_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_BREDR_ENABLED);
 
 		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
 	} else {
@@ -4784,11 +4782,11 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	if (!hdev_is_powered(hdev)) {
 		if (!cp->val) {
-			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
-			clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
-			clear_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
-			clear_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags);
-			clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
+			hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
+			hci_dev_clear_flag(hdev, HCI_SSP_ENABLED);
+			hci_dev_clear_flag(hdev, HCI_LINK_SECURITY);
+			hci_dev_clear_flag(hdev, HCI_FAST_CONNECTABLE);
+			hci_dev_clear_flag(hdev, HCI_HS_ENABLED);
 		}
 
 		change_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
@@ -4889,12 +4887,12 @@ static void sc_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 	switch (cp->val) {
 	case 0x00:
-		clear_bit(HCI_SC_ENABLED, &hdev->dev_flags);
-		clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_SC_ENABLED);
+		hci_dev_clear_flag(hdev, HCI_SC_ONLY);
 		break;
 	case 0x01:
 		hci_dev_set_flag(hdev, HCI_SC_ENABLED);
-		clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_SC_ONLY);
 		break;
 	case 0x02:
 		hci_dev_set_flag(hdev, HCI_SC_ENABLED);
@@ -4949,11 +4947,11 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 			if (cp->val == 0x02)
 				hci_dev_set_flag(hdev, HCI_SC_ONLY);
 			else
-				clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
+				hci_dev_clear_flag(hdev, HCI_SC_ONLY);
 		} else {
 			changed = test_and_clear_bit(HCI_SC_ENABLED,
 						     &hdev->dev_flags);
-			clear_bit(HCI_SC_ONLY, &hdev->dev_flags);
+			hci_dev_clear_flag(hdev, HCI_SC_ONLY);
 		}
 
 		err = send_settings_rsp(sk, MGMT_OP_SET_SECURE_CONN, hdev);
@@ -5082,7 +5080,7 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 	} else {
 		changed = test_and_clear_bit(HCI_PRIVACY, &hdev->dev_flags);
 		memset(hdev->irk, 0, sizeof(hdev->irk));
-		clear_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_RPA_EXPIRED);
 	}
 
 	err = send_settings_rsp(sk, MGMT_OP_SET_PRIVACY, hdev);
@@ -6159,7 +6157,7 @@ static int set_public_address(struct sock *sk, struct hci_dev *hdev,
 	if (is_configured(hdev)) {
 		mgmt_index_removed(hdev);
 
-		clear_bit(HCI_UNCONFIGURED, &hdev->dev_flags);
+		hci_dev_clear_flag(hdev, HCI_UNCONFIGURED);
 
 		hci_dev_set_flag(hdev, HCI_CONFIG);
 		hci_dev_set_flag(hdev, HCI_AUTO_OFF);
@@ -6587,8 +6585,8 @@ void mgmt_discoverable_timeout(struct hci_dev *hdev)
 	 * of a timeout triggered from general discoverable, it is
 	 * safe to unconditionally clear the flag.
 	 */
-	clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
-	clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+	hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
+	hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
 
 	hci_req_init(&req, hdev);
 	if (hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
@@ -7137,7 +7135,7 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 
 		if (enable && test_and_clear_bit(HCI_SSP_ENABLED,
 						 &hdev->dev_flags)) {
-			clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
+			hci_dev_clear_flag(hdev, HCI_HS_ENABLED);
 			new_settings(hdev, NULL);
 		}
 
@@ -7154,7 +7152,7 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 			changed = test_and_clear_bit(HCI_HS_ENABLED,
 						     &hdev->dev_flags);
 		else
-			clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
+			hci_dev_clear_flag(hdev, HCI_HS_ENABLED);
 	}
 
 	mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, settings_rsp, &match);
-- 
2.1.0

