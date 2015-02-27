Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 19/20] android/avdtp: Refactor avdtp_new()
Date: Fri, 27 Feb 2015 17:03:07 +0200
Message-Id: <1425049388-18333-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

avdtp_new() is refactored to two functions avdtp_new() and
avdtp_set_control() similar to set avdtp_set_transport(). This is needed
for code which creates avdtp session without fd like inside sink, source
and transport code.
---
 android/a2dp.c      |  4 +++-
 android/avdtp.c     | 27 ++++++++++++++++-----------
 android/avdtp.h     |  4 ++--
 android/avdtptest.c |  3 ++-
 unit/test-avdtp.c   |  5 +++--
 5 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index f219042..1a6e062 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -647,10 +647,12 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 	fd = g_io_channel_unix_get_fd(chan);
 
 	/* FIXME: Add proper version */
-	session = avdtp_new(fd, imtu, omtu, 0x0100, lseps);
+	session = avdtp_new(0x0100, lseps);
 	if (!session)
 		goto failed;
 
+	avdtp_set_control(session, fd, imtu, omtu);
+
 	dev->session = session;
 
 	avdtp_add_disconnect_cb(dev->session, disconnect_cb, dev);
diff --git a/android/avdtp.c b/android/avdtp.c
index b8a2147..dd31a0b 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -2113,28 +2113,35 @@ static int set_priority(int fd, int priority)
 	return err;
 }
 
-struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version,
-							struct queue *lseps)
+struct avdtp *avdtp_new(uint16_t version, struct queue *lseps)
 {
 	struct avdtp *session;
-	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-	int new_fd;
 
 	if (!lseps)
 		return NULL;
 
+	session = g_new0(struct avdtp, 1);
+	session->version = version;
+	session->lseps = lseps;
+
+	return avdtp_ref(session);
+}
+
+bool avdtp_set_control(struct avdtp *session, int fd, size_t imtu, size_t omtu)
+{
+	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	int new_fd;
+
 	new_fd = dup(fd);
 	if (new_fd < 0) {
 		error("dup(): %s (%d)", strerror(errno), errno);
-		return NULL;
+		return false;
 	}
 
 	if (set_priority(new_fd, 6) < 0)
-		return NULL;
+		return false;
 
-	session = g_new0(struct avdtp, 1);
 	session->io = g_io_channel_unix_new(new_fd);
-	session->version = version;
 	session->imtu = imtu;
 	session->omtu = omtu;
 	session->buf = g_malloc0(MAX(session->imtu, session->omtu));
@@ -2150,9 +2157,7 @@ struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version,
 						(GIOFunc) session_cb, session,
 						NULL);
 
-	session->lseps = lseps;
-
-	return avdtp_ref(session);
+	return true;
 }
 
 unsigned int avdtp_add_disconnect_cb(struct avdtp *session,
diff --git a/android/avdtp.h b/android/avdtp.h
index 07516a8..ce84029 100644
--- a/android/avdtp.h
+++ b/android/avdtp.h
@@ -205,8 +205,8 @@ typedef void (*avdtp_discover_cb_t) (struct avdtp *session, GSList *seps,
 					struct avdtp_error *err, void *user_data);
 typedef void (*avdtp_disconnect_cb_t) (void *user_data);
 
-struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version,
-							struct queue *lseps);
+struct avdtp *avdtp_new(uint16_t version, struct queue *lseps);
+bool avdtp_set_control(struct avdtp *session, int fd, size_t imtu, size_t omtu);
 
 unsigned int avdtp_add_disconnect_cb(struct avdtp *session,
 						avdtp_disconnect_cb_t cb,
diff --git a/android/avdtptest.c b/android/avdtptest.c
index 6529423..763a6f3 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -413,13 +413,14 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		return;
 	}
 
-	avdtp = avdtp_new(fd, imtu, omtu, version, lseps);
+	avdtp = avdtp_new(version, lseps);
 	if (!avdtp) {
 		printf("Failed to create avdtp instance\n");
 		g_main_loop_quit(mainloop);
 		return;
 	}
 
+	avdtp_set_control(avdtp, fd, imtu, omtu);
 	avdtp_add_disconnect_cb(avdtp, disconnect_cb, NULL);
 
 	if (preconf) {
diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 805f08d..b91cf97 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -236,10 +236,11 @@ static struct context *context_new(uint16_t version, uint16_t imtu,
 	context->lseps = queue_new();
 	g_assert(context->lseps);
 
-	context->session = avdtp_new(sv[0], imtu, omtu, version,
-								context->lseps);
+	context->session = avdtp_new(version, context->lseps);
 	g_assert(context->session != NULL);
 
+	g_assert(avdtp_set_control(context->session, sv[0], imtu, omtu));
+
 	channel = g_io_channel_unix_new(sv[1]);
 
 	g_io_channel_set_close_on_unref(channel, TRUE);
-- 
2.1.0

