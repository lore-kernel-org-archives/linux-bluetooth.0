Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8F1AF0AF
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253065; cv=pass; b=O648Q0lx/6DaEZd7Q1Zep8y+Kh546TghQKqioE5tEDL5AldPl6KC+96gbqkd/LVw1PEjntgR7E4aL8lueWuoDj2WmBudF9BBEBPuBf8BF36KCa926+Np24x1oJlZl6KniEHWBlM6FQNIfl9abJSHt+PJ2Xqv6p7G00xju6b9Fnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253065; c=relaxed/simple;
	bh=zO7SnIFD0f2Kf9NhWlvmCxlC1rq8HvuRFoJ9obgkEyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfEpXqyUpgrJpHIpm2l/WycRWyHl8tEWVZetlmYLk40qb//199sIjktjH3AZzBVrHGM41xSzOYMqcZc7P5S3LSYqk5Afla2oSgXr2tbtGVfjNUk9G6YATjG2kBGUKhZ1kqdM1RFSPSpel0Xe8CbzEivjd+TPuiUjoKbU1DB/g+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=rYiZIExk; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="rYiZIExk"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zh9pp5svXzyWZ;
	Mon, 21 Apr 2025 19:30:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1745253059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6aLSry4ANEaXkTA6FARz461UeJeypZckHx+rQoh8Qk=;
	b=rYiZIExkwRqKRuUUoWjMYsir1EgqrYEzyyFjXYjFmEcq77Nz28l8uNyNPgF5QDHP3ZNE0I
	tztAicGljPQTZqicWEAoR0cP8ldSf4GNJAY5Lb55SSaaQ2vsPFLrskoJRv2U1ELXcicK84
	NjBxmGhw02EWdw+q/cyOSqMl0pfBIPE=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1745253059; a=rsa-sha256; cv=none;
	b=ue+PUPKtEKD+5wg7vk2g2fqymnkVi5otg/U4V3+pMSNf5gKd2Ob567sgxNNSNhbCpAiMak
	4uPU//NKB0/jHS6hAVUAHljiNcPdUC3iKZTaKyvJn7UlzRFhj2vGC3VHrcwIkBAkqbr96D
	xE5wLkZr62S6jaREasfgbeDDyizDShk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1745253059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6aLSry4ANEaXkTA6FARz461UeJeypZckHx+rQoh8Qk=;
	b=aWyHWvhxNuORznkPgVaDHAhR/OTPV9dsrqdn5OV/RioMEShf7fhcXMlft1iNM0VGFAszLP
	uQGixrYCICZ7W7o78d74vqPJgXWsVWc3I71Z05V+9ZZd8uTvePJRPvoG8jfmib8aNepmDb
	4ItFEydu9SWCLswGByxtgaB+rpd6nEE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/bap: fix crash when removing PAC
Date: Mon, 21 Apr 2025 19:30:54 +0300
Message-ID: <86080a21f6604cb916b89aba57a43afe57475a59.1745252940.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <b3c84d2181db1acdc096df03e8d1046b89a7628d.1745252942.git.pav@iki.fi>
References: <b3c84d2181db1acdc096df03e8d1046b89a7628d.1745252942.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When PAC is removed, streams need to go through RELEASING flow, which in
some cases is not immediate. Access to stream->lpac is UAF during this
time, e.g. in profiles/audio/bap.c:bap_find_setup_by_stream

Allow stream->lpac == NULL. This should occur only if stream is
RELEASING.

When releasing streams due to removed PAC, do RELEASING->IDLE as we
can't cache config then.
---
 src/shared/bap.c | 52 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 3a11cb082..4c5b38b1e 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -294,6 +294,7 @@ struct bt_bap_stream {
 	uint8_t state;
 	unsigned int state_id;
 	struct queue *pending_states;
+	bool no_cache_config;
 	bool client;
 	void *user_data;
 };
@@ -1000,6 +1001,9 @@ static void stream_notify_config(struct bt_bap_stream *stream)
 
 	DBG(stream->bap, "stream %p", stream);
 
+	if (!lpac)
+		return;
+
 	len = sizeof(*status) + sizeof(*config) + stream->cc->iov_len;
 	status = malloc(len);
 
@@ -1163,7 +1167,7 @@ static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
 
 static void bap_stream_clear_cfm(struct bt_bap_stream *stream)
 {
-	if (!stream->lpac->ops || !stream->lpac->ops->clear)
+	if (!stream->lpac || !stream->lpac->ops || !stream->lpac->ops->clear)
 		return;
 
 	stream->lpac->ops->clear(stream, stream->lpac->user_data);
@@ -1518,6 +1522,12 @@ static uint8_t stream_config(struct bt_bap_stream *stream, struct iovec *cc,
 
 	DBG(stream->bap, "stream %p", stream);
 
+	if (!pac) {
+		ascs_ase_rsp_add(rsp, stream->ep->id, BT_ASCS_RSP_CONF_REJECTED,
+							BT_ASCS_REASON_CODEC);
+		return 0;
+	}
+
 	/* TODO: Wait for pac->ops response */
 	ascs_ase_rsp_success(rsp, stream->ep->id);
 
@@ -1962,6 +1972,9 @@ static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
 				     struct bt_bap_qos *qos, struct iovec *data,
 				     bt_bap_stream_func_t func, void *user_data)
 {
+	if (!stream->lpac)
+		return 0;
+
 	stream->qos = *qos;
 	stream->lpac->ops->config(stream, stream->cc, &stream->qos,
 			ep_config_cb, stream->lpac->user_data);
@@ -2201,18 +2214,23 @@ static uint8_t stream_release(struct bt_bap_stream *stream, struct iovec *rsp)
 	 * to take action immeditely.
 	 */
 	if (!stream->io) {
+		bool cache_config = !stream->no_cache_config;
+
 		switch (bt_bap_stream_get_state(stream)) {
 		case BT_BAP_STREAM_STATE_CONFIG:
 			/* Released (no caching) */
-			stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
-			stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+			cache_config = false;
 			break;
 		default:
 			/* Released (caching) */
-			stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
-			stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 			break;
 		}
+
+		stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
+		if (cache_config)
+			stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+		else
+			stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
 	} else
 		stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
 
@@ -4214,15 +4232,23 @@ static bool match_stream_lpac(const void *data, const void *user_data)
 	return stream->lpac == pac;
 }
 
-static void remove_streams(void *data, void *user_data)
+static void remove_lpac_streams(void *data, void *user_data)
 {
 	struct bt_bap *bap = data;
 	struct bt_bap_pac *pac = user_data;
 	struct bt_bap_stream *stream;
 
-	stream = queue_remove_if(bap->streams, match_stream_lpac, pac);
-	if (stream)
+	while (1) {
+		stream = queue_remove_if(bap->streams, match_stream_lpac, pac);
+		if (!stream)
+			break;
+
+		bt_bap_stream_ref(stream);
+		stream->no_cache_config = true;
 		bt_bap_stream_release(stream, NULL, NULL);
+		stream->lpac = NULL;
+		bt_bap_stream_unref(stream);
+	}
 }
 
 static void bap_pac_sink_removed(void *data, void *user_data)
@@ -4277,7 +4303,7 @@ bool bt_bap_remove_pac(struct bt_bap_pac *pac)
 	return false;
 
 found:
-	queue_foreach(sessions, remove_streams, pac);
+	queue_foreach(sessions, remove_lpac_streams, pac);
 	queue_foreach(sessions, notify_session_pac_removed, pac);
 	bap_pac_free(pac);
 	return true;
@@ -4998,7 +5024,7 @@ static void bap_stream_config_cfm(struct bt_bap_stream *stream)
 {
 	int err;
 
-	if (!stream->lpac->ops || !stream->lpac->ops->config)
+	if (!stream->lpac || !stream->lpac->ops || !stream->lpac->ops->config)
 		return;
 
 	err = stream->lpac->ops->config(stream, stream->cc, &stream->qos,
@@ -6409,6 +6435,9 @@ bool bt_bap_match_bcast_sink_stream(const void *data, const void *user_data)
 {
 	const struct bt_bap_stream *stream = data;
 
+	if (!stream->lpac)
+		return false;
+
 	return stream->lpac->type == BT_BAP_BCAST_SINK;
 }
 
@@ -6845,6 +6874,9 @@ static void add_new_subgroup(struct bt_base *base,
 	uint16_t cid = 0;
 	uint16_t vid = 0;
 
+	if (!lpac)
+		return;
+
 	bt_bap_pac_get_vendor_codec(lpac, &sgrp->codec.id, &cid,
 			&vid, NULL, NULL);
 	sgrp->codec.cid = cid;
-- 
2.49.0

