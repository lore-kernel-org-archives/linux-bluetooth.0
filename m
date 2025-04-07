Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1351156C69
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056112; cv=none; b=p/+mlXmC29OKDy6Ew2APT3BqKYI+0jfd1OXQOoDhTT9iGTQZovfYqtDbdVdGf3gudZTNrGbI5XFOcMpQDoBbATlLLKYpL6PMk1FBAWuSrPN77kSgn9AVvIu1i35UzAkMrKWj69y8TAWuNh7wFem0KI8k4cdgnVLmLhpiurY4VSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056112; c=relaxed/simple;
	bh=q+bzEpMAgO/dm2IDtUxLQbhY+OelrCiqWbUkR5l4eVk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ui6f38ZZBe9ULfP383suOVmKFJiujTduu6K3v5+ntk+gA0zthPYg9b2UmTtO1SokJoEv4a9yeIGyd8IHym+LFzqlTwMl7sbNC/hvAbcLQogTXR37h+7qQBBWzVSZuQ0KjOU3kzFuAaK3c3CFe04b4BibWVS1OGZyvSp+HHoKE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4c3smms; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4c3smms"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-525b44ec88aso2393138e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056108; x=1744660908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAeqKX0B+ER9flIVAP9swP6exuU6A7E3O5ep9bCGOhs=;
        b=h4c3smmsDn7Gn3/7++GuGfojk/GypDnJy6h924UC2ZxPOtgxnoU0ZWpnG+2LJoLmYZ
         LtElEX/y8Rp/23BxMPZCFBYX3meycWfRWDAvKWh4YzsndQz2J86nA4Ac2PMZe4bjvGzK
         yC+HGu7n+4lqban2AsRqKb30Hh+cWqwqCwT0HciDn2LP0wTR43fqFNrUZ+UGIajHEw2S
         MqO2NX/z5ktwSTjwyvNtpGZ9cEKst+EYAWhjgLMOIZVAooXjzUqiZcr4gA7hfSjb7VBR
         yNcJRsuGK+fummFpJtW580nazaKhdYGhdIsCB7v/K1jWsTDL6VMpvRrvAL66Ly84M/kz
         BUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056108; x=1744660908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAeqKX0B+ER9flIVAP9swP6exuU6A7E3O5ep9bCGOhs=;
        b=LvdJX5t1KpJrdJMkHPPgJu9fCl786bEsjqtZkKTNc+m6GzYfPsupu6dGV0IbmWzXY/
         HsKumfOOApl5jOT653HGicqNmzX9qB/86Cle5hKMXXB/KCalJOXb1dGY7gXz9gRkC15d
         CUur9A+nB/FSzxFFMXqRtWPw2rBgFHqGg9Cnd/L/I14autQo1P8vYxIr56fTKt5uvTTb
         MQBY5kGHPiX1BgS2sz0wZL/lVoHqMdob+Qc7QWtQAfxOoPAcKL1AurFDK7T99Q1gVgf1
         8CW2EVrdAcGlEM9qeEhlJ94On2tXvzxhAlSTu7M09OzJ4BqzeqjXI9SYiz0DFKtO5IxY
         suYg==
X-Gm-Message-State: AOJu0Yy/14e5lUav6nxND3fKWl3/zYnjupeAOWKoewPNEJFlS6Ac5of6
	632bbUgthfHjj65qpfR2qu/brNMeNOWCE2nM6DwUxHSigyIMvIVm6rVFoxzg
X-Gm-Gg: ASbGncs9pWjvqtuK3ICfQlSYaSS2Mua//waLcqBQ7CyRx0Isukgy2C7+sdGiYBQJ47j
	U2aL9qWE9QzNZ8PKf1xC1PRMcYNiCtrEV7SojI6OE1EQ+moxF2+am96GFkswIpAB1l9hVia/Zb+
	QdY/ThmeYa2j8N//LmPee5r0wEASVP3/HWdRx17Zy7pYeGTH9V4HQErTx2HVzDWjDNg+PiVnldN
	fRhfyctJZwWjJX0GjxNmmv/+YNjR2T2S7zqsxddsQanAhUElNTzlXN1uyaUaAlk/qKvkz6KPAaB
	OshOWdVGHWd92nipd2a9HarfvzRCEjemSEn4OrnM+i0Z/bwu0RQRyTL14oqzKvJ015qSpIYvtaK
	sW41h9F7bBncJ3A==
X-Google-Smtp-Source: AGHT+IEpO3pT0vBDt34cyUljj9IBGUOIbVvRzV58ySlxAa74eqfOJl3ckCiP2DyxwoVPCcRZRu7NIw==
X-Received: by 2002:a05:6122:8288:b0:525:aecb:6306 with SMTP id 71dfb90a1353d-52765dc9a76mr9771066e0c.11.1744056108488;
        Mon, 07 Apr 2025 13:01:48 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.01.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:01:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 08/15] shared/bap: Fix not always sending Releasing state
Date: Mon,  7 Apr 2025 16:01:14 -0400
Message-ID: <20250407200124.881534-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407200124.881534-1-luiz.dentz@gmail.com>
References: <20250407200124.881534-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order for states to be sent the stream cannot be freed since
pending_states could be pending due to be processing a CP operation, so
this attempts to grap a reference to the stream so it is not freed
while states are pending.
---
 src/shared/bap.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 650bea2f4e8d..dbeb43fe509d 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1130,11 +1130,9 @@ static void stream_notify_release(struct bt_bap_stream *stream)
 
 	DBG(stream->bap, "stream %p", stream);
 
-
 	memset(&status, 0, sizeof(status));
 	status.id = ep->id;
-	ep->state = BT_BAP_STREAM_STATE_RELEASING;
-	status.state = ep->state;
+	status.state = BT_ASCS_ASE_STATE_RELEASING;
 
 	gatt_db_attribute_notify(ep->attr, (void *)&status, sizeof(status),
 					bt_bap_get_att(stream->bap));
@@ -1283,8 +1281,10 @@ static void bap_abort_stream_req(struct bt_bap *bap,
 	queue_remove_all(bap->reqs, match_req_stream, stream, bap_req_abort);
 }
 
-static void bt_bap_stream_unref(struct bt_bap_stream *stream)
+static void bt_bap_stream_unref(void *data)
 {
+	struct bt_bap_stream *stream = data;
+
 	if (!stream)
 		return;
 
@@ -1308,7 +1308,6 @@ static void bap_ucast_detach(struct bt_bap_stream *stream)
 	queue_remove(stream->bap->streams, stream);
 	bap_stream_clear_cfm(stream);
 
-	stream->ep = NULL;
 	ep->stream = NULL;
 	bt_bap_stream_unref(stream);
 }
@@ -1751,6 +1750,16 @@ static bool stream_notify_state(void *data)
 	return false;
 }
 
+static struct bt_bap_stream *bt_bap_stream_ref(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return NULL;
+
+	__sync_fetch_and_add(&stream->ref_count, 1);
+
+	return stream;
+}
+
 static void bap_ucast_set_state(struct bt_bap_stream *stream, uint8_t state)
 {
 	struct bt_bap_endpoint *ep = stream->ep;
@@ -1771,7 +1780,8 @@ static void bap_ucast_set_state(struct bt_bap_stream *stream, uint8_t state)
 	else if (!stream->state_id)
 		stream->state_id = timeout_add(BAP_PROCESS_TIMEOUT,
 						stream_notify_state,
-						stream, NULL);
+						bt_bap_stream_ref(stream),
+						bt_bap_stream_unref);
 	else /* If a state_id is already pending then queue the old one */
 		queue_push_tail(stream->pending_states,
 				UINT_TO_PTR(ep->old_state));
@@ -2258,16 +2268,6 @@ static unsigned int bap_ucast_release(struct bt_bap_stream *stream,
 	return req->id;
 }
 
-static struct bt_bap_stream *bt_bap_stream_ref(struct bt_bap_stream *stream)
-{
-	if (!stream)
-		return NULL;
-
-	__sync_fetch_and_add(&stream->ref_count, 1);
-
-	return stream;
-}
-
 static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 {
 	struct bt_bap *bap = stream->bap;
-- 
2.49.0

