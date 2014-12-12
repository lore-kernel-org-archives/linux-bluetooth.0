Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 1/3] shared/queue: enable early terminate foreach
Date: Fri, 12 Dec 2014 10:44:22 -0800
Message-Id: <1418409864-26119-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418409864-26119-1-git-send-email-jamuraa@chromium.org>
References: <1418409864-26119-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Redefines the callback for queue_foreach to return a boolean indicating
whether to continue with the iteration.  When the function returns
false, the iteration is terminated.

This allows for functions where only part of the contents of the queue
need to be examined or touched to be efficient.
---
 android/bluetooth.c      |  4 ++-
 android/gatt.c           | 48 +++++++++++++++++++++-----------
 android/handsfree.c      |  9 ++++--
 android/health.c         | 36 ++++++++++++++----------
 android/tester-main.c    | 32 +++++++++++++++------
 emulator/hciemu.c        |  3 +-
 monitor/keys.c           | 10 +++----
 src/shared/att.c         | 22 ++++++++++-----
 src/shared/gatt-client.c | 16 +++++++----
 src/shared/gatt-db.c     | 72 ++++++++++++++++++++++++------------------------
 src/shared/hci.c         |  4 ++-
 src/shared/mgmt.c        |  8 ++++--
 src/shared/queue.c       |  3 +-
 src/shared/queue.h       |  2 +-
 src/shared/uhid.c        |  6 ++--
 unit/test-queue.c        | 16 ++++++++---
 16 files changed, 182 insertions(+), 109 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 6443cfe..5298fb6 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -4427,12 +4427,14 @@ failed:
 									status);
 }
 
-static void send_unpaired_notification(void *data, void *user_data)
+static bool send_unpaired_notification(void *data, void *user_data)
 {
 	bt_unpaired_device_cb cb = data;
 	struct mgmt_addr_info *addr = user_data;
 
 	cb(&addr->bdaddr, addr->type);
+
+	return true;
 }
 
 static void unpair_device_complete(uint8_t status, uint16_t length,
diff --git a/android/gatt.c b/android/gatt.c
index 37bd6de..8d6a939 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -886,19 +886,21 @@ static void send_app_connect_notify(struct app_connection *connection,
 		send_server_connection_notify(connection, !status);
 }
 
-static void disconnect_notify_by_device(void *data, void *user_data)
+static bool disconnect_notify_by_device(void *data, void *user_data)
 {
 	struct app_connection *conn = data;
 	struct gatt_device *dev = user_data;
 
 	if (dev != conn->device || !conn->app)
-		return;
+		return true;
 
 	if (dev->state == DEVICE_CONNECTED)
 		send_app_disconnect_notify(conn, GATT_SUCCESS);
 	else if (dev->state == DEVICE_CONNECT_INIT ||
 					dev->state == DEVICE_CONNECT_READY)
 		send_app_connect_notify(conn, GATT_FAILURE);
+
+	return true;
 }
 
 static void destroy_connection(void *data)
@@ -1142,7 +1144,7 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
 	return s;
 }
 
-static void send_client_primary_notify(void *data, void *user_data)
+static bool send_client_primary_notify(void *data, void *user_data)
 {
 	struct hal_ev_gatt_client_search_result ev;
 	struct service *p = data;
@@ -1150,7 +1152,7 @@ static void send_client_primary_notify(void *data, void *user_data)
 
 	/* In service queue we will have also included services */
 	if (!p->primary)
-		return;
+		return true;
 
 	ev.conn_id  = conn_id;
 	element_id_to_hal_srvc_id(&p->id, 1, &ev.srvc_id);
@@ -1159,6 +1161,8 @@ static void send_client_primary_notify(void *data, void *user_data)
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 			HAL_EV_GATT_CLIENT_SEARCH_RESULT, sizeof(ev), &ev);
+
+	return true;
 }
 
 static void send_client_search_complete_notify(int32_t status, int32_t conn_id)
@@ -1394,13 +1398,15 @@ struct connect_data {
 	int32_t status;
 };
 
-static void send_app_connect_notifications(void *data, void *user_data)
+static bool send_app_connect_notifications(void *data, void *user_data)
 {
 	struct app_connection *conn = data;
 	struct connect_data *con_data = user_data;
 
 	if (conn->device == con_data->dev)
 		send_app_connect_notify(conn, con_data->status);
+
+	return true;
 }
 
 static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id)
@@ -1430,19 +1436,21 @@ static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id)
 								&conn_match);
 }
 
-static void create_app_connection(void *data, void *user_data)
+static bool create_app_connection(void *data, void *user_data)
 {
 	struct gatt_device *dev = user_data;
 	struct gatt_app *app;
 
 	app = find_app_by_id(PTR_TO_INT(data));
 	if (!app)
-		return;
+		return true;
 
 	DBG("Autoconnect application id=%d", app->id);
 
 	if (!find_conn(&dev->bdaddr, PTR_TO_INT(data)))
 		create_connection(dev, app);
+
+	return true;
 }
 
 static void ind_handler(const uint8_t *cmd, uint16_t cmd_len,
@@ -1944,13 +1952,15 @@ static void remove_autoconnect_device(struct gatt_device *dev)
 	device_unref(dev);
 }
 
-static void clear_autoconnect_devices(void *data, void *user_data)
+static bool clear_autoconnect_devices(void *data, void *user_data)
 {
 	struct gatt_device *dev = data;
 
 	if (queue_remove(dev->autoconnect_apps, user_data))
 		if (queue_isempty(dev->autoconnect_apps))
 			remove_autoconnect_device(dev);
+
+	return true;
 }
 
 static uint8_t unregister_app(int client_if)
@@ -4768,7 +4778,7 @@ static void attribute_read_cb(struct gatt_db_attribute *attrib, int err,
 	memcpy(resp_data->value, value, length);
 }
 
-static void read_requested_attributes(void *data, void *user_data)
+static bool read_requested_attributes(void *data, void *user_data)
 {
 	struct pending_request *resp_data = data;
 	struct request_processing_data *process_data = user_data;
@@ -4780,7 +4790,7 @@ static void read_requested_attributes(void *data, void *user_data)
 	if (!attrib) {
 		resp_data->error = ATT_ECODE_ATTR_NOT_FOUND;
 		resp_data->state = REQUEST_DONE;
-		return;
+		return true;
 	}
 
 	gatt_db_attribute_get_permissions(attrib, &permissions);
@@ -4798,7 +4808,7 @@ static void read_requested_attributes(void *data, void *user_data)
 	if (error != 0) {
 		resp_data->error = error;
 		resp_data->state = REQUEST_DONE;
-		return;
+		return true;
 	}
 
 	resp_data->state = REQUEST_PENDING;
@@ -4806,6 +4816,8 @@ static void read_requested_attributes(void *data, void *user_data)
 	gatt_db_attribute_read(attrib, resp_data->offset, process_data->opcode,
 					&process_data->device->bdaddr,
 					attribute_read_cb, resp_data);
+
+	return true;
 }
 
 static void process_dev_pending_requests(struct gatt_device *device,
@@ -5109,7 +5121,7 @@ failed:
 				HAL_OP_GATT_SERVER_ADD_DESCRIPTOR, status);
 }
 
-static void notify_service_change(void *data, void *user_data)
+static bool notify_service_change(void *data, void *user_data)
 {
 	struct att_range range;
 	struct gatt_db_attribute *attrib = user_data;
@@ -5118,9 +5130,11 @@ static void notify_service_change(void *data, void *user_data)
 
 	/* In case of db error */
 	if (!range.end)
-		return;
+		return true;
 
 	notify_att_range_change(data, &range);
+
+	return true;
 }
 
 static sdp_record_t *get_sdp_record(uuid_t *uuid, uint16_t start, uint16_t end,
@@ -6515,21 +6529,21 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
-static void send_server_write_execute_notify(void *data, void *user_data)
+static bool send_server_write_execute_notify(void *data, void *user_data)
 {
 	struct hal_ev_gatt_server_request_exec_write *ev = user_data;
 	struct pending_trans_data *transaction;
 	struct app_connection *conn = data;
 
 	if (!conn->wait_execute_write)
-		return;
+		return true;
 
 	ev->conn_id = conn->id;
 
 	transaction = conn_add_transact(conn, ATT_OP_EXEC_WRITE_REQ, NULL, 0);
 	if (!transaction) {
 		conn->wait_execute_write = false;
-		return;
+		return true;
 	}
 
 	ev->trans_id = transaction->id;
@@ -6537,6 +6551,8 @@ static void send_server_write_execute_notify(void *data, void *user_data)
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_EV_GATT_SERVER_REQUEST_EXEC_WRITE,
 				sizeof(*ev), ev);
+
+	return true;
 }
 
 static uint8_t write_execute_request(const uint8_t *cmd, uint16_t cmd_len,
diff --git a/android/handsfree.c b/android/handsfree.c
index 7fbe64b..48d280b 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1986,7 +1986,7 @@ static void update_indicator(struct hf_device *dev, int ind, uint8_t val)
 	hfp_gw_send_info(dev->gw, "+CIEV: %u,%u", ind + 1, val);
 }
 
-static void device_status_notif(void *data, void *user_data)
+static bool device_status_notif(void *data, void *user_data)
 {
 	struct hf_device *dev = data;
 	struct hal_cmd_handsfree_device_status_notif *cmd = user_data;
@@ -1995,6 +1995,8 @@ static void device_status_notif(void *data, void *user_data)
 	update_indicator(dev, IND_ROAM, cmd->type);
 	update_indicator(dev, IND_SIGNAL, cmd->signal);
 	update_indicator(dev, IND_BATTCHG, cmd->battery);
+
+	return true;
 }
 
 static void handle_device_status_notif(const void *buf, uint16_t len)
@@ -2433,7 +2435,7 @@ static void phone_state_idle(struct hf_device *dev, int num_active,
 	}
 }
 
-static void phone_state_change(void *data, void *user_data)
+static bool phone_state_change(void *data, void *user_data)
 {
 	struct hf_device *dev = data;
 	struct hal_cmd_handsfree_phone_state_change *cmd = user_data;
@@ -2457,13 +2459,14 @@ static void phone_state_change(void *data, void *user_data)
 		DBG("unhandled new state %u (current state %u)", cmd->state,
 							dev->setup_state);
 
-		return;
+		return true;
 	}
 
 	dev->num_active = cmd->num_active;
 	dev->num_held = cmd->num_held;
 	dev->setup_state = cmd->state;
 
+	return true;
 }
 
 static void handle_phone_state_change(const void *buf, uint16_t len)
diff --git a/android/health.c b/android/health.c
index 75811aa..54085a7 100644
--- a/android/health.c
+++ b/android/health.c
@@ -313,13 +313,13 @@ struct channel_search {
 	struct health_channel *channel;
 };
 
-static void device_search_channel(void *data, void *user_data)
+static bool device_search_channel(void *data, void *user_data)
 {
 	struct health_device *dev = data;
 	struct channel_search *search = user_data;
 
 	if (search->channel)
-		return;
+		return false;
 
 	if (search->channel_id)
 		search->channel = queue_find(dev->channels, match_channel_by_id,
@@ -328,17 +328,21 @@ static void device_search_channel(void *data, void *user_data)
 		search->channel = queue_find(dev->channels,
 						match_channel_by_mdl,
 						search->mdl);
+
+	return true;
 }
 
-static void app_search_channel(void *data, void *user_data)
+static bool app_search_channel(void *data, void *user_data)
 {
 	struct health_app *app = data;
 	struct channel_search *search = user_data;
 
 	if (search->channel)
-		return;
+		return false;
 
 	queue_foreach(app->devices, device_search_channel, search);
+
+	return true;
 }
 
 static struct health_channel *search_channel_by_id(uint16_t id)
@@ -374,15 +378,14 @@ struct mcl_search {
 	struct health_device *dev;
 };
 
-static void app_search_dev(void *data, void *user_data)
+static bool app_search_dev(void *data, void *user_data)
 {
 	struct health_app *app = data;
 	struct mcl_search *search = user_data;
 
-	if (search->dev)
-		return;
-
 	search->dev = queue_find(app->devices, match_dev_by_mcl, search->mcl);
+
+	return !search->dev;
 }
 
 static struct health_device *search_dev_by_mcl(struct mcap_mcl *mcl)
@@ -404,17 +407,18 @@ struct app_search {
 	struct health_app *app;
 };
 
-static void app_search_mdep(void *data, void *user_data)
+static bool app_search_mdep(void *data, void *user_data)
 {
 	struct health_app *app = data;
 	struct app_search *search = user_data;
 
-	if (search->app)
-		return;
-
 	if (queue_find(app->mdeps, match_mdep_by_id,
-						INT_TO_PTR(search->mdepid)))
+						INT_TO_PTR(search->mdepid))) {
 		search->app = app;
+		return false;
+	}
+
+	return true;
 }
 
 static struct health_app *search_app_by_mdepid(uint8_t mdepid)
@@ -661,7 +665,7 @@ static void free_hdp_list(void *list)
 	sdp_list_free(hdp_list, (sdp_free_func_t)sdp_data_free);
 }
 
-static void register_features(void *data, void *user_data)
+static bool register_features(void *data, void *user_data)
 {
 	struct mdep_cfg *mdep = data;
 	sdp_list_t **sup_features = user_data;
@@ -671,7 +675,7 @@ static void register_features(void *data, void *user_data)
 
 	hdp_feature = mdeps_to_sdp_features(mdep);
 	if (!hdp_feature)
-		return;
+		return true;
 
 	if (!*sup_features) {
 		*sup_features = sdp_list_append(NULL, hdp_feature);
@@ -682,6 +686,8 @@ static void register_features(void *data, void *user_data)
 		sdp_list_free(hdp_feature,
 					(sdp_free_func_t)sdp_data_free);
 	}
+
+	return true;
 }
 
 static int register_service_sup_features(sdp_record_t *rec,
diff --git a/android/tester-main.c b/android/tester-main.c
index 6339b3a..33a6808 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -3046,60 +3046,76 @@ static void tester_testcases_cleanup(void)
 	remove_pan_tests();
 }
 
-static void add_bluetooth_tests(void *data, void *user_data)
+static bool add_bluetooth_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
 	test(tc, setup, generic_test_function, teardown);
+
+	return true;
 }
 
-static void add_socket_tests(void *data, void *user_data)
+static bool add_socket_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
 	test(tc, setup_socket, generic_test_function, teardown);
+
+	return true;
 }
 
-static void add_hidhost_tests(void *data, void *user_data)
+static bool add_hidhost_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
 	test(tc, setup_hidhost, generic_test_function, teardown);
+
+	return true;
 }
 
-static void add_pan_tests(void *data, void *user_data)
+static bool add_pan_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
 	test(tc, setup_pan, generic_test_function, teardown);
+
+	return true;
 }
 
-static void add_hdp_tests(void *data, void *user_data)
+static bool add_hdp_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
 	test(tc, setup_hdp, generic_test_function, teardown);
+
+	return true;
 }
 
-static void add_a2dp_tests(void *data, void *user_data)
+static bool add_a2dp_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
 	test(tc, setup_a2dp, generic_test_function, teardown);
+
+	return true;
 }
 
-static void add_avrcp_tests(void *data, void *user_data)
+static bool add_avrcp_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
 	test(tc, setup_avrcp, generic_test_function, teardown);
+
+	return true;
 }
 
-static void add_gatt_tests(void *data, void *user_data)
+static bool add_gatt_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
 
 	test(tc, setup_gatt, generic_test_function, teardown);
+
+	return true;
 }
 
 int main(int argc, char *argv[])
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index c5bfa77..c1ab868 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -77,7 +77,7 @@ struct run_data {
 	uint8_t len;
 };
 
-static void run_command_hook(void *data, void *user_data)
+static bool run_command_hook(void *data, void *user_data)
 {
 	struct hciemu_command_hook *hook = data;
 	struct run_data *run_data = user_data;
@@ -85,6 +85,7 @@ static void run_command_hook(void *data, void *user_data)
 	if (hook->function)
 		hook->function(run_data->opcode, run_data->data,
 					run_data->len, hook->user_data);
+	return true;
 }
 
 static void master_command_callback(uint16_t opcode,
diff --git a/monitor/keys.c b/monitor/keys.c
index 4ccef22..46cad43 100644
--- a/monitor/keys.c
+++ b/monitor/keys.c
@@ -106,22 +106,22 @@ struct resolve_data {
 	uint8_t ident_type;
 };
 
-static void try_resolve_irk(void *data, void *user_data)
+static bool try_resolve_irk(void *data, void *user_data)
 {
 	struct irk_data *irk = data;
 	struct resolve_data *result = user_data;
 	uint8_t local_hash[3];
 
-	if (result->found)
-		return;
-
 	bt_crypto_ah(crypto, irk->key, result->addr + 3, local_hash);
 
 	if (!memcmp(result->addr, local_hash, 3)) {
-		result->found = true;
 		memcpy(result->ident, irk->addr, 6);
+		result->found = true;
 		result->ident_type = irk->addr_type;
+		return false;
 	}
+
+	return true;
 }
 
 bool keys_resolve_identity(const uint8_t addr[6], uint8_t ident[6],
diff --git a/src/shared/att.c b/src/shared/att.c
index 26b6c5b..065d6e0 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -247,11 +247,13 @@ static bool match_notify_removed(const void *a, const void *b)
 	return notify->removed;
 }
 
-static void mark_notify_removed(void *data, void *user_data)
+static bool mark_notify_removed(void *data, void *user_data)
 {
 	struct att_notify *notify = data;
 
 	notify->removed = true;
+
+	return true;
 }
 
 struct att_disconn {
@@ -287,11 +289,13 @@ static bool match_disconn_removed(const void *a, const void *b)
 	return disconn->removed;
 }
 
-static void mark_disconn_removed(void *data, void *user_data)
+static bool mark_disconn_removed(void *data, void *user_data)
 {
 	struct att_disconn *disconn = data;
 
 	disconn->removed = true;
+
+	return true;
 }
 
 static bool encode_pdu(struct att_send_op *op, const void *pdu,
@@ -533,15 +537,17 @@ static void wakeup_writer(struct bt_att *att)
 	att->writer_active = true;
 }
 
-static void disconn_handler(void *data, void *user_data)
+static bool disconn_handler(void *data, void *user_data)
 {
 	struct att_disconn *disconn = data;
 
 	if (disconn->removed)
-		return;
+		return true;
 
 	if (disconn->callback)
 		disconn->callback(disconn->user_data);
+
+	return true;
 }
 
 static bool disconnect_cb(struct io *io, void *user_data)
@@ -675,22 +681,24 @@ static bool opcode_match(uint8_t opcode, uint8_t test_opcode)
 	return opcode == test_opcode;
 }
 
-static void notify_handler(void *data, void *user_data)
+static bool notify_handler(void *data, void *user_data)
 {
 	struct att_notify *notify = data;
 	struct notify_data *not_data = user_data;
 
 	if (notify->removed)
-		return;
+		return true;
 
 	if (!opcode_match(notify->opcode, not_data->opcode))
-		return;
+		return true;
 
 	not_data->handler_found = true;
 
 	if (notify->callback)
 		notify->callback(not_data->opcode, not_data->pdu,
 					not_data->pdu_len, notify->user_data);
+
+	return true;
 }
 
 static void respond_not_supported(struct bt_att *att, uint8_t opcode)
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 463de3b..696cd13 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -244,7 +244,7 @@ static bool match_notify_data_handle_range(const void *a, const void *b)
 					chrc->value_handle <= range->end;
 }
 
-static void mark_notify_data_invalid_if_in_range(void *data, void *user_data)
+static bool mark_notify_data_invalid_if_in_range(void *data, void *user_data)
 {
 	struct notify_data *notify_data = data;
 	struct notify_chrc *chrc = notify_data->chrc;
@@ -253,6 +253,8 @@ static void mark_notify_data_invalid_if_in_range(void *data, void *user_data)
 	if (chrc->value_handle >= range->start &&
 					chrc->value_handle <= range->end)
 		notify_data->invalid = true;
+
+	return true;
 }
 
 static bool match_notify_chrc_handle_range(const void *a, const void *b)
@@ -1400,7 +1402,7 @@ static void complete_unregister_notify(void *data)
 	notify_data_write_ccc(notify_data, false, disable_ccc_callback);
 }
 
-static void notify_handler(void *data, void *user_data)
+static bool notify_handler(void *data, void *user_data)
 {
 	struct notify_data *notify_data = data;
 	struct pdu_data *pdu_data = user_data;
@@ -1408,12 +1410,12 @@ static void notify_handler(void *data, void *user_data)
 	const uint8_t *value = NULL;
 
 	if (notify_data->removed)
-		return;
+		return true;
 
 	value_handle = get_le16(pdu_data->pdu);
 
 	if (notify_data->chrc->value_handle != value_handle)
-		return;
+		return true;
 
 	if (pdu_data->length > 2)
 		value = pdu_data->pdu + 2;
@@ -1421,6 +1423,8 @@ static void notify_handler(void *data, void *user_data)
 	if (notify_data->notify)
 		notify_data->notify(value_handle, value, pdu_data->length - 2,
 							notify_data->user_data);
+
+	return true;
 }
 
 static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
@@ -1849,12 +1853,14 @@ static void read_long_op_unref(void *data)
 	free(op);
 }
 
-static void append_blob(void *data, void *user_data)
+static bool append_blob(void *data, void *user_data)
 {
 	struct blob *blob = data;
 	uint8_t *value = user_data;
 
 	memcpy(value + blob->offset, blob->data, blob->length);
+
+	return true;
 }
 
 static void complete_read_long_op(struct read_long_op *op, bool success,
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 98fb8a0..0682248 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -215,7 +215,7 @@ struct notify_data {
 	bool added;
 };
 
-static void handle_notify(void *data, void *user_data)
+static bool handle_notify(void *data, void *user_data)
 {
 	struct notify *notify = data;
 	struct notify_data *notify_data = user_data;
@@ -224,6 +224,8 @@ static void handle_notify(void *data, void *user_data)
 		notify->service_added(notify_data->attr, notify->user_data);
 	else
 		notify->service_removed(notify_data->attr, notify->user_data);
+
+	return true;
 }
 
 static void notify_service_changed(struct gatt_db *db,
@@ -448,35 +450,31 @@ struct insert_loc_data {
 	struct gatt_db_service *cur;
 	uint16_t start, end;
 	bool fail;
-	bool done;
 };
 
-static void search_for_insert_loc(void *data, void *user_data)
+static bool search_for_insert_loc(void *data, void *user_data)
 {
 	struct insert_loc_data *loc_data = user_data;
 	struct gatt_db_service *service = data;
 	uint16_t cur_start, cur_end;
 
-	if (loc_data->done)
-		return;
-
 	gatt_db_service_get_handles(service, &cur_start, &cur_end);
 
 	/* Abort if the requested range overlaps with an existing service. */
 	if ((loc_data->start >= cur_start && loc_data->start <= cur_end) ||
 		(loc_data->end >= cur_start && loc_data->end <= cur_end)) {
 		loc_data->fail = true;
-		loc_data->done = true;
-		return;
+		return false;
 	}
 
 	/* Check if this is where the service should be inserted. */
 	if (loc_data->end < cur_start) {
-		loc_data->done = true;
-		return;
+		return false;
 	}
 
 	loc_data->cur = service;
+
+	return true;
 }
 
 struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
@@ -788,47 +786,43 @@ struct read_by_group_type_data {
 	uint16_t start_handle;
 	uint16_t end_handle;
 	uint16_t uuid_size;
-	bool stop_search;
 };
 
-static void read_by_group_type(void *data, void *user_data)
+static bool read_by_group_type(void *data, void *user_data)
 {
 	struct read_by_group_type_data *search_data = user_data;
 	struct gatt_db_service *service = data;
 	uint16_t grp_start, grp_end;
 
 	if (!service->active)
-		return;
-
-	/* Don't want more results as they have different size */
-	if (search_data->stop_search)
-		return;
+		return true;
 
 	if (bt_uuid_cmp(&search_data->uuid, &service->attributes[0]->uuid))
-		return;
+		return true;
 
 	grp_start = service->attributes[0]->handle;
 	grp_end = grp_start + service->num_handles - 1;
 
 	if (grp_end < search_data->start_handle ||
 				grp_start > search_data->end_handle)
-		return;
+		return true;
 
 	if (service->attributes[0]->handle < search_data->start_handle ||
 		service->attributes[0]->handle > search_data->end_handle)
-		return;
+		return true;
 
 	/* Remember size of uuid */
 	if (!search_data->uuid_size) {
 		search_data->uuid_size = service->attributes[0]->value_len;
 	} else if (search_data->uuid_size !=
 					service->attributes[0]->value_len) {
-		/* Don't want more results. This is last */
-		search_data->stop_search = true;
-		return;
+		/* Don't want more results (size differs). This is last */
+		return false;
 	}
 
 	queue_push_tail(search_data->queue, service->attributes[0]);
+
+	return true;
 }
 
 void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
@@ -843,7 +837,6 @@ void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
 	data.end_handle = end_handle;
 	data.queue = queue;
 	data.uuid_size = 0;
-	data.stop_search = false;
 
 	queue_foreach(db->services, read_by_group_type, &data);
 }
@@ -855,7 +848,7 @@ struct find_by_type_value_data {
 	uint16_t end_handle;
 };
 
-static void find_by_type(void *data, void *user_data)
+static bool find_by_type(void *data, void *user_data)
 {
 	struct find_by_type_value_data *search_data = user_data;
 	struct gatt_db_service *service = data;
@@ -863,7 +856,7 @@ static void find_by_type(void *data, void *user_data)
 	int i;
 
 	if (!service->active)
-		return;
+		return true;
 
 	for (i = 0; i < service->num_handles; i++) {
 		attribute = service->attributes[i];
@@ -880,6 +873,8 @@ static void find_by_type(void *data, void *user_data)
 
 		queue_push_tail(search_data->queue, attribute);
 	}
+
+	return true;
 }
 
 void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
@@ -904,7 +899,7 @@ struct read_by_type_data {
 	uint16_t end_handle;
 };
 
-static void read_by_type(void *data, void *user_data)
+static bool read_by_type(void *data, void *user_data)
 {
 	struct read_by_type_data *search_data = user_data;
 	struct gatt_db_service *service = data;
@@ -912,7 +907,7 @@ static void read_by_type(void *data, void *user_data)
 	int i;
 
 	if (!service->active)
-		return;
+		return true;
 
 	for (i = 0; i < service->num_handles; i++) {
 		attribute = service->attributes[i];
@@ -923,13 +918,15 @@ static void read_by_type(void *data, void *user_data)
 			continue;
 
 		if (attribute->handle > search_data->end_handle)
-			return;
+			return true;
 
 		if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
 			continue;
 
 		queue_push_tail(search_data->queue, attribute);
 	}
+
+	return true;
 }
 
 void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
@@ -953,7 +950,7 @@ struct find_information_data {
 	uint16_t end_handle;
 };
 
-static void find_information(void *data, void *user_data)
+static bool find_information(void *data, void *user_data)
 {
 	struct find_information_data *search_data = user_data;
 	struct gatt_db_service *service = data;
@@ -961,12 +958,12 @@ static void find_information(void *data, void *user_data)
 	int i;
 
 	if (!service->active)
-		return;
+		return true;
 
 	/* Check if service is in range */
 	if ((service->attributes[0]->handle + service->num_handles - 1) <
 						search_data->start_handle)
-		return;
+		return true;
 
 	for (i = 0; i < service->num_handles; i++) {
 		attribute = service->attributes[i];
@@ -977,10 +974,12 @@ static void find_information(void *data, void *user_data)
 			continue;
 
 		if (attribute->handle > search_data->end_handle)
-			return;
+			return true;
 
 		queue_push_tail(search_data->queue, attribute);
 	}
+
+	return true;
 }
 
 void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
@@ -1011,7 +1010,7 @@ struct foreach_data {
 	uint16_t start, end;
 };
 
-static void foreach_service_in_range(void *data, void *user_data)
+static bool foreach_service_in_range(void *data, void *user_data)
 {
 	struct gatt_db_service *service = data;
 	struct foreach_data *foreach_data = user_data;
@@ -1021,16 +1020,17 @@ static void foreach_service_in_range(void *data, void *user_data)
 	svc_start = get_handle_at_index(service, 0);
 
 	if (svc_start > foreach_data->end || svc_start < foreach_data->start)
-		return;
+		return true;
 
 	if (foreach_data->uuid) {
 		gatt_db_attribute_get_service_uuid(service->attributes[0],
 									&uuid);
 		if (bt_uuid_cmp(&uuid, foreach_data->uuid))
-			return;
+			return true;
 	}
 
 	foreach_data->func(service->attributes[0], foreach_data->user_data);
+	return true;
 }
 
 void gatt_db_foreach_service_in_range(struct gatt_db *db,
diff --git a/src/shared/hci.c b/src/shared/hci.c
index 9ab8c6e..529c0af 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -202,7 +202,7 @@ done:
 	wakeup_writer(hci);
 }
 
-static void process_notify(void *data, void *user_data)
+static bool process_notify(void *data, void *user_data)
 {
 	struct bt_hci_evt_hdr *hdr = user_data;
 	struct evt *evt = data;
@@ -210,6 +210,8 @@ static void process_notify(void *data, void *user_data)
 	if (evt->event == hdr->evt)
 		evt->callback(user_data + sizeof(struct bt_hci_evt_hdr),
 						hdr->plen, evt->user_data);
+
+	return true;
 }
 
 static void process_event(struct bt_hci *hci, const void *data, size_t size)
diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 1ed635d..d738b0a 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -255,20 +255,22 @@ struct event_index {
 	const void *param;
 };
 
-static void notify_handler(void *data, void *user_data)
+static bool notify_handler(void *data, void *user_data)
 {
 	struct mgmt_notify *notify = data;
 	struct event_index *match = user_data;
 
 	if (notify->event != match->event)
-		return;
+		return true;
 
 	if (notify->index != match->index && notify->index != MGMT_INDEX_NONE)
-		return;
+		return true;
 
 	if (notify->callback)
 		notify->callback(match->index, match->length, match->param,
 							notify->user_data);
+
+	return true;
 }
 
 static void process_notify(struct mgmt *mgmt, uint16_t event, uint16_t index,
diff --git a/src/shared/queue.c b/src/shared/queue.c
index a5155e7..b573c51 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -254,7 +254,8 @@ void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 
 		queue_entry_ref(entry);
 
-		function(entry->data, user_data);
+		if (!function(entry->data, user_data))
+			break;
 
 		next = entry->next;
 
diff --git a/src/shared/queue.h b/src/shared/queue.h
index 602b0ce..06aa512 100644
--- a/src/shared/queue.h
+++ b/src/shared/queue.h
@@ -37,7 +37,7 @@ void *queue_pop_head(struct queue *queue);
 void *queue_peek_head(struct queue *queue);
 void *queue_peek_tail(struct queue *queue);
 
-typedef void (*queue_foreach_func_t)(void *data, void *user_data);
+typedef bool (*queue_foreach_func_t)(void *data, void *user_data);
 
 void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 							void *user_data);
diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index f7ad0cb..8528f2d 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -63,16 +63,18 @@ static void uhid_free(struct bt_uhid *uhid)
 	free(uhid);
 }
 
-static void notify_handler(void *data, void *user_data)
+static bool notify_handler(void *data, void *user_data)
 {
 	struct uhid_notify *notify = data;
 	struct uhid_event *ev = user_data;
 
 	if (notify->event != ev->type)
-		return;
+		return true;
 
 	if (notify->func)
 		notify->func(ev, notify->user_data);
+
+	return true;
 }
 
 static bool uhid_read_handler(struct io *io, void *user_data)
diff --git a/unit/test-queue.c b/unit/test-queue.c
index cb85605..668b87f 100644
--- a/unit/test-queue.c
+++ b/unit/test-queue.c
@@ -58,11 +58,13 @@ static void test_basic(void)
 	queue_destroy(queue, NULL);
 }
 
-static void foreach_destroy(void *data, void *user_data)
+static bool foreach_destroy(void *data, void *user_data)
 {
 	struct queue *queue = user_data;
 
 	queue_destroy(queue, NULL);
+
+	return true;
 }
 
 static void test_foreach_destroy(void)
@@ -78,11 +80,13 @@ static void test_foreach_destroy(void)
 	queue_foreach(queue, foreach_destroy, queue);
 }
 
-static void foreach_remove(void *data, void *user_data)
+static bool foreach_remove(void *data, void *user_data)
 {
 	struct queue *queue = user_data;
 
 	g_assert(queue_remove(queue, data));
+
+	return true;
 }
 
 static void test_foreach_remove(void)
@@ -99,11 +103,13 @@ static void test_foreach_remove(void)
 	queue_destroy(queue, NULL);
 }
 
-static void foreach_remove_all(void *data, void *user_data)
+static bool foreach_remove_all(void *data, void *user_data)
 {
 	struct queue *queue = user_data;
 
 	queue_remove_all(queue, NULL, NULL, NULL);
+
+	return true;
 }
 
 static void test_foreach_remove_all(void)
@@ -120,12 +126,14 @@ static void test_foreach_remove_all(void)
 	queue_destroy(queue, NULL);
 }
 
-static void foreach_remove_backward(void *data, void *user_data)
+static bool foreach_remove_backward(void *data, void *user_data)
 {
 	struct queue *queue = user_data;
 
 	queue_remove(queue, UINT_TO_PTR(2));
 	queue_remove(queue, UINT_TO_PTR(1));
+
+	return true;
 }
 
 static void test_foreach_remove_backward(void)
-- 
2.2.0.rc0.207.ga3a616c

