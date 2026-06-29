Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF940F8DF
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743224; cv=none; b=U2QlOvxc/w3CgtuG9PJv9VIseAdcici+3rbQTYerY7i4ZQo664CFE+9zamlT4cKp36T8Bv5bnosWjti5+OmGgpO0f6o+SWymq+6yijCOkZcCD1jsXKtuexbfImv/ZtPUUw40urqaGlSbvDnTi5s5ytHUIoZ09BpZtLhN5tOBuqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743224; c=relaxed/simple;
	bh=plijgziijp9hhUa5uABfsKnFvq39ih7JQbrkXC9sNkc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPdYyAoyBZ9JkECSoFsCw+LNx3HkqaqOXVJyEc+Fi9UnWSwCtgqbVAdhpt7+fVVkVlkKyH2Iy8MOeKoXU6cQAsIgbzbl9M/UnJlWB2EwMZAVEXysTJCLJZTDSLTLSVQigZ0ee1+JRJtAIe9DbchwTdHWu1nAQ+Se1XNN6mN6HSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iO+MpJMb; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO+MpJMb"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9674d727c0aso2620775241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782743222; x=1783348022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWgaia2diaamOEoQjYG+qo0oKTLO6sMeVn1sN3nRFw0=;
        b=iO+MpJMbvmSyXpCSGtHe3+b6NZUHvyvjhf1xYrC6fdpCszmR9npHVSGLsi5ffeoqGl
         fS5dHy7dxdiPIuLjVDusjoHJ5QJVjigKJXJ1inyXV8PFUgO/Vd5tuqlPAkyz+ewNRDhg
         dBVCjnlV3QoEk9HobVmDMWz0TK7MUU1d/SIvjxpTvV6MxYhesU0Ke/Et4duvxB1+njT2
         /h7OOWJcHIDDVjucklIHXpbtM9b2GJRpjp3KS1793Q+FLr1aGKZ3GVS936KApTRSVMfT
         Rjz1yzrEKGI/6x6xsQ1s/6tGCdhIfGdDIt4AyK1QgDjSnzLMAbWhmikfWe02k/FKn2Dw
         XzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782743222; x=1783348022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hWgaia2diaamOEoQjYG+qo0oKTLO6sMeVn1sN3nRFw0=;
        b=rur2uqGRCu5f0A2utz1vm/Z+v/1tFtc0PrM1vxXEOFd2crmizn+pJ45Aw7ZXG7OYZQ
         OyaaaxhsHAg/CH+8KdUaJ+++moxbMZ0pkSL88UvOYmXvgqEichEB/Kvs8/yZYUaCHail
         FHvPFcDFk3nxoVwkhW+xHlTOhCFcFJvSgppCz74My8sRng+XjeGRRPOxIeEGWoVoa0bt
         yVQZg3s0RDNOL+qKnIE3lfBvLzOuIZnEvzNWE2uXQ1g2mACEA1YZH3t1cyCCZlgqPs2k
         wy0eXJGAT32UllT6bOQ56ejK1T8dRiroeXRChPGrggN6JYuaXIx4JtvKO1WPPvFLN++z
         euuA==
X-Gm-Message-State: AOJu0YycJfV4XZWaiZOvZyNM2W5eeu7OR9rCfJ3n+WL9s77fiF2m1ry5
	thQ18yK4LxEFxOtkfTPvqiIhlxY+SujO61wuMUcZLCeytcnmBhpCVicfllq7llEG
X-Gm-Gg: AfdE7clswsk47itYtvzxiQPocDFiTtkQhVr7vEXyO/Gy6+6TToI7ZwDqf1fwlueUmgS
	W4JNSnBjrBoDQuE/W4ktA5TW6G1lWGTynZI7c8bXr8MSC8Rv1rscV0N6xoYdSqPoBlIRwniWrt1
	KjRxjTMcoq2Q/hXx3ot3nQumIcGYx3cGegQhVZZS99JjJhTnW6x+PDiNGRFNrhy5XwmMSusg4L9
	eZSNvdpki2U27As31OoET936u4Da2UcX78joWiu+Se2gsmMLV7kQXBW90ihXmfhurzTLQO/jEJo
	mxEzXS6V7t7OKKTvBnjXbOty6cI8haSvCQQuUefJU7asrfZu1dMbC3HYxoYYc0jFxDj2r7RllD4
	XNU2dwop5BIvLjNeU6mgbPmECZCIIS17pfnOYBUDyEJE5FFAEtMy+N7z7/tDjgw7HzWoJAumaO1
	n152ktXTw0wBxNKuWRpMjbGpZbnW8rk9VELbnkjiUWzDCN2wsGRZbWM88VgN1N6bP6jePag6YUj
	dkX/xg=
X-Received: by 2002:a05:6102:3e1e:b0:613:3fff:febc with SMTP id ada2fe7eead31-73429a93fe0mr6281658137.2.1782743221804;
        Mon, 29 Jun 2026 07:27:01 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-738f72b4cf2sm1350695137.7.2026.06.29.07.27.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 07:27:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/5] shared/bap: Don't transition to IDLE inside bap_bcast_set_state
Date: Mon, 29 Jun 2026 10:26:47 -0400
Message-ID: <20260629142649.966025-3-luiz.dentz@gmail.com>
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

