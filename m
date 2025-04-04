Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123EF227586
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Apr 2025 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795622; cv=none; b=KVfbjfwt4GJLMLdZQH9C+ALyAoVVMLsG+ohHJc3TySP5nZ7/I+v6IZUMBR8wX+fHiqHCFWOfp0eMpe6ZbUFD5ux2/u/bDlRTT/Ct7m25DA7b0uTvMaDPWy85eJomJhARfV7nijCCVQLABRCjFLn0h1swqp147q/3YiYbBA9f9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795622; c=relaxed/simple;
	bh=6MTuJY3lF3nXkrFWIUCXlfQcdvNEPpg1b9L01pRqFtE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nI2BoMgaGXeuV5X8VkhoG0TFSS4fNP6lfQb2SQXlRTnCUzSebxBTGpnQSpFW8iOxPwagjXf1NAm2zTczvAPubNu2AWkD1bnHjOC5AO3/SacOOMnciHIkW9Al4KcXOt/8j7xQdWvekeF0xMLjCGyHDL/K+mLRIyTVuNsKR9F6bWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrLGILAk; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrLGILAk"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so2944697241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Apr 2025 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743795618; x=1744400418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKrVRoyW78yEO2SQvS5IegOdCkHEtUZJqpDGV6Xy6o8=;
        b=UrLGILAkZjStemssUcmt5ZmpAM9JE2etxVZIjQihyghUl2Hjg65fY7pXnBObWYBwRE
         5XWmm0ybiZF4t9Pismih7RAVheT3pLGy9YCn5js3plzXoxSXr59k/kZxjnJlWSGnYU2C
         JSEuI4uHkdBHDuxvyaky67o6DAfm56tHatXClbcDUE5GQXvh1ZrSZRvlwQAuEUh/kuA/
         3ho2hijFD2P6lMGRkyBIREiHApcNh7KAZkIRZoVVnG/4cDo71mhqFCRA6eI65A7A13VQ
         9fM0SYIrAoWFBqtP+8+Vbm5g8O6odb2gkdkeKw4uYzaT6G+dO6vu/E2/Zl+F1LfVrl8O
         HGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795618; x=1744400418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKrVRoyW78yEO2SQvS5IegOdCkHEtUZJqpDGV6Xy6o8=;
        b=ixRKp1eT2IPU48gTGba/23OxY3Uv4m+QV46Fx+rjHRgsKjZabYypuP+a6B3RpKQiZX
         F+XRv4hg7XipKx6xX2dYj2YkZWZqhNN7Twho3TeOrVPbx+kWcmQq+AiydbGkTR27WXx3
         g92sLCCSg9ToH2yf0tAwU6GHl6kd+KYNpGfj6C1YLqAHvuJbsJMURYToBmnpSzRxYG0Q
         BSgpouM/ZFymvhkbx3XVJPyjqN3J4h/PUwVcgzhVqyJLAQ/CBocUUZ+fkaRPqbcXEQA5
         5JC3khecAxgMoPzpsfmAY8wVIEkoorGKcBCwLt7P63+0x14shNWqVcnr7wl/gRXez4Ce
         QV4g==
X-Gm-Message-State: AOJu0YzT9tWAh/h12gd2RYHIyZi919Num/lsBq75p0X3QDCtWq/p4G73
	kgXN2PR+bSC8Otb6HqA9+8+QJtMSFK6c9xrjPNg7qIgzQssr2JoZJ+TTydgUL60=
X-Gm-Gg: ASbGncuIT40NfZ1vmj4jQ2Umyqx+v6F17hfMgqpv+C6LEZ3r5apbV6YbfxcGJbesxq0
	lKrnXrCqW+WZAP+T3FL04PLb4fzlkMAMkGiP9iviPXogWdinjQMzzw1cOPGdoFDO0vW7ciZy4vT
	0grXEBlB8nHHfxJqaAEy7+glwi2PyrJNC9FtLiDtTl2+VDa1SdDkH7w0lYvon1vXPJtQFCVUGis
	K8o29Nx9hEbcKm9SV7w3LoAJsBkmzSYrU4GSjqp2cfq62cdU58aFWLEtgkjk9SnnnIFW5hIBWUa
	OXrbGno94AlfvvmV+SGycqXnNG8gvNSnfxWagyulqgVwMFmeblyavy+1Fmodxys4xcnFqaONeq9
	xCyq3DjSDkFoNUA==
X-Google-Smtp-Source: AGHT+IF+UWbd/b1wdgpeCaKHdGcbEura6KxfSSF7vMpu8zUGQP4cB9NFokHrvBWIQP2p0g2ZbeXYww==
X-Received: by 2002:a67:be02:0:b0:4c1:8ded:2d66 with SMTP id ada2fe7eead31-4c845b9933dmr6742303137.12.1743795618024;
        Fri, 04 Apr 2025 12:40:18 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8738b1d352esm718587241.19.2025.04.04.12.40.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 12:40:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 08/11] shared/bap: Fix not always sending Releasing state
Date: Fri,  4 Apr 2025 15:39:46 -0400
Message-ID: <20250404193959.359008-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404193959.359008-1-luiz.dentz@gmail.com>
References: <20250404193959.359008-1-luiz.dentz@gmail.com>
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
 src/shared/bap.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 650bea2f4e8d..73d1b6192843 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1283,8 +1283,10 @@ static void bap_abort_stream_req(struct bt_bap *bap,
 	queue_remove_all(bap->reqs, match_req_stream, stream, bap_req_abort);
 }
 
-static void bt_bap_stream_unref(struct bt_bap_stream *stream)
+static void bt_bap_stream_unref(void *data)
 {
+	struct bt_bap_stream *stream = data;
+
 	if (!stream)
 		return;
 
@@ -1308,7 +1310,6 @@ static void bap_ucast_detach(struct bt_bap_stream *stream)
 	queue_remove(stream->bap->streams, stream);
 	bap_stream_clear_cfm(stream);
 
-	stream->ep = NULL;
 	ep->stream = NULL;
 	bt_bap_stream_unref(stream);
 }
@@ -1751,6 +1752,16 @@ static bool stream_notify_state(void *data)
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
@@ -1771,7 +1782,8 @@ static void bap_ucast_set_state(struct bt_bap_stream *stream, uint8_t state)
 	else if (!stream->state_id)
 		stream->state_id = timeout_add(BAP_PROCESS_TIMEOUT,
 						stream_notify_state,
-						stream, NULL);
+						bt_bap_stream_ref(stream),
+						bt_bap_stream_unref);
 	else /* If a state_id is already pending then queue the old one */
 		queue_push_tail(stream->pending_states,
 				UINT_TO_PTR(ep->old_state));
@@ -2258,16 +2270,6 @@ static unsigned int bap_ucast_release(struct bt_bap_stream *stream,
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

