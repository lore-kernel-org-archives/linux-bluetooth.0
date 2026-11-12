Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515618;
	b=q4JdbOHdTwGWiuAPIg0j1kcbZSTzpVil17FDyBHZEV+aNHZ0u0FzKGMeYTTVpiJrFden
	 98OpYlrwHcD6zqN3DIWdtpteVwa4GQcY7sRZCr7HVYlTnrqnK8IEH2hi5oK1Xy4GYj0MX
	 RxzU7JznOTbgcrDHxYK4TAJF1QuSPHgN4TEN1odvlO1o5RW7I4Aj7TNRw8jnJHf5TnhCO
	 THgvXxvcyDjchPKZuiMhDFg/EcrVv4izMCUmYYKU++Fmkc1aq4ppyH4/9N+zQgKFsnrkB
	 d1i2EO9vyHz6Hvif3uN1Qn6685WcTjGHquiYKVk+7sAiqbDNtM0+MlPOFoUOF8w4WtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LE7FegmjcalH+0vwnmXIvCWAxJWzlOY23j4+cBipzH4=;
	b=zeTn3UFenSiAzQG0qhKQxYfbXNWTqvmzBkCgnJZtF8eAy1VGBo+2+yq8DIF8NCFD/d9y
	 AK8adG/U5rTzmKNzigq52Q9VX54/7g5OfdEWb7192BoZsaRwiCa8H3Gwfx9ZYfRFkCVKC
	 s3A8bkFmtV9HVllh54G+j/GyJwYyWeH92SKMGgk+01DFYi6Ipy9F9FRu4UB6XvTiNKimy
	 G6T6JaJVMc6R4xJBgbp6PDpLwReQ+KN19/4dfKo/ccZ8VyOfqrzmU/E7Pk+Xv/7baxQeI
	 MwDbONGskEasc5Z6BUUEwIzzLkMuIwVIqvY+1WetZ4GNfurdGo1T2lna/cGbG8BgMDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=scfVvq+3;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077E7606A33A
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 077E7606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=scfVvq+3
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9908c849564so90603241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515617; x=1795120417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LE7FegmjcalH+0vwnmXIvCWAxJWzlOY23j4+cBipzH4=;
        b=scfVvq+30IAPzLC7sMeCZrSjj6S6WuH+fOwKWbSSJOClgFacqwjJ8YC2VljgqIjg2n
         EzR7ljqsNx7fZqdT4GTB8LyWy3whbbKpD21EJlqhhkpve3GE35brK2P+mqwPAXDBvB4p
         CLvI9WlxB+CJuGZtWcpcj85BlOixRWgB+2eF+hwzr+8TV376VYiY7swjUZtuH8n7GHIo
         /P6o7naeOJwJTyv32gfsaVlmyU02ujQlEaiM6JLDZOB83JlqTLP5p1wgdWg+OHZfRNpZ
         4BxPJ8xSfVj5tmwFhfS5wayXui2XVD2Sblsf/C7f0ZPhOcAv/G3avIDrmSh+BzKQqLuZ
         DpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515617; x=1795120417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LE7FegmjcalH+0vwnmXIvCWAxJWzlOY23j4+cBipzH4=;
        b=xeZbHnh1Bbqnrfnt7s67jtXQ9Y9v/M5f85LqEc5Z8zoT2j+VdczFI+sHXdhDSFw4uh
         vO1Hiwmnibb+IPp8CcxQ1cBsTWE43iT9dcbz97rdkll0DxbLy9QlYck6qxtmoBc6oIsw
         HajeXn/YetUabIeqPFaushOPmg32YWEVNTuPCx7la+uYPFCo4jZl0TC5WYPpRfDTRWYu
         Nh9/hBTpi5wkIvwJSJ2lGMwf2OwimfKrn86TdD5PCndLu8nQL6BqRS94abZXJU64dbB5
         ctxiMUTPzDk1Aj7eIcShufEd2hvZ7/oRiJYRpIK52JWa+E3rMHG6qIuN3sGzaarlZBqD
         LgiA==
X-Gm-Message-State: APuU4Z9z9qAYv3ZSA0u+8Df7dkzorLcbXuEZhUd9tDPvFBWRV7pTKZle
	mmkDe6o/EfCvR0cQoHzFEKnrQhFKOkuLB5eq2IYcykVWo+fN2L9PEJ0gdimwVQ==
X-Gm-Gg: AYBFou37530t8JedWr0hhvB9LBAYarMarZl5hN+2dSK5TvM6eRjBTpM7kGBPpBjtusZ
	vZjk1DQgAp53xf5zCFGbCn/EU8lMCayublK7wHCzWDNtILHpDicrqaDK5ciiQmsnYcYjpHexerd
	nW/XFEoBOsUpkxGXgENMce7lI7IrW/pvuhvM3V9UUVeVEcofnhLm/ukE2HkjH+thePMGmAlNEhZ
	BdKiZus8BcwExiR4UNJ2WyQuRDf7+uvRzSoepUGGDsdKR9pZTaIgbDhRfXfC5l6H8+3IJI9RYCG
	J+EqI6/OcOkSfEU6+uOhcuhUAcNj15H0+j4r+xr/JZhwESIzsVt8596E9tTxPhw4E51WZfDhwbg
	HcIKO2tq3K7IQGDfWk3VdPcGQ02qvN1IF+Cxx3m+RffRqMAfnQo+leO0u71PWyouT9TQUPXl5/C
	RxMWxgHXIzf+u+UKctgsV/0vFEJJDZ3osFT5Dy5krvxfgNFyN3cInbmgL+F2HGef+c1peuIm+Jo
	PUHV6NdIoiu/RyNAIwhUJbuwRK3Krrqj9bMt4b2qGYL64JI3ZoScP74bugN1Hip/zX+UKBVAsGP
	Cm3CsMGfjfeZ0WwlL5pUbPSH0AxwiG5BA9+WwHizTXWn6ez0owAXqe/CgILVRbh1Jtl12paTQJk
	FL/tUsqFmBBP5TRURHBpCpSlxEBG6AOItqLh6r3buJz3FIuxQ3bo87kSdKRaYvkbFsuiL6f09On
	SHuOKyCBYM2vK0Wzr/xQCmtNbg
X-Received: by 2002:a05:6102:2c82:b0:7c2:5692:1917 with SMTP id ada2fe7eead31-7d64d69de7fmr108150137.10.1794515616836;
        Thu, 12 Nov 2026 12:33:36 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c842ac652sm346627241.10.2026.11.12.12.33.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:33:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 3/6] bap: Release cached ASEs on ClearConfiguration of an endpoint
Date: Thu, 12 Nov 2026 15:33:29 -0500
Message-ID: <b34258fb27e2f1c2337d4aaaa202b10c5b24eb97.1794515475.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794515475.git.luiz.von.dentz@intel.com>
References: <cover.1794515475.git.luiz.von.dentz@intel.com>
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

