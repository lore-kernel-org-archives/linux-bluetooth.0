Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348251;
	b=qj5z+UnDDag8EL6eWztTpFMtI0gUtDHUCTYcZbDcLJZTH4heJRLaWrbzc2ptH591Gw3D
	 Mjl+12GdcdcTcvcLaukY3cavo2p8sp3m3ajz5urt4/F1/Pe7/kFQN0uKXJZ87jlEpAx3G
	 nRaFjEWkZn9lRRrc3AKrwCYSEgqauuugZxTdSPkRkQPqJAuhGyZXdEOoFPxtGMFTS8hGK
	 HASZ6+5V0ON4Xp2JUvxgdQ7aXq7I1Q+Fw7mPd0fmGtUekPrFdiZZr19oaeQcEkPPEJrOt
	 pS/+Xy0RnSDCYYTdNCNwjYDyVBTDvhi7SjAAKoxPwwOAOOVjVtcgOcMKJocMjYvDirg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GcOQVzEiETB4OL7U9Zwh7hQgb4ZfgcSD/YTNMOb8+xg=;
	b=cQ9A7eAKzl1OYXrLj5NEtNFufGRe5u/0/Rn/YCIt4KeXPKLaOjj0orTPcCmL7viCk24H
	 ioks9tSvU9NL4vCK6Q6RGIriGjw2CqQ+le5P5yseabC8FBo0cp6ClGAbZCRavySJkDOxn
	 4NLLB4T0hsCkppCRgB/fJkdoMIK+s0VnE7+olln4yqKsv8S1x+D8pw2EfLoZGa5D7bb9o
	 cp3sAN2rekihp2ZzW6BX6fG9VGuF43F4NVitJ4qfjsyE2H3f3bdZVJzHykBUy8HK0ycWN
	 Fu+y+vXO0GFkvG2m9iiZQcSTZGutfYRULHuC35WGv/5RqAbXNmM80DoiQBGo0dAWfdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=gq8kyQ8o;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3904606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3904606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=gq8kyQ8o
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so16048085e9.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 03:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795348249; x=1795953049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GcOQVzEiETB4OL7U9Zwh7hQgb4ZfgcSD/YTNMOb8+xg=;
        b=gq8kyQ8o8BczCBg62PhN6huHm9Mo4reiKTWdfrLZpky3Z+uLvRCF2QXV/IFc1WDRcK
         Affc1coZdzwM107hLr96e0U/c0LC4hVxgId880QuvFj9ydQVVK95WGwxBdrTQmcNDvht
         xlHq+IY5zu4Rb9SULTmDnxZwZNA+DvIarkrDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348249; x=1795953049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GcOQVzEiETB4OL7U9Zwh7hQgb4ZfgcSD/YTNMOb8+xg=;
        b=xs/Ec5t3CS6yRdxrbvpq7GzngxytOtk034hhCaFLJJurtAfrWqEEiDctEZy55WTA/e
         rtCV+AkmYjjJGhKfD7/v+WmDFv0zpUIsH1VJwxKyAe+PQGQQABPMY+t7blMlK5VjwEQV
         yQ+NSX0Tr0cdQBb9SsNCMe+WYg/lM+yJGYzCS/uvv67LwpovkhW9J2gIb1eg4wDpd7Ul
         fkoN2GwSo+gNB7OFnl0B3Sud7iEs5uTidILXRCKdBDb8f0Omij4yZHBpE876N9maTrYl
         5Sxv2lo+AS7FnUfvs7HquFIISjgzuRCDsr5QoNofOXNIcuBNhAu5I4zy6IkggvKEHu2+
         xldw==
X-Gm-Message-State: APuU4Z9wE4Z+Nz/ucsgm+9vvr4vRHGjmpZZSSdTgYCkYudYyGrYqAs6I
	j3+YZ+P1cwLn/WWCdQc4g9vPD5qKLoPYTiKciiMmeGOQ4Pm7lTIkuIO7r7HMsNLybofMlXRRIb5
	3cPwF
X-Gm-Gg: AZFdTZfTNboPIu3ihbmxYB4moHt+CJQ0KliSE/rRBOg8CqxAYN1sbEVzWdTK+s03wTL
	FJDeqxLGZRu7tNecQP0wWt70UemJw7fa25A42VqDyHhWDHjP/GovcErv/pLllAtO636/KJprRI6
	mBbg0hylG8+jF8DuExmyOTEt7bi8mFO7pvtZ5EAg/XU/lBc6l7+VHQmcvC8SUwwQGAhNRwIRHMw
	Zw8oYfOCmpo1IS4OlkRYiFC7ZxOFjUD034C2VqhQ9T9i/YG4HtggMbST1pi6GxrcxohqK9GWqIu
	ErlGtLKsmfGtm6iclXEBs7CmjKqTO4qK/PMBOZ/UDyfq271bHsvjgzTF2ctleVQoMO8plsR38Ee
	+qzGrICmJoAKi0iSlCk9/YGB/cRSUhggOX5pRlXE387nyuAE86/9qEWQrwsx1owGjqGX6lh3qRW
	uUEWW9YcARm7GQZztlI4W4P8xB/luUyagVz7AV1Yr5JgEBA770nS4GYpbw0PLIzycXvqtoFdqIe
	14t5nyOFDTL3WvtQLtkZEE/i10nRuRPiQApmKwnjZlKAgQ7k+5wPtGMkAKJJEHEDSACAp85Qvmb
	dnnBcYkw996RgWZ6OxGHfmrMBmf1OD9Wxr6jZ3IAff+JEXpE5w==
X-Received: by 2002:a05:600c:5493:b0:4a2:8c5:5e5 with SMTP id 5b1f17b1804b1-4bb8881c734mr188423545e9.7.1795348249296;
        Sun, 22 Nov 2026 03:50:49 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c248b75sm16538513f8f.54.2026.11.22.03.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:50:49 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/4] shared/bap: Remove broadcast sink PACs in bt_bap_remove_pac()
Date: Sun, 22 Nov 2026 12:50:42 +0100
Message-ID: <20261122115045.1077168-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

bt_bap_remove_pac() looked for the PAC in the sink, source and broadcast
source lists only, so a broadcast sink PAC stayed in broadcast_sinks
after its endpoint was freed. When the endpoint owner goes away, like
WirePlumber restarting, the next BIGInfo matches the stale PAC and
bluetoothd crashes:

  pac_bcast_config (endpoint=<freed>) at profiles/audio/media.c
  pac_config () at profiles/audio/media.c
  bap_bcast_config () at src/shared/bap.c
  bt_bap_stream_config () at src/shared/bap.c
  create_stream_for_bis () at profiles/audio/bap.c
  bis_handler () at profiles/audio/bap.c
  bt_bap_parse_base () at src/shared/bap.c
  big_info_report_cb () at profiles/audio/bap.c

Fixes: d49ea14f70da ("shared/bap: Add support for BAP broadcast sink")
Assisted-by: Claude:claude-opus-5-5
---
 src/shared/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8fc28de52..9404bddba 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4864,6 +4864,9 @@ bool bt_bap_remove_pac(struct bt_bap_pac *pac)
 	if (queue_remove_if(pac->bdb->broadcast_sources, NULL, pac))
 		goto found;
 
+	if (queue_remove_if(pac->bdb->broadcast_sinks, NULL, pac))
+		goto found;
+
 	return false;
 
 found:

base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
-- 
2.43.0

