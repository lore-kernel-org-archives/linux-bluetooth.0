Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/6] avdtp: Move connection_lost function to avoid forward declaration
Date: Thu, 10 Oct 2013 10:53:40 +0200
Message-ID: <1381395221-5067-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381395221-5067-1-git-send-email-szymon.janc@tieto.com>
References: <1381395221-5067-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/avdtp.c | 53 +++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index bf15935..e5d4139 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -439,7 +439,6 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 					uint8_t transaction, uint8_t signal_id,
 					void *buf, int size);
 static int process_queue(struct avdtp *session);
-static void connection_lost(struct avdtp *session, int err);
 static void avdtp_sep_set_state(struct avdtp *session,
 				struct avdtp_local_sep *sep,
 				avdtp_state_t state);
@@ -1137,6 +1136,32 @@ static void avdtp_free(void *data)
 	g_free(session);
 }
 
+static void connection_lost(struct avdtp *session, int err)
+{
+	struct avdtp_server *server = session->server;
+	char address[18];
+
+	ba2str(device_get_address(session->device), address);
+	DBG("Disconnected from %s", address);
+
+	if (err != EACCES)
+		avdtp_cancel_authorization(session);
+
+	g_slist_foreach(session->streams, (GFunc) release_stream, session);
+	session->streams = NULL;
+
+	finalize_discovery(session, err);
+
+	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
+
+	if (session->ref > 0)
+		return;
+
+	server->sessions = g_slist_remove(server->sessions, session);
+	btd_device_unref(session->device);
+	avdtp_free(session);
+}
+
 static gboolean disconnect_timeout(gpointer user_data)
 {
 	struct avdtp *session = user_data;
@@ -1180,32 +1205,6 @@ static void set_disconnect_timer(struct avdtp *session)
 						session);
 }
 
-static void connection_lost(struct avdtp *session, int err)
-{
-	struct avdtp_server *server = session->server;
-	char address[18];
-
-	ba2str(device_get_address(session->device), address);
-	DBG("Disconnected from %s", address);
-
-	if (err != EACCES)
-		avdtp_cancel_authorization(session);
-
-	g_slist_foreach(session->streams, (GFunc) release_stream, session);
-	session->streams = NULL;
-
-	finalize_discovery(session, err);
-
-	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
-
-	if (session->ref > 0)
-		return;
-
-	server->sessions = g_slist_remove(server->sessions, session);
-	btd_device_unref(session->device);
-	avdtp_free(session);
-}
-
 void avdtp_unref(struct avdtp *session)
 {
 	if (!session)
-- 
1.8.4

