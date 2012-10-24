Return-Path: <cyrus@holtmann.org>
From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [RFC 9/9] Bluetooth: Add set observer MGMT command
Date: Wed, 24 Oct 2012 12:58:15 -0300
Message-Id: <1351094295-10418-10-git-send-email-aloisio.almeida@openbossa.org>
In-Reply-To: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
References: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command will enable or disable observer mode.

If LE_ENABLED is set the HCI_OP_LE_SET_SCAN_PARAMS and HCI_OP_LE_SET_SCAN_ENABLE
commands will be sent. Observer will perform a passive scan with no timeout.

If discovery is required when observer is enabled, le scan is restarted in
active mode.

If observer is enabled when discovery finishes, passive le scan
is enabled.

If observer mode is required when discovery is on going, the le scan mode does
not change until the end of discovery process.

This command is available on the powered off state.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    5 ++
 include/net/bluetooth/mgmt.h     |    3 +
 net/bluetooth/hci_core.c         |   18 ++++-
 net/bluetooth/hci_event.c        |   50 ++++++------
 net/bluetooth/mgmt.c             |  165 ++++++++++++++++++++++++++++++++++----
 6 files changed, 201 insertions(+), 41 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 591450c..78538c0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -121,6 +121,7 @@ enum {
 	HCI_PENDING_CLASS,
 	HCI_PERIODIC_INQ,
 	HCI_BROADCASTER,
+	HCI_OBSERVER,
 };
 
 /* HCI ioctl defines */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6ef8660..f6bab83 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -55,6 +55,8 @@ struct inquiry_entry {
 	struct inquiry_data	data;
 };
 
+#define hdev_is_in_discovery(hdev) (hdev->discovery.state != DISCOVERY_STOPPED)
+
 struct discovery_state {
 	int			type;
 	enum {
@@ -133,7 +135,9 @@ struct controller_data {
 };
 
 enum {
+	LE_SCAN_REQ_REASON_RESET,
 	LE_SCAN_REQ_REASON_DISCOVERY,
+	LE_SCAN_REQ_REASON_OBSERVER,
 };
 
 #define HCI_MAX_SHORT_NAME_LENGTH	10
@@ -1095,6 +1099,7 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 					    u8 *randomizer, u8 status);
 int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 int mgmt_set_broadcaster_complete(struct hci_dev *hdev, u8 enable, u8 status);
+int mgmt_set_observer_complete(struct hci_dev *hdev, u8 enable, u8 status);
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
 		      u8 ssp, u8 *eir, u16 eir_len);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index bd64816..13936ab 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -93,6 +93,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_HS			0x00000100
 #define MGMT_SETTING_LE			0x00000200
 #define MGMT_SETTING_BROADCASTER	0x00000400
+#define MGMT_SETTING_OBSERVER		0x00000800
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -368,6 +369,8 @@ struct mgmt_cp_unset_controller_data {
 
 #define MGMT_OP_SET_BROADCASTER		0x002B
 
+#define MGMT_OP_SET_OBSERVER		0x002C
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fbf0ba1..1482681 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1556,14 +1556,28 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
 
 	BT_DBG("%s", hdev->name);
 
-	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags) &&
+	    reason == LE_SCAN_REQ_REASON_OBSERVER)
 		return -EINPROGRESS;
 
+	memset(&cp, 0, sizeof(cp));
+
+	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags) &&
+	    reason == LE_SCAN_REQ_REASON_DISCOVERY) {
+		hci_dev_lock(hdev);
+		hdev->le_scan_req_reason = LE_SCAN_REQ_REASON_RESET;
+		hci_dev_unlock(hdev);
+
+		err = hci_request(hdev, le_scan_enable_req, (unsigned long) &cp,
+				  timeo);
+		if (err)
+			return err;
+	}
+
 	param.type = type;
 	param.interval = interval;
 	param.window = window;
 
-	memset(&cp, 0, sizeof(cp));
 	cp.enable = 1;
 	if (reason == LE_SCAN_REQ_REASON_DISCOVERY)
 		cp.filter_dup = 1;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7ad2b0d..f31b694 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1212,42 +1212,42 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	if (!cp)
 		return;
 
-	switch (cp->enable) {
-	case LE_SCANNING_ENABLED:
-		hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_ENABLE, status);
+	hci_dev_lock(hdev);
 
-		if (status) {
-			hci_dev_lock(hdev);
-			mgmt_start_discovery_failed(hdev, status);
-			hci_dev_unlock(hdev);
-			return;
-		}
+	if (!status) {
+		if (cp->enable)
+			set_bit(HCI_LE_SCAN, &hdev->dev_flags);
+		else
+			clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
+	}
 
-		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
+	if (hdev->le_scan_req_reason == LE_SCAN_REQ_REASON_RESET)
+		goto unlock;
 
-		hci_dev_lock(hdev);
-		hci_discovery_set_state(hdev, DISCOVERY_FINDING);
-		hci_dev_unlock(hdev);
+	if (hdev->le_scan_req_reason == LE_SCAN_REQ_REASON_OBSERVER) {
+		mgmt_set_observer_complete(hdev, cp->enable, status);
+		goto unlock;
+	}
+
+	switch (cp->enable) {
+	case LE_SCANNING_ENABLED:
+		if (status)
+			mgmt_start_discovery_failed(hdev, status);
+		else
+			hci_discovery_set_state(hdev, DISCOVERY_FINDING);
 		break;
 
 	case LE_SCANNING_DISABLED:
 		if (status) {
-			hci_dev_lock(hdev);
 			mgmt_stop_discovery_failed(hdev, status);
-			hci_dev_unlock(hdev);
-			return;
+			goto unlock;
 		}
 
-		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
-
 		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
-		    hdev->discovery.state == DISCOVERY_FINDING) {
+		    hdev->discovery.state == DISCOVERY_FINDING)
 			mgmt_interleaved_discovery(hdev);
-		} else {
-			hci_dev_lock(hdev);
+		else
 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-			hci_dev_unlock(hdev);
-		}
 
 		break;
 
@@ -1255,6 +1255,10 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		BT_ERR("Used reserved LE_Scan_Enable param %d", cp->enable);
 		break;
 	}
+
+unlock:
+	hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_ENABLE, status);
+	hci_dev_unlock(hdev);
 }
 
 static void hci_cc_le_ltk_reply(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 46a45e7..bd7b238 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -106,11 +106,13 @@ static const u16 mgmt_events[] = {
  * These LE scan and inquiry parameters were chosen according to LE General
  * Discovery Procedure specification.
  */
-#define LE_SCAN_TYPE			0x01
+#define LE_SCAN_TYPE_PASSIVE		0x00
+#define LE_SCAN_TYPE_ACTIVE		0x01
 #define LE_SCAN_WIN			0x12
 #define LE_SCAN_INT			0x12
 #define LE_SCAN_TIMEOUT_LE_ONLY		10240	/* TGAP(gen_disc_scan_min) */
 #define LE_SCAN_TIMEOUT_BREDR_LE	5120	/* TGAP(100)/2 */
+#define LE_SCAN_NO_TIMEOUT		-1	/* Observer role */
 
 #define INQUIRY_LEN_BREDR		0x08	/* TGAP(100) */
 #define INQUIRY_LEN_BREDR_LE		0x04	/* TGAP(100)/2 */
@@ -381,6 +383,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	settings |= MGMT_SETTING_DISCOVERABLE;
 	settings |= MGMT_SETTING_PAIRABLE;
 	settings |= MGMT_SETTING_BROADCASTER;
+	settings |= MGMT_SETTING_OBSERVER;
 
 	if (lmp_ssp_capable(hdev))
 		settings |= MGMT_SETTING_SSP;
@@ -424,6 +427,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_BROADCASTER, &hdev->dev_flags))
 		settings |= MGMT_SETTING_BROADCASTER;
 
+	if (test_bit(HCI_OBSERVER, &hdev->dev_flags))
+		settings |= MGMT_SETTING_OBSERVER;
+
 	if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags))
 		settings |= MGMT_SETTING_LINK_SECURITY;
 
@@ -2305,14 +2311,10 @@ int mgmt_interleaved_discovery(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	hci_dev_lock(hdev);
-
 	err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR_LE);
 	if (err < 0)
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 
-	hci_dev_unlock(hdev);
-
 	return err;
 }
 
@@ -2339,7 +2341,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	if (hdev->discovery.state != DISCOVERY_STOPPED) {
+	if (hdev_is_in_discovery(hdev)) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 				 MGMT_STATUS_BUSY);
 		goto failed;
@@ -2363,8 +2365,9 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	case DISCOV_TYPE_LE:
 		if (lmp_host_le_capable(hdev))
-			err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
-					  LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY,
+			err = hci_le_scan(hdev, LE_SCAN_TYPE_ACTIVE,
+					  LE_SCAN_INT, LE_SCAN_WIN,
+					  LE_SCAN_TIMEOUT_LE_ONLY,
 					  LE_SCAN_REQ_REASON_DISCOVERY);
 		else
 			err = -ENOTSUPP;
@@ -2372,8 +2375,9 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	case DISCOV_TYPE_INTERLEAVED:
 		if (lmp_host_le_capable(hdev) && lmp_bredr_capable(hdev))
-			err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
-					  LE_SCAN_WIN, LE_SCAN_TIMEOUT_BREDR_LE,
+			err = hci_le_scan(hdev, LE_SCAN_TYPE_ACTIVE,
+					  LE_SCAN_INT, LE_SCAN_WIN,
+					  LE_SCAN_TIMEOUT_BREDR_LE,
 					  LE_SCAN_REQ_REASON_DISCOVERY);
 		else
 			err = -ENOTSUPP;
@@ -2850,6 +2854,89 @@ static int set_broadcaster(struct sock *sk, struct hci_dev *hdev, void *data,
 	return set_broadcaster_le(sk, hdev, cp->val);
 }
 
+static int set_observer_le(struct sock *sk, struct hci_dev *hdev, u8 enable)
+{
+	struct pending_cmd *cmd;
+	int err;
+
+	BT_DBG("%s enable:%i", hdev->name, enable);
+
+	hci_dev_lock(hdev);
+
+	if (!hdev_is_powered(hdev)) {
+		bool changed = false;
+
+		if (enable != test_bit(HCI_OBSERVER, &hdev->dev_flags)) {
+			change_bit(HCI_OBSERVER, &hdev->dev_flags);
+			changed = true;
+		}
+
+		err = send_settings_rsp(sk, MGMT_OP_SET_OBSERVER, hdev);
+		if (err < 0)
+			goto unlock;
+
+		if (changed)
+			err = new_settings(hdev, sk);
+
+		goto unlock;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_SET_OBSERVER, hdev)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_OBSERVER,
+				 MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	if (enable == test_bit(HCI_OBSERVER, &hdev->dev_flags)) {
+		err = send_settings_rsp(sk, MGMT_OP_SET_OBSERVER, hdev);
+		goto unlock;
+	}
+
+	if (hdev_is_in_discovery(hdev)) {
+		change_bit(HCI_OBSERVER, &hdev->dev_flags);
+		err = send_settings_rsp(sk, MGMT_OP_SET_OBSERVER, hdev);
+		if (err < 0)
+			goto unlock;
+
+		err = new_settings(hdev, sk);
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_OBSERVER, hdev, NULL, 0);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	if (enable)
+		err = hci_le_scan(hdev, LE_SCAN_TYPE_PASSIVE, LE_SCAN_INT,
+				  LE_SCAN_WIN, LE_SCAN_NO_TIMEOUT,
+				  LE_SCAN_REQ_REASON_OBSERVER);
+	else
+		err = hci_cancel_le_scan(hdev, LE_SCAN_REQ_REASON_OBSERVER);
+
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
+static int set_observer(struct sock *sk, struct hci_dev *hdev, void *data,
+			u16 len)
+{
+	struct mgmt_mode *cp = data;
+
+	BT_DBG("%s val:%i", hdev->name, cp->val);
+
+	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_OBSERVER,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	return set_observer_le(sk, hdev, cp->val);
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -2900,6 +2987,7 @@ static const struct mgmt_handler {
 	{ set_controller_data,    true,  MGMT_SET_CONTROLLER_DATA_SIZE },
 	{ unset_controller_data,  false, MGMT_UNSET_CONTROLLER_DATA_SIZE },
 	{ set_broadcaster,        false, MGMT_SETTING_SIZE },
+	{ set_observer,           false, MGMT_SETTING_SIZE },
 };
 
 
@@ -3080,14 +3168,19 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 		update_name(hdev, hdev->dev_name);
 		update_eir(hdev);
 
-		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
 			update_adv_data(hdev);
 
-		if (test_bit(HCI_BROADCASTER, &hdev->dev_flags) &&
-		    test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
-			u8 enable = 1;
-			hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
-				     sizeof(enable), &enable);
+			if (test_bit(HCI_BROADCASTER, &hdev->dev_flags)) {
+				u8 enable = 1;
+				hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+					     sizeof(enable), &enable);
+			} else if (test_bit(HCI_OBSERVER, &hdev->dev_flags)) {
+				hci_le_scan(hdev, LE_SCAN_TYPE_PASSIVE,
+					  LE_SCAN_INT,
+					  LE_SCAN_WIN, LE_SCAN_NO_TIMEOUT,
+					  LE_SCAN_REQ_REASON_OBSERVER);
+			}
 		}
 
 	} else {
@@ -3782,6 +3875,41 @@ int mgmt_set_broadcaster_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	return err;
 }
 
+int mgmt_set_observer_complete(struct hci_dev *hdev, u8 enable, u8 status)
+{
+	struct cmd_lookup match = { NULL, hdev };
+	bool changed = false;
+	int err = 0;
+
+	if (status) {
+		u8 mgmt_err = mgmt_status(status);
+
+		mgmt_pending_foreach(MGMT_OP_SET_OBSERVER, hdev,
+				     cmd_status_rsp, &mgmt_err);
+
+		return err;
+	}
+
+	if (enable) {
+		if (!test_and_set_bit(HCI_OBSERVER, &hdev->dev_flags))
+			changed = true;
+	} else {
+		if (test_and_clear_bit(HCI_OBSERVER, &hdev->dev_flags))
+			changed = true;
+	}
+
+	mgmt_pending_foreach(MGMT_OP_SET_OBSERVER, hdev, settings_rsp,
+			     &match);
+
+	if (changed)
+		err = new_settings(hdev, match.sk);
+
+	if (match.sk)
+		sock_put(match.sk);
+
+	return err;
+}
+
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name, u8
 		      ssp, u8 *eir, u16 eir_len)
@@ -3898,6 +4026,11 @@ int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 		mgmt_pending_remove(cmd);
 	}
 
+	if (!discovering && test_bit(HCI_OBSERVER, &hdev->dev_flags))
+		hci_le_scan(hdev, LE_SCAN_TYPE_PASSIVE, LE_SCAN_INT,
+			    LE_SCAN_WIN, LE_SCAN_NO_TIMEOUT,
+			    LE_SCAN_REQ_REASON_OBSERVER);
+
 	memset(&ev, 0, sizeof(ev));
 	ev.type = hdev->discovery.type;
 	ev.discovering = discovering;
-- 
1.7.10.4

