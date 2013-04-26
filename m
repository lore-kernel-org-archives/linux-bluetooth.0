Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 19/27] profile: Use btd_service for probing profiles
Date: Fri, 26 Apr 2013 08:17:15 +0200
Message-Id: <1366957043-2383-20-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Change the profile probe mechanism in order to pass the btd_service
instance representing the remote service. This object is bound to a
btd_profile and a btd_device, thus replacing the previous parameters.

The probe callback is allowed to hold a reference to the btd_service
by means of btd_service_ref(), which should be unreferenced during
removal.

Keeping such a reference of the btd_service allows supporting multiple
instances of the same UUID, since the reference can serve as a handle
during the interactions between the profile implementation and the core.
---
 profiles/audio/manager.c             | 14 ++++++++++----
 profiles/cyclingspeed/cyclingspeed.c |  8 +++++---
 profiles/deviceinfo/deviceinfo.c     | 10 ++++++----
 profiles/gatt/gas.c                  |  9 ++++++---
 profiles/health/hdp_manager.c        |  9 +++++++--
 profiles/heartrate/heartrate.c       | 10 ++++++----
 profiles/input/device.c              | 14 +++++++++-----
 profiles/input/device.h              |  4 ++--
 profiles/input/hog.c                 |  7 +++++--
 profiles/input/manager.c             |  1 +
 profiles/network/connection.c        |  9 +++++++--
 profiles/network/connection.h        |  4 ++--
 profiles/network/manager.c           |  1 +
 profiles/proximity/manager.c         | 28 ++++++++++++++++------------
 profiles/proximity/reporter.c        |  7 +++++--
 profiles/proximity/reporter.h        |  4 ++--
 profiles/sap/manager.c               |  1 +
 profiles/scanparam/scan.c            |  8 ++++++--
 profiles/thermometer/thermometer.c   | 10 ++++++----
 src/profile.c                        |  8 ++++++--
 src/profile.h                        |  7 ++++---
 src/service.c                        |  4 ++--
 22 files changed, 115 insertions(+), 62 deletions(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index f9c0ca6..ff4590e 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -53,6 +53,7 @@
 #include "../src/adapter.h"
 #include "../src/device.h"
 #include "../src/profile.h"
+#include "../src/service.h"
 
 #include "log.h"
 #include "device.h"
@@ -89,8 +90,9 @@ static struct audio_device *manager_find_device(struct btd_device *device)
 	return NULL;
 }
 
-static void audio_remove(struct btd_profile *p, struct btd_device *device)
+static void audio_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct audio_device *dev;
 
 	dev = manager_find_device(device);
@@ -101,8 +103,9 @@ static void audio_remove(struct btd_profile *p, struct btd_device *device)
 	audio_device_unregister(dev);
 }
 
-static int a2dp_source_probe(struct btd_profile *p, struct btd_device *device)
+static int a2dp_source_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct audio_device *audio_dev;
 
 	audio_dev = get_audio_dev(device);
@@ -116,8 +119,9 @@ static int a2dp_source_probe(struct btd_profile *p, struct btd_device *device)
 	return 0;
 }
 
-static int a2dp_sink_probe(struct btd_profile *p, struct btd_device *device)
+static int a2dp_sink_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct audio_device *audio_dev;
 
 	audio_dev = get_audio_dev(device);
@@ -131,8 +135,10 @@ static int a2dp_sink_probe(struct btd_profile *p, struct btd_device *device)
 	return 0;
 }
 
-static int avrcp_probe(struct btd_profile *p, struct btd_device *device)
+static int avrcp_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_profile *p = btd_service_get_profile(service);
 	struct audio_device *audio_dev;
 
 	audio_dev = get_audio_dev(device);
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 744bd4b..6080f09 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -34,6 +34,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "service.h"
 #include "dbus-common.h"
 #include "error.h"
 #include "attrib/gattrib.h"
@@ -1180,8 +1181,9 @@ static const GDBusMethodTable cyclingspeed_device_methods[] = {
 	{ }
 };
 
-static int csc_device_probe(struct btd_profile *p, struct btd_device *device)
+static int csc_device_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct btd_adapter *adapter;
 	struct csc_adapter *cadapter;
 	struct csc *csc;
@@ -1226,9 +1228,9 @@ static int csc_device_probe(struct btd_profile *p, struct btd_device *device)
 	return 0;
 }
 
-static void csc_device_remove(struct btd_profile *p,
-						struct btd_device *device)
+static void csc_device_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct btd_adapter *adapter;
 	struct csc_adapter *cadapter;
 	struct csc *csc;
diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index 08f53b3..fc8babd 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -34,6 +34,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "service.h"
 #include "attrib/gattrib.h"
 #include "attio.h"
 #include "attrib/att.h"
@@ -198,9 +199,9 @@ static void deviceinfo_unregister(struct btd_device *device)
 	deviceinfo_free(d);
 }
 
-static int deviceinfo_driver_probe(struct btd_profile *p,
-						struct btd_device *device)
+static int deviceinfo_driver_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_primary *prim;
 
 	prim = btd_device_get_primary(device, DEVICE_INFORMATION_UUID);
@@ -210,9 +211,10 @@ static int deviceinfo_driver_probe(struct btd_profile *p,
 	return deviceinfo_register(device, prim);
 }
 
-static void deviceinfo_driver_remove(struct btd_profile *p,
-						struct btd_device *device)
+static void deviceinfo_driver_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	deviceinfo_unregister(device);
 }
 
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 4c7af4b..33a680f 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -39,6 +39,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "service.h"
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
 #include "attio.h"
@@ -407,8 +408,9 @@ static void gas_unregister(struct btd_device *device)
 	gas_free(gas);
 }
 
-static int gatt_driver_probe(struct btd_profile *p, struct btd_device *device)
+static int gatt_driver_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_primary *gap, *gatt;
 
 	gap = btd_device_get_primary(device, GAP_UUID);
@@ -422,9 +424,10 @@ static int gatt_driver_probe(struct btd_profile *p, struct btd_device *device)
 	return gas_register(device, &gap->range, &gatt->range);
 }
 
-static void gatt_driver_remove(struct btd_profile *p,
-						struct btd_device *device)
+static void gatt_driver_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	gas_unregister(device);
 }
 
diff --git a/profiles/health/hdp_manager.c b/profiles/health/hdp_manager.c
index 3777fd4..1bb6007 100644
--- a/profiles/health/hdp_manager.c
+++ b/profiles/health/hdp_manager.c
@@ -34,6 +34,7 @@
 #include <adapter.h>
 #include <device.h>
 #include <profile.h>
+#include <service.h>
 #include <glib-helper.h>
 #include <log.h>
 
@@ -54,13 +55,17 @@ static void hdp_adapter_remove(struct btd_profile *p,
 	hdp_adapter_unregister(adapter);
 }
 
-static int hdp_driver_probe(struct btd_profile *p, struct btd_device *device)
+static int hdp_driver_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	return hdp_device_register(device);
 }
 
-static void hdp_driver_remove(struct btd_profile *p, struct btd_device *device)
+static void hdp_driver_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	hdp_device_unregister(device);
 }
 
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 18a9448..3a2d419 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -35,6 +35,7 @@
 #include "dbus-common.h"
 #include "device.h"
 #include "profile.h"
+#include "service.h"
 #include "error.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
@@ -841,9 +842,9 @@ static void heartrate_adapter_remove(struct btd_profile *p,
 	heartrate_adapter_unregister(adapter);
 }
 
-static int heartrate_device_probe(struct btd_profile *p,
-						struct btd_device *device)
+static int heartrate_device_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_primary *prim;
 
 	prim = btd_device_get_primary(device, HEART_RATE_UUID);
@@ -853,9 +854,10 @@ static int heartrate_device_probe(struct btd_profile *p,
 	return heartrate_device_register(device, prim);
 }
 
-static void heartrate_device_remove(struct btd_profile *p,
-						struct btd_device *device)
+static void heartrate_device_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	heartrate_device_unregister(device);
 }
 
diff --git a/profiles/input/device.c b/profiles/input/device.c
index b6f9028..c9a3612 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -44,6 +44,7 @@
 #include "../src/adapter.h"
 #include "../src/device.h"
 #include "../src/profile.h"
+#include "../src/service.h"
 #include "../src/storage.h"
 #include "../src/dbus-common.h"
 
@@ -761,9 +762,10 @@ int input_device_disconnect(struct btd_device *dev, struct btd_profile *profile)
 	return 0;
 }
 
-static struct input_device *input_device_new(struct btd_device *device,
-							struct btd_profile *p)
+static struct input_device *input_device_new(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_profile *p = btd_service_get_profile(service);
 	const char *path = device_get_path(device);
 	const sdp_record_t *rec = btd_device_get_record(device, p->remote_uuid);
 	struct btd_adapter *adapter = device_get_adapter(device);
@@ -859,8 +861,9 @@ static const GDBusPropertyTable input_properties[] = {
 	{ }
 };
 
-int input_device_register(struct btd_profile *p, struct btd_device *device)
+int input_device_register(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	const char *path = device_get_path(device);
 	struct input_device *idev;
 
@@ -870,7 +873,7 @@ int input_device_register(struct btd_profile *p, struct btd_device *device)
 	if (idev)
 		return -EEXIST;
 
-	idev = input_device_new(device, p);
+	idev = input_device_new(service);
 	if (!idev)
 		return -EINVAL;
 
@@ -904,8 +907,9 @@ static struct input_device *find_device(const bdaddr_t *src,
 	return NULL;
 }
 
-void input_device_unregister(struct btd_profile *p, struct btd_device *device)
+void input_device_unregister(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	const char *path = device_get_path(device);
 	struct input_device *idev;
 
diff --git a/profiles/input/device.h b/profiles/input/device.h
index 1c237fc..fd7f847 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -29,8 +29,8 @@ struct input_conn;
 
 void input_set_idle_timeout(int timeout);
 
-int input_device_register(struct btd_profile *p, struct btd_device *device);
-void input_device_unregister(struct btd_profile *p, struct btd_device *device);
+int input_device_register(struct btd_service *service);
+void input_device_unregister(struct btd_service *service);
 
 int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 							GIOChannel *io);
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index eec0eee..c092875 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -46,6 +46,7 @@
 #include "src/adapter.h"
 #include "src/device.h"
 #include "src/profile.h"
+#include "src/service.h"
 
 #include "plugin.h"
 #include "suspend.h"
@@ -820,8 +821,9 @@ static void resume_callback(void)
 	g_slist_foreach(devices, set_suspend, GINT_TO_POINTER(suspend));
 }
 
-static int hog_probe(struct btd_profile *p, struct btd_device *device)
+static int hog_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	const char *path = device_get_path(device);
 	GSList *primaries, *l;
 
@@ -860,8 +862,9 @@ static void remove_device(gpointer a, gpointer b)
 	hog_unregister_device(hogdev);
 }
 
-static void hog_remove(struct btd_profile *p, struct btd_device *device)
+static void hog_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	const char *path = device_get_path(device);
 
 	DBG("path %s", path);
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 51cd4cf..dc771a6 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -39,6 +39,7 @@
 #include "../src/adapter.h"
 #include "../src/device.h"
 #include "../src/profile.h"
+#include "../src/service.h"
 
 #include "device.h"
 #include "server.h"
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 84359c0..cc7c5ce 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -44,6 +44,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "service.h"
 
 #include "error.h"
 #include "common.h"
@@ -640,8 +641,10 @@ static const GDBusPropertyTable connection_properties[] = {
 	{ }
 };
 
-void connection_unregister(struct btd_profile *p, struct btd_device *device)
+void connection_unregister(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_profile *p = btd_service_get_profile(service);
 	struct network_peer *peer;
 	uint16_t id = bnep_service_id(p->remote_uuid);
 
@@ -686,8 +689,10 @@ static struct network_peer *create_peer(struct btd_device *device)
 	return peer;
 }
 
-int connection_register(struct btd_profile *p, struct btd_device *device)
+int connection_register(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_profile *p = btd_service_get_profile(service);
 	struct network_peer *peer;
 	struct network_conn *nc;
 	uint16_t id = bnep_service_id(p->remote_uuid);
diff --git a/profiles/network/connection.h b/profiles/network/connection.h
index 5daead0..1e7eedb 100644
--- a/profiles/network/connection.h
+++ b/profiles/network/connection.h
@@ -21,7 +21,7 @@
  *
  */
 
-int connection_register(struct btd_profile *p, struct btd_device *device);
-void connection_unregister(struct btd_profile *p, struct btd_device *device);
+int connection_register(struct btd_service *service);
+void connection_unregister(struct btd_service *service);
 int connection_connect(struct btd_device *device, uint16_t id);
 int connection_disconnect(struct btd_device *device, uint16_t id);
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index df79351..f37954a 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -41,6 +41,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "service.h"
 #include "manager.h"
 #include "common.h"
 #include "connection.h"
diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index f24428b..7dab23f 100644
--- a/profiles/proximity/manager.c
+++ b/profiles/proximity/manager.c
@@ -35,6 +35,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "service.h"
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
 #include "attrib/gatt.h"
@@ -48,9 +49,9 @@ static struct enabled enabled  = {
 	.findme = TRUE,
 };
 
-static int monitor_linkloss_probe(struct btd_profile *p,
-						struct btd_device *device)
+static int monitor_linkloss_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_primary *linkloss;
 
 	linkloss = btd_device_get_primary(device, LINK_LOSS_UUID);
@@ -60,9 +61,9 @@ static int monitor_linkloss_probe(struct btd_profile *p,
 	return monitor_register_linkloss(device, &enabled, linkloss);
 }
 
-static int monitor_immediate_probe(struct btd_profile *p,
-						struct btd_device *device)
+static int monitor_immediate_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_primary *immediate;
 
 	immediate = btd_device_get_primary(device, IMMEDIATE_ALERT_UUID);
@@ -72,9 +73,9 @@ static int monitor_immediate_probe(struct btd_profile *p,
 	return monitor_register_immediate(device, &enabled, immediate);
 }
 
-static int monitor_txpower_probe(struct btd_profile *p,
-						struct btd_device *device)
+static int monitor_txpower_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_primary *txpower;
 
 	txpower = btd_device_get_primary(device, TX_POWER_UUID);
@@ -84,21 +85,24 @@ static int monitor_txpower_probe(struct btd_profile *p,
 	return monitor_register_txpower(device, &enabled, txpower);
 }
 
-static void monitor_linkloss_remove(struct btd_profile *p,
-						struct btd_device *device)
+static void monitor_linkloss_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	monitor_unregister_linkloss(device);
 }
 
-static void monitor_immediate_remove(struct btd_profile *p,
-						struct btd_device *device)
+static void monitor_immediate_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	monitor_unregister_immediate(device);
 }
 
-static void monitor_txpower_remove(struct btd_profile *p,
-						struct btd_device *device)
+static void monitor_txpower_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	monitor_unregister_txpower(device);
 }
 
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index 66f52fe..dbb593a 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -42,6 +42,7 @@
 #include "error.h"
 #include "device.h"
 #include "profile.h"
+#include "service.h"
 #include "hcid.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
@@ -203,8 +204,9 @@ static void register_reporter_device(struct btd_device *device,
 	radapter->devices = g_slist_prepend(radapter->devices, device);
 }
 
-int reporter_device_probe(struct btd_profile *p, struct btd_device *device)
+int reporter_device_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct reporter_adapter *radapter;
 	struct btd_adapter *adapter = device_get_adapter(device);
 
@@ -217,8 +219,9 @@ int reporter_device_probe(struct btd_profile *p, struct btd_device *device)
 	return 0;
 }
 
-void reporter_device_remove(struct btd_profile *p, struct btd_device *device)
+void reporter_device_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct reporter_adapter *radapter;
 	struct btd_adapter *adapter = device_get_adapter(device);
 
diff --git a/profiles/proximity/reporter.h b/profiles/proximity/reporter.h
index b02ae9c..a8e1aac 100644
--- a/profiles/proximity/reporter.h
+++ b/profiles/proximity/reporter.h
@@ -36,8 +36,8 @@ enum {
 	HIGH_ALERT = 0x02,
 };
 
-void reporter_device_remove(struct btd_profile *p, struct btd_device *device);
-int reporter_device_probe(struct btd_profile *p, struct btd_device *device);
+void reporter_device_remove(struct btd_service *service);
+int reporter_device_probe(struct btd_service *service);
 
 int reporter_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter);
 void reporter_adapter_remove(struct btd_profile *p,
diff --git a/profiles/sap/manager.c b/profiles/sap/manager.c
index fddd7aa..24b73e7 100644
--- a/profiles/sap/manager.c
+++ b/profiles/sap/manager.c
@@ -28,6 +28,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "service.h"
 
 #include "manager.h"
 #include "server.h"
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index deb0653..dbbb4ea 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -37,6 +37,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "service.h"
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
 #include "attrib/gatt.h"
@@ -266,8 +267,9 @@ static void scan_unregister(struct btd_device *device)
 	g_free(scan);
 }
 
-static int scan_param_probe(struct btd_profile *p, struct btd_device *device)
+static int scan_param_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_primary *prim;
 
 	DBG("Probing Scan Parameters");
@@ -279,8 +281,10 @@ static int scan_param_probe(struct btd_profile *p, struct btd_device *device)
 	return scan_register(device, prim);
 }
 
-static void scan_param_remove(struct btd_profile *p, struct btd_device *device)
+static void scan_param_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	scan_unregister(device);
 }
 
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index ae8ccb2..3757b25 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -35,6 +35,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "service.h"
 #include "error.h"
 #include "log.h"
 #include "attrib/gattrib.h"
@@ -1280,9 +1281,9 @@ static void thermometer_adapter_unregister(struct btd_adapter *adapter)
 					THERMOMETER_MANAGER_INTERFACE);
 }
 
-static int thermometer_device_probe(struct btd_profile *p,
-						struct btd_device *device)
+static int thermometer_device_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_primary *tattr;
 
 	tattr = btd_device_get_primary(device, HEALTH_THERMOMETER_UUID);
@@ -1292,9 +1293,10 @@ static int thermometer_device_probe(struct btd_profile *p,
 	return thermometer_register(device, tattr);
 }
 
-static void thermometer_device_remove(struct btd_profile *p,
-						struct btd_device *device)
+static void thermometer_device_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	thermometer_unregister(device);
 }
 
diff --git a/src/profile.c b/src/profile.c
index 7bd7970..b2c5ebf 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -50,6 +50,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "service.h"
 
 #define DUN_DEFAULT_CHANNEL	1
 #define SPP_DEFAULT_CHANNEL	3
@@ -1397,8 +1398,9 @@ static void ext_adapter_remove(struct btd_profile *p,
 	}
 }
 
-static int ext_device_probe(struct btd_profile *p, struct btd_device *dev)
+static int ext_device_probe(struct btd_service *service)
 {
+	struct btd_profile *p = btd_service_get_profile(service);
 	struct ext_profile *ext;
 
 	ext = find_ext(p);
@@ -1425,8 +1427,10 @@ static struct ext_io *find_connection(struct ext_profile *ext,
 	return NULL;
 }
 
-static void ext_device_remove(struct btd_profile *p, struct btd_device *dev)
+static void ext_device_remove(struct btd_service *service)
 {
+	struct btd_profile *p = btd_service_get_profile(service);
+	struct btd_device *dev = btd_service_get_device(service);
 	struct ext_profile *ext;
 	struct ext_io *conn;
 
diff --git a/src/profile.h b/src/profile.h
index 5622f23..8daa358 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -25,6 +25,8 @@
 #define BTD_PROFILE_PRIORITY_MEDIUM	1
 #define BTD_PROFILE_PRIORITY_HIGH	2
 
+struct btd_service;
+
 struct btd_profile {
 	const char *name;
 	int priority;
@@ -34,9 +36,8 @@ struct btd_profile {
 
 	bool auto_connect;
 
-	int (*device_probe) (struct btd_profile *p, struct btd_device *device);
-	void (*device_remove) (struct btd_profile *p,
-						struct btd_device *device);
+	int (*device_probe) (struct btd_service *service);
+	void (*device_remove) (struct btd_service *service);
 
 	int (*connect) (struct btd_device *device,
 						struct btd_profile *profile);
diff --git a/src/service.c b/src/service.c
index 298d600..a10138d 100644
--- a/src/service.c
+++ b/src/service.c
@@ -138,7 +138,7 @@ int service_probe(struct btd_service *service)
 
 	assert(service->state == BTD_SERVICE_STATE_UNAVAILABLE);
 
-	err = service->profile->device_probe(service->profile, service->device);
+	err = service->profile->device_probe(service);
 	if (err == 0) {
 		change_state(service, BTD_SERVICE_STATE_DISCONNECTED, 0);
 		return 0;
@@ -153,7 +153,7 @@ int service_probe(struct btd_service *service)
 void service_shutdown(struct btd_service *service)
 {
 	change_state(service, BTD_SERVICE_STATE_UNAVAILABLE, 0);
-	service->profile->device_remove(service->profile, service->device);
+	service->profile->device_remove(service);
 	service->device = NULL;
 	service->profile = NULL;
 }
-- 
1.8.1.4

