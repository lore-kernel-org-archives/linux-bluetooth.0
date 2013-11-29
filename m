Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/main: Call unregister for all registered services on exit
Date: Fri, 29 Nov 2013 10:08:49 +0200
Message-Id: <1385712529-24757-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/main.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/android/main.c b/android/main.c
index 2879bbf..2a9348b 100644
--- a/android/main.c
+++ b/android/main.c
@@ -493,6 +493,38 @@ static void cleanup_hal_connection(void)
 	ipc_cleanup();
 }
 
+static void cleanup_services(void)
+{
+	int i;
+
+	DBG("");
+
+	for (i=HAL_SERVICE_ID_BLUETOOTH; i < HAL_SERVICE_ID_MAX; i++) {
+		if (!services[i])
+			continue;
+
+		switch (i) {
+		case HAL_SERVICE_ID_BLUETOOTH:
+			bt_bluetooth_unregister();
+			break;
+		case HAL_SERVICE_ID_SOCK:
+			bt_socket_unregister();
+			break;
+		case HAL_SERVICE_ID_HIDHOST:
+			bt_hid_unregister();
+			break;
+		case HAL_SERVICE_ID_A2DP:
+			bt_a2dp_unregister();
+			break;
+		case HAL_SERVICE_ID_PAN:
+			bt_pan_unregister();
+			break;
+		}
+
+		services[i] = false;
+	}
+}
+
 static bool set_capabilities(void)
 {
 #if defined(ANDROID)
@@ -598,6 +630,8 @@ int main(int argc, char *argv[])
 	if (bluetooth_start_timeout > 0)
 		g_source_remove(bluetooth_start_timeout);
 
+	cleanup_services();
+
 	cleanup_hal_connection();
 	stop_sdp_server();
 	bt_bluetooth_cleanup();
-- 
1.8.3.2

