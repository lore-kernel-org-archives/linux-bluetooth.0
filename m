Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/3] android: Enable mgmt debug logs
Date: Thu, 6 Mar 2014 10:38:01 +0100
Message-ID: <1394098681-18983-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394098681-18983-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394098681-18983-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduce possibility to enable mgmt interface logs.
In order to enable it is required to set property:
persist.sys.bluetooth.mgmtdbg to 1 or literaly "true".
More info in README
---
 android/README               |  4 ++++
 android/bluetooth.c          | 11 ++++++++++-
 android/bluetooth.h          |  2 +-
 android/bluetoothd-wrapper.c | 18 ++++++++++++++----
 android/main.c               |  8 ++++++--
 5 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/android/README b/android/README
index b7ecf5f..6ee0c69 100644
--- a/android/README
+++ b/android/README
@@ -140,6 +140,10 @@ adb shell setprop persist.sys.bluetooth.debug 1
 
 After changing property value Bluetooth needs to be restarted to apply changes.
 
+There is also a possibility to enable mgmt debug logs which also enables debugs
+as above. To enable it procced in the same way as described above but use
+system properties called: persist.sys.bluetooth.mgmtdbg
+
 Note: Debugs are only available on NON USER build variants
 =============================
 Building and running on Linux
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 6d94904..7736693 100644
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
+bool bt_bluetooth_start(int index, bool mgmt_dbg, bt_bluetooth_ready cb)
 {
 	DBG("index %d", index);
 
@@ -2164,6 +2170,9 @@ bool bt_bluetooth_start(int index, bt_bluetooth_ready cb)
 		return false;
 	}
 
+	if (mgmt_dbg)
+		mgmt_set_debug(mgmt_if, mgmt_debug, "mgmt_if: ", NULL);
+
 	if (mgmt_send(mgmt_if, MGMT_OP_READ_VERSION, MGMT_INDEX_NONE, 0, NULL,
 				read_version_complete, cb, NULL) == 0) {
 		error("Error sending READ_VERSION mgmt command");
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 4731e2b..f436178 100644
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
index 56b8a78..80c59c9 100644
--- a/android/bluetoothd-wrapper.c
+++ b/android/bluetoothd-wrapper.c
@@ -26,6 +26,8 @@
 
 #define PROPERTY_DEBUG_NAME "persist.sys.bluetooth.debug"
 
+#define PROPERTY_MGMT_DEBUG_NAME "persist.sys.bluetooth.mgmtdbg"
+
 #define VALGRIND_BIN "/system/bin/valgrind"
 
 #define BLUETOOTHD_BIN "/system/bin/bluetoothd-main"
@@ -47,14 +49,15 @@ static void run_valgrind(void)
 	execve(prg_argv[0], prg_argv, prg_envp);
 }
 
-static void run_bluetoothd(int debug)
+static void run_bluetoothd(int debug, int mgmt_dbg)
 {
-	char *prg_argv[3];
+	char *prg_argv[4];
 	char *prg_envp[1];
 
 	prg_argv[0] = BLUETOOTHD_BIN;
 	prg_argv[1] = debug ? "-d" : NULL;
-	prg_argv[2] = NULL;
+	prg_argv[2] = mgmt_dbg ? "--mgmt-debug" : NULL;
+	prg_argv[3] = NULL;
 
 	prg_envp[0] = NULL;
 
@@ -65,6 +68,7 @@ int main(int argc, char *argv[])
 {
 	char value[PROPERTY_VALUE_MAX];
 	int debug = 0;
+	int mgmt_dbg = 0;
 
 	if (property_get(PROPERTY_VALGRIND_NAME, value, "") > 0 &&
 			(!strcasecmp(value, "true") || atoi(value) > 0))
@@ -74,10 +78,16 @@ int main(int argc, char *argv[])
 			(!strcasecmp(value, "true") || atoi(value) > 0))
 			debug = 1;
 
+	if (property_get(PROPERTY_MGMT_DEBUG_NAME, value, "") > 0 &&
+			(!strcasecmp(value, "true") || atoi(value) > 0)) {
+			debug = 1;
+			mgmt_dbg = 1;
+	}
+
 	/* In case we failed to execute Valgrind, try to run bluetoothd
 	 * without it
 	 */
-	run_bluetoothd(debug);
+	run_bluetoothd(debug, mgmt_dbg);
 
 	return 0;
 }
diff --git a/android/main.c b/android/main.c
index edec7dc..a34f885 100644
--- a/android/main.c
+++ b/android/main.c
@@ -345,6 +345,7 @@ static guint setup_signalfd(void)
 static gboolean option_version = FALSE;
 static gint option_index = -1;
 static gboolean option_dbg = FALSE;
+static gboolean option_mgmt_dbg = FALSE;
 
 static GOptionEntry options[] = {
 	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
@@ -353,6 +354,9 @@ static GOptionEntry options[] = {
 				"Use specified controller", "INDEX"},
 	{ "debug", 'd', 0, G_OPTION_ARG_NONE, &option_dbg,
 				"Enable debug logs", NULL},
+	{ "mgmt-debug", 0, 0, G_OPTION_ARG_NONE, &option_mgmt_dbg,
+				"Enable mgmt debug logs", NULL},
+
 	{ NULL }
 };
 
@@ -476,7 +480,7 @@ int main(int argc, char *argv[])
 	if (!signal)
 		return EXIT_FAILURE;
 
-	if (option_dbg)
+	if (option_dbg || option_mgmt_dbg)
 		__btd_log_init("*", 0);
 	else
 		__btd_log_init(NULL, 0);
@@ -496,7 +500,7 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	if (!bt_bluetooth_start(option_index, adapter_ready)) {
+	if (!bt_bluetooth_start(option_index, option_mgmt_dbg, adapter_ready)) {
 		__btd_log_cleanup();
 		g_source_remove(bluetooth_start_timeout);
 		g_source_remove(signal);
-- 
1.8.4

