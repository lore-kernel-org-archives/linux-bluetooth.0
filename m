Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/8] android/haltest: Add init and cleanup calls to rc methods
Date: Fri, 24 Jan 2014 15:24:32 +0200
Message-Id: <1390569875-29436-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390569875-29436-1-git-send-email-luiz.dentz@gmail.com>
References: <1390569875-29436-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/Android.mk                     |  1 +
 android/Makefile.am                    |  1 +
 android/client/haltest.c               |  2 ++
 android/client/if-bt.c                 |  2 +-
 android/client/if-main.h               |  2 ++
 android/client/{if-audio.c => if-rc.c} | 44 +++++++++++++---------------------
 6 files changed, 23 insertions(+), 29 deletions(-)
 copy android/client/{if-audio.c => if-rc.c} (57%)

diff --git a/android/Android.mk b/android/Android.mk
index 160a1d4..b83d1fe 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -131,6 +131,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/client/tabcompletion.c \
 	bluez/android/client/if-audio.c \
 	bluez/android/client/if-av.c \
+	bluez/android/client/if-rc.c \
 	bluez/android/client/if-bt.c \
 	bluez/android/client/if-hf.c \
 	bluez/android/client/if-hh.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 664524f..e065c0c 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -85,6 +85,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/tabcompletion.c \
 				android/client/if-main.h \
 				android/client/if-av.c \
+				android/client/if-rc.c \
 				android/client/if-bt.c \
 				android/client/if-gatt.c \
 				android/client/if-hf.c \
diff --git a/android/client/haltest.c b/android/client/haltest.c
index f4d1ade..114fe31 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -34,6 +34,7 @@ const struct interface *interfaces[] = {
 	&audio_if,
 	&bluetooth_if,
 	&av_if,
+	&rc_if,
 	&gatt_if,
 	&gatt_client_if,
 	&gatt_server_if,
@@ -382,6 +383,7 @@ static void init(void)
 	static const char * const inames[] = {
 		BT_PROFILE_HANDSFREE_ID,
 		BT_PROFILE_ADVANCED_AUDIO_ID,
+		BT_PROFILE_AV_RC_ID,
 		BT_PROFILE_HEALTH_ID,
 		BT_PROFILE_HIDHOST_ID,
 		BT_PROFILE_PAN_ID,
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 6bfb439..8dcffea 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -760,7 +760,7 @@ static void get_profile_interface_p(int argc, const char **argv)
 	else if (strcmp(BT_PROFILE_PAN_ID, id) == 0)
 		pif = (const void **) &if_pan;
 	else if (strcmp(BT_PROFILE_AV_RC_ID, id) == 0)
-		pif = &dummy; /* TODO: change when if_rc is there */
+		pif = (const void **) &if_rc;
 	else if (strcmp(BT_PROFILE_GATT_ID, id) == 0)
 		pif = (const void **) &if_gatt;
 	else
diff --git a/android/client/if-main.h b/android/client/if-main.h
index 2b22fc4..d82358e 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -48,6 +48,7 @@ extern audio_hw_device_t *if_audio;
 /* Interfaces from hal that can be populated during application lifetime */
 extern const bt_interface_t *if_bluetooth;
 extern const btav_interface_t *if_av;
+extern const btrc_interface_t *if_rc;
 extern const bthf_interface_t *if_hf;
 extern const bthh_interface_t *if_hh;
 extern const btpan_interface_t *if_pan;
@@ -68,6 +69,7 @@ struct interface {
 extern const struct interface audio_if;
 extern const struct interface bluetooth_if;
 extern const struct interface av_if;
+extern const struct interface rc_if;
 extern const struct interface gatt_if;
 extern const struct interface gatt_client_if;
 extern const struct interface gatt_server_if;
diff --git a/android/client/if-audio.c b/android/client/if-rc.c
similarity index 57%
copy from android/client/if-audio.c
copy to android/client/if-rc.c
index 203e088..58fb892 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-rc.c
@@ -18,41 +18,29 @@
 #include "if-main.h"
 #include "../hal-utils.h"
 
-audio_hw_device_t *if_audio = NULL;
+const btrc_interface_t *if_rc = NULL;
 
-static void init_p(int argc, const char **argv)
-{
-	int err;
-	const hw_module_t *module;
-	audio_hw_device_t *device;
+static btrc_callbacks_t rc_cbacks = {
+	.size = sizeof(rc_cbacks),
+};
 
-	err = hw_get_module_by_class(AUDIO_HARDWARE_MODULE_ID,
-					AUDIO_HARDWARE_MODULE_ID_A2DP, &module);
-	if (err) {
-		haltest_error("hw_get_module_by_class returned %d\n", err);
-		return;
-	}
+/* init */
 
-	err = audio_hw_device_open(module, &device);
-	if (err)
-		haltest_error("audio_hw_device_open returned %d\n", err);
+static void init_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_rc);
 
-	if_audio = device;
+	EXEC(if_rc->init, &rc_cbacks);
 }
 
+/* cleanup */
+
 static void cleanup_p(int argc, const char **argv)
 {
-	int err;
-
-	RETURN_IF_NULL(if_audio);
-
-	err = audio_hw_device_close(if_audio);
-	if (err < 0) {
-		haltest_error("audio_hw_device_close returned %d\n", err);
-		return;
-	}
+	RETURN_IF_NULL(if_rc);
 
-	if_audio = NULL;
+	EXECV(if_rc->cleanup);
+	if_rc = NULL;
 }
 
 static struct method methods[] = {
@@ -61,7 +49,7 @@ static struct method methods[] = {
 	END_METHOD
 };
 
-const struct interface audio_if = {
-	.name = "audio",
+const struct interface rc_if = {
+	.name = "rc",
 	.methods = methods
 };
-- 
1.8.4.2

