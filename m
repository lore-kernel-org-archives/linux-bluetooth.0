Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 1/6] android/bluetooth: Add flag for kernel connection control
Date: Fri,  1 Aug 2014 15:31:20 +0200
Message-Id: <1406899885-5338-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1406899885-5338-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1406899885-5338-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces main_opts struct which is global.
This is design to keep some generic options which are static and useful
in different part of code. For now we keep there info about kernel
connection control capabilities. Later it can be used also for other
properties.

This patch also set option kernel connection control to TRUE if mgmt interface
is 1.7 or higier. Kernel connect control means that things like
background scan, auto connect or white list are supported by kernel and
can be used by daemon.
---
 android/bluetooth.c | 6 ++++++
 android/bluetooth.h | 6 ++++++
 android/main.c      | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index cd1772a..a71e192 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3268,6 +3268,12 @@ static void read_version_complete(uint8_t status, uint16_t length,
 		goto failed;
 	}
 
+	/* Starting from mgmt 1.7, kernel can handle connection control */
+	if (MGMT_VERSION(mgmt_version, mgmt_revision) >= MGMT_VERSION(1, 7)) {
+		info("Kernel connection control will be used");
+		main_opts.kernel_conn_control = true;
+	}
+
 	mgmt_register(mgmt_if, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
 					mgmt_index_added_event, cb, NULL);
 	mgmt_register(mgmt_if, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
diff --git a/android/bluetooth.h b/android/bluetooth.h
index e00634c..600526d 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -26,6 +26,12 @@ enum bt_csrk_type {
 	REMOTE_CSRK,
 };
 
+struct main_opts {
+	bool kernel_conn_control;
+};
+
+extern struct main_opts main_opts;
+
 typedef void (*bt_bluetooth_ready)(int err, const bdaddr_t *addr);
 bool bt_bluetooth_start(int index, bool mgmt_dbg, bt_bluetooth_ready cb);
 
diff --git a/android/main.c b/android/main.c
index 0a0c150..d991181 100644
--- a/android/main.c
+++ b/android/main.c
@@ -64,6 +64,8 @@
 #define STARTUP_GRACE_SECONDS 5
 #define SHUTDOWN_GRACE_SECONDS 10
 
+struct main_opts main_opts;
+
 static guint bluetooth_start_timeout = 0;
 
 static bdaddr_t adapter_bdaddr;
@@ -477,6 +479,8 @@ int main(int argc, char *argv[])
 	GError *err = NULL;
 	guint signal;
 
+	memset(&main_opts, 0, sizeof(main_opts));
+
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 
-- 
1.8.4

