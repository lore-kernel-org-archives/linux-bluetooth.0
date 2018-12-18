Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206CDC43444
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 22:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F4D2184C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 22:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeLRWb4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:31:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:60670 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbeLRWbz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 17:31:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 14:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="101704179"
Received: from bgix-dell-lap.sea.intel.com ([10.241.111.161])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2018 14:31:51 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org
Subject: [PATCH BlueZ v4 15/30] mesh: Re-architect for DBus API
Date:   Tue, 18 Dec 2018 14:31:24 -0800
Message-Id: <20181218223139.8041-16-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181218223139.8041-1-brian.gix@intel.com>
References: <20181218223139.8041-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

---
 mesh/mesh.c | 625 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 mesh/mesh.h |  27 ++-
 2 files changed, 505 insertions(+), 147 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index d1d409672..05232b225 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -36,9 +36,24 @@
 #include "mesh/node.h"
 #include "mesh/net.h"
 #include "mesh/storage.h"
-#include "mesh/cfgmod.h"
+#include "mesh/prov.h"
+#include "mesh/provision.h"
 #include "mesh/model.h"
+#include "mesh/dbus.h"
+#include "mesh/error.h"
 #include "mesh/mesh.h"
+#include "mesh/agent.h"
+
+#define MESH_COMP_MAX_LEN 378
+
+/*
+ * The default values for mesh configuration. Can be
+ * overwritten by values from mesh.conf
+ */
+#define DEFAULT_PROV_TIMEOUT 60
+#define DEFAULT_ALGORITHMS 0x0001
+
+/* TODO: add more default values */
 
 struct scan_filter {
 	uint8_t id;
@@ -46,42 +61,49 @@ struct scan_filter {
 };
 
 struct bt_mesh {
-	struct mesh_net *net;
 	struct mesh_io *io;
 	struct l_queue *filters;
-	int ref_count;
-	uint16_t index;
+	prov_rx_cb_t prov_rx;
+	void *prov_data;
+	uint32_t prov_timeout;
+	uint16_t algorithms;
 	uint16_t req_index;
 	uint8_t max_filters;
 };
 
+struct join_data{
+	struct l_dbus_message *msg;
+	struct mesh_agent *agent;
+	const char *sender;
+	const char *app_path;
+	struct mesh_node *node;
+	uint32_t disc_watch;
+	uint8_t uuid[16];
+};
+
+struct attach_data {
+	uint64_t token;
+	struct l_dbus_message *msg;
+	const char *app;
+};
+
+static struct bt_mesh mesh;
 static struct l_queue *controllers;
-static struct l_queue *mesh_list;
 static struct mgmt *mgmt_mesh;
 static bool initialized;
-static struct bt_mesh *current;
+
+/* We allow only one outstanding Join request */
+static struct join_data *join_pending;
+
+/* Pending Attach requests */
+static struct l_queue *attach_queue;
 
 static bool simple_match(const void *a, const void *b)
 {
 	return a == b;
 }
 
-static void save_exit_config(struct bt_mesh *mesh)
-{
-	const char *cfg_filename;
-
-	if (!mesh_net_cfg_file_get(mesh->net, &cfg_filename) || !cfg_filename)
-		return;
-
-	/* Preserve the last sequence number before saving configuration */
-	storage_local_write_sequence_number(mesh->net,
-					mesh_net_get_seq_num(mesh->net));
-
-	if (storage_save_config(mesh->net, cfg_filename, true, NULL, NULL))
-		l_info("Saved final configuration to %s", cfg_filename);
-}
-
-static void start_io(struct bt_mesh *mesh, uint16_t index)
+static void start_io(uint16_t index)
 {
 	struct mesh_io *io;
 	struct mesh_io_caps caps;
@@ -91,21 +113,70 @@ static void start_io(struct bt_mesh *mesh, uint16_t index)
 	io = mesh_io_new(index, MESH_IO_TYPE_GENERIC);
 	if (!io) {
 		l_error("Failed to start mesh io (hci %u)", index);
-		current = NULL;
 		return;
 	}
 
 	mesh_io_get_caps(io, &caps);
-	mesh->max_filters = caps.max_num_filters;
+	mesh.max_filters = caps.max_num_filters;
+
+	mesh.io = io;
+
+	l_debug("Started mesh (io %p) on hci %u", mesh.io, index);
+
+	node_attach_io(io);
+}
+
+/* Used for any outbound traffic that doesn't have Friendship Constraints */
+/* This includes Beacons, Provisioning and unrestricted Network Traffic */
+bool mesh_send_pkt(uint8_t count, uint16_t interval,
+					uint8_t *data, uint16_t len)
+{
+	struct mesh_io_send_info info = {
+		.type = MESH_IO_TIMING_TYPE_GENERAL,
+		.u.gen.cnt = count,
+		.u.gen.interval = interval,
+		.u.gen.max_delay = 0,
+		.u.gen.min_delay = 0,
+	};
+
+	return mesh_io_send(mesh.io, &info, data, len);
+}
+
+bool mesh_send_cancel(const uint8_t *filter, uint8_t len)
+{
+	return mesh_io_send_cancel(mesh.io, filter, len);
+}
 
-	mesh_net_attach(mesh->net, io);
-	mesh_net_set_window_accuracy(mesh->net, caps.window_accuracy);
-	mesh->io = io;
-	mesh->index = index;
+static void prov_rx(void *user_data, struct mesh_io_recv_info *info,
+					const uint8_t *data, uint16_t len)
+{
+	if (user_data != &mesh)
+		return;
+
+	if (mesh.prov_rx)
+		mesh.prov_rx(mesh.prov_data, data, len);
+}
+
+bool mesh_reg_prov_rx(prov_rx_cb_t cb, void *user_data)
+{
+	if (mesh.prov_rx && mesh.prov_rx != cb)
+		return false;
 
-	current = NULL;
+	mesh.prov_rx = cb;
+	mesh.prov_data = user_data;
 
-	l_debug("Started mesh (io %p) on hci %u", mesh->io, index);
+	return mesh_io_register_recv_cb(mesh.io, MESH_IO_FILTER_PROV,
+							prov_rx, &mesh);
+}
+
+void mesh_unreg_prov_rx(prov_rx_cb_t cb)
+{
+	if (mesh.prov_rx != cb)
+		return;
+
+	mesh.prov_rx = NULL;
+	mesh.prov_data = NULL;
+	mesh_io_deregister_recv_cb(mesh.io, MESH_IO_FILTER_PROV);
 }
 
 static void read_info_cb(uint8_t status, uint16_t length,
@@ -115,7 +186,7 @@ static void read_info_cb(uint8_t status, uint16_t length,
 	const struct mgmt_rp_read_info *rp = param;
 	uint32_t current_settings, supported_settings;
 
-	if (!current)
+	if (mesh.io)
 		/* Already initialized */
 		return;
 
@@ -148,7 +219,7 @@ static void read_info_cb(uint8_t status, uint16_t length,
 		return;
 	}
 
-	start_io(current, index);
+	start_io(index);
 }
 
 static void index_added(uint16_t index, uint16_t length, const void *param,
@@ -156,11 +227,8 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
 {
 	l_debug("hci device %u", index);
 
-	if (!current)
-		return;
-
-	if (current->req_index != MGMT_INDEX_NONE &&
-					index != current->req_index) {
+	if (mesh.req_index != MGMT_INDEX_NONE &&
+					index != mesh.req_index) {
 		l_debug("Ignore index %d", index);
 		return;
 	}
@@ -219,145 +287,100 @@ static void read_index_list_cb(uint8_t status, uint16_t length,
 	}
 }
 
-static bool load_config(struct bt_mesh *mesh, const char *in_config_name)
+static bool init_mgmt(void)
 {
-	if (!mesh->net)
-		return false;
-
-	if (!storage_parse_config(mesh->net, in_config_name))
+	mgmt_mesh = mgmt_new_default();
+	if (!mgmt_mesh)
 		return false;
 
-	/* Register foundational models */
-	mesh_config_srv_init(mesh->net, PRIMARY_ELE_IDX);
-
-	return true;
-}
-
-static bool init_mesh(void)
-{
-	if (initialized)
-		return true;
-
 	controllers = l_queue_new();
 	if (!controllers)
 		return false;
 
-	mesh_list = l_queue_new();
-	if (!mesh_list)
-		return false;
-
-	mgmt_mesh = mgmt_new_default();
-	if (!mgmt_mesh)
-		goto fail;
-
 	mgmt_register(mgmt_mesh, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
 						index_added, NULL, NULL);
 	mgmt_register(mgmt_mesh, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
 						index_removed, NULL, NULL);
-
-	initialized = true;
 	return true;
-
-fail:
-	l_error("Failed to initialize mesh management");
-
-	l_queue_destroy(controllers, NULL);
-
-	return false;
 }
 
-struct bt_mesh *mesh_new(uint16_t index, const char *config_file)
+bool mesh_init(uint16_t index, const char *config_dir)
 {
-	struct bt_mesh *mesh;
+	if (initialized)
+		return true;
+
+	if (!init_mgmt()) {
+		l_error("Failed to initialize mesh management");
+		return false;
+	}
 
-	if (!init_mesh())
-		return NULL;
+	mesh.req_index = index;
 
-	mesh = l_new(struct bt_mesh, 1);
-	if (!mesh)
-		return NULL;
+	mesh_model_init();
+	mesh_agent_init();
 
-	mesh->req_index = index;
-	mesh->index = MGMT_INDEX_NONE;
+	/* TODO: read mesh.conf */
+	mesh.prov_timeout = DEFAULT_PROV_TIMEOUT;
+	mesh.algorithms = DEFAULT_ALGORITHMS;
 
-	mesh->net = mesh_net_new(index);
-	if (!mesh->net) {
-		l_free(mesh);
-		return NULL;
-	}
+	if (!config_dir)
+		config_dir = MESH_STORAGEDIR;
 
-	if (!load_config(mesh, config_file)) {
-		l_error("Failed to load mesh configuration: %s", config_file);
-		l_free(mesh);
-		return NULL;
-	}
+	l_info("Loading node configuration from %s", config_dir);
+
+	if (!storage_load_nodes(config_dir))
+		return false;
 
-	/*
-	 * TODO: Check if another mesh is searching for io.
-	 * If so, add to pending list and return.
-	 */
 	l_debug("send read index_list");
 	if (mgmt_send(mgmt_mesh, MGMT_OP_READ_INDEX_LIST,
 				MGMT_INDEX_NONE, 0, NULL,
-				read_index_list_cb, mesh, NULL) > 0) {
-		current = mesh;
-		l_queue_push_tail(mesh_list, mesh);
-		return mesh_ref(mesh);
-	}
-
-	l_free(mesh);
+				read_index_list_cb, NULL, NULL) <= 0)
+		return false;
 
-	return NULL;
+	return true;
 }
 
-struct bt_mesh *mesh_ref(struct bt_mesh *mesh)
+static void attach_exit(void *data)
 {
-	if (!mesh)
-		return NULL;
-
-	__sync_fetch_and_add(&mesh->ref_count, 1);
+	struct l_dbus_message *reply;
+	struct attach_data *pending = data;
 
-	return mesh;
+	reply = dbus_error(pending->msg, MESH_ERROR_FAILED, "Failed. Exiting");
+	l_dbus_send(dbus_get_bus(), reply);
+	l_free(pending);
 }
 
-void mesh_unref(struct bt_mesh *mesh)
+void mesh_cleanup(void)
 {
-	struct mesh_io *io;
+	struct l_dbus_message *reply;
 
-	if (!mesh)
-		return;
+	mesh_io_destroy(mesh.io);
+	mgmt_unref(mgmt_mesh);
 
-	if (__sync_sub_and_fetch(&mesh->ref_count, 1))
-		return;
+	if (join_pending) {
+		reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED,
+							"Failed. Exiting");
+		l_dbus_send(dbus_get_bus(), reply);
 
-	if (mesh_net_provisioned_get(mesh->net))
-		save_exit_config(mesh);
+		if (join_pending->disc_watch)
+			dbus_disconnect_watch_remove(dbus_get_bus(),
+						join_pending->disc_watch);
 
-	node_cleanup(mesh->net);
+		if (join_pending->node)
+			node_free(join_pending->node);
 
-	storage_release(mesh->net);
-	io = mesh_net_detach(mesh->net);
-	if (io)
-		mesh_io_destroy(io);
+		l_free(join_pending);
+		join_pending = NULL;
+	}
 
-	mesh_net_unref(mesh->net);
-	l_queue_remove(mesh_list, mesh);
-	l_free(mesh);
-}
+	l_queue_destroy(attach_queue, attach_exit);
+	node_cleanup_all();
+	mesh_model_cleanup();
 
-void mesh_cleanup(void)
-{
 	l_queue_destroy(controllers, NULL);
-	l_queue_destroy(mesh_list, NULL);
-	mgmt_unref(mgmt_mesh);
-}
-
-bool mesh_set_output(struct bt_mesh *mesh, const char *config_name)
-{
-	if (!config_name)
-		return false;
-
-	return mesh_net_cfg_file_set(mesh->net, config_name);
+	l_dbus_object_remove_interface(dbus_get_bus(), BLUEZ_MESH_PATH,
+							MESH_NETWORK_INTERFACE);
+	l_dbus_unregister_interface(dbus_get_bus(), MESH_NETWORK_INTERFACE);
 }
 
 const char *mesh_status_str(uint8_t err)
@@ -386,7 +409,333 @@ const char *mesh_status_str(uint8_t err)
 	}
 }
 
-struct mesh_net *mesh_get_net(struct bt_mesh *mesh)
+static void free_pending_join_call(bool failed)
+{
+	if (!join_pending)
+		return;
+
+	if (join_pending->disc_watch)
+		dbus_disconnect_watch_remove(dbus_get_bus(),
+						join_pending->disc_watch);
+
+	mesh_agent_remove(join_pending->agent);
+
+	if (failed) {
+		storage_remove_node_config(join_pending->node);
+		mesh_agent_remove(join_pending->agent);
+	}
+
+	l_free(join_pending);
+	join_pending = NULL;
+}
+
+/* This is being called if the app exits unexpectedly */
+static void prov_disc_cb(struct l_dbus *bus, void *user_data)
+{
+	if (!join_pending)
+		return;
+
+	if (join_pending->msg)
+		l_dbus_message_unref(join_pending->msg);
+
+	acceptor_cancel(&mesh);
+
+	join_pending->disc_watch = 0;
+
+	free_pending_join_call(true);
+}
+
+static const char *prov_status_str(uint8_t status)
+{
+	switch (status) {
+	case PROV_ERR_SUCCESS:
+		return "success";
+	case PROV_ERR_INVALID_PDU:
+	case PROV_ERR_INVALID_FORMAT:
+	case PROV_ERR_UNEXPECTED_PDU:
+		return "bad-pdu";
+	case PROV_ERR_CONFIRM_FAILED:
+		return "confirmation-failed";
+	case PROV_ERR_INSUF_RESOURCE:
+		return "out-of-resources";
+	case PROV_ERR_DECRYPT_FAILED:
+		return "decryption-error";
+	case PROV_ERR_CANT_ASSIGN_ADDR:
+		return "cannot-assign-addresses";
+	case PROV_ERR_TIMEOUT:
+		return "timeout";
+	case PROV_ERR_UNEXPECTED_ERR:
+	default:
+		return "unexpected-error";
+	}
+}
+
+static void send_join_failed(const char *owner, const char *path,
+							uint8_t status)
+{
+	struct l_dbus_message *msg;
+	struct l_dbus *dbus = dbus_get_bus();
+
+	msg = l_dbus_message_new_method_call(dbus, owner, path,
+						MESH_APPLICATION_INTERFACE,
+						"JoinFailed");
+
+	l_dbus_message_set_arguments(msg, "s", prov_status_str(status));
+	l_dbus_send(dbus_get_bus(), msg);
+
+	free_pending_join_call(true);
+}
+
+static bool prov_complete_cb(void *user_data, uint8_t status,
+					struct mesh_prov_node_info *info)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg;
+	const char *owner;
+	const char *path;
+	const uint8_t *dev_key;
+
+	l_debug("Provisioning complete %s", prov_status_str(status));
+
+	if (!join_pending)
+		return false;
+
+	owner = join_pending->sender;
+	path = join_pending->app_path;
+
+	if (status == PROV_ERR_SUCCESS &&
+	    !node_add_pending_local(join_pending->node, info, mesh.io))
+		status = PROV_ERR_UNEXPECTED_ERR;
+
+	if (status != PROV_ERR_SUCCESS) {
+		send_join_failed(owner, path, status);
+		return false;
+	}
+
+	dev_key = node_get_device_key(join_pending->node);
+
+	msg = l_dbus_message_new_method_call(dbus, owner, path,
+						MESH_APPLICATION_INTERFACE,
+						"JoinComplete");
+
+	l_dbus_message_set_arguments(msg, "t", l_get_u64(dev_key));
+
+	l_dbus_send(dbus_get_bus(), msg);
+
+	free_pending_join_call(false);
+
+	return true;
+}
+
+static void node_init_cb(struct mesh_node *node, struct mesh_agent *agent)
+{
+	struct l_dbus_message *reply;
+	uint8_t num_ele;
+
+	if (!node) {
+		reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED,
+				"Failed to create node from application");
+		goto fail;
+	}
+
+	join_pending->node = node;
+	num_ele = node_get_num_elements(node);
+
+	if (!acceptor_start(num_ele, join_pending->uuid, mesh.algorithms,
+				mesh.prov_timeout, agent, prov_complete_cb,
+				&mesh))
+	{
+		reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED,
+				"Failed to start provisioning acceptor");
+		goto fail;
+	}
+
+	reply = l_dbus_message_new_method_return(join_pending->msg);
+	l_dbus_send(dbus_get_bus(), reply);
+	join_pending->msg = NULL;
+
+	return;
+
+fail:
+	l_dbus_send(dbus_get_bus(), reply);
+	mesh_agent_remove(join_pending->agent);
+	l_free(join_pending);
+	join_pending = NULL;
+}
+
+static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
 {
-	return mesh->net;
+	const char *app_path, *sender;
+	struct l_dbus_message_iter iter_uuid;
+	uint32_t n;
+
+	l_debug("Join network request");
+
+	if (join_pending)
+		return dbus_error(msg, MESH_ERROR_BUSY,
+						"Provisioning in progress");
+
+	if (!l_dbus_message_get_arguments(msg, "oay", &app_path,
+								&iter_uuid))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	join_pending = l_new(struct join_data, 1);
+
+	n = dbus_get_byte_array(&iter_uuid, join_pending->uuid,16);
+
+	if (n != 16) {
+		l_free(join_pending);
+		join_pending = NULL;
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad device UUID");
+	}
+
+	sender = l_dbus_message_get_sender(msg);
+
+	join_pending->sender = l_strdup(sender);
+	join_pending->disc_watch = dbus_disconnect_watch_add(dbus, sender,
+							prov_disc_cb, NULL);
+	join_pending->msg = l_dbus_message_ref(msg);
+	join_pending->app_path = app_path;
+
+	/* Try to create a temporary node */
+	node_join(app_path, sender, join_pending->uuid, node_init_cb);
+
+	return NULL;
+}
+
+static struct l_dbus_message *cancel_join_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct l_dbus_message *reply;
+
+	l_debug("Cancel Join");
+
+	if (!join_pending) {
+		reply = dbus_error(msg, MESH_ERROR_DOES_NOT_EXIST,
+							"No join in progress");
+		goto done;
+	}
+
+	acceptor_cancel(&mesh);
+
+	/* Return error to the original Join call */
+	if (join_pending->msg) {
+		reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED, NULL);
+		l_dbus_send(dbus_get_bus(), reply);
+	}
+
+	reply = l_dbus_message_new_method_return(msg);
+	l_dbus_message_set_arguments(reply, "");
+
+	free_pending_join_call(true);
+done:
+	return reply;
+}
+
+static bool match_attach_request(const void *a, const void *b)
+{
+	const struct attach_data *pending = a;
+	const uint64_t *token = b;
+
+	return *token == pending->token;
+}
+
+static void attach_ready_cb(int status, char *node_path, uint64_t token)
+{
+	struct l_dbus_message *reply;
+	struct attach_data *pending;
+
+	pending = l_queue_find(attach_queue, match_attach_request, &token);
+	if (!pending)
+		return;
+
+	if (status != MESH_ERROR_NONE) {
+		const char *desc = (status == MESH_ERROR_NOT_FOUND) ?
+				"Node match not found" : "Attach failed";
+		reply = dbus_error(pending->msg, status, desc);
+		goto done;
+	}
+
+	reply = l_dbus_message_new_method_return(pending->msg);
+
+	node_build_attach_reply(reply, token);
+
+done:
+	l_dbus_send(dbus_get_bus(), reply);
+	l_queue_remove(attach_queue, pending);
+	l_free(pending);
+}
+
+static struct l_dbus_message *attach_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint64_t token = 1;
+	const char *app_path, *sender;
+	struct attach_data *pending;
+
+	l_debug("Attach");
+
+	if (!l_dbus_message_get_arguments(msg, "ot", &app_path, &token))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	sender = l_dbus_message_get_sender(msg);
+
+	if (node_attach(app_path, sender, token, attach_ready_cb) !=
+								MESH_ERROR_NONE)
+		return dbus_error(msg, MESH_ERROR_NOT_FOUND,
+						"Matching node not found");
+
+	pending = l_new(struct attach_data, 1);
+
+	pending->token = token;
+	pending->msg = l_dbus_message_ref(msg);
+
+	if (!attach_queue)
+		attach_queue = l_queue_new();
+
+	l_queue_push_tail(attach_queue, pending);
+
+	return NULL;
+}
+
+static void setup_network_interface(struct l_dbus_interface *iface)
+{
+	l_dbus_interface_method(iface, "Join", 0, join_network_call, "",
+				"oay", "app", "uuid");
+
+	l_dbus_interface_method(iface, "Cancel", 0, cancel_join_call, "", "");
+
+	l_dbus_interface_method(iface, "Attach", 0, attach_call,
+				"oa(ya(qa{sv}))", "ot", "node", "configuration",
+				"app", "token");
+
+	/* TODO: Implement Leave method */
+}
+
+bool mesh_dbus_init(struct l_dbus *dbus)
+{
+	if (!l_dbus_register_interface(dbus, MESH_NETWORK_INTERFACE,
+						setup_network_interface,
+						NULL, false)) {
+		l_info("Unable to register %s interface",
+			       MESH_NETWORK_INTERFACE);
+		return false;
+	}
+
+	if (!l_dbus_object_add_interface(dbus, BLUEZ_MESH_PATH,
+						MESH_NETWORK_INTERFACE, NULL)) {
+		l_info("Unable to register the mesh object on '%s'",
+							MESH_NETWORK_INTERFACE);
+		l_dbus_unregister_interface(dbus, MESH_NETWORK_INTERFACE);
+		return false;
+	}
+
+	l_info("Added Network Interface on %s", BLUEZ_MESH_PATH);
+
+	return true;
 }
diff --git a/mesh/mesh.h b/mesh/mesh.h
index 8d389883b..1189f8276 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -18,15 +18,24 @@
  *
  */
 
-struct bt_mesh;
-struct mesh_net;
+#define BLUEZ_MESH_NAME "org.bluez.mesh"
 
-struct bt_mesh *mesh_new(uint16_t index, const char *in_config_name);
-struct bt_mesh *mesh_ref(struct bt_mesh *mesh);
-void mesh_unref(struct bt_mesh *mesh);
-bool mesh_set_output(struct bt_mesh *mesh, const char *out_config_name);
+#define MESH_NETWORK_INTERFACE "org.bluez.mesh.Network1"
+#define MESH_NODE_INTERFACE "org.bluez.mesh.Node1"
+#define MESH_ELEMENT_INTERFACE "org.bluez.mesh.Element1"
+#define MESH_APPLICATION_INTERFACE "org.bluez.mesh.Application1"
+#define MESH_PROVISION_AGENT_INTERFACE "org.bluez.mesh.ProvisionAgent1"
+#define ERROR_INTERFACE "org.bluez.mesh.Error"
+
+typedef void (*prov_rx_cb_t)(void *user_data, const uint8_t *data,
+								uint16_t len);
+bool mesh_init(uint16_t index, const char *in_config_name);
 void mesh_cleanup(void);
-const char *mesh_status_str(uint8_t err);
+bool mesh_dbus_init(struct l_dbus *dbus);
 
-/* Command line testing */
-struct mesh_net *mesh_get_net(struct bt_mesh *mesh);
+const char *mesh_status_str(uint8_t err);
+bool mesh_send_pkt(uint8_t count, uint16_t interval, uint8_t *data,
+								uint16_t len);
+bool mesh_send_cancel(const uint8_t *filter, uint8_t len);
+bool mesh_reg_prov_rx(prov_rx_cb_t cb, void *user_data);
+void mesh_unreg_prov_rx(prov_rx_cb_t cb);
-- 
2.14.5

