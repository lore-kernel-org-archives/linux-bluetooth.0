Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2009 18:24:06 +0300
Message-ID: <eb7933e20908270824w2dc3ae2x8257d20d307ce6fd@mail.gmail.com>
Subject: [PATCH] AVDTP start/stop handling during disconnection
From: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A suggested patch for rejecting AVDTP CLOSE and START requests when a
CLOSE request has been initiated. The check is done by testing the
close_int flag in the avdtp_stream struct. The flag is reset when
receiving a timeout or rejection from the remote.

Changes in unix.c were made to call avdtp_unref() in case an AVDTP
session was marked by avdtp_ref(), but no SEP was found. This could
happen if START is called on a session being disconnected.

We found that these changes help to improve behavior both in case the
audio streaming application tries to start the stream during a
disconnection procedure, and if avdtp_close() is called twice.

Br,
Daniel Örstadius

------------------------

 audio/avdtp.c |   19 +++++++++++++++++--
 audio/unix.c  |   11 ++++++++++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 8046dda..839f035 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -2223,9 +2223,12 @@ static gboolean request_timeout(gpointer user_data)
 		break;
 	case AVDTP_CLOSE:
 		error("Close request timed out");
-		if (lsep && lsep->cfm && lsep->cfm->close)
+		if (lsep && lsep->cfm && lsep->cfm->close) {
 			lsep->cfm->close(session, lsep, stream, &err,
 						lsep->user_data);
+			if (stream)
+				stream->close_int = FALSE;
+		}
 		break;
 	case AVDTP_SET_CONFIGURATION:
 		error("SetConfiguration request timed out");
@@ -2675,9 +2678,11 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 			return FALSE;
 		error("CLOSE request rejected: %s (%d)",
 				avdtp_strerror(&err), err.err.error_code);
-		if (sep && sep->cfm && sep->cfm->close)
+		if (sep && sep->cfm && sep->cfm->close) {
 			sep->cfm->close(session, sep, stream, &err,
 					sep->user_data);
+			stream->close_int = FALSE;
+		}
 		return TRUE;
 	case AVDTP_ABORT:
 		if (!stream_rej_to_err(buf, size, &err, &acp_seid))
@@ -3138,6 +3143,11 @@ int avdtp_start(struct avdtp *session, struct
avdtp_stream *stream)
 	if (stream->lsep->state != AVDTP_STATE_OPEN)
 		return -EINVAL;

+	if (stream->close_int == TRUE) {
+		error("avdtp_start: rejecting start since close is initiated");
+		return -EINVAL;
+	}
+
 	memset(&req, 0, sizeof(req));
 	req.first_seid.seid = stream->rseid;

@@ -3156,6 +3166,11 @@ int avdtp_close(struct avdtp *session, struct
avdtp_stream *stream)
 	if (stream->lsep->state < AVDTP_STATE_OPEN)
 		return -EINVAL;

+	if (stream->close_int == TRUE) {
+		error("avdtp_close: rejecting close since it is already inititated");
+		return -EINVAL;
+	}
+
 	memset(&req, 0, sizeof(req));
 	req.acp_seid = stream->rseid;

diff --git a/audio/unix.c b/audio/unix.c
index 0829630..61cc369 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -1051,14 +1051,17 @@ static void start_resume(struct audio_device
*dev, struct unix_client *client)
 	struct a2dp_data *a2dp;
 	struct headset_data *hs;
 	unsigned int id;
+	gboolean ref_session = FALSE;

 	switch (client->type) {
 	case TYPE_SINK:
 	case TYPE_SOURCE:
 		a2dp = &client->d.a2dp;

-		if (!a2dp->session)
+		if (!a2dp->session) {
 			a2dp->session = avdtp_get(&dev->src, &dev->dst);
+			ref_session = TRUE;
+		}			

 		if (!a2dp->session) {
 			error("Unable to get a session");
@@ -1067,6 +1070,12 @@ static void start_resume(struct audio_device
*dev, struct unix_client *client)

 		if (!a2dp->sep) {
 			error("seid not opened");
+
+			if (ref_session) {
+				avdtp_unref(a2dp->session);
+				a2dp->session = NULL;
+			}
+
 			goto failed;
 		}
