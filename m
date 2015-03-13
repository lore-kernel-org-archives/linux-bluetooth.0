Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Bluetooth: Introduce hci_dev_test_flag helper macro
Date: Fri, 13 Mar 2015 02:11:00 -0700
Message-Id: <1426237866-8329-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of manually coding test_bit on hdev->dev_flags all the time,
use hci_dev_test_flag helper macro.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  14 +--
 net/bluetooth/hci_conn.c         |  14 +--
 net/bluetooth/hci_core.c         | 120 ++++++++++-----------
 net/bluetooth/hci_debugfs.c      |   4 +-
 net/bluetooth/hci_event.c        |  92 ++++++++--------
 net/bluetooth/hci_request.c      |  28 ++---
 net/bluetooth/hci_sock.c         |   8 +-
 net/bluetooth/l2cap_core.c       |   8 +-
 net/bluetooth/mgmt.c             | 224 +++++++++++++++++++--------------------
 net/bluetooth/smp.c              |  44 ++++----
 10 files changed, 278 insertions(+), 278 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5cc5a192359d..05e95a75aba5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -502,6 +502,8 @@ extern struct list_head hci_cb_list;
 extern rwlock_t hci_dev_list_lock;
 extern struct mutex hci_cb_list_lock;
 
+#define hci_dev_test_flag(hdev, nr)   test_bit((nr), &(hdev)->dev_flags)
+
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
@@ -598,14 +600,14 @@ enum {
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
-	return test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
+	return hci_dev_test_flag(hdev, HCI_SSP_ENABLED) &&
 	       test_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
 }
 
 static inline bool hci_conn_sc_enabled(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
-	return test_bit(HCI_SC_ENABLED, &hdev->dev_flags) &&
+	return hci_dev_test_flag(hdev, HCI_SC_ENABLED) &&
 	       test_bit(HCI_CONN_SC_ENABLED, &conn->flags);
 }
 
@@ -1025,10 +1027,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_host_le_capable(dev)   (!!((dev)->features[1][0] & LMP_HOST_LE))
 #define lmp_host_le_br_capable(dev) (!!((dev)->features[1][0] & LMP_HOST_LE_BREDR))
 
-#define hdev_is_powered(hdev) (test_bit(HCI_UP, &hdev->flags) && \
-				!test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
-#define bredr_sc_enabled(dev) (lmp_sc_capable(dev) && \
-			       test_bit(HCI_SC_ENABLED, &(dev)->dev_flags))
+#define hdev_is_powered(dev)   (test_bit(HCI_UP, &(dev)->flags) && \
+				!hci_dev_test_flag(dev, HCI_AUTO_OFF))
+#define bredr_sc_enabled(dev)  (lmp_sc_capable(dev) && \
+				hci_dev_test_flag(dev, HCI_SC_ENABLED))
 
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 91ebb9cb31de..5444e194eb4e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -571,7 +571,7 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (!test_bit(HCI_UP, &d->flags) ||
-		    test_bit(HCI_USER_CHANNEL, &d->dev_flags) ||
+		    hci_dev_test_flag(d, HCI_USER_CHANNEL) ||
 		    d->dev_type != HCI_BREDR)
 			continue;
 
@@ -734,7 +734,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	int err;
 
 	/* Let's make sure that le is enabled.*/
-	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
 		if (lmp_le_capable(hdev))
 			return ERR_PTR(-ECONNREFUSED);
 
@@ -799,7 +799,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	 * anyway have to disable it in order to start directed
 	 * advertising.
 	 */
-	if (test_bit(HCI_LE_ADV, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
 		u8 enable = 0x00;
 		hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
 			    &enable);
@@ -810,7 +810,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		/* If we're active scanning most controllers are unable
 		 * to initiate advertising. Simply reject the attempt.
 		 */
-		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags) &&
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
 		    hdev->le_scan_type == LE_SCAN_ACTIVE) {
 			skb_queue_purge(&req.cmd_q);
 			hci_conn_del(conn);
@@ -840,7 +840,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	 * handler for scan disabling knows to set the correct discovery
 	 * state.
 	 */
-	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 		hci_req_add_le_scan_disable(&req);
 		set_bit(HCI_LE_SCAN_INTERRUPTED, &hdev->dev_flags);
 	}
@@ -864,7 +864,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *acl;
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
 		if (lmp_bredr_capable(hdev))
 			return ERR_PTR(-ECONNREFUSED);
 
@@ -942,7 +942,7 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 	 * Connections is used and the link is encrypted with AES-CCM
 	 * using a P-256 authenticated combination key.
 	 */
-	if (test_bit(HCI_SC_ONLY, &conn->hdev->flags)) {
+	if (hci_dev_test_flag(conn->hdev, HCI_SC_ONLY)) {
 		if (!hci_conn_sc_enabled(conn) ||
 		    !test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
 		    conn->key_type != HCI_LK_AUTH_COMBINATION_P256)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e3bbdd537b90..20fe5ef6abc5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -617,7 +617,7 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
 		 */
 		hdev->max_page = 0x01;
 
-		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
+		if (hci_dev_test_flag(hdev, HCI_SSP_ENABLED)) {
 			u8 mode = 0x01;
 
 			hci_req_add(req, HCI_OP_WRITE_SSP_MODE,
@@ -656,7 +656,7 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
 			    sizeof(cp), &cp);
 	}
 
-	if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_LINK_SECURITY)) {
 		u8 enable = 1;
 		hci_req_add(req, HCI_OP_WRITE_AUTH_ENABLE, sizeof(enable),
 			    &enable);
@@ -693,7 +693,7 @@ static void hci_set_le_support(struct hci_request *req)
 
 	memset(&cp, 0, sizeof(cp));
 
-	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
 		cp.le = 0x01;
 		cp.simul = 0x00;
 	}
@@ -881,7 +881,7 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 		hci_req_add(req, HCI_OP_READ_SYNC_TRAIN_PARAMS, 0, NULL);
 
 	/* Enable Secure Connections if supported and configured */
-	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
+	if (hci_dev_test_flag(hdev, HCI_SSP_ENABLED) &&
 	    bredr_sc_enabled(hdev)) {
 		u8 support = 0x01;
 
@@ -901,7 +901,7 @@ static int __hci_init(struct hci_dev *hdev)
 	/* The Device Under Test (DUT) mode is special and available for
 	 * all controller types. So just create it early on.
 	 */
-	if (test_bit(HCI_SETUP, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
 		debugfs_create_file("dut_mode", 0644, hdev->debugfs, hdev,
 				    &dut_mode_fops);
 	}
@@ -937,8 +937,8 @@ static int __hci_init(struct hci_dev *hdev)
 	 * So only when in setup phase or config phase, create the debugfs
 	 * entries and register the SMP channels.
 	 */
-	if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
-	    !test_bit(HCI_CONFIG, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
+	    !hci_dev_test_flag(hdev, HCI_CONFIG))
 		return 0;
 
 	hci_debugfs_create_common(hdev);
@@ -1300,12 +1300,12 @@ int hci_inquiry(void __user *arg)
 	if (!hdev)
 		return -ENODEV;
 
-	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		err = -EBUSY;
 		goto done;
 	}
 
-	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 		err = -EOPNOTSUPP;
 		goto done;
 	}
@@ -1315,7 +1315,7 @@ int hci_inquiry(void __user *arg)
 		goto done;
 	}
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
 		err = -EOPNOTSUPP;
 		goto done;
 	}
@@ -1387,17 +1387,17 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 
 	hci_req_lock(hdev);
 
-	if (test_bit(HCI_UNREGISTER, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
 		ret = -ENODEV;
 		goto done;
 	}
 
-	if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
-	    !test_bit(HCI_CONFIG, &hdev->dev_flags)) {
+	if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
+	    !hci_dev_test_flag(hdev, HCI_CONFIG)) {
 		/* Check for rfkill but allow the HCI setup stage to
 		 * proceed (which in itself doesn't cause any RF activity).
 		 */
-		if (test_bit(HCI_RFKILLED, &hdev->dev_flags)) {
+		if (hci_dev_test_flag(hdev, HCI_RFKILLED)) {
 			ret = -ERFKILL;
 			goto done;
 		}
@@ -1414,7 +1414,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		 * This check is only valid for BR/EDR controllers
 		 * since AMP controllers do not have an address.
 		 */
-		if (!test_bit(HCI_USER_CHANNEL, &hdev->dev_flags) &&
+		if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
 		    hdev->dev_type == HCI_BREDR &&
 		    !bacmp(&hdev->bdaddr, BDADDR_ANY) &&
 		    !bacmp(&hdev->static_addr, BDADDR_ANY)) {
@@ -1436,7 +1436,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	atomic_set(&hdev->cmd_cnt, 1);
 	set_bit(HCI_INIT, &hdev->flags);
 
-	if (test_bit(HCI_SETUP, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
 		if (hdev->setup)
 			ret = hdev->setup(hdev);
 
@@ -1458,11 +1458,11 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		 * also the original Bluetooth public device address
 		 * will be read using the Read BD Address command.
 		 */
-		if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
+		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
 			ret = __hci_unconf_init(hdev);
 	}
 
-	if (test_bit(HCI_CONFIG, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_CONFIG)) {
 		/* If public address change is configured, ensure that
 		 * the address gets programmed. If the driver does not
 		 * support changing the public address, fail the power
@@ -1476,8 +1476,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	}
 
 	if (!ret) {
-		if (!test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
-		    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags))
+		if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
+		    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
 			ret = __hci_init(hdev);
 	}
 
@@ -1488,10 +1488,10 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
-		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
-		    !test_bit(HCI_CONFIG, &hdev->dev_flags) &&
-		    !test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
-		    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags) &&
+		if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
+		    !hci_dev_test_flag(hdev, HCI_CONFIG) &&
+		    !hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
+		    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
 		    hdev->dev_type == HCI_BREDR) {
 			hci_dev_lock(hdev);
 			mgmt_powered(hdev, 1);
@@ -1543,8 +1543,8 @@ int hci_dev_open(__u16 dev)
 	 * HCI_USER_CHANNEL will be set first before attempting to
 	 * open the device.
 	 */
-	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
-	    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
+	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		err = -EOPNOTSUPP;
 		goto done;
 	}
@@ -1569,8 +1569,8 @@ int hci_dev_open(__u16 dev)
 	 * is in use this bit will be cleared again and userspace has
 	 * to explicitly enable it.
 	 */
-	if (!test_bit(HCI_USER_CHANNEL, &hdev->dev_flags) &&
-	    !test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+	    !hci_dev_test_flag(hdev, HCI_MGMT))
 		set_bit(HCI_BONDABLE, &hdev->dev_flags);
 
 	err = hci_dev_do_open(hdev);
@@ -1601,7 +1601,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 {
 	BT_DBG("%s %p", hdev->name, hdev);
 
-	if (!test_bit(HCI_UNREGISTER, &hdev->dev_flags)) {
+	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
 		/* Execute vendor specific shutdown routine */
 		if (hdev->shutdown)
 			hdev->shutdown(hdev);
@@ -1635,7 +1635,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		cancel_delayed_work_sync(&hdev->rpa_expired);
 
 	/* Avoid potential lockdep warnings from the *_flush() calls by
@@ -1667,8 +1667,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	/* Reset device */
 	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
-	if (!test_bit(HCI_AUTO_OFF, &hdev->dev_flags) &&
-	    !test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
+	if (!hci_dev_test_flag(hdev, HCI_AUTO_OFF) &&
+	    !hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
 	    test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)) {
 		set_bit(HCI_INIT, &hdev->flags);
 		__hci_req_sync(hdev, hci_reset_req, 0, HCI_CMD_TIMEOUT);
@@ -1723,7 +1723,7 @@ int hci_dev_close(__u16 dev)
 	if (!hdev)
 		return -ENODEV;
 
-	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		err = -EBUSY;
 		goto done;
 	}
@@ -1786,12 +1786,12 @@ int hci_dev_reset(__u16 dev)
 		goto done;
 	}
 
-	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		err = -EBUSY;
 		goto done;
 	}
 
-	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 		err = -EOPNOTSUPP;
 		goto done;
 	}
@@ -1812,12 +1812,12 @@ int hci_dev_reset_stat(__u16 dev)
 	if (!hdev)
 		return -ENODEV;
 
-	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		ret = -EBUSY;
 		goto done;
 	}
 
-	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 		ret = -EOPNOTSUPP;
 		goto done;
 	}
@@ -1851,14 +1851,14 @@ static void hci_update_scan_state(struct hci_dev *hdev, u8 scan)
 						    &hdev->dev_flags);
 	}
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_MGMT))
 		return;
 
 	if (conn_changed || discov_changed) {
 		/* In case this was disabled through mgmt */
 		set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
 
-		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		if (hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 			mgmt_update_adv_data(hdev);
 
 		mgmt_new_settings(hdev);
@@ -1878,12 +1878,12 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 	if (!hdev)
 		return -ENODEV;
 
-	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		err = -EBUSY;
 		goto done;
 	}
 
-	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 		err = -EOPNOTSUPP;
 		goto done;
 	}
@@ -1893,7 +1893,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		goto done;
 	}
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
 		err = -EOPNOTSUPP;
 		goto done;
 	}
@@ -1997,7 +1997,7 @@ int hci_get_dev_list(void __user *arg)
 		 * is running, but in that case still indicate that the
 		 * device is actually down.
 		 */
-		if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+		if (hci_dev_test_flag(hdev, HCI_AUTO_OFF))
 			flags &= ~BIT(HCI_UP);
 
 		(dr + n)->dev_id  = hdev->id;
@@ -2035,7 +2035,7 @@ int hci_get_dev_info(void __user *arg)
 	 * is running, but in that case still indicate that the
 	 * device is actually down.
 	 */
-	if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_AUTO_OFF))
 		flags = hdev->flags & ~BIT(HCI_UP);
 	else
 		flags = hdev->flags;
@@ -2078,13 +2078,13 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 
 	BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
 
-	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
 		return -EBUSY;
 
 	if (blocked) {
 		set_bit(HCI_RFKILLED, &hdev->dev_flags);
-		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
-		    !test_bit(HCI_CONFIG, &hdev->dev_flags))
+		if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
+		    !hci_dev_test_flag(hdev, HCI_CONFIG))
 			hci_dev_do_close(hdev);
 	} else {
 		clear_bit(HCI_RFKILLED, &hdev->dev_flags);
@@ -2116,14 +2116,14 @@ static void hci_power_on(struct work_struct *work)
 	 * ignored and they need to be checked now. If they are still
 	 * valid, it is important to turn the device back off.
 	 */
-	if (test_bit(HCI_RFKILLED, &hdev->dev_flags) ||
-	    test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) ||
+	if (hci_dev_test_flag(hdev, HCI_RFKILLED) ||
+	    hci_dev_test_flag(hdev, HCI_UNCONFIGURED) ||
 	    (hdev->dev_type == HCI_BREDR &&
 	     !bacmp(&hdev->bdaddr, BDADDR_ANY) &&
 	     !bacmp(&hdev->static_addr, BDADDR_ANY))) {
 		clear_bit(HCI_AUTO_OFF, &hdev->dev_flags);
 		hci_dev_do_close(hdev);
-	} else if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
+	} else if (hci_dev_test_flag(hdev, HCI_AUTO_OFF)) {
 		queue_delayed_work(hdev->req_workqueue, &hdev->power_off,
 				   HCI_AUTO_OFF_TIMEOUT);
 	}
@@ -2132,7 +2132,7 @@ static void hci_power_on(struct work_struct *work)
 		/* For unconfigured devices, set the HCI_RAW flag
 		 * so that userspace can easily identify them.
 		 */
-		if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
+		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
 			set_bit(HCI_RAW, &hdev->flags);
 
 		/* For fully configured devices, this will send
@@ -2147,7 +2147,7 @@ static void hci_power_on(struct work_struct *work)
 		/* When the controller is now configured, then it
 		 * is important to clear the HCI_RAW flag.
 		 */
-		if (!test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
+		if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
 			clear_bit(HCI_RAW, &hdev->flags);
 
 		/* Powering on the controller with HCI_CONFIG set only
@@ -2986,7 +2986,7 @@ static void le_scan_restart_work(struct work_struct *work)
 	BT_DBG("%s", hdev->name);
 
 	/* If controller is not scanning we are done. */
-	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
 		return;
 
 	hci_req_init(&req, hdev);
@@ -3021,7 +3021,7 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
 	    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
-	    (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
+	    (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
 	     bacmp(&hdev->static_addr, BDADDR_ANY))) {
 		bacpy(bdaddr, &hdev->static_addr);
 		*bdaddr_type = ADDR_LE_DEV_RANDOM;
@@ -3251,8 +3251,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->power_on);
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
-	    !test_bit(HCI_SETUP, &hdev->dev_flags) &&
-	    !test_bit(HCI_CONFIG, &hdev->dev_flags)) {
+	    !hci_dev_test_flag(hdev, HCI_SETUP) &&
+	    !hci_dev_test_flag(hdev, HCI_CONFIG)) {
 		hci_dev_lock(hdev);
 		mgmt_index_removed(hdev);
 		hci_dev_unlock(hdev);
@@ -3926,7 +3926,7 @@ static inline int __get_blocks(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void __check_timeout(struct hci_dev *hdev, unsigned int cnt)
 {
-	if (!test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
+	if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
 		if (!cnt && time_after(jiffies, hdev->acl_last_tx +
@@ -4109,7 +4109,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 	if (!hci_conn_num(hdev, LE_LINK))
 		return;
 
-	if (!test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
+	if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 		/* LE tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
 		if (!hdev->le_cnt && hdev->le_pkts &&
@@ -4157,7 +4157,7 @@ static void hci_tx_work(struct work_struct *work)
 	BT_DBG("%s acl %d sco %d le %d", hdev->name, hdev->acl_cnt,
 	       hdev->sco_cnt, hdev->le_cnt);
 
-	if (!test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		/* Schedule queues and send stuff to HCI driver */
 		hci_sched_acl(hdev);
 		hci_sched_sco(hdev);
@@ -4354,7 +4354,7 @@ static void hci_rx_work(struct work_struct *work)
 			hci_send_to_sock(hdev, skb);
 		}
 
-		if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+		if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 			kfree_skb(skb);
 			continue;
 		}
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 65261e5d4b84..3c025ee5572c 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -247,7 +247,7 @@ static ssize_t use_debug_keys_read(struct file *file, char __user *user_buf,
 	struct hci_dev *hdev = file->private_data;
 	char buf[3];
 
-	buf[0] = test_bit(HCI_USE_DEBUG_KEYS, &hdev->dev_flags) ? 'Y': 'N';
+	buf[0] = hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS) ? 'Y': 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
@@ -265,7 +265,7 @@ static ssize_t sc_only_mode_read(struct file *file, char __user *user_buf,
 	struct hci_dev *hdev = file->private_data;
 	char buf[3];
 
-	buf[0] = test_bit(HCI_SC_ONLY, &hdev->dev_flags) ? 'Y': 'N';
+	buf[0] = hci_dev_test_flag(hdev, HCI_SC_ONLY) ? 'Y': 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 39653d46932b..f1ed3fe9e0df 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -265,7 +265,7 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_set_local_name_complete(hdev, sent, status);
 	else if (!status)
 		memcpy(hdev->dev_name, sent, HCI_MAX_NAME_LENGTH);
@@ -282,8 +282,8 @@ static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 	if (rp->status)
 		return;
 
-	if (test_bit(HCI_SETUP, &hdev->dev_flags) ||
-	    test_bit(HCI_CONFIG, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
+	    hci_dev_test_flag(hdev, HCI_CONFIG))
 		memcpy(hdev->dev_name, rp->name, HCI_MAX_NAME_LENGTH);
 }
 
@@ -309,7 +309,7 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 			clear_bit(HCI_AUTH, &hdev->flags);
 	}
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_auth_enable_complete(hdev, status);
 
 	hci_dev_unlock(hdev);
@@ -404,7 +404,7 @@ static void hci_cc_write_class_of_dev(struct hci_dev *hdev, struct sk_buff *skb)
 	if (status == 0)
 		memcpy(hdev->dev_class, sent, 3);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_set_class_of_dev_complete(hdev, sent, status);
 
 	hci_dev_unlock(hdev);
@@ -497,7 +497,7 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 			hdev->features[1][0] &= ~LMP_HOST_SSP;
 	}
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_ssp_enable_complete(hdev, sent->mode, status);
 	else if (!status) {
 		if (sent->mode)
@@ -529,7 +529,7 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
 			hdev->features[1][0] &= ~LMP_HOST_SC;
 	}
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags) && !status) {
+	if (!hci_dev_test_flag(hdev, HCI_MGMT) && !status) {
 		if (sent->support)
 			set_bit(HCI_SC_ENABLED, &hdev->dev_flags);
 		else
@@ -548,8 +548,8 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 	if (rp->status)
 		return;
 
-	if (test_bit(HCI_SETUP, &hdev->dev_flags) ||
-	    test_bit(HCI_CONFIG, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
+	    hci_dev_test_flag(hdev, HCI_CONFIG)) {
 		hdev->hci_ver = rp->hci_ver;
 		hdev->hci_rev = __le16_to_cpu(rp->hci_rev);
 		hdev->lmp_ver = rp->lmp_ver;
@@ -568,8 +568,8 @@ static void hci_cc_read_local_commands(struct hci_dev *hdev,
 	if (rp->status)
 		return;
 
-	if (test_bit(HCI_SETUP, &hdev->dev_flags) ||
-	    test_bit(HCI_CONFIG, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
+	    hci_dev_test_flag(hdev, HCI_CONFIG))
 		memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
 }
 
@@ -691,7 +691,7 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 	if (test_bit(HCI_INIT, &hdev->flags))
 		bacpy(&hdev->bdaddr, &rp->bdaddr);
 
-	if (test_bit(HCI_SETUP, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_SETUP))
 		bacpy(&hdev->setup_addr, &rp->bdaddr);
 }
 
@@ -900,7 +900,7 @@ static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_pin_code_reply_complete(hdev, &rp->bdaddr, rp->status);
 
 	if (rp->status)
@@ -926,7 +926,7 @@ static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_pin_code_neg_reply_complete(hdev, &rp->bdaddr,
 						 rp->status);
 
@@ -985,7 +985,7 @@ static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_user_confirm_reply_complete(hdev, &rp->bdaddr, ACL_LINK, 0,
 						 rp->status);
 
@@ -1001,7 +1001,7 @@ static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_user_confirm_neg_reply_complete(hdev, &rp->bdaddr,
 						     ACL_LINK, 0, rp->status);
 
@@ -1016,7 +1016,7 @@ static void hci_cc_user_passkey_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_user_passkey_reply_complete(hdev, &rp->bdaddr, ACL_LINK,
 						 0, rp->status);
 
@@ -1032,7 +1032,7 @@ static void hci_cc_user_passkey_neg_reply(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_user_passkey_neg_reply_complete(hdev, &rp->bdaddr,
 						     ACL_LINK, 0, rp->status);
 
@@ -1229,7 +1229,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		if (test_and_clear_bit(HCI_LE_SCAN_INTERRUPTED,
 				       &hdev->dev_flags))
 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-		else if (!test_bit(HCI_LE_ADV, &hdev->dev_flags) &&
+		else if (!hci_dev_test_flag(hdev, HCI_LE_ADV) &&
 			 hdev->discovery.state == DISCOVERY_FINDING)
 			mgmt_reenable_advertising(hdev);
 
@@ -1769,7 +1769,7 @@ static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		hci_check_pending_name(hdev, conn, &cp->bdaddr, NULL, 0);
 
 	if (!conn)
@@ -2118,7 +2118,7 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	smp_mb__after_atomic(); /* wake_up_bit advises about this barrier */
 	wake_up_bit(&hdev->flags, HCI_INQUIRY);
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_MGMT))
 		return;
 
 	hci_dev_lock(hdev);
@@ -2154,7 +2154,7 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!num_rsp)
 		return;
 
-	if (test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
 		return;
 
 	hci_dev_lock(hdev);
@@ -2304,8 +2304,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 * connection. These features are only touched through mgmt so
 	 * only do the checks if HCI_MGMT is set.
 	 */
-	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
-	    !test_bit(HCI_CONNECTABLE, &hdev->dev_flags) &&
+	if (hci_dev_test_flag(hdev, HCI_MGMT) &&
+	    !hci_dev_test_flag(hdev, HCI_CONNECTABLE) &&
 	    !hci_bdaddr_list_lookup(&hdev->whitelist, &ev->bdaddr,
 				    BDADDR_BREDR)) {
 		    hci_reject_conn(hdev, &ev->bdaddr);
@@ -2542,7 +2542,7 @@ static void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_MGMT))
 		goto check_auth;
 
 	if (ev->status == 0)
@@ -2626,7 +2626,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		 * connections that are not encrypted with AES-CCM
 		 * using a P-256 authenticated combination key.
 		 */
-		if (test_bit(HCI_SC_ONLY, &hdev->dev_flags) &&
+		if (hci_dev_test_flag(hdev, HCI_SC_ONLY) &&
 		    (!test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
 		     conn->key_type != HCI_LK_AUTH_COMBINATION_P256)) {
 			hci_connect_cfm(conn, HCI_ERROR_AUTH_FAILURE);
@@ -3331,11 +3331,11 @@ static void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_conn_drop(conn);
 	}
 
-	if (!test_bit(HCI_BONDABLE, &hdev->dev_flags) &&
+	if (!hci_dev_test_flag(hdev, HCI_BONDABLE) &&
 	    !test_bit(HCI_CONN_AUTH_INITIATOR, &conn->flags)) {
 		hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY,
 			     sizeof(ev->bdaddr), &ev->bdaddr);
-	} else if (test_bit(HCI_MGMT, &hdev->dev_flags)) {
+	} else if (hci_dev_test_flag(hdev, HCI_MGMT)) {
 		u8 secure;
 
 		if (conn->pending_sec_level == BT_SECURITY_HIGH)
@@ -3391,7 +3391,7 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_MGMT))
 		return;
 
 	hci_dev_lock(hdev);
@@ -3465,7 +3465,7 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	set_bit(HCI_CONN_NEW_LINK_KEY, &conn->flags);
 	conn_set_key(conn, ev->key_type, conn->pin_length);
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_MGMT))
 		goto unlock;
 
 	key = hci_add_link_key(hdev, conn, &ev->bdaddr, ev->link_key,
@@ -3487,7 +3487,7 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 * store_hint being 0).
 	 */
 	if (key->type == HCI_LK_DEBUG_COMBINATION &&
-	    !test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->dev_flags)) {
+	    !hci_dev_test_flag(hdev, HCI_KEEP_DEBUG_KEYS)) {
 		list_del_rcu(&key->list);
 		kfree_rcu(key, rcu);
 		goto unlock;
@@ -3570,7 +3570,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 	if (!num_rsp)
 		return;
 
-	if (test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
 		return;
 
 	hci_dev_lock(hdev);
@@ -3776,7 +3776,7 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 	if (!num_rsp)
 		return;
 
-	if (test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
 		return;
 
 	hci_dev_lock(hdev);
@@ -3794,7 +3794,7 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 		data.rssi		= info->rssi;
 		data.ssp_mode		= 0x01;
 
-		if (test_bit(HCI_MGMT, &hdev->dev_flags))
+		if (hci_dev_test_flag(hdev, HCI_MGMT))
 			name_known = eir_has_data_type(info->data,
 						       sizeof(info->data),
 						       EIR_NAME_COMPLETE);
@@ -3898,7 +3898,7 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 			 * information. However it can only be trusted when
 			 * not in Secure Connection Only mode.
 			 */
-			if (!test_bit(HCI_SC_ONLY, &hdev->dev_flags))
+			if (!hci_dev_test_flag(hdev, HCI_SC_ONLY))
 				return data->present;
 
 			/* When Secure Connections Only mode is enabled, then
@@ -3942,13 +3942,13 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_conn_hold(conn);
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_MGMT))
 		goto unlock;
 
 	/* Allow pairing if we're pairable, the initiators of the
 	 * pairing or if the remote is not requesting bonding.
 	 */
-	if (test_bit(HCI_BONDABLE, &hdev->dev_flags) ||
+	if (hci_dev_test_flag(hdev, HCI_BONDABLE) ||
 	    test_bit(HCI_CONN_AUTH_INITIATOR, &conn->flags) ||
 	    (conn->remote_auth & ~0x01) == HCI_AT_NO_BONDING) {
 		struct hci_cp_io_capability_reply cp;
@@ -3974,7 +3974,7 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		/* If we're not bondable, force one of the non-bondable
 		 * authentication requirement values.
 		 */
-		if (!test_bit(HCI_BONDABLE, &hdev->dev_flags))
+		if (!hci_dev_test_flag(hdev, HCI_BONDABLE))
 			conn->auth_type &= HCI_AT_NO_BONDING_MITM;
 
 		cp.authentication = conn->auth_type;
@@ -4029,7 +4029,7 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_MGMT))
 		goto unlock;
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
@@ -4100,7 +4100,7 @@ static void hci_user_passkey_request_evt(struct hci_dev *hdev,
 
 	BT_DBG("%s", hdev->name);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_user_passkey_request(hdev, &ev->bdaddr, ACL_LINK, 0);
 }
 
@@ -4119,7 +4119,7 @@ static void hci_user_passkey_notify_evt(struct hci_dev *hdev,
 	conn->passkey_notify = __le32_to_cpu(ev->passkey);
 	conn->passkey_entered = 0;
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_user_passkey_notify(hdev, &conn->dst, conn->type,
 					 conn->dst_type, conn->passkey_notify,
 					 conn->passkey_entered);
@@ -4157,7 +4157,7 @@ static void hci_keypress_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_user_passkey_notify(hdev, &conn->dst, conn->type,
 					 conn->dst_type, conn->passkey_notify,
 					 conn->passkey_entered);
@@ -4226,7 +4226,7 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_MGMT))
 		goto unlock;
 
 	data = hci_find_remote_oob_data(hdev, &ev->bdaddr, BDADDR_BREDR);
@@ -4243,7 +4243,7 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 		struct hci_cp_remote_oob_ext_data_reply cp;
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
-		if (test_bit(HCI_SC_ONLY, &hdev->dev_flags)) {
+		if (hci_dev_test_flag(hdev, HCI_SC_ONLY)) {
 			memset(cp.hash192, 0, sizeof(cp.hash192));
 			memset(cp.rand192, 0, sizeof(cp.rand192));
 		} else {
@@ -4432,7 +4432,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		if (conn->out) {
 			conn->resp_addr_type = ev->bdaddr_type;
 			bacpy(&conn->resp_addr, &ev->bdaddr);
-			if (test_bit(HCI_PRIVACY, &hdev->dev_flags)) {
+			if (hci_dev_test_flag(hdev, HCI_PRIVACY)) {
 				conn->init_addr_type = ADDR_LE_DEV_RANDOM;
 				bacpy(&conn->init_addr, &hdev->rpa);
 			} else {
@@ -4658,7 +4658,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		/* If the controller is not using resolvable random
 		 * addresses, then this report can be ignored.
 		 */
-		if (!test_bit(HCI_PRIVACY, &hdev->dev_flags))
+		if (!hci_dev_test_flag(hdev, HCI_PRIVACY))
 			return;
 
 		/* If the local IRK of the controller does not match
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index f857e765e081..42fa10522e89 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -270,7 +270,7 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	 * and 0x01 (whitelist enabled) use the new filter policies
 	 * 0x02 (no whitelist) and 0x03 (whitelist enabled).
 	 */
-	if (test_bit(HCI_PRIVACY, &hdev->dev_flags) &&
+	if (hci_dev_test_flag(hdev, HCI_PRIVACY) &&
 	    (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY))
 		filter_policy |= 0x02;
 
@@ -304,7 +304,7 @@ static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
 	 * In this kind of scenario skip the update and let the random
 	 * address be updated at the next cycle.
 	 */
-	if (test_bit(HCI_LE_ADV, &hdev->dev_flags) ||
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
 	    hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT)) {
 		BT_DBG("Deferring random address update");
 		set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
@@ -324,7 +324,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 	 * current RPA has expired or there is something else than
 	 * the current RPA in use, then generate a new one.
 	 */
-	if (test_bit(HCI_PRIVACY, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_PRIVACY)) {
 		int to;
 
 		*own_addr_type = ADDR_LE_DEV_RANDOM;
@@ -385,7 +385,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 	 */
 	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
 	    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
-	    (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
+	    (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
 	     bacmp(&hdev->static_addr, BDADDR_ANY))) {
 		*own_addr_type = ADDR_LE_DEV_RANDOM;
 		if (bacmp(&hdev->static_addr, &hdev->random_addr))
@@ -425,7 +425,7 @@ void __hci_update_page_scan(struct hci_request *req)
 	struct hci_dev *hdev = req->hdev;
 	u8 scan;
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 		return;
 
 	if (!hdev_is_powered(hdev))
@@ -434,7 +434,7 @@ void __hci_update_page_scan(struct hci_request *req)
 	if (mgmt_powering_down(hdev))
 		return;
 
-	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) ||
+	if (hci_dev_test_flag(hdev, HCI_CONNECTABLE) ||
 	    disconnected_whitelist_entries(hdev))
 		scan = SCAN_PAGE;
 	else
@@ -443,7 +443,7 @@ void __hci_update_page_scan(struct hci_request *req)
 	if (test_bit(HCI_PSCAN, &hdev->flags) == !!(scan & SCAN_PAGE))
 		return;
 
-	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
 		scan |= SCAN_INQUIRY;
 
 	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
@@ -471,14 +471,14 @@ void __hci_update_background_scan(struct hci_request *req)
 
 	if (!test_bit(HCI_UP, &hdev->flags) ||
 	    test_bit(HCI_INIT, &hdev->flags) ||
-	    test_bit(HCI_SETUP, &hdev->dev_flags) ||
-	    test_bit(HCI_CONFIG, &hdev->dev_flags) ||
-	    test_bit(HCI_AUTO_OFF, &hdev->dev_flags) ||
-	    test_bit(HCI_UNREGISTER, &hdev->dev_flags))
+	    hci_dev_test_flag(hdev, HCI_SETUP) ||
+	    hci_dev_test_flag(hdev, HCI_CONFIG) ||
+	    hci_dev_test_flag(hdev, HCI_AUTO_OFF) ||
+	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		return;
 
 	/* No point in doing scanning if LE support hasn't been enabled */
-	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return;
 
 	/* If discovery is active don't interfere with it */
@@ -502,7 +502,7 @@ void __hci_update_background_scan(struct hci_request *req)
 		 */
 
 		/* If controller is not scanning we are done. */
-		if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
 			return;
 
 		hci_req_add_le_scan_disable(req);
@@ -524,7 +524,7 @@ void __hci_update_background_scan(struct hci_request *req)
 		/* If controller is currently scanning, we stop it to ensure we
 		 * don't miss any advertising (due to duplicates filter).
 		 */
-		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
 			hci_req_add_le_scan_disable(req);
 
 		hci_req_add_le_passive_scan(req);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index aa9ffcb9481f..b297709d82bf 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -534,10 +534,10 @@ static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 	if (!hdev)
 		return -EBADFD;
 
-	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
 		return -EBUSY;
 
-	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
 		return -EOPNOTSUPP;
 
 	if (hdev->dev_type != HCI_BREDR)
@@ -713,8 +713,8 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 
 		if (test_bit(HCI_UP, &hdev->flags) ||
 		    test_bit(HCI_INIT, &hdev->flags) ||
-		    test_bit(HCI_SETUP, &hdev->dev_flags) ||
-		    test_bit(HCI_CONFIG, &hdev->dev_flags)) {
+		    hci_dev_test_flag(hdev, HCI_SETUP) ||
+		    hci_dev_test_flag(hdev, HCI_CONFIG)) {
 			err = -EBUSY;
 			hci_dev_put(hdev);
 			goto done;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 91c682846bcf..af30d8240c80 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3900,7 +3900,7 @@ static int l2cap_connect_req(struct l2cap_conn *conn,
 		return -EPROTO;
 
 	hci_dev_lock(hdev);
-	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
+	if (hci_dev_test_flag(hdev, HCI_MGMT) &&
 	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &hcon->flags))
 		mgmt_device_connected(hdev, hcon, 0, NULL, 0);
 	hci_dev_unlock(hdev);
@@ -6987,10 +6987,10 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	conn->local_fixed_chan = L2CAP_FC_SIG_BREDR | L2CAP_FC_CONNLESS;
 
 	if (hcon->type == ACL_LINK &&
-	    test_bit(HCI_HS_ENABLED, &hcon->hdev->dev_flags))
+	    hci_dev_test_flag(hcon->hdev, HCI_HS_ENABLED))
 		conn->local_fixed_chan |= L2CAP_FC_A2MP;
 
-	if (test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags) &&
+	if (hci_dev_test_flag(hcon->hdev, HCI_LE_ENABLED) &&
 	    (bredr_sc_enabled(hcon->hdev) ||
 	     test_bit(HCI_FORCE_BREDR_SMP, &hcon->hdev->dbg_flags)))
 		conn->local_fixed_chan |= L2CAP_FC_SMP_BREDR;
@@ -7112,7 +7112,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		else
 			dst_type = ADDR_LE_DEV_RANDOM;
 
-		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
 			role = HCI_ROLE_SLAVE;
 		else
 			role = HCI_ROLE_MASTER;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0761f2e0fefa..596b36111e64 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -385,7 +385,7 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (d->dev_type == HCI_BREDR &&
-		    !test_bit(HCI_UNCONFIGURED, &d->dev_flags))
+		    !hci_dev_test_flag(d, HCI_UNCONFIGURED))
 			count++;
 	}
 
@@ -398,9 +398,9 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (test_bit(HCI_SETUP, &d->dev_flags) ||
-		    test_bit(HCI_CONFIG, &d->dev_flags) ||
-		    test_bit(HCI_USER_CHANNEL, &d->dev_flags))
+		if (hci_dev_test_flag(d, HCI_SETUP) ||
+		    hci_dev_test_flag(d, HCI_CONFIG) ||
+		    hci_dev_test_flag(d, HCI_USER_CHANNEL))
 			continue;
 
 		/* Devices marked as raw-only are neither configured
@@ -410,7 +410,7 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 			continue;
 
 		if (d->dev_type == HCI_BREDR &&
-		    !test_bit(HCI_UNCONFIGURED, &d->dev_flags)) {
+		    !hci_dev_test_flag(d, HCI_UNCONFIGURED)) {
 			rp->index[count++] = cpu_to_le16(d->id);
 			BT_DBG("Added hci%u", d->id);
 		}
@@ -445,7 +445,7 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (d->dev_type == HCI_BREDR &&
-		    test_bit(HCI_UNCONFIGURED, &d->dev_flags))
+		    hci_dev_test_flag(d, HCI_UNCONFIGURED))
 			count++;
 	}
 
@@ -458,9 +458,9 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (test_bit(HCI_SETUP, &d->dev_flags) ||
-		    test_bit(HCI_CONFIG, &d->dev_flags) ||
-		    test_bit(HCI_USER_CHANNEL, &d->dev_flags))
+		if (hci_dev_test_flag(d, HCI_SETUP) ||
+		    hci_dev_test_flag(d, HCI_CONFIG) ||
+		    hci_dev_test_flag(d, HCI_USER_CHANNEL))
 			continue;
 
 		/* Devices marked as raw-only are neither configured
@@ -470,7 +470,7 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 			continue;
 
 		if (d->dev_type == HCI_BREDR &&
-		    test_bit(HCI_UNCONFIGURED, &d->dev_flags)) {
+		    hci_dev_test_flag(d, HCI_UNCONFIGURED)) {
 			rp->index[count++] = cpu_to_le16(d->id);
 			BT_DBG("Added hci%u", d->id);
 		}
@@ -492,7 +492,7 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 static bool is_configured(struct hci_dev *hdev)
 {
 	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) &&
-	    !test_bit(HCI_EXT_CONFIGURED, &hdev->dev_flags))
+	    !hci_dev_test_flag(hdev, HCI_EXT_CONFIGURED))
 		return false;
 
 	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
@@ -507,7 +507,7 @@ static __le32 get_missing_options(struct hci_dev *hdev)
 	u32 options = 0;
 
 	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) &&
-	    !test_bit(HCI_EXT_CONFIGURED, &hdev->dev_flags))
+	    !hci_dev_test_flag(hdev, HCI_EXT_CONFIGURED))
 		options |= MGMT_OPTION_EXTERNAL_CONFIG;
 
 	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
@@ -608,43 +608,43 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (hdev_is_powered(hdev))
 		settings |= MGMT_SETTING_POWERED;
 
-	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_CONNECTABLE))
 		settings |= MGMT_SETTING_CONNECTABLE;
 
-	if (test_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_FAST_CONNECTABLE))
 		settings |= MGMT_SETTING_FAST_CONNECTABLE;
 
-	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
 		settings |= MGMT_SETTING_DISCOVERABLE;
 
-	if (test_bit(HCI_BONDABLE, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_BONDABLE))
 		settings |= MGMT_SETTING_BONDABLE;
 
-	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 		settings |= MGMT_SETTING_BREDR;
 
-	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		settings |= MGMT_SETTING_LE;
 
-	if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_LINK_SECURITY))
 		settings |= MGMT_SETTING_LINK_SECURITY;
 
-	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
 		settings |= MGMT_SETTING_SSP;
 
-	if (test_bit(HCI_HS_ENABLED, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_HS_ENABLED))
 		settings |= MGMT_SETTING_HS;
 
-	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		settings |= MGMT_SETTING_ADVERTISING;
 
-	if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_SC_ENABLED))
 		settings |= MGMT_SETTING_SECURE_CONN;
 
-	if (test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_KEEP_DEBUG_KEYS))
 		settings |= MGMT_SETTING_DEBUG_KEYS;
 
-	if (test_bit(HCI_PRIVACY, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_PRIVACY))
 		settings |= MGMT_SETTING_PRIVACY;
 
 	/* The current setting for static address has two purposes. The
@@ -660,7 +660,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	 * be evaluated.
 	 */
 	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
-	    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) ||
+	    !hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) ||
 	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
 		if (bacmp(&hdev->static_addr, BDADDR_ANY))
 			settings |= MGMT_SETTING_STATIC_ADDRESS;
@@ -840,7 +840,7 @@ static void update_scan_rsp_data(struct hci_request *req)
 	struct hci_cp_le_set_scan_rsp_data cp;
 	u8 len;
 
-	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return;
 
 	memset(&cp, 0, sizeof(cp));
@@ -874,9 +874,9 @@ static u8 get_adv_discov_flags(struct hci_dev *hdev)
 		else if (cp->val == 0x02)
 			return LE_AD_LIMITED;
 	} else {
-		if (test_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags))
+		if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
 			return LE_AD_LIMITED;
-		else if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
+		else if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
 			return LE_AD_GENERAL;
 	}
 
@@ -889,7 +889,7 @@ static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
 
 	flags |= get_adv_discov_flags(hdev);
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 		flags |= LE_AD_NO_BREDR;
 
 	if (flags) {
@@ -921,7 +921,7 @@ static void update_adv_data(struct hci_request *req)
 	struct hci_cp_le_set_adv_data cp;
 	u8 len;
 
-	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return;
 
 	memset(&cp, 0, sizeof(cp));
@@ -1009,10 +1009,10 @@ static void update_eir(struct hci_request *req)
 	if (!lmp_ext_inq_capable(hdev))
 		return;
 
-	if (!test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
 		return;
 
-	if (test_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_SERVICE_CACHE))
 		return;
 
 	memset(&cp, 0, sizeof(cp));
@@ -1048,17 +1048,17 @@ static void update_class(struct hci_request *req)
 	if (!hdev_is_powered(hdev))
 		return;
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 		return;
 
-	if (test_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_SERVICE_CACHE))
 		return;
 
 	cod[0] = hdev->minor_class;
 	cod[1] = hdev->major_class;
 	cod[2] = get_service_classes(hdev);
 
-	if (test_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
 		cod[1] |= 0x20;
 
 	if (memcmp(cod, hdev->dev_class, 3) == 0)
@@ -1080,7 +1080,7 @@ static bool get_connectable(struct hci_dev *hdev)
 		return cp->val;
 	}
 
-	return test_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+	return hci_dev_test_flag(hdev, HCI_CONNECTABLE);
 }
 
 static void disable_advertising(struct hci_request *req)
@@ -1100,7 +1100,7 @@ static void enable_advertising(struct hci_request *req)
 	if (hci_conn_num(hdev, LE_LINK) > 0)
 		return;
 
-	if (test_bit(HCI_LE_ADV, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 		disable_advertising(req);
 
 	/* Clear the HCI_LE_ADV bit temporarily so that the
@@ -1110,7 +1110,7 @@ static void enable_advertising(struct hci_request *req)
 	 */
 	clear_bit(HCI_LE_ADV, &hdev->dev_flags);
 
-	if (test_bit(HCI_ADVERTISING_CONNECTABLE, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
 		connectable = true;
 	else
 		connectable = get_connectable(hdev);
@@ -1165,7 +1165,7 @@ static void rpa_expired(struct work_struct *work)
 
 	set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
 
-	if (!test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return;
 
 	/* The generation of a new RPA and programming it into the
@@ -1328,7 +1328,7 @@ static bool hci_stop_discovery(struct hci_request *req)
 
 	default:
 		/* Passive scanning */
-		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 			hci_req_add_le_scan_disable(req);
 			return true;
 		}
@@ -1354,7 +1354,7 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	}
 
-	if (test_bit(HCI_LE_ADV, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 		disable_advertising(&req);
 
 	discov_stopped = hci_stop_discovery(&req);
@@ -1538,7 +1538,7 @@ static u8 mgmt_bredr_support(struct hci_dev *hdev)
 {
 	if (!lmp_bredr_capable(hdev))
 		return MGMT_STATUS_NOT_SUPPORTED;
-	else if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	else if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 		return MGMT_STATUS_REJECTED;
 	else
 		return MGMT_STATUS_SUCCESS;
@@ -1548,7 +1548,7 @@ static u8 mgmt_le_support(struct hci_dev *hdev)
 {
 	if (!lmp_le_capable(hdev))
 		return MGMT_STATUS_NOT_SUPPORTED;
-	else if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+	else if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return MGMT_STATUS_REJECTED;
 	else
 		return MGMT_STATUS_SUCCESS;
@@ -1626,8 +1626,8 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
-	    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) &&
+	    !hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
 				       MGMT_STATUS_REJECTED);
 
@@ -1660,7 +1660,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags)) {
+	if (!hci_dev_test_flag(hdev, HCI_CONNECTABLE)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
 				      MGMT_STATUS_REJECTED);
 		goto failed;
@@ -1673,7 +1673,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * not a valid operation since it requires a timeout
 		 * and so no need to check HCI_LIMITED_DISCOVERABLE.
 		 */
-		if (!!cp->val != test_bit(HCI_DISCOVERABLE, &hdev->dev_flags)) {
+		if (!!cp->val != hci_dev_test_flag(hdev, HCI_DISCOVERABLE)) {
 			change_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
 			changed = true;
 		}
@@ -1692,9 +1692,9 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	 * value with the new value. And if only the timeout gets updated,
 	 * then no need for any HCI transactions.
 	 */
-	if (!!cp->val == test_bit(HCI_DISCOVERABLE, &hdev->dev_flags) &&
-	    (cp->val == 0x02) == test_bit(HCI_LIMITED_DISCOVERABLE,
-					  &hdev->dev_flags)) {
+	if (!!cp->val == hci_dev_test_flag(hdev, HCI_DISCOVERABLE) &&
+	    (cp->val == 0x02) == hci_dev_test_flag(hdev,
+						   HCI_LIMITED_DISCOVERABLE)) {
 		cancel_delayed_work(&hdev->discov_off);
 		hdev->discov_timeout = timeout;
 
@@ -1732,7 +1732,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	/* The procedure for LE-only controllers is much simpler - just
 	 * update the advertising data.
 	 */
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 		goto update_ad;
 
 	scan = SCAN_PAGE;
@@ -1785,7 +1785,7 @@ static void write_fast_connectable(struct hci_request *req, bool enable)
 	struct hci_cp_write_page_scan_activity acp;
 	u8 type;
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 		return;
 
 	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
@@ -1870,7 +1870,7 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 	bool changed = false;
 	int err;
 
-	if (!!val != test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+	if (!!val != hci_dev_test_flag(hdev, HCI_CONNECTABLE))
 		changed = true;
 
 	if (val) {
@@ -1904,8 +1904,8 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
-	    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) &&
+	    !hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
 				       MGMT_STATUS_REJECTED);
 
@@ -1939,7 +1939,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	 * by-product of disabling connectable, we need to update the
 	 * advertising flags.
 	 */
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
 		if (!cp->val) {
 			clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
 			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
@@ -1972,7 +1972,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 no_scan_update:
 	/* Update the advertising parameters if necessary */
-	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		enable_advertising(&req);
 
 	err = hci_req_run(&req, set_connectable_complete);
@@ -2045,8 +2045,7 @@ static int set_link_security(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (!hdev_is_powered(hdev)) {
 		bool changed = false;
 
-		if (!!cp->val != test_bit(HCI_LINK_SECURITY,
-					  &hdev->dev_flags)) {
+		if (!!cp->val != hci_dev_test_flag(hdev, HCI_LINK_SECURITY)) {
 			change_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
 			changed = true;
 		}
@@ -2146,7 +2145,7 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto failed;
 	}
 
-	if (!!cp->val == test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
+	if (!!cp->val == hci_dev_test_flag(hdev, HCI_SSP_ENABLED)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_SSP, hdev);
 		goto failed;
 	}
@@ -2157,7 +2156,7 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto failed;
 	}
 
-	if (!cp->val && test_bit(HCI_USE_DEBUG_KEYS, &hdev->dev_flags))
+	if (!cp->val && hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS))
 		hci_send_cmd(hdev, HCI_OP_WRITE_SSP_DEBUG_MODE,
 			     sizeof(cp->val), &cp->val);
 
@@ -2189,7 +2188,7 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
-	if (!test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
 				       MGMT_STATUS_REJECTED);
 
@@ -2255,7 +2254,7 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 	 * has actually been enabled. During power on, the
 	 * update in powered_update_hci will take care of it.
 	 */
-	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
 		struct hci_request req;
 
 		hci_req_init(&req, hdev);
@@ -2289,7 +2288,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 				       MGMT_STATUS_INVALID_PARAMS);
 
 	/* LE-only devices do not allow toggling LE on/off */
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
 				       MGMT_STATUS_REJECTED);
 
@@ -2301,12 +2300,12 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	if (!hdev_is_powered(hdev) || val == enabled) {
 		bool changed = false;
 
-		if (val != test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+		if (val != hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
 			change_bit(HCI_LE_ENABLED, &hdev->dev_flags);
 			changed = true;
 		}
 
-		if (!val && test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
+		if (!val && hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
 			clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
 			changed = true;
 		}
@@ -2342,7 +2341,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		hci_cp.le = val;
 		hci_cp.simul = 0x00;
 	} else {
-		if (test_bit(HCI_LE_ADV, &hdev->dev_flags))
+		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 			disable_advertising(&req);
 	}
 
@@ -3860,12 +3859,12 @@ static bool trigger_discovery(struct hci_request *req, u8 *status)
 			return false;
 
 		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
-		    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+		    !hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
 			*status = MGMT_STATUS_NOT_SUPPORTED;
 			return false;
 		}
 
-		if (test_bit(HCI_LE_ADV, &hdev->dev_flags)) {
+		if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
 			/* Don't let discovery abort an outgoing
 			 * connection attempt that's using directed
 			 * advertising.
@@ -3883,7 +3882,7 @@ static bool trigger_discovery(struct hci_request *req, u8 *status)
 		 * is running. Thus, we should temporarily stop it in order to
 		 * set the discovery scanning parameters.
 		 */
-		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
 			hci_req_add_le_scan_disable(req);
 
 		memset(&param_cp, 0, sizeof(param_cp));
@@ -4007,7 +4006,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	if (hdev->discovery.state != DISCOVERY_STOPPED ||
-	    test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
+	    hci_dev_test_flag(hdev, HCI_PERIODIC_INQ)) {
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 					MGMT_STATUS_BUSY, &cp->type,
 					sizeof(cp->type));
@@ -4083,7 +4082,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	if (hdev->discovery.state != DISCOVERY_STOPPED ||
-	    test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
+	    hci_dev_test_flag(hdev, HCI_PERIODIC_INQ)) {
 		err = mgmt_cmd_complete(sk, hdev->id,
 					MGMT_OP_START_SERVICE_DISCOVERY,
 					MGMT_STATUS_BUSY, &cp->type,
@@ -4410,7 +4409,7 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
 		goto unlock;
 	}
 
-	if (test_bit(HCI_LE_ADV, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 		set_bit(HCI_ADVERTISING, &hdev->dev_flags);
 	else
 		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
@@ -4457,11 +4456,10 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 	 * necessary).
 	 */
 	if (!hdev_is_powered(hdev) ||
-	    (val == test_bit(HCI_ADVERTISING, &hdev->dev_flags) &&
-	     (cp->val == 0x02) == test_bit(HCI_ADVERTISING_CONNECTABLE,
-					   &hdev->dev_flags)) ||
+	    (val == hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
+	     (cp->val == 0x02) == hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE)) ||
 	    hci_conn_num(hdev, LE_LINK) > 0 ||
-	    (test_bit(HCI_LE_SCAN, &hdev->dev_flags) &&
+	    (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
 	     hdev->le_scan_type == LE_SCAN_ACTIVE)) {
 		bool changed;
 
@@ -4609,7 +4607,7 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 	/* If background scan is running, restart it so new parameters are
 	 * loaded.
 	 */
-	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags) &&
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
 	    hdev->discovery.state == DISCOVERY_STOPPED) {
 		struct hci_request req;
 
@@ -4670,7 +4668,7 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) ||
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) ||
 	    hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 				       MGMT_STATUS_NOT_SUPPORTED);
@@ -4687,7 +4685,7 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (!!cp->val == test_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags)) {
+	if (!!cp->val == hci_dev_test_flag(hdev, HCI_FAST_CONNECTABLE)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_FAST_CONNECTABLE,
 					hdev);
 		goto unlock;
@@ -4770,7 +4768,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
-	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
 				       MGMT_STATUS_REJECTED);
 
@@ -4780,7 +4778,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	if (cp->val == test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+	if (cp->val == hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_BREDR, hdev);
 		goto unlock;
 	}
@@ -4824,9 +4822,9 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		 * switching BR/EDR back on when secure connections has been
 		 * enabled is not a supported transaction.
 		 */
-		if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
+		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
 		    (bacmp(&hdev->static_addr, BDADDR_ANY) ||
-		     test_bit(HCI_SC_ENABLED, &hdev->dev_flags))) {
+		     hci_dev_test_flag(hdev, HCI_SC_ENABLED))) {
 			err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
 					      MGMT_STATUS_REJECTED);
 			goto unlock;
@@ -4926,13 +4924,13 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 	BT_DBG("request for %s", hdev->name);
 
 	if (!lmp_sc_capable(hdev) &&
-	    !test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+	    !hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
-	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
+	if (hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
 	    lmp_sc_capable(hdev) &&
-	    !test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
+	    !hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				       MGMT_STATUS_REJECTED);
 
@@ -4943,7 +4941,7 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev) || !lmp_sc_capable(hdev) ||
-	    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+	    !hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
 		bool changed;
 
 		if (cp->val) {
@@ -4977,8 +4975,8 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 
 	val = !!cp->val;
 
-	if (val == test_bit(HCI_SC_ENABLED, &hdev->dev_flags) &&
-	    (cp->val == 0x02) == test_bit(HCI_SC_ONLY, &hdev->dev_flags)) {
+	if (val == hci_dev_test_flag(hdev, HCI_SC_ENABLED) &&
+	    (cp->val == 0x02) == hci_dev_test_flag(hdev, HCI_SC_ONLY)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_SECURE_CONN, hdev);
 		goto failed;
 	}
@@ -5032,7 +5030,7 @@ static int set_debug_keys(struct sock *sk, struct hci_dev *hdev,
 						 &hdev->dev_flags);
 
 	if (hdev_is_powered(hdev) && use_changed &&
-	    test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
+	    hci_dev_test_flag(hdev, HCI_SSP_ENABLED)) {
 		u8 mode = (cp->val == 0x02) ? 0x01 : 0x00;
 		hci_send_cmd(hdev, HCI_OP_WRITE_SSP_DEBUG_MODE,
 			     sizeof(mode), &mode);
@@ -6104,7 +6102,7 @@ static int set_external_config(struct sock *sk, struct hci_dev *hdev,
 
 	err = new_options(hdev, sk);
 
-	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) == is_configured(hdev)) {
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED) == is_configured(hdev)) {
 		mgmt_index_removed(hdev);
 
 		if (test_and_change_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
@@ -6156,7 +6154,7 @@ static int set_public_address(struct sock *sk, struct hci_dev *hdev,
 	if (!changed)
 		goto unlock;
 
-	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
 		err = new_options(hdev, sk);
 
 	if (is_configured(hdev)) {
@@ -6304,15 +6302,15 @@ int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
 			goto done;
 		}
 
-		if (test_bit(HCI_SETUP, &hdev->dev_flags) ||
-		    test_bit(HCI_CONFIG, &hdev->dev_flags) ||
-		    test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+		if (hci_dev_test_flag(hdev, HCI_SETUP) ||
+		    hci_dev_test_flag(hdev, HCI_CONFIG) ||
+		    hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 			err = mgmt_cmd_status(sk, index, opcode,
 					      MGMT_STATUS_INVALID_INDEX);
 			goto done;
 		}
 
-		if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
+		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
 		    !(handler->flags & HCI_MGMT_UNCONFIGURED)) {
 			err = mgmt_cmd_status(sk, index, opcode,
 					      MGMT_STATUS_INVALID_INDEX);
@@ -6362,7 +6360,7 @@ void mgmt_index_added(struct hci_dev *hdev)
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		return;
 
-	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
 		mgmt_event(MGMT_EV_UNCONF_INDEX_ADDED, hdev, NULL, 0, NULL);
 	else
 		mgmt_event(MGMT_EV_INDEX_ADDED, hdev, NULL, 0, NULL);
@@ -6380,7 +6378,7 @@ void mgmt_index_removed(struct hci_dev *hdev)
 
 	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
 
-	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
 		mgmt_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev, NULL, 0, NULL);
 	else
 		mgmt_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0, NULL);
@@ -6448,7 +6446,7 @@ static int powered_update_hci(struct hci_dev *hdev)
 
 	hci_req_init(&req, hdev);
 
-	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
+	if (hci_dev_test_flag(hdev, HCI_SSP_ENABLED) &&
 	    !lmp_host_ssp_capable(hdev)) {
 		u8 mode = 0x01;
 
@@ -6462,7 +6460,7 @@ static int powered_update_hci(struct hci_dev *hdev)
 		}
 	}
 
-	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
+	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED) &&
 	    lmp_bredr_capable(hdev)) {
 		struct hci_cp_write_le_host_supported cp;
 
@@ -6483,24 +6481,24 @@ static int powered_update_hci(struct hci_dev *hdev)
 		 * advertising data. This also applies to the case
 		 * where BR/EDR was toggled during the AUTO_OFF phase.
 		 */
-		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+		if (hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
 			update_adv_data(&req);
 			update_scan_rsp_data(&req);
 		}
 
-		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
 			enable_advertising(&req);
 
 		restart_le_actions(&req);
 	}
 
-	link_sec = test_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
+	link_sec = hci_dev_test_flag(hdev, HCI_LINK_SECURITY);
 	if (link_sec != test_bit(HCI_AUTH, &hdev->flags))
 		hci_req_add(&req, HCI_OP_WRITE_AUTH_ENABLE,
 			    sizeof(link_sec), &link_sec);
 
 	if (lmp_bredr_capable(hdev)) {
-		if (test_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags))
+		if (hci_dev_test_flag(hdev, HCI_FAST_CONNECTABLE))
 			write_fast_connectable(&req, true);
 		else
 			write_fast_connectable(&req, false);
@@ -6519,7 +6517,7 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 	u8 status, zero_cod[] = { 0, 0, 0 };
 	int err;
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_MGMT))
 		return 0;
 
 	if (powered) {
@@ -6540,7 +6538,7 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 	 * been triggered, potentially causing misleading DISCONNECTED
 	 * status responses.
 	 */
-	if (test_bit(HCI_UNREGISTER, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		status = MGMT_STATUS_INVALID_INDEX;
 	else
 		status = MGMT_STATUS_NOT_POWERED;
@@ -6594,7 +6592,7 @@ void mgmt_discoverable_timeout(struct hci_dev *hdev)
 	clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
 
 	hci_req_init(&req, hdev);
-	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
 		u8 scan = SCAN_PAGE;
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE,
 			    sizeof(scan), &scan);
@@ -7170,8 +7168,8 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 
 	hci_req_init(&req, hdev);
 
-	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
-		if (test_bit(HCI_USE_DEBUG_KEYS, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_SSP_ENABLED)) {
+		if (hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS))
 			hci_req_add(&req, HCI_OP_WRITE_SSP_DEBUG_MODE,
 				    sizeof(enable), &enable);
 		update_eir(&req);
@@ -7343,7 +7341,7 @@ static bool eir_has_uuids(u8 *eir, u16 eir_len, u16 uuid_count, u8 (*uuids)[16])
 static void restart_le_scan(struct hci_dev *hdev)
 {
 	/* If controller is not scanning we are done. */
-	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
 		return;
 
 	if (time_after(jiffies + DISCOV_LE_RESTART_DELAY,
@@ -7514,7 +7512,7 @@ void mgmt_reenable_advertising(struct hci_dev *hdev)
 {
 	struct hci_request req;
 
-	if (!test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return;
 
 	hci_req_init(&req, hdev);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index d6ef7e48c2c3..81975f274c2b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -52,7 +52,7 @@
 
 #define SMP_TIMEOUT	msecs_to_jiffies(30000)
 
-#define AUTH_REQ_MASK(dev)	(test_bit(HCI_SC_ENABLED, &(dev)->dev_flags) ? \
+#define AUTH_REQ_MASK(dev)	(hci_dev_test_flag(dev, HCI_SC_ENABLED) ? \
 				 0x1f : 0x07)
 #define KEY_DIST_MASK		0x07
 
@@ -589,7 +589,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	struct hci_dev *hdev = hcon->hdev;
 	u8 local_dist = 0, remote_dist = 0, oob_flag = SMP_OOB_NOT_PRESENT;
 
-	if (test_bit(HCI_BONDABLE, &conn->hcon->hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_BONDABLE)) {
 		local_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
 		remote_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
 		authreq |= SMP_AUTH_BONDING;
@@ -597,18 +597,18 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 		authreq &= ~SMP_AUTH_BONDING;
 	}
 
-	if (test_bit(HCI_RPA_RESOLVING, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_RPA_RESOLVING))
 		remote_dist |= SMP_DIST_ID_KEY;
 
-	if (test_bit(HCI_PRIVACY, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_PRIVACY))
 		local_dist |= SMP_DIST_ID_KEY;
 
-	if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags) &&
+	if (hci_dev_test_flag(hdev, HCI_SC_ENABLED) &&
 	    (authreq & SMP_AUTH_SC)) {
 		struct oob_data *oob_data;
 		u8 bdaddr_type;
 
-		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
+		if (hci_dev_test_flag(hdev, HCI_SSP_ENABLED)) {
 			local_dist |= SMP_DIST_LINK_KEY;
 			remote_dist |= SMP_DIST_LINK_KEY;
 		}
@@ -692,7 +692,7 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 	 * support hasn't been explicitly enabled.
 	 */
 	if (smp->ltk && smp->ltk->type == SMP_LTK_P256_DEBUG &&
-	    !test_bit(HCI_KEEP_DEBUG_KEYS, &hcon->hdev->dev_flags)) {
+	    !hci_dev_test_flag(hcon->hdev, HCI_KEEP_DEBUG_KEYS)) {
 		list_del_rcu(&smp->ltk->list);
 		kfree_rcu(smp->ltk, rcu);
 		smp->ltk = NULL;
@@ -1052,7 +1052,7 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 			/* Don't keep debug keys around if the relevant
 			 * flag is not set.
 			 */
-			if (!test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->dev_flags) &&
+			if (!hci_dev_test_flag(hdev, HCI_KEEP_DEBUG_KEYS) &&
 			    key->type == HCI_LK_DEBUG_COMBINATION) {
 				list_del_rcu(&key->list);
 				kfree_rcu(key, rcu);
@@ -1604,15 +1604,15 @@ static void build_bredr_pairing_cmd(struct smp_chan *smp,
 	struct hci_dev *hdev = conn->hcon->hdev;
 	u8 local_dist = 0, remote_dist = 0;
 
-	if (test_bit(HCI_BONDABLE, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_BONDABLE)) {
 		local_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
 		remote_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
 	}
 
-	if (test_bit(HCI_RPA_RESOLVING, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_RPA_RESOLVING))
 		remote_dist |= SMP_DIST_ID_KEY;
 
-	if (test_bit(HCI_PRIVACY, &hdev->dev_flags))
+	if (hci_dev_test_flag(hdev, HCI_PRIVACY))
 		local_dist |= SMP_DIST_ID_KEY;
 
 	if (!rsp) {
@@ -1664,11 +1664,11 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* We didn't start the pairing, so match remote */
 	auth = req->auth_req & AUTH_REQ_MASK(hdev);
 
-	if (!test_bit(HCI_BONDABLE, &hdev->dev_flags) &&
+	if (!hci_dev_test_flag(hdev, HCI_BONDABLE) &&
 	    (auth & SMP_AUTH_BONDING))
 		return SMP_PAIRING_NOTSUPP;
 
-	if (test_bit(HCI_SC_ONLY, &hdev->dev_flags) && !(auth & SMP_AUTH_SC))
+	if (hci_dev_test_flag(hdev, HCI_SC_ONLY) && !(auth & SMP_AUTH_SC))
 		return SMP_AUTH_REQUIREMENTS;
 
 	smp->preq[0] = SMP_CMD_PAIRING_REQ;
@@ -1761,7 +1761,7 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 
 	BT_DBG("");
 
-	if (test_bit(HCI_USE_DEBUG_KEYS, &hdev->dev_flags)) {
+	if (hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS)) {
 		BT_DBG("Using debug keys");
 		memcpy(smp->local_pk, debug_pk, 64);
 		memcpy(smp->local_sk, debug_sk, 32);
@@ -1816,7 +1816,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	auth = rsp->auth_req & AUTH_REQ_MASK(hdev);
 
-	if (test_bit(HCI_SC_ONLY, &hdev->dev_flags) && !(auth & SMP_AUTH_SC))
+	if (hci_dev_test_flag(hdev, HCI_SC_ONLY) && !(auth & SMP_AUTH_SC))
 		return SMP_AUTH_REQUIREMENTS;
 
 	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
@@ -2086,7 +2086,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	auth = rp->auth_req & AUTH_REQ_MASK(hdev);
 
-	if (test_bit(HCI_SC_ONLY, &hdev->dev_flags) && !(auth & SMP_AUTH_SC))
+	if (hci_dev_test_flag(hdev, HCI_SC_ONLY) && !(auth & SMP_AUTH_SC))
 		return SMP_AUTH_REQUIREMENTS;
 
 	if (hcon->io_capability == HCI_IO_NO_INPUT_OUTPUT)
@@ -2107,7 +2107,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!smp)
 		return SMP_UNSPECIFIED;
 
-	if (!test_bit(HCI_BONDABLE, &hcon->hdev->dev_flags) &&
+	if (!hci_dev_test_flag(hdev, HCI_BONDABLE) &&
 	    (auth & SMP_AUTH_BONDING))
 		return SMP_PAIRING_NOTSUPP;
 
@@ -2141,7 +2141,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 
 	chan = conn->smp;
 
-	if (!test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags))
+	if (!hci_dev_test_flag(hcon->hdev, HCI_LE_ENABLED))
 		return 1;
 
 	if (smp_sufficient_security(hcon, sec_level, SMP_USE_LTK))
@@ -2170,7 +2170,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 
 	authreq = seclevel_to_authreq(sec_level);
 
-	if (test_bit(HCI_SC_ENABLED, &hcon->hdev->dev_flags))
+	if (hci_dev_test_flag(hcon->hdev, HCI_SC_ENABLED))
 		authreq |= SMP_AUTH_SC;
 
 	/* Require MITM if IO Capability allows or the security level
@@ -2606,7 +2606,7 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 	if (skb->len < 1)
 		return -EILSEQ;
 
-	if (!test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags)) {
+	if (!hci_dev_test_flag(hcon->hdev, HCI_LE_ENABLED)) {
 		reason = SMP_PAIRING_NOTSUPP;
 		goto done;
 	}
@@ -2744,7 +2744,7 @@ static void bredr_pairing(struct l2cap_chan *chan)
 		return;
 
 	/* Secure Connections support must be enabled */
-	if (!test_bit(HCI_SC_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_SC_ENABLED))
 		return;
 
 	/* BR/EDR must use Secure Connections for SMP */
@@ -2753,7 +2753,7 @@ static void bredr_pairing(struct l2cap_chan *chan)
 		return;
 
 	/* If our LE support is not enabled don't do anything */
-	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return;
 
 	/* Don't bother if remote LE support is not enabled */
-- 
2.1.0

