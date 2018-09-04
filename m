Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/1] mesh: Add start up management command chain
Date: Tue,  4 Sep 2018 13:00:43 -0700
Message-Id: <20180904200043.7240-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows co-existense of meshd and bluetoothd. meshd will
automatically take control of the first available LE-capable
controller that is not in use , i.e., is poered down.
---
 Makefile.mesh |   4 +-
 mesh/btmesh.c |   5 +-
 mesh/main.c   |  22 ++---
 mesh/mesh.c   | 253 +++++++++++++++++++++++++++++++++++++++++++++-----
 mesh/mesh.h   |   4 +-
 mesh/net.c    |  49 +++++-----
 6 files changed, 269 insertions(+), 68 deletions(-)

diff --git a/Makefile.mesh b/Makefile.mesh
index 643b1a59a..e93e68e38 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -23,7 +23,7 @@ libexec_PROGRAMS += mesh/meshd
 mesh_meshd_SOURCES = $(mesh_sources) mesh/main.c
 
 mesh_meshd_LDADD = src/shared/ecc.lo src/shared/queue.lo src/shared/io-ell.lo \
-				src/shared/util.lo src/shared/hci.lo \
+				src/shared/util.lo src/shared/hci.lo src/shared/mgmt.lo \
 				@DBUS_LIBS@ @ELL_LIBS@ -ljson-c
 
 noinst_PROGRAMS += mesh/btmesh
@@ -34,7 +34,7 @@ mesh_btmesh_SOURCES = $(mesh_sources) \
 						mesh/btmesh.c
 
 mesh_btmesh_LDADD = src/shared/ecc.lo src/shared/queue.lo src/shared/io-ell.lo \
-				src/shared/util.lo src/shared/hci.lo \
+				src/shared/util.lo src/shared/hci.lo src/shared/mgmt.lo \
 				src/libshared-mainloop.la \
 				-lreadline @ELL_LIBS@ -ljson-c
 
diff --git a/mesh/btmesh.c b/mesh/btmesh.c
index c312d85db..108ec39f3 100644
--- a/mesh/btmesh.c
+++ b/mesh/btmesh.c
@@ -153,8 +153,8 @@ int main(int argc, char *argv[])
 
 	l_info("Starting mesh on hci%d\n", index);
 
-	mesh = mesh_create(index);
-	if (!mesh || !mesh_load_config(mesh, config_option)) {
+	mesh = mesh_new(index, config_option);
+	if (!mesh) {
 		l_info("Failed to create mesh\n");
 		bt_shell_cleanup();
 		return EXIT_FAILURE;
@@ -170,6 +170,7 @@ int main(int argc, char *argv[])
 	bt_shell_run();
 
 	mesh_unref(mesh);
+	mesh_cleanup();
 	l_main_exit();
 
 	return status;
diff --git a/mesh/main.c b/mesh/main.c
index 8c03f51eb..289b0582b 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -30,6 +30,9 @@
 #include <sys/stat.h>
 #include <ell/ell.h>
 
+#include "lib/bluetooth.h"
+#include "lib/mgmt.h"
+
 #include "mesh/mesh.h"
 #include "mesh/net.h"
 #include "mesh/storage.h"
@@ -81,6 +84,7 @@ int main(int argc, char *argv[])
 	sigset_t mask;
 	struct bt_mesh *mesh = NULL;
 	const char *config_file = NULL;
+	int index = MGMT_INDEX_NONE;
 
 	if (!l_main_init())
 		return -1;
@@ -107,12 +111,7 @@ int main(int argc, char *argv[])
 				goto done;
 			}
 
-			mesh = mesh_create(atoi(str));
-			if (!mesh) {
-				l_error("Failed to initialize mesh");
-				status = EXIT_FAILURE;
-				goto done;
-			}
+			index = atoi(str);
 
 			break;
 		case 'n':
@@ -135,14 +134,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (!mesh) {
-		usage();
-		status = EXIT_FAILURE;
-		goto done;
-	}
-
-	if (!mesh_load_config(mesh, config_file)) {
-		l_error("Failed to load mesh configuration: %s", config_file);
+	if (!mesh_new(index, config_file)) {
+		l_error("Failed to initialize mesh");
 		status = EXIT_FAILURE;
 		goto done;
 	}
@@ -168,6 +161,7 @@ int main(int argc, char *argv[])
 
 done:
 	mesh_unref(mesh);
+	mesh_cleanup();
 	l_main_exit();
 
 	return status;
diff --git a/mesh/mesh.c b/mesh/mesh.c
index a6f733f5c..3fba0140c 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -26,9 +26,11 @@
 #include <ell/ell.h>
 
 #include "lib/bluetooth.h"
+#include "lib/mgmt.h"
 
-#include "mesh/mesh-defs.h"
+#include "src/shared/mgmt.h"
 
+#include "mesh/mesh-defs.h"
 #include "mesh/mesh-io.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
@@ -44,11 +46,25 @@ struct scan_filter {
 
 struct bt_mesh {
 	struct mesh_net *net;
-	int ref_count;
+	struct mesh_io *io;
 	struct l_queue *filters;
+	int ref_count;
+	uint16_t index;
+	uint16_t req_index;
 	uint8_t max_filters;
 };
 
+static struct l_queue *controllers;
+static struct l_queue *mesh_list;
+static struct mgmt *mgmt_mesh;
+static bool initialized;
+static struct bt_mesh *current;
+
+static bool simple_match(const void *a, const void *b)
+{
+	return a == b;
+}
+
 static void save_exit_config(struct bt_mesh *mesh)
 {
 	const char *cfg_filename;
@@ -64,36 +80,233 @@ static void save_exit_config(struct bt_mesh *mesh)
 		l_info("Saved final configuration to %s", cfg_filename);
 }
 
-struct bt_mesh *mesh_create(uint16_t index)
+static void start_io(struct bt_mesh *mesh, uint16_t index)
 {
-	struct bt_mesh *mesh;
 	struct mesh_io *io;
 	struct mesh_io_caps caps;
 
+	l_debug("Starting mesh on hci %u", index);
+
+	io = mesh_io_new(index, MESH_IO_TYPE_GENERIC);
+	if (!io) {
+		l_error("Failed to start mesh io (hci %u)", index);
+		current = NULL;
+		return;
+	}
+
+	mesh_io_get_caps(io, &caps);
+	mesh->max_filters = caps.max_num_filters;
+
+	mesh_net_attach(mesh->net, io);
+	mesh_net_set_window_accuracy(mesh->net, caps.window_accuracy);
+	mesh->io = io;
+	mesh->index = index;
+
+	current = NULL;
+
+	l_debug("Started mesh (io %p) on hci %u", mesh->io, index);
+}
+
+static void read_info_cb(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	uint16_t index = L_PTR_TO_UINT(user_data);
+	const struct mgmt_rp_read_info *rp = param;
+	uint32_t current_settings, supported_settings;
+
+	if (!current)
+		/* Already initialized */
+		return;
+
+	l_debug("hci %u status 0x%02x", index, status);
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		l_error("Failed to read info for hci index %u: %s (0x%02x)",
+					index, mgmt_errstr(status), status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		l_error("Read info response too short");
+		return;
+	}
+
+	current_settings = btohl(rp->current_settings);
+	supported_settings = btohl(rp->supported_settings);
+
+	l_debug("settings: supp %8.8x curr %8.8x",
+					supported_settings, current_settings);
+
+	if (current_settings & MGMT_SETTING_POWERED) {
+		l_info("Controller hci %u is in use", index);
+		return;
+	}
+
+	if (!(supported_settings & MGMT_SETTING_LE)) {
+		l_info("Controller hci %u does not support LE", index);
+		return;
+	}
+
+	start_io(current, index);
+}
+
+static void index_added(uint16_t index, uint16_t length, const void *param,
+							void *user_data)
+{
+	l_debug("hci device %u", index);
+
+	if (!current)
+		return;
+
+	if (current->req_index != MGMT_INDEX_NONE &&
+					index != current->req_index) {
+		l_debug("Ignore index %d", index);
+		return;
+	}
+
+	if (l_queue_find(controllers, simple_match, L_UINT_TO_PTR(index)))
+		return;
+
+	l_queue_push_tail(controllers, L_UINT_TO_PTR(index));
+
+	if (mgmt_send(mgmt_mesh, MGMT_OP_READ_INFO, index, 0, NULL,
+			read_info_cb, L_UINT_TO_PTR(index), NULL) > 0)
+		return;
+
+	l_queue_remove(controllers, L_UINT_TO_PTR(index));
+}
+
+static void index_removed(uint16_t index, uint16_t length, const void *param,
+							void *user_data)
+{
+	l_warn("Hci dev %4.4x removed", index);
+	l_queue_remove(controllers, L_UINT_TO_PTR(index));
+}
+
+static void read_index_list_cb(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_read_index_list *rp = param;
+	uint16_t num;
+	int i;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		l_error("Failed to read index list: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		l_error("Read index list response sixe too short");
+		return;
+	}
+
+	num = btohs(rp->num_controllers);
+
+	l_debug("Number of controllers: %u", num);
+
+	if (num * sizeof(uint16_t) + sizeof(*rp) != length) {
+		l_error("Incorrect packet size for index list response");
+		return;
+	}
+
+	for (i = 0; i < num; i++) {
+		uint16_t index;
+
+		index = btohs(rp->index[i]);
+		index_added(index, 0, NULL, user_data);
+	}
+}
+
+static bool load_config(struct bt_mesh *mesh, const char *in_config_name)
+{
+	if (!mesh->net)
+		return false;
+
+	if (!storage_parse_config(mesh->net, in_config_name))
+		return false;
+
+	/* Register foundational models */
+	mesh_config_srv_init(mesh->net, PRIMARY_ELE_IDX);
+
+	return true;
+}
+
+static bool init_mesh(void)
+{
+	if (initialized)
+		return true;
+
+	controllers = l_queue_new();
+	if (!controllers)
+		return false;
+
+	mesh_list = l_queue_new();
+	if (!mesh_list)
+		return false;
+
+	mgmt_mesh = mgmt_new_default();
+	if (!mgmt_mesh)
+		goto fail;
+
+	mgmt_register(mgmt_mesh, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
+						index_added, NULL, NULL);
+	mgmt_register(mgmt_mesh, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
+						index_removed, NULL, NULL);
+
+	initialized = true;
+	return true;
+
+fail:
+	l_error("Failed to initialize mesh management");
+
+	l_queue_destroy(controllers, NULL);
+
+	return false;
+}
+
+struct bt_mesh *mesh_new(uint16_t index, const char *config_file)
+{
+	struct bt_mesh *mesh;
+
+	if (!init_mesh())
+		return NULL;
+
 	mesh = l_new(struct bt_mesh, 1);
 	if (!mesh)
 		return NULL;
 
+	mesh->req_index = index;
+	mesh->index = MGMT_INDEX_NONE;
+
 	mesh->net = mesh_net_new(index);
 	if (!mesh->net) {
 		l_free(mesh);
 		return NULL;
 	}
 
-	io = mesh_io_new(index, MESH_IO_TYPE_GENERIC);
-	if (!io) {
-		mesh_net_unref(mesh->net);
+	if (!load_config(mesh, config_file)) {
+		l_error("Failed to load mesh configuration: %s", config_file);
 		l_free(mesh);
 		return NULL;
 	}
 
-	mesh_io_get_caps(io, &caps);
-	mesh->max_filters = caps.max_num_filters;
+	/*
+	 * TODO: Check if another mesh is searching for io.
+	 * If so, add to pending list and return.
+	 */
+	l_debug("send read index_list");
+	if (mgmt_send(mgmt_mesh, MGMT_OP_READ_INDEX_LIST,
+				MGMT_INDEX_NONE, 0, NULL,
+				read_index_list_cb, mesh, NULL) > 0) {
+		current = mesh;
+		l_queue_push_tail(mesh_list, mesh);
+		return mesh_ref(mesh);
+	}
 
-	mesh_net_attach(mesh->net, io);
-	mesh_net_set_window_accuracy(mesh->net, caps.window_accuracy);
+	l_free(mesh);
 
-	return mesh_ref(mesh);
+	return NULL;
 }
 
 struct bt_mesh *mesh_ref(struct bt_mesh *mesh)
@@ -127,18 +340,15 @@ void mesh_unref(struct bt_mesh *mesh)
 		mesh_io_destroy(io);
 
 	mesh_net_unref(mesh->net);
+	l_queue_remove(mesh_list, mesh);
 	l_free(mesh);
 }
 
-bool mesh_load_config(struct bt_mesh *mesh, const char *in_config_name)
+void mesh_cleanup(void)
 {
-	if (!storage_parse_config(mesh->net, in_config_name))
-		return false;
-
-	/* Register foundational models */
-	mesh_config_srv_init(mesh->net, PRIMARY_ELE_IDX);
-
-	return true;
+	l_queue_destroy(controllers, NULL);
+	l_queue_destroy(mesh_list, NULL);
+	mgmt_unref(mgmt_mesh);
 }
 
 bool mesh_set_output(struct bt_mesh *mesh, const char *config_name)
@@ -177,8 +387,5 @@ const char *mesh_status_str(uint8_t err)
 
 struct mesh_net *mesh_get_net(struct bt_mesh *mesh)
 {
-	if (!mesh)
-		return NULL;
-
 	return mesh->net;
 }
diff --git a/mesh/mesh.h b/mesh/mesh.h
index 7cd1e6158..8d389883b 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -21,11 +21,11 @@
 struct bt_mesh;
 struct mesh_net;
 
-struct bt_mesh *mesh_create(uint16_t index);
+struct bt_mesh *mesh_new(uint16_t index, const char *in_config_name);
 struct bt_mesh *mesh_ref(struct bt_mesh *mesh);
 void mesh_unref(struct bt_mesh *mesh);
-bool mesh_load_config(struct bt_mesh *mesh, const char *in_config_name);
 bool mesh_set_output(struct bt_mesh *mesh, const char *out_config_name);
+void mesh_cleanup(void);
 const char *mesh_status_str(uint8_t err);
 
 /* Command line testing */
diff --git a/mesh/net.c b/mesh/net.c
index 544f9efa5..fb17e639d 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1133,7 +1133,8 @@ int mesh_net_add_key(struct mesh_net *net, bool update, uint16_t idx,
 		return MESH_STATUS_STORAGE_FAIL;
 	}
 
-	start_network_beacon(subnet, net);
+	if (net->io)
+		start_network_beacon(subnet, net);
 
 	return MESH_STATUS_SUCCESS;
 }
@@ -3099,13 +3100,34 @@ bool mesh_net_set_beacon_mode(struct mesh_net *net, bool enable)
 	return true;
 }
 
-
 bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 {
 	if (!net)
 		return false;
 
 	net->io = io;
+	if (net->provisioned) {
+
+		mesh_io_register_recv_cb(io, MESH_IO_FILTER_BEACON,
+							beacon_recv, net);
+		mesh_io_register_recv_cb(io, MESH_IO_FILTER_NET,
+							net_msg_recv, net);
+		l_queue_foreach(net->subnets, start_network_beacon, net);
+
+	} else {
+		uint8_t *uuid = node_uuid_get(net->local_node);
+
+		if (!uuid)
+			return false;
+
+		mesh_io_deregister_recv_cb(io, MESH_IO_FILTER_BEACON);
+		mesh_io_deregister_recv_cb(io, MESH_IO_FILTER_NET);
+
+		mesh_prov_listen(net, uuid, (uint8_t *) &net->prov_caps,
+					acceptor_prov_open,
+					acceptor_prov_close,
+					acceptor_prov_receive, net);
+	}
 
 	return true;
 }
@@ -4150,33 +4172,10 @@ bool mesh_net_provisioned_new(struct mesh_net *net, uint8_t device_key[16],
 
 void mesh_net_provisioned_set(struct mesh_net *net, bool provisioned)
 {
-	struct mesh_io *io;
-
 	if (!net)
 		return;
 
 	net->provisioned = provisioned;
-	io = net->io;
-
-	if (provisioned) {
-		mesh_io_register_recv_cb(io, MESH_IO_FILTER_BEACON,
-							beacon_recv, net);
-		mesh_io_register_recv_cb(io, MESH_IO_FILTER_NET,
-							net_msg_recv, net);
-	} else {
-		uint8_t *uuid = node_uuid_get(net->local_node);
-
-		if (!uuid)
-			return;
-
-		mesh_io_deregister_recv_cb(io, MESH_IO_FILTER_BEACON);
-		mesh_io_deregister_recv_cb(io, MESH_IO_FILTER_NET);
-
-		mesh_prov_listen(net, uuid, (uint8_t *) &net->prov_caps,
-					acceptor_prov_open,
-					acceptor_prov_close,
-					acceptor_prov_receive, net);
-	}
 }
 
 bool mesh_net_provisioned_get(struct mesh_net *net)
-- 
2.17.1
