Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ v0 1/4] core: Add purge parameter to profile remove
Date: Fri, 28 Sep 2012 17:01:31 -0300
Message-Id: <1348862494-16911-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1348862494-16911-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1348862494-16911-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends the profile device remove callback allowing the
profiles to remove stored data or execute other profile specific
actions before removing completely the device from the system.
---
 audio/manager.c                |  3 ++-
 profiles/deviceinfo/manager.c  |  2 +-
 profiles/gatt/manager.c        |  2 +-
 profiles/health/hdp_manager.c  |  3 ++-
 profiles/heartrate/manager.c   |  2 +-
 profiles/input/hog_manager.c   |  3 ++-
 profiles/input/manager.c       |  3 ++-
 profiles/network/manager.c     |  3 ++-
 profiles/proximity/manager.c   |  2 +-
 profiles/proximity/reporter.c  |  3 ++-
 profiles/proximity/reporter.h  |  3 ++-
 profiles/scanparam/manager.c   |  3 ++-
 profiles/thermometer/manager.c |  2 +-
 src/device.c                   | 26 +++++++++++++++++---------
 src/profile.h                  |  2 +-
 15 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 70be01b..3a89b0f 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -665,7 +665,8 @@ static struct audio_device *get_audio_dev(struct btd_device *device)
 	return manager_get_device(&src, &dst, TRUE);
 }
 
-static void audio_remove(struct btd_profile *p, struct btd_device *device)
+static void audio_remove(struct btd_profile *p, struct btd_device *device,
+								gboolean purge)
 {
 	struct audio_device *dev;
 	const char *path;
diff --git a/profiles/deviceinfo/manager.c b/profiles/deviceinfo/manager.c
index 3217283..f620f2c 100644
--- a/profiles/deviceinfo/manager.c
+++ b/profiles/deviceinfo/manager.c
@@ -62,7 +62,7 @@ static int deviceinfo_driver_probe(struct btd_profile *p,
 }
 
 static void deviceinfo_driver_remove(struct btd_profile *p,
-						struct btd_device *device)
+				struct btd_device *device, gboolean purge)
 {
 	deviceinfo_unregister(device);
 }
diff --git a/profiles/gatt/manager.c b/profiles/gatt/manager.c
index 747760b..94921d2 100644
--- a/profiles/gatt/manager.c
+++ b/profiles/gatt/manager.c
@@ -68,7 +68,7 @@ static int gatt_driver_probe(struct btd_profile *p, struct btd_device *device,
 }
 
 static void gatt_driver_remove(struct btd_profile *p,
-						struct btd_device *device)
+				struct btd_device *device, gboolean purge)
 {
 	gas_unregister(device);
 }
diff --git a/profiles/health/hdp_manager.c b/profiles/health/hdp_manager.c
index 7b799f4..5b98f21 100644
--- a/profiles/health/hdp_manager.c
+++ b/profiles/health/hdp_manager.c
@@ -60,7 +60,8 @@ static int hdp_driver_probe(struct btd_profile *p, struct btd_device *device,
 	return hdp_device_register(device);
 }
 
-static void hdp_driver_remove(struct btd_profile *p, struct btd_device *device)
+static void hdp_driver_remove(struct btd_profile *p, struct btd_device *device,
+								gboolean purge)
 {
 	hdp_device_unregister(device);
 }
diff --git a/profiles/heartrate/manager.c b/profiles/heartrate/manager.c
index 19b18a8..7be9156 100644
--- a/profiles/heartrate/manager.c
+++ b/profiles/heartrate/manager.c
@@ -70,7 +70,7 @@ static int heartrate_device_probe(struct btd_profile *p,
 }
 
 static void heartrate_device_remove(struct btd_profile *p,
-						struct btd_device *device)
+				struct btd_device *device, gboolean purge)
 {
 	heartrate_device_unregister(device);
 }
diff --git a/profiles/input/hog_manager.c b/profiles/input/hog_manager.c
index 362c38a..13cd902 100644
--- a/profiles/input/hog_manager.c
+++ b/profiles/input/hog_manager.c
@@ -107,7 +107,8 @@ static void remove_device(gpointer hogdev, gpointer b)
 	hog_device_unregister(hogdev);
 }
 
-static void hog_device_remove(struct btd_profile *p, struct btd_device *device)
+static void hog_device_remove(struct btd_profile *p, struct btd_device *device,
+								gboolean purge)
 {
 	const gchar *path = device_get_path(device);
 
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 32698aa..4ef2ff2 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -70,7 +70,8 @@ static int hid_device_probe(struct btd_profile *p, struct btd_device *device,
 							idle_timeout * 60);
 }
 
-static void hid_device_remove(struct btd_profile *p, struct btd_device *device)
+static void hid_device_remove(struct btd_profile *p, struct btd_device *device,
+								gboolean purge)
 {
 	input_remove(device, HID_UUID);
 }
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index e1f4164..dc09ced 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -95,7 +95,8 @@ static int network_probe(struct btd_profile *p, struct btd_device *device,
 	return 0;
 }
 
-static void network_remove(struct btd_profile *p, struct btd_device *device)
+static void network_remove(struct btd_profile *p, struct btd_device *device,
+								gboolean purge)
 {
 	const gchar *path = device_get_path(device);
 
diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index 58e5193..93dc33e 100644
--- a/profiles/proximity/manager.c
+++ b/profiles/proximity/manager.c
@@ -78,7 +78,7 @@ static int monitor_device_probe(struct btd_profile *p,
 }
 
 static void monitor_device_remove(struct btd_profile *p,
-						struct btd_device *device)
+				struct btd_device *device, gboolean purge)
 {
 	monitor_unregister(device);
 }
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index 6ec5f73..90f1f77 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -238,7 +238,8 @@ int reporter_device_probe(struct btd_profile *p, struct btd_device *device,
 	return 0;
 }
 
-void reporter_device_remove(struct btd_profile *p, struct btd_device *device)
+void reporter_device_remove(struct btd_profile *p, struct btd_device *device,
+								gboolean purge)
 {
 	struct reporter_adapter *radapter;
 	struct btd_adapter *adapter = device_get_adapter(device);
diff --git a/profiles/proximity/reporter.h b/profiles/proximity/reporter.h
index 480c668..bd64a92 100644
--- a/profiles/proximity/reporter.h
+++ b/profiles/proximity/reporter.h
@@ -36,7 +36,8 @@ enum {
 	HIGH_ALERT = 0x02,
 };
 
-void reporter_device_remove(struct btd_profile *p, struct btd_device *device);
+void reporter_device_remove(struct btd_profile *p, struct btd_device *device,
+							gboolean purge);
 int reporter_device_probe(struct btd_profile *p, struct btd_device *device,
 								GSList *uuids);
 
diff --git a/profiles/scanparam/manager.c b/profiles/scanparam/manager.c
index 24d1e78..0ce0583 100644
--- a/profiles/scanparam/manager.c
+++ b/profiles/scanparam/manager.c
@@ -68,7 +68,8 @@ static int scan_param_probe(struct btd_profile *p, struct btd_device *device,
 	return scan_register(device, l->data);
 }
 
-static void scan_param_remove(struct btd_profile *p, struct btd_device *device)
+static void scan_param_remove(struct btd_profile *p, struct btd_device *device,
+								gboolean purge)
 {
 	scan_unregister(device);
 }
diff --git a/profiles/thermometer/manager.c b/profiles/thermometer/manager.c
index d965976..81eb8be 100644
--- a/profiles/thermometer/manager.c
+++ b/profiles/thermometer/manager.c
@@ -61,7 +61,7 @@ static int thermometer_driver_probe(struct btd_profile *p,
 }
 
 static void thermometer_driver_remove(struct btd_profile *p,
-						struct btd_device *device)
+				struct btd_device *device, gboolean purge)
 {
 	thermometer_unregister(device);
 }
diff --git a/src/device.c b/src/device.c
index efa3dbe..8f34f01 100644
--- a/src/device.c
+++ b/src/device.c
@@ -497,7 +497,15 @@ static DBusMessage *set_trust(DBusMessage *msg, gboolean value, void *data)
 static void profile_remove(struct btd_profile *profile,
 						struct btd_device *device)
 {
-	profile->device_remove(profile, device);
+	profile->device_remove(profile, device, FALSE);
+
+	device->profiles = g_slist_remove(device->profiles, profile);
+}
+
+static void profile_purge(struct btd_profile *profile,
+						struct btd_device *device)
+{
+	profile->device_remove(profile, device, TRUE);
 
 	device->profiles = g_slist_remove(device->profiles, profile);
 }
@@ -1270,10 +1278,13 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	if (device->connected)
 		do_disconnect(device);
 
-	if (remove_stored)
+	if (remove_stored) {
 		device_remove_stored(device);
-
-	g_slist_foreach(device->profiles, (GFunc) profile_remove, device);
+		g_slist_foreach(device->profiles, (GFunc) profile_purge,
+								device);
+	} else
+		g_slist_foreach(device->profiles, (GFunc) profile_remove,
+								device);
 	g_slist_free(device->profiles);
 	device->profiles = NULL;
 
@@ -1406,9 +1417,7 @@ void device_remove_profile(gpointer a, gpointer b)
 	if (!g_slist_find(device->profiles, profile))
 		return;
 
-	device->profiles = g_slist_remove(device->profiles, profile);
-
-	profile->device_remove(profile, device);
+	profile_remove(profile, device);
 }
 
 void device_probe_profiles(struct btd_device *device, GSList *uuids)
@@ -1486,8 +1495,7 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 			continue;
 		}
 
-		profile->device_remove(profile, device);
-		device->profiles = g_slist_remove(device->profiles, profile);
+		profile_remove(profile, device);
 	}
 }
 
diff --git a/src/profile.h b/src/profile.h
index 1702901..25da63c 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -39,7 +39,7 @@ struct btd_profile {
 	int (*device_probe) (struct btd_profile *p, struct btd_device *device,
 								GSList *uuids);
 	void (*device_remove) (struct btd_profile *p,
-						struct btd_device *device);
+					struct btd_device *device, gboolean purge);
 
 	int (*connect) (struct btd_device *device, struct btd_profile *profile,
 							btd_profile_cb cb);
-- 
1.7.12

