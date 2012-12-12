Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 14/16] audio: Make manager_get_device accept btd_device
Date: Wed, 12 Dec 2012 11:28:06 +0100
Message-ID: <1355308088-9080-15-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also rename manager_get_device to manager_get_audio_device to better
mark what this function do.
---
 profiles/audio/a2dp.c    |  8 +-------
 profiles/audio/avctp.c   | 14 ++++----------
 profiles/audio/avdtp.c   | 18 +++++-------------
 profiles/audio/manager.c | 35 +++++++----------------------------
 profiles/audio/manager.h |  5 ++---
 5 files changed, 19 insertions(+), 61 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c812d45..4c74652 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -48,8 +48,6 @@
 #include "a2dp.h"
 #include "a2dp-codecs.h"
 #include "sdpd.h"
-#include "../src/manager.h"
-#include "../src/device.h"
 
 /* The duration that streams without users are allowed to stay in
  * STREAMING state. */
@@ -124,11 +122,7 @@ static struct a2dp_setup *setup_ref(struct a2dp_setup *setup)
 
 static struct audio_device *a2dp_get_dev(struct avdtp *session)
 {
-	struct btd_adapter *adapter = avdtp_get_adapter(session);
-	struct btd_device *device = avdtp_get_device(session);
-
-	return manager_get_device(adapter_get_address(adapter),
-					device_get_address(device), FALSE);
+	return manager_get_audio_device(avdtp_get_device(session), FALSE);
 }
 
 static struct a2dp_setup *setup_new(struct avdtp *session)
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index e56885a..8ffbf43 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -448,9 +448,7 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 	struct audio_device *dev;
 	avctp_state_t old_state = session->state;
 
-	dev = manager_get_device(adapter_get_address(session->server->adapter),
-					device_get_address(session->device),
-					FALSE);
+	dev = manager_get_audio_device(session->device, FALSE);
 	if (dev == NULL) {
 		error("%s(): No matching audio device", __func__);
 		return;
@@ -842,9 +840,7 @@ static void init_uinput(struct avctp *session)
 	struct audio_device *dev;
 	char address[18], name[248 + 1];
 
-	dev = manager_get_device(adapter_get_address(session->server->adapter),
-					device_get_address(session->device),
-					FALSE);
+	dev = manager_get_audio_device(session->device, FALSE);
 
 	device_get_name(dev->btd_dev, name, sizeof(name));
 	if (g_str_equal(name, "Nokia CK-20W")) {
@@ -855,7 +851,6 @@ static void init_uinput(struct avctp *session)
 	}
 
 	ba2str(device_get_address(session->device), address);
-
 	session->uinput = uinput_create(address);
 	if (session->uinput < 0)
 		error("AVRCP: failed to init uinput for %s", address);
@@ -1137,10 +1132,9 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 	if (session == NULL)
 		return;
 
-	dev = manager_get_device(&src, device_get_address(device), FALSE);
+	dev = manager_get_audio_device(device, FALSE);
 	if (!dev) {
-		dev = manager_get_device(&src, device_get_address(device),
-									TRUE);
+		dev = manager_get_audio_device(device, TRUE);
 		if (!dev) {
 			error("Unable to get audio device object for %s",
 					address);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 690294c..aca7e62 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -715,13 +715,10 @@ static void avdtp_set_state(struct avdtp *session,
 	GSList *l;
 	struct audio_device *dev;
 	avdtp_session_state_t old_state = session->state;
-	struct btd_adapter *adapter = avdtp_get_adapter(session);
-	struct btd_device *device = avdtp_get_device(session);
 
 	session->state = new_state;
 
-	dev = manager_get_device(adapter_get_address(adapter),
-					device_get_address(device), FALSE);
+	dev = manager_get_audio_device(avdtp_get_device(session), FALSE);
 	if (dev == NULL) {
 		error("%s(): No matching audio device", __func__);
 		return;
@@ -1158,9 +1155,7 @@ static gboolean disconnect_timeout(gpointer user_data)
 
 	stream_setup = session->stream_setup;
 	session->stream_setup = FALSE;
-	dev = manager_get_device(adapter_get_address(session->server->adapter),
-					device_get_address(session->device),
-					FALSE);
+	dev = manager_get_audio_device(session->device, FALSE);
 
 	if (dev && dev->sink && stream_setup)
 		sink_setup_stream(dev->sink, session);
@@ -1458,8 +1453,6 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 	uint8_t err, category = 0x00;
 	struct audio_device *dev;
 	GSList *l;
-	struct btd_adapter *adapter = avdtp_get_adapter(session);
-	struct btd_device *device = avdtp_get_device(session);
 
 	if (size < sizeof(struct setconf_req)) {
 		error("Too short getcap request");
@@ -1477,8 +1470,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
-	dev = manager_get_device(adapter_get_address(adapter),
-					device_get_address(device), FALSE);
+	dev = manager_get_audio_device(avdtp_get_device(session), FALSE);
 	if (!dev) {
 		error("Unable to get a audio device object");
 		err = AVDTP_BAD_STATE;
@@ -2515,9 +2507,9 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 		goto drop;
 	}
 
-	dev = manager_get_device(&src, &dst, FALSE);
+	dev = manager_get_audio_device(device, FALSE);
 	if (!dev) {
-		dev = manager_get_device(&src, &dst, TRUE);
+		dev = manager_get_audio_device(device, TRUE);
 		if (!dev) {
 			error("Unable to get audio device object for %s",
 					address);
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index b3d4a68..adc4e77 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -99,10 +99,7 @@ static struct audio_adapter *find_adapter(GSList *list,
 
 static struct audio_device *get_audio_dev(struct btd_device *device)
 {
-	struct btd_adapter *adapter = device_get_adapter(device);
-
-	return manager_get_device(adapter_get_address(adapter),
-					device_get_address(device), TRUE);
+	return manager_get_audio_device(device, TRUE);
 }
 
 static GSList *manager_find_devices(const char *path,
@@ -644,39 +641,21 @@ void audio_manager_exit(void)
 	btd_unregister_adapter_driver(&media_driver);
 }
 
-struct audio_device *manager_get_device(const bdaddr_t *src,
-					const bdaddr_t *dst,
-					gboolean create)
+struct audio_device *manager_get_audio_device(struct btd_device *device,
+							gboolean create)
 {
 	struct audio_device *dev;
-	struct btd_adapter *adapter;
-	struct btd_device *device;
-	char addr[18];
+	struct btd_adapter *adapter = device_get_adapter(device);
 
-	dev = manager_find_device(NULL, src, dst, NULL, FALSE);
+	dev = manager_find_device(NULL, adapter_get_address(adapter),
+					device_get_address(device), NULL,
+					FALSE);
 	if (dev)
 		return dev;
 
 	if (!create)
 		return NULL;
 
-	ba2str(src, addr);
-
-	adapter = manager_find_adapter(src);
-	if (!adapter) {
-		error("Unable to get a btd_adapter object for %s",
-				addr);
-		return NULL;
-	}
-
-	ba2str(dst, addr);
-
-	device = adapter_get_device(adapter, addr, BDADDR_BREDR);
-	if (!device) {
-		error("Unable to get btd_device object for %s", addr);
-		return NULL;
-	}
-
 	dev = audio_device_register(device);
 	if (!dev)
 		return NULL;
diff --git a/profiles/audio/manager.h b/profiles/audio/manager.h
index f352a67..2567e46 100644
--- a/profiles/audio/manager.h
+++ b/profiles/audio/manager.h
@@ -37,9 +37,8 @@ void audio_source_disconnected(struct btd_device *dev, int err);
 int audio_manager_init(GKeyFile *config);
 void audio_manager_exit(void);
 
-struct audio_device *manager_get_device(const bdaddr_t *src,
-					const bdaddr_t *dst,
-					gboolean create);
+struct audio_device *manager_get_audio_device(struct btd_device *device,
+							gboolean create);
 
 /* TRUE to enable fast connectable and FALSE to disable fast connectable for all
  * audio adapters. */
-- 
1.8.0

