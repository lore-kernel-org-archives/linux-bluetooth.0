Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 04/10] android/A2DP: Add initial code to handle audio IPC commands
Date: Tue,  7 Jan 2014 13:53:17 +0200
Message-Id: <1389095603-30504-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389095603-30504-1-git-send-email-luiz.dentz@gmail.com>
References: <1389095603-30504-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds initial code to handle audio IPC commands.
---
 android/a2dp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 581d094..c12d8f1 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -44,6 +44,8 @@
 #include "utils.h"
 #include "bluetooth.h"
 #include "avdtp.h"
+#include "audio-msg.h"
+#include "audio-ipc.h"
 
 #define L2CAP_PSM_AVDTP 0x19
 #define SVC_HINT_CAPTURING 0x08
@@ -352,6 +354,9 @@ static sdp_record_t *a2dp_record(void)
 	return record;
 }
 
+static const struct ipc_handler audio_handlers[] = {
+};
+
 bool bt_a2dp_register(const bdaddr_t *addr)
 {
 	GError *err = NULL;
@@ -359,6 +364,8 @@ bool bt_a2dp_register(const bdaddr_t *addr)
 
 	DBG("");
 
+	audio_ipc_init();
+
 	bacpy(&adapter_addr, addr);
 
 	server = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
@@ -388,6 +395,8 @@ bool bt_a2dp_register(const bdaddr_t *addr)
 	ipc_register(HAL_SERVICE_ID_A2DP, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
+	audio_ipc_register(audio_handlers, G_N_ELEMENTS(audio_handlers));
+
 	return true;
 
 fail:
@@ -411,8 +420,9 @@ void bt_a2dp_unregister(void)
 	g_slist_foreach(devices, a2dp_device_disconnected, NULL);
 	devices = NULL;
 
-
 	ipc_unregister(HAL_SERVICE_ID_A2DP);
+	audio_ipc_unregister();
+
 	bt_adapter_remove_record(record_id);
 	record_id = 0;
 
@@ -421,4 +431,6 @@ void bt_a2dp_unregister(void)
 		g_io_channel_unref(server);
 		server = NULL;
 	}
+
+	audio_ipc_cleanup();
 }
-- 
1.8.4.2

