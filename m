Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 2/9] android/A2DP: Add initial code to handle audio IPC commands
Date: Mon, 30 Dec 2013 14:34:08 +0200
Message-Id: <1388406855-8809-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1388406855-8809-1-git-send-email-luiz.dentz@gmail.com>
References: <1388406855-8809-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds initial code to handle audio IPC commands and defines a new
service id (10).
---
 android/a2dp.c    | 13 ++++++++++++-
 android/hal-msg.h |  3 ++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 581d094..63f1f58 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -352,6 +352,9 @@ static sdp_record_t *a2dp_record(void)
 	return record;
 }
 
+static const struct ipc_handler audio_handlers[] = {
+};
+
 bool bt_a2dp_register(const bdaddr_t *addr)
 {
 	GError *err = NULL;
@@ -359,6 +362,8 @@ bool bt_a2dp_register(const bdaddr_t *addr)
 
 	DBG("");
 
+	audio_ipc_init();
+
 	bacpy(&adapter_addr, addr);
 
 	server = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
@@ -388,6 +393,9 @@ bool bt_a2dp_register(const bdaddr_t *addr)
 	ipc_register(HAL_SERVICE_ID_A2DP, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
+	ipc_register(HAL_SERVICE_ID_AUDIO, audio_handlers,
+						G_N_ELEMENTS(audio_handlers));
+
 	return true;
 
 fail:
@@ -411,8 +419,9 @@ void bt_a2dp_unregister(void)
 	g_slist_foreach(devices, a2dp_device_disconnected, NULL);
 	devices = NULL;
 
-
 	ipc_unregister(HAL_SERVICE_ID_A2DP);
+	ipc_unregister(HAL_SERVICE_ID_AUDIO);
+
 	bt_adapter_remove_record(record_id);
 	record_id = 0;
 
@@ -421,4 +430,6 @@ void bt_a2dp_unregister(void)
 		g_io_channel_unref(server);
 		server = NULL;
 	}
+
+	audio_ipc_cleanup();
 }
diff --git a/android/hal-msg.h b/android/hal-msg.h
index b14eced..1afb1bc 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -45,8 +45,9 @@ struct hal_hdr {
 #define HAL_SERVICE_ID_HEALTH		7
 #define HAL_SERVICE_ID_AVRCP		8
 #define HAL_SERVICE_ID_GATT		9
+#define HAL_SERVICE_ID_AUDIO		10
 
-#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_GATT
+#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_AUDIO
 
 /* Core Service */
 
-- 
1.8.4.2

