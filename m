Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Fix not indicating resume problems on a2dp stream
Date: Wed, 11 May 2011 18:15:30 +0300
Message-Id: <1305126930-1926-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1305126930-1926-1-git-send-email-luiz.dentz@gmail.com>
References: <1305126930-1926-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

There is no D-Bus signal when attempting to resume an a2dp stream leaving
applications unable to detect any problems if they were not directly using
Media API or unix socket.
---
 audio/a2dp.c      |    5 +++++
 audio/avdtp.c     |   18 ++++++++++++++++--
 audio/avdtp.h     |    1 +
 audio/device.c    |    1 +
 audio/sink.c      |    6 ++++++
 audio/sink.h      |    1 +
 audio/source.c    |    5 +++++
 audio/source.h    |    1 +
 doc/audio-api.txt |   14 ++++++++++----
 9 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 9cd7207..52c4448 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -2124,6 +2124,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 		}
 		break;
 	case AVDTP_STATE_OPEN:
+	case AVDTP_STATE_RESUMING:
 	case AVDTP_STATE_STREAMING:
 		if (avdtp_stream_has_capabilities(setup->stream, caps)) {
 			DBG("Configuration match: resuming");
@@ -2176,6 +2177,8 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 			goto failed;
 		}
 		break;
+	case AVDTP_STATE_RESUMING:
+		break;
 	case AVDTP_STATE_STREAMING:
 		if (!sep->suspending && sep->suspend_timer) {
 			g_source_remove(sep->suspend_timer);
@@ -2226,6 +2229,7 @@ unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 	case AVDTP_STATE_OPEN:
 		cb_data->source_id = g_idle_add(finalize_suspend, setup);
 		break;
+	case AVDTP_STATE_RESUMING:
 	case AVDTP_STATE_STREAMING:
 		if (avdtp_suspend(session, sep->stream) < 0) {
 			error("avdtp_suspend failed");
@@ -2317,6 +2321,7 @@ gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session)
 	case AVDTP_STATE_OPEN:
 		/* Set timer here */
 		break;
+	case AVDTP_STATE_RESUMING:
 	case AVDTP_STATE_STREAMING:
 		if (avdtp_suspend(session, sep->stream) == 0)
 			sep->suspending = TRUE;
diff --git a/audio/avdtp.c b/audio/avdtp.c
index c2aeeec..c122301 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -474,6 +474,8 @@ static const char *avdtp_statestr(avdtp_state_t state)
 		return "CONFIGURED";
 	case AVDTP_STATE_OPEN:
 		return "OPEN";
+	case AVDTP_STATE_RESUMING:
+		return "RESUMING";
 	case AVDTP_STATE_STREAMING:
 		return "STREAMING";
 	case AVDTP_STATE_CLOSING:
@@ -1071,6 +1073,7 @@ static void avdtp_sep_set_state(struct avdtp *session,
 								stream_timeout,
 								stream);
 		break;
+	case AVDTP_STATE_RESUMING:
 	case AVDTP_STATE_STREAMING:
 	case AVDTP_STATE_CLOSING:
 	case AVDTP_STATE_ABORTING:
@@ -1706,7 +1709,8 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 
 		stream = sep->stream;
 
-		if (sep->state != AVDTP_STATE_OPEN) {
+		if (sep->state != AVDTP_STATE_OPEN &&
+				sep->state != AVDTP_STATE_RESUMING) {
 			err = AVDTP_BAD_STATE;
 			goto failed;
 		}
@@ -1750,7 +1754,8 @@ static gboolean avdtp_close_cmd(struct avdtp *session, uint8_t transaction,
 	}
 
 	if (sep->state != AVDTP_STATE_OPEN &&
-			sep->state != AVDTP_STATE_STREAMING) {
+			sep->state != AVDTP_STATE_STREAMING &&
+			sep->state != AVDTP_STATE_RESUMING) {
 		err = AVDTP_BAD_STATE;
 		goto failed;
 	}
@@ -2678,6 +2683,10 @@ static int send_req(struct avdtp *session, gboolean priority,
 		goto failed;
 	}
 
+	if (req->signal_id == AVDTP_START)
+		avdtp_sep_set_state(session, req->stream->lsep,
+							AVDTP_STATE_RESUMING);
+
 	session->req = req;
 
 	req->timeout = g_timeout_add_seconds(req->signal_id == AVDTP_ABORT ?
@@ -3087,6 +3096,7 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 		if (sep && sep->cfm && sep->cfm->start)
 			sep->cfm->start(session, sep, stream, &err,
 					sep->user_data);
+		avdtp_sep_set_state(session, sep, AVDTP_STATE_RESUMING);
 		return TRUE;
 	case AVDTP_SUSPEND:
 		if (!stream_rej_to_err(buf, size, &err, &acp_seid))
@@ -3550,6 +3560,10 @@ int avdtp_start(struct avdtp *session, struct avdtp_stream *stream)
 	if (!g_slist_find(session->streams, stream))
 		return -EINVAL;
 
+	/* Resume in progress, no need to send command again */
+	if (stream->lsep->state == AVDTP_STATE_RESUMING)
+		return 0;
+
 	if (stream->lsep->state != AVDTP_STATE_OPEN)
 		return -EINVAL;
 
diff --git a/audio/avdtp.h b/audio/avdtp.h
index 5f37dc3..1979694 100644
--- a/audio/avdtp.h
+++ b/audio/avdtp.h
@@ -83,6 +83,7 @@ typedef enum {
 	AVDTP_STATE_IDLE,
 	AVDTP_STATE_CONFIGURED,
 	AVDTP_STATE_OPEN,
+	AVDTP_STATE_RESUMING,
 	AVDTP_STATE_STREAMING,
 	AVDTP_STATE_CLOSING,
 	AVDTP_STATE_ABORTING,
diff --git a/audio/device.c b/audio/device.c
index e38e598..0d45c09 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -429,6 +429,7 @@ static void device_sink_cb(struct audio_device *dev,
 				priv->hs_state == HEADSET_STATE_CONNECTING)
 			device_set_state(dev, AUDIO_STATE_CONNECTED);
 		break;
+	case SINK_STATE_RESUMING:
 	case SINK_STATE_PLAYING:
 		break;
 	}
diff --git a/audio/sink.c b/audio/sink.c
index 2d5db18..6f3e85d 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -84,6 +84,7 @@ static char *str_state[] = {
 	"SINK_STATE_DISCONNECTED",
 	"SINK_STATE_CONNECTING",
 	"SINK_STATE_CONNECTED",
+	"SINK_STATE_RESUMING",
 	"SINK_STATE_PLAYING",
 };
 
@@ -96,6 +97,8 @@ static const char *state2str(sink_state_t state)
 		return "connecting";
 	case SINK_STATE_CONNECTED:
 		return "connected";
+	case SINK_STATE_RESUMING:
+		return "resuming";
 	case SINK_STATE_PLAYING:
 		return "playing";
 	default:
@@ -234,6 +237,9 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		}
 		sink_set_state(dev, SINK_STATE_CONNECTED);
 		break;
+	case AVDTP_STATE_RESUMING:
+		sink_set_state(dev, SINK_STATE_RESUMING);
+		break;
 	case AVDTP_STATE_STREAMING:
 		value = TRUE;
 		g_dbus_emit_signal(dev->conn, dev->path, AUDIO_SINK_INTERFACE,
diff --git a/audio/sink.h b/audio/sink.h
index 7b1902b..6a190f8 100644
--- a/audio/sink.h
+++ b/audio/sink.h
@@ -28,6 +28,7 @@ typedef enum {
 	SINK_STATE_DISCONNECTED,
 	SINK_STATE_CONNECTING,
 	SINK_STATE_CONNECTED,
+	SINK_STATE_RESUMING,
 	SINK_STATE_PLAYING,
 } sink_state_t;
 
diff --git a/audio/source.c b/audio/source.c
index 6d266f2..ab3b135 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -90,6 +90,8 @@ static const char *state2str(source_state_t state)
 		return "connecting";
 	case SOURCE_STATE_CONNECTED:
 		return "connected";
+	case SOURCE_STATE_RESUMING:
+		return "resuming";
 	case SOURCE_STATE_PLAYING:
 		return "playing";
 	default:
@@ -193,6 +195,9 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	case AVDTP_STATE_OPEN:
 		source_set_state(dev, SOURCE_STATE_CONNECTED);
 		break;
+	case AVDTP_STATE_RESUMING:
+		source_set_state(dev, SOURCE_STATE_RESUMING);
+		break;
 	case AVDTP_STATE_STREAMING:
 		source_set_state(dev, SOURCE_STATE_PLAYING);
 		break;
diff --git a/audio/source.h b/audio/source.h
index 7837284..d1dd90c 100644
--- a/audio/source.h
+++ b/audio/source.h
@@ -29,6 +29,7 @@ typedef enum {
 	SOURCE_STATE_DISCONNECTED,
 	SOURCE_STATE_CONNECTING,
 	SOURCE_STATE_CONNECTED,
+	SOURCE_STATE_RESUMING,
 	SOURCE_STATE_PLAYING,
 } source_state_t;
 
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index 1eed843..d2f3996 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -261,7 +261,7 @@ Signals		void Connected() {deprecated}
 properties	string State [readonly]
 
 			Possible values: "disconnected", "connecting",
-			"connected", "playing"
+			"connected", "resuming", "playing"
 
 			"disconnected" -> "connecting"
 				Either an incoming or outgoing connection
@@ -273,7 +273,10 @@ properties	string State [readonly]
 			"connecting" -> "connected"
 				Successfully connected
 
-			"connected" -> "playing"
+			"resuming" -> "connected"
+				Audio stream failed to resume
+
+			"resuming" -> "playing"
 				Audio stream active
 
 			"playing" -> "connected"
@@ -324,7 +327,7 @@ Signals		PropertyChanged(string name, variant value)
 properties	string State [readonly]
 
 			Possible values: "disconnected", "connecting",
-			"connected", "playing"
+			"connected", "resuming", "playing"
 
 			"disconnected" -> "connecting"
 				Either an incoming or outgoing connection
@@ -336,7 +339,10 @@ properties	string State [readonly]
 			"connecting" -> "connected"
 				Successfully connected
 
-			"connected" -> "playing"
+			"resuming" -> "connected"
+				Audio stream failed to resume
+
+			"resuming" -> "playing"
 				Audio stream active
 
 			"playing" -> "connected"
-- 
1.7.1

