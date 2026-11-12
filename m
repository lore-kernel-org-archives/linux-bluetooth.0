Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515868;
	b=FOfW8zWtt5C2fIzkcphB9IvEu/7AaIE3Ht0qMlI12f2RszTOftyXqs2jdUapfz94BLr/
	 ncrv7OS+5lC/Jp3qEIQhGpS1swqzcGmaZPuir0CwlzujLHcLc+xESNS/W2ouqz+UzqXp4
	 7H7Jb2cuzB4i9B5UglkfQKqURNUW7aLMa+y6lpkY0R0dqmAIKXyR6QZeO+BKiHh5ph/Cx
	 9U+q7D8KJmawRIfVxj/EN9VRZx/DDzm/FaCPQAgLSE2ShXi6NoyGGpIsQOaFdD5vxFNNb
	 6mkf7I3GKU40FRVfbXFdUonnrPvMz8C65v//8Y97PZNxajL4U+pS33qmq0mZw37WPYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LE7FegmjcalH+0vwnmXIvCWAxJWzlOY23j4+cBipzH4=;
	b=bUwAKulWj0OBvCkrd0qowhJkY1Xy9WBp4WLBsSBY6HPkk0CvT6CEOBalUu9Gnj15JCGS
	 AOTyGt8kFpHlGwvUMdbUP7sHJvQwXvHFLK4Cw7jOActNdb33hTanWDGjYHHmMrCvKarTH
	 P4cTskS76er79mst4R10ypMP83Jitoi25y3VuGyphOReWghxLtH27ie6BqtMep+hPLr7T
	 7/LwojL5Me5A6nUoYyRCaTr/fHYkjmH5uXXh2Qmesf/KzPc61yZQN3v38HzuAC6UNp0zk
	 9TqoWXIhsccWuMoeDNoowudMninS2Ov2L9jez+ZloxLN5V6pLt0Zg636gkg2TCefVtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N6zK3qNf;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393DC606A331
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 393DC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N6zK3qNf
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ec20398b05so249609e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515867; x=1795120667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LE7FegmjcalH+0vwnmXIvCWAxJWzlOY23j4+cBipzH4=;
        b=N6zK3qNfl/tRHOqZZ5mtx2+M6FMw2wJLiiFY16oUMDNERT77mXga1R6WVL0on6tfoC
         jeJmrDel5fvsg6kt7ixr4xuQAulVq20/ZslEIFcRCq6cH2bIM+8asKZpzZHkcy/UvceR
         6vq8rB9+LpQxK0gtP/V9qgcMxghQw1wDgoZRTdNixgiUTX8CYrQV3XuM7MWaDi8Zfklk
         meZ0h9YFly87vQT7guydCYqYon4K1k/eGqHmbNkH/f84L1LX3bXYnWkAs+PM4jF5mXn5
         hmIVIirwe0gpHfCKvZ9dSV0c+S3EG+UejUNRTDi1Fp6USsND1+K1z0WB5tFb08IQwAvm
         LP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515867; x=1795120667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LE7FegmjcalH+0vwnmXIvCWAxJWzlOY23j4+cBipzH4=;
        b=ueADPDvRYJHaDZQyvwzlHfd5Ms9+T6NaHWMNFJVB0jYO3V7PCpkV0jTKPtVv1RTQTg
         EIeIBRKXBXUkmlXw4IJ15WDShS95H1ojdxd7TfjWmEBBds+TDK0F64XU/+cZTNNZWFsQ
         Ksyj+N1fr0/Wk4s0wbVG+6syN3xWUdA4JdQRrLBOgepn0WuDIil8K6L6UA/dzR2VuZLI
         zUe/v4qlIXGhdG9kNIVpwLobRIulR8sX3gHqrL2oAAqAJ/QtwVGoUkh6Di6LQWnhgfdt
         RcUStGu+WN3gToOxFxgzczG6LdQOmqJsN/GmzLoQKIiIBhrXm23fqy06eZa07+CIT6bu
         0Wqg==
X-Gm-Message-State: APuU4Z8p49NZUHMSlAIoomlTO1ug+E3cp756LRoTlqVZ9/tsguDqrD40
	JQSiZOB0X8B5ZR2d9pbqnqQrs1l+ozYdiargWvEpMCwgOl45lcuiPHZCOITujA==
X-Gm-Gg: AYBFou0WVV2wQMlBieFykH3/+c2isk4mFEvbgtR+Ap3uKwCnqpcTw+GBLczrNMdvGhP
	Dcu4lZgpbTOsDCc9bEiQ2PeVyEekusWj5VQ+L9lKzFIaKYymTenAazJlTKQmI2jhKgrpqCgqyUn
	cmLTs9rY0wq10VEoLYRP1qF+PtZt34SUUY+Z+6jw9Grvyy0K+tX6y1g+B3E+Te2gwWGo86DIHHK
	97b4P150QS/8Stq+G5q5inTbwGufQsFLpsHYmdSNl8noa+Ha+vebCDEZls9EMrrwh0FY+VtYGQk
	zVJmndIRRk+NVu6ziwIVn+Ttzutjs5P9dhLIAN1COA5MmQTs3fDCWljVCkvfcrYZJPVPeQWJ4V7
	a6JWfX1cl2ZBklLuDG5PPg3Ze00MOCGqmfnKcTQHtUyY/ij4NuqixWsAJiMrLsOweI4w+oOCtnS
	QBVILT1oH3jXmRLPrQ9tpud+/G5xHjsMoTAXzomDWiBviSiQx3oNGcowwU74Qbh7b9LtkDguVlA
	cNWOHXjorLj8c/V0rNKoZd+ulFL6FQudQnGzGt5v8inLaTXJi5uzIoupRRYj0ouB2CSep6qSTcC
	e8EqgrTViH14hDSGR73BVItrSqF/7cwRTCOo03fmDeqtt6gFf7yfDfS9AhKPy2oesRTCPnSY70x
	U0lLN9yL7emD+U4gtZPJ957p1um6KW3hFQI9zVxAip+H8PpKbAyP2EwHcHl4ArQ3kvQGXbFh1tU
	JRpGM=
X-Received: by 2002:a05:6122:62a6:b0:5e5:1be6:e12c with SMTP id 71dfb90a1353d-5ee34adabf7mr113727e0c.21.1794515867076;
        Thu, 12 Nov 2026 12:37:47 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34bff0d2sm145765e0c.0.2026.11.12.12.37.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:37:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 3/6] bap: Release cached ASEs on ClearConfiguration of an endpoint
Date: Thu, 12 Nov 2026 15:37:40 -0500
Message-ID: <b34258fb27e2f1c2337d4aaaa202b10c5b24eb97.1794515788.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794515788.git.luiz.von.dentz@intel.com>
References: <cover.1794515788.git.luiz.von.dentz@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Once a stream is released, the server may cache the codec configuration
of its ASE, leaving it in Codec Configured state, while the setup of
the stream is freed. ClearConfiguration only closed the streams that
have a setup, so it could not release such an ASE anymore.

When ClearConfiguration is given the path of the endpoint, also release
its streams in Codec Configured state that have no setup, as a client
may release an ASE in that state (ASCS Table 3.2, BAP 5.6.6).

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/bap.c | 178 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 169 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a0e0ba60d817..45314b499325 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -46,6 +46,7 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/gatt-server.h"
 #include "src/shared/bap.h"
+#include "src/shared/ascs.h"
 #include "src/shared/tmap.h"
 #include "src/shared/gmap.h"
 
@@ -138,6 +139,7 @@ struct bap_data {
 	struct queue *bcast;
 	struct queue *bcast_snks;
 	struct queue *server_streams;
+	struct queue *cached_releases;
 	GIOChannel *listen_io;
 	bool pa_synced;
 	unsigned int pa_timer;
@@ -149,6 +151,8 @@ struct bap_data {
 
 static struct queue *sessions;
 
+static void cached_release_cancel(void *data);
+
 static int setup_config(struct bap_setup *setup, bap_setup_ready_func_t cb,
 							void *user_data);
 static int bap_select_all(struct bap_data *data, bool reconfigure,
@@ -196,6 +200,7 @@ static void bap_data_free(struct bap_data *data)
 	queue_destroy(data->srcs, ep_unregister);
 	queue_destroy(data->bcast, ep_unregister);
 	queue_destroy(data->server_streams, NULL);
+	queue_destroy(data->cached_releases, cached_release_cancel);
 	data->bcast_snks = NULL;
 	queue_destroy(bcast_snks, setup_free);
 
@@ -996,8 +1001,9 @@ static int setup_close(struct bap_setup *setup, bap_setup_close_func_t cb,
 struct ep_close_data {
 	int remaining;
 	int count;
+	int err;
 	const char *path;
-	void (*cb)(int count, void *user_data);
+	void (*cb)(int count, int err, void *user_data);
 	void *user_data;
 };
 
@@ -1013,7 +1019,7 @@ static void ep_close_setup_cb(struct bap_setup *setup, void *user_data)
 		return;
 
 	if (epdata->cb)
-		epdata->cb(epdata->count, epdata->user_data);
+		epdata->cb(epdata->count, epdata->err, epdata->user_data);
 
 	free(epdata);
 }
@@ -1035,8 +1041,144 @@ static void ep_close_setup(void *data, void *user_data)
 		epdata->count++;
 }
 
+static struct bap_setup *bap_find_setup_by_stream(struct bap_data *data,
+					struct bt_bap_stream *stream);
+
+struct cached_release_data {
+	struct bap_ep *ep;
+	struct ep_close_data *epdata;
+};
+
+/* The release of a cached stream, done once the ASE has left Releasing */
+struct cached_release {
+	struct bap_data *data;
+	struct bt_bap_stream *stream;
+	struct ep_close_data *epdata;
+	int refs;
+	bool done;
+};
+
+static void cached_release_unref(struct cached_release *cr)
+{
+	if (--cr->refs)
+		return;
+
+	free(cr);
+}
+
+static void cached_release_done(struct cached_release *cr, int err)
+{
+	if (cr->done)
+		return;
+
+	cr->done = true;
+
+	if (err)
+		cr->epdata->err = err;
+
+	ep_close_setup_cb(NULL, cr->epdata);
+}
+
+static bool match_cached_release(const void *data, const void *match_data)
+{
+	const struct cached_release *cr = data;
+
+	return cr->stream == match_data;
+}
+
+static void bap_cached_release_done(struct bap_data *data,
+					struct bt_bap_stream *stream)
+{
+	struct cached_release *cr;
+
+	/* A server may keep the codec configuration of the ASE when released,
+	 * moving it back to Codec Configured instead of Idle, which can't be
+	 * cleared, so it is done once the ASE has left Releasing either way.
+	 */
+	while ((cr = queue_remove_if(data->cached_releases,
+					match_cached_release, stream))) {
+		cached_release_done(cr, 0);
+		cached_release_unref(cr);
+	}
+}
+
+static void cached_release_cancel(void *data)
+{
+	struct cached_release *cr = data;
+
+	cr->data = NULL;
+	cached_release_done(cr, -ECANCELED);
+	cached_release_unref(cr);
+}
+
+static void ep_release_cached_cb(struct bt_bap_stream *stream, uint8_t code,
+					uint8_t reason, void *user_data)
+{
+	struct cached_release *cr = user_data;
+
+	/* The ASE leaves Releasing once notified, so only a failure completes
+	 * the release here.
+	 */
+	if (code != BT_ASCS_RSP_SUCCESS) {
+		if (cr->data && queue_remove(cr->data->cached_releases, cr))
+			cached_release_unref(cr);
+
+		cached_release_done(cr, -EIO);
+	}
+
+	cached_release_unref(cr);
+}
+
+static void ep_release_cached(struct bt_bap_stream *stream, void *user_data)
+{
+	struct cached_release_data *data = user_data;
+	struct bap_ep *ep = data->ep;
+	struct cached_release *cr, *pending;
+
+	/* The server may have cached the codec configuration of a released
+	 * ASE, which has no setup anymore, so release it again.
+	 */
+	if (bt_bap_stream_get_rpac(stream) != ep->rpac ||
+			bt_bap_stream_get_state(stream) !=
+					BT_BAP_STREAM_STATE_CONFIG ||
+			bap_find_setup_by_stream(ep->data, stream))
+		return;
+
+	DBG("stream %p", stream);
+
+	/* Don't release it again while an earlier release is pending, just
+	 * wait for it as well.
+	 */
+	pending = queue_find(ep->data->cached_releases, match_cached_release,
+								stream);
+
+	cr = new0(struct cached_release, 1);
+	cr->data = ep->data;
+	cr->stream = stream;
+	cr->epdata = data->epdata;
+	cr->refs = pending ? 1 : 2;
+
+	data->epdata->remaining++;
+
+	if (!ep->data->cached_releases)
+		ep->data->cached_releases = queue_new();
+
+	queue_push_tail(ep->data->cached_releases, cr);
+
+	if (pending)
+		return;
+
+	if (!bt_bap_stream_release(stream, ep_release_cached_cb, cr)) {
+		queue_remove(ep->data->cached_releases, cr);
+		data->epdata->remaining--;
+		free(cr);
+	}
+}
+
 static void ep_close(struct bap_ep *ep, const char *transport_path,
-			void (*cb)(int count, void *user_data), void *user_data)
+			bool cached,
+			void (*cb)(int count, int err, void *user_data),
+			void *user_data)
 {
 	struct ep_close_data *epdata;
 
@@ -1051,6 +1193,15 @@ static void ep_close(struct bap_ep *ep, const char *transport_path,
 	if (ep)
 		queue_foreach(ep->setups, ep_close_setup, epdata);
 
+	/* The cached streams have to be released before replying, as an ASE
+	 * still being released can't be configured again.
+	 */
+	if (cached && ep && ep->rpac) {
+		struct cached_release_data data = { ep, epdata };
+
+		bt_bap_foreach_stream(ep->data->bap, ep_release_cached, &data);
+	}
+
 	epdata->path = NULL;
 	ep_close_setup_cb(NULL, epdata);
 }
@@ -1302,14 +1453,16 @@ struct clear_configuration_data {
 	bool all;
 };
 
-static void clear_configuration_cb(int count, void *user_data)
+static void clear_configuration_cb(int count, int err, void *user_data)
 {
 	struct clear_configuration_data *data = user_data;
 	DBusMessage *reply;
 
 	DBG("%p", data);
 
-	if (!data->all && count == 0)
+	if (err)
+		reply = btd_error_failed(data->msg, strerror(-err));
+	else if (!data->all && count == 0)
 		reply = btd_error_invalid_args(data->msg);
 	else
 		reply = dbus_message_new_method_return(data->msg);
@@ -1338,7 +1491,8 @@ static DBusMessage *clear_configuration(DBusConnection *conn, DBusMessage *msg,
 	cbdata->all = (path == NULL);
 
 	DBG("%p %s %s", cbdata, ep->path, path ? path : "NULL");
-	ep_close(ep, path, clear_configuration_cb, cbdata);
+
+	ep_close(ep, path, !path, clear_configuration_cb, cbdata);
 	return NULL;
 }
 
@@ -1403,7 +1557,7 @@ static void reconfigure_select_cb(int err, void *user_data)
 	free(data);
 }
 
-static void reconfigure_close_cb(int count, void *user_data)
+static void reconfigure_close_cb(int count, int err, void *user_data)
 {
 	struct reconfigure_data *data = user_data;
 
@@ -1424,7 +1578,7 @@ static void ep_close_if_reconfigure(void *obj, void *user_data)
 
 	if (ep->reconfigure) {
 		data->remaining++;
-		ep_close(ep, NULL, reconfigure_close_cb, data);
+		ep_close(ep, NULL, false, reconfigure_close_cb, data);
 	}
 }
 
@@ -1464,7 +1618,7 @@ static DBusMessage *reconfigure(DBusConnection *conn, DBusMessage *msg,
 	queue_foreach(data->snks, ep_close_if_reconfigure, cbdata);
 	queue_foreach(data->srcs, ep_close_if_reconfigure, cbdata);
 
-	reconfigure_close_cb(0, cbdata);
+	reconfigure_close_cb(0, 0, cbdata);
 	return NULL;
 }
 
@@ -3015,6 +3169,9 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 	if (new_state == old_state && new_state != BT_BAP_STREAM_STATE_CONFIG)
 		return;
 
+	if (old_state == BT_BAP_STREAM_STATE_RELEASING)
+		bap_cached_release_done(data, stream);
+
 	setup = bap_find_setup_by_stream(data, stream);
 
 	if (setup && setup->closing) {
@@ -4054,6 +4211,9 @@ static int bap_disconnect(struct btd_service *service)
 	queue_destroy(data->server_streams, NULL);
 	data->server_streams = NULL;
 
+	queue_destroy(data->cached_releases, cached_release_cancel);
+	data->cached_releases = NULL;
+
 	bt_bap_detach(data->bap);
 
 	btd_service_disconnecting_complete(service, 0);
-- 
2.56.0

