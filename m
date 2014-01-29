Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/a2dp: Fix crash on remote disconnection
Date: Wed, 29 Jan 2014 16:45:02 +0100
Message-Id: <1391010302-13231-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove setups when a2dp device is removed. This fix following:

Invalid read of size 4
   at 0x115E32: bt_stream_close (a2dp.c:1352)
   by 0x111DFB: ipc_handle_msg (ipc.c:95)
   by 0x11234B: audio_watch_cb (audio-ipc.c:67)
   by 0x48BD9C7: ??? (in /system/lib/libglib.so)
 Address 0x4a590f4 is 12 bytes inside a block of size 20 free'd
   at 0x4897E6C: free (in
       /system/lib/valgrind/vgpreload_memcheck-arm-linux.so)
   by 0x48C5E2B: g_free (in /system/lib/libglib.so)

Invalid read of size 4
   at 0x113638: avdtp_close (avdtp.c:3201)
   by 0x115E39: bt_stream_close (a2dp.c:1352)
   by 0x111DFB: ipc_handle_msg (ipc.c:95)
   by 0x11234B: audio_watch_cb (audio-ipc.c:67)
   by 0x48BD9C7: ??? (in /system/lib/libglib.so)
 Address 0x4a594a4 is 28 bytes inside a block of size 1,100 free'd
   at 0x4897E6C: free (in
       /system/lib/valgrind/vgpreload_memcheck-arm-linux.so)
   by 0x48C5E2B: g_free (in /system/lib/libglib.so)
---
 android/a2dp.c | 49 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 8d8fa7d..a215ce2 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -122,6 +122,37 @@ static void unregister_endpoint(void *data)
 	g_free(endpoint);
 }
 
+static void setup_free(void *data)
+{
+	struct a2dp_setup *setup = data;
+
+	if (!g_slist_find(setup->endpoint->presets, setup->preset))
+		preset_free(setup->preset);
+
+	g_free(setup);
+}
+
+static void setup_remove(struct a2dp_setup *setup)
+{
+	setups = g_slist_remove(setups, setup);
+	setup_free(setup);
+}
+
+static void setup_remove_all_by_dev(struct a2dp_device *dev)
+{
+	GSList *l = setups;
+
+	while (l) {
+		struct a2dp_setup *setup = l->data;
+		GSList *next = g_slist_next(l);
+
+		if (setup->dev == dev)
+			setup_remove(setup);
+
+		l = next;
+	}
+}
+
 static void a2dp_device_free(void *data)
 {
 	struct a2dp_device *dev = data;
@@ -137,6 +168,8 @@ static void a2dp_device_free(void *data)
 		g_io_channel_unref(dev->io);
 	}
 
+	setup_remove_all_by_dev(dev);
+
 	devices = g_slist_remove(devices, dev);
 	g_free(dev);
 }
@@ -828,22 +861,6 @@ static struct a2dp_device *find_device_by_session(struct avdtp *session)
 	return NULL;
 }
 
-static void setup_free(void *data)
-{
-	struct a2dp_setup *setup = data;
-
-	if (!g_slist_find(setup->endpoint->presets, setup->preset))
-		preset_free(setup->preset);
-
-	g_free(setup);
-}
-
-static void setup_remove(struct a2dp_setup *setup)
-{
-	setups = g_slist_remove(setups, setup);
-	setup_free(setup);
-}
-
 static struct a2dp_setup *find_setup(uint8_t id)
 {
 	GSList *l;
-- 
1.8.5.3

