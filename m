Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B814256C89
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749418362; cv=pass; b=pO2OQ48+I+dtdhCYUnXdsT7ODqW2ZxBQzckQ2plM8FvLmbcGWNm4jUVxof8zZDCns6WCAYBSvXX6dwhaDcHLSepHc+Ocvof57lXedfHllrHXIPtqyu/tNd1y0ZlzyAPlb+hqNqqX9bx8o18v8AxbCXWw15kJ7UKE5DuaiGRh1Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749418362; c=relaxed/simple;
	bh=VYcrhD2CIDXWa3QLlfZyvykpAIfwSE5fTbvTx1gHWRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7MgH1dQYBwCCB6942DDk3k3F0kUjiv6E64czviYnv+8xliEf7BArrRXVd8qAT9o3/xskIUnrcWRnTegmtkjgMimKlVCF/8y86gW4meJS3RN8J73XshyhDPfALLCD8IPSPl7KarIGMIrz0qHrF5eide7JXjdSz6uUb4y2SjHwls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=CHsviPHg; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="CHsviPHg"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bFpDk2HDtz49Q4L;
	Mon,  9 Jun 2025 00:32:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1749418358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B29qcsl4V3dNGkC00Sv+rhKeW0H6rzDD+JKT5VVGUfg=;
	b=CHsviPHgQFzce7Uz9KqyD1LB3D2/rjDIFjwMqXqWFJDx7DmAmpbaGpN6jKvcwlqegNHw6i
	bisqNImdklA2NasgBq07frUOh8deoJvTz+i/yl1KOS3DYVywFcMMvtPk25Pi+ImE/NpQFf
	d6CDn+m/7mb8XicYYelMBL9c6POSmZ+ZrATmhAJZa2Rc3pc5JIZz1uD2qJYyGVGuCPlLRI
	QbTODM4nDvj6+SIzIvrkN8H7NUfDlNSNIJH86czsego+9VQjq8mAxNy9UBVxZ+ti3SZnkU
	c/OhFp2unoZwbzID6JXHu3I6NrK4EB3xWzfxbDAlYucurx1eEEgVQhL0RUHTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1749418358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B29qcsl4V3dNGkC00Sv+rhKeW0H6rzDD+JKT5VVGUfg=;
	b=URpzUNkLkZKTHVgyola9xUKN8K42JFkq2XwnsQr4fL9Iv7JffwK2lsYzajocGyO23qP24S
	cKdZBbsqfKHpvDn2rU3OUJreCOPex+OBSSRfDh8HLatMicqjaJMezTo+/x+VVY4Gmg5EgH
	GkBm/6aRzetPmhj4DnICN3pArmV305iv3d00uD56J4NYXXImLoLCBZU9Fq7g9Uho9owniH
	vIk29nPclO9STlHLK4ZTQ/b+ltvRmLk24tvd9FsHXKlXUxYarjx8jC0Kt/Jejkj//bWGEX
	aMgjGYsDFi+/uzBvTSvIiqncE3mU3pI6MhSyDpl5JmHTn4Dv+lHOfm2NESoUzw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1749418358; a=rsa-sha256;
	cv=none;
	b=QovO8v7EgA3Cyl9IYK0trvUBdeNMpFLhDP8I9xRDd7xx8P3j7kJbp94b11eLV+ZKDUseGZ
	npf2gCBJuPvW/9i08ae2Kqe2AnuukzhwKuHlwWxVQ8npzt6ea/octMKz6MJ10lFTfKNvqV
	iHL6QiQD8zGZjxp7ZemuHmDWdeKtb0LqBoO4hX/TPbDuXvSxSopbyC5aTczD661K0pWQfT
	vozi5f6Bhtncr1Glh72/saEmyHPKH0X74OqDV/FOwPBwaSZYYMISrT37cDqLRrAibHVAQT
	YDTyCMrnc4U5SE1///Xt5zqpHSVnmrNbDqBSIPFrcG2wmVJF1tc4vgS3H2NpGg==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 03/10] shared/bap: add client ASE reuse and upper level stream locking
Date: Mon,  9 Jun 2025 00:32:15 +0300
Message-ID: <36b7af1db42e5fad73161a535146d2b16381b3bf.1749418319.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749418319.git.pav@iki.fi>
References: <cover.1749418319.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change ucast client stream design so that:

* upper level locks streams to indicate which ones it is using
* unused streams are reused when upper level wants a new stream
* only locked streams are used for bidi CIS linking
* streams (still) correspond 1-to-1 to non-idle ASEs

This fixes some issues:

* bap_ucast_stream_new() could pick a stream upper level is already
  using if lpac & rpac match (can occur with multi-stream AC 6(ii) etc)
* Avoids assuming ASE enters idle state at end of stream life cycle.
  This is False for some devices like Sony headsets, which always cache
  codec config so RELEASING -> CONFIG always, never RELEASING -> IDLE,
  so ASE never go IDLE again.
* Allows reconfiguring an ASE with different codec in this case.
* Allows upper level to only QoS some of the streams.

Reconfiguring ASE in QOS/CONFIG state with different codec here results
to need_reconfig=true state, where ASE and stream configs do not match,
and upper level needs to do bt_bap_stream_config() to sync them.
---
 src/shared/bap.c | 133 ++++++++++++++++++++++++++++++-----------------
 src/shared/bap.h |   3 ++
 2 files changed, 89 insertions(+), 47 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index fda1e3560..1c15a4ecb 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -296,6 +296,8 @@ struct bt_bap_stream {
 	struct queue *pending_states;
 	bool no_cache_config;
 	bool client;
+	bool locked;
+	bool need_reconfig;
 	void *user_data;
 };
 
@@ -1925,6 +1927,9 @@ static unsigned int bap_ucast_qos(struct bt_bap_stream *stream,
 	if (!stream->client)
 		return 0;
 
+	if (stream->need_reconfig)
+		return 0;
+
 	memset(&qos, 0, sizeof(qos));
 
 	/* TODO: Figure out how to pass these values around */
@@ -2327,7 +2332,6 @@ static unsigned int bap_ucast_release(struct bt_bap_stream *stream,
 	/* If stream does not belong to a client session, clean it up now */
 	if (!bap_stream_valid(stream)) {
 		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
-		stream = NULL;
 		return 0;
 	}
 
@@ -2610,6 +2614,9 @@ static int bap_ucast_io_link(struct bt_bap_stream *stream,
 			stream->ep->dir == link->ep->dir)
 		return -EINVAL;
 
+	if (stream->client && !(stream->locked && link->locked))
+		return -EINVAL;
+
 	if (!stream->links)
 		stream->links = queue_new();
 
@@ -5073,6 +5080,8 @@ static void ep_status_config(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 		ep->stream->cc = new0(struct iovec, 1);
 
 	util_iov_memcpy(ep->stream->cc, cfg->cc, cfg->cc_len);
+
+	ep->stream->need_reconfig = false;
 }
 
 static void bap_stream_config_cfm_cb(struct bt_bap_stream *stream, int err)
@@ -5980,43 +5989,6 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac)
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
@@ -6196,6 +6168,48 @@ static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
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
+		if (ep->stream->locked)
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
@@ -6213,20 +6227,26 @@ static struct bt_bap_stream *bap_ucast_stream_new(struct bt_bap *bap,
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
 
 	return stream;
 }
@@ -6247,6 +6267,25 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 	return bap_bcast_stream_new(bap, lpac, pqos, data);
 }
 
+void bt_bap_stream_lock(struct bt_bap_stream *stream)
+{
+	if (!stream || !stream->client)
+		return;
+
+	/* Reserve stream ASE for use by upper level, so it won't get
+	 * reallocated
+	 */
+	stream->locked = true;
+}
+
+void bt_bap_stream_unlock(struct bt_bap_stream *stream)
+{
+	if (!stream || !stream->client)
+		return;
+
+	stream->locked = false;
+}
+
 struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)
 {
 	if (!stream)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index d10581428..fba8b6b17 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -183,6 +183,9 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 					struct bt_bap_qos *pqos,
 					struct iovec *data);
 
+void bt_bap_stream_lock(struct bt_bap_stream *stream);
+void bt_bap_stream_unlock(struct bt_bap_stream *stream);
+
 struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream);
 uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream);
 
-- 
2.49.0

