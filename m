Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 1/2] android: Add possible to enable BlueZ debug logs
Date: Wed, 5 Mar 2014 13:56:05 +0100
Message-ID: <1394024166-14102-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394024166-14102-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394024166-14102-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch it is possible to enable BlueZ logs which. In order
to enable it is required to set property:
persist.sys.bluetooth.debug to 1 or literaly "true".

More info in README
---
 android/README               | 11 +++++++++++
 android/bluetoothd-wrapper.c | 17 ++++++++++++-----
 android/main.c               |  8 +++++++-
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/android/README b/android/README
index 3095383..b7ecf5f 100644
--- a/android/README
+++ b/android/README
@@ -130,6 +130,17 @@ will break at e.g. g_free() function without prior callers. It's possible to
 have proper library installed automatically by appropriate entry in Android.mk,
 see https://code.google.com/p/aosp-bluez.glib/ for an example.
 
+Enabling BlueZ debugs
+==============================
+
+BlueZ debug logs can be enabled in runtime by setting "persist.sys.bluetooth.debug"
+property to either literal "true" or any numeric value >0. For example:
+adb root
+adb shell setprop persist.sys.bluetooth.debug 1
+
+After changing property value Bluetooth needs to be restarted to apply changes.
+
+Note: Debugs are only available on NON USER build variants
 =============================
 Building and running on Linux
 =============================
diff --git a/android/bluetoothd-wrapper.c b/android/bluetoothd-wrapper.c
index 122e6b0..2c7d087 100644
--- a/android/bluetoothd-wrapper.c
+++ b/android/bluetoothd-wrapper.c
@@ -24,6 +24,8 @@
 
 #define PROPERTY_NAME "persist.sys.bluetooth.valgrind"
 
+#define PROPERTY_DEBUG_NAME "persist.sys.bluetooth.debug"
+
 #define VALGRIND_BIN "/system/bin/valgrind"
 
 #define BLUETOOTHD_BIN "/system/bin/bluetoothd-main"
@@ -45,13 +47,14 @@ static void run_valgrind(void)
 	execve(prg_argv[0], prg_argv, prg_envp);
 }
 
-static void run_bluetoothd(void)
+static void run_bluetoothd(int debug)
 {
-	char *prg_argv[2];
+	char *prg_argv[3];
 	char *prg_envp[1];
 
 	prg_argv[0] = BLUETOOTHD_BIN;
-	prg_argv[1] = NULL;
+	prg_argv[1] = debug ? "-d" : NULL;
+	prg_argv[2] = NULL;
 
 	prg_envp[0] = NULL;
 
@@ -61,16 +64,20 @@ static void run_bluetoothd(void)
 int main(int argc, char *argv[])
 {
 	char value[PROPERTY_VALUE_MAX];
+	int debug = 0;
 
 	if (property_get(PROPERTY_NAME, value, "") > 0 &&
 			(!strcasecmp(value, "true") || atoi(value) > 0))
 		run_valgrind();
 
+	if (property_get(PROPERTY_DEBUG_NAME, value, "") > 0 &&
+			(!strcasecmp(value, "true") || atoi(value) > 0))
+			debug = 1;
+
 	/* In case we failed to execute Valgrind, try to run bluetoothd
 	 * without it
 	 */
-
-	run_bluetoothd();
+	run_bluetoothd(debug);
 
 	return 0;
 }
diff --git a/android/main.c b/android/main.c
index 42bc982..edec7dc 100644
--- a/android/main.c
+++ b/android/main.c
@@ -344,12 +344,15 @@ static guint setup_signalfd(void)
 
 static gboolean option_version = FALSE;
 static gint option_index = -1;
+static gboolean option_dbg = FALSE;
 
 static GOptionEntry options[] = {
 	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
 				"Show version information and exit", NULL },
 	{ "index", 'i', 0, G_OPTION_ARG_INT, &option_index,
 				"Use specified controller", "INDEX"},
+	{ "debug", 'd', 0, G_OPTION_ARG_NONE, &option_dbg,
+				"Enable debug logs", NULL},
 	{ NULL }
 };
 
@@ -473,7 +476,10 @@ int main(int argc, char *argv[])
 	if (!signal)
 		return EXIT_FAILURE;
 
-	__btd_log_init("*", 0);
+	if (option_dbg)
+		__btd_log_init("*", 0);
+	else
+		__btd_log_init(NULL, 0);
 
 	if (!set_capabilities()) {
 		__btd_log_cleanup();
-- 
1.8.4

