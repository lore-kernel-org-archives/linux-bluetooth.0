Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0167319E98A
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374541; cv=pass; b=tMFXDuWHE6TdsQ62+eMuZJ0uJQZ0FxngIykrW1XwowEl0JnBRfw8P5fcLLRBMl7SwmVhWYi9Xyw+9933+NoHGSUw1bHLAeGR9t81AOl2M3o9Jt6+ZY/TidliR7tuPW6y/zvBD4rN7XPeLdEoLlP0L5lpCMqwbLRXf2NvGyRG7yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374541; c=relaxed/simple;
	bh=ZFgLKB+yGNvsbEoUL9e9E+4HVLNg2ks77/v8bzNS5cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViE/m6lqBNAaVYD7pieIYmI2mgQkXWJwYmjaAP5KCluTrCJMtlEa7ANI9KH1OCCtidT10BWP+K2DJ1/9efM6S2vRXm3g/z60YS0yWpW/j8oactlY2aXTYzsq+FOaJyZ/KEqE6QQrJVHsdySAtS3n8n/dx0EJiTkww2Weh81/ZIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qv/qYKLW; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qv/qYKLW"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zr8YZ6yJlzyhZ;
	Sun,  4 May 2025 19:02:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1746374531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rv5HovNWEEmO/z125kMRxUFsKXAiN1VGj2tceppLErw=;
	b=qv/qYKLWBioCzVJJ3hCGWG6C1sz8yBAoqV67tiI5fekGUb9IkwU3UO11erO6oUtX5EjKlD
	yLRQwPTcKzTKlOw16bmxoo3CRG4dbCSGG8ZICOgivqHdh0q4cM4sKwUDEiGJDEqK0QJT+w
	swuxaF2+H2GvQrDiSPbfW9aSIu0bErc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1746374531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rv5HovNWEEmO/z125kMRxUFsKXAiN1VGj2tceppLErw=;
	b=L3uXCZ6jZeGxKBVSP8YZ2/jPkWm89P8nfbGuxBqcZmHuwIThSGzw9x0/4Mh/5DWFmqY1Cq
	B1U2SIstf8VTg8IOpTRuu14LTSg7q9TWzwFHHtxkwJrFR8jlAt/8ZeMXJEwn6SL1FMJtBc
	puWWoYjoSuqMTBe33brGkGwV6DefZs0=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1746374531; a=rsa-sha256; cv=none;
	b=xUcw5ZeTcJiXT02kdLew/DFHWH7lYaIy5U1xE/+G4cyDbI+jFi6oB5pxVrsr8Xx8jg9tQL
	erCM3exod7nRPiglGCrBbrUz5Q4dgc/FNoB0oTy4fcfuy9LekxhsELIn3QdT8pEzwzBTCv
	ixA13EmRvvB+3NIqAinrFu7CzCP7jCk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ v2 04/11] shared/bap: fix ucast client ASE usage
Date: Sun,  4 May 2025 19:01:56 +0300
Message-ID: <52645e73ab0c6f12d2a29b17259222417cf81a93.1746374514.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
References: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ucast client stream design has issues:

* Assuming lpac & rpac pair uniquely identifies a stream.  False for
  AC6(i) and other multi-stream configs.

* No way for ASE in Config state be configured with different codec.

* Assuming ASE enters idle state at end of stream life cycle.  False for
  some devices like Sony headsets, which always cache codec config so
  RELEASING -> CONFIG always, never RELEASING -> IDLE, so ASE never go
  IDLE again.

* Assuming Unicast Client upper layer always creates streams for all
  non-idle ASEs.  False, as when switching between duplex & sink-only
  modes, only some streams shall be used regardless of whether Server is
  caching config or not.

In practice, these currently prevent reconfiguring ASEs on devices which
cache codec config, and multi-stream configs work only accidentally (and
fail if server does Config codec itself, like some devices do).

Minimally fixed design for Unicast Client streams:

Streams correspond 1-to-1 to ASEs in non-IDLE state.

Track explicitly which streams upper level is using:

- bt_bap_stream_new() always makes new stream with client_active=true
- bt_bap_stream_discard() releases stream and marks client_active=false

Streams (ASEs) with no active client may be reused when upper level asks
for a new stream.

Streams with no active client may have their lpac changed.  The
need_reconfig state is a bit ugly, but not really avoidable.

Streams with no active client shall be ignored when constructing
bidirectional CIS pairs.

Streams shall clear transport and detach io on RELEASING. (cf BAP v1.0.2
§5.6.6). Also unlink them since QoS is gone at that point.

Streams shall have transport only for >= QOS state.  (Server streams
work differently, which makes sense since upper level cannot acquire
them before they are pending.)
---
 src/shared/bap.c | 170 +++++++++++++++++++++++++++++++++--------------
 src/shared/bap.h |   2 +
 2 files changed, 123 insertions(+), 49 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 976e3c0b1..456450d40 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -296,6 +296,8 @@ struct bt_bap_stream {
 	struct queue *pending_states;
 	bool no_cache_config;
 	bool client;
+	bool client_active;
+	bool need_reconfig;
 	void *user_data;
 };
 
@@ -1488,6 +1490,13 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 		if (stream->client)
 			bt_bap_stream_stop(stream, stream_stop_complete, NULL);
 		break;
+	case BT_ASCS_ASE_STATE_RELEASING:
+		if (stream->client) {
+			bap_stream_clear_cfm(stream);
+			bap_stream_io_detach(stream);
+			bt_bap_stream_io_unlink(stream, NULL);
+		}
+		break;
 	}
 }
 
@@ -1898,6 +1907,9 @@ static unsigned int bap_ucast_qos(struct bt_bap_stream *stream,
 	if (!stream->client)
 		return 0;
 
+	if (stream->need_reconfig)
+		return 0;
+
 	memset(&qos, 0, sizeof(qos));
 
 	/* TODO: Figure out how to pass these values around */
@@ -2300,7 +2312,6 @@ static unsigned int bap_ucast_release(struct bt_bap_stream *stream,
 	/* If stream does not belong to a client session, clean it up now */
 	if (!bap_stream_valid(stream)) {
 		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
-		stream = NULL;
 		return 0;
 	}
 
@@ -2583,6 +2594,9 @@ static int bap_ucast_io_link(struct bt_bap_stream *stream,
 			stream->ep->dir == link->ep->dir)
 		return -EINVAL;
 
+	if (stream->client && !(stream->client_active && link->client_active))
+		return -EINVAL;
+
 	if (!stream->links)
 		stream->links = queue_new();
 
@@ -2603,6 +2617,30 @@ static int bap_ucast_io_link(struct bt_bap_stream *stream,
 	return 0;
 }
 
+static void stream_unlink_ucast(void *data)
+{
+	struct bt_bap_stream *link = data;
+
+	DBG(link->bap, "stream %p unlink", link);
+
+	queue_destroy(link->links, NULL);
+	link->links = NULL;
+}
+
+static int bap_ucast_io_unlink(struct bt_bap_stream *stream,
+						struct bt_bap_stream *link)
+{
+	if (!stream)
+		return -EINVAL;
+
+	queue_destroy(stream->links, stream_unlink_ucast);
+	stream->links = NULL;
+
+	DBG(stream->bap, "stream %p unlink", stream);
+	return 0;
+
+}
+
 static void stream_link(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = (void *)data;
@@ -2708,7 +2746,7 @@ static const struct bt_bap_stream_ops stream_ops[] = {
 			bap_ucast_release, bap_ucast_detach,
 			bap_ucast_set_io, bap_ucast_get_io,
 			bap_ucast_io_dir, bap_ucast_io_link,
-			NULL),
+			bap_ucast_io_unlink),
 	STREAM_OPS(BT_BAP_SOURCE, bap_ucast_set_state,
 			bap_ucast_get_state,
 			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
@@ -2718,7 +2756,7 @@ static const struct bt_bap_stream_ops stream_ops[] = {
 			bap_ucast_release, bap_ucast_detach,
 			bap_ucast_set_io, bap_ucast_get_io,
 			bap_ucast_io_dir, bap_ucast_io_link,
-			NULL),
+			bap_ucast_io_unlink),
 	STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
 			bap_bcast_get_state,
 			bap_bcast_config, bap_bcast_qos, bap_bcast_sink_enable,
@@ -5015,6 +5053,8 @@ static void ep_status_config(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 		ep->stream->cc = new0(struct iovec, 1);
 
 	util_iov_memcpy(ep->stream->cc, cfg->cc, cfg->cc_len);
+
+	ep->stream->need_reconfig = false;
 }
 
 static void bap_stream_config_cfm_cb(struct bt_bap_stream *stream, int err)
@@ -5922,43 +5962,6 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac)
 	return false;
 }
 
-static bool find_ep_unused(const void *data, const void *user_data)
-{
-	const struct bt_bap_endpoint *ep = data;
-	const struct match_pac *match = user_data;
-
-	if (ep->stream)
-		return false;
-
-	if (match->rpac)
-		return ep->dir == match->rpac->type;
-	else
-		return true;
-}
-
-static bool find_ep_pacs(const void *data, const void *user_data)
-{
-	const struct bt_bap_endpoint *ep = data;
-	const struct match_pac *match = user_data;
-
-	if (!ep->stream)
-		return false;
-
-	if (ep->stream->lpac != match->lpac)
-		return false;
-
-	if (ep->stream->rpac != match->rpac)
-		return false;
-
-	switch (ep->state) {
-	case BT_BAP_STREAM_STATE_CONFIG:
-	case BT_BAP_STREAM_STATE_QOS:
-		return true;
-	}
-
-	return false;
-}
-
 static bool find_ep_source(const void *data, const void *user_data)
 {
 	const struct bt_bap_endpoint *ep = data;
@@ -6136,6 +6139,48 @@ static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
 	return stream;
 }
 
+static bool find_ep_ucast(const void *data, const void *user_data)
+{
+	const struct bt_bap_endpoint *ep = data;
+	const struct match_pac *match = user_data;
+
+	if (ep->stream) {
+		if (!ep->stream->client)
+			return false;
+		if (ep->stream->client_active)
+			return false;
+		if (!queue_isempty(ep->stream->pending_states))
+			return false;
+
+		switch (ep->stream->state) {
+		case BT_BAP_STREAM_STATE_IDLE:
+		case BT_BAP_STREAM_STATE_CONFIG:
+		case BT_BAP_STREAM_STATE_QOS:
+			break;
+		default:
+			return false;
+		}
+	}
+
+	if (ep->dir != match->rpac->type)
+		return false;
+
+	switch (match->lpac->type) {
+	case BT_BAP_SOURCE:
+		if (ep->dir != BT_BAP_SINK)
+			return false;
+		break;
+	case BT_BAP_SINK:
+		if (ep->dir != BT_BAP_SOURCE)
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 static struct bt_bap_stream *bap_ucast_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac,
@@ -6153,21 +6198,28 @@ static struct bt_bap_stream *bap_ucast_stream_new(struct bt_bap *bap,
 	match.lpac = lpac;
 	match.rpac = rpac;
 
-	/* Check for existing stream */
-	ep = queue_find(bap->remote_eps, find_ep_pacs, &match);
+	/* Get free ASE */
+	ep = queue_find(bap->remote_eps, find_ep_ucast, &match);
 	if (!ep) {
-		/* Check for unused ASE */
-		ep = queue_find(bap->remote_eps, find_ep_unused, &match);
-		if (!ep) {
-			DBG(bap, "Unable to find unused ASE");
-			return NULL;
-		}
+		DBG(bap, "Unable to find usable ASE");
+		return NULL;
 	}
 
 	stream = ep->stream;
-	if (!stream)
+	if (stream) {
+		/* Replace lpac: the stream generally needs to be reconfigured
+		 * after this, otherwise things like codec config not match.
+		 */
+		bap_stream_clear_cfm(stream);
+		stream->lpac = lpac;
+		util_iov_free(stream->cc, 1);
+		stream->cc = util_iov_dup(data, 1);
+		stream->need_reconfig = true;
+	} else {
 		stream = bap_stream_new(bap, ep, lpac, rpac, data, true);
+	}
 
+	stream->client_active = true;
 	return stream;
 }
 
@@ -6187,6 +6239,26 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 	return bap_bcast_stream_new(bap, lpac, pqos, data);
 }
 
+void bt_bap_stream_discard(struct bt_bap_stream *stream)
+{
+	if (!stream || !stream->client)
+		return;
+
+	stream->client_active = false;
+
+	switch (stream->ep->state) {
+	case BT_BAP_STREAM_STATE_IDLE:
+	case BT_BAP_STREAM_STATE_RELEASING:
+		break;
+	case BT_BAP_STREAM_STATE_CONFIG:
+		if (stream->ep->old_state == BT_BAP_STREAM_STATE_RELEASING)
+			break;
+		/* Fallthrough */
+	default:
+		bt_bap_stream_release(stream, NULL, NULL);
+	}
+}
+
 struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)
 {
 	if (!stream)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index d10581428..5949eb4b1 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -183,6 +183,8 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 					struct bt_bap_qos *pqos,
 					struct iovec *data);
 
+void bt_bap_stream_discard(struct bt_bap_stream *stream);
+
 struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream);
 uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream);
 
-- 
2.49.0

