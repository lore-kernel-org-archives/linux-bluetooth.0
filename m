Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414354;
	b=IcJcx60WkcDV2zRSnnrSHjbwL/KZRiarAnaeHhGjEMgzk04PfKUuTm46RPpFBd8NXPU/
	 D2PRnB24fpRTskRWr5k+X98iTgWPSryfIAjnJzPchn+7mjEl6GpxTAvRcpmM7Tc7OjgB5
	 P0Nw8Wvl1NOSZpn26HvvcurVUT8Myr7Z8tSuXpUNOQ3+bPfqajgwM71SKSai7gTofvnyO
	 TObhWcjCxXIxwk874275DUmWI2aq40WQTfEWRhGiWe7k8ta+T2Bs10EP+zShcpkvDr/wE
	 GygLlmPnZCAYiAiSav2e4ykXg6EVdDB5FZhrh9WsKvSWfFyb7k5pQscvBXkDjwVexRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2TodmAJLaG0Lx6EgcB1ygyLSmvs7KgWcoMn6aVLYBLM=;
	b=lCan68CUdf65W+bQ2VYiJXbE5im6o6YgKe7j2RUMA8ky+WQwJcRBSmG4C7F3qNTqiGh8
	 8GmzXS4YsdPcB7MeO0TLVisLHAounPYcEmtMRQO7uKuXHlrP1dODebdmDSb9J6v6OyQVs
	 KnnevJ3g0kTVHdd7pWPaQ6McEJRR/KxQ2G7ACM7ffpLOehpyieT4xCxffMkCh6VXKblxP
	 /3ArrWVUW9r/kGhvhaMiEFgf/e6X+JhJHtj/mUbKBulbNC34a+sDZYro0G1gResOYAnhG
	 +MFzfPTq5EDeEpqfbQGI//GYHpPniYHNpyuLJhHo1VzI+aTcobiutpm5M6IyfftIoHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BHMmYG2O;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5D606A893
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FE5D606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BHMmYG2O
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ee029fd76aso1394187e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414353; x=1795019153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2TodmAJLaG0Lx6EgcB1ygyLSmvs7KgWcoMn6aVLYBLM=;
        b=BHMmYG2OCvsPtsMKH2hteuWc1yP6XQuHZKF9aiX1FNP8JqBC88AtpoJCKFKffZFZPh
         tK+ngL1B0jR2L6DoRWH80T6Sph0MDiwBdHR1Y8OvLctYhYZZANmZLakmUt1Qb9M1YfTX
         7lFhNUWq11QCj1vQL9RLIJeKFt5MIf/PZDQaddIee9Z2NJ/k9dXAafHEuomlekRfoFw6
         7y6UkGS0oeWdU99/0Jfyy6FSO3nP0RUixwS0o8XMlncfYUqo7q43818zMKsiaXdUmmgY
         k69XTgL9Oxhy9S9elTD3ALdZmhldLSxHdJ9Iq0FQ2ALeQxnV7zd5i11f/FCDWe4Qc+iA
         owAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414353; x=1795019153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2TodmAJLaG0Lx6EgcB1ygyLSmvs7KgWcoMn6aVLYBLM=;
        b=xOdC6S+sAFM6MJdOm9pcSdCqj6Cwc+MwkcHlrGsgnm8qS2qrVueKV0+DrxLnoCcxE0
         8FltQZmAfVB1n+AzUmcVQIQZB+IEfJlmEAoXnmuc9Ipd7CE2MHwGIxawjp70Urc33zK1
         1+alk0eIaYN3PYv2OWvljni515nHkztVPKEgOLuHU6lBj268ZID8GKsxtCi91sFKdKCr
         Zp/U1S4rwTukrAx3l1tHVo0llNyMecYvjCeoEiH1YOTOYSFzAgPliFlYhGoj2fEjbrJw
         2++5l+pTYEsnVFuidmfTFobQ0JxApKyV/L+njcdybDahdsHEL9+WkbSWy32qJHgR/7NH
         m2ew==
X-Gm-Message-State: APuU4Z9g5wzozSWdzarw5CZETvHqWwHGNObEjeM8r/kG97kItHu6BJaF
	kRuamtLENFYtY/APzTDE0H6t5FsXBxsQJigIUot4q+Kv8Ff0e+e70uBy7mZXKg==
X-Gm-Gg: AYBFou3Q7HHC1jvMKcMjGm855gxx5LA1kTeKVleHstl6TDdH/nMS/+bhLwYm6gnGNo2
	1ea0p0PnLay+xngyg0V4G7x2FGQBg7GmkvIfzizxy4P6O0V3CJI8mfxkqOR+M9GYmxua7z9R5hR
	lyH+OT6pQuAT8eE1x4ZO8irj4z02I2In8xEr70jkd04pDpePkZ6H8pGH/iMmAHfdBc94iRUiOGI
	Tfjk6hQuK7gSHHUFoZgph9R46nxNZ895hYsxvqcHK2CL56oKxxPmPLB4BBu6cbAKADdTuUq4vH5
	Dao+WXaQSxnTEZ62WUog/iYy2w7U2SZHEJhC9DPfzxaYpAFwgcc19Soc8dxLhJFie6TzZ9fE1yc
	l2Ly/3Pdr3FD0clohqsmlP6V1MfcepbAKnBwDNV18ScH1p40xvSEDKYzR0VjoTyh/R0l6wVx+ut
	Ji9NHUioB4y55JGOXF0RMfoizEXwUv3RyRVWNBM5JYVFvFrDVN8tLoS3lkgR65gQ0liYiWNUs6y
	vslcH38+3WDI/qeDl4UDB6D37KQ6ZFW2BJ4yT12pclYoCjwtbsJfRZXezHk7yS1uFXjeaBIZCRw
	9CfBRVwAo7tTppfl1KwEYSHMSl+PSHcN0HhrVO2M5xSD9x/6FSYOvp1VooY8J+QDQVVqS+Sutf1
	dJwhd5Q/tpJP0w4oFWewRBwGb2zcU9bi6nS0pZIUd6Gfn+FtCxgtcFHr2Oc37uikHHOOf6vsDJ1
	d8iJE=
X-Received: by 2002:a05:6122:2188:b0:5ea:cd69:7cda with SMTP id 71dfb90a1353d-5ee1c3e578emr1181435e0c.7.1794414353118;
        Wed, 11 Nov 2026 08:25:53 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:52 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/8] transport: Clear the owner of desynchronized links when removing it
Date: Wed, 11 Nov 2026 11:25:26 -0500
Message-ID: <486839102182279ed024915e601dde34581ddaf5.1794414122.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794414122.git.luiz.von.dentz@intel.com>
References: <cover.1794414122.git.luiz.von.dentz@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The links of a transport are given its owner when it is acquired while
synchronized, but removing the owner only cleared them if the transport
was still synchronized. Setting Desynchronized in between left the links
with a pointer to the owner that was freed, which is used when the link
is freed in turn:

  media_request_reply() transport.c:282
  media_transport_remove_owner() transport.c:389
  media_transport_free() transport.c:1854

Clear the links that share the owner being removed regardless of
Desynchronized, as linked_transport_remove_owner() only does it for the
ones that actually have it.

Fixes: 1db06505df5a ("audio: Add ability to desynchronized linked transport")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/transport.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 39378ca19815..496eb379b700 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -370,7 +370,11 @@ static void transport_bap_remove_owner(struct media_transport *transport,
 {
 	struct bap_transport *bap = transport->data;
 
-	if (bap && bap->linked && !bap->desync)
+	/*
+	 * Also when desynchronized, as the links may have been given the owner
+	 * before, and the owner is about to be freed.
+	 */
+	if (bap && bap->linked)
 		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
 				linked_transport_remove_owner, owner);
 }
-- 
2.56.0

