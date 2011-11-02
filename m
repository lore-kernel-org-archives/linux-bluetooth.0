Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 5/8] Make obex_server_init to initialized all services registered
Date: Wed,  2 Nov 2011 15:09:52 +0200
Message-Id: <1320239395-29819-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320239395-29819-1-git-send-email-luiz.dentz@gmail.com>
References: <1320239395-29819-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This way we don't have to keep adding new entries to main.c everytime
a new service is introduced.
---
 src/main.c    |   17 ++++-------------
 src/server.c  |   43 +++++++++++++++++++++++++++----------------
 src/server.h  |    2 +-
 src/service.c |    3 +++
 4 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/src/main.c b/src/main.c
index 114c215..992a646 100644
--- a/src/main.c
+++ b/src/main.c
@@ -241,19 +241,10 @@ int main(int argc, char *argv[])
 
 	plugin_init(option_plugin, option_noplugin);
 
-	obex_server_init(OBEX_OPP);
-
-	obex_server_init(OBEX_FTP);
-
-	obex_server_init(OBEX_PCSUITE);
-
-	obex_server_init(OBEX_PBAP);
-
-	obex_server_init(OBEX_IRMC);
-
-	obex_server_init(OBEX_SYNCEVOLUTION);
-
-	obex_server_init(OBEX_MAS);
+	if (obex_server_init() < 0) {
+		error("obex_server_init failed");
+		exit(EXIT_FAILURE);
+	}
 
 	if (!root_folder_setup(option_root, option_root_setup)) {
 		error("Unable to setup root folder %s", option_root);
diff --git a/src/server.c b/src/server.c
index bf234ea..f91a622 100644
--- a/src/server.c
+++ b/src/server.c
@@ -47,24 +47,10 @@
 
 static GSList *servers = NULL;
 
-int obex_server_init(uint16_t service)
+static void init_server(uint16_t service, GSList *transports)
 {
-	GSList *drivers;
-	GSList *transports;
 	GSList *l;
 
-	drivers = obex_service_driver_list(service);
-	if (drivers == NULL) {
-		DBG("No service driver registered");
-		return -EINVAL;
-	}
-
-	transports = obex_transport_driver_list();
-	if (transports == NULL) {
-		DBG("No transport driver registered");
-		return -EINVAL;
-	}
-
 	for (l = transports; l; l = l->next) {
 		struct obex_transport_driver *transport = l->data;
 		struct obex_server *server;
@@ -76,7 +62,7 @@ int obex_server_init(uint16_t service)
 
 		server = g_new0(struct obex_server, 1);
 		server->transport = transport;
-		server->drivers = drivers;
+		server->drivers = obex_service_driver_list(service);
 
 		server->transport_data = transport->start(server, &err);
 		if (server->transport_data == NULL) {
@@ -88,6 +74,31 @@ int obex_server_init(uint16_t service)
 
 		servers = g_slist_prepend(servers, server);
 	}
+}
+
+int obex_server_init(void)
+{
+	GSList *drivers;
+	GSList *transports;
+	GSList *l;
+
+	drivers = obex_service_driver_list(0);
+	if (drivers == NULL) {
+		DBG("No service driver registered");
+		return -EINVAL;
+	}
+
+	transports = obex_transport_driver_list();
+	if (transports == NULL) {
+		DBG("No transport driver registered");
+		return -EINVAL;
+	}
+
+	for (l = drivers; l; l = l->next) {
+		struct obex_service_driver *driver = l->data;
+
+		init_server(driver->service, transports);
+	}
 
 	return 0;
 }
diff --git a/src/server.h b/src/server.h
index dd0df00..81c0b5d 100644
--- a/src/server.h
+++ b/src/server.h
@@ -28,7 +28,7 @@ struct obex_server {
 	GSList *drivers;
 };
 
-int obex_server_init(uint16_t service);
+int obex_server_init(void);
 
 void obex_server_exit(void);
 
diff --git a/src/service.c b/src/service.c
index f7c5a61..8116fc2 100644
--- a/src/service.c
+++ b/src/service.c
@@ -64,6 +64,9 @@ GSList *obex_service_driver_list(uint16_t services)
 	GSList *l;
 	GSList *list = NULL;
 
+	if (services == 0)
+		return drivers;
+
 	for (l = drivers; l && services; l = l->next) {
 		struct obex_service_driver *driver = l->data;
 
-- 
1.7.6.4

