Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] android: Add possible to enable mgmt debug logs
Date: Mon, 24 Feb 2014 13:39:11 +0100
Message-ID: <1393245551-8145-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1393245551-8145-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1393245551-8145-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch it is possible to enable mgmt inteface logs which might
be useful when debuging. In order to enable it is required to set
property persist.sys.bluetooth.mgmtdbg to 1 or literaly "true".
More info in README
---
 android/README               | 10 ++++++++++
 android/bluetooth.c          | 11 ++++++++++-
 android/bluetooth.h          |  2 +-
 android/bluetoothd-wrapper.c | 19 +++++++++++++++----
 android/main.c               |  6 +++++-
 5 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/android/README b/android/README
index 3095383..11d5ddd 100644
--- a/android/README
+++ b/android/README
@@ -130,6 +130,16 @@ will break at e.g. g_free() function without prior callers. It's possible to
 have proper library installed automatically by appropriate entry in Android.mk,
 see https://code.google.com/p/aosp-bluez.glib/ for an example.
 
+Enabling mgmt interface debugs
+==============================
+
+Mgmt logs can be enabled in runtime by setting "persist.sys.bluetooth.mgmtdbg"
+property to either literal "true" or any numeric value >0. For example:
+adb root
+adb shell setprop persist.sys.bluetooth.mgmtdbg 1
+
+After changing property value Bluetooth need to be restarted to apply changes.
+
 =============================
 Building and running on Linux
 =============================
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 66177e5..2950513 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -145,6 +145,12 @@ static GSList *cached_devices = NULL;
 /* This list contains addresses which are asked for records */
 static GSList *browse_reqs;
 
+static void mgmt_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+	info("%s%s", prefix, str);
+}
+
 static void store_adapter_config(void)
 {
 	GKeyFile *key_file;
@@ -2151,7 +2157,7 @@ failed:
 	cb(-EIO, NULL);
 }
 
-bool bt_bluetooth_start(int index, bt_bluetooth_ready cb)
+bool bt_bluetooth_start(int index, bool mgmt_dbg, bt_bluetooth_ready cb)
 {
 	DBG("index %d", index);
 
@@ -2161,6 +2167,9 @@ bool bt_bluetooth_start(int index, bt_bluetooth_ready cb)
 		return false;
 	}
 
+	if (mgmt_dbg)
+		mgmt_set_debug(mgmt_if, mgmt_debug, "mgmt_if: ", NULL);
+
 	if (mgmt_send(mgmt_if, MGMT_OP_READ_VERSION, MGMT_INDEX_NONE, 0, NULL,
 				read_version_complete, cb, NULL) == 0) {
 		error("Error sending READ_VERSION mgmt command");
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 8ab34f6..1b7f3d4 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -22,7 +22,7 @@
  */
 
 typedef void (*bt_bluetooth_ready)(int err, const bdaddr_t *addr);
-bool bt_bluetooth_start(int index, bt_bluetooth_ready cb);
+bool bt_bluetooth_start(int index, bool mgmt_dbg, bt_bluetooth_ready cb);
 
 typedef void (*bt_bluetooth_stopped)(void);
 bool bt_bluetooth_stop(bt_bluetooth_stopped cb);
diff --git a/android/bluetoothd-wrapper.c b/android/bluetoothd-wrapper.c
index 3a9f32e..c98a3ce 100644
--- a/android/bluetoothd-wrapper.c
+++ b/android/bluetoothd-wrapper.c
@@ -24,10 +24,14 @@
 
 #define PROPERTY_VALGRIND_NAME "persist.sys.bluetooth.valgrind"
 
+#define PROPERTY_MGMT_DEBUG_NAME "persist.sys.bluetooth.mgmtdbg"
+
 #define VALGRIND_BIN "/system/bin/valgrind"
 
 #define BLUETOOTHD_BIN "/system/bin/bluetoothd-main"
 
+#define MGMT_DEBUG_PARAM "-d"
+
 static void run_valgrind(void)
 {
 	char *prg_argv[4];
@@ -45,13 +49,14 @@ static void run_valgrind(void)
 	execve(prg_argv[0], prg_argv, prg_envp);
 }
 
-static void run_bluetoothd(void)
+static void run_bluetoothd(int mgmt_debug)
 {
-	char *prg_argv[2];
+	char *prg_argv[3];
 	char *prg_envp[1];
 
 	prg_argv[0] = BLUETOOTHD_BIN;
-	prg_argv[1] = NULL;
+	prg_argv[1] = mgmt_debug ? MGMT_DEBUG_PARAM : NULL;
+	prg_argv[2] = NULL;
 
 	prg_envp[0] = NULL;
 
@@ -61,16 +66,22 @@ static void run_bluetoothd(void)
 int main(int argc, char *argv[])
 {
 	char value[PROPERTY_VALUE_MAX];
+	int mgmt_dbg = 0;
 
 	if (property_get(PROPERTY_VALGRIND_NAME, value, "") > 0 &&
 			(!strcasecmp(value, "true") || atoi(value) > 0))
 		run_valgrind();
 
+	if (property_get(PROPERTY_MGMT_DEBUG_NAME, value, "") > 0 &&
+			(!strcasecmp(value, "true") || atoi(value) > 0))
+			mgmt_dbg = 1;
+
+
 	/* In case we failed to execute Valgrind, try to run bluetoothd
 	 * without it
 	 */
 
-	run_bluetoothd();
+	run_bluetoothd(mgmt_dbg);
 
 	return 0;
 }
diff --git a/android/main.c b/android/main.c
index bf1dcfd..2c1d8e9 100644
--- a/android/main.c
+++ b/android/main.c
@@ -314,12 +314,15 @@ static guint setup_signalfd(void)
 
 static gboolean option_version = FALSE;
 static gint option_index = -1;
+static gint option_mgmt_dbg = FALSE;
 
 static GOptionEntry options[] = {
 	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
 				"Show version information and exit", NULL },
 	{ "index", 'i', 0, G_OPTION_ARG_INT, &option_index,
 				"Use specified controller", "INDEX"},
+	{ "mgmt_debug", 'd', 0, G_OPTION_ARG_NONE, &option_mgmt_dbg,
+				"Enable mgmt interface debug logs", NULL},
 	{ NULL }
 };
 
@@ -454,7 +457,8 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	if (!bt_bluetooth_start(option_index, adapter_ready)) {
+	if (!bt_bluetooth_start(option_index, option_mgmt_dbg,
+							adapter_ready)) {
 		__btd_log_cleanup();
 		g_source_remove(bluetooth_start_timeout);
 		g_source_remove(signal);
-- 
1.8.4

