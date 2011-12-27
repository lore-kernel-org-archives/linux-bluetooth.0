Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/8] attrib-server: Initial steps towards multi-adapter GATT server support
Date: Tue, 27 Dec 2011 15:33:12 +0100
Message-Id: <1324996399-20245-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1324996399-20245-1-git-send-email-sancane@gmail.com>
References: <1324996399-20245-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need neither to init nor stop gatt server whenever the demon
starts and finishes the execution, instead of doing that, we init
or stop the GATT server when the adapter is initialized or removed.
---
 src/adapter.c       |    7 +++
 src/adapter.h       |    3 +
 src/attrib-server.c |  106 +++++++++++++++++++++++++++++++++++---------------
 src/hcid.h          |    3 -
 src/main.c          |    8 ----
 5 files changed, 84 insertions(+), 43 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2d9e368..5fd6802 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2484,6 +2484,10 @@ gboolean adapter_init(struct btd_adapter *adapter)
 	}
 
 	sdp_init_services_list(&adapter->bdaddr);
+
+	if (main_opts.attrib_server)
+		btd_adapter_gatt_server_start(adapter);
+
 	load_drivers(adapter);
 	clear_blocked(adapter);
 	load_devices(adapter);
@@ -2543,6 +2547,9 @@ void adapter_remove(struct btd_adapter *adapter)
 	g_slist_free(adapter->devices);
 
 	unload_drivers(adapter);
+	if (main_opts.attrib_server)
+		btd_adapter_gatt_server_stop(adapter);
+
 	g_slist_free(adapter->pin_callbacks);
 
 	/* Return adapter to down state if it was not up on init */
diff --git a/src/adapter.h b/src/adapter.h
index 3e93441..1c1768e 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -282,3 +282,6 @@ int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
 
 int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 							bdaddr_t *bdaddr);
+
+int btd_adapter_gatt_server_start(struct btd_adapter *adapter);
+void btd_adapter_gatt_server_stop(struct btd_adapter *adapter);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index b767b72..452e72b 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -53,6 +53,13 @@
 #include "attrib-server.h"
 
 static GSList *database = NULL;
+static GSList *servers = NULL;
+
+struct gatt_server {
+	struct btd_adapter *adapter;
+	GIOChannel *l2cap_io;
+	GIOChannel *le_io;
+};
 
 struct gatt_channel {
 	bdaddr_t src;
@@ -71,7 +78,6 @@ struct group_elem {
 	uint16_t len;
 };
 
-static GIOChannel *l2cap_io = NULL;
 static GIOChannel *le_io = NULL;
 static GSList *clients = NULL;
 static uint32_t gatt_sdp_handle = 0;
@@ -94,6 +100,35 @@ static bt_uuid_t ccc_uuid = {
 			.value.u16 = GATT_CLIENT_CHARAC_CFG_UUID
 };
 
+static void gatt_server_free(struct gatt_server *server)
+{
+	if (server->l2cap_io != NULL) {
+		g_io_channel_unref(server->l2cap_io);
+		g_io_channel_shutdown(server->l2cap_io, FALSE, NULL);
+	}
+
+	if (server->le_io != NULL) {
+		g_io_channel_unref(server->le_io);
+		g_io_channel_shutdown(server->le_io, FALSE, NULL);
+	}
+
+	if (server->adapter != NULL)
+		btd_adapter_unref(server->adapter);
+
+	g_free(server);
+}
+
+static gint adapter_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_server *server = a;
+	const struct btd_adapter *adapter = b;
+
+	if (server->adapter == adapter)
+		return 0;
+
+	return -1;
+}
+
 static sdp_record_t *server_record_new(uuid_t *uuid, uint16_t start, uint16_t end)
 {
 	sdp_list_t *svclass_id, *apseq, *proto[2], *root, *aproto;
@@ -1012,66 +1047,73 @@ failed:
 	return FALSE;
 }
 
-int attrib_server_init(void)
+int btd_adapter_gatt_server_start(struct btd_adapter *adapter)
 {
+	struct gatt_server *server;
 	GError *gerr = NULL;
+	bdaddr_t addr;
+
+	DBG("Start GATT server in hci%d", adapter_get_dev_id(adapter));
+
+	server = g_new0(struct gatt_server, 1);
+	server->adapter = btd_adapter_ref(adapter);
+
+	adapter_get_address(server->adapter, &addr);
 
 	/* BR/EDR socket */
-	l2cap_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
+	server->l2cap_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
 					NULL, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR, BDADDR_ANY,
+					BT_IO_OPT_SOURCE_BDADDR, &addr,
 					BT_IO_OPT_PSM, ATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
-	if (l2cap_io == NULL) {
+
+	if (server->l2cap_io == NULL) {
 		error("%s", gerr->message);
 		g_error_free(gerr);
+		gatt_server_free(server);
 		return -1;
 	}
 
-	if (!register_core_services())
-		goto failed;
+	if (!register_core_services()) {
+		gatt_server_free(server);
+		return -1;
+	}
 
 	/* LE socket */
-	le_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
-					&le_io, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR, BDADDR_ANY,
+	server->le_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
+					&server->le_io, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR, &addr,
 					BT_IO_OPT_CID, ATT_CID,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
-	if (le_io == NULL) {
+
+	if (server->le_io == NULL) {
 		error("%s", gerr->message);
 		g_error_free(gerr);
 		/* Doesn't have LE support, continue */
 	}
 
+	servers = g_slist_prepend(servers, server);
 	return 0;
-
-failed:
-	g_io_channel_unref(l2cap_io);
-	l2cap_io = NULL;
-
-	if (le_io) {
-		g_io_channel_unref(le_io);
-		le_io = NULL;
-	}
-
-	return -1;
 }
 
-void attrib_server_exit(void)
+void btd_adapter_gatt_server_stop(struct btd_adapter *adapter)
 {
-	g_slist_free_full(database, attrib_free);
+	struct gatt_server *server;
+	GSList *l;
 
-	if (l2cap_io) {
-		g_io_channel_unref(l2cap_io);
-		g_io_channel_shutdown(l2cap_io, FALSE, NULL);
-	}
+	l = g_slist_find_custom(servers, adapter, adapter_cmp);
+	if (l == NULL)
+		return;
 
-	if (le_io) {
-		g_io_channel_unref(le_io);
-		g_io_channel_shutdown(le_io, FALSE, NULL);
-	}
+	DBG("Stop GATT server in hci%d", adapter_get_dev_id(adapter));
+
+	server = l->data;
+	servers = g_slist_remove(servers, server);
+	gatt_server_free(server);
+
+	g_slist_free_full(database, attrib_free);
 
 	g_slist_free_full(clients, (GDestroyNotify) channel_free);
 
diff --git a/src/hcid.h b/src/hcid.h
index e993a16..1987b7d 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -63,6 +63,3 @@ void plugin_cleanup(void);
 
 void rfkill_init(void);
 void rfkill_exit(void);
-
-int attrib_server_init(void);
-void attrib_server_exit(void);
diff --git a/src/main.c b/src/main.c
index 3031f09..74ec3fa 100644
--- a/src/main.c
+++ b/src/main.c
@@ -521,11 +521,6 @@ int main(int argc, char *argv[])
 
 	start_sdp_server(mtu, main_opts.deviceid, SDP_SERVER_COMPAT);
 
-	if (main_opts.attrib_server) {
-		if (attrib_server_init() < 0)
-			error("Can't initialize attribute server");
-	}
-
 	/* Loading plugins has to be done after D-Bus has been setup since
 	 * the plugins might wanna expose some paths on the bus. However the
 	 * best order of how to init various subsystems of the Bluetooth
@@ -551,9 +546,6 @@ int main(int argc, char *argv[])
 
 	plugin_cleanup();
 
-	if (main_opts.attrib_server)
-		attrib_server_exit();
-
 	stop_sdp_server();
 
 	agent_exit();
-- 
1.7.8.1

