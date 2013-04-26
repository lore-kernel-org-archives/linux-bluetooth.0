Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 04/27] profile: Remove UUID list from probe function
Date: Fri, 26 Apr 2013 08:17:00 +0200
Message-Id: <1366957043-2383-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Each instance of btd_profile is associated to one single remote UUID
and therefore the list provided by the callback is redundant and can be
removed.
---
 profiles/audio/manager.c             |  9 +++------
 profiles/cyclingspeed/cyclingspeed.c |  3 +--
 profiles/deviceinfo/deviceinfo.c     |  3 +--
 profiles/gatt/gas.c                  |  3 +--
 profiles/health/hdp_manager.c        |  3 +--
 profiles/heartrate/heartrate.c       |  2 +-
 profiles/input/hog.c                 |  3 +--
 profiles/input/manager.c             |  3 +--
 profiles/network/manager.c           |  9 +++------
 profiles/proximity/manager.c         |  6 +++---
 profiles/proximity/reporter.c        |  3 +--
 profiles/proximity/reporter.h        |  3 +--
 profiles/scanparam/scan.c            |  3 +--
 profiles/thermometer/thermometer.c   |  3 +--
 src/device.c                         | 14 ++------------
 src/profile.c                        |  5 ++---
 src/profile.h                        |  3 +--
 17 files changed, 25 insertions(+), 53 deletions(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 8131a3e..f9c0ca6 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -101,8 +101,7 @@ static void audio_remove(struct btd_profile *p, struct btd_device *device)
 	audio_device_unregister(dev);
 }
 
-static int a2dp_source_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int a2dp_source_probe(struct btd_profile *p, struct btd_device *device)
 {
 	struct audio_device *audio_dev;
 
@@ -117,8 +116,7 @@ static int a2dp_source_probe(struct btd_profile *p, struct btd_device *device,
 	return 0;
 }
 
-static int a2dp_sink_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int a2dp_sink_probe(struct btd_profile *p, struct btd_device *device)
 {
 	struct audio_device *audio_dev;
 
@@ -133,8 +131,7 @@ static int a2dp_sink_probe(struct btd_profile *p, struct btd_device *device,
 	return 0;
 }
 
-static int avrcp_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int avrcp_probe(struct btd_profile *p, struct btd_device *device)
 {
 	struct audio_device *audio_dev;
 
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 125007e..744bd4b 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -1180,8 +1180,7 @@ static const GDBusMethodTable cyclingspeed_device_methods[] = {
 	{ }
 };
 
-static int csc_device_probe(struct btd_profile *p,
-				struct btd_device *device, GSList *uuids)
+static int csc_device_probe(struct btd_profile *p, struct btd_device *device)
 {
 	struct btd_adapter *adapter;
 	struct csc_adapter *cadapter;
diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index 471241b..08f53b3 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -199,8 +199,7 @@ static void deviceinfo_unregister(struct btd_device *device)
 }
 
 static int deviceinfo_driver_probe(struct btd_profile *p,
-					struct btd_device *device,
-					GSList *uuids)
+						struct btd_device *device)
 {
 	struct gatt_primary *prim;
 
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index bc8dbb5..4c7af4b 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -407,8 +407,7 @@ static void gas_unregister(struct btd_device *device)
 	gas_free(gas);
 }
 
-static int gatt_driver_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int gatt_driver_probe(struct btd_profile *p, struct btd_device *device)
 {
 	struct gatt_primary *gap, *gatt;
 
diff --git a/profiles/health/hdp_manager.c b/profiles/health/hdp_manager.c
index 5428724..3777fd4 100644
--- a/profiles/health/hdp_manager.c
+++ b/profiles/health/hdp_manager.c
@@ -54,8 +54,7 @@ static void hdp_adapter_remove(struct btd_profile *p,
 	hdp_adapter_unregister(adapter);
 }
 
-static int hdp_driver_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int hdp_driver_probe(struct btd_profile *p, struct btd_device *device)
 {
 	return hdp_device_register(device);
 }
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 0520f5c..18a9448 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -842,7 +842,7 @@ static void heartrate_adapter_remove(struct btd_profile *p,
 }
 
 static int heartrate_device_probe(struct btd_profile *p,
-				struct btd_device *device, GSList *uuids)
+						struct btd_device *device)
 {
 	struct gatt_primary *prim;
 
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index eadc860..eec0eee 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -820,8 +820,7 @@ static void resume_callback(void)
 	g_slist_foreach(devices, set_suspend, GINT_TO_POINTER(suspend));
 }
 
-static int hog_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int hog_probe(struct btd_profile *p, struct btd_device *device)
 {
 	const char *path = device_get_path(device);
 	GSList *primaries, *l;
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 8bbf768..d3d4cf3 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -55,8 +55,7 @@ static void input_remove(struct btd_device *device, const char *uuid)
 	input_device_unregister(path, uuid);
 }
 
-static int hid_device_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int hid_device_probe(struct btd_profile *p, struct btd_device *device)
 {
 	const char *path = device_get_path(device);
 	const sdp_record_t *rec = btd_device_get_record(device, HID_UUID);
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 53bb652..4aa6a2b 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -74,8 +74,7 @@ done:
 				conf_security ? "true" : "false");
 }
 
-static int panu_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int panu_probe(struct btd_profile *p, struct btd_device *device)
 {
 	DBG("path %s", device_get_path(device));
 
@@ -118,8 +117,7 @@ static void panu_server_remove(struct btd_profile *p,
 	server_unregister(adapter, BNEP_SVC_PANU);
 }
 
-static int gn_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int gn_probe(struct btd_profile *p, struct btd_device *device)
 {
 	DBG("path %s", device_get_path(device));
 
@@ -155,8 +153,7 @@ static void gn_server_remove(struct btd_profile *p,
 	server_unregister(adapter, BNEP_SVC_GN);
 }
 
-static int nap_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int nap_probe(struct btd_profile *p, struct btd_device *device)
 {
 	DBG("path %s", device_get_path(device));
 
diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index 81bfc3b..f24428b 100644
--- a/profiles/proximity/manager.c
+++ b/profiles/proximity/manager.c
@@ -49,7 +49,7 @@ static struct enabled enabled  = {
 };
 
 static int monitor_linkloss_probe(struct btd_profile *p,
-				struct btd_device *device, GSList *uuids)
+						struct btd_device *device)
 {
 	struct gatt_primary *linkloss;
 
@@ -61,7 +61,7 @@ static int monitor_linkloss_probe(struct btd_profile *p,
 }
 
 static int monitor_immediate_probe(struct btd_profile *p,
-				struct btd_device *device, GSList *uuids)
+						struct btd_device *device)
 {
 	struct gatt_primary *immediate;
 
@@ -73,7 +73,7 @@ static int monitor_immediate_probe(struct btd_profile *p,
 }
 
 static int monitor_txpower_probe(struct btd_profile *p,
-				struct btd_device *device, GSList *uuids)
+						struct btd_device *device)
 {
 	struct gatt_primary *txpower;
 
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index 31c33ef..66f52fe 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -203,8 +203,7 @@ static void register_reporter_device(struct btd_device *device,
 	radapter->devices = g_slist_prepend(radapter->devices, device);
 }
 
-int reporter_device_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+int reporter_device_probe(struct btd_profile *p, struct btd_device *device)
 {
 	struct reporter_adapter *radapter;
 	struct btd_adapter *adapter = device_get_adapter(device);
diff --git a/profiles/proximity/reporter.h b/profiles/proximity/reporter.h
index 6a7066d..b02ae9c 100644
--- a/profiles/proximity/reporter.h
+++ b/profiles/proximity/reporter.h
@@ -37,8 +37,7 @@ enum {
 };
 
 void reporter_device_remove(struct btd_profile *p, struct btd_device *device);
-int reporter_device_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids);
+int reporter_device_probe(struct btd_profile *p, struct btd_device *device);
 
 int reporter_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter);
 void reporter_adapter_remove(struct btd_profile *p,
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index abbd129..deb0653 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -266,8 +266,7 @@ static void scan_unregister(struct btd_device *device)
 	g_free(scan);
 }
 
-static int scan_param_probe(struct btd_profile *p, struct btd_device *device,
-								GSList *uuids)
+static int scan_param_probe(struct btd_profile *p, struct btd_device *device)
 {
 	struct gatt_primary *prim;
 
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 8550500..ae8ccb2 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -1281,8 +1281,7 @@ static void thermometer_adapter_unregister(struct btd_adapter *adapter)
 }
 
 static int thermometer_device_probe(struct btd_profile *p,
-					struct btd_device *device,
-					GSList *uuids)
+						struct btd_device *device)
 {
 	struct gatt_primary *tattr;
 
diff --git a/src/device.c b/src/device.c
index 18beed9..01afd49 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2330,7 +2330,6 @@ struct probe_data {
 static void dev_probe(struct btd_profile *p, void *user_data)
 {
 	struct probe_data *d = user_data;
-	GSList *probe_uuids;
 	int err;
 
 	if (p->device_probe == NULL)
@@ -2339,24 +2338,19 @@ static void dev_probe(struct btd_profile *p, void *user_data)
 	if (!device_match_profile(d->dev, p, d->uuids))
 		return;
 
-	probe_uuids = g_slist_append(NULL, (char *) p->remote_uuid);
-
-	err = p->device_probe(p, d->dev, probe_uuids);
+	err = p->device_probe(p, d->dev);
 	if (err < 0) {
 		error("%s profile probe failed for %s", p->name, d->addr);
-		g_slist_free(probe_uuids);
 		return;
 	}
 
 	d->dev->profiles = g_slist_append(d->dev->profiles, p);
-	g_slist_free(probe_uuids);
 }
 
 void device_probe_profile(gpointer a, gpointer b)
 {
 	struct btd_device *device = a;
 	struct btd_profile *profile = b;
-	GSList *probe_uuids;
 	char addr[18];
 	int err;
 
@@ -2366,19 +2360,15 @@ void device_probe_profile(gpointer a, gpointer b)
 	if (!device_match_profile(device, profile, device->uuids))
 		return;
 
-	probe_uuids = g_slist_append(NULL, (char *) profile->remote_uuid);
-
 	ba2str(&device->bdaddr, addr);
 
-	err = profile->device_probe(profile, device, probe_uuids);
+	err = profile->device_probe(profile, device);
 	if (err < 0) {
 		error("%s profile probe failed for %s", profile->name, addr);
-		g_slist_free(probe_uuids);
 		return;
 	}
 
 	device->profiles = g_slist_append(device->profiles, profile);
-	g_slist_free(probe_uuids);
 
 	if (!profile->auto_connect || !device->general_connect)
 		return;
diff --git a/src/profile.c b/src/profile.c
index 55e72dd..7bd7970 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1397,8 +1397,7 @@ static void ext_adapter_remove(struct btd_profile *p,
 	}
 }
 
-static int ext_device_probe(struct btd_profile *p, struct btd_device *dev,
-								GSList *uuids)
+static int ext_device_probe(struct btd_profile *p, struct btd_device *dev)
 {
 	struct ext_profile *ext;
 
@@ -1406,7 +1405,7 @@ static int ext_device_probe(struct btd_profile *p, struct btd_device *dev,
 	if (!ext)
 		return -ENOENT;
 
-	DBG("%s probed with %u UUIDs", ext->name, g_slist_length(uuids));
+	DBG("%s probed with UUID %s", ext->name, p->remote_uuid);
 
 	return 0;
 }
diff --git a/src/profile.h b/src/profile.h
index 5d78b37..5622f23 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -34,8 +34,7 @@ struct btd_profile {
 
 	bool auto_connect;
 
-	int (*device_probe) (struct btd_profile *p, struct btd_device *device,
-								GSList *uuids);
+	int (*device_probe) (struct btd_profile *p, struct btd_device *device);
 	void (*device_remove) (struct btd_profile *p,
 						struct btd_device *device);
 
-- 
1.8.1.4

