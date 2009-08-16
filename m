Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	=?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH] Add support for the source interface to audio IPC.
Date: Sat, 15 Aug 2009 23:44:12 -0300
Message-Id: <1250390653-476-1-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/unix.c |   55 +++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/audio/unix.c b/audio/unix.c
index 3fad129..23e2382 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -168,21 +168,28 @@ static void unix_ipc_error(struct unix_client *client, uint8_t name, int err)
 
 	rsp->posix_errno = err;
 
+	debug("sending error %s(%d)", strerror(err), err);
 	unix_ipc_sendmsg(client, &rsp->h);
 }
 
 static service_type_t select_service(struct audio_device *dev, const char *interface)
 {
 	if (!interface) {
-		if (dev->sink && avdtp_is_connected(&dev->src, &dev->dst))
+		if (dev->source && avdtp_is_connected(&dev->src, &dev->dst))
+			return TYPE_SOURCE;
+		else if (dev->sink && avdtp_is_connected(&dev->src, &dev->dst))
 			return TYPE_SINK;
 		else if (dev->headset && headset_is_active(dev))
 			return TYPE_HEADSET;
+		else if (dev->source)
+			return TYPE_SOURCE;
 		else if (dev->sink)
 			return TYPE_SINK;
 		else if (dev->headset)
 			return TYPE_HEADSET;
-	} else if (!strcmp(interface, AUDIO_SINK_INTERFACE) && dev->sink)
+	} else if (!strcmp(interface, AUDIO_SOURCE_INTERFACE) && dev->source)
+		return TYPE_SOURCE;
+	else if (!strcmp(interface, AUDIO_SINK_INTERFACE) && dev->sink)
 		return TYPE_SINK;
 	else if (!strcmp(interface, AUDIO_HEADSET_INTERFACE) && dev->headset)
 		return TYPE_HEADSET;
@@ -487,6 +494,7 @@ static void print_sbc(struct sbc_codec_cap *sbc)
 static int a2dp_append_codec(struct bt_get_capabilities_rsp *rsp,
 				struct avdtp_service_capability *cap,
 				uint8_t seid,
+				uint8_t type,
 				uint8_t configured,
 				uint8_t lock)
 {
@@ -518,7 +526,10 @@ static int a2dp_append_codec(struct bt_get_capabilities_rsp *rsp,
 		sbc->max_bitpool = sbc_cap->max_bitpool;
 
 		print_sbc(sbc_cap);
-		codec->type = BT_A2DP_SBC_SINK;
+		if (type == AVDTP_SEP_TYPE_SINK)
+			codec->type = BT_A2DP_SBC_SINK;
+		else if (type == AVDTP_SEP_TYPE_SOURCE)
+			codec->type = BT_A2DP_SBC_SOURCE;
 	} else if (codec_cap->media_codec_type == A2DP_CODEC_MPEG12) {
 		struct mpeg_codec_cap *mpeg_cap = (void *) codec_cap;
 		mpeg_capabilities_t *mpeg = (void *) codec;
@@ -536,7 +547,10 @@ static int a2dp_append_codec(struct bt_get_capabilities_rsp *rsp,
 		mpeg->bitrate = mpeg_cap->bitrate;
 
 		print_mpeg12(mpeg_cap);
-		codec->type = BT_A2DP_MPEG12_SINK;
+		if (type == AVDTP_SEP_TYPE_SINK)
+			codec->type = BT_A2DP_MPEG12_SINK;
+		else if (type == AVDTP_SEP_TYPE_SOURCE)
+			codec->type = BT_A2DP_MPEG12_SOURCE;
 	} else {
 		size_t codec_length, type_length, total_length;
 
@@ -553,7 +567,10 @@ static int a2dp_append_codec(struct bt_get_capabilities_rsp *rsp,
 		memcpy(codec->data, &codec_cap->media_codec_type, type_length);
 		memcpy(codec->data + type_length, codec_cap->data,
 			codec_length);
-		codec->type = BT_A2DP_UNKNOWN_SINK;
+		if (type == AVDTP_SEP_TYPE_SINK)
+			codec->type = BT_A2DP_UNKNOWN_SINK;
+		else if (type == AVDTP_SEP_TYPE_SOURCE)
+			codec->type = BT_A2DP_UNKNOWN_SOURCE;
 	}
 
 	codec->seid = seid;
@@ -606,7 +623,8 @@ static void a2dp_discovery_complete(struct avdtp *session, GSList *seps,
 
 		type = avdtp_get_type(rsep);
 
-		if (type != AVDTP_SEP_TYPE_SINK)
+		if (type != AVDTP_SEP_TYPE_SINK &&
+			type != AVDTP_SEP_TYPE_SOURCE)
 			continue;
 
 		cap = avdtp_get_codec(rsep);
@@ -641,7 +659,7 @@ static void a2dp_discovery_complete(struct avdtp *session, GSList *seps,
 		if (sep && a2dp_sep_get_lock(sep))
 			lock = BT_WRITE_LOCK;
 
-		a2dp_append_codec(rsp, cap, seid, configured, lock);
+		a2dp_append_codec(rsp, cap, seid, type, configured, lock);
 	}
 
 	unix_ipc_sendmsg(client, &rsp->h);
@@ -819,6 +837,7 @@ static void start_discovery(struct audio_device *dev, struct unix_client *client
 
 	switch (client->type) {
 	case TYPE_SINK:
+	case TYPE_SOURCE:
 		a2dp = &client->d.a2dp;
 
 		if (!a2dp->session)
@@ -1252,10 +1271,12 @@ static void handle_getcapabilities_req(struct unix_client *client,
 		dev = manager_find_device(req->object, &src, &dst,
 					client->interface, FALSE);
 
-	if (!dev && req->transport == BT_CAPABILITIES_TRANSPORT_SCO) {
+	if (!dev) {
 		g_free(client->interface);
-		client->interface = g_strdup(AUDIO_GATEWAY_INTERFACE);
-
+		if (req->transport == BT_CAPABILITIES_TRANSPORT_SCO)
+			client->interface = g_strdup(AUDIO_GATEWAY_INTERFACE);
+		else if (req->transport == BT_CAPABILITIES_TRANSPORT_A2DP)
+			client->interface = g_strdup(AUDIO_SOURCE_INTERFACE);
 		dev = manager_find_device(req->object, &src, &dst,
 				client->interface, TRUE);
 		if (!dev && (req->flags & BT_FLAG_AUTOCONNECT))
@@ -1305,8 +1326,10 @@ static int handle_sco_open(struct unix_client *client, struct bt_open_req *req)
 static int handle_a2dp_open(struct unix_client *client, struct bt_open_req *req)
 {
 	if (!client->interface)
+		/* FIXME: are we treating a sink or a source? */
 		client->interface = g_strdup(AUDIO_SINK_INTERFACE);
-	else if (!g_str_equal(client->interface, AUDIO_SINK_INTERFACE))
+	else if (!g_str_equal(client->interface, AUDIO_SINK_INTERFACE) &&
+			!g_str_equal(client->interface, AUDIO_SOURCE_INTERFACE))
 		return -EIO;
 
 	debug("open a2dp - object=%s source=%s destination=%s lock=%s%s",
@@ -1398,8 +1421,10 @@ static int handle_a2dp_transport(struct unix_client *client,
 	struct mpeg_codec_cap mpeg_cap;
 
 	if (!client->interface)
+		/* FIXME: are we treating a sink or a source? */
 		client->interface = g_strdup(AUDIO_SINK_INTERFACE);
-	else if (!g_str_equal(client->interface, AUDIO_SINK_INTERFACE))
+	else if (!g_str_equal(client->interface, AUDIO_SINK_INTERFACE) &&
+			!g_str_equal(client->interface, AUDIO_SOURCE_INTERFACE))
 		return -EIO;
 
 	if (client->caps) {
@@ -1413,7 +1438,8 @@ static int handle_a2dp_transport(struct unix_client *client,
 
 	client->caps = g_slist_append(client->caps, media_transport);
 
-	if (req->codec.type == BT_A2DP_MPEG12_SINK) {
+	if (req->codec.type == BT_A2DP_MPEG12_SINK ||
+		req->codec.type == BT_A2DP_MPEG12_SOURCE) {
 		mpeg_capabilities_t *mpeg = (void *) &req->codec;
 
 		memset(&mpeg_cap, 0, sizeof(mpeg_cap));
@@ -1431,7 +1457,8 @@ static int handle_a2dp_transport(struct unix_client *client,
 							sizeof(mpeg_cap));
 
 		print_mpeg12(&mpeg_cap);
-	} else if (req->codec.type == BT_A2DP_SBC_SINK) {
+	} else if (req->codec.type == BT_A2DP_SBC_SINK ||
+			req->codec.type == BT_A2DP_SBC_SOURCE) {
 		sbc_capabilities_t *sbc = (void *) &req->codec;
 
 		memset(&sbc_cap, 0, sizeof(sbc_cap));
-- 
1.6.0.4

