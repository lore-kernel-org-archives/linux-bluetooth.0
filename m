Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429475;
	b=w8mmpYBOojhK1DEkbpKD2gK/UPHNxeVCOT6TO49dFhf9Z+d2+JzVPxrxtqK63dIxpEBo
	 oC0rgQrpDvNnwTuoiwSsNJ0ZLD0Q5iFyn75fa6M/lt3UE6SK3f0JLTlXV07G40u1c2YMF
	 mNHzYY3IOlFUT2W4TcnZUReMo1woBT55NY0nNTgW/9YMWKm5r1a8bWfNjsW7S70ovgylI
	 9qmRmPJXEb2UX3PLbiNUCtDyX2RlDd1MS9LwInYrDoD1ciirlVNAnKg86ORFM3XJ1y6R8
	 RAnabZYl9ruBAR6SewoQr0Yq3nL28CJLjt2d2WwMXMm3hOUIB1thB0N6ZbTH+ZBedGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JN+ZFVXsDi5sIenVMFCTWDKq1Y+Vg8c4ZPV7Bgdpehc=;
	b=HXJpUiIqjW90p+HxCRoPTSci8wUltff5opcKj7rmX5Tb/gNiJowYJpgEr1Tj7AZ3jI00
	 vWSdnQRfMHoL1iAic2nGl2oHCpkob5oSRmiar10IJmWYcaxgD+EgV0o7i35OfWs0lJWFf
	 37cphimKlV7iFRmcutlTn84Z94kvpzzNXXxNnrekSUloftMvnpsuoFcqh+gqRSeriUXTv
	 VHHL7PG7ekWGmRjfmeCiT2gIMoLE7zrib39SytN/m/NrLGpesXnRimGDsxQPudqSYim5G
	 UfxcEU5UVs8ZFJhSZYhFuweQNi73Rixabwp0vInkRHPryiPThmVfX2UHcbDk7vJZU/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ktQh+FQw;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35B160A2614
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D35B160A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ktQh+FQw
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7cc1cf48a39so1389267137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429474; x=1795034274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JN+ZFVXsDi5sIenVMFCTWDKq1Y+Vg8c4ZPV7Bgdpehc=;
        b=ktQh+FQw42cTDRu57A9ydfoF4ynAARpVuDif3Ws6QHp3r7TiKE7sTOovn4sxvEaSyc
         tU1vDaASUdqquRDpBifoeH7IO6wGMwSnRb7Gda1wvjrDChBspdxoqv1p3miDwb37M9TI
         IFFKYj9nD3uMmQRVMwfp+aHcd3DbKe7vcEh1tPOa93+WreE2HDnWn1lPbzsrrBp3sWRQ
         0vrC/meW1+BGAVYPf05O1GsUErIhgcFyZHpI8qWWC9Bces+hYg31sOau9UYhbcznBCI+
         83q53sAG5boy1/cbtuQZHq9bnDdJKNry2zcVmVNA2vfWN3s6iZqvCHcO++amJEqPaZG2
         EPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429474; x=1795034274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JN+ZFVXsDi5sIenVMFCTWDKq1Y+Vg8c4ZPV7Bgdpehc=;
        b=QAolKOIfdYKNA8j3GiwntHJ7L0b0ZhmMF/4ccy57N42cR7p5ygYCTm1zt9KMr1DAwD
         jtbxBXdBoh0QGdHnrKb3WccbudrWIF04YKm1oUwEl+zWuZSp9MOLqqkJSdKO4DDiA8ec
         zvSyD9ghJJQOWe6rahB8l5NfKjro/Lln7huiAk8HupHxwZkdggL6pbte40XFFHb7Ejf/
         qlIqdcVirnXXy/ES37frAKK5B8MV6rIHMysFvUodomSz1OMgaAF5+ntd6lUZmvDP9pUf
         26vm+S5Bs9ezIwbf4OZylMlIqzWZvleiFceHOP3BEmOWMclPLV0WJmunEvNRAAuTIRBN
         4Ewg==
X-Gm-Message-State: APuU4Z9pBx6ordqYf1mqrAWCtq4DWr4STe5skBWnszJUQuM37FwCHKwW
	jcV1FzxHF/dhuHw93eE9KW6/nE/tvwDur5tr9AOGcrWAsPSD3NY9jgubGCZ2RA==
X-Gm-Gg: AYBFou1S+UYZQ8D8+Hx+j9PLeltfFlhs0ECTpTBrDyL/BLlHNuN2qEEK/84vcT7QiSs
	U5HAqopCmNhI2kxeV5I8bczUvl48C87eLe09t2CK9L0s9SpAA2EDvlBUPuSvSA496Mh55xm14wa
	Ubfz4rkMDyE5DGwvpZharfSf0LcsJmbZJpq6z6z9wsOW/gVOznpvckJ1FmYUqjHiROB8fDZRZar
	AgjZTJvEN76c+tZ5We0BZ7VncHuX+jNPa1YtLvOTRfFoXuXD27acFgUcaBcAAjAshOPtpYRGWKl
	54b4UZ/FcE6fIb9QSJwdjKvvAVqcRX8imq+oS0FSqb87KijVlPcw1Eg0o8TSUGHUvpo6oHX+hz3
	Khe52SXnF8D5qFmj1Nwyqghkd1SLSO2THOsn6IAtd2Nlpd0dQf4N7wNYV72yQU/KlhzjIssxjb2
	hl/szyOHhOltLcczw/XGh/wBn3U7X5qdMNM5tRFs/9VudMdTHhAXp6zNYWLL0DzkaADHhkXEcuL
	2qncZBEsKq9myRe/ElDq2hNkrUXMTwPTcExpcov+02uh6GQhko4I1EOp1rKW5ifUPnCelQJ6YqH
	pkKar+nxnI6BKeaJRSaI7fpOM1YrvztoU0V6kCNXb6/0g/dUBKf7iBnL63wEjRIgP6KlOAL72QQ
	gox1KLu96tKCYvkF41cf7l7C80mV2m2ORmz8fGo71pwPejlJhn8CRwxJdH2TJ7JphkQtzReQGC1
	lTkWs=
X-Received: by 2002:a05:6102:160b:b0:7cc:174b:f7bc with SMTP id ada2fe7eead31-7d4fb28a79emr1373673137.15.1794429473547;
        Wed, 11 Nov 2026 12:37:53 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:52 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/6] bap: Release cached ASEs on ClearConfiguration of an endpoint
Date: Wed, 11 Nov 2026 15:37:30 -0500
Message-ID: <5f63deb0a9e2a437093a3b98399b5eb70ceebce1.1794428234.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794428234.git.luiz.von.dentz@intel.com>
References: <cover.1794428234.git.luiz.von.dentz@intel.com>
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
 profiles/audio/bap.c | 159 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 150 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a0e0ba60d817..507b910cf8ce 100644
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
@@ -1035,8 +1041,126 @@ static void ep_close_setup(void *data, void *user_data)
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
+/* The release of a cached stream, done once the stream is idle */
+struct cached_release {
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
+static void bap_cached_release_idle(struct bap_data *data,
+					struct bt_bap_stream *stream)
+{
+	struct cached_release *cr;
+
+	cr = queue_remove_if(data->cached_releases, match_cached_release,
+								stream);
+	if (!cr)
+		return;
+
+	cached_release_done(cr, 0);
+	cached_release_unref(cr);
+}
+
+static void cached_release_cancel(void *data)
+{
+	struct cached_release *cr = data;
+
+	cached_release_done(cr, -ECANCELED);
+	cached_release_unref(cr);
+}
+
+static void ep_release_cached_cb(struct bt_bap_stream *stream, uint8_t code,
+					uint8_t reason, void *user_data)
+{
+	struct cached_release *cr = user_data;
+
+	/* The ASE is idle once it is notified, so only a failure completes
+	 * the release here.
+	 */
+	if (code != BT_ASCS_RSP_SUCCESS)
+		cached_release_done(cr, -EIO);
+
+	cached_release_unref(cr);
+}
+
+static void ep_release_cached(struct bt_bap_stream *stream, void *user_data)
+{
+	struct cached_release_data *data = user_data;
+	struct bap_ep *ep = data->ep;
+	struct cached_release *cr;
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
+	cr = new0(struct cached_release, 1);
+	cr->stream = stream;
+	cr->epdata = data->epdata;
+	cr->refs = 2;
+
+	data->epdata->remaining++;
+
+	if (!ep->data->cached_releases)
+		ep->data->cached_releases = queue_new();
+
+	queue_push_tail(ep->data->cached_releases, cr);
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
 
@@ -1051,6 +1175,15 @@ static void ep_close(struct bap_ep *ep, const char *transport_path,
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
@@ -1302,14 +1435,16 @@ struct clear_configuration_data {
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
@@ -1338,7 +1473,8 @@ static DBusMessage *clear_configuration(DBusConnection *conn, DBusMessage *msg,
 	cbdata->all = (path == NULL);
 
 	DBG("%p %s %s", cbdata, ep->path, path ? path : "NULL");
-	ep_close(ep, path, clear_configuration_cb, cbdata);
+
+	ep_close(ep, path, !path, clear_configuration_cb, cbdata);
 	return NULL;
 }
 
@@ -1403,7 +1539,7 @@ static void reconfigure_select_cb(int err, void *user_data)
 	free(data);
 }
 
-static void reconfigure_close_cb(int count, void *user_data)
+static void reconfigure_close_cb(int count, int err, void *user_data)
 {
 	struct reconfigure_data *data = user_data;
 
@@ -1424,7 +1560,7 @@ static void ep_close_if_reconfigure(void *obj, void *user_data)
 
 	if (ep->reconfigure) {
 		data->remaining++;
-		ep_close(ep, NULL, reconfigure_close_cb, data);
+		ep_close(ep, NULL, false, reconfigure_close_cb, data);
 	}
 }
 
@@ -1464,7 +1600,7 @@ static DBusMessage *reconfigure(DBusConnection *conn, DBusMessage *msg,
 	queue_foreach(data->snks, ep_close_if_reconfigure, cbdata);
 	queue_foreach(data->srcs, ep_close_if_reconfigure, cbdata);
 
-	reconfigure_close_cb(0, cbdata);
+	reconfigure_close_cb(0, 0, cbdata);
 	return NULL;
 }
 
@@ -3031,6 +3167,8 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 			setup_free(setup);
 		else
 			queue_remove(data->server_streams, stream);
+
+		bap_cached_release_idle(data, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (setup) {
@@ -4054,6 +4192,9 @@ static int bap_disconnect(struct btd_service *service)
 	queue_destroy(data->server_streams, NULL);
 	data->server_streams = NULL;
 
+	queue_destroy(data->cached_releases, cached_release_cancel);
+	data->cached_releases = NULL;
+
 	bt_bap_detach(data->bap);
 
 	btd_service_disconnecting_complete(service, 0);
-- 
2.56.0

