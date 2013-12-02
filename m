Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 4/9] android/bluetooth: Use generic IPC msg handling for commands
Date: Mon,  2 Dec 2013 13:20:43 +0100
Message-Id: <1385986848-8023-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
References: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handlers are registered on service register and unregistered on
unregister.
---
 android/bluetooth.c | 464 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 321 insertions(+), 143 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 8a1d444..eb8dbc5 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1361,7 +1361,7 @@ static void set_adapter_name_complete(uint8_t status, uint16_t length,
 	adapter_set_name(rp->name);
 }
 
-static uint8_t set_adapter_name(uint8_t *name, uint16_t len)
+static uint8_t set_adapter_name(const uint8_t *name, uint16_t len)
 {
 	struct mgmt_cp_set_local_name cp;
 
@@ -1378,8 +1378,17 @@ static uint8_t set_adapter_name(uint8_t *name, uint16_t len)
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t set_discoverable_timeout(uint8_t *timeout)
+static uint8_t set_discoverable_timeout(const void *buf, uint16_t len)
 {
+	const uint32_t *timeout = buf;
+
+	if (len != sizeof(*timeout)) {
+		error("Invalid set disc timeout size (%u bytes), terminating",
+									len);
+		raise(SIGTERM);
+		return HAL_STATUS_FAILED;
+	}
+
 	/* Android handles discoverable timeout in Settings app.
 	 * There is no need to use kernel feature for that.
 	 * Just need to store this value here */
@@ -1776,33 +1785,72 @@ static bool get_discoverable_timeout(void)
 	return true;
 }
 
-static bool get_property(void *buf, uint16_t len)
+static void handle_get_adapter_prop_cmd(const void *buf, uint16_t len)
 {
-	struct hal_cmd_get_adapter_prop *cmd = buf;
+	const struct hal_cmd_get_adapter_prop *cmd = buf;
+	uint8_t status;
 
 	switch (cmd->type) {
 	case HAL_PROP_ADAPTER_ADDR:
 		get_address();
-		return true;
+		break;
 	case HAL_PROP_ADAPTER_NAME:
-		return get_name();
+		if (!get_name()) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+		break;
 	case HAL_PROP_ADAPTER_UUIDS:
-		return get_uuids();
+		if (!get_uuids()) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+		break;
 	case HAL_PROP_ADAPTER_CLASS:
-		return get_class();
+		if (!get_class()) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+		break;
 	case HAL_PROP_ADAPTER_TYPE:
-		return get_type();
+		if (!get_type()) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+		break;
 	case HAL_PROP_ADAPTER_SERVICE_REC:
-		return get_service();
+		if (!get_service()) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+		break;
 	case HAL_PROP_ADAPTER_SCAN_MODE:
-		return get_scan_mode();
+		if (!get_scan_mode()) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+		break;
 	case HAL_PROP_ADAPTER_BONDED_DEVICES:
-		return get_devices();
+		if (!get_devices()) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+		break;
 	case HAL_PROP_ADAPTER_DISC_TIMEOUT:
-		return get_discoverable_timeout();
+		if (!get_discoverable_timeout()) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+		break;
 	default:
-		return false;
+		status = HAL_STATUS_FAILED;
+		goto failed;
 	}
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROP, status);
 }
 
 static void get_properties(void)
@@ -1858,11 +1906,18 @@ static bool stop_discovery(void)
 	return false;
 }
 
-static uint8_t set_scan_mode(void *buf, uint16_t len)
+static uint8_t set_scan_mode(const void *buf, uint16_t len)
 {
-	uint8_t *mode = buf;
+	const uint8_t *mode = buf;
 	bool conn, disc, cur_conn, cur_disc;
 
+	if (len != sizeof(*mode)) {
+		error("Invalid set scan mode size (%u bytes), terminating",
+								len);
+		raise(SIGTERM);
+		return HAL_STATUS_FAILED;
+	}
+
 	cur_conn = adapter.current_settings & MGMT_SETTING_CONNECTABLE;
 	cur_disc = adapter.current_settings & MGMT_SETTING_DISCOVERABLE;
 
@@ -1914,21 +1969,35 @@ done:
 	return HAL_STATUS_DONE;
 }
 
-static uint8_t set_property(void *buf, uint16_t len)
+static void handle_set_adapter_prop_cmd(const void *buf, uint16_t len)
 {
-	struct hal_cmd_set_adapter_prop *cmd = buf;
+	const struct hal_cmd_set_adapter_prop *cmd = buf;
+	uint8_t status;
+
+	if (len != sizeof(*cmd) + cmd->len) {
+		error("Invalid set adapter prop cmd (0x%x), terminating",
+								cmd->type);
+		raise(SIGTERM);
+		return;
+	}
 
 	switch (cmd->type) {
 	case HAL_PROP_ADAPTER_SCAN_MODE:
-		return set_scan_mode(cmd->val, cmd->len);
+		status = set_scan_mode(cmd->val, cmd->len);
+		break;
 	case HAL_PROP_ADAPTER_NAME:
-		return set_adapter_name(cmd->val, cmd->len);
+		status = set_adapter_name(cmd->val, cmd->len);
+		break;
 	case HAL_PROP_ADAPTER_DISC_TIMEOUT:
-		return set_discoverable_timeout(cmd->val);
+		status = set_discoverable_timeout(cmd->val, cmd->len);
+		break;
 	default:
 		DBG("Unhandled property type 0x%x", cmd->type);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		break;
 	}
+
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SET_ADAPTER_PROP, status);
 }
 
 static void pair_device_complete(uint8_t status, uint16_t length,
@@ -1947,9 +2016,10 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 							HAL_BOND_STATE_NONE);
 }
 
-static bool create_bond(void *buf, uint16_t len)
+static void handle_create_bond_cmd(const void *buf, uint16_t len)
 {
-	struct hal_cmd_create_bond *cmd = buf;
+	const struct hal_cmd_create_bond *cmd = buf;
+	uint8_t status;
 	struct mgmt_cp_pair_device cp;
 
 	cp.io_cap = DEFAULT_IO_CAPABILITY;
@@ -1957,25 +2027,36 @@ static bool create_bond(void *buf, uint16_t len)
 	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
 
 	if (mgmt_send(mgmt_if, MGMT_OP_PAIR_DEVICE, adapter.index, sizeof(cp),
-				&cp, pair_device_complete, NULL, NULL) == 0)
-		return false;
+				&cp, pair_device_complete, NULL, NULL) == 0) {
+		status = HAL_STATUS_FAILED;
+		goto fail;
+	}
+
+	status = HAL_STATUS_SUCCESS;
 
 	set_device_bond_state(&cp.addr.bdaddr, HAL_STATUS_SUCCESS,
 						HAL_BOND_STATE_BONDING);
 
-	return true;
+fail:
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CREATE_BOND, status);
 }
 
-static bool cancel_bond(void *buf, uint16_t len)
+static void handle_cancel_bond_cmd(const void *buf, uint16_t len)
 {
-	struct hal_cmd_cancel_bond *cmd = buf;
+	const struct hal_cmd_cancel_bond *cmd = buf;
 	struct mgmt_addr_info cp;
+	uint8_t status;
 
 	cp.type = BDADDR_BREDR;
 	android2bdaddr(cmd->bdaddr, &cp.bdaddr);
 
-	return mgmt_reply(mgmt_if, MGMT_OP_CANCEL_PAIR_DEVICE, adapter.index,
-					sizeof(cp), &cp, NULL, NULL, NULL) > 0;
+	if (mgmt_reply(mgmt_if, MGMT_OP_CANCEL_PAIR_DEVICE, adapter.index,
+					sizeof(cp), &cp, NULL, NULL, NULL) > 0)
+		status = HAL_STATUS_SUCCESS;
+	else
+		status = HAL_STATUS_FAILED;
+
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CANCEL_BOND, status);
 }
 
 static void unpair_device_complete(uint8_t status, uint16_t length,
@@ -1992,23 +2073,30 @@ static void unpair_device_complete(uint8_t status, uint16_t length,
 							HAL_BOND_STATE_NONE);
 }
 
-static bool remove_bond(void *buf, uint16_t len)
+static void handle_remove_bond_cmd(const void *buf, uint16_t len)
 {
-	struct hal_cmd_remove_bond *cmd = buf;
+	const struct hal_cmd_remove_bond *cmd = buf;
 	struct mgmt_cp_unpair_device cp;
+	uint8_t status;
 
 	cp.disconnect = 1;
 	cp.addr.type = BDADDR_BREDR;
 	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
 
-	return mgmt_send(mgmt_if, MGMT_OP_UNPAIR_DEVICE, adapter.index,
+	if (mgmt_send(mgmt_if, MGMT_OP_UNPAIR_DEVICE, adapter.index,
 				sizeof(cp), &cp, unpair_device_complete,
-				NULL, NULL) > 0;
+				NULL, NULL) > 0)
+		status = HAL_STATUS_SUCCESS;
+	else
+		status = HAL_STATUS_FAILED;
+
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_REMOVE_BOND, status);
 }
 
-static uint8_t pin_reply(void *buf, uint16_t len)
+static void handle_pin_reply_cmd(const void *buf, uint16_t len)
 {
-	struct hal_cmd_pin_reply *cmd = buf;
+	const struct hal_cmd_pin_reply *cmd = buf;
+	uint8_t status;
 	bdaddr_t bdaddr;
 	char addr[18];
 
@@ -2017,8 +2105,10 @@ static uint8_t pin_reply(void *buf, uint16_t len)
 
 	DBG("%s accept %u pin_len %u", addr, cmd->accept, cmd->pin_len);
 
-	if (!cmd->accept && cmd->pin_len)
-		return HAL_STATUS_INVALID;
+	if (!cmd->accept && cmd->pin_len) {
+		status = HAL_STATUS_INVALID;
+		goto failed;
+	}
 
 	if (cmd->accept) {
 		struct mgmt_cp_pin_code_reply rp;
@@ -2031,8 +2121,10 @@ static uint8_t pin_reply(void *buf, uint16_t len)
 		memcpy(rp.pin_code, cmd->pin_code, rp.pin_len);
 
 		if (mgmt_reply(mgmt_if, MGMT_OP_PIN_CODE_REPLY, adapter.index,
-				sizeof(rp), &rp, NULL, NULL, NULL) == 0)
-			return HAL_STATUS_FAILED;
+				sizeof(rp), &rp, NULL, NULL, NULL) == 0) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
 	} else {
 		struct mgmt_cp_pin_code_neg_reply rp;
 
@@ -2041,11 +2133,15 @@ static uint8_t pin_reply(void *buf, uint16_t len)
 
 		if (mgmt_reply(mgmt_if, MGMT_OP_PIN_CODE_NEG_REPLY,
 						adapter.index, sizeof(rp), &rp,
-						NULL, NULL, NULL) == 0)
-			return HAL_STATUS_FAILED;
+						NULL, NULL, NULL) == 0) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
 	}
 
-	return HAL_STATUS_SUCCESS;
+	status = HAL_STATUS_SUCCESS;
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_PIN_REPLY, status);
 }
 
 static uint8_t user_confirm_reply(const bdaddr_t *bdaddr, bool accept)
@@ -2102,11 +2198,11 @@ static uint8_t user_passkey_reply(const bdaddr_t *bdaddr, bool accept,
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t ssp_reply(void *buf, uint16_t len)
+static void handle_ssp_reply_cmd(const void *buf, uint16_t len)
 {
-	struct hal_cmd_ssp_reply *cmd = buf;
-	uint8_t status;
+	const struct hal_cmd_ssp_reply *cmd = buf;
 	bdaddr_t bdaddr;
+	uint8_t status;
 	char addr[18];
 
 	/* TODO should parameters sanity be verified here? */
@@ -2133,144 +2229,226 @@ static uint8_t ssp_reply(void *buf, uint16_t len)
 		break;
 	}
 
-	return status;
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SSP_REPLY, status);
 }
 
-static uint8_t get_remote_services(void *buf, uint16_t len)
+static void handle_get_remote_services_cmd(const void *buf, uint16_t len)
 {
-	struct hal_cmd_get_remote_services *cmd = buf;
+	const struct hal_cmd_get_remote_services *cmd = buf;
+	uint8_t status;
 	bdaddr_t addr;
 
 	android2bdaddr(&cmd->bdaddr, &addr);
 
-	return browse_remote_sdp(&addr);
+	status = browse_remote_sdp(&addr);
+
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_REMOTE_SERVICES,
+									status);
 }
 
-void bt_bluetooth_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
+static void handle_enable_cmd(const void *buf, uint16_t len)
 {
-	uint8_t status = HAL_STATUS_FAILED;
+	uint8_t status;
 
-	switch (opcode) {
-	case HAL_OP_ENABLE:
-		/* Framework expects all properties to be emitted while
-		 * enabling adapter */
-		get_properties();
+	/* Framework expects all properties to be emitted while
+	 * enabling adapter */
+	get_properties();
 
-		if (adapter.current_settings & MGMT_SETTING_POWERED) {
-			status = HAL_STATUS_DONE;
-			goto error;
-		}
+	if (adapter.current_settings & MGMT_SETTING_POWERED) {
+		status = HAL_STATUS_DONE;
+		goto failed;
+	}
 
-		if (!set_mode(MGMT_OP_SET_POWERED, 0x01))
-			goto error;
+	if (!set_mode(MGMT_OP_SET_POWERED, 0x01)) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
-		break;
-	case HAL_OP_DISABLE:
-		if (!(adapter.current_settings & MGMT_SETTING_POWERED)) {
-			status = HAL_STATUS_DONE;
-			goto error;
-		}
+	status = HAL_STATUS_SUCCESS;
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_ENABLE, status);
+}
 
-		if (!set_mode(MGMT_OP_SET_POWERED, 0x00))
-			goto error;
+static void handle_disable_cmd(const void *buf, uint16_t len)
+{
+	uint8_t status;
 
-		break;
-	case HAL_OP_GET_ADAPTER_PROPS:
-		get_properties();
+	if (!(adapter.current_settings & MGMT_SETTING_POWERED)) {
+		status = HAL_STATUS_DONE;
+		goto failed;
+	}
 
-		break;
-	case HAL_OP_GET_ADAPTER_PROP:
-		if (!get_property(buf, len))
-			goto error;
+	if (!set_mode(MGMT_OP_SET_POWERED, 0x00)) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
-		break;
-	case HAL_OP_SET_ADAPTER_PROP:
-		status = set_property(buf, len);
-		if (status != HAL_STATUS_SUCCESS && status != HAL_STATUS_DONE)
-			goto error;
+	status = HAL_STATUS_SUCCESS;
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DISABLE, status);
+}
 
-		break;
-	case HAL_OP_CREATE_BOND:
-		if (!create_bond(buf, len))
-			goto error;
+static void handle_get_adapter_props_cmd(const void *buf, uint16_t len)
+{
+	get_properties();
 
-		break;
-	case HAL_OP_CANCEL_BOND:
-		if (!cancel_bond(buf, len))
-			goto error;
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROPS,
+							HAL_STATUS_SUCCESS);
+}
 
-		break;
-	case HAL_OP_REMOVE_BOND:
-		if (!remove_bond(buf, len))
-			goto error;
+static void handle_get_remote_device_props_cmd(const void *buf, uint16_t len)
+{
+	/* TODO */
 
-		break;
-	case HAL_OP_PIN_REPLY:
-		status = pin_reply(buf, len);
-		if (status != HAL_STATUS_SUCCESS)
-			goto error;
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_REMOTE_DEVICE_PROPS,
+							HAL_STATUS_FAILED);
+}
 
-		break;
-	case HAL_OP_SSP_REPLY:
-		status = ssp_reply(buf, len);
-		if (status != HAL_STATUS_SUCCESS)
-			goto error;
-		break;
-	case HAL_OP_START_DISCOVERY:
-		if (adapter.discovering) {
-			status = HAL_STATUS_DONE;
-			goto error;
-		}
+static void handle_get_remote_device_prop_cmd(const void *buf, uint16_t len)
+{
+	/* TODO */
 
-		if (!(adapter.current_settings & MGMT_SETTING_POWERED)) {
-			status = HAL_STATUS_NOT_READY;
-			goto error;
-		}
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_REMOTE_DEVICE_PROP,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_set_remote_device_prop_cmd(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_set_remote_device_prop *cmd = buf;
+	uint8_t status;
 
-		if (!start_discovery())
-			goto error;
+	if (len != sizeof(*cmd) + cmd->len) {
+		error("Invalid set remote device prop cmd (0x%x), terminating",
+								cmd->type);
+		raise(SIGTERM);
+		return;
+	}
 
+	/* TODO */
+
+	switch (cmd->type) {
+	default:
+		DBG("Unhandled property type 0x%x", cmd->type);
+		status = HAL_STATUS_FAILED;
 		break;
-	case HAL_OP_CANCEL_DISCOVERY:
-		if (!adapter.discovering) {
-			status = HAL_STATUS_DONE;
-			goto error;
-		}
+	}
 
-		if (!(adapter.current_settings & MGMT_SETTING_POWERED)) {
-			status = HAL_STATUS_NOT_READY;
-			goto error;
-		}
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SET_REMOTE_DEVICE_PROP,
+									status);
+}
 
-		if (!stop_discovery())
-			goto error;
+static void handle_get_remote_service_rec_cmd(const void *buf, uint16_t len)
+{
+	/* TODO */
 
-		break;
-	case HAL_OP_GET_REMOTE_SERVICES:
-		status = get_remote_services(buf, len);
-		if (status != HAL_STATUS_SUCCESS)
-			goto error;
-		break;
-	default:
-		DBG("Unhandled command, opcode 0x%x", opcode);
-		goto error;
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_REMOTE_SERVICE_REC,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_start_discovery_cmd(const void *buf, uint16_t len)
+{
+	uint8_t status;
+
+	if (adapter.discovering) {
+		status = HAL_STATUS_DONE;
+		goto failed;
 	}
 
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, opcode, HAL_STATUS_SUCCESS);
-	return;
+	if (!(adapter.current_settings & MGMT_SETTING_POWERED)) {
+		status = HAL_STATUS_NOT_READY;
+		goto failed;
+	}
 
-error:
-	error("Error handling command 0x%02x status %u", opcode, status);
+	if (!start_discovery()) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
-	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, opcode, status);
+	status = HAL_STATUS_SUCCESS;
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_START_DISCOVERY, status);
 }
 
+static void handle_cancel_discovery_cmd(const void *buf, uint16_t len)
+{
+	uint8_t status;
+
+	if (!adapter.discovering) {
+		status = HAL_STATUS_DONE;
+		goto failed;
+	}
+
+	if (!(adapter.current_settings & MGMT_SETTING_POWERED)) {
+		status = HAL_STATUS_NOT_READY;
+		goto failed;
+	}
+
+	if (!stop_discovery()) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CANCEL_DISCOVERY, status);
+}
+
+static const struct ipc_handler cmd_handlers[] = {
+	/* HAL_OP_ENABLE */
+	{ handle_enable_cmd, false, 0 },
+	/* HAL_OP_DISABLE */
+	{ handle_disable_cmd, false, 0 },
+	/* HAL_OP_GET_ADAPTER_PROPS */
+	{ handle_get_adapter_props_cmd, false, 0 },
+	/* HAL_OP_GET_ADAPTER_PROP */
+	{ handle_get_adapter_prop_cmd, false,
+				sizeof(struct hal_cmd_get_adapter_prop) },
+	/* HAL_OP_SET_ADAPTER_PROP */
+	{ handle_set_adapter_prop_cmd, true,
+				sizeof(struct hal_cmd_set_adapter_prop) },
+	/* HAL_OP_GET_REMOTE_DEVICE_PROPS */
+	{ handle_get_remote_device_props_cmd, false,
+			sizeof(struct hal_cmd_get_remote_device_props) },
+	/* HAL_OP_GET_REMOTE_DEVICE_PROP */
+	{ handle_get_remote_device_prop_cmd, false,
+				sizeof(struct hal_cmd_get_remote_device_prop) },
+	/* HAL_OP_SET_REMOTE_DEVICE_PROP */
+	{ handle_set_remote_device_prop_cmd, true,
+				sizeof(struct hal_cmd_set_remote_device_prop) },
+	/* HAL_OP_GET_REMOTE_SERVICE_REC */
+	{ handle_get_remote_service_rec_cmd, false,
+				sizeof(struct hal_cmd_get_remote_service_rec) },
+	/* HAL_OP_GET_REMOTE_SERVICES */
+	{ handle_get_remote_services_cmd, false,
+				sizeof(struct hal_cmd_get_remote_services) },
+	/* HAL_OP_START_DISCOVERY */
+	{ handle_start_discovery_cmd, false, 0 },
+	/* HAL_OP_CANCEL_DISCOVERY */
+	{ handle_cancel_discovery_cmd, false, 0 },
+	/* HAL_OP_CREATE_BOND */
+	{ handle_create_bond_cmd, false, sizeof(struct hal_cmd_create_bond) },
+	/* HAL_OP_REMOVE_BOND */
+	{ handle_remove_bond_cmd, false, sizeof(struct hal_cmd_remove_bond) },
+	/* HAL_OP_CANCEL_BOND */
+	{handle_cancel_bond_cmd, false, sizeof(struct hal_cmd_cancel_bond) },
+	/* HAL_OP_PIN_REPLY */
+	{ handle_pin_reply_cmd, false, sizeof(struct hal_cmd_pin_reply) },
+	/* HAL_OP_SSP_REPLY */
+	{ handle_ssp_reply_cmd, false, sizeof(struct hal_cmd_ssp_reply) },
+};
+
 void bt_bluetooth_register(void)
 {
 	DBG("");
+
+	ipc_register(HAL_SERVICE_ID_BLUETOOTH, cmd_handlers,
+				sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
 }
 
 void bt_bluetooth_unregister(void)
 {
 	DBG("");
+
+	ipc_unregister(HAL_SERVICE_ID_CORE);
 }
-- 
1.8.3.2

