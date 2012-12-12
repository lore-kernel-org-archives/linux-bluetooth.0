Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 12/16] avdtp: Replace avdtp_get_peers with adapter and device getters
Date: Wed, 12 Dec 2012 11:28:04 +0100
Message-ID: <1355308088-9080-13-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to directly pass adapter or device object instead
of looking for them with addresses later on.
---
 profiles/audio/a2dp.c  | 24 ++++++++++--------------
 profiles/audio/avdtp.c | 26 +++++++++++++++-----------
 profiles/audio/avdtp.h |  3 ++-
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index da54717..f8e0f19 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -49,6 +49,7 @@
 #include "a2dp-codecs.h"
 #include "sdpd.h"
 #include "../src/manager.h"
+#include "../src/device.h"
 
 /* The duration that streams without users are allowed to stay in
  * STREAMING state. */
@@ -123,11 +124,12 @@ static struct a2dp_setup *setup_ref(struct a2dp_setup *setup)
 
 static struct audio_device *a2dp_get_dev(struct avdtp *session)
 {
-	bdaddr_t src, dst;
+	struct btd_adapter *adapter = avdtp_get_adapter(session);
+	struct btd_device *device = avdtp_get_device(session);
 
-	avdtp_get_peers(session, &src, &dst);
-
-	return manager_find_device(NULL, &src, &dst, NULL, FALSE);
+	return manager_find_device(NULL, adapter_get_address(adapter),
+					device_get_address(device), NULL,
+					FALSE);
 }
 
 static struct a2dp_setup *setup_new(struct avdtp *session)
@@ -1492,10 +1494,8 @@ static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t type,
 	struct a2dp_server *server;
 	struct a2dp_sep *sep;
 	GSList *l;
-	bdaddr_t src;
 
-	avdtp_get_peers(session, &src, NULL);
-	server = find_server(servers, manager_find_adapter(&src));
+	server = find_server(servers, avdtp_get_adapter(session));
 	if (!server)
 		return NULL;
 
@@ -1571,10 +1571,8 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 	struct avdtp_service_capability *cap;
 	struct avdtp_media_codec_capability *codec_cap = NULL;
 	int posix_err;
-	bdaddr_t src;
 
-	avdtp_get_peers(session, &src, NULL);
-	server = find_server(servers, manager_find_adapter(&src));
+	server = find_server(servers, avdtp_get_adapter(session));
 	if (!server)
 		return 0;
 
@@ -1883,15 +1881,13 @@ struct a2dp_sep *a2dp_get_sep(struct avdtp *session,
 				struct avdtp_stream *stream)
 {
 	struct a2dp_server *server;
-	bdaddr_t src, dst;
+	struct btd_adapter *adapter = avdtp_get_adapter(session);
 	GSList *l;
 
-	avdtp_get_peers(session, &src, &dst);
-
 	for (l = servers; l; l = l->next) {
 		server = l->data;
 
-		if (bacmp(&src, adapter_get_address(server->adapter)) == 0)
+		if (server->adapter == adapter)
 			break;
 	}
 
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 20fdf25..690294c 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -714,13 +714,14 @@ static void avdtp_set_state(struct avdtp *session,
 {
 	GSList *l;
 	struct audio_device *dev;
-	bdaddr_t src, dst;
 	avdtp_session_state_t old_state = session->state;
+	struct btd_adapter *adapter = avdtp_get_adapter(session);
+	struct btd_device *device = avdtp_get_device(session);
 
 	session->state = new_state;
 
-	avdtp_get_peers(session, &src, &dst);
-	dev = manager_get_device(&src, &dst, FALSE);
+	dev = manager_get_device(adapter_get_address(adapter),
+					device_get_address(device), FALSE);
 	if (dev == NULL) {
 		error("%s(): No matching audio device", __func__);
 		return;
@@ -1456,8 +1457,9 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 	struct avdtp_stream *stream;
 	uint8_t err, category = 0x00;
 	struct audio_device *dev;
-	bdaddr_t src, dst;
 	GSList *l;
+	struct btd_adapter *adapter = avdtp_get_adapter(session);
+	struct btd_device *device = avdtp_get_device(session);
 
 	if (size < sizeof(struct setconf_req)) {
 		error("Too short getcap request");
@@ -1475,8 +1477,8 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
-	avdtp_get_peers(session, &src, &dst);
-	dev = manager_get_device(&src, &dst, FALSE);
+	dev = manager_get_device(adapter_get_address(adapter),
+					device_get_address(device), FALSE);
 	if (!dev) {
 		error("Unable to get a audio device object");
 		err = AVDTP_BAD_STATE;
@@ -3845,12 +3847,14 @@ avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep)
 	return sep->state;
 }
 
-void avdtp_get_peers(struct avdtp *session, bdaddr_t *src, bdaddr_t *dst)
+struct btd_adapter *avdtp_get_adapter(struct avdtp *session)
+{
+	return session->server->adapter;
+}
+
+struct btd_device *avdtp_get_device(struct avdtp *session)
 {
-	if (src)
-		bacpy(src, adapter_get_address(session->server->adapter));
-	if (dst)
-		bacpy(dst, device_get_address(session->device));
+	return session->device;
 }
 
 int avdtp_init(struct btd_adapter *adapter, GKeyFile *config)
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index dbdf8f4..8f0d7e6 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -305,7 +305,8 @@ uint8_t avdtp_error_category(struct avdtp_error *err);
 int avdtp_error_error_code(struct avdtp_error *err);
 int avdtp_error_posix_errno(struct avdtp_error *err);
 
-void avdtp_get_peers(struct avdtp *session, bdaddr_t *src, bdaddr_t *dst);
+struct btd_adapter *avdtp_get_adapter(struct avdtp *session);
+struct btd_device *avdtp_get_device(struct avdtp *session);
 
 gboolean avdtp_stream_setup_active(struct avdtp *session);
 void avdtp_set_device_disconnect(struct avdtp *session, gboolean dev_dc);
-- 
1.8.0

