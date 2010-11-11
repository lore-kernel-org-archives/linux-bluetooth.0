Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Fix not aborting sink stream configuration on disconnect
Date: Thu, 11 Nov 2010 11:40:25 +0200
Message-Id: <1289468425-11997-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1289468425-11997-1-git-send-email-luiz.dentz@gmail.com>
References: <1289468425-11997-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

If stream configuration is not complete it should be aborted so we can
proceed with disconnection process.
---
 audio/sink.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/audio/sink.c b/audio/sink.c
index a9f6307..cb3ca74 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -351,6 +351,12 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 	struct pending_request *pending;
 	int id;
 
+	if (!sink->connect) {
+		avdtp_unref(sink->session);
+		sink->session = NULL;
+		return;
+	}
+
 	pending = sink->connect;
 
 	if (err) {
@@ -669,11 +675,31 @@ gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
 
 gboolean sink_shutdown(struct sink *sink)
 {
-	if (!sink->stream)
+	if (!sink->session)
 		return FALSE;
 
 	avdtp_set_device_disconnect(sink->session, TRUE);
 
+	/* cancel pending connect */
+	if (sink->connect) {
+		struct pending_request *pending = sink->connect;
+
+		if (pending->msg)
+			error_failed(pending->conn, pending->msg,
+							"Stream setup failed");
+		pending_request_free(sink->dev, pending);
+		sink->connect = NULL;
+
+		return TRUE;
+	}
+
+	/* disconnect already ongoing */
+	if (sink->disconnect)
+		return TRUE;
+
+	if (!sink->stream)
+		return FALSE;
+
 	if (avdtp_close(sink->session, sink->stream, FALSE) < 0)
 		return FALSE;
 
-- 
1.7.1

