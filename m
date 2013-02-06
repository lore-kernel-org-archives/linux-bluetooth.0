Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 7/7] profile: Limit to one remote UUID per profile
Date: Wed,  6 Feb 2013 10:16:27 +0100
Message-Id: <1360142187-15347-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1360142187-15347-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1360142187-15347-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The code can be considerably simplified by constraining struct
btd_profile to one single remote UUID.
---
 profiles/audio/manager.c             |  8 +++---
 profiles/cyclingspeed/cyclingspeed.c |  2 +-
 profiles/deviceinfo/deviceinfo.c     |  2 +-
 profiles/gatt/gas.c                  |  2 +-
 profiles/health/hdp_manager.c        |  4 +--
 profiles/heartrate/heartrate.c       |  2 +-
 profiles/input/hog.c                 |  2 +-
 profiles/input/manager.c             |  2 +-
 profiles/network/manager.c           |  6 ++---
 profiles/proximity/manager.c         |  8 +++---
 profiles/scanparam/scan.c            |  2 +-
 profiles/thermometer/thermometer.c   |  2 +-
 src/device.c                         | 49 +++++++++++++-----------------------
 src/profile.c                        | 25 ++++++++----------
 src/profile.h                        |  4 +--
 15 files changed, 49 insertions(+), 71 deletions(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 3023249..5799e77 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -345,7 +345,7 @@ static struct btd_profile a2dp_source_profile = {
 	.name		= "audio-source",
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
 
-	.remote_uuids	= BTD_UUIDS(A2DP_SOURCE_UUID),
+	.remote_uuid	= A2DP_SOURCE_UUID,
 	.device_probe	= a2dp_source_probe,
 	.device_remove	= audio_remove,
 
@@ -361,7 +361,7 @@ static struct btd_profile a2dp_sink_profile = {
 	.name		= "audio-sink",
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
 
-	.remote_uuids	= BTD_UUIDS(A2DP_SINK_UUID),
+	.remote_uuid	= A2DP_SINK_UUID,
 	.device_probe	= a2dp_sink_probe,
 	.device_remove	= audio_remove,
 
@@ -376,7 +376,7 @@ static struct btd_profile a2dp_sink_profile = {
 static struct btd_profile avrcp_target_profile = {
 	.name		= "audio-avrcp-target",
 
-	.remote_uuids	= BTD_UUIDS(AVRCP_TARGET_UUID),
+	.remote_uuid	= AVRCP_TARGET_UUID,
 	.device_probe	= avrcp_probe,
 	.device_remove	= audio_remove,
 
@@ -391,7 +391,7 @@ static struct btd_profile avrcp_target_profile = {
 static struct btd_profile avrcp_remote_profile = {
 	.name		= "audio-avrcp-control",
 
-	.remote_uuids	= BTD_UUIDS(AVRCP_REMOTE_UUID),
+	.remote_uuid	= AVRCP_REMOTE_UUID,
 	.device_probe	= avrcp_probe,
 	.device_remove	= audio_remove,
 
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index fc72791..125007e 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -1256,7 +1256,7 @@ static void csc_device_remove(struct btd_profile *p,
 
 static struct btd_profile cscp_profile = {
 	.name		= "Cycling Speed and Cadence GATT Driver",
-	.remote_uuids	= BTD_UUIDS(CYCLING_SC_UUID),
+	.remote_uuid	= CYCLING_SC_UUID,
 
 	.adapter_probe	= csc_adapter_probe,
 	.adapter_remove	= csc_adapter_remove,
diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index fb423fa..471241b 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -219,7 +219,7 @@ static void deviceinfo_driver_remove(struct btd_profile *p,
 
 static struct btd_profile deviceinfo_profile = {
 	.name		= "deviceinfo",
-	.remote_uuids	= BTD_UUIDS(DEVICE_INFORMATION_UUID),
+	.remote_uuid	= DEVICE_INFORMATION_UUID,
 	.device_probe	= deviceinfo_driver_probe,
 	.device_remove	= deviceinfo_driver_remove
 };
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 6a8571c..bc8dbb5 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -431,7 +431,7 @@ static void gatt_driver_remove(struct btd_profile *p,
 
 static struct btd_profile gatt_profile = {
 	.name		= "gap-gatt-profile",
-	.remote_uuids	= BTD_UUIDS(GATT_UUID),
+	.remote_uuid	= GATT_UUID,
 	.device_probe	= gatt_driver_probe,
 	.device_remove	= gatt_driver_remove
 };
diff --git a/profiles/health/hdp_manager.c b/profiles/health/hdp_manager.c
index 9df5b2b..5428724 100644
--- a/profiles/health/hdp_manager.c
+++ b/profiles/health/hdp_manager.c
@@ -67,7 +67,7 @@ static void hdp_driver_remove(struct btd_profile *p, struct btd_device *device)
 
 static struct btd_profile hdp_source_profile = {
 	.name		= "hdp-source",
-	.remote_uuids	= BTD_UUIDS(HDP_SOURCE_UUID),
+	.remote_uuid	= HDP_SOURCE_UUID,
 
 	.device_probe	= hdp_driver_probe,
 	.device_remove	= hdp_driver_remove,
@@ -78,7 +78,7 @@ static struct btd_profile hdp_source_profile = {
 
 static struct btd_profile hdp_sink_profile = {
 	.name		= "hdp-sink",
-	.remote_uuids	= BTD_UUIDS(HDP_SINK_UUID),
+	.remote_uuid	= HDP_SINK_UUID,
 
 	.device_probe	= hdp_driver_probe,
 	.device_remove	= hdp_driver_remove,
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 5c56d3f..0520f5c 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -861,7 +861,7 @@ static void heartrate_device_remove(struct btd_profile *p,
 
 static struct btd_profile hrp_profile = {
 	.name		= "Heart Rate GATT Driver",
-	.remote_uuids	= BTD_UUIDS(HEART_RATE_UUID),
+	.remote_uuid	= HEART_RATE_UUID,
 
 	.device_probe	= heartrate_device_probe,
 	.device_remove	= heartrate_device_remove,
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index a5269d9..eadc860 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -872,7 +872,7 @@ static void hog_remove(struct btd_profile *p, struct btd_device *device)
 
 static struct btd_profile hog_profile = {
 	.name		= "input-hog",
-	.remote_uuids	= BTD_UUIDS(HOG_UUID),
+	.remote_uuid	= HOG_UUID,
 	.device_probe	= hog_probe,
 	.device_remove	= hog_remove,
 };
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 6ed12ee..d30ba67 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -89,7 +89,7 @@ static void hid_server_remove(struct btd_profile *p,
 static struct btd_profile input_profile = {
 	.name		= "input-hid",
 	.local_uuid	= HID_UUID,
-	.remote_uuids	= BTD_UUIDS(HID_UUID),
+	.remote_uuid	= HID_UUID,
 
 	.auto_connect	= true,
 	.connect	= input_device_connect,
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index bc553c4..53bb652 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -195,7 +195,7 @@ static void nap_server_remove(struct btd_profile *p,
 static struct btd_profile panu_profile = {
 	.name		= "network-panu",
 	.local_uuid	= NAP_UUID,
-	.remote_uuids	= BTD_UUIDS(PANU_UUID),
+	.remote_uuid	= PANU_UUID,
 	.device_probe	= panu_probe,
 	.device_remove	= network_remove,
 	.connect	= panu_connect,
@@ -207,7 +207,7 @@ static struct btd_profile panu_profile = {
 static struct btd_profile gn_profile = {
 	.name		= "network-gn",
 	.local_uuid	= PANU_UUID,
-	.remote_uuids	= BTD_UUIDS(GN_UUID),
+	.remote_uuid	= GN_UUID,
 	.device_probe	= gn_probe,
 	.device_remove	= network_remove,
 	.connect	= gn_connect,
@@ -219,7 +219,7 @@ static struct btd_profile gn_profile = {
 static struct btd_profile nap_profile = {
 	.name		= "network-nap",
 	.local_uuid	= PANU_UUID,
-	.remote_uuids	= BTD_UUIDS(NAP_UUID),
+	.remote_uuid	= NAP_UUID,
 	.device_probe	= nap_probe,
 	.device_remove	= network_remove,
 	.connect	= nap_connect,
diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index 7579be5..81bfc3b 100644
--- a/profiles/proximity/manager.c
+++ b/profiles/proximity/manager.c
@@ -104,28 +104,28 @@ static void monitor_txpower_remove(struct btd_profile *p,
 
 static struct btd_profile pxp_monitor_linkloss_profile = {
 	.name		= "proximity-linkloss",
-	.remote_uuids	= BTD_UUIDS(LINK_LOSS_UUID),
+	.remote_uuid	= LINK_LOSS_UUID,
 	.device_probe	= monitor_linkloss_probe,
 	.device_remove	= monitor_linkloss_remove,
 };
 
 static struct btd_profile pxp_monitor_immediate_profile = {
 	.name		= "proximity-immediate",
-	.remote_uuids	= BTD_UUIDS(IMMEDIATE_ALERT_UUID),
+	.remote_uuid	= IMMEDIATE_ALERT_UUID,
 	.device_probe	= monitor_immediate_probe,
 	.device_remove	= monitor_immediate_remove,
 };
 
 static struct btd_profile pxp_monitor_txpower_profile = {
 	.name		= "proximity-txpower",
-	.remote_uuids	= BTD_UUIDS(TX_POWER_UUID),
+	.remote_uuid	= TX_POWER_UUID,
 	.device_probe	= monitor_txpower_probe,
 	.device_remove	= monitor_txpower_remove,
 };
 
 static struct btd_profile pxp_reporter_profile = {
 	.name		= "Proximity Reporter GATT Driver",
-	.remote_uuids	= BTD_UUIDS(GATT_UUID),
+	.remote_uuid	= GATT_UUID,
 	.device_probe	= reporter_device_probe,
 	.device_remove	= reporter_device_remove,
 
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 268bdc8..abbd129 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -287,7 +287,7 @@ static void scan_param_remove(struct btd_profile *p, struct btd_device *device)
 
 static struct btd_profile scan_profile = {
 	.name = "Scan Parameters Client Driver",
-	.remote_uuids = BTD_UUIDS(SCAN_PARAMETERS_UUID),
+	.remote_uuid = SCAN_PARAMETERS_UUID,
 	.device_probe = scan_param_probe,
 	.device_remove = scan_param_remove,
 };
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 1b299e7..8550500 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -1313,7 +1313,7 @@ static void thermometer_adapter_remove(struct btd_profile *p,
 
 static struct btd_profile thermometer_profile = {
 	.name		= "Health Thermometer GATT driver",
-	.remote_uuids	= BTD_UUIDS(HEALTH_THERMOMETER_UUID),
+	.remote_uuid	= HEALTH_THERMOMETER_UUID,
 	.device_probe	= thermometer_device_probe,
 	.device_remove	= thermometer_device_remove,
 	.adapter_probe	= thermometer_adapter_probe,
diff --git a/src/device.c b/src/device.c
index 49f8957..adcad6c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1155,15 +1155,12 @@ static struct btd_profile *find_connectable_profile(struct btd_device *dev,
 
 	for (l = dev->profiles; l != NULL; l = g_slist_next(l)) {
 		struct btd_profile *p = l->data;
-		int i;
 
-		if (!p->connect || !p->remote_uuids)
+		if (!p->connect || !p->remote_uuid)
 			continue;
 
-		for (i = 0; p->remote_uuids[i] != NULL; i++) {
-			if (strcasecmp(uuid, p->remote_uuids[i]) == 0)
-				return p;
-		}
+		if (strcasecmp(uuid, p->remote_uuid) == 0)
+			return p;
 	}
 
 	return NULL;
@@ -2299,27 +2296,18 @@ GSList *device_get_uuids(struct btd_device *device)
 	return device->uuids;
 }
 
-static GSList *device_match_profile(struct btd_device *device,
+static bool device_match_profile(struct btd_device *device,
 					struct btd_profile *profile,
 					GSList *uuids)
 {
-	const char **uuid;
-	GSList *match_uuids = NULL;
-
-	for (uuid = profile->remote_uuids; *uuid; uuid++) {
-		GSList *match;
-
-		/* skip duplicated uuids */
-		if (g_slist_find_custom(match_uuids, *uuid, bt_uuid_strcmp))
-			continue;
+	if (profile->remote_uuid == NULL)
+		return false;
 
-		/* match profile uuid */
-		match = g_slist_find_custom(uuids, *uuid, bt_uuid_strcmp);
-		if (match)
-			match_uuids = g_slist_append(match_uuids, match->data);
-	}
+	if (g_slist_find_custom(uuids, profile->remote_uuid,
+							bt_uuid_strcmp) == NULL)
+		return false;
 
-	return match_uuids;
+	return true;
 }
 
 struct probe_data {
@@ -2337,10 +2325,11 @@ static void dev_probe(struct btd_profile *p, void *user_data)
 	if (p->device_probe == NULL)
 		return;
 
-	probe_uuids = device_match_profile(d->dev, p, d->uuids);
-	if (!probe_uuids)
+	if (!device_match_profile(d->dev, p, d->uuids))
 		return;
 
+	probe_uuids = g_slist_append(NULL, (char *) p->remote_uuid);
+
 	err = p->device_probe(p, d->dev, probe_uuids);
 	if (err < 0) {
 		error("%s profile probe failed for %s", p->name, d->addr);
@@ -2363,10 +2352,11 @@ void device_probe_profile(gpointer a, gpointer b)
 	if (profile->device_probe == NULL)
 		return;
 
-	probe_uuids = device_match_profile(device, profile, device->uuids);
-	if (!probe_uuids)
+	if (!device_match_profile(device, profile, device->uuids))
 		return;
 
+	probe_uuids = g_slist_append(NULL, (char *) profile->remote_uuid);
+
 	ba2str(&device->bdaddr, addr);
 
 	err = profile->device_probe(profile, device, probe_uuids);
@@ -2451,15 +2441,10 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 
 	for (l = device->profiles; l != NULL; l = next) {
 		struct btd_profile *profile = l->data;
-		GSList *probe_uuids;
 
 		next = l->next;
-		probe_uuids = device_match_profile(device, profile,
-								device->uuids);
-		if (probe_uuids != NULL) {
-			g_slist_free(probe_uuids);
+		if (device_match_profile(device, profile, device->uuids))
 			continue;
-		}
 
 		profile->device_remove(profile, device);
 		device->profiles = g_slist_remove(device->profiles, profile);
diff --git a/src/profile.c b/src/profile.c
index 631a03f..b31bcc5 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -519,7 +519,7 @@ struct ext_profile {
 	char *(*get_record)(struct ext_profile *ext, struct ext_io *l2cap,
 							struct ext_io *rfcomm);
 
-	char **remote_uuids;
+	char *remote_uuid;
 
 	guint id;
 
@@ -851,7 +851,7 @@ static bool send_new_connection(struct ext_profile *ext, struct ext_io *conn)
 	DBusMessage *msg;
 	DBusMessageIter iter, dict;
 	struct prop_append_data data = { &dict, conn };
-	const char *remote_uuid = ext->remote_uuids[0];
+	const char *remote_uuid = ext->remote_uuid;
 	const sdp_record_t *rec;
 	const char *path;
 	int fd;
@@ -1540,7 +1540,7 @@ static int resolve_service(struct ext_io *conn, const bdaddr_t *src,
 	uuid_t uuid;
 	int err;
 
-	bt_string2uuid(&uuid, ext->remote_uuids[0]);
+	bt_string2uuid(&uuid, ext->remote_uuid);
 	sdp_uuid128_to_uuid(&uuid);
 
 	err = bt_search_service(src, dst, &uuid, record_cb, conn, NULL);
@@ -1910,8 +1910,7 @@ static void ext_set_defaults(struct ext_profile *ext)
 	ext->authorize = true;
 	ext->enable_client = true;
 	ext->enable_server = true;
-
-	ext->remote_uuids = g_new0(char *, 2);
+	ext->remote_uuid = NULL;
 
 	for (i = 0; i < G_N_ELEMENTS(defaults); i++) {
 		struct default_settings *settings = &defaults[i];
@@ -1925,7 +1924,7 @@ static void ext_set_defaults(struct ext_profile *ext)
 		else
 			remote_uuid = ext->uuid;
 
-		ext->remote_uuids[0] = g_strdup(remote_uuid);
+		ext->remote_uuid = g_strdup(remote_uuid);
 
 		if (settings->channel)
 			ext->local_chan = settings->channel;
@@ -2117,21 +2116,18 @@ static struct ext_profile *create_ext(const char *owner, const char *path,
 	if (!ext->name)
 		ext->name = g_strdup_printf("%s%s/%s", owner, path, uuid);
 
-	if (!ext->remote_uuids[0]) {
+	if (!ext->remote_uuid) {
 		if (ext->service)
-			ext->remote_uuids[0] = g_strdup(ext->service);
+			ext->remote_uuid = g_strdup(ext->service);
 		else
-			ext->remote_uuids[0] = g_strdup(ext->uuid);
+			ext->remote_uuid = g_strdup(ext->uuid);
 	}
 
 	p = &ext->p;
 
 	p->name = ext->name;
 	p->local_uuid = ext->service ? ext->service : ext->uuid;
-
-	/* Typecast can't really be avoided here:
-	 * http://c-faq.com/ansi/constmismatch.html */
-	p->remote_uuids = (const char **) ext->remote_uuids;
+	p->remote_uuid = ext->remote_uuid;
 
 	if (ext->enable_server || ext->record || ext->get_record) {
 		p->adapter_probe = ext_adapter_probe;
@@ -2167,8 +2163,7 @@ static void remove_ext(struct ext_profile *ext)
 	g_slist_free_full(ext->servers, ext_io_destroy);
 	g_slist_free_full(ext->conns, ext_io_destroy);
 
-	g_strfreev(ext->remote_uuids);
-
+	g_free(ext->remote_uuid);
 	g_free(ext->name);
 	g_free(ext->owner);
 	g_free(ext->uuid);
diff --git a/src/profile.h b/src/profile.h
index d858925..5d78b37 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -21,8 +21,6 @@
  *
  */
 
-#define BTD_UUIDS(args...) ((const char *[]) { args, NULL } )
-
 #define BTD_PROFILE_PRIORITY_LOW	0
 #define BTD_PROFILE_PRIORITY_MEDIUM	1
 #define BTD_PROFILE_PRIORITY_HIGH	2
@@ -32,7 +30,7 @@ struct btd_profile {
 	int priority;
 
 	const char *local_uuid;
-	const char **remote_uuids;
+	const char *remote_uuid;
 
 	bool auto_connect;
 
-- 
1.8.1

