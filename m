Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 04/15] network: Split Network into three btd_profile
Date: Fri, 19 Oct 2012 17:39:21 +0200
Message-Id: <1350661172-18125-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Split the possible roles into three different btd_profile instances, one
role each, in accordance with the rest of the existing profiles.
---
 profiles/network/manager.c | 105 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 86 insertions(+), 19 deletions(-)

diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index fe3324b..eda0bbe 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -73,19 +73,12 @@ done:
 				conf_security ? "true" : "false");
 }
 
-static int network_probe(struct btd_profile *p, struct btd_device *device,
+static int panu_probe(struct btd_profile *p, struct btd_device *device,
 								GSList *uuids)
 {
 	DBG("path %s", device_get_path(device));
 
-	if (g_slist_find_custom(uuids, PANU_UUID, bt_uuid_strcmp))
-		connection_register(device, BNEP_SVC_PANU);
-	if (g_slist_find_custom(uuids, GN_UUID, bt_uuid_strcmp))
-		connection_register(device, BNEP_SVC_GN);
-	if (g_slist_find_custom(uuids, NAP_UUID, bt_uuid_strcmp))
-		connection_register(device, BNEP_SVC_NAP);
-
-	return 0;
+	return connection_register(device, BNEP_SVC_PANU);
 }
 
 static void network_remove(struct btd_profile *p, struct btd_device *device)
@@ -95,17 +88,70 @@ static void network_remove(struct btd_profile *p, struct btd_device *device)
 	connection_unregister(device);
 }
 
-static int network_server_probe(struct btd_profile *p,
+static int panu_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
+{
+	const gchar *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
+
+	return server_register(adapter, BNEP_SVC_PANU);
+}
+
+static void panu_server_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	const gchar *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
+
+	server_unregister(adapter, BNEP_SVC_PANU);
+}
+
+static int gn_probe(struct btd_profile *p, struct btd_device *device,
+								GSList *uuids)
+{
+	DBG("path %s", device_get_path(device));
+
+	return connection_register(device, BNEP_SVC_GN);
+}
+
+static int gn_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
+{
+	const gchar *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
+
+	return server_register(adapter, BNEP_SVC_GN);
+}
+
+static void gn_server_remove(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
 	const gchar *path = adapter_get_path(adapter);
 
 	DBG("path %s", path);
 
+	server_unregister(adapter, BNEP_SVC_GN);
+}
+
+static int nap_probe(struct btd_profile *p, struct btd_device *device,
+								GSList *uuids)
+{
+	DBG("path %s", device_get_path(device));
+
+	return connection_register(device, BNEP_SVC_NAP);
+}
+
+static int nap_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
+{
+	const gchar *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
+
 	return server_register(adapter, BNEP_SVC_NAP);
 }
 
-static void network_server_remove(struct btd_profile *p,
+static void nap_server_remove(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
 	const gchar *path = adapter_get_path(adapter);
@@ -115,14 +161,31 @@ static void network_server_remove(struct btd_profile *p,
 	server_unregister(adapter, BNEP_SVC_NAP);
 }
 
-static struct btd_profile network_profile = {
-	.name		= "network",
-	.remote_uuids	= BTD_UUIDS(PANU_UUID, GN_UUID, NAP_UUID),
-	.device_probe	= network_probe,
+static struct btd_profile panu_profile = {
+	.name		= "network-panu",
+	.remote_uuids	= BTD_UUIDS(PANU_UUID),
+	.device_probe	= panu_probe,
+	.device_remove	= network_remove,
+	.adapter_probe	= panu_server_probe,
+	.adapter_remove	= panu_server_remove,
+};
+
+static struct btd_profile gn_profile = {
+	.name		= "network-gn",
+	.remote_uuids	= BTD_UUIDS(GN_UUID),
+	.device_probe	= gn_probe,
 	.device_remove	= network_remove,
+	.adapter_probe	= gn_server_probe,
+	.adapter_remove	= gn_server_remove,
+};
 
-	.adapter_probe	= network_server_probe,
-	.adapter_remove	= network_server_remove,
+static struct btd_profile nap_profile = {
+	.name		= "network-nap",
+	.remote_uuids	= BTD_UUIDS(NAP_UUID),
+	.device_probe	= nap_probe,
+	.device_remove	= network_remove,
+	.adapter_probe	= nap_server_probe,
+	.adapter_remove	= nap_server_remove,
 };
 
 int network_manager_init(void)
@@ -144,7 +207,9 @@ int network_manager_init(void)
 	if (server_init(conf_security) < 0)
 		return -1;
 
-	btd_profile_register(&network_profile);
+	btd_profile_register(&panu_profile);
+	btd_profile_register(&gn_profile);
+	btd_profile_register(&nap_profile);
 
 	return 0;
 }
@@ -153,7 +218,9 @@ void network_manager_exit(void)
 {
 	server_exit();
 
-	btd_profile_unregister(&network_profile);
+	btd_profile_unregister(&panu_profile);
+	btd_profile_unregister(&gn_profile);
+	btd_profile_unregister(&nap_profile);
 
 	bnep_cleanup();
 }
-- 
1.7.11.7

