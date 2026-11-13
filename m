Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587885;
	b=wZ8VmWwNSieWdH5iR9Q7m5ica8Jf1nPT0ij6ZxxdmgVYR/fasKgjuMcYYTBXk703MNp6
	 MaQ6OrU+bHq63ViHs80q+izoL+b6QH/G4cq4lc5OsodDUCoP18BVZU9Dgvqwb/gzHRK9m
	 lgBj+ESlP4P52GAACH75YPFA3mo3kCRsmTpl0Lvne7rL7GZrBQ1Jy9j97UYttamXhnMfT
	 qbL3mg4WG5IZ3y2S8bR3BVTSjW3Js78/4Xptn4uvO7tNK1YH1Qkn6vpgfdBM1rJ0aZXYS
	 VkKWpvzqtPMt5Qln2dcHlQVb+scrkvvZM2bEsLHyAoypJmzmc52u5S1BrIufp6AUHpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IjZ4aRZqzKUB9n64DHSahAStL6N1wDOY4lVK6tTjc1U=;
	b=zLpYmY89s9FY04wHT6ZC1YlWJa1Gqt17clUpkakCq+a54cDzaARvSWdsAfIwzfueOwBH
	 UN6Z8b8Y6BN2ImD2ghBim9WBlxRwzje30MI4eEqyFlbOYoIFHL95JbhgikqbI9bK+HxCN
	 u9uxghiaVtoA6CyszodtN2TqgJEPoIByzGmN2+3OKhKRXX0uK5IYP8QuLqEC4+DRf64+X
	 fWcJZx3RTk1KEuez87KJMI8BfZUSWne1W4UIkYCJTz9SS0zP/Adng2wS3P1v0WxOaujSR
	 pUC/nqK7y57kv1YIIMC8Rk7LG7hz3fAnQ6x4a3OrggfwZLg5KKi0s+y1araIbMrvO1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ayY2gdN4;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35280606A335
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35280606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ayY2gdN4
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eafaeb8684so335376e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 08:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587884; x=1795192684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IjZ4aRZqzKUB9n64DHSahAStL6N1wDOY4lVK6tTjc1U=;
        b=ayY2gdN4xjxJst5byNB034BYHiaA2CEcs8sVUvehVUL4U4tuInJx5uTkx1c6optNvL
         I7ChpOP9RHUnrRz7O+HRsbjXoH3lFwcvipwYNi7LWI6U4EzpTvObozXnsF2kKQP8aR6q
         wQdgEprPUvwglwGhsr5JaJ3T0WPr5O42nIqrGYJknF2Sm+zkwg/34m5Vrp2PAZsmoQrI
         ptU47XWGbiXzb25fIPT5Q40NnBGdMieHAebAX9QsInsmVtSqPtEKTmQGKlrvNDzGurIB
         qd5BHOH489BNwrwtyasxgeHR6lRS2N514rTN4ODDO+5cpYoChLZqfBNx1nsJxgLGb6DH
         Jivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587884; x=1795192684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IjZ4aRZqzKUB9n64DHSahAStL6N1wDOY4lVK6tTjc1U=;
        b=0T7Z0Goxc5RheeSNRto1IcHQBBoCytI31NJRQ6WxHQ5hZkcssbPE/O5NCK9NKOw2qx
         bP0Pn5LvkswU9XNLChJlXvxn/GIK13gN0Kq7PndhJpZelsteEgn7mdYHNnY/gnfjpzZ/
         wQpRAVSabUn06vt5DFk6RcY4NwbtqvCkEl6u/MQlH8H5oibASGDeLM9BhGyVim+o+i13
         5KxJijEcYe5iejr73fxvQX6bVn3M/6lBkx6Boop/RYhYyyV6xeX62Yn82qhRZQ/v7Z99
         a2tya36fZ3GjpdJw9wDvfeGJ0D2amCZKxuPlO/YCwjDLxJ5Rhux0LiQRD5enRXP1g17U
         PW3A==
X-Gm-Message-State: APuU4Z8SBlE7KAMCKptzCgV/o/50np//ZEgYGmD+wdI5N+xm68nL+NJT
	MuRcjHbFf50hKez+Swlb4/YaOBRsIxz7HBc3UpolAEoHXn1xxrh9PEXE4p9ELpiLoyE=
X-Gm-Gg: AYBFou2cX0dRwdkryAs7wvDEYRJ01IKV9OZ2ztdg4UgZmFDzra4NlmwVIS8Dto4cHlP
	VsVlEzk3SVkxv6l3wKErbmMLdfytx7GFDiRZlCqu1A0IcuWEXVPt58qCxWCxHASiux+wRD7ZsZF
	fsWLCdVM1CVRjYi0zcninIBV/XpkL2elQpgku6BqLnSnPrVuDmLCDko2uisr7VnmLbG+ACmS4rn
	VM6xl+SWo5iFIGRKDVMfetcZYYRUaTGzeI5M5DWisMaLXNtSEjGv6GVdRb7BzHpjjdeDG6j6cJJ
	pCV7AzFwN76bu2CWiRjDDLG0EPrOtHtPoN1Nwgga85o/NwSC2ijkVjMdCJ6waROexNVwDWQa7qO
	G1LfiQ+R8Pe27aWyEebW4W2oAj3SItpXSpPN52PXKSvVUt6i2EDNNhoA8m51AZ/NCsD4JyJZ/r8
	dlQvZZHi97CmrJHbD68HoAAQHzYv4oYosMff2r4J/kLieW+ISoaAqpgyPX2RufbBzTVhw2IJ8C3
	1CtnE5lqJCGmwMgozBxw/QAtSjAhWSWLgMJasw41fKlBR99UNZj3QbS7F6wdQSRH20fIiywQeVU
	SQ72lU3dg8R/sjV06Ac1ohvk8e5PT57uwjJ5PS4dmHDI6t1+UnJdfcwFdDwEYyYHBy8SM6Qf1/1
	HOqket4Z6xg0PlEvOawQMdOYkzy7Jd1Dg+L99VGuOspDItMcWakA3aCIGreJr38btJgVAI3wjti
	UEdjA=
X-Received: by 2002:a05:6122:3127:b0:5ea:bfba:f540 with SMTP id 71dfb90a1353d-5ee346585d4mr1038538e0c.1.1794587883906;
        Fri, 13 Nov 2026 08:38:03 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c842ac652sm1746701241.10.2026.11.13.08.38.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:38:03 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 3/6] bap: Release cached ASEs on ClearConfiguration of an endpoint
Date: Fri, 13 Nov 2026 11:37:55 -0500
Message-ID: <a148977c379916405142e718c76d402353c411bc.1794586887.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794586887.git.luiz.von.dentz@intel.com>
References: <cover.1794586887.git.luiz.von.dentz@intel.com>
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
 profiles/audio/bap.c | 221 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 212 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a0e0ba60d817..457ba5de8fd0 100644
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
@@ -1035,8 +1041,187 @@ static void ep_close_setup(void *data, void *user_data)
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
+#define CACHED_RELEASE_TIMEOUT	10
+
+/* A ClearConfiguration waiting for a cached ASE to leave Releasing */
+struct cached_release {
+	struct bap_data *data;
+	struct bt_bap_stream *stream;
+	struct ep_close_data *epdata;
+	unsigned int timer;
+	int refs;
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
+static bool match_cached_release(const void *data, const void *match_data)
+{
+	const struct cached_release *cr = data;
+
+	return cr->stream == match_data;
+}
+
+static void cached_release_timer_destroy(void *user_data)
+{
+	struct cached_release *cr = user_data;
+
+	cr->timer = 0;
+	cached_release_unref(cr);
+}
+
+static void bap_cached_release_finish(struct bap_data *data,
+					struct bt_bap_stream *stream, int err)
+{
+	struct cached_release *cr;
+
+	/* A server may keep the codec configuration of the ASE when released,
+	 * moving it back to Codec Configured instead of Idle, which can't be
+	 * cleared, so it is done once the ASE has left Releasing either way.
+	 * All the ClearConfiguration waiting for the stream are completed
+	 * with the same result.
+	 */
+	while ((cr = queue_remove_if(data->cached_releases,
+					match_cached_release, stream))) {
+		/* The request may outlive the queue */
+		cr->data = NULL;
+
+		if (cr->timer)
+			g_source_remove(cr->timer);
+
+		if (err)
+			cr->epdata->err = err;
+
+		ep_close_setup_cb(NULL, cr->epdata);
+		cached_release_unref(cr);
+	}
+}
+
+static gboolean cached_release_timeout(gpointer user_data)
+{
+	struct cached_release *cr = user_data;
+
+	/* The source is removed by returning, so don't remove it again */
+	cr->timer = 0;
+
+	if (cr->data) {
+		DBG("stream %p", cr->stream);
+		bap_cached_release_finish(cr->data, cr->stream, -ETIMEDOUT);
+	}
+
+	return FALSE;
+}
+
+static void bap_cached_release_done(struct bap_data *data,
+					struct bt_bap_stream *stream)
+{
+	bap_cached_release_finish(data, stream, 0);
+}
+
+static void cached_release_cancel(void *data)
+{
+	struct cached_release *cr = data;
+
+	cr->data = NULL;
+
+	if (cr->timer)
+		g_source_remove(cr->timer);
+
+	cr->epdata->err = -ECANCELED;
+	ep_close_setup_cb(NULL, cr->epdata);
+	cached_release_unref(cr);
+}
+
+static void ep_release_cached_cb(struct bt_bap_stream *stream, uint8_t code,
+					uint8_t reason, void *user_data)
+{
+	struct cached_release *cr = user_data;
+
+	/* The ASE leaves Releasing once notified, which completes the release,
+	 * so only a failure completes it here, or an ASE still in Codec
+	 * Configured, as the shared layer calls it when the notification
+	 * didn't come in time.
+	 */
+	if (cr->data && (code != BT_ASCS_RSP_SUCCESS ||
+			bt_bap_stream_get_state(stream) ==
+					BT_BAP_STREAM_STATE_CONFIG))
+		bap_cached_release_finish(cr->data, stream,
+				code != BT_ASCS_RSP_SUCCESS ? -EIO :
+				-ETIMEDOUT);
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
+	if (bt_bap_stream_get_rpac(stream) != ep->rpac ||
+			bap_find_setup_by_stream(ep->data, stream))
+		return;
+
+	/* Wait for an earlier release as well instead of releasing again,
+	 * also when the ASE is already Releasing.
+	 */
+	pending = queue_find(ep->data->cached_releases, match_cached_release,
+								stream);
+
+	/* The server may have cached the codec configuration of a released
+	 * ASE, which has no setup anymore, so release it again.
+	 */
+	if (!pending && bt_bap_stream_get_state(stream) !=
+					BT_BAP_STREAM_STATE_CONFIG)
+		return;
+
+	DBG("stream %p", stream);
+
+	cr = new0(struct cached_release, 1);
+	cr->data = ep->data;
+	cr->stream = stream;
+	cr->epdata = data->epdata;
+	cr->refs = 1;
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
+	/* One reference for the request, and one for the timer */
+	cr->refs += 2;
+	cr->timer = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT,
+				CACHED_RELEASE_TIMEOUT, cached_release_timeout,
+				cr, cached_release_timer_destroy);
+
+	if (!bt_bap_stream_release(stream, ep_release_cached_cb, cr)) {
+		cr->refs--;
+		bap_cached_release_finish(ep->data, stream, -EIO);
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
 
@@ -1051,6 +1236,15 @@ static void ep_close(struct bap_ep *ep, const char *transport_path,
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
@@ -1302,14 +1496,16 @@ struct clear_configuration_data {
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
@@ -1338,7 +1534,8 @@ static DBusMessage *clear_configuration(DBusConnection *conn, DBusMessage *msg,
 	cbdata->all = (path == NULL);
 
 	DBG("%p %s %s", cbdata, ep->path, path ? path : "NULL");
-	ep_close(ep, path, clear_configuration_cb, cbdata);
+
+	ep_close(ep, path, !path, clear_configuration_cb, cbdata);
 	return NULL;
 }
 
@@ -1403,7 +1600,7 @@ static void reconfigure_select_cb(int err, void *user_data)
 	free(data);
 }
 
-static void reconfigure_close_cb(int count, void *user_data)
+static void reconfigure_close_cb(int count, int err, void *user_data)
 {
 	struct reconfigure_data *data = user_data;
 
@@ -1424,7 +1621,7 @@ static void ep_close_if_reconfigure(void *obj, void *user_data)
 
 	if (ep->reconfigure) {
 		data->remaining++;
-		ep_close(ep, NULL, reconfigure_close_cb, data);
+		ep_close(ep, NULL, false, reconfigure_close_cb, data);
 	}
 }
 
@@ -1464,7 +1661,7 @@ static DBusMessage *reconfigure(DBusConnection *conn, DBusMessage *msg,
 	queue_foreach(data->snks, ep_close_if_reconfigure, cbdata);
 	queue_foreach(data->srcs, ep_close_if_reconfigure, cbdata);
 
-	reconfigure_close_cb(0, cbdata);
+	reconfigure_close_cb(0, 0, cbdata);
 	return NULL;
 }
 
@@ -3015,6 +3212,9 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 	if (new_state == old_state && new_state != BT_BAP_STREAM_STATE_CONFIG)
 		return;
 
+	if (old_state == BT_BAP_STREAM_STATE_RELEASING)
+		bap_cached_release_done(data, stream);
+
 	setup = bap_find_setup_by_stream(data, stream);
 
 	if (setup && setup->closing) {
@@ -4054,6 +4254,9 @@ static int bap_disconnect(struct btd_service *service)
 	queue_destroy(data->server_streams, NULL);
 	data->server_streams = NULL;
 
+	queue_destroy(data->cached_releases, cached_release_cancel);
+	data->cached_releases = NULL;
+
 	bt_bap_detach(data->bap);
 
 	btd_service_disconnecting_complete(service, 0);
-- 
2.56.0

