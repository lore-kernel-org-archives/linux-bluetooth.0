Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 10/27] network: Bypass manager during probe/remove
Date: Fri, 26 Apr 2013 08:17:06 +0200
Message-Id: <1366957043-2383-11-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Use the internal device API to provide the btd_profile callback
functions, without boilerplate code in manager.c.
---
 profiles/network/connection.c | 11 ++++++++---
 profiles/network/connection.h |  4 ++--
 profiles/network/manager.c    | 40 ++++++----------------------------------
 3 files changed, 16 insertions(+), 39 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 3ccd211..84359c0 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -43,6 +43,7 @@
 #include "dbus-common.h"
 #include "adapter.h"
 #include "device.h"
+#include "profile.h"
 
 #include "error.h"
 #include "common.h"
@@ -639,9 +640,12 @@ static const GDBusPropertyTable connection_properties[] = {
 	{ }
 };
 
-void connection_unregister(struct btd_device *device)
+void connection_unregister(struct btd_profile *p, struct btd_device *device)
 {
 	struct network_peer *peer;
+	uint16_t id = bnep_service_id(p->remote_uuid);
+
+	DBG("%s id %u", device_get_path(device), id);
 
 	peer = find_peer(peers, device);
 	if (!peer)
@@ -682,12 +686,13 @@ static struct network_peer *create_peer(struct btd_device *device)
 	return peer;
 }
 
-int connection_register(struct btd_device *device, uint16_t id)
+int connection_register(struct btd_profile *p, struct btd_device *device)
 {
 	struct network_peer *peer;
 	struct network_conn *nc;
+	uint16_t id = bnep_service_id(p->remote_uuid);
 
-	DBG("id %u", id);
+	DBG("%s id %u", device_get_path(device), id);
 
 	peer = find_peer(peers, device);
 	if (!peer) {
diff --git a/profiles/network/connection.h b/profiles/network/connection.h
index 32356f9..5daead0 100644
--- a/profiles/network/connection.h
+++ b/profiles/network/connection.h
@@ -21,7 +21,7 @@
  *
  */
 
-int connection_register(struct btd_device *device, uint16_t id);
-void connection_unregister(struct btd_device *device);
+int connection_register(struct btd_profile *p, struct btd_device *device);
+void connection_unregister(struct btd_profile *p, struct btd_device *device);
 int connection_connect(struct btd_device *device, uint16_t id);
 int connection_disconnect(struct btd_device *device, uint16_t id);
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 4aa6a2b..df79351 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -74,20 +74,6 @@ done:
 				conf_security ? "true" : "false");
 }
 
-static int panu_probe(struct btd_profile *p, struct btd_device *device)
-{
-	DBG("path %s", device_get_path(device));
-
-	return connection_register(device, BNEP_SVC_PANU);
-}
-
-static void network_remove(struct btd_profile *p, struct btd_device *device)
-{
-	DBG("path %s", device_get_path(device));
-
-	connection_unregister(device);
-}
-
 static int panu_connect(struct btd_device *dev, struct btd_profile *profile)
 {
 	return connection_connect(dev, BNEP_SVC_PANU);
@@ -117,13 +103,6 @@ static void panu_server_remove(struct btd_profile *p,
 	server_unregister(adapter, BNEP_SVC_PANU);
 }
 
-static int gn_probe(struct btd_profile *p, struct btd_device *device)
-{
-	DBG("path %s", device_get_path(device));
-
-	return connection_register(device, BNEP_SVC_GN);
-}
-
 static int gn_connect(struct btd_device *dev, struct btd_profile *profile)
 {
 	return connection_connect(dev, BNEP_SVC_GN);
@@ -153,13 +132,6 @@ static void gn_server_remove(struct btd_profile *p,
 	server_unregister(adapter, BNEP_SVC_GN);
 }
 
-static int nap_probe(struct btd_profile *p, struct btd_device *device)
-{
-	DBG("path %s", device_get_path(device));
-
-	return connection_register(device, BNEP_SVC_NAP);
-}
-
 static int nap_connect(struct btd_device *dev, struct btd_profile *profile)
 {
 	return connection_connect(dev, BNEP_SVC_NAP);
@@ -193,8 +165,8 @@ static struct btd_profile panu_profile = {
 	.name		= "network-panu",
 	.local_uuid	= NAP_UUID,
 	.remote_uuid	= PANU_UUID,
-	.device_probe	= panu_probe,
-	.device_remove	= network_remove,
+	.device_probe	= connection_register,
+	.device_remove	= connection_unregister,
 	.connect	= panu_connect,
 	.disconnect	= panu_disconnect,
 	.adapter_probe	= panu_server_probe,
@@ -205,8 +177,8 @@ static struct btd_profile gn_profile = {
 	.name		= "network-gn",
 	.local_uuid	= PANU_UUID,
 	.remote_uuid	= GN_UUID,
-	.device_probe	= gn_probe,
-	.device_remove	= network_remove,
+	.device_probe	= connection_register,
+	.device_remove	= connection_unregister,
 	.connect	= gn_connect,
 	.disconnect	= gn_disconnect,
 	.adapter_probe	= gn_server_probe,
@@ -217,8 +189,8 @@ static struct btd_profile nap_profile = {
 	.name		= "network-nap",
 	.local_uuid	= PANU_UUID,
 	.remote_uuid	= NAP_UUID,
-	.device_probe	= nap_probe,
-	.device_remove	= network_remove,
+	.device_probe	= connection_register,
+	.device_remove	= connection_unregister,
 	.connect	= nap_connect,
 	.disconnect	= nap_disconnect,
 	.adapter_probe	= nap_server_probe,
-- 
1.8.1.4

