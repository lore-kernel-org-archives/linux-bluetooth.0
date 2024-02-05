Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C4B482DC
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Feb 2024 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707171064; cv=none; b=Y4zrPgzCHG7gPUG8dC0TejChAe4LllTv8GXdnD/Jc6VsiwGlIXlKZ93pLLYq0oatk7xLER4s72jihzNnXDwRqh/5ZHC3xuWD1YDioKRnt7tgUmQpvhgwlrbLtArQL41DClWJxZUP3xwY/sOPFCxWzaZoos1sVrx7ZwtmGUrYqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707171064; c=relaxed/simple;
	bh=8jiwNIrOJ4R1+PCf5hm7jdJD3UP9394+dKuIaxgaFWU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOj/jMl+hfhT3PgqVW2VoiJlbgB8Zbc2mAskO94QTTVObuo1aOV37vERmr7O5r8lUpA7q9kGCR0TiURAI95TgLyL6rUUHVkh+W8FIHApshAdyG+/XKGqzp5Y2FLDUCfSl4Oiv53zafVQn54sWeS0SlWvOAO3Js2z9BwGM0GRhtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmQb1J/s; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmQb1J/s"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-46d3b3e0671so230313137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Feb 2024 14:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707171060; x=1707775860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcM9nkXP7uW7E3zY2tNcFEfc1ERMoKJJqAdEbfP0BUc=;
        b=VmQb1J/skjTtzWugAVgOLgkp3486E2zIpu37HMqTYT/a3u0esLmQY5+Bef8tqLMX/C
         wuVFwbPCTsf9pNnG5Av6H/mPWsXPVgPyAO4fGSn38QfFsXuJQY+ps+06KALHxtFNMpnq
         FV49JkmGpERnGchldzlZ0tYhJwh3ssJemfEblVv7l3kq520wGFIDpTOFvxYyno4wrs3Y
         M3+pIyV2Bus3E6cj7FLUc7X1wp68EJT4H0U9TLOIVKZCg74n/8hVaLMKmSAEKfewkKY0
         locsKj+3LZ9hlbdN6xwZuq9DN3i9UaPz+nxw4bhslTTsewK25dPrltMTqlA6xOA9ZRhu
         zDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707171060; x=1707775860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcM9nkXP7uW7E3zY2tNcFEfc1ERMoKJJqAdEbfP0BUc=;
        b=rIkc0mI1KYR1Lf2JvJylLFuCcUsdyS741n349lcsbwSUZWIfdkjpOBn+fGccCUUxRW
         mUgQGT1CQGLs6pygXb3xOS6a+m3bOXKV7CZtZ/d0y1f/80eMciMmgpHD1nSOptmUXZ/v
         9cB6gsmF73vh0sVC94h2xrMEgigBdDNK3chFJqFk7Kj7tit2+KZf495ZGkhYu0i4Dhn1
         ASSe1tTPHb+92UGXjN8CUoI3Hrre5277wr3vF4vfLFIBoX8iyM866yUHa0BhwVe8k3mY
         SGOx7SK98/UO/OZaw/UDqlT8oPLG1zxGO27R5kawQURXHR+1+iwveeYCpE8CEapF8Op9
         AreA==
X-Gm-Message-State: AOJu0Yxt3StI/uW6DUVNolGYt1R7B8QTszzamHDFLt3U3r/0YFUQJ/aI
	gC3ETyeKCFDo9/Gw2GgEL3LrsE3DOQFluJ6hgevDQAKiLHxtz9HPRvzwOCex
X-Google-Smtp-Source: AGHT+IEHzlotWSuQEyggTXbgMjBsHyQ0cF4rvO/cVY9YDngMlXGXl3pYjdS4ZOZTYWmPbv4acJBMlQ==
X-Received: by 2002:a67:ce0c:0:b0:46d:2228:d196 with SMTP id s12-20020a67ce0c000000b0046d2228d196mr245438vsl.29.1707171060507;
        Mon, 05 Feb 2024 14:11:00 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id 30-20020a9f22a1000000b007ce1febd008sm117414uan.34.2024.02.05.14.10.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:10:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] shared/bap: Add .set_state to bt_bap_stream_ops
Date: Mon,  5 Feb 2024 17:10:57 -0500
Message-ID: <20240205221057.2349094-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205221057.2349094-1-luiz.dentz@gmail.com>
References: <20240205221057.2349094-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables different code paths for each stream type e.g unicast vs
broadcast.
---
 src/shared/bap.c | 180 +++++++++++++++++++++++------------------------
 1 file changed, 87 insertions(+), 93 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 3b4803ab6c72..9b0768d11373 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -216,6 +216,7 @@ struct bt_bap_stream_io {
 
 struct bt_bap_stream_ops {
 	uint8_t type;
+	void (*set_state)(struct bt_bap_stream *stream, uint8_t state);
 	unsigned int (*config)(struct bt_bap_stream *stream,
 				struct bt_bap_qos *qos, struct iovec *data,
 				bt_bap_stream_func_t func, void *user_data);
@@ -1218,15 +1219,6 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 			bt_bap_stream_statestr(stream->ep->old_state),
 			bt_bap_stream_statestr(stream->ep->state));
 
-	/* Check if ref_count is already 0 which means detaching is in
-	 * progress.
-	 */
-	bap = bt_bap_ref_safe(bap);
-	if (!bap) {
-		bap_stream_detach(stream);
-		return;
-	}
-
 	/* Pre notification updates */
 	switch (stream->ep->state) {
 	case BT_ASCS_ASE_STATE_IDLE:
@@ -1280,85 +1272,27 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 			bt_bap_stream_stop(stream, stream_stop_complete, NULL);
 		break;
 	}
-
-	bt_bap_unref(bap);
 }
 
 static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
-{
-	struct bt_bap_endpoint *ep = stream->ep;
-
-	ep->old_state = ep->state;
-	ep->state = state;
-
-	if (stream->lpac->type == BT_BAP_BCAST_SINK)
-		goto done;
-
-	if (stream->client)
-		goto done;
-
-	switch (ep->state) {
-	case BT_ASCS_ASE_STATE_IDLE:
-		break;
-	case BT_ASCS_ASE_STATE_CONFIG:
-		stream_notify_config(stream);
-		break;
-	case BT_ASCS_ASE_STATE_QOS:
-		stream_notify_qos(stream);
-		break;
-	case BT_ASCS_ASE_STATE_ENABLING:
-	case BT_ASCS_ASE_STATE_STREAMING:
-	case BT_ASCS_ASE_STATE_DISABLING:
-		stream_notify_metadata(stream);
-		break;
-	}
-
-done:
-	bap_stream_state_changed(stream);
-}
-
-static void stream_set_state_broadcast(struct bt_bap_stream *stream,
-					uint8_t state)
 {
 	struct bt_bap_endpoint *ep = stream->ep;
 	struct bt_bap *bap = stream->bap;
-	const struct queue_entry *entry;
 
-	if (ep->old_state == state)
+	/* Check if ref_count is already 0 which means detaching is in
+	 * progress.
+	 */
+	bap = bt_bap_ref_safe(bap);
+	if (!bap) {
+		bap_stream_detach(stream);
 		return;
+	}
+
 	ep->old_state = ep->state;
 	ep->state = state;
 
-	DBG(bap, "stream %p dir 0x%02x: %s -> %s", stream,
-			bt_bap_stream_get_dir(stream),
-			bt_bap_stream_statestr(stream->ep->old_state),
-			bt_bap_stream_statestr(stream->ep->state));
-
-	bt_bap_ref(bap);
-
-	for (entry = queue_get_entries(bap->state_cbs); entry;
-							entry = entry->next) {
-		struct bt_bap_state *state = entry->data;
-
-		if (state->func)
-			state->func(stream, stream->ep->old_state,
-					stream->ep->state, state->data);
-	}
-
-	/* Post notification updates */
-	switch (stream->ep->state) {
-	case BT_ASCS_ASE_STATE_IDLE:
-		bap_stream_detach(stream);
-		break;
-	case BT_ASCS_ASE_STATE_DISABLING:
-		bap_stream_io_detach(stream);
-		stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_QOS);
-		break;
-	case BT_ASCS_ASE_STATE_RELEASING:
-		bap_stream_io_detach(stream);
-		stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_IDLE);
-		break;
-	}
+	if (stream->ops && stream->ops->set_state)
+		stream->ops->set_state(stream, state);
 
 	bt_bap_unref(bap);
 }
@@ -1370,11 +1304,9 @@ static void ep_config_cb(struct bt_bap_stream *stream, int err)
 
 	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
 		if (!bt_bap_stream_io_dir(stream))
-			stream_set_state_broadcast(stream,
-				BT_BAP_STREAM_STATE_QOS);
+			stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
 		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-			stream_set_state_broadcast(stream,
-				BT_BAP_STREAM_STATE_CONFIG);
+			stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 		return;
 	}
 
@@ -1591,6 +1523,33 @@ static bool bap_queue_req(struct bt_bap *bap, struct bt_bap_req *req)
 	return true;
 }
 
+static void bap_ucast_set_state(struct bt_bap_stream *stream, uint8_t state)
+{
+	struct bt_bap_endpoint *ep = stream->ep;
+
+	if (stream->lpac->type == BT_BAP_BCAST_SINK || stream->client)
+		goto done;
+
+	switch (ep->state) {
+	case BT_ASCS_ASE_STATE_IDLE:
+		break;
+	case BT_ASCS_ASE_STATE_CONFIG:
+		stream_notify_config(stream);
+		break;
+	case BT_ASCS_ASE_STATE_QOS:
+		stream_notify_qos(stream);
+		break;
+	case BT_ASCS_ASE_STATE_ENABLING:
+	case BT_ASCS_ASE_STATE_STREAMING:
+	case BT_ASCS_ASE_STATE_DISABLING:
+		stream_notify_metadata(stream);
+		break;
+	}
+
+done:
+	bap_stream_state_changed(stream);
+}
+
 static unsigned int bap_ucast_config(struct bt_bap_stream *stream,
 					struct bt_bap_qos *qos,
 					struct iovec *data,
@@ -1977,16 +1936,50 @@ static unsigned int bap_ucast_release(struct bt_bap_stream *stream,
 	return req->id;
 }
 
+static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
+{
+	struct bt_bap *bap = stream->bap;
+	const struct queue_entry *entry;
+
+	DBG(bap, "stream %p dir 0x%02x: %s -> %s", stream,
+			bt_bap_stream_get_dir(stream),
+			bt_bap_stream_statestr(stream->ep->old_state),
+			bt_bap_stream_statestr(stream->ep->state));
+
+	for (entry = queue_get_entries(bap->state_cbs); entry;
+							entry = entry->next) {
+		struct bt_bap_state *state = entry->data;
+
+		if (state->func)
+			state->func(stream, stream->ep->old_state,
+					stream->ep->state, state->data);
+	}
+
+	/* Post notification updates */
+	switch (stream->ep->state) {
+	case BT_ASCS_ASE_STATE_IDLE:
+		bap_stream_detach(stream);
+		break;
+	case BT_ASCS_ASE_STATE_DISABLING:
+		bap_stream_io_detach(stream);
+		stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
+		break;
+	case BT_ASCS_ASE_STATE_RELEASING:
+		bap_stream_io_detach(stream);
+		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+		break;
+	}
+}
+
 static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
 					bool enable_links, struct iovec *data,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
 	if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-		stream_set_state_broadcast(stream,
-						BT_BAP_STREAM_STATE_STREAMING);
+		stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
 	else
-		stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_CONFIG);
+		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 
 	return 1;
 }
@@ -1995,7 +1988,7 @@ static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_STREAMING);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
 
 	return 1;
 }
@@ -2005,7 +1998,7 @@ static unsigned int bap_bcast_disable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_DISABLING);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
 
 	return 1;
 }
@@ -2025,15 +2018,16 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_RELEASING);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
 
 	return 1;
 }
 
-#define STREAM_OPS(_type, _config, _qos, _enable, _start, _disable, _stop, \
-			_metadata, _release) \
+#define STREAM_OPS(_type, _set_state, _config, _qos, _enable, _start, \
+			_disable, _stop, _metadata, _release) \
 { \
 	.type = _type, \
+	.set_state = _set_state, \
 	.config = _config, \
 	.qos = _qos, \
 	.enable = _enable, \
@@ -2045,19 +2039,19 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 }
 
 static const struct bt_bap_stream_ops stream_ops[] = {
-	STREAM_OPS(BT_BAP_SINK,
+	STREAM_OPS(BT_BAP_SINK, bap_ucast_set_state,
 			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
 			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
 			bap_ucast_metadata, bap_ucast_release),
-	STREAM_OPS(BT_BAP_SOURCE,
+	STREAM_OPS(BT_BAP_SOURCE, bap_ucast_set_state,
 			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
 			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
 			bap_ucast_metadata, bap_ucast_release),
-	STREAM_OPS(BT_BAP_BCAST_SINK,
+	STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
 			bap_bcast_config, NULL, bap_bcast_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
 			bap_bcast_metadata, bap_bcast_release),
-	STREAM_OPS(BT_BAP_BCAST_SOURCE,
+	STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
 			bap_bcast_config, NULL, bap_bcast_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
 			bap_bcast_metadata, bap_bcast_release),
-- 
2.43.0

