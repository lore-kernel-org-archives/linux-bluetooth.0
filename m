Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/8] attrib-server: Initial steps towards multi-adapter GATT server support
Date: Tue, 20 Dec 2011 16:57:54 +0100
Message-Id: <1324396681-27276-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1324396681-27276-1-git-send-email-sancane@gmail.com>
References: <1324396681-27276-1-git-send-email-sancane@gmail.com>
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
index a776997..57e4c12 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2483,6 +2483,10 @@ gboolean adapter_init(struct btd_adapter *adapter)
 	}
 
 	sdp_init_services_list(&adapter->bdaddr);
+
+	if (main_opts.attrib_server)
+		btd_adapter_gatt_server_start(adapter);
+
 	load_drivers(adapter);
 	clear_blocked(adapter);
 	load_devices(adapter);
@@ -2542,6 +2546,9 @@ void adapter_remove(struct btd_adapter *adapter)
 	g_slist_free(adapter->devices);
 
 	unload_drivers(adapter);
+	if (main_opts.attrib_server)
+		btd_adapter_gatt_server_stop(adapter);
+
 	g_slist_free(adapter->pin_callbacks);
 
 	/* Return adapter to down state if it was not up on init */
diff --git a/src/adapter.h b/src/adapter.h
index 23bc8a5..f6f35f2 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -277,3 +277,6 @@ int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
 
 int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 							bdaddr_t *bdaddr);
+
+int btd_adapter_gatt_server_start(struct btd_adapter *adapter);
+void btd_adapter_gatt_server_stop(struct btd_adapter *adapter);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index b767b72..24778e5 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -53,6 +53,13 @@
 #include "attrib-server.h"
 
 static GSList *database = NULL;
+static GSList *adapters = NULL;
+
+struct gatt_adapter {
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
 
+static void gatt_adapter_free(struct gatt_adapter *gadapter)
+{
+	if (gadapter->l2cap_io != NULL) {
+		g_io_channel_unref(gadapter->l2cap_io);
+		g_io_channel_shutdown(gadapter->l2cap_io, FALSE, NULL);
+	}
+
+	if (gadapter->le_io != NULL) {
+		g_io_channel_unref(gadapter->le_io);
+		g_io_channel_shutdown(gadapter->le_io, FALSE, NULL);
+	}
+
+	if (gadapter->adapter != NULL)
+		btd_adapter_unref(gadapter->adapter);
+
+	g_free(gadapter);
+}
+
+static gint adapter_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_adapter *gatt_adapter = a;
+	const struct btd_adapter *adapter = b;
+
+	if (gatt_adapter->adapter == adapter)
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
+	struct gatt_adapter *gadapter;
 	GError *gerr = NULL;
+	bdaddr_t addr;
+
+	DBG("Start GATT server in hci%d", adapter_get_dev_id(adapter));
+
+	gadapter = g_new0(struct gatt_adapter, 1);
+	gadapter->adapter = btd_adapter_ref(adapter);
+
+	adapter_get_address(gadapter->adapter, &addr);
 
 	/* BR/EDR socket */
-	l2cap_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
+	gadapter->l2cap_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
 					NULL, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR, BDADDR_ANY,
+					BT_IO_OPT_SOURCE_BDADDR, &addr,
 					BT_IO_OPT_PSM, ATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
-	if (l2cap_io == NULL) {
+
+	if (gadapter->l2cap_io == NULL) {
 		error("%s", gerr->message);
 		g_error_free(gerr);
+		gatt_adapter_free(gadapter);
 		return -1;
 	}
 
-	if (!register_core_services())
-		goto failed;
+	if (!register_core_services()) {
+		gatt_adapter_free(gadapter);
+		return -1;
+	}
 
 	/* LE socket */
-	le_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
-					&le_io, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR, BDADDR_ANY,
+	gadapter->le_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
+					&gadapter->le_io, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR, &addr,
 					BT_IO_OPT_CID, ATT_CID,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
-	if (le_io == NULL) {
+
+	if (gadapter->le_io == NULL) {
 		error("%s", gerr->message);
 		g_error_free(gerr);
 		/* Doesn't have LE support, continue */
 	}
 
+	adapters = g_slist_prepend(adapters, gadapter);
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
+	struct gatt_adapter *gadapter;
+	GSList *l;
 
-	if (l2cap_io) {
-		g_io_channel_unref(l2cap_io);
-		g_io_channel_shutdown(l2cap_io, FALSE, NULL);
-	}
+	l = g_slist_find_custom(adapters, adapter, adapter_cmp);
+	if (l == NULL)
+		return;
 
-	if (le_io) {
-		g_io_channel_unref(le_io);
-		g_io_channel_shutdown(le_io, FALSE, NULL);
-	}
+	DBG("Stop GATT server in hci%d", adapter_get_dev_id(adapter));
+
+	gadapter = l->data;
+	adapters = g_slist_remove(adapters, gadapter);
+	gatt_adapter_free(gadapter);
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
1.7.8

