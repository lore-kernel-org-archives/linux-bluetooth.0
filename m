Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 06/11] profile: Use btd_service for probing profiles
Date: Fri,  5 Apr 2013 13:45:43 +0200
Message-Id: <1365162348-25541-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1365162348-25541-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1365162348-25541-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Change the profile probe mechanism in order to pass the btd_service
instance representing the remote service. This object is bound to a
btd_profile and a btd_device, thus replacing the previous parameters.

The probe callback is allowed to hold a reference to the btd_service
by means of btd_service_ref(), which should be unreferenced during
removal. In addition, the probe callback is allowed to set the
user_data pointer associated to the btd_service by using
service_set_user_data().

Keeping such a reference of the btd_service allows supporting multiple
instances of the same UUID, since the reference can serve as a handle
during the interactions between the profile implementation and the core.
---
 profiles/audio/control.c             |  8 ++++----
 profiles/audio/control.h             |  4 ++--
 profiles/audio/manager.c             | 21 ++++++++++++---------
 profiles/cyclingspeed/cyclingspeed.c |  9 +++++----
 profiles/deviceinfo/deviceinfo.c     | 11 ++++++-----
 profiles/gatt/gas.c                  | 10 ++++++----
 profiles/health/hdp_manager.c        | 10 +++++++---
 profiles/heartrate/heartrate.c       | 10 ++++++----
 profiles/input/hog.c                 |  8 +++++---
 profiles/input/manager.c             | 11 +++++++----
 profiles/network/manager.c           | 20 +++++++++++++-------
 profiles/proximity/manager.c         | 28 ++++++++++++++++------------
 profiles/proximity/reporter.c        |  8 +++++---
 profiles/proximity/reporter.h        |  5 ++---
 profiles/sap/manager.c               |  1 +
 profiles/scanparam/scan.c            |  9 ++++++---
 profiles/thermometer/thermometer.c   | 11 ++++++-----
 src/device.c                         | 11 +++--------
 src/profile.c                        | 11 +++++++----
 src/profile.h                        |  8 ++++----
 20 files changed, 123 insertions(+), 91 deletions(-)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 6086bde..fd5ff92 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -253,13 +253,13 @@ void control_unregister(struct audio_device *dev)
 						AUDIO_CONTROL_INTERFACE);
 }
 
-void control_update(struct control *control, GSList *uuids)
+void control_update(struct control *control, const char *uuid)
 {
-	if (g_slist_find_custom(uuids, AVRCP_TARGET_UUID, bt_uuid_strcmp))
+	if (bt_uuid_strcmp(uuid, AVRCP_TARGET_UUID) == 0)
 		control->target = TRUE;
 }
 
-struct control *control_init(struct audio_device *dev, GSList *uuids)
+struct control *control_init(struct audio_device *dev, const char *uuid)
 {
 	struct control *control;
 
@@ -276,7 +276,7 @@ struct control *control_init(struct audio_device *dev, GSList *uuids)
 
 	control = g_new0(struct control, 1);
 
-	control_update(control, uuids);
+	control_update(control, uuid);
 
 	control->avctp_id = avctp_add_state_cb(dev, state_changed);
 
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index de0259e..82ad0d2 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -24,8 +24,8 @@
 
 #define AUDIO_CONTROL_INTERFACE "org.bluez.MediaControl1"
 
-struct control *control_init(struct audio_device *dev, GSList *uuids);
-void control_update(struct control *control, GSList *uuids);
+struct control *control_init(struct audio_device *dev, const char *uuid);
+void control_update(struct control *control, const char *uuid);
 void control_unregister(struct audio_device *dev);
 gboolean control_is_active(struct audio_device *dev);
 
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 4517815..ff4590e 100644
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
@@ -101,9 +103,9 @@ static void audio_remove(struct btd_profile *p, struct btd_device *device)
 	audio_device_unregister(dev);
 }
 
-static int a2dp_source_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int a2dp_source_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct audio_device *audio_dev;
 
 	audio_dev = get_audio_dev(device);
@@ -117,9 +119,9 @@ static int a2dp_source_probe(struct btd_profile *p, struct btd_device *device,
 	return 0;
 }
 
-static int a2dp_sink_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int a2dp_sink_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct audio_device *audio_dev;
 
 	audio_dev = get_audio_dev(device);
@@ -133,9 +135,10 @@ static int a2dp_sink_probe(struct btd_profile *p, struct btd_device *device,
 	return 0;
 }
 
-static int avrcp_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int avrcp_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_profile *p = btd_service_get_profile(service);
 	struct audio_device *audio_dev;
 
 	audio_dev = get_audio_dev(device);
@@ -145,9 +148,9 @@ static int avrcp_probe(struct btd_profile *p, struct btd_device *device,
 	}
 
 	if (audio_dev->control)
-		control_update(audio_dev->control, uuids);
+		control_update(audio_dev->control, p->remote_uuid);
 	else
-		audio_dev->control = control_init(audio_dev, uuids);
+		audio_dev->control = control_init(audio_dev, p->remote_uuid);
 
 	if (audio_dev->sink && sink_is_active(audio_dev))
 		avrcp_connect(audio_dev);
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 125007e..6080f09 100644
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
@@ -1180,9 +1181,9 @@ static const GDBusMethodTable cyclingspeed_device_methods[] = {
 	{ }
 };
 
-static int csc_device_probe(struct btd_profile *p,
-				struct btd_device *device, GSList *uuids)
+static int csc_device_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct btd_adapter *adapter;
 	struct csc_adapter *cadapter;
 	struct csc *csc;
@@ -1227,9 +1228,9 @@ static int csc_device_probe(struct btd_profile *p,
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
index 471241b..fc8babd 100644
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
@@ -198,10 +199,9 @@ static void deviceinfo_unregister(struct btd_device *device)
 	deviceinfo_free(d);
 }
 
-static int deviceinfo_driver_probe(struct btd_profile *p,
-					struct btd_device *device,
-					GSList *uuids)
+static int deviceinfo_driver_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_primary *prim;
 
 	prim = btd_device_get_primary(device, DEVICE_INFORMATION_UUID);
@@ -211,9 +211,10 @@ static int deviceinfo_driver_probe(struct btd_profile *p,
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
index bc8dbb5..33a680f 100644
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
@@ -407,9 +408,9 @@ static void gas_unregister(struct btd_device *device)
 	gas_free(gas);
 }
 
-static int gatt_driver_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int gatt_driver_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_primary *gap, *gatt;
 
 	gap = btd_device_get_primary(device, GAP_UUID);
@@ -423,9 +424,10 @@ static int gatt_driver_probe(struct btd_profile *p, struct btd_device *device,
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
index 5428724..1bb6007 100644
--- a/profiles/health/hdp_manager.c
+++ b/profiles/health/hdp_manager.c
@@ -34,6 +34,7 @@
 #include <adapter.h>
 #include <device.h>
 #include <profile.h>
+#include <service.h>
 #include <glib-helper.h>
 #include <log.h>
 
@@ -54,14 +55,17 @@ static void hdp_adapter_remove(struct btd_profile *p,
 	hdp_adapter_unregister(adapter);
 }
 
-static int hdp_driver_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
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
index 0520f5c..3a2d419 100644
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
-				struct btd_device *device, GSList *uuids)
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
 
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index eadc860..c092875 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -46,6 +46,7 @@
 #include "src/adapter.h"
 #include "src/device.h"
 #include "src/profile.h"
+#include "src/service.h"
 
 #include "plugin.h"
 #include "suspend.h"
@@ -820,9 +821,9 @@ static void resume_callback(void)
 	g_slist_foreach(devices, set_suspend, GINT_TO_POINTER(suspend));
 }
 
-static int hog_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int hog_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	const char *path = device_get_path(device);
 	GSList *primaries, *l;
 
@@ -861,8 +862,9 @@ static void remove_device(gpointer a, gpointer b)
 	hog_unregister_device(hogdev);
 }
 
-static void hog_remove(struct btd_profile *p, struct btd_device *device)
+static void hog_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	const char *path = device_get_path(device);
 
 	DBG("path %s", path);
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index d30ba67..72a4e3b 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -39,6 +39,7 @@
 #include "../src/adapter.h"
 #include "../src/device.h"
 #include "../src/profile.h"
+#include "../src/service.h"
 
 #include "device.h"
 #include "server.h"
@@ -55,11 +56,11 @@ static void input_remove(struct btd_device *device, const char *uuid)
 	input_device_unregister(path, uuid);
 }
 
-static int hid_device_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int hid_device_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	const char *path = device_get_path(device);
-	const sdp_record_t *rec = btd_device_get_record(device, uuids->data);
+	const sdp_record_t *rec = btd_device_get_record(device, HID_UUID);
 
 	DBG("path %s", path);
 
@@ -70,8 +71,10 @@ static int hid_device_probe(struct btd_profile *p, struct btd_device *device,
 							idle_timeout * 60);
 }
 
-static void hid_device_remove(struct btd_profile *p, struct btd_device *device)
+static void hid_device_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	input_remove(device, HID_UUID);
 }
 
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 53bb652..d860cc0 100644
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
@@ -74,16 +75,19 @@ done:
 				conf_security ? "true" : "false");
 }
 
-static int panu_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int panu_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	DBG("path %s", device_get_path(device));
 
 	return connection_register(device, BNEP_SVC_PANU);
 }
 
-static void network_remove(struct btd_profile *p, struct btd_device *device)
+static void network_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	DBG("path %s", device_get_path(device));
 
 	connection_unregister(device);
@@ -118,9 +122,10 @@ static void panu_server_remove(struct btd_profile *p,
 	server_unregister(adapter, BNEP_SVC_PANU);
 }
 
-static int gn_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int gn_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	DBG("path %s", device_get_path(device));
 
 	return connection_register(device, BNEP_SVC_GN);
@@ -155,9 +160,10 @@ static void gn_server_remove(struct btd_profile *p,
 	server_unregister(adapter, BNEP_SVC_GN);
 }
 
-static int nap_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int nap_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+
 	DBG("path %s", device_get_path(device));
 
 	return connection_register(device, BNEP_SVC_NAP);
diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index 81bfc3b..7dab23f 100644
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
-				struct btd_device *device, GSList *uuids)
+static int monitor_linkloss_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_primary *linkloss;
 
 	linkloss = btd_device_get_primary(device, LINK_LOSS_UUID);
@@ -60,9 +61,9 @@ static int monitor_linkloss_probe(struct btd_profile *p,
 	return monitor_register_linkloss(device, &enabled, linkloss);
 }
 
-static int monitor_immediate_probe(struct btd_profile *p,
-				struct btd_device *device, GSList *uuids)
+static int monitor_immediate_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_primary *immediate;
 
 	immediate = btd_device_get_primary(device, IMMEDIATE_ALERT_UUID);
@@ -72,9 +73,9 @@ static int monitor_immediate_probe(struct btd_profile *p,
 	return monitor_register_immediate(device, &enabled, immediate);
 }
 
-static int monitor_txpower_probe(struct btd_profile *p,
-				struct btd_device *device, GSList *uuids)
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
index 31c33ef..dbb593a 100644
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
@@ -203,9 +204,9 @@ static void register_reporter_device(struct btd_device *device,
 	radapter->devices = g_slist_prepend(radapter->devices, device);
 }
 
-int reporter_device_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+int reporter_device_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct reporter_adapter *radapter;
 	struct btd_adapter *adapter = device_get_adapter(device);
 
@@ -218,8 +219,9 @@ int reporter_device_probe(struct btd_profile *p, struct btd_device *device,
 	return 0;
 }
 
-void reporter_device_remove(struct btd_profile *p, struct btd_device *device)
+void reporter_device_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct reporter_adapter *radapter;
 	struct btd_adapter *adapter = device_get_adapter(device);
 
diff --git a/profiles/proximity/reporter.h b/profiles/proximity/reporter.h
index 6a7066d..a8e1aac 100644
--- a/profiles/proximity/reporter.h
+++ b/profiles/proximity/reporter.h
@@ -36,9 +36,8 @@ enum {
 	HIGH_ALERT = 0x02,
 };
 
-void reporter_device_remove(struct btd_profile *p, struct btd_device *device);
-int reporter_device_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids);
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
index abbd129..dbbb4ea 100644
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
@@ -266,9 +267,9 @@ static void scan_unregister(struct btd_device *device)
 	g_free(scan);
 }
 
-static int scan_param_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int scan_param_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_primary *prim;
 
 	DBG("Probing Scan Parameters");
@@ -280,8 +281,10 @@ static int scan_param_probe(struct btd_profile *p, struct btd_device *device,
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
index 8550500..3757b25 100644
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
@@ -1280,10 +1281,9 @@ static void thermometer_adapter_unregister(struct btd_adapter *adapter)
 					THERMOMETER_MANAGER_INTERFACE);
 }
 
-static int thermometer_device_probe(struct btd_profile *p,
-					struct btd_device *device,
-					GSList *uuids)
+static int thermometer_device_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_primary *tattr;
 
 	tattr = btd_device_get_primary(device, HEALTH_THERMOMETER_UUID);
@@ -1293,9 +1293,10 @@ static int thermometer_device_probe(struct btd_profile *p,
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
 
diff --git a/src/device.c b/src/device.c
index dd2b7af..22fbfcb 100644
--- a/src/device.c
+++ b/src/device.c
@@ -905,7 +905,7 @@ static void service_remove(struct btd_service *service)
 	struct btd_device *device = btd_service_get_device(service);
 
 	btd_service_unavailable(service);
-	profile->device_remove(profile, device);
+	profile->device_remove(service);
 	device->pending = g_slist_remove(device->pending, service);
 	btd_service_unref(service);
 }
@@ -2392,7 +2392,6 @@ struct probe_data {
 static void dev_probe(struct btd_profile *p, void *user_data)
 {
 	struct probe_data *d = user_data;
-	GSList *probe_uuids;
 	struct btd_service *service;
 	int err;
 
@@ -2402,21 +2401,17 @@ static void dev_probe(struct btd_profile *p, void *user_data)
 	if (!device_match_profile(d->dev, p, d->uuids))
 		return;
 
-	probe_uuids = g_slist_append(NULL, (char *) p->remote_uuid);
-
 	service = service_create(d->dev, p);
 
-	err = p->device_probe(p, d->dev, probe_uuids);
+	err = p->device_probe(service);
 	if (err < 0) {
 		error("%s profile probe failed for %s", p->name, d->addr);
 		btd_service_unref(service);
-		g_slist_free(probe_uuids);
 		return;
 	}
 
 	btd_service_probed(service);
 	d->dev->services = g_slist_append(d->dev->services, service);
-	g_slist_free(probe_uuids);
 }
 
 void device_probe_profile(gpointer a, gpointer b)
@@ -2440,7 +2435,7 @@ void device_probe_profile(gpointer a, gpointer b)
 
 	service = service_create(device, profile);
 
-	err = profile->device_probe(profile, device, probe_uuids);
+	err = profile->device_probe(service);
 	if (err < 0) {
 		error("%s profile probe failed for %s", profile->name, addr);
 		btd_service_unref(service);
diff --git a/src/profile.c b/src/profile.c
index 29f9ee6..d0aa332 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -50,6 +50,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "service.h"
 
 #define DUN_DEFAULT_CHANNEL	1
 #define SPP_DEFAULT_CHANNEL	3
@@ -1359,16 +1360,16 @@ static void ext_adapter_remove(struct btd_profile *p,
 	}
 }
 
-static int ext_device_probe(struct btd_profile *p, struct btd_device *dev,
-								GSList *uuids)
+static int ext_device_probe(struct btd_service *service)
 {
+	struct btd_profile *p = btd_service_get_profile(service);
 	struct ext_profile *ext;
 
 	ext = find_ext(p);
 	if (!ext)
 		return -ENOENT;
 
-	DBG("%s probed with %u UUIDs", ext->name, g_slist_length(uuids));
+	DBG("%s probed with UUID %s", ext->name, p->remote_uuid);
 
 	return 0;
 }
@@ -1388,8 +1389,10 @@ static struct ext_io *find_connection(struct ext_profile *ext,
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
index 5d78b37..8daa358 100644
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
@@ -34,10 +36,8 @@ struct btd_profile {
 
 	bool auto_connect;
 
-	int (*device_probe) (struct btd_profile *p, struct btd_device *device,
-								GSList *uuids);
-	void (*device_remove) (struct btd_profile *p,
-						struct btd_device *device);
+	int (*device_probe) (struct btd_service *service);
+	void (*device_remove) (struct btd_service *service);
 
 	int (*connect) (struct btd_device *device,
 						struct btd_profile *profile);
-- 
1.8.1.4

