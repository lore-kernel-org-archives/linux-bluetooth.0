Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 10/11] attrib-server: Remove attrib_server_exit/attrib_server_exit functions
Date: Fri, 16 Dec 2011 17:09:58 +0100
Message-Id: <1324051799-21439-11-git-send-email-sancane@gmail.com>
In-Reply-To: <1324051799-21439-10-git-send-email-sancane@gmail.com>
References: <1324051799-21439-1-git-send-email-sancane@gmail.com>
 <1324051799-21439-2-git-send-email-sancane@gmail.com>
 <1324051799-21439-3-git-send-email-sancane@gmail.com>
 <1324051799-21439-4-git-send-email-sancane@gmail.com>
 <1324051799-21439-5-git-send-email-sancane@gmail.com>
 <1324051799-21439-6-git-send-email-sancane@gmail.com>
 <1324051799-21439-7-git-send-email-sancane@gmail.com>
 <1324051799-21439-8-git-send-email-sancane@gmail.com>
 <1324051799-21439-9-git-send-email-sancane@gmail.com>
 <1324051799-21439-10-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need neither to init nor stop gatt server whenever the demon starts
and finishes the execution, instead of doing that, we init or stop the
GATT server when the adapter is initialized or removed. Furthermore,
we don't use btd_adapter_driver any more because the GATT server must
be already initialized before any plugin use it.
---
 src/adapter.c       |    7 +++++++
 src/adapter.h       |    3 +++
 src/attrib-server.c |   24 ++++--------------------
 src/hcid.h          |    3 ---
 src/main.c          |    8 --------
 5 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1a701a4..200e9d9 100644
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
index ff1d659..2f8f125 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -275,3 +275,6 @@ int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
 
 int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 							bdaddr_t *bdaddr);
+
+int btd_adapter_gatt_server_start(struct btd_adapter *adapter);
+void btd_adapter_gatt_server_stop(struct btd_adapter *adapter);
\ No newline at end of file
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 0414ff7..12065fa 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1210,13 +1210,13 @@ static gboolean register_core_services(struct gatt_adapter *gatt_adapter)
 	return TRUE;
 }
 
-static int attrib_adapter_probe(struct btd_adapter *adapter)
+int btd_adapter_gatt_server_start(struct btd_adapter *adapter)
 {
 	struct gatt_adapter *gatt_adapter;
 	GError *gerr = NULL;
 	bdaddr_t addr;
 
-	DBG("Start GATT server in %s", adapter_get_path(adapter));
+	DBG("Start GATT server in hci%d", adapter_get_dev_id(adapter));
 
 	gatt_adapter = g_new0(struct gatt_adapter, 1);
 	gatt_adapter->adapter = btd_adapter_ref(adapter);
@@ -1262,7 +1262,7 @@ static int attrib_adapter_probe(struct btd_adapter *adapter)
 	return 0;
 }
 
-static void attrib_adapter_remove(struct btd_adapter *adapter)
+void btd_adapter_gatt_server_stop(struct btd_adapter *adapter)
 {
 	struct gatt_adapter *gatt_adapter;
 	GSList *l;
@@ -1271,29 +1271,13 @@ static void attrib_adapter_remove(struct btd_adapter *adapter)
 	if (l == NULL)
 		return;
 
-	DBG("Stop GATT server in %s", adapter_get_path(adapter));
+	DBG("Stop GATT server in hci%d", adapter_get_dev_id(adapter));
 
 	gatt_adapter = l->data;
 	adapters = g_slist_remove(adapters, gatt_adapter);
 	free_gatt_adapter(gatt_adapter);
 }
 
-static struct btd_adapter_driver attrib_adapter_driver = {
-	.name	= "attrib-adapter-driver",
-	.probe	= attrib_adapter_probe,
-	.remove	= attrib_adapter_remove,
-};
-
-int attrib_server_init(void)
-{
-	return btd_register_adapter_driver(&attrib_adapter_driver);
-}
-
-void attrib_server_exit(void)
-{
-	btd_unregister_adapter_driver(&attrib_adapter_driver);
-}
-
 uint32_t attrib_create_sdp(uint16_t handle, const char *name)
 {
 	struct gatt_adapter *gatt_adapter;
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

