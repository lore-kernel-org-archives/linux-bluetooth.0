Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 11/12] android/handsfree: Add helper for getting device
Date: Wed,  8 Oct 2014 12:15:13 +0200
Message-Id: <1412763314-12871-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412763314-12871-1-git-send-email-szymon.janc@tieto.com>
References: <1412763314-12871-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For now this is just dummy to minime use of global static device.
---
 android/handsfree.c | 321 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 238 insertions(+), 83 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index aab2fbb..1381929 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -265,6 +265,32 @@ static void device_cleanup(struct hf_device *dev)
 	memset(dev, 0, sizeof(*dev));
 }
 
+static struct hf_device *find_default_device(void)
+{
+	/* TODO should be replaced by find_device() eventually */
+
+	return &device;
+}
+
+static struct hf_device *find_device(const bdaddr_t *bdaddr)
+{
+	if (bacmp(&device.bdaddr, bdaddr))
+		return NULL;
+
+	return &device;
+}
+
+static struct hf_device *get_device(const bdaddr_t *bdaddr)
+{
+	struct hf_device *dev;
+
+	dev = find_device(bdaddr);
+	if (dev)
+		return dev;
+
+	return &device;
+}
+
 static void disconnect_watch(void *user_data)
 {
 	struct hf_device *dev = user_data;
@@ -1400,6 +1426,7 @@ static void confirm_cb(GIOChannel *chan, gpointer data)
 	char address[18];
 	bdaddr_t bdaddr;
 	GError *err = NULL;
+	struct hf_device *dev;
 
 	bt_io_get(chan, &err,
 			BT_IO_OPT_DEST, address,
@@ -1413,20 +1440,26 @@ static void confirm_cb(GIOChannel *chan, gpointer data)
 
 	DBG("incoming connect from %s", address);
 
-	if (device.state != HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED) {
+	dev = get_device(&bdaddr);
+	if (!dev) {
+		error("handsfree: Failed to get device object for %s", address);
+		goto drop;
+	}
+
+	if (dev->state != HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED) {
 		info("handsfree: refusing connection from %s", address);
 		goto drop;
 	}
 
-	device_init(&device, &bdaddr);
+	device_init(dev, &bdaddr);
 
-	if (!bt_io_accept(chan, connect_cb, &device, NULL, NULL)) {
+	if (!bt_io_accept(chan, connect_cb, dev, NULL, NULL)) {
 		error("handsfree: failed to accept connection");
-		device_cleanup(&device);
+		device_cleanup(dev);
 		goto drop;
 	}
 
-	device.hsp = GPOINTER_TO_INT(data);
+	dev->hsp = GPOINTER_TO_INT(data);
 	return;
 
 drop:
@@ -1609,6 +1642,7 @@ static int sdp_search_hfp(struct hf_device *dev)
 static void handle_connect(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_connect *cmd = buf;
+	struct hf_device *dev;
 	char addr[18];
 	uint8_t status;
 	bdaddr_t bdaddr;
@@ -1616,23 +1650,34 @@ static void handle_connect(const void *buf, uint16_t len)
 
 	DBG("");
 
-	if (device.state != HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED) {
+	dev = find_default_device();
+	if (dev) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
 	android2bdaddr(&cmd->bdaddr, &bdaddr);
+	dev = get_device(&bdaddr);
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	if (dev->state != HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
 	ba2str(&bdaddr, addr);
 	DBG("connecting to %s", addr);
 
-	device_init(&device, &bdaddr);
+	device_init(dev, &bdaddr);
 
 	/* prefer HFP over HSP */
-	ret = hfp_server ? sdp_search_hfp(&device) : sdp_search_hsp(&device);
+	ret = hfp_server ? sdp_search_hfp(dev) : sdp_search_hsp(dev);
 	if (ret < 0) {
 		error("handsfree: SDP search failed");
-		device_cleanup(&device);
+		device_cleanup(dev);
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -1647,6 +1692,7 @@ failed:
 static void handle_disconnect(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_disconnect *cmd = buf;
+	struct hf_device *dev;
 	bdaddr_t bdaddr;
 	uint8_t status;
 
@@ -1654,22 +1700,27 @@ static void handle_disconnect(const void *buf, uint16_t len)
 
 	android2bdaddr(cmd->bdaddr, &bdaddr);
 
-	if (device.state == HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED ||
-			bacmp(&device.bdaddr, &bdaddr)) {
+	dev = find_device(&bdaddr);
+	if (!dev) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
-	if (device.state == HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTING) {
+	if (dev->state == HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	if (dev->state == HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTING) {
 		status = HAL_STATUS_SUCCESS;
 		goto failed;
 	}
 
-	if (device.state == HAL_EV_HANDSFREE_CONN_STATE_CONNECTING) {
-		device_cleanup(&device);
+	if (dev->state == HAL_EV_HANDSFREE_CONN_STATE_CONNECTING) {
+		device_cleanup(dev);
 	} else {
-		set_state(&device, HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTING);
-		hfp_gw_disconnect(device.gw);
+		set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTING);
+		hfp_gw_disconnect(dev->gw);
 	}
 
 	status = HAL_STATUS_SUCCESS;
@@ -1716,6 +1767,7 @@ static bool connect_audio(struct hf_device *dev)
 static void handle_connect_audio(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_connect_audio *cmd = buf;
+	struct hf_device *dev;
 	bdaddr_t bdaddr;
 	uint8_t status;
 
@@ -1723,13 +1775,18 @@ static void handle_connect_audio(const void *buf, uint16_t len)
 
 	android2bdaddr(cmd->bdaddr, &bdaddr);
 
-	if (device.audio_state != HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED ||
-			bacmp(&device.bdaddr, &bdaddr)) {
+	dev = find_device(&bdaddr);
+	if (!dev) {
 		status = HAL_STATUS_FAILED;
 		goto done;
 	}
 
-	status = connect_audio(&device) ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
+	if (dev->audio_state != HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	status = connect_audio(dev) ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
 
 done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -1739,6 +1796,7 @@ done:
 static void handle_disconnect_audio(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_disconnect_audio *cmd = buf;
+	struct hf_device *dev;
 	bdaddr_t bdaddr;
 	uint8_t status;
 
@@ -1746,13 +1804,18 @@ static void handle_disconnect_audio(const void *buf, uint16_t len)
 
 	android2bdaddr(cmd->bdaddr, &bdaddr);
 
-	if (device.audio_state != HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED ||
-			bacmp(&device.bdaddr, &bdaddr)) {
+	dev = find_device(&bdaddr);
+	if (!dev) {
 		status = HAL_STATUS_FAILED;
 		goto done;
 	}
 
-	status = disconnect_sco(&device) ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
+	if (dev->audio_state != HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	status = disconnect_sco(dev) ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
 
 done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -1761,34 +1824,50 @@ done:
 
 static void handle_start_vr(const void *buf, uint16_t len)
 {
+	struct hf_device *dev;
 	uint8_t status;
 
 	DBG("");
 
-	if (device.features & HFP_HF_FEAT_VR) {
-		hfp_gw_send_info(device.gw, "+BVRA: 1");
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	if (dev->features & HFP_HF_FEAT_VR) {
+		hfp_gw_send_info(dev->gw, "+BVRA: 1");
 		status = HAL_STATUS_SUCCESS;
 	} else {
 		status = HAL_STATUS_FAILED;
 	}
 
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_START_VR, status);
 }
 
 static void handle_stop_vr(const void *buf, uint16_t len)
 {
+	struct hf_device *dev;
 	uint8_t status;
 
 	DBG("");
 
-	if (device.features & HFP_HF_FEAT_VR) {
-		hfp_gw_send_info(device.gw, "+BVRA: 0");
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	if (dev->features & HFP_HF_FEAT_VR) {
+		hfp_gw_send_info(dev->gw, "+BVRA: 0");
 		status = HAL_STATUS_SUCCESS;
 	} else {
 		status = HAL_STATUS_FAILED;
 	}
 
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 				HAL_OP_HANDSFREE_STOP_VR, status);
 }
@@ -1796,20 +1875,27 @@ static void handle_stop_vr(const void *buf, uint16_t len)
 static void handle_volume_control(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_volume_control *cmd = buf;
+	struct hf_device *dev;
 	uint8_t status, volume;
 
 	DBG("type=%u volume=%u", cmd->type, cmd->volume);
 
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
 	volume = cmd->volume > 15 ? 15 : cmd->volume;
 
 	switch (cmd->type) {
 	case HAL_HANDSFREE_VOLUME_TYPE_MIC:
-		hfp_gw_send_info(device.gw, "+VGM: %u", volume);
+		hfp_gw_send_info(dev->gw, "+VGM: %u", volume);
 
 		status = HAL_STATUS_SUCCESS;
 		break;
 	case HAL_HANDSFREE_VOLUME_TYPE_SPEAKER:
-		hfp_gw_send_info(device.gw, "+VGS: %u", volume);
+		hfp_gw_send_info(dev->gw, "+VGS: %u", volume);
 
 		status = HAL_STATUS_SUCCESS;
 		break;
@@ -1818,6 +1904,7 @@ static void handle_volume_control(const void *buf, uint16_t len)
 		break;
 	}
 
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 				HAL_OP_HANDSFREE_VOLUME_CONTROL, status);
 }
@@ -1844,22 +1931,34 @@ static void update_indicator(struct hf_device *dev, int ind, uint8_t val)
 static void handle_device_status_notif(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_device_status_notif *cmd = buf;
+	struct hf_device *dev;
+	uint8_t status;
 
 	DBG("");
 
-	update_indicator(&device, IND_SERVICE, cmd->state);
-	update_indicator(&device, IND_ROAM, cmd->type);
-	update_indicator(&device, IND_SIGNAL, cmd->signal);
-	update_indicator(&device, IND_BATTCHG, cmd->battery);
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	update_indicator(dev, IND_SERVICE, cmd->state);
+	update_indicator(dev, IND_ROAM, cmd->type);
+	update_indicator(dev, IND_SIGNAL, cmd->signal);
+	update_indicator(dev, IND_BATTCHG, cmd->battery);
 
+	status = HAL_STATUS_SUCCESS;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-					HAL_OP_HANDSFREE_DEVICE_STATUS_NOTIF,
-					HAL_STATUS_SUCCESS);
+				HAL_OP_HANDSFREE_DEVICE_STATUS_NOTIF, status);
 }
 
 static void handle_cops(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_cops_response *cmd = buf;
+	struct hf_device *dev;
+	uint8_t status;
 
 	if (len != sizeof(*cmd) + cmd->len ||
 			(cmd->len != 0 && cmd->buf[cmd->len - 1] != '\0')) {
@@ -1870,13 +1969,22 @@ static void handle_cops(const void *buf, uint16_t len)
 
 	DBG("");
 
-	hfp_gw_send_info(device.gw, "+COPS: 0,0,\"%.16s\"",
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	hfp_gw_send_info(dev->gw, "+COPS: 0,0,\"%.16s\"",
 					cmd->len ? (char *) cmd->buf : "");
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
+
+	status = HAL_STATUS_SUCCESS;
 
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-			HAL_OP_HANDSFREE_COPS_RESPONSE, HAL_STATUS_SUCCESS);
+				HAL_OP_HANDSFREE_COPS_RESPONSE, status);
 }
 
 static unsigned int get_callsetup(uint8_t state)
@@ -1896,38 +2004,51 @@ static unsigned int get_callsetup(uint8_t state)
 static void handle_cind(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_cind_response *cmd = buf;
+	struct hf_device *dev;
+	uint8_t status;
 
 	DBG("");
 
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
 	/* HAL doesn't provide indicators values so need to convert here */
-	device.inds[IND_SERVICE].val = cmd->svc;
-	device.inds[IND_CALL].val = !!(cmd->num_active + cmd->num_held);
-	device.inds[IND_CALLSETUP].val = get_callsetup(cmd->state);
-	device.inds[IND_CALLHELD].val = cmd->num_held ?
+	dev->inds[IND_SERVICE].val = cmd->svc;
+	dev->inds[IND_CALL].val = !!(cmd->num_active + cmd->num_held);
+	dev->inds[IND_CALLSETUP].val = get_callsetup(cmd->state);
+	dev->inds[IND_CALLHELD].val = cmd->num_held ?
 						(cmd->num_active ? 1 : 2) : 0;
-	device.inds[IND_SIGNAL].val = cmd->signal;
-	device.inds[IND_ROAM].val = cmd->roam;
-	device.inds[IND_BATTCHG].val = cmd->batt_chg;
+	dev->inds[IND_SIGNAL].val = cmd->signal;
+	dev->inds[IND_ROAM].val = cmd->roam;
+	dev->inds[IND_BATTCHG].val = cmd->batt_chg;
 
 	/* Order must match indicators_defaults table */
-	hfp_gw_send_info(device.gw, "+CIND: %u,%u,%u,%u,%u,%u,%u",
-						device.inds[IND_SERVICE].val,
-						device.inds[IND_CALL].val,
-						device.inds[IND_CALLSETUP].val,
-						device.inds[IND_CALLHELD].val,
-						device.inds[IND_SIGNAL].val,
-						device.inds[IND_ROAM].val,
-						device.inds[IND_BATTCHG].val);
+	hfp_gw_send_info(dev->gw, "+CIND: %u,%u,%u,%u,%u,%u,%u",
+						dev->inds[IND_SERVICE].val,
+						dev->inds[IND_CALL].val,
+						dev->inds[IND_CALLSETUP].val,
+						dev->inds[IND_CALLHELD].val,
+						dev->inds[IND_SIGNAL].val,
+						dev->inds[IND_ROAM].val,
+						dev->inds[IND_BATTCHG].val);
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 
+	status = HAL_STATUS_SUCCESS;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-			HAL_OP_HANDSFREE_CIND_RESPONSE, HAL_STATUS_SUCCESS);
+				HAL_OP_HANDSFREE_CIND_RESPONSE, status);
 }
 
 static void handle_formatted_at_resp(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_formatted_at_response *cmd = buf;
+	struct hf_device *dev;
+	uint8_t status;
 
 	DBG("");
 
@@ -1938,33 +2059,53 @@ static void handle_formatted_at_resp(const void *buf, uint16_t len)
 		return;
 	}
 
-	hfp_gw_send_info(device.gw, "%s", cmd->len ? (char *) cmd->buf : "");
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
 
+	hfp_gw_send_info(dev->gw, "%s", cmd->len ? (char *) cmd->buf : "");
+
+	status = HAL_STATUS_SUCCESS;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-					HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE,
-					HAL_STATUS_SUCCESS);
+			HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE, status);
 }
 
 static void handle_at_resp(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_at_response *cmd = buf;
+	struct hf_device *dev;
+	uint8_t status;
 
 	DBG("");
 
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
 	if (cmd->response == HAL_HANDSFREE_AT_RESPONSE_OK)
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
-	else if (device.cmee_enabled)
-		hfp_gw_send_error(device.gw, cmd->error);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
+	else if (dev->cmee_enabled)
+		hfp_gw_send_error(dev->gw, cmd->error);
 	else
-		hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
+
+	status = HAL_STATUS_SUCCESS;
 
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-			HAL_OP_HANDSFREE_AT_RESPONSE, HAL_STATUS_SUCCESS);
+					HAL_OP_HANDSFREE_AT_RESPONSE, status);
 }
 
 static void handle_clcc_resp(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_clcc_response *cmd = buf;
+	struct hf_device *dev;
 	uint8_t status;
 	char *number;
 
@@ -1977,8 +2118,14 @@ static void handle_clcc_resp(const void *buf, uint16_t len)
 
 	DBG("");
 
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
 	if (!cmd->index) {
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 
 		status = HAL_STATUS_SUCCESS;
 		goto done;
@@ -1995,13 +2142,13 @@ static void handle_clcc_resp(const void *buf, uint16_t len)
 	case HAL_HANDSFREE_CALL_STATE_ALERTING:
 		if (cmd->type == HAL_HANDSFREE_CALL_ADDRTYPE_INTERNATIONAL &&
 							number[0] != '+')
-			hfp_gw_send_info(device.gw,
+			hfp_gw_send_info(dev->gw,
 					"+CLCC: %u,%u,%u,%u,%u,\"+%s\",%u",
 					cmd->index, cmd->dir, cmd->state,
 					cmd->mode, cmd->mpty, number,
 					cmd->type);
 		else
-			hfp_gw_send_info(device.gw,
+			hfp_gw_send_info(dev->gw,
 					"+CLCC: %u,%u,%u,%u,%u,\"%s\",%u",
 					cmd->index, cmd->dir, cmd->state,
 					cmd->mode, cmd->mpty, number,
@@ -2209,6 +2356,7 @@ static void phone_state_idle(struct hf_device *dev, int num_active,
 static void handle_phone_state_change(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_phone_state_change *cmd = buf;
+	struct hf_device *dev;
 	uint8_t status;
 
 	if (len != sizeof(*cmd) + cmd->number_len || (cmd->number_len != 0 &&
@@ -2221,32 +2369,38 @@ static void handle_phone_state_change(const void *buf, uint16_t len)
 	DBG("active=%u hold=%u state=%u", cmd->num_active, cmd->num_held,
 								cmd->state);
 
+	dev = find_default_device();
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
 	switch (cmd->state) {
 	case HAL_HANDSFREE_CALL_STATE_DIALING:
-		phone_state_dialing(&device, cmd->num_active, cmd->num_held);
+		phone_state_dialing(dev, cmd->num_active, cmd->num_held);
 		break;
 	case HAL_HANDSFREE_CALL_STATE_ALERTING:
-		phone_state_alerting(&device, cmd->num_active, cmd->num_held);
+		phone_state_alerting(dev, cmd->num_active, cmd->num_held);
 		break;
 	case HAL_HANDSFREE_CALL_STATE_INCOMING:
-		phone_state_incoming(&device, cmd->num_active, cmd->num_held,
+		phone_state_incoming(dev, cmd->num_active, cmd->num_held,
 						cmd->type, cmd->number,
 						cmd->number_len);
 		break;
 	case HAL_HANDSFREE_CALL_STATE_IDLE:
-		phone_state_idle(&device, cmd->num_active, cmd->num_held);
+		phone_state_idle(dev, cmd->num_active, cmd->num_held);
 		break;
 	default:
 		DBG("unhandled new state %u (current state %u)", cmd->state,
-							device.setup_state);
+							dev->setup_state);
 
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
-	device.num_active = cmd->num_active;
-	device.num_held = cmd->num_held;
-	device.setup_state = cmd->state;
+	dev->num_active = cmd->num_active;
+	dev->num_held = cmd->num_held;
+	dev->setup_state = cmd->state;
 
 	status = HAL_STATUS_SUCCESS;
 
@@ -2370,9 +2524,7 @@ static void confirm_sco_cb(GIOChannel *chan, gpointer user_data)
 	char address[18];
 	bdaddr_t bdaddr;
 	GError *err = NULL;
-
-	if (device.sco)
-		goto drop;
+	struct hf_device *dev;
 
 	bt_io_get(chan, &err,
 			BT_IO_OPT_DEST, address,
@@ -2386,18 +2538,19 @@ static void confirm_sco_cb(GIOChannel *chan, gpointer user_data)
 
 	DBG("incoming SCO connection from %s", address);
 
-	if (device.state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED ||
-			bacmp(&device.bdaddr, &bdaddr)) {
+	dev = find_device(&bdaddr);
+	if (!dev || dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED ||
+								dev->sco) {
 		error("handsfree: audio connection from %s rejected", address);
 		goto drop;
 	}
 
-	if (!bt_io_accept(chan, connect_sco_cb, &device, NULL, NULL)) {
+	if (!bt_io_accept(chan, connect_sco_cb, dev, NULL, NULL)) {
 		error("handsfree: failed to accept audio connection");
 		goto drop;
 	}
 
-	set_audio_state(&device, HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTING);
+	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTING);
 	return;
 
 drop:
@@ -2629,21 +2782,23 @@ static void bt_sco_get_fd(const void *buf, uint16_t len)
 	int fd;
 	GError *err;
 	struct sco_rsp_get_fd rsp;
+	struct hf_device *dev;
 
 	DBG("");
 
-	if (!device.sco)
+	dev = find_default_device();
+	if (!dev || !dev->sco)
 		goto failed;
 
 	err = NULL;
-	if (!bt_io_get(device.sco, &err, BT_IO_OPT_MTU, &rsp.mtu,
+	if (!bt_io_get(dev->sco, &err, BT_IO_OPT_MTU, &rsp.mtu,
 							BT_IO_OPT_INVALID)) {
 		error("Unable to get MTU: %s\n", err->message);
 		g_clear_error(&err);
 		goto failed;
 	}
 
-	fd = g_io_channel_unix_get_fd(device.sco);
+	fd = g_io_channel_unix_get_fd(dev->sco);
 
 	DBG("fd %d mtu %u", fd, rsp.mtu);
 
-- 
1.9.1

