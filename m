Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/16] a2dp: Convert sink/source register to accept btd_adapter
Date: Wed, 12 Dec 2012 11:27:56 +0100
Message-ID: <1355308088-9080-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pass btd_adapter directly or use getters to get needed data from
adapter object.
---
 profiles/audio/a2dp.c    | 14 ++++++++------
 profiles/audio/a2dp.h    |  4 ++--
 profiles/audio/manager.c |  4 ++--
 profiles/audio/sink.c    |  5 +++--
 profiles/audio/source.c  |  5 +++--
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index ac5c513..eeecb43 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -37,6 +37,8 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include "../src/adapter.h"
+
 #include "log.h"
 #include "device.h"
 #include "manager.h"
@@ -1179,15 +1181,15 @@ static struct a2dp_server *a2dp_server_register(const bdaddr_t *src,
 	return server;
 }
 
-int a2dp_source_register(const bdaddr_t *src, GKeyFile *config)
+int a2dp_source_register(struct btd_adapter *adapter, GKeyFile *config)
 {
 	struct a2dp_server *server;
 
-	server = find_server(servers, src);
+	server = find_server(servers, adapter_get_address(adapter));
 	if (server != NULL)
 		goto done;
 
-	server = a2dp_server_register(src, config);
+	server = a2dp_server_register(adapter_get_address(adapter), config);
 	if (server == NULL)
 		return -EPROTONOSUPPORT;
 
@@ -1197,15 +1199,15 @@ done:
 	return 0;
 }
 
-int a2dp_sink_register(const bdaddr_t *src, GKeyFile *config)
+int a2dp_sink_register(struct btd_adapter *adapter, GKeyFile *config)
 {
 	struct a2dp_server *server;
 
-	server = find_server(servers, src);
+	server = find_server(servers, adapter_get_address(adapter));
 	if (server != NULL)
 		goto done;
 
-	server = a2dp_server_register(src, config);
+	server = a2dp_server_register(adapter_get_address(adapter), config);
 	if (server == NULL)
 		return -EPROTONOSUPPORT;
 
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index ded1060..827d5cc 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -64,8 +64,8 @@ typedef void (*a2dp_stream_cb_t) (struct avdtp *session,
 					struct avdtp_error *err,
 					void *user_data);
 
-int a2dp_source_register(const bdaddr_t *src, GKeyFile *config);
-int a2dp_sink_register(const bdaddr_t *src, GKeyFile *config);
+int a2dp_source_register(struct btd_adapter *adapter, GKeyFile *config);
+int a2dp_sink_register(struct btd_adapter *adapter, GKeyFile *config);
 void a2dp_unregister(const bdaddr_t *src);
 
 struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 7025868..b355281 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -351,7 +351,7 @@ static int a2dp_source_server_probe(struct btd_profile *p,
 
 	audio_adapter_unref(adp); /* Referenced by a2dp server */
 
-	return a2dp_source_register(adapter_get_address(adapter), config);
+	return a2dp_source_register(adapter, config);
 }
 
 static int a2dp_sink_server_probe(struct btd_profile *p,
@@ -368,7 +368,7 @@ static int a2dp_sink_server_probe(struct btd_profile *p,
 
 	audio_adapter_unref(adp); /* Referenced by a2dp server */
 
-	return a2dp_sink_register(adapter_get_address(adapter), config);
+	return a2dp_sink_register(adapter, config);
 }
 
 static int avrcp_server_probe(struct btd_profile *p,
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 62ec601..a3d9b1f 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -39,6 +39,9 @@
 
 #include "log.h"
 
+#include "../src/adapter.h"
+#include "../src/device.h"
+
 #include "device.h"
 #include "avdtp.h"
 #include "media.h"
@@ -46,8 +49,6 @@
 #include "error.h"
 #include "sink.h"
 #include "dbus-common.h"
-#include "../src/adapter.h"
-#include "../src/device.h"
 
 #define STREAM_SETUP_RETRY_TIMER 2
 
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index ef6cf7a..efd6946 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -40,6 +40,9 @@
 
 #include "log.h"
 
+#include "../src/adapter.h"
+#include "../src/device.h"
+
 #include "device.h"
 #include "avdtp.h"
 #include "media.h"
@@ -48,8 +51,6 @@
 #include "manager.h"
 #include "source.h"
 #include "dbus-common.h"
-#include "../src/adapter.h"
-#include "../src/device.h"
 
 #define STREAM_SETUP_RETRY_TIMER 2
 
-- 
1.8.0

