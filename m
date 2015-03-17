Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: Add channel parameter to mgmt_pending_find() API
Date: Tue, 17 Mar 2015 13:48:47 +0200
Message-Id: <1426592930-5842-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1426592930-5842-1-git-send-email-johan.hedberg@gmail.com>
References: <1426592930-5842-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To be able to have pending commands for different HCI channels we need
to be able to distinguish for which channel a command was sent to. The
channel information is already part of the socket data and can be
fetched using the recently added hci_sock_get_channel() function. To not
require all mgmt.c code to pass an extra channel parameter this patch
also adds a helper pending_find() & pending_find_data() functions which
act as a wrapper to the new mgmt_pending_find() & mgmt_pending_find_data()
APIs.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 108 +++++++++++++++++++++++++++++----------------------
 1 file changed, 62 insertions(+), 46 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 72e41d29e301..76e0f0300195 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -882,12 +882,15 @@ static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
 	return ptr;
 }
 
-static struct mgmt_pending_cmd *mgmt_pending_find(u16 opcode,
+static struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel,
+						  u16 opcode,
 						  struct hci_dev *hdev)
 {
 	struct mgmt_pending_cmd *cmd;
 
 	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+		if (hci_sock_get_channel(cmd->sk) != channel)
+			continue;
 		if (cmd->opcode == opcode)
 			return cmd;
 	}
@@ -895,7 +898,13 @@ static struct mgmt_pending_cmd *mgmt_pending_find(u16 opcode,
 	return NULL;
 }
 
-static struct mgmt_pending_cmd *mgmt_pending_find_data(u16 opcode,
+static struct mgmt_pending_cmd *pending_find(u16 opcode, struct hci_dev *hdev)
+{
+	return mgmt_pending_find(HCI_CHANNEL_CONTROL, opcode, hdev);
+}
+
+static struct mgmt_pending_cmd *mgmt_pending_find_data(unsigned short channel,
+						       u16 opcode,
 						       struct hci_dev *hdev,
 						       const void *data)
 {
@@ -911,6 +920,13 @@ static struct mgmt_pending_cmd *mgmt_pending_find_data(u16 opcode,
 	return NULL;
 }
 
+static struct mgmt_pending_cmd *pending_find_data(u16 opcode,
+						  struct hci_dev *hdev,
+						  const void *data)
+{
+	return mgmt_pending_find_data(HCI_CHANNEL_CONTROL, opcode, hdev, data);
+}
+
 static u8 create_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
 {
 	u8 ad_len = 0;
@@ -969,7 +985,7 @@ static u8 get_adv_discov_flags(struct hci_dev *hdev)
 	/* If there's a pending mgmt command the flags will not yet have
 	 * their final values, so check for this first.
 	 */
-	cmd = mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev);
+	cmd = pending_find(MGMT_OP_SET_DISCOVERABLE, hdev);
 	if (cmd) {
 		struct mgmt_mode *cp = cmd->param;
 		if (cp->val == 0x01)
@@ -1177,7 +1193,7 @@ static bool get_connectable(struct hci_dev *hdev)
 	/* If there's a pending mgmt command the flag will not yet have
 	 * it's final value, so check for this first.
 	 */
-	cmd = mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
+	cmd = pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
 	if (cmd) {
 		struct mgmt_mode *cp = cmd->param;
 		return cp->val;
@@ -1516,7 +1532,7 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	if (mgmt_pending_find(MGMT_OP_SET_POWERED, hdev)) {
+	if (pending_find(MGMT_OP_SET_POWERED, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
 				      MGMT_STATUS_BUSY);
 		goto failed;
@@ -1668,7 +1684,7 @@ static void set_discoverable_complete(struct hci_dev *hdev, u8 status,
 
 	hci_dev_lock(hdev);
 
-	cmd = mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev);
+	cmd = pending_find(MGMT_OP_SET_DISCOVERABLE, hdev);
 	if (!cmd)
 		goto unlock;
 
@@ -1753,8 +1769,8 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev) ||
-	    mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
+	if (pending_find(MGMT_OP_SET_DISCOVERABLE, hdev) ||
+	    pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
 				      MGMT_STATUS_BUSY);
 		goto failed;
@@ -1925,7 +1941,7 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status,
 
 	hci_dev_lock(hdev);
 
-	cmd = mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
+	cmd = pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
 	if (!cmd)
 		goto unlock;
 
@@ -2020,8 +2036,8 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev) ||
-	    mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
+	if (pending_find(MGMT_OP_SET_DISCOVERABLE, hdev) ||
+	    pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
 				      MGMT_STATUS_BUSY);
 		goto failed;
@@ -2160,7 +2176,7 @@ static int set_link_security(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_LINK_SECURITY, hdev)) {
+	if (pending_find(MGMT_OP_SET_LINK_SECURITY, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
 				      MGMT_STATUS_BUSY);
 		goto failed;
@@ -2239,7 +2255,7 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev)) {
+	if (pending_find(MGMT_OP_SET_SSP, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
 				      MGMT_STATUS_BUSY);
 		goto failed;
@@ -2298,7 +2314,7 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev)) {
+	if (pending_find(MGMT_OP_SET_SSP, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
 				      MGMT_STATUS_BUSY);
 		goto unlock;
@@ -2420,8 +2436,8 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto unlock;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_LE, hdev) ||
-	    mgmt_pending_find(MGMT_OP_SET_ADVERTISING, hdev)) {
+	if (pending_find(MGMT_OP_SET_LE, hdev) ||
+	    pending_find(MGMT_OP_SET_ADVERTISING, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
 				      MGMT_STATUS_BUSY);
 		goto unlock;
@@ -2505,7 +2521,7 @@ static void mgmt_class_complete(struct hci_dev *hdev, u16 mgmt_op, u8 status)
 
 	hci_dev_lock(hdev);
 
-	cmd = mgmt_pending_find(mgmt_op, hdev);
+	cmd = pending_find(mgmt_op, hdev);
 	if (!cmd)
 		goto unlock;
 
@@ -2999,7 +3015,7 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_DISCONNECT, hdev)) {
+	if (pending_find(MGMT_OP_DISCONNECT, hdev)) {
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
 					MGMT_STATUS_BUSY, &rp, sizeof(rp));
 		goto failed;
@@ -3463,7 +3479,7 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_find(MGMT_OP_PAIR_DEVICE, hdev);
+	cmd = pending_find(MGMT_OP_PAIR_DEVICE, hdev);
 	if (!cmd) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
 				      MGMT_STATUS_INVALID_PARAMS);
@@ -3641,7 +3657,7 @@ static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 	hci_dev_lock(hdev);
 
-	cmd = mgmt_pending_find(MGMT_OP_SET_LOCAL_NAME, hdev);
+	cmd = pending_find(MGMT_OP_SET_LOCAL_NAME, hdev);
 	if (!cmd)
 		goto unlock;
 
@@ -3751,7 +3767,7 @@ static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev)) {
+	if (pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
 				      MGMT_STATUS_BUSY);
 		goto unlock;
@@ -4028,9 +4044,9 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status,
 
 	hci_dev_lock(hdev);
 
-	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
+	cmd = pending_find(MGMT_OP_START_DISCOVERY, hdev);
 	if (!cmd)
-		cmd = mgmt_pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev);
+		cmd = pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev);
 
 	if (cmd) {
 		cmd->cmd_complete(cmd, mgmt_status(status));
@@ -4274,7 +4290,7 @@ static void stop_discovery_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 	hci_dev_lock(hdev);
 
-	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
+	cmd = pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
 	if (cmd) {
 		cmd->cmd_complete(cmd, mgmt_status(status));
 		mgmt_pending_remove(cmd);
@@ -4583,8 +4599,8 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_ADVERTISING, hdev) ||
-	    mgmt_pending_find(MGMT_OP_SET_LE, hdev)) {
+	if (pending_find(MGMT_OP_SET_ADVERTISING, hdev) ||
+	    pending_find(MGMT_OP_SET_LE, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
 				      MGMT_STATUS_BUSY);
 		goto unlock;
@@ -4727,7 +4743,7 @@ static void fast_connectable_complete(struct hci_dev *hdev, u8 status,
 
 	hci_dev_lock(hdev);
 
-	cmd = mgmt_pending_find(MGMT_OP_SET_FAST_CONNECTABLE, hdev);
+	cmd = pending_find(MGMT_OP_SET_FAST_CONNECTABLE, hdev);
 	if (!cmd)
 		goto unlock;
 
@@ -4773,7 +4789,7 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (mgmt_pending_find(MGMT_OP_SET_FAST_CONNECTABLE, hdev)) {
+	if (pending_find(MGMT_OP_SET_FAST_CONNECTABLE, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 				      MGMT_STATUS_BUSY);
 		goto unlock;
@@ -4825,7 +4841,7 @@ static void set_bredr_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 	hci_dev_lock(hdev);
 
-	cmd = mgmt_pending_find(MGMT_OP_SET_BREDR, hdev);
+	cmd = pending_find(MGMT_OP_SET_BREDR, hdev);
 	if (!cmd)
 		goto unlock;
 
@@ -4925,7 +4941,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		}
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_BREDR, hdev)) {
+	if (pending_find(MGMT_OP_SET_BREDR, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
 				      MGMT_STATUS_BUSY);
 		goto unlock;
@@ -4970,7 +4986,7 @@ static void sc_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 	hci_dev_lock(hdev);
 
-	cmd = mgmt_pending_find(MGMT_OP_SET_SECURE_CONN, hdev);
+	cmd = pending_find(MGMT_OP_SET_SECURE_CONN, hdev);
 	if (!cmd)
 		goto unlock;
 
@@ -5061,7 +5077,7 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_SECURE_CONN, hdev)) {
+	if (pending_find(MGMT_OP_SET_SECURE_CONN, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				      MGMT_STATUS_BUSY);
 		goto failed;
@@ -5454,7 +5470,7 @@ static void conn_info_refresh_complete(struct hci_dev *hdev, u8 hci_status,
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_find_data(MGMT_OP_GET_CONN_INFO, hdev, conn);
+	cmd = pending_find_data(MGMT_OP_GET_CONN_INFO, hdev, conn);
 	if (!cmd)
 		goto unlock;
 
@@ -5507,7 +5523,7 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	if (mgmt_pending_find_data(MGMT_OP_GET_CONN_INFO, hdev, conn)) {
+	if (pending_find_data(MGMT_OP_GET_CONN_INFO, hdev, conn)) {
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
 					MGMT_STATUS_BUSY, &rp, sizeof(rp));
 		goto unlock;
@@ -5643,7 +5659,7 @@ static void get_clock_info_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 		conn = NULL;
 	}
 
-	cmd = mgmt_pending_find_data(MGMT_OP_GET_CLOCK_INFO, hdev, conn);
+	cmd = pending_find_data(MGMT_OP_GET_CLOCK_INFO, hdev, conn);
 	if (!cmd)
 		goto unlock;
 
@@ -5809,7 +5825,7 @@ static void add_device_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 	hci_dev_lock(hdev);
 
-	cmd = mgmt_pending_find(MGMT_OP_ADD_DEVICE, hdev);
+	cmd = pending_find(MGMT_OP_ADD_DEVICE, hdev);
 	if (!cmd)
 		goto unlock;
 
@@ -5932,7 +5948,7 @@ static void remove_device_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 	hci_dev_lock(hdev);
 
-	cmd = mgmt_pending_find(MGMT_OP_REMOVE_DEVICE, hdev);
+	cmd = pending_find(MGMT_OP_REMOVE_DEVICE, hdev);
 	if (!cmd)
 		goto unlock;
 
@@ -6889,7 +6905,7 @@ void mgmt_set_powered_failed(struct hci_dev *hdev, int err)
 	struct mgmt_pending_cmd *cmd;
 	u8 status;
 
-	cmd = mgmt_pending_find(MGMT_OP_SET_POWERED, hdev);
+	cmd = pending_find(MGMT_OP_SET_POWERED, hdev);
 	if (!cmd)
 		return;
 
@@ -7154,7 +7170,7 @@ bool mgmt_powering_down(struct hci_dev *hdev)
 	struct mgmt_pending_cmd *cmd;
 	struct mgmt_mode *cp;
 
-	cmd = mgmt_pending_find(MGMT_OP_SET_POWERED, hdev);
+	cmd = pending_find(MGMT_OP_SET_POWERED, hdev);
 	if (!cmd)
 		return false;
 
@@ -7211,7 +7227,7 @@ void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
 			     hdev);
 
-	cmd = mgmt_pending_find(MGMT_OP_DISCONNECT, hdev);
+	cmd = pending_find(MGMT_OP_DISCONNECT, hdev);
 	if (!cmd)
 		return;
 
@@ -7263,7 +7279,7 @@ void mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct mgmt_pending_cmd *cmd;
 
-	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_REPLY, hdev);
+	cmd = pending_find(MGMT_OP_PIN_CODE_REPLY, hdev);
 	if (!cmd)
 		return;
 
@@ -7276,7 +7292,7 @@ void mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct mgmt_pending_cmd *cmd;
 
-	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_NEG_REPLY, hdev);
+	cmd = pending_find(MGMT_OP_PIN_CODE_NEG_REPLY, hdev);
 	if (!cmd)
 		return;
 
@@ -7321,7 +7337,7 @@ static int user_pairing_resp_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct mgmt_pending_cmd *cmd;
 
-	cmd = mgmt_pending_find(opcode, hdev);
+	cmd = pending_find(opcode, hdev);
 	if (!cmd)
 		return -ENOENT;
 
@@ -7532,14 +7548,14 @@ void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 	memcpy(ev.name, name, HCI_MAX_NAME_LENGTH);
 	memcpy(ev.short_name, hdev->short_name, HCI_MAX_SHORT_NAME_LENGTH);
 
-	cmd = mgmt_pending_find(MGMT_OP_SET_LOCAL_NAME, hdev);
+	cmd = pending_find(MGMT_OP_SET_LOCAL_NAME, hdev);
 	if (!cmd) {
 		memcpy(hdev->dev_name, name, sizeof(hdev->dev_name));
 
 		/* If this is a HCI command related to powering on the
 		 * HCI dev don't send any mgmt signals.
 		 */
-		if (mgmt_pending_find(MGMT_OP_SET_POWERED, hdev))
+		if (pending_find(MGMT_OP_SET_POWERED, hdev))
 			return;
 	}
 
@@ -7555,7 +7571,7 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 
 	BT_DBG("%s status %u", hdev->name, status);
 
-	cmd = mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev);
+	cmd = pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev);
 	if (!cmd)
 		return;
 
-- 
2.1.0

