Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3281F142E75
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850230; cv=none; b=WqQBotSvja3wgLf7aS5n1E6afyNYFcnIb+2ApZNM4EjONyQ/pIAhLdp6IAU+2Fnd6MUFTlwLK7yEjTtsnOBaOq3WbP2Se3mm3fAjarh4ub5qO2toZvgjxcT2dvabC7Ty3r6vOd2cAV1Y8HC7s7Q2T/FNb98CoSGX9Ok3s5FntQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850230; c=relaxed/simple;
	bh=PqHPX83R97G7eIq/784Jd02Ywg3ig3f/+g+FHUYlLxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhH1oBodjXN1orTrxPTclqz7fFb0TLVN6xLSDuQDqBXf/kxPT9B7TaWE3WmviAYsYS7xD/8z+yMXNFN7tTcUVbjI1iMWuseXUh0Y/N9WqHcxmStmuT3QTE2nluHvzmk0NMQHEDHBVOS4AQA6moo0JKwlxHrO0/0Y39CWe7LrL0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56B001C000A;
	Thu, 16 May 2024 09:03:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 08/15] shared/bap: Fix possible use-after-free
Date: Thu, 16 May 2024 11:03:12 +0200
Message-ID: <20240516090340.61417-9-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240516090340.61417-1-hadess@hadess.net>
References: <20240516090340.61417-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

stream_set_state() might call bap_stream_detach() if the stream is in
the process of being detached, causing a use-after-free.

Return false from stream_set_state() if the stream is unsafe to
manipulate (ie. was in the process of being detached and freed).

Error: USE_AFTER_FREE (CWE-416): [#def37] [important]
bluez-5.75/src/shared/bap.c:2490:2: freed_arg: "stream_set_state" frees "stream".
bluez-5.75/src/shared/bap.c:2493:2: deref_after_free: Dereferencing freed pointer "stream".
2491|
2492|		/* Sink can autonomously for to Streaming state if io already exits */
2493|->		if (stream->io && stream->ep->dir == BT_BAP_SINK)
2494|			stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
2495|
---
 src/shared/bap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1316d7c73d02..0026bc8dc989 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1298,7 +1298,8 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 	}
 }
 
-static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
+/* Return false if the stream is being detached */
+static bool stream_set_state(struct bt_bap_stream *stream, uint8_t state)
 {
 	struct bt_bap *bap = stream->bap;
 
@@ -1308,13 +1309,14 @@ static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
 	bap = bt_bap_ref_safe(bap);
 	if (!bap) {
 		bap_stream_detach(stream);
-		return;
+		return false;
 	}
 
 	if (stream->ops && stream->ops->set_state)
 		stream->ops->set_state(stream, state);
 
 	bt_bap_unref(bap);
+	return true;
 }
 
 static void ep_config_cb(struct bt_bap_stream *stream, int err)
@@ -2487,7 +2489,8 @@ static uint8_t stream_enable(struct bt_bap_stream *stream, struct iovec *meta,
 	util_iov_free(stream->meta, 1);
 	stream->meta = util_iov_dup(meta, 1);
 
-	stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);
+	if (!stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING))
+		return 1;
 
 	/* Sink can autonomously for to Streaming state if io already exits */
 	if (stream->io && stream->ep->dir == BT_BAP_SINK)
-- 
2.44.0

