Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] audio/AVDTP: Add struct for discover specific data
Date: Mon, 14 Oct 2013 13:14:46 +0300
Message-Id: <1381745687-5677-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1381745687-5677-1-git-send-email-luiz.dentz@gmail.com>
References: <1381745687-5677-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This pushes discover specific data to a struct which is a common practice
if the field contains callback and user_data specific to certain
operations.
---
 profiles/audio/avdtp.c | 48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 57e644c..dab8f1c 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -354,6 +354,12 @@ struct avdtp_state_callback {
 	void *user_data;
 };
 
+struct discover_callback {
+	unsigned int id;
+	avdtp_discover_cb_t cb;
+	void *user_data;
+};
+
 struct avdtp_stream {
 	GIOChannel *io;
 	uint16_t imtu;
@@ -412,10 +418,7 @@ struct avdtp {
 
 	char *buf;
 
-	guint discov_id;
-	avdtp_discover_cb_t discov_cb;
-	void *user_data;
-
+	struct discover_callback *discover;
 	struct pending_req *req;
 
 	guint dc_timer;
@@ -1042,24 +1045,21 @@ static void avdtp_sep_set_state(struct avdtp *session,
 
 static void finalize_discovery(struct avdtp *session, int err)
 {
+	struct discover_callback *discover = session->discover;
 	struct avdtp_error avdtp_err;
 
-	avdtp_error_init(&avdtp_err, AVDTP_ERRNO, err);
-
-	if (!session->discov_cb)
+	if (!discover)
 		return;
 
-	if (session->discov_id > 0) {
-		g_source_remove(session->discov_id);
-		session->discov_id = 0;
-	}
+	avdtp_error_init(&avdtp_err, AVDTP_ERRNO, err);
 
-	session->discov_cb(session, session->seps,
-				err ? &avdtp_err : NULL,
-				session->user_data);
+	if (discover->id > 0)
+		g_source_remove(discover->id);
 
-	session->discov_cb = NULL;
-	session->user_data = NULL;
+	discover->cb(session, session->seps, err ? &avdtp_err : NULL,
+							discover->user_data);
+	g_free(discover);
+	session->discover = NULL;
 }
 
 static void release_stream(struct avdtp_stream *stream, struct avdtp *session)
@@ -3328,7 +3328,7 @@ static gboolean process_discover(gpointer data)
 {
 	struct avdtp *session = data;
 
-	session->discov_id = 0;
+	session->discover->id = 0;
 
 	finalize_discovery(session, 0);
 
@@ -3340,20 +3340,22 @@ int avdtp_discover(struct avdtp *session, avdtp_discover_cb_t cb,
 {
 	int err;
 
-	if (session->discov_cb)
+	if (session->discover)
 		return -EBUSY;
 
+	session->discover = g_new0(struct discover_callback, 1);
+
 	if (session->seps) {
-		session->discov_cb = cb;
-		session->user_data = user_data;
-		session->discov_id = g_idle_add(process_discover, session);
+		session->discover->cb = cb;
+		session->discover->user_data = user_data;
+		session->discover->id = g_idle_add(process_discover, session);
 		return 0;
 	}
 
 	err = send_request(session, FALSE, NULL, AVDTP_DISCOVER, NULL, 0);
 	if (err == 0) {
-		session->discov_cb = cb;
-		session->user_data = user_data;
+		session->discover->cb = cb;
+		session->discover->user_data = user_data;
 	}
 
 	return err;
-- 
1.8.3.1

