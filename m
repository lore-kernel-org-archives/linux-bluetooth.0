Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android: Add mode for SCO over HCI
Date: Thu, 15 May 2014 15:29:31 +0300
Message-Id: <1400156971-23998-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the option --sco-over-hci that can be used to enable SCO over
HCI routing, by default it is disabled.
---
 android/bluetoothd-wrapper.c | 16 ++++++++++++----
 android/handsfree.c          |  9 +++------
 android/handsfree.h          |  3 +++
 android/main.c               | 10 +++++++++-
 android/system-emulator.c    |  5 +++--
 5 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/android/bluetoothd-wrapper.c b/android/bluetoothd-wrapper.c
index 90ed292..4402024 100644
--- a/android/bluetoothd-wrapper.c
+++ b/android/bluetoothd-wrapper.c
@@ -28,6 +28,8 @@
 
 #define PROPERTY_MGMT_DEBUG_NAME "persist.sys.bluetooth.mgmtdbg"
 
+#define PROPERTY_SCO_NAME "persist.sys.bluetooth.sco"
+
 #define VALGRIND_BIN "/system/bin/valgrind"
 
 #define BLUETOOTHD_BIN "/system/bin/bluetoothd-main"
@@ -52,15 +54,16 @@ static void run_valgrind(int debug, int mgmt_dbg)
 	execve(prg_argv[0], prg_argv, prg_envp);
 }
 
-static void run_bluetoothd(int debug, int mgmt_dbg)
+static void run_bluetoothd(int debug, int mgmt_dbg, int sco_hci)
 {
-	char *prg_argv[4];
+	char *prg_argv[5];
 	char *prg_envp[1];
 
 	prg_argv[0] = BLUETOOTHD_BIN;
 	prg_argv[1] = debug ? "-d" : NULL;
 	prg_argv[2] = mgmt_dbg ? "--mgmt-debug" : NULL;
-	prg_argv[3] = NULL;
+	prg_argv[3] = sco_hci ? "--sco-over-hci" : NULL;
+	prg_argv[4] = NULL;
 
 	prg_envp[0] = NULL;
 
@@ -72,6 +75,7 @@ int main(int argc, char *argv[])
 	char value[PROPERTY_VALUE_MAX];
 	int debug = 0;
 	int mgmt_dbg = 0;
+	int sco_hci = 0;
 
 	if (property_get(PROPERTY_DEBUG_NAME, value, "") > 0 &&
 			(!strcasecmp(value, "true") || atoi(value) > 0))
@@ -83,6 +87,10 @@ int main(int argc, char *argv[])
 			mgmt_dbg = 1;
 	}
 
+	if (property_get(PROPERTY_SCO_NAME, value, "") > 0 &&
+			(!strcasecmp(value, "true") || atoi(value) > 0))
+			sco_hci = 1;
+
 	if (property_get(PROPERTY_VALGRIND_NAME, value, "") > 0 &&
 			(!strcasecmp(value, "true") || atoi(value) > 0))
 		run_valgrind(debug, mgmt_dbg);
@@ -91,7 +99,7 @@ int main(int argc, char *argv[])
 	 * In case we failed to execute Valgrind, try to run bluetoothd
 	 * without it
 	 */
-	run_bluetoothd(debug, mgmt_dbg);
+	run_bluetoothd(debug, mgmt_dbg, sco_hci);
 
 	return 0;
 }
diff --git a/android/handsfree.c b/android/handsfree.c
index 7ca0ba8..b625501 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2602,7 +2602,7 @@ static const struct ipc_handler sco_handlers[] = {
 	{ bt_sco_connect, false, 0 }
 };
 
-static void bt_sco_unregister(void)
+void bt_sco_unregister(void)
 {
 	DBG("");
 
@@ -2610,12 +2610,12 @@ static void bt_sco_unregister(void)
 	sco_ipc = NULL;
 }
 
-static bool bt_sco_register(ipc_disconnect_cb disconnect)
+bool bt_sco_register(void)
 {
 	DBG("");
 
 	sco_ipc = ipc_init(BLUEZ_SCO_SK_PATH, sizeof(BLUEZ_SCO_SK_PATH),
-				SCO_SERVICE_ID, false, disconnect, NULL);
+					SCO_SERVICE_ID, false, NULL, NULL);
 	if (!sco_ipc)
 		return false;
 
@@ -2660,8 +2660,6 @@ done:
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
-	bt_sco_register(NULL);
-
 	return true;
 }
 
@@ -2669,7 +2667,6 @@ void bt_handsfree_unregister(void)
 {
 	DBG("");
 
-	bt_sco_unregister();
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HANDSFREE);
 	hal_ipc = NULL;
 
diff --git a/android/handsfree.h b/android/handsfree.h
index e5eff47..fb65e47 100644
--- a/android/handsfree.h
+++ b/android/handsfree.h
@@ -23,3 +23,6 @@
 
 bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
 void bt_handsfree_unregister(void);
+
+bool bt_sco_register(void);
+void bt_sco_unregister(void);
diff --git a/android/main.c b/android/main.c
index 0a0c150..9d84ac7 100644
--- a/android/main.c
+++ b/android/main.c
@@ -362,6 +362,7 @@ static gboolean option_version = FALSE;
 static gint option_index = -1;
 static gboolean option_dbg = FALSE;
 static gboolean option_mgmt_dbg = FALSE;
+static gboolean option_sco_hci = FALSE;
 
 static GOptionEntry options[] = {
 	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
@@ -372,7 +373,8 @@ static GOptionEntry options[] = {
 				"Enable debug logs", NULL},
 	{ "mgmt-debug", 0, 0, G_OPTION_ARG_NONE, &option_mgmt_dbg,
 				"Enable mgmt debug logs", NULL},
-
+	{ "sco-over-hci", 0, 0, G_OPTION_ARG_NONE, &option_sco_hci,
+				"Enable SCO over HCI", NULL},
 	{ NULL }
 };
 
@@ -528,6 +530,9 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
+	if (option_sco_hci)
+		bt_sco_register();
+
 	/* Use params: mtu = 0, flags = 0 */
 	start_sdp_server(0, 0);
 
@@ -544,6 +549,9 @@ int main(int argc, char *argv[])
 
 	cleanup_services();
 
+	if (option_sco_hci)
+		bt_sco_unregister();
+
 	stop_sdp_server();
 	bt_bluetooth_cleanup();
 	g_main_loop_unref(event_loop);
diff --git a/android/system-emulator.c b/android/system-emulator.c
index c1b1b25..b677248 100644
--- a/android/system-emulator.c
+++ b/android/system-emulator.c
@@ -50,7 +50,7 @@ static pid_t snoop_pid = -1;
 static void ctl_start(void)
 {
 	char prg_name[PATH_MAX + 1];
-	char *prg_argv[6];
+	char *prg_argv[7];
 	char *prg_envp[3];
 	pid_t pid;
 
@@ -61,7 +61,8 @@ static void ctl_start(void)
 	prg_argv[2] = "--track-origins=yes";
 	prg_argv[3] = prg_name;
 	prg_argv[4] = "-d";
-	prg_argv[5] = NULL;
+	prg_argv[5] = "--sco-over-hci";
+	prg_argv[6] = NULL;
 
 	prg_envp[0] = "G_SLICE=always-malloc";
 	prg_envp[1] = "G_DEBUG=gc-friendly";
-- 
1.9.0

