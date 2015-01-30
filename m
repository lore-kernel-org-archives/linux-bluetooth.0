Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] policy: Fix not removing timers
Date: Fri, 30 Jan 2015 15:04:34 +0200
Message-Id: <1422623075-6319-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If service becomes unavailable, due to e.g. the device being removed,
all the related timers should be removed as well otherwise it may cause
crashes such as the following:

Invalid read of size 8
   at 0x4A6597: btd_device_get_service (device.c:5335)
   by 0x40F49F: policy_connect_ct (policy.c:112)
   by 0x4E7F552: ??? (in /usr/lib64/libglib-2.0.so.0.4200.1)
   by 0x4E7EAEA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.1)
   by 0x4E7EE87: ??? (in /usr/lib64/libglib-2.0.so.0.4200.1)
   by 0x4E7F1B1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.1)
   by 0x40BACF: main (main.c:631)
 Address 0x73b9ba8 is 360 bytes inside a block of size 592 free'd
   at 0x4C2ACE9: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E847FE: g_free (in /usr/lib64/libglib-2.0.so.0.4200.1)
   by 0x49C83F: device_free (device.c:624)
   by 0x4BDB29: remove_interface (object.c:658)
   by 0x4BE701: g_dbus_unregister_interface (object.c:1382)
   by 0x4A49DC: btd_device_unref (device.c:5173)
   by 0x41DC46: avdtp_free (avdtp.c:1138)
   by 0x41EE09: connection_lost (avdtp.c:1164)
   by 0x422EA5: session_cb (avdtp.c:2263)
   by 0x4E7EAEA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.1)
   by 0x4E7EE87: ??? (in /usr/lib64/libglib-2.0.so.0.4200.1)
   by 0x4E7F1B1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.1)
---
 plugins/policy.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/plugins/policy.c b/plugins/policy.c
index 6fb0729..0aaf45f 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -214,6 +214,11 @@ static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 
 	switch (new_state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
+		if (data->sink_timer > 0) {
+			g_source_remove(data->sink_timer);
+			data->sink_timer = 0;
+		}
+		break;
 	case BTD_SERVICE_STATE_DISCONNECTED:
 		if (old_state == BTD_SERVICE_STATE_CONNECTING) {
 			int err = btd_service_get_error(service);
@@ -324,6 +329,11 @@ static void source_cb(struct btd_service *service,
 
 	switch (new_state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
+		if (data->source_timer > 0) {
+			g_source_remove(data->source_timer);
+			data->source_timer = 0;
+		}
+		break;
 	case BTD_SERVICE_STATE_DISCONNECTED:
 		if (old_state == BTD_SERVICE_STATE_CONNECTING) {
 			int err = btd_service_get_error(service);
@@ -382,6 +392,11 @@ static void controller_cb(struct btd_service *service,
 
 	switch (new_state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
+		if (data->ct_timer > 0) {
+			g_source_remove(data->ct_timer);
+			data->ct_timer = 0;
+		}
+		break;
 	case BTD_SERVICE_STATE_DISCONNECTED:
 		break;
 	case BTD_SERVICE_STATE_CONNECTING:
@@ -410,6 +425,12 @@ static void target_cb(struct btd_service *service,
 
 	switch (new_state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
+		if (data->tg_timer > 0) {
+			g_source_remove(data->tg_timer);
+			data->tg_timer = 0;
+		}
+
+		break;
 	case BTD_SERVICE_STATE_DISCONNECTED:
 		break;
 	case BTD_SERVICE_STATE_CONNECTING:
@@ -419,6 +440,7 @@ static void target_cb(struct btd_service *service,
 			g_source_remove(data->tg_timer);
 			data->tg_timer = 0;
 		}
+
 		break;
 	case BTD_SERVICE_STATE_DISCONNECTING:
 		break;
-- 
2.1.0

