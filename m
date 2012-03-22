Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 7/7] media: implement a2dp reconfiguration
Date: Thu, 22 Mar 2012 17:37:55 +0100
Message-Id: <1332434275-25394-8-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/transport.c |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 117 insertions(+), 0 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index f9b924a..6dd3c58 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -43,6 +43,7 @@
 #include "a2dp.h"
 #include "headset.h"
 #include "gateway.h"
+#include "ipc.h"
 
 #ifndef DBUS_TYPE_UNIX_FD
 #define DBUS_TYPE_UNIX_FD -1
@@ -53,6 +54,7 @@
 struct media_request {
 	DBusMessage		*msg;
 	guint			id;
+	DBusConnection		*conn;
 };
 
 struct media_owner {
@@ -837,11 +839,123 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static GSList *handle_a2dp_transport(uint8_t codec)
+{
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct sbc_codec_cap sbc_cap;
+	struct mpeg_codec_cap mpg_cap;
+	GSList *caps = NULL;
+
+	if (codec == A2DP_CODEC_MPEG12) {
+		memset(&mpg_cap, 0, sizeof(mpg_cap));
+
+		/* FIXME: this code says MP3 and hope the receiver accept */
+		mpg_cap.cap.media_type = AVDTP_MEDIA_TYPE_AUDIO;
+		mpg_cap.cap.media_codec_type = A2DP_CODEC_MPEG12;
+		mpg_cap.channel_mode = BT_A2DP_CHANNEL_MODE_JOINT_STEREO;
+		mpg_cap.crc = 0;
+		mpg_cap.layer = BT_MPEG_LAYER_3;
+		mpg_cap.frequency = MPEG_SAMPLING_FREQ_44100;
+		mpg_cap.mpf = 0;
+		mpg_cap.bitrate = 0x80;
+
+		media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, &mpg_cap,
+							sizeof(mpg_cap));
+
+		DBG("Handling switch to MPEG transport");
+	} else if (codec == A2DP_CODEC_SBC) {
+		memset(&sbc_cap, 0, sizeof(sbc_cap));
+
+		/* FIXME: this is the mandatory SBC params for a source */
+		sbc_cap.cap.media_type = AVDTP_MEDIA_TYPE_AUDIO;
+		sbc_cap.cap.media_codec_type = A2DP_CODEC_SBC;
+		sbc_cap.channel_mode = BT_A2DP_CHANNEL_MODE_JOINT_STEREO;
+		sbc_cap.frequency = BT_SBC_SAMPLING_FREQ_44100;
+		sbc_cap.allocation_method = BT_A2DP_ALLOCATION_LOUDNESS;
+		sbc_cap.subbands = BT_A2DP_SUBBANDS_8;
+		sbc_cap.block_length = BT_A2DP_BLOCK_LENGTH_16;
+		sbc_cap.min_bitpool = 53;
+		sbc_cap.max_bitpool = 53;
+
+		media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, &sbc_cap,
+							sizeof(sbc_cap));
+
+		DBG("Handling switch to SBC transport");
+	} else
+		return NULL;
+
+	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
+						NULL, 0);
+
+	caps = g_slist_append(caps, media_transport);
+	caps = g_slist_append(caps, media_codec);
+
+	return caps;
+}
+
+static void a2dp_config_complete(struct avdtp *session, struct a2dp_sep *sep,
+					struct avdtp_stream *stream,
+					struct avdtp_error *err,
+					void *user_data)
+{
+	struct media_request *req = user_data;
+
+	media_request_reply(req, req->conn, err ? -ENOTSUP : 0);
+
+	dbus_connection_unref(req->conn);
+
+	g_free(req);
+}
+
+static void media_transport_reconfigure(struct avdtp *session, const char *path,
+						struct media_request *req)
+{
+	int err;
+	GSList *caps;
+	uint8_t codec;
+	struct media_endpoint *endpoint;
+	struct a2dp_sep *sep;
+
+	endpoint = media_endpoint_find(path);
+	if (endpoint == NULL) {
+		err = -EEXIST;
+		goto failed;
+	}
+	sep = media_endpoint_get_sep(endpoint);
+	codec = media_endpoint_get_codec(endpoint);
+
+	DBG(" sep %p creating caps list for codec %d", sep, codec);
+
+	/* FIXME prevent usage on SCO transport */
+	caps = handle_a2dp_transport(codec);
+	if (caps == NULL) {
+		err = -EINVAL;
+		goto failed;
+	}
+
+	err = a2dp_config(session, sep, a2dp_config_complete,
+					caps, req);
+	if (err < 0)
+		goto failed;
+
+	req->id = err;
+	return;
+
+failed:
+	media_request_reply(req, req->conn, -err);
+
+	dbus_connection_unref(req->conn);
+
+	g_free(req);
+}
+
 static DBusMessage *reconfigure(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
+	struct media_transport *transport = data;
 	DBusMessageIter iter;
 	const char *endpoint;
+	struct media_request *req;
 
 	if (!dbus_message_iter_init(msg, &iter))
 		return btd_error_invalid_args(msg);
@@ -849,6 +963,9 @@ static DBusMessage *reconfigure(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	dbus_message_iter_get_basic(&iter, &endpoint);
 
+	req = media_request_create(msg, 0);
+	req->conn = dbus_connection_ref(conn);
+	media_transport_reconfigure(transport->session, endpoint, req);
 
 	return NULL;
 }
-- 
1.7.5.4

