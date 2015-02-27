Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 05/20] audio/avdtp: Move connection logic from avdtp to a2dp
Date: Fri, 27 Feb 2015 17:02:53 +0200
Message-Id: <1425049388-18333-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

l2cap connection logic moved from avdtp.c to a2dp.c
---
 profiles/audio/a2dp.c      | 24 ++++++++++++++++++++++++
 profiles/audio/a2dp.h      |  1 +
 profiles/audio/avdtp.c     | 29 ++---------------------------
 profiles/audio/media.c     |  2 ++
 profiles/audio/sink.c      |  2 ++
 profiles/audio/source.c    |  2 ++
 profiles/audio/transport.c |  2 ++
 7 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c96971f..e23455a 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1265,6 +1265,30 @@ static void avdtp_server_destroy(struct avdtp_server *server)
 	g_free(server);
 }
 
+GIOChannel *l2cap_connect(struct avdtp *session, BtIOConnect cb)
+{
+	GError *err = NULL;
+	GIOChannel *io;
+	const bdaddr_t *src;
+
+	src = btd_adapter_get_address(avdtp_get_adapter(session));
+
+	io = bt_io_connect(cb, session, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, src,
+				BT_IO_OPT_DEST_BDADDR,
+				device_get_address(avdtp_get_device(session)),
+				BT_IO_OPT_PSM, AVDTP_PSM,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_INVALID);
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+		return NULL;
+	}
+
+	return io;
+}
+
 static void a2dp_clean_lsep(struct a2dp_sep *sep)
 {
 	struct avdtp_local_sep *lsep = sep->lsep;
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index fdcc528..a4d6947 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -91,3 +91,4 @@ struct avdtp *a2dp_avdtp_get(struct btd_device *device);
 void avdtp_server_remove_session(struct avdtp_server *server,
 							struct avdtp *session);
 struct btd_adapter *avdtp_server_get_adapter(struct avdtp_server *server);
+GIOChannel *l2cap_connect(struct avdtp *session, BtIOConnect cb);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 05b3d2c..1ea9fe4 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2454,31 +2454,6 @@ bool avdtp_request_authorization(struct avdtp *session, const bdaddr_t *src,
 	return true;
 }
 
-static GIOChannel *l2cap_connect(struct avdtp *session)
-{
-	GError *err = NULL;
-	GIOChannel *io;
-	const bdaddr_t *src;
-
-	src = btd_adapter_get_address(avdtp_get_adapter(session));
-
-	io = bt_io_connect(avdtp_connect_cb, session,
-				NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_DEST_BDADDR,
-				device_get_address(session->device),
-				BT_IO_OPT_PSM, AVDTP_PSM,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_INVALID);
-	if (!io) {
-		error("%s", err->message);
-		g_error_free(err);
-		return NULL;
-	}
-
-	return io;
-}
-
 static void queue_request(struct avdtp *session, struct pending_req *req,
 			gboolean priority)
 {
@@ -2614,7 +2589,7 @@ static int send_req(struct avdtp *session, gboolean priority,
 	int err;
 
 	if (session->state == AVDTP_SESSION_STATE_DISCONNECTED) {
-		session->io = l2cap_connect(session);
+		session->io = l2cap_connect(session, avdtp_connect_cb);
 		if (!session->io) {
 			err = -EIO;
 			goto failed;
@@ -2796,7 +2771,7 @@ static gboolean avdtp_open_resp(struct avdtp *session, struct avdtp_stream *stre
 {
 	struct avdtp_local_sep *sep = stream->lsep;
 
-	stream->io = l2cap_connect(session);
+	stream->io = l2cap_connect(session, avdtp_connect_cb);
 	if (!stream->io) {
 		avdtp_sep_set_state(session, sep, AVDTP_STATE_IDLE);
 		return FALSE;
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 633695c..18fe2c1 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -46,6 +46,8 @@
 #include "src/error.h"
 #include "src/shared/queue.h"
 
+#include "btio/btio.h"
+
 #include "avdtp.h"
 #include "media.h"
 #include "transport.h"
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 7cf22d9..ad4bbaa 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -46,6 +46,8 @@
 #include "src/dbus-common.h"
 #include "src/shared/queue.h"
 
+#include "btio/btio.h"
+
 #include "avdtp.h"
 #include "media.h"
 #include "a2dp.h"
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index fd68917..039157c 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -47,6 +47,8 @@
 #include "src/dbus-common.h"
 #include "src/shared/queue.h"
 
+#include "btio/btio.h"
+
 #include "avdtp.h"
 #include "media.h"
 #include "a2dp.h"
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index a267bfd..ca11a86 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -41,6 +41,8 @@
 #include "src/error.h"
 #include "src/shared/queue.h"
 
+#include "btio/btio.h"
+
 #include "avdtp.h"
 #include "media.h"
 #include "transport.h"
-- 
2.1.0

