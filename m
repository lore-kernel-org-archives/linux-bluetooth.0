Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BA33F787E
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743225; cv=none; b=QBVDiGhg/DWBi4Qd+Yyg+ecay7dqXP/3kN2+fIPdkqOdYFM1FB7o8k6SqDFvVLNm0w8Fy4ZSe9XFaPoJm7j423pY0EkQrs3OtT/55h+uHqrnN8X/s67nnOl5xHCxyneS1zRxCqEBJL8YVmZr+oGn7YPvPrRkAqYHCjXa8nCOKgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743225; c=relaxed/simple;
	bh=xVjyUMuHLynoN8g83q0hUYdm7KNWtnoosMvI/snXuyM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYqKuAoAWLHJ66rI0HtYyXQ3DQb1mMJD1qkY0HAryHbi9F++tA+Yf1BdfkhcNqsbJKJjIbTUW9sJCvWRFhNbM1oPKcfDriS05jg6lUZkmVAOlqWcX88LSObXtzbDU3oQW1CqUUpodSduKUtTC9EMlAljAI2nEBN0dVmt2f5JUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFK3Sgu8; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFK3Sgu8"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7387013d24aso742530137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782743223; x=1783348023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJn748z7kco//vyV6hl4zmq8Nv0zi3K5zLZa6zqvm+U=;
        b=qFK3Sgu8msyTn+LXs64QWAhA7CM+3xygw/sw5AC/uh+QQQYYCeVLknc2LrYfj8BDTT
         dVbkJi0I0d1VYbjnuUZ3Ac7zqHdkUq7M4opF4KqrZ54ncUbtDvwoaMGgNzgeUNrwzQdf
         qZ3+c56+GfUJzRVYqmhcrIG7+FfB5ZEqlBoucwqmw48/CLnucCJYKVWpFS/HyYu0T/3m
         M5aCBUtDJMEz/lW7INnWfpyGj2nqwtPj3SxJudJHdeMj1kZEYEGINP8Z5ZZm0AkQ3FHd
         9jOu4id+B8C99gYWuE+iumok16Abf8FSBQgJyBPaY/6cdk3lBkv9D/L9Q6POKnFYpZJb
         UJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782743223; x=1783348023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OJn748z7kco//vyV6hl4zmq8Nv0zi3K5zLZa6zqvm+U=;
        b=CRF2ihzQOkxv0jY/BAojhfmcemEmsAwWErRl6blsikfXOUsIk8bLmjw30Fjkz5Rv7W
         hkMM7j1S9hePWVhFAk+L1XY7JgeeIFRzlJTv94ghJ0TkgWx4D8yQckbPrL/7xYPbP0iS
         N0bgnLrVgqrZHmXIHg5yTT7juqOGUzJikkSI1fg8oMPX1HD6kKx0BFC4dhfKZvRb3/sF
         lnFhQiq8yGMKkOznqdyZX6OlCPD6dOp8MhgWWRrs227EX+q08T7J0bt50oJmYH/OmnOB
         6FS0DODOoTT1tmFEtpfgR9G3CvvNp+IiJVBAv38duVUYT7jEQ6SGsg4YKY8BsS51Lx93
         2NaQ==
X-Gm-Message-State: AOJu0Yya2rZq09t+5ukhWuAb+zZyzJZeG+mmj8fAuzhBozXkApwJo/Ng
	5PF1p45Hjdg6gcGSTVOYKvQy/lUc3RVeqbnFhLMzPGOWgNE2Ni/L1WmrfjdxQJyV
X-Gm-Gg: AfdE7cnUld0VW95dIa4z00L36WHW8aBJjOpyKK6CYCMm9U7w679ODNd3p38bsKu5cVW
	jiKqNvr8n66N/Ba6xThKGJ/wFo7RxgVr+aAt7hoBZV6b7fD2EMKZojhoZTfXmUk2Cl5mez5zm+y
	7MZ2irxtBUlaWRJvi4mhFhSEOxB46mOaFoNOTfZ0EledZR40Yv7bYHMCA6xrKAeLD4AaDSVqBve
	WCtBwotdsxIT+oCaRupb9DosRkIMTFJFOWHPDe4O/biMg59ppbfbECfSTGag5iEv7VxlGOLIypg
	NVyC/HNiDGTwE+zjxlRvy5WnQ0SZzQYqvagIkdMMopweshiaa8kkUp9lPJg40p45ydVbSYsq4Gn
	MOFdzdodiHBf/y2SfarBEnCbvQ1KugPL0upqoj+fFkRNX4lq9xJbZMmNGplDmvi4tolNI5ZYbZS
	O+x4dFWTEowkYtrikNBsIIBARhFnwzYGXHxQxNsDcaUfgv6WekcpbMqPLgwjZDIvI8b/zu/bqbe
	pvBVN8=
X-Received: by 2002:a05:6102:e13:b0:739:5c3d:605f with SMTP id ada2fe7eead31-739f8a29c3fmr480700137.9.1782743222601;
        Mon, 29 Jun 2026 07:27:02 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-738f72b4cf2sm1350695137.7.2026.06.29.07.27.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 07:27:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/5] shared/bap: Use queue_foreach to notify state changes
Date: Mon, 29 Jun 2026 10:26:48 -0400
Message-ID: <20260629142649.966025-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629142649.966025-1-luiz.dentz@gmail.com>
References: <20260629142649.966025-1-luiz.dentz@gmail.com>
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

