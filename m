Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 14/16] network: Add a dedicated btd_profile for BNEP
Date: Tue, 25 Jun 2013 18:24:47 +0200
Message-Id: <1372177489-6858-15-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The profile is currently a dummy profile.
---
 profiles/network/manager.c |  6 +++---
 profiles/network/server.c  | 47 +++++++++++++++++++++++++++++++++++-----------
 profiles/network/server.h  |  4 ++--
 3 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 4f897dd..ca1e797 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -127,7 +127,7 @@ static int network_init(void)
 	 * field that defines which service the source is connecting to.
 	 */
 
-	if (server_init(conf_security) < 0)
+	if (network_server_init(conf_security) < 0)
 		return -1;
 
 	btd_profile_register(&panu_profile);
@@ -139,12 +139,12 @@ static int network_init(void)
 
 static void network_exit(void)
 {
-	server_exit();
-
 	btd_profile_unregister(&panu_profile);
 	btd_profile_unregister(&gn_profile);
 	btd_profile_unregister(&nap_profile);
 
+	network_server_exit();
+
 	bnep_cleanup();
 }
 
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 02a74ab..0e52db0 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -555,17 +555,6 @@ drop:
 	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
-int server_init(gboolean secure)
-{
-	security = secure;
-
-	return 0;
-}
-
-void server_exit(void)
-{
-}
-
 static uint32_t register_server_record(struct network_server *ns)
 {
 	sdp_record_t *record;
@@ -855,3 +844,39 @@ void network_server_remove(struct btd_server *server)
 						adapter_get_path(adapter),
 						NETWORK_SERVER_INTERFACE);
 }
+
+static int bnep_server_probe(struct btd_server *server)
+{
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+	const char *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
+
+	return 0;
+}
+
+static void bnep_server_remove(struct btd_server *server)
+{
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
+	DBG("path %s", adapter_get_path(adapter));
+}
+
+static struct btd_profile bnep_profile = {
+	.name		= "network-bnep",
+	.local_uuid	= BNEP_SVC_UUID,
+	.adapter_probe	= bnep_server_probe,
+	.adapter_remove	= bnep_server_remove,
+};
+
+int network_server_init(gboolean secure)
+{
+	security = secure;
+
+	return btd_profile_register(&bnep_profile);
+}
+
+void network_server_exit(void)
+{
+	btd_profile_unregister(&bnep_profile);
+}
diff --git a/profiles/network/server.h b/profiles/network/server.h
index 2d8b41c..438f74a 100644
--- a/profiles/network/server.h
+++ b/profiles/network/server.h
@@ -21,7 +21,7 @@
  *
  */
 
-int server_init(gboolean secure);
-void server_exit(void);
+int network_server_init(gboolean secure);
+void network_server_exit(void);
 int network_server_probe(struct btd_server *server);
 void network_server_remove(struct btd_server *server);
-- 
1.8.1.4

