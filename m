Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/8] Move secure flag to service driver
Date: Wed,  2 Nov 2011 15:09:51 +0200
Message-Id: <1320239395-29819-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320239395-29819-1-git-send-email-luiz.dentz@gmail.com>
References: <1320239395-29819-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The driver already define the channel so it makes sense to have the
secure flag in the same place.
---
 plugins/bluetooth.c     |   18 +++++++++---------
 plugins/ftp.c           |    1 +
 plugins/irmc.c          |    1 +
 plugins/mas.c           |    1 +
 plugins/pbap.c          |    1 +
 plugins/pcsuite.c       |    1 +
 plugins/syncevolution.c |    1 +
 src/main.c              |   14 +++++++-------
 src/server.c            |    3 +--
 src/server.h            |    3 +--
 src/service.h           |    1 +
 11 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 1c9d92e..1a57654 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -500,12 +500,18 @@ drop:
 }
 
 static GIOChannel *start(struct obex_server *server,
-				struct obex_service_driver *service,
-				BtIOSecLevel sec_level)
+				struct obex_service_driver *service)
 {
+	BtIOSecLevel sec_level;
 	GIOChannel *io;
 	GError *err = NULL;
 
+	if (service->secure == TRUE)
+		sec_level = BT_IO_SEC_MEDIUM;
+	else
+		sec_level = BT_IO_SEC_LOW;
+
+
 	io = bt_io_listen(BT_IO_RFCOMM, NULL, confirm_event,
 				service, NULL, &err,
 				BT_IO_OPT_CHANNEL, service->channel,
@@ -523,20 +529,14 @@ static GIOChannel *start(struct obex_server *server,
 
 static void *bluetooth_start(struct obex_server *server, int *err)
 {
-	BtIOSecLevel sec_level;
 	GSList *ios = NULL;
 	const GSList *l;
 
-	if (server->secure == TRUE)
-		sec_level = BT_IO_SEC_MEDIUM;
-	else
-		sec_level = BT_IO_SEC_LOW;
-
 	for (l = server->drivers; l; l = l->next) {
 		struct obex_service_driver *service = l->data;
 		GIOChannel *io;
 
-		io = start(server, service, sec_level);
+		io = start(server, service);
 		if (io == NULL)
 			continue;
 
diff --git a/plugins/ftp.c b/plugins/ftp.c
index 3f32563..aebe411 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -576,6 +576,7 @@ static struct obex_service_driver ftp = {
 	.name = "File Transfer server",
 	.service = OBEX_FTP,
 	.channel = FTP_CHANNEL,
+	.secure = TRUE,
 	.record = FTP_RECORD,
 	.target = FTP_TARGET,
 	.target_size = TARGET_SIZE,
diff --git a/plugins/irmc.c b/plugins/irmc.c
index 3499ca7..4ea76c5 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -493,6 +493,7 @@ static struct obex_service_driver irmc = {
 	.name = "IRMC Sync server",
 	.service = OBEX_IRMC,
 	.channel = IRMC_CHANNEL,
+	.secure = TRUE,
 	.record = IRMC_RECORD,
 	.target = IRMC_TARGET,
 	.target_size = IRMC_TARGET_SIZE,
diff --git a/plugins/mas.c b/plugins/mas.c
index 3e3670f..7d3d553 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -554,6 +554,7 @@ static struct obex_service_driver mas = {
 	.name = "Message Access server",
 	.service = OBEX_MAS,
 	.channel = MAS_CHANNEL,
+	.secure = TRUE,
 	.record = MAS_RECORD,
 	.target = MAS_TARGET,
 	.target_size = TARGET_SIZE,
diff --git a/plugins/pbap.c b/plugins/pbap.c
index 066e37e..997b5bd 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -758,6 +758,7 @@ static struct obex_service_driver pbap = {
 	.name = "Phonebook Access server",
 	.service = OBEX_PBAP,
 	.channel = PBAP_CHANNEL,
+	.secure = TRUE,
 	.record = PBAP_RECORD,
 	.target = PBAP_TARGET,
 	.target_size = TARGET_SIZE,
diff --git a/plugins/pcsuite.c b/plugins/pcsuite.c
index b93bd65..27a3496 100644
--- a/plugins/pcsuite.c
+++ b/plugins/pcsuite.c
@@ -253,6 +253,7 @@ static struct obex_service_driver pcsuite = {
 	.name = "Nokia OBEX PC Suite Services",
 	.service = OBEX_PCSUITE,
 	.channel = PCSUITE_CHANNEL,
+	.secure = TRUE,
 	.record = PCSUITE_RECORD,
 	.target = FTP_TARGET,
 	.target_size = TARGET_SIZE,
diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
index a389783..fcf6d2b 100644
--- a/plugins/syncevolution.c
+++ b/plugins/syncevolution.c
@@ -450,6 +450,7 @@ static struct obex_service_driver synce = {
 	.name = "OBEX server for SyncML, using SyncEvolution",
 	.service = OBEX_SYNCEVOLUTION,
 	.channel = SYNCEVOLUTION_CHANNEL,
+	.secure = TRUE,
 	.record = SYNCEVOLUTION_RECORD,
 	.target = SYNCML_TARGET,
 	.target_size = SYNCML_TARGET_SIZE,
diff --git a/src/main.c b/src/main.c
index 73c1db5..114c215 100644
--- a/src/main.c
+++ b/src/main.c
@@ -241,19 +241,19 @@ int main(int argc, char *argv[])
 
 	plugin_init(option_plugin, option_noplugin);
 
-	obex_server_init(OBEX_OPP, FALSE);
+	obex_server_init(OBEX_OPP);
 
-	obex_server_init(OBEX_FTP, TRUE);
+	obex_server_init(OBEX_FTP);
 
-	obex_server_init(OBEX_PCSUITE, TRUE);
+	obex_server_init(OBEX_PCSUITE);
 
-	obex_server_init(OBEX_PBAP, TRUE);
+	obex_server_init(OBEX_PBAP);
 
-	obex_server_init(OBEX_IRMC, TRUE);
+	obex_server_init(OBEX_IRMC);
 
-	obex_server_init(OBEX_SYNCEVOLUTION, TRUE);
+	obex_server_init(OBEX_SYNCEVOLUTION);
 
-	obex_server_init(OBEX_MAS, TRUE);
+	obex_server_init(OBEX_MAS);
 
 	if (!root_folder_setup(option_root, option_root_setup)) {
 		error("Unable to setup root folder %s", option_root);
diff --git a/src/server.c b/src/server.c
index dc1ad6d..bf234ea 100644
--- a/src/server.c
+++ b/src/server.c
@@ -47,7 +47,7 @@
 
 static GSList *servers = NULL;
 
-int obex_server_init(uint16_t service, gboolean secure)
+int obex_server_init(uint16_t service)
 {
 	GSList *drivers;
 	GSList *transports;
@@ -77,7 +77,6 @@ int obex_server_init(uint16_t service, gboolean secure)
 		server = g_new0(struct obex_server, 1);
 		server->transport = transport;
 		server->drivers = drivers;
-		server->secure = secure;
 
 		server->transport_data = transport->start(server, &err);
 		if (server->transport_data == NULL) {
diff --git a/src/server.h b/src/server.h
index beb8a9c..dd0df00 100644
--- a/src/server.h
+++ b/src/server.h
@@ -25,11 +25,10 @@
 struct obex_server {
 	struct obex_transport_driver *transport;
 	void *transport_data;
-	gboolean secure;
 	GSList *drivers;
 };
 
-int obex_server_init(uint16_t service, gboolean secure);
+int obex_server_init(uint16_t service);
 
 void obex_server_exit(void);
 
diff --git a/src/service.h b/src/service.h
index 6633be3..68c4474 100644
--- a/src/service.h
+++ b/src/service.h
@@ -25,6 +25,7 @@ struct obex_service_driver {
 	const char *name;
 	uint16_t service;
 	uint8_t channel;
+	gboolean secure;
 	const uint8_t *target;
 	unsigned int target_size;
 	const uint8_t *who;
-- 
1.7.6.4

