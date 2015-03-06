Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 6/7] Bluetooth: Rename pending_cmd to mgmt_pending_cmd
Date: Fri,  6 Mar 2015 21:08:55 +0200
Message-Id: <1425668936-23234-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1425668936-23234-1-git-send-email-johan.hedberg@gmail.com>
References: <1425668936-23234-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch renames the pending_cmd struct (used for tracking pending mgmt
commands) to mgmt_pending_cmd, so that it can be moved to a more generic
place and be used also by other modules using other HCI channels.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 176 ++++++++++++++++++++++++++-------------------------
 1 file changed, 89 insertions(+), 87 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 835a459531ab..62c23927684f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -135,7 +135,7 @@ static const u16 mgmt_events[] = {
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
 
-struct pending_cmd {
+struct mgmt_pending_cmd {
 	struct list_head list;
 	u16 opcode;
 	int index;
@@ -143,7 +143,7 @@ struct pending_cmd {
 	size_t param_len;
 	struct sock *sk;
 	void *user_data;
-	int (*cmd_complete)(struct pending_cmd *cmd, u8 status);
+	int (*cmd_complete)(struct mgmt_pending_cmd *cmd, u8 status);
 };
 
 /* HCI to MGMT error code conversion table */
@@ -771,9 +771,10 @@ static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
 	return ptr;
 }
 
-static struct pending_cmd *mgmt_pending_find(u16 opcode, struct hci_dev *hdev)
+static struct mgmt_pending_cmd *mgmt_pending_find(u16 opcode,
+						  struct hci_dev *hdev)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
 		if (cmd->opcode == opcode)
@@ -783,11 +784,11 @@ static struct pending_cmd *mgmt_pending_find(u16 opcode, struct hci_dev *hdev)
 	return NULL;
 }
 
-static struct pending_cmd *mgmt_pending_find_data(u16 opcode,
-						  struct hci_dev *hdev,
-						  const void *data)
+static struct mgmt_pending_cmd *mgmt_pending_find_data(u16 opcode,
+						       struct hci_dev *hdev,
+						       const void *data)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
 		if (cmd->user_data != data)
@@ -852,7 +853,7 @@ static void update_scan_rsp_data(struct hci_request *req)
 
 static u8 get_adv_discov_flags(struct hci_dev *hdev)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	/* If there's a pending mgmt command the flags will not yet have
 	 * their final values, so check for this first.
@@ -1060,7 +1061,7 @@ static void update_class(struct hci_request *req)
 
 static bool get_connectable(struct hci_dev *hdev)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	/* If there's a pending mgmt command the flag will not yet have
 	 * it's final value, so check for this first.
@@ -1210,18 +1211,18 @@ static int read_controller_info(struct sock *sk, struct hci_dev *hdev,
 				 sizeof(rp));
 }
 
-static void mgmt_pending_free(struct pending_cmd *cmd)
+static void mgmt_pending_free(struct mgmt_pending_cmd *cmd)
 {
 	sock_put(cmd->sk);
 	kfree(cmd->param);
 	kfree(cmd);
 }
 
-static struct pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
-					    struct hci_dev *hdev, void *data,
-					    u16 len)
+static struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
+						 struct hci_dev *hdev,
+						 void *data, u16 len)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd)
@@ -1247,11 +1248,11 @@ static struct pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 }
 
 static void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
-				 void (*cb)(struct pending_cmd *cmd,
+				 void (*cb)(struct mgmt_pending_cmd *cmd,
 					    void *data),
 				 void *data)
 {
-	struct pending_cmd *cmd, *tmp;
+	struct mgmt_pending_cmd *cmd, *tmp;
 
 	list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
 		if (opcode > 0 && cmd->opcode != opcode)
@@ -1261,7 +1262,7 @@ static void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 	}
 }
 
-static void mgmt_pending_remove(struct pending_cmd *cmd)
+static void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
 {
 	list_del(&cmd->list);
 	mgmt_pending_free(cmd);
@@ -1390,7 +1391,7 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 		       u16 len)
 {
 	struct mgmt_mode *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
@@ -1472,7 +1473,7 @@ struct cmd_lookup {
 	u8 mgmt_status;
 };
 
-static void settings_rsp(struct pending_cmd *cmd, void *data)
+static void settings_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
 	struct cmd_lookup *match = data;
 
@@ -1488,7 +1489,7 @@ static void settings_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_free(cmd);
 }
 
-static void cmd_status_rsp(struct pending_cmd *cmd, void *data)
+static void cmd_status_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
 	u8 *status = data;
 
@@ -1496,7 +1497,7 @@ static void cmd_status_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_remove(cmd);
 }
 
-static void cmd_complete_rsp(struct pending_cmd *cmd, void *data)
+static void cmd_complete_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
 	if (cmd->cmd_complete) {
 		u8 *status = data;
@@ -1510,13 +1511,13 @@ static void cmd_complete_rsp(struct pending_cmd *cmd, void *data)
 	cmd_status_rsp(cmd, data);
 }
 
-static int generic_cmd_complete(struct pending_cmd *cmd, u8 status)
+static int generic_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)
 {
 	return mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
 				 cmd->param, cmd->param_len);
 }
 
-static int addr_cmd_complete(struct pending_cmd *cmd, u8 status)
+static int addr_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)
 {
 	return mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
 				 cmd->param, sizeof(struct mgmt_addr_info));
@@ -1545,7 +1546,7 @@ static u8 mgmt_le_support(struct hci_dev *hdev)
 static void set_discoverable_complete(struct hci_dev *hdev, u8 status,
 				      u16 opcode)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct mgmt_mode *cp;
 	struct hci_request req;
 	bool changed;
@@ -1606,7 +1607,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 			    u16 len)
 {
 	struct mgmt_cp_set_discoverable *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	u16 timeout;
 	u8 scan;
@@ -1805,7 +1806,7 @@ static void write_fast_connectable(struct hci_request *req, bool enable)
 static void set_connectable_complete(struct hci_dev *hdev, u8 status,
 				     u16 opcode)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct mgmt_mode *cp;
 	bool conn_changed, discov_changed;
 
@@ -1885,7 +1886,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 			   u16 len)
 {
 	struct mgmt_mode *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	u8 scan;
 	int err;
@@ -2022,7 +2023,7 @@ static int set_link_security(struct sock *sk, struct hci_dev *hdev, void *data,
 			     u16 len)
 {
 	struct mgmt_mode *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	u8 val, status;
 	int err;
 
@@ -2091,7 +2092,7 @@ failed:
 static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	u8 status;
 	int err;
 
@@ -2270,7 +2271,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct hci_cp_write_le_host_supported hci_cp;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	int err;
 	u8 val, enabled;
@@ -2363,7 +2364,7 @@ unlock:
  */
 static bool pending_eir_or_class(struct hci_dev *hdev)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
 		switch (cmd->opcode) {
@@ -2399,7 +2400,7 @@ static u8 get_uuid_size(const u8 *uuid)
 
 static void mgmt_class_complete(struct hci_dev *hdev, u16 mgmt_op, u8 status)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	hci_dev_lock(hdev);
 
@@ -2426,7 +2427,7 @@ static void add_uuid_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_cp_add_uuid *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	struct bt_uuid *uuid;
 	int err;
@@ -2506,7 +2507,7 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 		       u16 len)
 {
 	struct mgmt_cp_remove_uuid *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct bt_uuid *match, *tmp;
 	u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 	struct hci_request req;
@@ -2592,7 +2593,7 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 			 u16 len)
 {
 	struct mgmt_cp_set_dev_class *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	int err;
 
@@ -2760,7 +2761,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct mgmt_cp_unpair_device *cp = data;
 	struct mgmt_rp_unpair_device rp;
 	struct hci_cp_disconnect dc;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_conn *conn;
 	int err;
 
@@ -2874,7 +2875,7 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_disconnect *cp = data;
 	struct mgmt_rp_disconnect rp;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_conn *conn;
 	int err;
 
@@ -3014,7 +3015,7 @@ unlock:
 static int send_pin_code_neg_reply(struct sock *sk, struct hci_dev *hdev,
 				   struct mgmt_cp_pin_code_neg_reply *cp)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	int err;
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_NEG_REPLY, hdev, cp,
@@ -3036,7 +3037,7 @@ static int pin_code_reply(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct hci_conn *conn;
 	struct mgmt_cp_pin_code_reply *cp = data;
 	struct hci_cp_pin_code_reply reply;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	int err;
 
 	BT_DBG("");
@@ -3116,10 +3117,10 @@ static int set_io_capability(struct sock *sk, struct hci_dev *hdev, void *data,
 				 NULL, 0);
 }
 
-static struct pending_cmd *find_pairing(struct hci_conn *conn)
+static struct mgmt_pending_cmd *find_pairing(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
 		if (cmd->opcode != MGMT_OP_PAIR_DEVICE)
@@ -3134,7 +3135,7 @@ static struct pending_cmd *find_pairing(struct hci_conn *conn)
 	return NULL;
 }
 
-static int pairing_complete(struct pending_cmd *cmd, u8 status)
+static int pairing_complete(struct mgmt_pending_cmd *cmd, u8 status)
 {
 	struct mgmt_rp_pair_device rp;
 	struct hci_conn *conn = cmd->user_data;
@@ -3166,7 +3167,7 @@ static int pairing_complete(struct pending_cmd *cmd, u8 status)
 void mgmt_smp_complete(struct hci_conn *conn, bool complete)
 {
 	u8 status = complete ? MGMT_STATUS_SUCCESS : MGMT_STATUS_FAILED;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	cmd = find_pairing(conn);
 	if (cmd) {
@@ -3177,7 +3178,7 @@ void mgmt_smp_complete(struct hci_conn *conn, bool complete)
 
 static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	BT_DBG("status %u", status);
 
@@ -3193,7 +3194,7 @@ static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 
 static void le_pairing_complete_cb(struct hci_conn *conn, u8 status)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	BT_DBG("status %u", status);
 
@@ -3215,7 +3216,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_pair_device *cp = data;
 	struct mgmt_rp_pair_device rp;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	u8 sec_level, auth_type;
 	struct hci_conn *conn;
 	int err;
@@ -3341,7 +3342,7 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 			      u16 len)
 {
 	struct mgmt_addr_info *addr = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_conn *conn;
 	int err;
 
@@ -3384,7 +3385,7 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 			     struct mgmt_addr_info *addr, u16 mgmt_op,
 			     u16 hci_op, __le32 passkey)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_conn *conn;
 	int err;
 
@@ -3527,7 +3528,7 @@ static void update_name(struct hci_request *req)
 static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct mgmt_cp_set_local_name *cp;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	BT_DBG("status 0x%02x", status);
 
@@ -3556,7 +3557,7 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 			  u16 len)
 {
 	struct mgmt_cp_set_local_name *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	int err;
 
@@ -3624,7 +3625,7 @@ failed:
 static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
 			       void *data, u16 data_len)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -3913,7 +3914,7 @@ static bool trigger_discovery(struct hci_request *req, u8 *status)
 static void start_discovery_complete(struct hci_dev *hdev, u8 status,
 				     u16 opcode)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	unsigned long timeout;
 
 	BT_DBG("status %d", status);
@@ -3980,7 +3981,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 len)
 {
 	struct mgmt_cp_start_discovery *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	u8 status;
 	int err;
@@ -4042,7 +4043,8 @@ failed:
 	return err;
 }
 
-static int service_discovery_cmd_complete(struct pending_cmd *cmd, u8 status)
+static int service_discovery_cmd_complete(struct mgmt_pending_cmd *cmd,
+					  u8 status)
 {
 	return mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
 				 cmd->param, 1);
@@ -4052,7 +4054,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 				   void *data, u16 len)
 {
 	struct mgmt_cp_start_service_discovery *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	const u16 max_uuid_count = ((U16_MAX - sizeof(*cp)) / 16);
 	u16 uuid_count, expected_len;
@@ -4159,7 +4161,7 @@ failed:
 
 static void stop_discovery_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	BT_DBG("status %d", status);
 
@@ -4181,7 +4183,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 			  u16 len)
 {
 	struct mgmt_cp_stop_discovery *mgmt_cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	int err;
 
@@ -4420,7 +4422,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 			   u16 len)
 {
 	struct mgmt_mode *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	u8 val, enabled, status;
 	int err;
@@ -4600,7 +4602,7 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 static void fast_connectable_complete(struct hci_dev *hdev, u8 status,
 				      u16 opcode)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	BT_DBG("status 0x%02x", status);
 
@@ -4635,7 +4637,7 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 				void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	int err;
 
@@ -4698,7 +4700,7 @@ unlock:
 
 static void set_bredr_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	BT_DBG("status 0x%02x", status);
 
@@ -4731,7 +4733,7 @@ unlock:
 static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	int err;
 
@@ -4842,7 +4844,7 @@ unlock:
 
 static void sc_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct mgmt_mode *cp;
 
 	BT_DBG("%s status %u", hdev->name, status);
@@ -4889,7 +4891,7 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	u8 val;
 	int err;
@@ -5265,7 +5267,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static int conn_info_cmd_complete(struct pending_cmd *cmd, u8 status)
+static int conn_info_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)
 {
 	struct hci_conn *conn = cmd->user_data;
 	struct mgmt_rp_get_conn_info rp;
@@ -5296,7 +5298,7 @@ static void conn_info_refresh_complete(struct hci_dev *hdev, u8 hci_status,
 				       u16 opcode)
 {
 	struct hci_cp_read_rssi *cp;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_conn *conn;
 	u16 handle;
 	u8 status;
@@ -5409,7 +5411,7 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		struct hci_request req;
 		struct hci_cp_read_tx_power req_txp_cp;
 		struct hci_cp_read_rssi req_rssi_cp;
-		struct pending_cmd *cmd;
+		struct mgmt_pending_cmd *cmd;
 
 		hci_req_init(&req, hdev);
 		req_rssi_cp.handle = cpu_to_le16(conn->handle);
@@ -5466,7 +5468,7 @@ unlock:
 	return err;
 }
 
-static int clock_info_cmd_complete(struct pending_cmd *cmd, u8 status)
+static int clock_info_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)
 {
 	struct hci_conn *conn = cmd->user_data;
 	struct mgmt_rp_get_clock_info rp;
@@ -5505,7 +5507,7 @@ complete:
 static void get_clock_info_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct hci_cp_read_clock *hci_cp;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_conn *conn;
 
 	BT_DBG("%s status %u", hdev->name, status);
@@ -5540,7 +5542,7 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct mgmt_cp_get_clock_info *cp = data;
 	struct mgmt_rp_get_clock_info rp;
 	struct hci_cp_read_clock hci_cp;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	struct hci_conn *conn;
 	int err;
@@ -5683,7 +5685,7 @@ static void device_added(struct sock *sk, struct hci_dev *hdev,
 
 static void add_device_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	BT_DBG("status 0x%02x", status);
 
@@ -5704,7 +5706,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		      void *data, u16 len)
 {
 	struct mgmt_cp_add_device *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	u8 auto_conn, addr_type;
 	int err;
@@ -5806,7 +5808,7 @@ static void device_removed(struct sock *sk, struct hci_dev *hdev,
 
 static void remove_device_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	BT_DBG("status 0x%02x", status);
 
@@ -5827,7 +5829,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			 void *data, u16 len)
 {
 	struct mgmt_cp_remove_device *cp = data;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 	int err;
 
@@ -6530,7 +6532,7 @@ new_settings:
 
 void mgmt_set_powered_failed(struct hci_dev *hdev, int err)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	u8 status;
 
 	cmd = mgmt_pending_find(MGMT_OP_SET_POWERED, hdev);
@@ -6781,7 +6783,7 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 		    sizeof(*ev) + eir_len, NULL);
 }
 
-static void disconnect_rsp(struct pending_cmd *cmd, void *data)
+static void disconnect_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
 	struct sock **sk = data;
 
@@ -6793,7 +6795,7 @@ static void disconnect_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_remove(cmd);
 }
 
-static void unpair_device_rsp(struct pending_cmd *cmd, void *data)
+static void unpair_device_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
 	struct hci_dev *hdev = data;
 	struct mgmt_cp_unpair_device *cp = cmd->param;
@@ -6806,7 +6808,7 @@ static void unpair_device_rsp(struct pending_cmd *cmd, void *data)
 
 bool mgmt_powering_down(struct hci_dev *hdev)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	struct mgmt_mode *cp;
 
 	cmd = mgmt_pending_find(MGMT_OP_SET_POWERED, hdev);
@@ -6861,7 +6863,7 @@ void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	u8 bdaddr_type = link_to_bdaddr(link_type, addr_type);
 	struct mgmt_cp_disconnect *cp;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
 			     hdev);
@@ -6916,7 +6918,7 @@ void mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure)
 void mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  u8 status)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_REPLY, hdev);
 	if (!cmd)
@@ -6929,7 +6931,7 @@ void mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				      u8 status)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_NEG_REPLY, hdev);
 	if (!cmd)
@@ -6974,7 +6976,7 @@ static int user_pairing_resp_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				      u8 link_type, u8 addr_type, u8 status,
 				      u8 opcode)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	cmd = mgmt_pending_find(opcode, hdev);
 	if (!cmd)
@@ -7035,7 +7037,7 @@ int mgmt_user_passkey_notify(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void mgmt_auth_failed(struct hci_conn *conn, u8 hci_status)
 {
 	struct mgmt_ev_auth_failed ev;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 	u8 status = mgmt_status(hci_status);
 
 	bacpy(&ev.addr.bdaddr, &conn->dst);
@@ -7150,7 +7152,7 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	hci_req_run(&req, NULL);
 }
 
-static void sk_lookup(struct pending_cmd *cmd, void *data)
+static void sk_lookup(struct mgmt_pending_cmd *cmd, void *data)
 {
 	struct cmd_lookup *match = data;
 
@@ -7180,7 +7182,7 @@ void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 {
 	struct mgmt_cp_set_local_name ev;
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	if (status)
 		return;
@@ -7208,7 +7210,7 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 				       u8 *rand192, u8 *hash256, u8 *rand256,
 				       u8 status)
 {
-	struct pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd;
 
 	BT_DBG("%s status %u", hdev->name, status);
 
-- 
2.1.0

