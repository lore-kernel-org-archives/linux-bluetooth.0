Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 03/16] profile: Use btd_server to probe adapters
Date: Tue, 25 Jun 2013 18:24:36 +0200
Message-Id: <1372177489-6858-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Modify the btd_profile callbacks to receive a btd_server pointer,
trivially replacing the previous parameters.

This allows the profile implementations to set the userdata pointer
during probe, in case they want to associate a private data type to the
probed adapter (which is fairly common).
---
 profiles/alert/server.c              |  9 ++++----
 profiles/audio/manager.c             | 41 ++++++++++++++++++++++--------------
 profiles/cyclingspeed/cyclingspeed.c |  8 ++++---
 profiles/health/hdp_manager.c        | 11 ++++++----
 profiles/heartrate/heartrate.c       | 11 ++++++----
 profiles/input/manager.c             | 10 ++++++---
 profiles/network/manager.c           | 22 +++++++++++--------
 profiles/proximity/reporter.c        |  8 ++++---
 profiles/proximity/reporter.h        |  5 ++---
 profiles/sap/manager.c               |  9 ++++----
 profiles/thermometer/thermometer.c   | 11 ++++++----
 profiles/time/server.c               |  8 ++++---
 src/profile.c                        | 11 ++++++----
 src/profile.h                        |  7 +++---
 src/server.c                         |  5 ++---
 15 files changed, 105 insertions(+), 71 deletions(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 8da1928..4f84669 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -45,6 +45,7 @@
 #include "attrib-server.h"
 #include "attrib/gatt.h"
 #include "profile.h"
+#include "server.h"
 #include "error.h"
 #include "textfile.h"
 #include "attio.h"
@@ -927,9 +928,9 @@ static void register_alert_notif_service(struct alert_adapter *al_adapter)
 			GATT_OPT_INVALID);
 }
 
-static int alert_server_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static int alert_server_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	struct alert_adapter *al_adapter;
 
 	al_adapter = g_new0(struct alert_adapter, 1);
@@ -943,9 +944,9 @@ static int alert_server_probe(struct btd_profile *p,
 	return 0;
 }
 
-static void alert_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void alert_server_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	struct alert_adapter *al_adapter;
 
 	al_adapter = find_alert_adapter(adapter);
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 7f02fbd..23d0ee4 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -54,6 +54,7 @@
 #include "../src/device.h"
 #include "../src/profile.h"
 #include "../src/service.h"
+#include "../src/server.h"
 
 #include "log.h"
 #include "device.h"
@@ -272,65 +273,73 @@ static int avrcp_target_disconnect(struct btd_service *service)
 	return control_disconnect(audio_dev);
 }
 
-static int a2dp_source_server_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static int a2dp_source_server_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	DBG("path %s", adapter_get_path(adapter));
 
 	return a2dp_source_register(adapter, config);
 }
 
-static void a2dp_source_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void a2dp_source_server_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	DBG("path %s", adapter_get_path(adapter));
 
 	a2dp_source_unregister(adapter);
 }
 
-static int a2dp_sink_server_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static int a2dp_sink_server_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	DBG("path %s", adapter_get_path(adapter));
 
 	return a2dp_sink_register(adapter, config);
 }
 
-static void a2dp_sink_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void a2dp_sink_server_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	DBG("path %s", adapter_get_path(adapter));
 
 	a2dp_sink_unregister(adapter);
 }
 
-static int avrcp_target_server_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static int avrcp_target_server_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	DBG("path %s", adapter_get_path(adapter));
 
 	return avrcp_target_register(adapter, config);
 }
 
-static int avrcp_remote_server_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static int avrcp_remote_server_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	DBG("path %s", adapter_get_path(adapter));
 
 	return avrcp_remote_register(adapter, config);
 }
 
-static void avrcp_target_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void avrcp_target_server_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	DBG("path %s", adapter_get_path(adapter));
 
 	avrcp_target_unregister(adapter);
 }
 
-static void avrcp_remote_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void avrcp_remote_server_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	DBG("path %s", adapter_get_path(adapter));
 
 	avrcp_remote_unregister(adapter);
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index ea6076c..14c2df7 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -35,6 +35,7 @@
 #include "device.h"
 #include "profile.h"
 #include "service.h"
+#include "server.h"
 #include "dbus-common.h"
 #include "error.h"
 #include "attrib/gattrib.h"
@@ -957,8 +958,9 @@ static const GDBusMethodTable cyclingspeed_manager_methods[] = {
 	{ }
 };
 
-static int csc_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
+static int csc_adapter_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	struct csc_adapter *cadapter;
 
 	cadapter = g_new0(struct csc_adapter, 1);
@@ -981,9 +983,9 @@ static int csc_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 	return 0;
 }
 
-static void csc_adapter_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void csc_adapter_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	struct csc_adapter *cadapter;
 
 	cadapter = find_csc_adapter(adapter);
diff --git a/profiles/health/hdp_manager.c b/profiles/health/hdp_manager.c
index 1bb6007..06cf33f 100644
--- a/profiles/health/hdp_manager.c
+++ b/profiles/health/hdp_manager.c
@@ -35,6 +35,7 @@
 #include <device.h>
 #include <profile.h>
 #include <service.h>
+#include <server.h>
 #include <glib-helper.h>
 #include <log.h>
 
@@ -43,15 +44,17 @@
 #include "hdp_manager.h"
 #include "hdp.h"
 
-static int hdp_adapter_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static int hdp_adapter_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	return hdp_adapter_register(adapter);
 }
 
-static void hdp_adapter_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void hdp_adapter_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	hdp_adapter_unregister(adapter);
 }
 
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 34ec9bc..1d902a8 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -36,6 +36,7 @@
 #include "device.h"
 #include "profile.h"
 #include "service.h"
+#include "server.h"
 #include "error.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
@@ -830,15 +831,17 @@ static void heartrate_device_unregister(struct btd_device *device)
 				device_get_path(device), HEART_RATE_INTERFACE);
 }
 
-static int heartrate_adapter_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static int heartrate_adapter_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	return heartrate_adapter_register(adapter);
 }
 
-static void heartrate_adapter_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void heartrate_adapter_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	heartrate_adapter_unregister(adapter);
 }
 
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 689ccdd..4c32919 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -40,18 +40,22 @@
 #include "../src/device.h"
 #include "../src/profile.h"
 #include "../src/service.h"
+#include "../src/server.h"
 
 #include "device.h"
 #include "server.h"
 
-static int hid_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
+static int hid_server_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	return server_start(adapter_get_address(adapter));
 }
 
-static void hid_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void hid_server_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	server_stop(adapter_get_address(adapter));
 }
 
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 03b1b3d..1ec2db2 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -42,6 +42,7 @@
 #include "device.h"
 #include "profile.h"
 #include "service.h"
+#include "../src/server.h"
 #include "common.h"
 #include "connection.h"
 #include "server.h"
@@ -74,8 +75,9 @@ done:
 				conf_security ? "true" : "false");
 }
 
-static int panu_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
+static int panu_server_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	const char *path = adapter_get_path(adapter);
 
 	DBG("path %s", path);
@@ -83,9 +85,9 @@ static int panu_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 	return server_register(adapter, BNEP_SVC_PANU);
 }
 
-static void panu_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void panu_server_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	const char *path = adapter_get_path(adapter);
 
 	DBG("path %s", path);
@@ -93,8 +95,9 @@ static void panu_server_remove(struct btd_profile *p,
 	server_unregister(adapter, BNEP_SVC_PANU);
 }
 
-static int gn_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
+static int gn_server_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	const char *path = adapter_get_path(adapter);
 
 	DBG("path %s", path);
@@ -102,9 +105,9 @@ static int gn_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 	return server_register(adapter, BNEP_SVC_GN);
 }
 
-static void gn_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void gn_server_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	const char *path = adapter_get_path(adapter);
 
 	DBG("path %s", path);
@@ -112,8 +115,9 @@ static void gn_server_remove(struct btd_profile *p,
 	server_unregister(adapter, BNEP_SVC_GN);
 }
 
-static int nap_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
+static int nap_server_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	const char *path = adapter_get_path(adapter);
 
 	DBG("path %s", path);
@@ -121,9 +125,9 @@ static int nap_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 	return server_register(adapter, BNEP_SVC_NAP);
 }
 
-static void nap_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void nap_server_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	const char *path = adapter_get_path(adapter);
 
 	DBG("path %s", path);
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index dbb593a..3f6ba75 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -43,6 +43,7 @@
 #include "device.h"
 #include "profile.h"
 #include "service.h"
+#include "server.h"
 #include "hcid.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
@@ -232,8 +233,9 @@ void reporter_device_remove(struct btd_service *service)
 	unregister_reporter_device(device, radapter);
 }
 
-int reporter_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
+int reporter_adapter_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	struct reporter_adapter *radapter;
 
 	radapter = g_new0(struct reporter_adapter, 1);
@@ -249,9 +251,9 @@ int reporter_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 	return 0;
 }
 
-void reporter_adapter_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+void reporter_adapter_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	struct reporter_adapter *radapter = find_reporter_adapter(adapter);
 	if (!radapter)
 		return;
diff --git a/profiles/proximity/reporter.h b/profiles/proximity/reporter.h
index a8e1aac..4f94e2b 100644
--- a/profiles/proximity/reporter.h
+++ b/profiles/proximity/reporter.h
@@ -39,8 +39,7 @@ enum {
 void reporter_device_remove(struct btd_service *service);
 int reporter_device_probe(struct btd_service *service);
 
-int reporter_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter);
-void reporter_adapter_remove(struct btd_profile *p,
-						struct btd_adapter *adapter);
+int reporter_adapter_probe(struct btd_server *server);
+void reporter_adapter_remove(struct btd_server *server);
 
 const char *get_alert_level_string(uint8_t level);
diff --git a/profiles/sap/manager.c b/profiles/sap/manager.c
index 24b73e7..4d6cfdc 100644
--- a/profiles/sap/manager.c
+++ b/profiles/sap/manager.c
@@ -29,12 +29,14 @@
 #include "device.h"
 #include "profile.h"
 #include "service.h"
+#include "../src/server.h"
 
 #include "manager.h"
 #include "server.h"
 
-static int sap_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
+static int sap_server_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	const char *path = adapter_get_path(adapter);
 
 	DBG("path %s", path);
@@ -42,10 +44,9 @@ static int sap_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 	return sap_server_register(path, adapter_get_address(adapter));
 }
 
-static void sap_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void sap_server_remove(struct btd_server *server)
 {
-	const char *path = adapter_get_path(adapter);
+	const char *path = adapter_get_path(btd_server_get_adapter(server));
 
 	DBG("path %s", path);
 
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index c2ca251..44f5e79 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -36,6 +36,7 @@
 #include "device.h"
 #include "profile.h"
 #include "service.h"
+#include "server.h"
 #include "error.h"
 #include "log.h"
 #include "attrib/gattrib.h"
@@ -1300,15 +1301,17 @@ static void thermometer_device_remove(struct btd_service *service)
 	thermometer_unregister(device);
 }
 
-static int thermometer_adapter_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static int thermometer_adapter_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	return thermometer_adapter_register(adapter);
 }
 
-static void thermometer_adapter_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void thermometer_adapter_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+
 	thermometer_adapter_unregister(adapter);
 }
 
diff --git a/profiles/time/server.c b/profiles/time/server.c
index 518a29f..b5f14ce 100644
--- a/profiles/time/server.c
+++ b/profiles/time/server.c
@@ -34,6 +34,7 @@
 #include <adapter.h>
 #include <device.h>
 #include <profile.h>
+#include <server.h>
 #include <plugin.h>
 
 #include "lib/uuid.h"
@@ -230,8 +231,9 @@ static gboolean register_ref_time_update_service(struct btd_adapter *adapter)
 				GATT_OPT_INVALID);
 }
 
-static int time_server_init(struct btd_profile *p, struct btd_adapter *adapter)
+static int time_server_init(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	const char *path = adapter_get_path(adapter);
 
 	DBG("path %s", path);
@@ -249,9 +251,9 @@ static int time_server_init(struct btd_profile *p, struct btd_adapter *adapter)
 	return 0;
 }
 
-static void time_server_exit(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void time_server_exit(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	const char *path = adapter_get_path(adapter);
 
 	DBG("path %s", path);
diff --git a/src/profile.c b/src/profile.c
index c745811..ae18887 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -51,6 +51,7 @@
 #include "device.h"
 #include "profile.h"
 #include "service.h"
+#include "server.h"
 
 #define DUN_DEFAULT_CHANNEL	1
 #define SPP_DEFAULT_CHANNEL	3
@@ -1349,9 +1350,10 @@ static struct ext_profile *find_ext(struct btd_profile *p)
 	return l->data;
 }
 
-static int ext_adapter_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static int ext_adapter_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+	struct btd_profile *p = btd_server_get_profile(server);
 	struct ext_profile *ext;
 	struct ext_record *rec;
 	uint32_t handle;
@@ -1396,9 +1398,10 @@ static void ext_remove_records(struct ext_profile *ext,
 	}
 }
 
-static void ext_adapter_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void ext_adapter_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
+	struct btd_profile *p = btd_server_get_profile(server);
 	struct ext_profile *ext;
 	GSList *l, *next;
 
diff --git a/src/profile.h b/src/profile.h
index 9aec27e..683e3a9 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -25,6 +25,7 @@
 #define BTD_PROFILE_PRIORITY_MEDIUM	1
 #define BTD_PROFILE_PRIORITY_HIGH	2
 
+struct btd_server;
 struct btd_service;
 
 struct btd_profile {
@@ -42,10 +43,8 @@ struct btd_profile {
 	int (*connect) (struct btd_service *service);
 	int (*disconnect) (struct btd_service *service);
 
-	int (*adapter_probe) (struct btd_profile *p,
-						struct btd_adapter *adapter);
-	void (*adapter_remove) (struct btd_profile *p,
-						struct btd_adapter *adapter);
+	int (*adapter_probe) (struct btd_server *server);
+	void (*adapter_remove) (struct btd_server *server);
 };
 
 void btd_profile_foreach(void (*func)(struct btd_profile *p, void *data),
diff --git a/src/server.c b/src/server.c
index 9337ff6..7c5b445 100644
--- a/src/server.c
+++ b/src/server.c
@@ -67,7 +67,7 @@ struct btd_server *server_create(struct btd_adapter *adapter,
 	server->adapter = adapter; /* Weak ref */
 	server->profile = profile;
 
-	err = profile->adapter_probe(server->profile, server->adapter);
+	err = profile->adapter_probe(server);
 	if (err == 0)
 		return server;
 
@@ -82,8 +82,7 @@ struct btd_server *server_create(struct btd_adapter *adapter,
 void server_destroy(struct btd_server *server)
 {
 	if (server->profile->adapter_remove != NULL)
-		server->profile->adapter_remove(server->profile,
-							server->adapter);
+		server->profile->adapter_remove(server);
 
 	g_free(server);
 }
-- 
1.8.1.4

