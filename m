Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D96449E130
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342768; cv=none; b=McQgOspAZHVwipiMzp0G28D5ydw3x2XVf4AAZneAx69Q40+p+cif30AFqBbk8zMzGtcwhKBFr7ggyEq7dVeDg5/gnIptRx4QUf/Pu+WYjY5i5qQE5OA5wsKOh/I+Id/mqicTQJIQB1NZhPR3zybkaWMXHC+J1FLi1AT7qA/Abyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342768; c=relaxed/simple;
	bh=RQJrnDTHo5SJuz0MJf3zL4xer+c0SjWHkyLRn73yZqE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beyEL+ZwtNwXmIi/0MM1ob1nYc3t1nUnRIjASvdHwPMSi7JwWRCa9IZ8UoYZiONsTvVXYMjX5pc/mWX7/HqlMVZVkc4RaGbKJ3ZsRzpvGB3qmX9VMA9JDwT08K4R2w4sKFLayhW8CgeELuezvA9/AiIYUTtYnp8tb1nOTirABUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KIVP3xc4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KIVP3xc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790342739;
	bh=RQJrnDTHo5SJuz0MJf3zL4xer+c0SjWHkyLRn73yZqE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KIVP3xc4eq9wsGZGo6cmu33zxqqWsw2UBX5U1TG/c96mHJWedB64WcrA9JTChobLO
	 7/avNokCayVHjTmjILdzRzJAo5WVUqC/pKyVImDiSrm4y5Pq4Y+nBBTUl4Y5lie/RB
	 bnW9l82DqGEcq/mxBeBImj7vN9zdl34yrJfJ/TBX2QDgrXQdY5U3miqmWEk9SnGklg
	 bGXR3uM4c2TbjHdjNtHDl325E2wPFg1oHtHU4ZHfU6RDY5JWoWmwtjCGKWp8fWBH/X
	 Z3eK3uPo7mIwxwGM+uYzk/SM+/3QSItwpz8jFV6sCWIGoz9oAYoX+zcyIcfS2pJeiw
	 u8SDBsmP1R26w==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4310617E12A1
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:25:39 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/12] audio/hfp-hf: Add codecs support
Date: Fri, 25 Sep 2026 15:25:28 +0200
Message-ID: <20260925132528.3361517-13-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925132528.3361517-1-frederic.danis@collabora.com>
References: <20260925132528.3361517-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis.oss@gmail.com>

---
 profiles/audio/hfp-hf.c | 171 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 152 insertions(+), 19 deletions(-)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 25dce517f..4e626653d 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -65,11 +65,19 @@
 
 #define HFP_HF_SDP_FEATURES	(HFP_HF_SDP_ECNR | HFP_HF_SDP_3WAY |\
 				HFP_HF_SDP_CLIP |\
-				HFP_HF_SDP_REMOTE_VOLUME_CONTROL)
+				HFP_HF_SDP_REMOTE_VOLUME_CONTROL |\
+				HFP_HF_SDP_WIDE_BAND_SPEECH |\
+				HFP_HF_SDP_SUPER_WIDE_BAND_SPEECH)
 
 #define URI	"tel"
 #define URI_PREFIX	URI ":"
 
+struct connect_data {
+	struct hfp_device *dev;
+	void (*cb)(int status, void *data);
+	void *cb_user_data;
+};
+
 struct hfp_device {
 	struct telephony	*telephony;
 	uint16_t		version;
@@ -81,6 +89,7 @@ struct hfp_device {
 	struct queue		*calls;
 	uint8_t			codec;
 	unsigned int		resume_id;
+	struct connect_data	*pending_connect;
 	hfp_hf_sco_closed_cb	sco_closed_cb;
 	void			*sco_closed_data;
 };
@@ -169,6 +178,20 @@ static bool call_id_cmp(const void *data, const void *match_data)
 	return call->idx == id;
 }
 
+static void sco_connect_complete(struct connect_data *connect_data, int status)
+{
+	if (!connect_data)
+		return;
+
+	if (connect_data->dev->pending_connect == connect_data)
+		connect_data->dev->pending_connect = NULL;
+
+	if (connect_data->cb)
+		connect_data->cb(status, connect_data->cb_user_data);
+
+	g_free(connect_data);
+}
+
 static void device_destroy(struct hfp_device *dev)
 {
 	struct hfp_server *server;
@@ -177,6 +200,9 @@ static void device_destroy(struct hfp_device *dev)
 
 	telephony_set_state(dev->telephony, DISCONNECTING);
 
+	if (dev->pending_connect)
+		sco_connect_complete(dev->pending_connect, -ENOTCONN);
+
 	if (dev->hf) {
 		hfp_hf_unref(dev->hf);
 		dev->hf = NULL;
@@ -329,6 +355,49 @@ static void hfp_hf_call_line_id_updated(uint id, const char *number,
 	telephony_call_set_line_id(call, number);
 }
 
+static uint8_t hfp_hf_get_codecs(uint8_t *codecs, uint8_t max_codecs,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	struct btd_adapter *adapter;
+	struct hfp_server *server;
+	GSList *l;
+	uint8_t i = 0;
+
+	adapter = device_get_adapter(telephony_get_device(dev->telephony));
+	server = find_server(servers, adapter);
+
+	for (l = server->endpoints; l; l = l->next) {
+		codecs[i++] = media_endpoint_get_codec(l->data);
+		if (i >= max_codecs)
+			break;
+	}
+
+	return i;
+}
+
+static bool hfp_hf_select_codec(uint8_t codec, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	struct btd_adapter *adapter;
+	struct hfp_server *server;
+	GSList *l;
+
+	DBG("Selecting codec: %u", codec);
+	adapter = device_get_adapter(telephony_get_device(dev->telephony));
+	server = find_server(servers, adapter);
+
+	for (l = server->endpoints; l; l = l->next) {
+		if (media_endpoint_get_codec(l->data) == codec) {
+			dev->codec = codec;
+			return true;
+		}
+	}
+
+	DBG("Unsupported codec: %u", codec);
+	return false;
+}
+
 static struct hfp_hf_callbacks hf_session_callbacks = {
 	.session_ready = hfp_hf_session_ready_cb,
 	.update_indicator = hfp_hf_update_indicator,
@@ -338,6 +407,8 @@ static struct hfp_hf_callbacks hf_session_callbacks = {
 	.call_removed = hfp_hf_call_removed,
 	.call_status_updated = hfp_hf_call_status_updated,
 	.call_line_id_updated = hfp_hf_call_line_id_updated,
+	.get_codecs = hfp_hf_get_codecs,
+	.select_codec = hfp_hf_select_codec,
 };
 
 static void hfp_disconnect_watch(void *user_data)
@@ -991,23 +1062,6 @@ static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond, void *data)
 	return FALSE;
 }
 
-struct connect_data {
-	struct hfp_device *dev;
-	void (*cb)(int status, void *data);
-	void *cb_user_data;
-};
-
-static void sco_connect_complete(struct connect_data *connect_data, int status)
-{
-	if (!connect_data || !connect_data->cb)
-		goto done;
-
-	connect_data->cb(status, connect_data->cb_user_data);
-
-done:
-	g_free(connect_data);
-}
-
 static void sco_connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct connect_data *connect_data = user_data;
@@ -1109,6 +1163,62 @@ static void sco_connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	sco_connect_complete(connect_data, 0);
 }
 
+static void confirm_cb(GIOChannel *io, gpointer user_data)
+{
+	bdaddr_t src, dst;
+	char address[18];
+	struct btd_device *device;
+	struct btd_service *service;
+	struct hfp_device *dev = NULL;
+	int voice;
+	GError *err = NULL;
+
+	if (!bt_io_get(io, &err,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_INVALID)) {
+		error("Unable to get destination address: %s", err->message);
+		g_clear_error(&err);
+		goto drop;
+	}
+
+	DBG("Incoming SCO connection from %s", address);
+
+	device = btd_adapter_find_device(adapter_find(&src), &dst,
+								BDADDR_BREDR);
+	if (!device)
+		goto drop;
+
+	service = btd_device_get_service(device, HFP_AG_UUID);
+	if (!service)
+		goto drop;
+
+	dev = btd_service_get_user_data(service);
+	voice = dev->codec == 1 ? BT_VOICE_CVSD_16BIT : BT_VOICE_TRANSPARENT;
+
+	if (!bt_io_set(io, &err, BT_IO_OPT_VOICE, voice, BT_IO_OPT_INVALID)) {
+		error("Could not set voice settings on SCO IO: %s",
+								err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	if (!bt_io_accept(io, sco_connect_cb, dev->pending_connect, NULL,
+								&err)) {
+		error("bt_io_accept() failed: %s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	return;
+
+drop:
+	if (dev && dev->pending_connect)
+		sco_connect_complete(dev->pending_connect, -EIO);
+	g_io_channel_shutdown(io, TRUE, NULL);
+}
+
 bool hfp_hf_sco_listen(struct btd_adapter *adapter, void *endpoint)
 {
 	struct hfp_server *server;
@@ -1126,7 +1236,7 @@ bool hfp_hf_sco_listen(struct btd_adapter *adapter, void *endpoint)
 	if (server->sco_io)
 		return true;
 
-	server->sco_io = bt_io_listen(sco_connect_cb, NULL, NULL, NULL,
+	server->sco_io = bt_io_listen(NULL, confirm_cb, NULL, NULL,
 				&err,
 				BT_IO_OPT_SOURCE_BDADDR,
 				btd_adapter_get_address(server->adapter),
@@ -1190,6 +1300,16 @@ uint16_t hfp_hf_device_get_omtu(struct hfp_device *dev)
 	return dev->omtu;
 }
 
+static void req_codec_connection_complete(enum hfp_result res,
+						enum hfp_error cme_err,
+						void *user_data)
+{
+	struct connect_data *connect_data = user_data;
+
+	if (res != HFP_RESULT_OK)
+		sco_connect_complete(connect_data, -EIO);
+}
+
 static gboolean sco_start_cb(gpointer data)
 {
 	struct connect_data *connect_data = data;
@@ -1211,6 +1331,11 @@ unsigned int hfp_hf_sco_start(struct hfp_device *dev, void *cb, void *user_data)
 
 	DBG("codec %u", dev->codec);
 
+	if (dev->pending_connect) {
+		error("SCO connect already in progress");
+		return 0;
+	}
+
 	connect_data = g_new0(struct connect_data, 1);
 	connect_data->dev = dev;
 	connect_data->cb = cb;
@@ -1219,6 +1344,13 @@ unsigned int hfp_hf_sco_start(struct hfp_device *dev, void *cb, void *user_data)
 	src = telephony_get_src(dev->telephony);
 	dst = telephony_get_dst(dev->telephony);
 	if (!dev->sco_io) {
+		if (hfp_hf_request_codec_connection(dev->hf,
+						req_codec_connection_complete,
+						connect_data)) {
+			dev->pending_connect = connect_data;
+			goto done;
+		}
+
 		io = bt_io_connect(sco_connect_cb, connect_data, NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR, &src,
 			BT_IO_OPT_DEST_BDADDR, &dst,
@@ -1234,6 +1366,7 @@ unsigned int hfp_hf_sco_start(struct hfp_device *dev, void *cb, void *user_data)
 		g_idle_add(sco_start_cb, connect_data);
 	}
 
+done:
 	return (++dev->resume_id);
 }
 
-- 
2.43.0

