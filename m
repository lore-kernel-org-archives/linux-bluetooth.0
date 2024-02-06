Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0017BC4
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258920; cv=none; b=N5OztrlTbswCOimTgfeF/47OqOpxII9lh9zt8iZOyCvGDZjjBu79SQ8Je3jUkMInCi4t4bl3WfQgOY301QNi3/IR503to0DcUDcqAdcQi6HgHXOFKEJ7ZPf6Mps0HvUUEpuu16mXQAF9BOkFLRX4+av4ZLDijMK46MezfnBZ700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258920; c=relaxed/simple;
	bh=PVMVZfRJv0/eFc6Drl3lvOnwBw9zB43fr7ix5pc7Y+E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9pPaxhnDxKCTyhNP1Gq/AxZnO7CGQ/AAgOGa4zfnq4gIFxQWdV2sGXwStlbJXO9PvufUPMWsEFGvOWE8UxXwiXP+kl0bAFHoVpMyYZFDCJvbpW/XMp1OrWsMhkwQtBfU8NDXFr9/MkKp/WddBYjBma55I9J6hErI1i/sH7JVjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMQwPFdt; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMQwPFdt"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-46d3d03bb35so589098137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Feb 2024 14:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707258916; x=1707863716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCqy+sPgCuOEGmuoq94Z1elRKNlEZcwG4WI2JQ5LNJg=;
        b=RMQwPFdtErRP9mr/Rw8FBIxw0bZ0LKEUzXdnYCYAASoOQ3oD+ZZPOAJrnun1QBcj1y
         rVbzH3fwTmMpfd+QQMLWHaUUkPI+mq4SIlSuEysc+fn/Vi2WdkxSRlMmGOIAoHralCxz
         DoTZvy4Uy3crlsKIywHAjaj+yuAFHk7B21+l0pk/xEACWNlxQqtTj4hqxHKTd5dCgIZf
         e/xXvxDLpHdxJtH2Ws5D/k5ms1ziAWYd/ZbYO2PA/TdTTBpPW8/20EazOOH/ExyxTNvd
         Gd89qd6GxwpX+Qngr67l5FFG733Z8EMYGv9NUc90HHvrKa/ElwWZ+FrwMn4U/PQ+3VRR
         /ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707258916; x=1707863716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCqy+sPgCuOEGmuoq94Z1elRKNlEZcwG4WI2JQ5LNJg=;
        b=M5YLb7oKM1Ki1dNhJA75DJmCwc1ETD1jGP/vRPxhobnUapRv7zkW3u80rvgPYXXDc7
         jFRmWm324SVJDbIFpvnqqZEPrNla2C9JT7jFx2AejEvKKSQ2aV9/OO51bJ1DC3cCgSOa
         yaaPYgYyxip6sliva3vRZiB87pHCbbXYVt6N0LhnsIP1KUv4ZyBWyzS4zIuKjegm2pBo
         d8APr1rFi2ec1cXEVGYbIGZHnNrBAOqr1hIfnxbjrP1V1EEMxUePRJJkahXeIu8fu6lO
         3DEE0TuoiYzJtHPFep8wareB0tKH2s8NtDy+ptNDJGml4LEPH2t5XkkmOIcF27fpeEPK
         sFyA==
X-Gm-Message-State: AOJu0YyfJk4TvGAISxZecom9Z/CtiMrjOvZlcYXQZBnN70irkaHQmTHJ
	D+ntMWHnp70kPSdT0I7Mf9lyITeB47KCLwxhyf2bhz8mWcC6BnAe9TVyLZBH
X-Google-Smtp-Source: AGHT+IEI5oS6CJQTmvj6TvPDgBXS3l7JGIip2I0btHrt7cNXn47i0K9zftxJecK2wn0tZwLz94r1tg==
X-Received: by 2002:a05:6102:390b:b0:46d:3670:9743 with SMTP id e11-20020a056102390b00b0046d36709743mr1128305vsu.34.1707258915812;
        Tue, 06 Feb 2024 14:35:15 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id l7-20020a056102316700b0046d35339f2bsm322432vsm.3.2024.02.06.14.35.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:35:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/3] shared/bap: Add .set_state to bt_bap_stream_ops
Date: Tue,  6 Feb 2024 17:35:12 -0500
Message-ID: <20240206223513.2783330-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206223513.2783330-1-luiz.dentz@gmail.com>
References: <20240206223513.2783330-1-luiz.dentz@gmail.com>
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
index 7c714628c437..4722ed1a1b27 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -216,6 +216,7 @@ struct bt_bap_stream_io {
 
 struct bt_bap_stream_ops {
 	uint8_t type;
+	void (*set_state)(struct bt_bap_stream *stream, uint8_t state);
 	unsigned int (*config)(struct bt_bap_stream *stream,
 				struct bt_bap_qos *qos, struct iovec *data,
 				bt_bap_stream_func_t func, void *user_data);
@@ -1213,20 +1214,6 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 	struct bt_bap *bap = stream->bap;
 	const struct queue_entry *entry;
 
-	DBG(bap, "stream %p dir 0x%02x: %s -> %s", stream,
-			bt_bap_stream_get_dir(stream),
-			bt_bap_stream_statestr(stream->ep->old_state),
-			bt_bap_stream_statestr(stream->ep->state));
-
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
@@ -1280,52 +1267,22 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 			bt_bap_stream_stop(stream, stream_stop_complete, NULL);
 		break;
 	}
-
-	bt_bap_unref(bap);
 }
 
 static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
 {
 	struct bt_bap_endpoint *ep = stream->ep;
+	struct bt_bap *bap = stream->bap;
 
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
+	/* Check if ref_count is already 0 which means detaching is in
+	 * progress.
+	 */
+	bap = bt_bap_ref_safe(bap);
+	if (!bap) {
+		bap_stream_detach(stream);
+		return;
 	}
 
-done:
-	bap_stream_state_changed(stream);
-}
-
-static void stream_set_state_broadcast(struct bt_bap_stream *stream,
-					uint8_t state)
-{
-	struct bt_bap_endpoint *ep = stream->ep;
-	struct bt_bap *bap = stream->bap;
-	const struct queue_entry *entry;
-
-	if (ep->old_state == state)
-		return;
 	ep->old_state = ep->state;
 	ep->state = state;
 
@@ -1334,31 +1291,8 @@ static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 			bt_bap_stream_statestr(stream->ep->old_state),
 			bt_bap_stream_statestr(stream->ep->state));
 
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
@@ -1978,16 +1937,50 @@ static unsigned int bap_ucast_release(struct bt_bap_stream *stream,
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
@@ -1996,7 +1989,7 @@ static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_STREAMING);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
 
 	return 1;
 }
@@ -2006,7 +1999,7 @@ static unsigned int bap_bcast_disable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_DISABLING);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
 
 	return 1;
 }
@@ -2026,15 +2019,16 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
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
@@ -2046,19 +2040,19 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
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

