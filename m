Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/4] android/bluetooth: Add initial support for permanent storage
Date: Wed, 18 Dec 2013 15:05:55 +0100
Message-Id: <1387375558-17976-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1387375558-17976-1-git-send-email-szymon.janc@tieto.com>
References: <1387375558-17976-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds initial support for storing adapter configuration.
Currently stored data is address, name and discoverable timeout.

Since Android daemon storage format is to be simpler than Linux check
if correct adapter is used before going operational. This is
a precaution to avoid e.g. using linkkeys generated for different
controller.
---
 android/Android.mk  |  3 +-
 android/bluetooth.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 configure.ac        |  3 ++
 3 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index ebc3219..2953a6e 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -8,7 +8,8 @@ pathmap_INCL += glib:external/bluetooth/glib
 
 # Specify common compiler flags
 BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\" \
-	-DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION)
+	-DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION) \
+	-DANDROID_STORAGEDIR=\"/data/misc/bluetooth\" \
 
 # Disable warnings enabled by Android but not enabled in autotools build
 BLUEZ_COMMON_CFLAGS += -Wno-pointer-arith -Wno-missing-field-initializers
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 97d4aae..114a466 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -27,6 +27,10 @@
 
 #include <errno.h>
 #include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 #include <glib.h>
 
@@ -123,6 +127,75 @@ static GSList *devices = NULL;
 /* This list contains addresses which are asked for records */
 static GSList *browse_reqs;
 
+static void store_adapter_config(void)
+{
+	GKeyFile *key_file;
+	gsize length = 0;
+	char addr[18];
+	char *data;
+
+	key_file = g_key_file_new();
+
+	if (!g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/settings",
+								0, NULL)) {
+		int fd = open(ANDROID_STORAGEDIR"/settings", O_CREAT, 0600);
+		if (fd < 0) {
+			error("Failed to create adapter config file: %d (%s)",
+							errno, strerror(errno));
+			return;
+		}
+
+		close(fd);
+	}
+
+	ba2str(&adapter.bdaddr, addr);
+
+	g_key_file_set_string(key_file, "General", "Address", addr);
+	g_key_file_set_string(key_file, "General", "Name", adapter.name);
+	g_key_file_set_integer(key_file, "General", "DiscoverableTimeout",
+						adapter.discoverable_timeout);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+
+	g_file_set_contents(ANDROID_STORAGEDIR"/settings", data, length, NULL);
+
+	g_free(data);
+	g_key_file_free(key_file);
+}
+
+static void load_adapter_config(void)
+{
+	GError *gerr = NULL;
+	GKeyFile *key_file;
+	char *str;
+
+	key_file = g_key_file_new();
+
+	g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/settings", 0,
+									NULL);
+
+	str = g_key_file_get_string(key_file, "General", "Address", NULL);
+	if (!str) {
+		g_key_file_free(key_file);
+		return;
+	}
+
+	str2ba(str, &adapter.bdaddr);
+	g_free(str);
+
+	adapter.name = g_key_file_get_string(key_file, "General", "Name", NULL);
+
+	adapter.discoverable_timeout = g_key_file_get_integer(key_file,
+				"General", "DiscoverableTimeout", &gerr);
+	if (gerr) {
+		adapter.discoverable_timeout = DEFAULT_DISCOVERABLE_TIMEOUT;
+		g_error_free(gerr);
+		gerr = NULL;
+	}
+
+	g_key_file_free(key_file);
+}
+
 static int bdaddr_cmp(gconstpointer a, gconstpointer b)
 {
 	const bdaddr_t *bda = a;
@@ -215,6 +288,8 @@ static void adapter_set_name(const uint8_t *name)
 	g_free(adapter.name);
 	adapter.name = g_strdup((const char *) name);
 
+	store_adapter_config();
+
 	adapter_name_changed(name);
 }
 
@@ -1385,9 +1460,10 @@ static uint8_t set_adapter_discoverable_timeout(const void *buf, uint16_t len)
 	 * There is no need to use kernel feature for that.
 	 * Just need to store this value here */
 
-	/* TODO: This should be in some storage */
 	memcpy(&adapter.discoverable_timeout, timeout, sizeof(uint32_t));
 
+	store_adapter_config();
+
 	send_adapter_property(HAL_PROP_ADAPTER_DISC_TIMEOUT,
 					sizeof(adapter.discoverable_timeout),
 					&adapter.discoverable_timeout);
@@ -1434,17 +1510,26 @@ static void read_info_complete(uint8_t status, uint16_t length,
 		goto failed;
 	}
 
+	load_adapter_config();
+
+	if (!bacmp(&adapter.bdaddr, BDADDR_ANY)) {
+		bacpy(&adapter.bdaddr, &rp->bdaddr);
+		adapter.name = g_strdup((const char *) rp->name);
+		store_adapter_config();
+		set_adapter_name(rp->name, strlen((char *)rp->name));
+	} else if (bacmp(&adapter.bdaddr, &rp->bdaddr)) {
+		error("Bluetooth address mismatch");
+		err = -ENODEV;
+		goto failed;
+	}
+
 	/* Store adapter information */
-	bacpy(&adapter.bdaddr, &rp->bdaddr);
 	adapter.dev_class = rp->dev_class[0] | (rp->dev_class[1] << 8) |
 						(rp->dev_class[2] << 16);
-	adapter.name = g_strdup((const char *) rp->name);
 
 	supported_settings = btohs(rp->supported_settings);
 	adapter.current_settings = btohs(rp->current_settings);
 
-	/* TODO: Read discoverable timeout from storage here */
-
 	/* TODO: Register all event notification handlers */
 	register_mgmt_handlers();
 
diff --git a/configure.ac b/configure.ac
index 18d0b55..5171c38 100644
--- a/configure.ac
+++ b/configure.ac
@@ -252,4 +252,7 @@ AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
 					[enable_android=${enableval}])
 AM_CONDITIONAL(ANDROID, test "${enable_android}" = "yes")
 
+AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
+			[Directory for the Android daemon storage files])
+
 AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
-- 
1.8.3.2

