Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8E43D7D6C
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742314; cv=none; b=HH0jd/EgSJKNsIxK+BO3B0YSxCWkpYsZQMj+nmLEZBH0cKjRjTR98q/c5bk1AyH+S7glWd608ERJqtX7F9Cp5f12MzWIXxJmoQeysFWme5H3xEJB3llHSzi76nqFM1qgS/FvX9tt8RcCWLNe9RobO53Ml5QjjxGt9oxMKswq3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742314; c=relaxed/simple;
	bh=xVjyUMuHLynoN8g83q0hUYdm7KNWtnoosMvI/snXuyM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ue5soBId9vcdb1k4y/KLNRTn4/W5BqG/i3rxO1EfpB/LxQi3NMZ0W3nA6cDDUv7Ja3ie3ZeBFrqHHxTaMv2eOPI6+IUQ43oh9H5Rc5uc57pY9v+8Ez0wPpF1IrhILqLUxtYXrbYmCxmvVciPYFSYueJNaNmVQG8oROAcbqi/++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkmxsJhK; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkmxsJhK"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bdb162ee53so421640e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782742310; x=1783347110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJn748z7kco//vyV6hl4zmq8Nv0zi3K5zLZa6zqvm+U=;
        b=YkmxsJhKu6TtmCeIdvlAN+BowLocT52NY3c9kdFWValW/vPMlh/2OCg646KOGMIW2S
         sxgAnYCf82vGteiSPEgsLFHoeJ6+uxe4EnpGM4/8GG7/B87zW3e6h6UFz6rtQOQosDPf
         HW1FL9V1d5cS5p8EfZ8dz4+hq+IV1hDn8h/lpPLtvaanVgh2BPj4WssuZL1YxAzR8MwV
         vwUEYBQKgQgCxWauacJnYB5hu97TCXA0UKcnKN5pvzRdc+pYQtHwqLXgEg96dVBvAgx+
         L2XC9arIiR1CRT3BVQbOEmWldAiK4cPNo4j85ti5aXHZwhFlhrFlpmCQRwT2uObmgOO+
         oMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742310; x=1783347110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OJn748z7kco//vyV6hl4zmq8Nv0zi3K5zLZa6zqvm+U=;
        b=kr16x8CPYi1IR4vCZ9uf7M0nogz0Pg/ve1j/Bdyy9vp7xwoV9F0T563dY9qy21UG0K
         G8nC6uNg1SP2R/WZFsMdwq0oVAj1ETEOUxixgMx4IvaaqNfFmqY3oDsIzUOoVcRNsaJy
         /JriaPBQXCkigrv0zX2HZseUh4ZjdQ/tqnCsQOteSzYhfVZQkD0IOgPp9pfDl7u7+r4y
         O4UUd9+Keyh1jqYRrK1Alp/YVkBZ3zb98k6mq9/k4bn+CUg2dfiHsqHN0Qag1/CkJf/i
         8HeaC6Up6W4mJGLKaGqYjTB0hPUo+3PbdMIzcv7CeU3CwllPpR1iFKM0oy8KqrVnHSHr
         dl2w==
X-Gm-Message-State: AOJu0YwvlX03pjzkVRKcdVn+dmabIy4lVJbGj0sbjKGRFtmOVK7QLqRc
	Sv0mAkWn0EMIwFLpEL1m+hI8oCzth0QPGKSZxniaqr5CaMUsAnO24zocnIHN4Gk6
X-Gm-Gg: AfdE7cmZ0Heq2ExNetmkM4aSmdOnBZQh40koUy2WY1YMFECuG6a+zkOniK9YZg8KlIG
	H2G6DkIDbDzHW7M9Ym4C3TEo4YvVdJ6EBtuyvV+XjhbFRLYUofhCYcN4/oPrO3kAUZzXi6fQVhx
	mfRK5UzFvTYsWzBsjHgwi+6LaqaRlPlhG0xyhDiLmk6ikOrzixmEYoYGBoKlO8svufJEeOd+uZx
	mS4p6QxMMWjc7bd8VzeI3WBZYupbHNY+f4TQBB48jHU8ooE5IY4yrUBDr+ZEmM995OoUVUPg01Q
	a7tn0V4w0exKlB+MKXDGQl8zIUR2EX670lWFv5fWI+MnEKL5WRYfMni8RagL4NWmZK8yU6tFywH
	A3Jpwf9rwRiMx74z3uJM+lMlLKgUFsAYrA4RNQVeF2/VtSA28UXJMvPyFIMEKajAhXtMdk5aXx+
	4Ozu26Nu/iXkEU0Q7MZuYKcauP6HhrhPmgNjPHjM5Hh4mkrDjx1I1b41PSH2+lUZ/vAbShLPu+E
	Y7qnfk=
X-Received: by 2002:a05:6122:1da1:b0:5bd:b203:b644 with SMTP id 71dfb90a1353d-5bdb203bd22mr1122415e0c.11.1782742309899;
        Mon, 29 Jun 2026 07:11:49 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bd78e999c5sm5756883e0c.6.2026.06.29.07.11.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 07:11:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] shared/bap: Use queue_foreach to notify state changes
Date: Mon, 29 Jun 2026 10:11:36 -0400
Message-ID: <20260629141136.947652-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629141136.947652-1-luiz.dentz@gmail.com>
References: <20260629141136.947652-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Use queue_foreach to notify state changes since that is considered
safer as it does attempt to detect list modification while traversing
the list.
---
 src/shared/bap.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6086924a9cb7..7bcf28bcefe4 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1447,10 +1447,19 @@ static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 	return true;
 }
 
+static void stream_state_changed(void *data, void *user_data)
+{
+	const struct bt_bap_state *state = data;
+	struct bt_bap_stream *stream = user_data;
+
+	if (state->func)
+		state->func(stream, stream->old_state, stream->state,
+							state->data);
+}
+
 static void bap_stream_state_changed(struct bt_bap_stream *stream)
 {
 	struct bt_bap *bap = stream->bap;
-	const struct queue_entry *entry;
 
 	/* Pre notification updates */
 	switch (stream->ep->state) {
@@ -1475,14 +1484,13 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 		break;
 	}
 
-	for (entry = queue_get_entries(bap->state_cbs); entry;
-							entry = entry->next) {
-		struct bt_bap_state *state = entry->data;
+	stream->old_state = stream->ep->old_state;
+	stream->state = stream->ep->state;
 
-		if (state->func)
-			state->func(stream, stream->ep->old_state,
-					stream->ep->state, state->data);
-	}
+	/* Notify callbacks using queue_foreach since it does attempt to
+	 * protect against concurrent modifications to the list.
+	 */
+	queue_foreach(bap->state_cbs, stream_state_changed, stream);
 
 	/* Post notification updates */
 	switch (stream->ep->state) {
@@ -2407,7 +2415,6 @@ static unsigned int bap_ucast_release(struct bt_bap_stream *stream,
 static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 {
 	struct bt_bap *bap = stream->bap;
-	const struct queue_entry *entry;
 
 	stream->old_state = stream->state;
 	stream->state = state;
@@ -2419,14 +2426,10 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 			bt_bap_stream_statestr(stream->old_state),
 			bt_bap_stream_statestr(stream->state));
 
-	for (entry = queue_get_entries(bap->state_cbs); entry;
-							entry = entry->next) {
-		struct bt_bap_state *state = entry->data;
-
-		if (state->func)
-			state->func(stream, stream->old_state,
-					stream->state, state->data);
-	}
+	/* Notify callbacks using queue_foreach since it does attempt to
+	 * protect against concurrent modifications to the list.
+	 */
+	queue_foreach(bap->state_cbs, stream_state_changed, stream);
 
 	/* Post notification updates */
 	switch (stream->state) {
-- 
2.54.0

