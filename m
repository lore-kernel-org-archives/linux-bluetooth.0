Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507278;
	b=L9yExZ+Hon5Z2Bb4BY3dpyUYoKW9FWHpbWXD0hU7JbdiJeVep3kXFhW/ZJGrGLbuDkw1
	 +CqM+HRYZCs42IG0gqYL06jRi/pdUQCZat49Zmak4A8vNAgAh3e6c5Gd/MHZ7fjnpgJZ+
	 9D4+f4U5A6DSastQaMbxIRW91/QnmiRRUg6/Ylg+G0sq/khTob3Q7OwTUMbMyQM2JV82W
	 fxVP6BtYg/T0ZyC1TEQBNAiWo22RCRgikvZwtj0W2NChboHG2tjlcLQHIGSVbZKOxy0W+
	 9CzfZ/9MwG868JbT/x4ViAqU0NMLtf9h11IlbGsYu5q4jy6w8/DJGhhaSvlw7e2SlAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YCWr+j22vEA9suRst+RDtDDS7RC51DC248rk8uKJ9xQ=;
	b=FmAE9GoJuxmDSunWbr2kgXgIsNtauq8+59hpl4h5ez4MIJy1a6G8/k5S9SIFLY0eZfAe
	 uN5qxfEPBBb6ddLN+9nYrXV9v7rul7/rqpPGplQJpJUN2OnSVyQxwnlJRqojtQATGZQOc
	 fQpQ79Turr485zhv9WTUOUd90ZgR4M/Er3P29GcDfFql5yMgWUSuTzgmc2zYkmFsThFtV
	 xDmjIx/uUl+JDkKyUtXMbwraQ2uXq3Yn56L2kOQBYOfB/vDXjnIwoLUGryAfxtgL80ZV1
	 8DgN8bwlZNKHKLhuAfRDzEqTxg0luNwrsM44uNLHVJAN5aY8DcHo+KoWmZSVIvUnj2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xJeJcT4P;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86E606A333
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 18:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C86E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xJeJcT4P
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7d2d18f1bf5so19360137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794507277; x=1795112077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YCWr+j22vEA9suRst+RDtDDS7RC51DC248rk8uKJ9xQ=;
        b=xJeJcT4PQ68IXnl1hsE2YjIDg+h8R8WrqP3Bv6j611tDdBoVuRS51Y86Hs4if1cCmK
         K5J2kSYkYz6XxSJfnwx6Q89ntxfIRtpQyaZb6sVrSY46PzTF+wrJhgi0DUe21SdeDzx8
         Y68Xi/lnpRDGi3h2yD3gaI+qwFCKJGJKf6FHzXGkaGOMSllbIqw7MEV5JScvz5kXm2s9
         pyVivCV/3t+e479lJ91cOBUoWX6pgqBrhE0/1c5zGSn9w94YKBCpCbTYDoU3zadCkSoT
         1NzRXhe5W6znZFz4B917+JX3gQoOhccse5agvrFhAjbAbhLsxC4XHblf7Zr4WoyDahRR
         Fv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507277; x=1795112077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YCWr+j22vEA9suRst+RDtDDS7RC51DC248rk8uKJ9xQ=;
        b=t9o3C4njE5mzcB5anmlvTbG4HFriTA7JTXFAovAhXb6KzuLUlLQY8j9H30b8uKDOmv
         UrLYzWd4C/Id0EHSApjN4dJmXUJPcyeymqXBHZ4cSLBx2gvLhX0bWVgom8L1a3r8KWes
         YhO0bVs4i4QDz+7e3cqJpYtfPvDoGW2IHeSBVytTO20vwaLo2oaiuc+Vy5PwlxAKeY2v
         Sdpe6m/jzOOkptvjosVD3p8M4DteFWdEKDIMg/L4+46SFFx58vpIqHdRabNwIHWulT2R
         t0bzXXnW1ZR8YdlVXoYaOGyMeJX+s0cWBR/plvQps84HUlK5O0YKhT1bY6vByQTsV6tS
         4vvw==
X-Gm-Message-State: APuU4Z+kzzYg2iQoRCiwcP0qNSt7wWtwhVI2d66BSd/qoFu8CZJOhkWn
	FDh5ljmTbPx4wHirRe2ywSZO51OVbqY2QlCj1Qq8SPxCMn8iG8c7u0qv2hwfmQ==
X-Gm-Gg: AYBFou0D2h48CTOSOkgMC1DcZuR5pzZMpPeMk6lpDZ+JH5HHpHvlgjobAVA7ESW+eq+
	Qlti8yJjfSF3Rokk+/7woGv8R9iA4QI8bpr+cDZrnGDilCrnO3fVP3z09nFPc2Qpz5f0d19YCXM
	UNJB3oa2leYgMxmf/ZPJ2klD30+XQ+gaUNI0nxJsXn0TZJr3bIF81IUQhjJdkeO6xQwAeEwRoXp
	+AH4N/DREDW4vcJ3vsoJX+jY+hM2grjr1P9MEfcpOSQ0TWwRU6IigbyM0gNJk0JtAeR0HbXOtn1
	YIIGlHmpH52RFeeAXaXAGPcum3PvdSQyWWgomw0jYVYC4+fk9REng+h2f8r94adFwBudNdcTCn+
	gh1qMOlQ9KzzI7Dgrp8kJ0gkykW0+yGFbNlc4ENB8tq4w4KlzOSE4pxV7qZMVfI4ydo0GZ74O5k
	O9I9/VYbRlOl5YOuPOi1YQxdTcvcdD9Q8ohIqwYj/EJ/hEXqG+u+bK0aVhnm0aZ4lz4UjyqeG61
	HLKEQwFmzEqeFjW6AXQdl1wBHh/SrhUwrsUip1OMMxe30EtH3a9LBqShZSSw38/xcAiDIy1MNIp
	YI5+uu4sD175GVVpcnWdFL8w3umo0cxArS+O7BUUI5kWQ0VTU2oHxBqNNwX1YOepp/SPZuqBH/4
	XfHpuIw46tB7C1FkRzYOdm7mcc0l97eXtdgehPLT5mEa4pzHEK4iKZ5lVsmUnxLihhw8Vyrbnub
	DFDomqTPUXN4HZuNJaQskFptVe
X-Received: by 2002:a05:6102:f07:b0:7a1:f951:664f with SMTP id ada2fe7eead31-7d64d816027mr4804137.22.1794507277353;
        Thu, 12 Nov 2026 10:14:37 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c1b33eesm178749137.2.2026.11.12.10.14.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:14:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 3/6] bap: Release cached ASEs on ClearConfiguration of an endpoint
Date: Thu, 12 Nov 2026 13:14:28 -0500
Message-ID: <c2567c9a5cb24aad7d5f95ccc533329d226cb234.1794504552.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794504552.git.luiz.von.dentz@intel.com>
References: <cover.1794504552.git.luiz.von.dentz@intel.com>
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
 profiles/audio/bap.c | 158 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 149 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a0e0ba60d817..478e8358e551 100644
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
@@ -1035,8 +1041,125 @@ static void ep_close_setup(void *data, void *user_data)
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
+	/* Also the ones of a failed release, left behind for this stream */
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
 
@@ -1051,6 +1174,15 @@ static void ep_close(struct bap_ep *ep, const char *transport_path,
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
@@ -1302,14 +1434,16 @@ struct clear_configuration_data {
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
@@ -1338,7 +1472,8 @@ static DBusMessage *clear_configuration(DBusConnection *conn, DBusMessage *msg,
 	cbdata->all = (path == NULL);
 
 	DBG("%p %s %s", cbdata, ep->path, path ? path : "NULL");
-	ep_close(ep, path, clear_configuration_cb, cbdata);
+
+	ep_close(ep, path, !path, clear_configuration_cb, cbdata);
 	return NULL;
 }
 
@@ -1403,7 +1538,7 @@ static void reconfigure_select_cb(int err, void *user_data)
 	free(data);
 }
 
-static void reconfigure_close_cb(int count, void *user_data)
+static void reconfigure_close_cb(int count, int err, void *user_data)
 {
 	struct reconfigure_data *data = user_data;
 
@@ -1424,7 +1559,7 @@ static void ep_close_if_reconfigure(void *obj, void *user_data)
 
 	if (ep->reconfigure) {
 		data->remaining++;
-		ep_close(ep, NULL, reconfigure_close_cb, data);
+		ep_close(ep, NULL, false, reconfigure_close_cb, data);
 	}
 }
 
@@ -1464,7 +1599,7 @@ static DBusMessage *reconfigure(DBusConnection *conn, DBusMessage *msg,
 	queue_foreach(data->snks, ep_close_if_reconfigure, cbdata);
 	queue_foreach(data->srcs, ep_close_if_reconfigure, cbdata);
 
-	reconfigure_close_cb(0, cbdata);
+	reconfigure_close_cb(0, 0, cbdata);
 	return NULL;
 }
 
@@ -3031,6 +3166,8 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 			setup_free(setup);
 		else
 			queue_remove(data->server_streams, stream);
+
+		bap_cached_release_idle(data, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (setup) {
@@ -4054,6 +4191,9 @@ static int bap_disconnect(struct btd_service *service)
 	queue_destroy(data->server_streams, NULL);
 	data->server_streams = NULL;
 
+	queue_destroy(data->cached_releases, cached_release_cancel);
+	data->cached_releases = NULL;
+
 	bt_bap_detach(data->bap);
 
 	btd_service_disconnecting_complete(service, 0);
-- 
2.56.0

