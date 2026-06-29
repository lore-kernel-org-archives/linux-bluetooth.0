Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664443BFE41
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742313; cv=none; b=iFOEipBFIOoGS+noCBIEQEG/cWYmJ5y2TY6B2Cwb1ImngnxKHFCpFrFCOyUtZ7zK0YZHLbSDCoQDTCdSnLlwVFQKIIwzyja4GMLFZaeI8cFop+yWDJNeH2j+J0WgX/mX2JSI0VpaezCzutRIqau4HUArVO6x5rMzzdD1UWWwnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742313; c=relaxed/simple;
	bh=plijgziijp9hhUa5uABfsKnFvq39ih7JQbrkXC9sNkc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erTzXmh/vSCmHYdgDQ9eg4QVg6A8PbiTdqH8x1e3eSQeWp9pTpOu/RhiUEeb9tjEkaOH9hgUZEHA8A2qEFd1Kkd5/ZsyqBgAwh2MmN4e1Fcy8JqYYIeKqHmHmHAYDrqVJVVHdGBCJvsXaxkI7ldtrn2pXVyG6ZyWWnbHMO95WzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfJjz4g3; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfJjz4g3"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-59c2a81ca92so2610529e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 07:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782742309; x=1783347109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWgaia2diaamOEoQjYG+qo0oKTLO6sMeVn1sN3nRFw0=;
        b=FfJjz4g3t/rWdQo26BX9qnjZkclhD+VAFjKOEVGZ34s2fdFQ2TdobZi+WWJgT+xoxZ
         w5JytqGb0jWDVzyO7EwgPcy7Cl9bYvG+FF2s6p/IHaGF2bYvLPnaWpz6aaU3Ufwl/l9H
         g3otGU5stV8qrdn+3r06U2lrXzAMiBvSkjzS2kYO+Xft8qkA9i5GaCgTb7uvgMzL9etA
         PhNUOAPQz0AYq8YSrBQCwh5qEECwVA8ywuhteR+B5li5XMZ5YVmD8pOvTdMchShyVqwt
         ufNaVlvvj+LIVR2ITEDai8k/J28jKkjilX5oXTnNI7Bxv0QyZBxM0OZYkv2g+LF72HKP
         fnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742309; x=1783347109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hWgaia2diaamOEoQjYG+qo0oKTLO6sMeVn1sN3nRFw0=;
        b=Zi2xaIraHIGjiFAV4j0yI9cpz9tD9KbrdHH5ka5qY915Nm6ZA9uqAqQKXkkb4SsLlp
         +V2Jm1Cc1NdwsCbvOHZfYTmncptB/CWhhFr1dygO57fQC4KKTAktiVJHtMQErE97X2SG
         l+o1xZF9sTT3k+SoY3b9J5SEp77QSy7381buBciDprKwGfW6sp+X8+FRNF9fC3WNIs+z
         8q3RNeGvveOxbv1RAiyt4wKRV7siH3h0uJOLVM4/Q4rlPggJj1wdRmpQEPchX3Xp/zyb
         QPGlMmEC2ejDXRoVaiqdvgpXBxI/hBRpwo8KDwKk5spgg3GIvoG6F8sC3jrc+byKT7By
         FRCQ==
X-Gm-Message-State: AOJu0YwIYHZi4r1F0STLoyI67Q7vjjT9e3/Sb9leVS5V0Npjmij3930v
	vhD7b4kAg6itGW9ATGMu1PXwaFEp7PtNUGMeI/fEs13gmNbgMh8I9cAt9rF4O/mF
X-Gm-Gg: AfdE7cmELkSns8iUpLxkcK+WI5KV0OsTdSRKgNp7bupXRchuXAfqVrgV3Ige43hSGvQ
	LILwyL+CqZ3UIIKZdhy1ZqoqK+9srYP5z5QxaKDQFPzK7bM6MjzKRUFNQfcBdkGsiwTJ2JgUMo4
	N+4ZWUXQWsPaIsRPsTUo93TFRQTLJbRvxyfd+hvinAW5IluJFOQ4Emj+XCz6+KLOqXUq5puRLh2
	LG6sbodqeFjbsbKDPSriysxZ8dYpF0QhxoooxkZ1x98EWRct2wTs2hmwz9Po79nXwzl1hP4Bpzb
	0U5VeEqdHJIGlfPoyh3/Ig/FRNxn4o2QXCInZ2t2i28C0gfogg14CIUrRwkubI32LpNbz/0MwHB
	ushVmgaAWXWKgEjsqw6wk4AGKjaaQ1ZWdo2iEeMaxWHOKprouljPSwOmOcXcKQs+nIMY3NugH3E
	DxUvVuxOZ/ekeOB01+O3u6GCwoZk0CwZ38NBHyVelGW8ykGlYazi2pLxCmancV2WV2GOA+Ypo62
	mVgUOQ=
X-Received: by 2002:a05:6122:1803:b0:59e:71df:c64a with SMTP id 71dfb90a1353d-5bdba9a721fmr486245e0c.10.1782742308960;
        Mon, 29 Jun 2026 07:11:48 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bd78e999c5sm5756883e0c.6.2026.06.29.07.11.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 07:11:48 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/4] shared/bap: Don't transition to IDLE inside bap_bcast_set_state
Date: Mon, 29 Jun 2026 10:11:35 -0400
Message-ID: <20260629141136.947652-3-luiz.dentz@gmail.com>
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

Remove the recursive stream_set_state(IDLE) call from the RELEASING
case in bap_bcast_set_state. This call re-entered bap_bcast_set_state
while the state_cbs queue was still being iterated, causing a
use-after-free if a callback unregistered itself during notification.
---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 9dd07bc5f2e2..6086924a9cb7 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2436,7 +2436,6 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 		break;
 	case BT_ASCS_ASE_STATE_RELEASING:
 		bap_stream_io_detach(stream);
-		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
 		break;
 	case BT_ASCS_ASE_STATE_ENABLING:
 		if (bt_bap_stream_get_io(stream))
@@ -2579,6 +2578,7 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 					void *user_data)
 {
 	stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
 
 	return 1;
 }
-- 
2.54.0

