Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] android/AVDTP: Add avdtp_shutdown
Date: Thu, 19 Dec 2013 17:15:55 +0200
Message-Id: <1387466156-14100-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1387466156-14100-1-git-send-email-luiz.dentz@gmail.com>
References: <1387466156-14100-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

avdtp_shutdown can be used to disconnect closing all existing stream
properly.
---
 android/avdtp.c | 19 +++++++++++++++++++
 android/avdtp.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/android/avdtp.c b/android/avdtp.c
index b2d77a4..7d3cb18 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -2102,6 +2102,25 @@ gboolean avdtp_remove_disconnect_cb(struct avdtp *session, unsigned int id)
 	return FALSE;
 }
 
+void avdtp_shutdown(struct avdtp *session)
+{
+	GSList *l;
+	int sock;
+
+	if (!session->io)
+		return;
+
+	for (l = session->streams; l; l = g_slist_next(l)) {
+		struct avdtp_stream *stream = l->data;
+
+		avdtp_close(session, stream, TRUE);
+	}
+
+	sock = g_io_channel_unix_get_fd(session->io);
+
+	shutdown(sock, SHUT_RDWR);
+}
+
 static void queue_request(struct avdtp *session, struct pending_req *req,
 			gboolean priority)
 {
diff --git a/android/avdtp.h b/android/avdtp.h
index 1619029..d371653 100644
--- a/android/avdtp.h
+++ b/android/avdtp.h
@@ -209,6 +209,8 @@ unsigned int avdtp_add_disconnect_cb(struct avdtp *session,
 						void *user_data);
 gboolean avdtp_remove_disconnect_cb(struct avdtp *session, unsigned int id);
 
+void avdtp_shutdown(struct avdtp *session);
+
 void avdtp_unref(struct avdtp *session);
 struct avdtp *avdtp_ref(struct avdtp *session);
 
-- 
1.8.3.1

