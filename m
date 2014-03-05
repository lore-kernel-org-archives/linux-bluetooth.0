Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 2/2] android: Add verbose debugs to BlueZ
Date: Wed, 5 Mar 2014 13:56:06 +0100
Message-ID: <1394024166-14102-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394024166-14102-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394024166-14102-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is usefull in some cases to enable more logs for BlueZ debugging.
This patch introduce possibility to enable verbose debugs.
For now it will enable mgmt interface debug logs

More info in README
---
 android/README               |  5 +++++
 android/bluetooth.c          | 11 ++++++++++-
 android/bluetooth.h          |  2 +-
 android/bluetoothd-wrapper.c | 18 ++++++++++++++----
 android/main.c               |  8 ++++++--
 5 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/android/README b/android/README
index b7ecf5f..cf114a4 100644
--- a/android/README
+++ b/android/README
@@ -140,6 +140,11 @@ adb shell setprop persist.sys.bluetooth.debug 1
 
 After changing property value Bluetooth needs to be restarted to apply changes.
 
+There is also a possibility to enable verbose debug (e.g mgmt interface logs)
+which also enables debugs as above.
+To enable it procced in the same way as described above but use system
+properties called: persist.sys.bluetooth.vdebug
+
 Note: Debugs are only available on NON USER build variants
 =============================
 Building and running on Linux
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 6d94904..cfced4f 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -148,6 +148,12 @@ static GSList *browse_reqs;
 
 static struct ipc *hal_ipc = NULL;
 
+static void mgmt_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+	info("%s%s", prefix, str);
+}
+
 static void store_adapter_config(void)
 {
 	GKeyFile *key_file;
@@ -2154,7 +2160,7 @@ failed:
 	cb(-EIO, NULL);
 }
 
-bool bt_bluetooth_start(int index, bt_bluetooth_ready cb)
+bool bt_bluetooth_start(int index, bool vdebug, bt_bluetooth_ready cb)
 {
 	DBG("index %d", index);
 
@@ -2164,6 +2170,9 @@ bool bt_bluetooth_start(int index, bt_bluetooth_ready cb)
 		return false;
 	}
 
+	if (vdebug)
+		mgmt_set_debug(mgmt_if, mgmt_debug, "mgmt_if: ", NULL);
+
 	if (mgmt_send(mgmt_if, MGMT_OP_READ_VERSION, MGMT_INDEX_NONE, 0, NULL,
 				read_version_complete, cb, NULL) == 0) {
 		error("Error sending READ_VERSION mgmt command");
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 4731e2b..fe3b2b5 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -22,7 +22,7 @@
  */
 
 typedef void (*bt_bluetooth_ready)(int err, const bdaddr_t *addr);
-bool bt_bluetooth_start(int index, bt_bluetooth_ready cb);
+bool bt_bluetooth_start(int index, bool vdebug, bt_bluetooth_ready cb);
 
 typedef void (*bt_bluetooth_stopped)(void);
 bool bt_bluetooth_stop(bt_bluetooth_stopped cb);
diff --git a/android/bluetoothd-wrapper.c b/android/bluetoothd-wrapper.c
index 2c7d087..59a1e91 100644
--- a/android/bluetoothd-wrapper.c
+++ b/android/bluetoothd-wrapper.c
@@ -26,6 +26,8 @@
 
 #define PROPERTY_DEBUG_NAME "persist.sys.bluetooth.debug"
 
+#define PROPERTY_VERBOSE_DEBUG_NAME "persist.sys.bluetooth.vdebug"
+
 #define VALGRIND_BIN "/system/bin/valgrind"
 
 #define BLUETOOTHD_BIN "/system/bin/bluetoothd-main"
@@ -47,14 +49,15 @@ static void run_valgrind(void)
 	execve(prg_argv[0], prg_argv, prg_envp);
 }
 
-static void run_bluetoothd(int debug)
+static void run_bluetoothd(int debug, int vdebug)
 {
-	char *prg_argv[3];
+	char *prg_argv[4];
 	char *prg_envp[1];
 
 	prg_argv[0] = BLUETOOTHD_BIN;
 	prg_argv[1] = debug ? "-d" : NULL;
-	prg_argv[2] = NULL;
+	prg_argv[2] = vdebug ? "-D" : NULL;
+	prg_argv[3] = NULL;
 
 	prg_envp[0] = NULL;
 
@@ -65,6 +68,7 @@ int main(int argc, char *argv[])
 {
 	char value[PROPERTY_VALUE_MAX];
 	int debug = 0;
+	int vdebug = 0;
 
 	if (property_get(PROPERTY_NAME, value, "") > 0 &&
 			(!strcasecmp(value, "true") || atoi(value) > 0))
@@ -74,10 +78,16 @@ int main(int argc, char *argv[])
 			(!strcasecmp(value, "true") || atoi(value) > 0))
 			debug = 1;
 
+	if (property_get(PROPERTY_VERBOSE_DEBUG_NAME, value, "") > 0 &&
+			(!strcasecmp(value, "true") || atoi(value) > 0)) {
+			debug = 1;
+			vdebug = 1;
+	}
+
 	/* In case we failed to execute Valgrind, try to run bluetoothd
 	 * without it
 	 */
-	run_bluetoothd(debug);
+	run_bluetoothd(debug, vdebug);
 
 	return 0;
 }
diff --git a/android/main.c b/android/main.c
index edec7dc..777a1ea 100644
--- a/android/main.c
+++ b/android/main.c
@@ -345,6 +345,7 @@ static guint setup_signalfd(void)
 static gboolean option_version = FALSE;
 static gint option_index = -1;
 static gboolean option_dbg = FALSE;
+static gboolean option_vdbg = FALSE;
 
 static GOptionEntry options[] = {
 	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
@@ -353,6 +354,9 @@ static GOptionEntry options[] = {
 				"Use specified controller", "INDEX"},
 	{ "debug", 'd', 0, G_OPTION_ARG_NONE, &option_dbg,
 				"Enable debug logs", NULL},
+	{ "verbose debug", 'D', 0, G_OPTION_ARG_NONE, &option_vdbg,
+				"Enable verbose debug logs, e.g. mgmt", NULL},
+
 	{ NULL }
 };
 
@@ -476,7 +480,7 @@ int main(int argc, char *argv[])
 	if (!signal)
 		return EXIT_FAILURE;
 
-	if (option_dbg)
+	if (option_dbg || option_vdbg)
 		__btd_log_init("*", 0);
 	else
 		__btd_log_init(NULL, 0);
@@ -496,7 +500,7 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	if (!bt_bluetooth_start(option_index, adapter_ready)) {
+	if (!bt_bluetooth_start(option_index, option_vdbg, adapter_ready)) {
 		__btd_log_cleanup();
 		g_source_remove(bluetooth_start_timeout);
 		g_source_remove(signal);
-- 
1.8.4

