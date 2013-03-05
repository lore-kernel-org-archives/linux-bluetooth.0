Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/6] avctp: Allow to register state callback for specified audio device
Date: Tue, 5 Mar 2013 12:06:56 +0100
Message-ID: <1362481619-25815-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1362481619-25815-1-git-send-email-szymon.janc@tieto.com>
References: <1362481619-25815-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

State callback can now be registered and called for specified device
only (or all devices if NULL is passed). This will allow for more
cleaner callback register/unregister in roles code.

Fix following valgrind reports:

16 bytes in 1 blocks are still reachable in loss record 43 of 223
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E92CA2: g_slice_alloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E93FC2: g_slist_append (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x419ABD: avctp_add_state_cb (avctp.c:1652)
   by 0x41DD87: audio_device_register (device.c:320)
   by 0x416ECA: manager_get_audio_device (manager.c:491)
   by 0x4171A8: a2dp_sink_probe (manager.c:131)
   by 0x46A821: dev_probe (device.c:2347)
   by 0x468CBE: btd_profile_foreach (profile.c:599)
   by 0x46BBB5: device_probe_profiles (device.c:2423)
   by 0x461458: load_devices (adapter.c:2549)

16 bytes in 1 blocks are still reachable in loss record 44 of 223
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E92CA2: g_slice_alloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E93FC2: g_slist_append (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x419ABD: avctp_add_state_cb (avctp.c:1652)
   by 0x417791: control_init (control.c:290)
   by 0x417097: avrcp_probe (manager.c:156)
   by 0x46A821: dev_probe (device.c:2347)
   by 0x468CBE: btd_profile_foreach (profile.c:599)
   by 0x46BBB5: device_probe_profiles (device.c:2423)
   by 0x461458: load_devices (adapter.c:2549)
   by 0x465086: read_info_complete (adapter.c:5514)

24 bytes in 1 blocks are still reachable in loss record 59 of 223
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x419A92: avctp_add_state_cb (avctp.c:1647)
   by 0x41DD87: audio_device_register (device.c:320)
   by 0x416ECA: manager_get_audio_device (manager.c:491)
   by 0x4171A8: a2dp_sink_probe (manager.c:131)
   by 0x46A821: dev_probe (device.c:2347)
   by 0x468CBE: btd_profile_foreach (profile.c:599)
   by 0x46BBB5: device_probe_profiles (device.c:2423)
   by 0x461458: load_devices (adapter.c:2549)
   by 0x465086: read_info_complete (adapter.c:5514)
   by 0x4713A1: request_complete (mgmt.c:221)

24 bytes in 1 blocks are still reachable in loss record 60 of 223
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x419A92: avctp_add_state_cb (avctp.c:1647)
   by 0x417791: control_init (control.c:290)
   by 0x417097: avrcp_probe (manager.c:156)
   by 0x46A821: dev_probe (device.c:2347)
   by 0x468CBE: btd_profile_foreach (profile.c:599)
   by 0x46BBB5: device_probe_profiles (device.c:2423)
   by 0x461458: load_devices (adapter.c:2549)
   by 0x465086: read_info_complete (adapter.c:5514)
   by 0x4713A1: request_complete (mgmt.c:221)
   by 0x47175B: received_data (mgmt.c:319)
---
 profiles/audio/avctp.c   | 9 ++++++++-
 profiles/audio/avctp.h   | 3 ++-
 profiles/audio/avrcp.c   | 2 +-
 profiles/audio/control.c | 8 ++++----
 profiles/audio/device.c  | 8 ++++----
 5 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index c276c52..7fbaacb 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -114,6 +114,7 @@ struct avc_header {
 
 struct avctp_state_callback {
 	avctp_state_cb cb;
+	struct audio_device *dev;
 	void *user_data;
 	unsigned int id;
 };
@@ -477,6 +478,10 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 
 	for (l = callbacks; l != NULL; l = l->next) {
 		struct avctp_state_callback *cb = l->data;
+
+		if (cb->dev && cb->dev != dev)
+			continue;
+
 		cb->cb(dev, old_state, new_state, cb->user_data);
 	}
 
@@ -1639,13 +1644,15 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
 						func, user_data);
 }
 
-unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data)
+unsigned int avctp_add_state_cb(avctp_state_cb cb, struct audio_device *dev,
+								void *user_data)
 {
 	struct avctp_state_callback *state_cb;
 	static unsigned int id = 0;
 
 	state_cb = g_new(struct avctp_state_callback, 1);
 	state_cb->cb = cb;
+	state_cb->dev = dev;
 	state_cb->user_data = user_data;
 	state_cb->id = ++id;
 
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index 411b093..56ed672 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -92,7 +92,8 @@ typedef size_t (*avctp_browsing_pdu_cb) (struct avctp *session,
 					uint8_t *operands, size_t operand_count,
 					void *user_data);
 
-unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data);
+unsigned int avctp_add_state_cb(avctp_state_cb cb, struct audio_device *dev,
+							void *user_data);
 gboolean avctp_remove_state_cb(unsigned int id);
 
 int avctp_register(struct btd_adapter *adapter, gboolean master);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index abb902a..b7edc44 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2832,7 +2832,7 @@ int avrcp_register(struct btd_adapter *adapter, GKeyFile *config)
 	servers = g_slist_append(servers, server);
 
 	if (!avctp_id)
-		avctp_id = avctp_add_state_cb(state_changed, NULL);
+		avctp_id = avctp_add_state_cb(state_changed, NULL, NULL);
 
 	return 0;
 }
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 18c8478..b48ff0a 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -59,11 +59,10 @@
 #include "glib-helper.h"
 #include "dbus-common.h"
 
-static unsigned int avctp_id = 0;
-
 struct control {
 	struct avctp *session;
 	gboolean target;
+	unsigned int avctp_id;
 };
 
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
@@ -250,6 +249,8 @@ static void path_unregister(void *data)
 	if (control->session)
 		avctp_disconnect(control->session);
 
+	avctp_remove_state_cb(control->avctp_id);
+
 	g_free(control);
 	dev->control = NULL;
 }
@@ -286,8 +287,7 @@ struct control *control_init(struct audio_device *dev, GSList *uuids)
 
 	control_update(control, uuids);
 
-	if (!avctp_id)
-		avctp_id = avctp_add_state_cb(state_changed, NULL);
+	control->avctp_id = avctp_add_state_cb(state_changed, dev, NULL);
 
 	return control;
 }
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index 663a341..61bd37c 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -81,10 +81,10 @@ struct dev_priv {
 	gboolean disconnecting;
 
 	unsigned int avdtp_callback_id;
+	unsigned int avctp_callback_id;
 };
 
 static unsigned int sink_callback_id = 0;
-static unsigned int avctp_callback_id = 0;
 
 static void device_free(struct audio_device *dev)
 {
@@ -100,6 +100,7 @@ static void device_free(struct audio_device *dev)
 							priv->dc_id);
 
 		avdtp_remove_state_cb(priv->avdtp_callback_id);
+		avctp_remove_state_cb(priv->avctp_callback_id);
 
 		g_free(priv);
 	}
@@ -315,9 +316,8 @@ struct audio_device *audio_device_register(struct btd_device *device)
 		sink_callback_id = sink_add_state_cb(device_sink_cb, NULL);
 
 	dev->priv->avdtp_callback_id = avdtp_add_state_cb(device_avdtp_cb, dev);
-
-	if (avctp_callback_id == 0)
-		avctp_callback_id = avctp_add_state_cb(device_avctp_cb, NULL);
+	dev->priv->avctp_callback_id = avctp_add_state_cb(device_avctp_cb, dev,
+									NULL);
 
 	return dev;
 }
-- 
1.8.1.5

