Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213607;
	b=ct3EiUm2lSwr8LO1Hxhw8/di7YIICHH1qWebZXl48d4M+mQHmgmiuahFXPekNaLNWe0q
	 Hd4YGNXJ4J7B8qh928EBGFGIdJ7Z5V8WZamxFqB03rL9IjScd9ZCZyezc2BRi7LbY2btu
	 y+6Vmu0gFEOC4wlQJEKV16bJV3G63UgYX4Ioqymuvjk4zGXfeo0bQcCLB/L1t2VX8yRmy
	 4/g7Ym4+wMJvEJhwUdU+YX5QfTweoDpObF3wPH/sCl1Va5PWxscDEO9TXphkCLPNL08bd
	 depmp7mo1+GFQ2WA228flwhFY1RrJLnRervue+SHXR1ppugkW2N0mcsKTap/Ml5osdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cEWpRNXwLO6tMVnFBy4u1Yu8LTLkEG1xyMaCgV+OMJw=;
	b=ckXEY7180NQ+6qCPucqAz3Qf8CtCcoiygu+zHyT88IBCOWe4VE2u4FpF2DhknTHjEl7e
	 A0qWPh9uHucwn7w41sJ34e4AdZdSC6ZkSyuMlcLDTT1QAg6c1su2ILruL/F68eEi4KPsu
	 4vukI2cZaBRPB0HUPK9KQyOXP1lTz3oFhNQ10/ZXjbwjRLNNRQNSi258y+Ik34oINS7xU
	 ySjH0Eo6uC+MEwRZBa0DbovkTWiOcZSaC/U/v4cMlFsmR9eE8LmQpNqs1hXCUqpcyDiAo
	 I7vVLsdDVXHh75vEtIvc1wlvBUOU8EGwUgqlh7XSFqgdBJ5DPMSqtez1uM+cjrOE2UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PewT9R+E;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B0606A6A2
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 22:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB2B0606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PewT9R+E
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb609d9bf4so2477665e9.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 14:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795213603; x=1795818403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cEWpRNXwLO6tMVnFBy4u1Yu8LTLkEG1xyMaCgV+OMJw=;
        b=PewT9R+EQCHMqiR/1kR2i3HjBigpJLdm+7GjyXVlpgNZceVFfXneL4r9jSmlJLs/6X
         5YKv0oHCqINhuMWIJidD4fRVFspV0SKUebssG17l+9oMX0oPuA8y8u9LRp8/Yz9g70HE
         BpS++sRry73AmuwmbG4AEV1s6ye1wE4QXet6B8LIEjx7s/afMPas2SKqeXWFmVizFlDi
         PIGA4O4Qn+QZWRphvkRivHZCd9JzlmC2HpdFO+RNOdLXZyR9uqV337+Ts7DFrqO9Tlrb
         WVSyc4heM7pPB3jOOIroVBDw/Uo092ZfClpC3u62NjODfc6XDnjJ0WErFBtNUjuMrKGb
         mvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213603; x=1795818403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cEWpRNXwLO6tMVnFBy4u1Yu8LTLkEG1xyMaCgV+OMJw=;
        b=eu/1C6ZIJo+OMb3d5XyKxejbBO/n8ogriYRm7R4Xyy6/YKAX3aapf0BM5/ZU74p73k
         p8SjgpP+tS1EHbL8tmo08VIF7H1ip23pLXwtoQvzRJ73S/IIDSOVnZ1sw1K+mKq3Fwfp
         1m+7Mn8fPMTYeNuNvdLl1bqW4p6f0JYQT3Cq95JT+8vXurICpoMGTksjkreoLcjf+9RD
         7pvHGsLE59cqLRKOf2aGn+CBO0+3woLtoP1JpC/em8QFeVDBRSx3uajceFb9bHr7kOCo
         vT9Ndr8ccJ3TXSUIEmk3IreXChFJQcgEJ+lh+/QzS11sPUZbRV4IjCg5ODq/n/UQwlP7
         38Vg==
X-Gm-Message-State: APuU4Z+Hq3wGt8X1dvgE0agmF+uWyT7hU+6acZO3ENbE5Ly4FTXTSLm5
	daWh2cgcR6oTMyytfaweScJLbGyDEQqqCks0CmUTUARdisAsXsO6QTpldmjieA==
X-Gm-Gg: AYBFou1mm4DXhQUPeyHu1ohaj3zrHXV7s9yK2X2wNOXZMQ9qlVap3DjhCQj0LExTpgr
	OqyGL8lqbFytSOZ1/YkiMpzFcwiH1b8ZnZpaYPi65vTZH10SdRel3B2Wow/bW4eqq4wafZdr34d
	Mb4gFtONTTt7E9XqDxVOd1p0fZgQQIVdx7DihDpBSLlq4wv31Dj4dRL6ny0X1DP/4dIbANri4Pz
	09wlYbzWGKhvtwg8vVEVNawjEGRhEfbVWkt+dAT3+qJR2eO1A9/kwzbT/pHukMheErbGHZ8uhyJ
	VtzYAG3b5vWV6NjOa7+cYR4VmRPc2U30QadgosetLrjYmKAvvr1ReVLvLeDvOp2nQQ+vpS2NwWP
	MQmLjWoUvkV4+m9iWpVimhs8xtm0SUB/jbyUynukI6IfH6mVY0n9KVLgNt7oftk0uS5X3bTMWyt
	HzRZEYZ2oEJKJwM/RZwelkJ5Z+az7Hg5zPlWYSf0k0Q2iDBlxAolckrSQpqPhHUfykO+D0QYcjm
	o1URLcWOdqTabjyM4cn8sJjxzCwk9zGzLHMwezcolQsiGxX1IXhYGOCzIXpGQduC8ff4DS0MvFH
	kUKhq/Eg2UgT35zPvDniDIKa+G5Yl6/eY5mLz7eUxsliJWP4
X-Received: by 2002:a05:600c:8206:b0:4a0:1f9e:5f78 with SMTP id 5b1f17b1804b1-4bb88787d87mr99629525e9.0.1795213603096;
        Fri, 20 Nov 2026 14:26:43 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b39e:f00:df5c:2a51:ff8a:45b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm23698785e9.2.2026.11.20.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:26:42 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ 1/5] monitor: Fix overflow of the name buffer in print_eir
Date: Fri, 20 Nov 2026 23:26:20 +0100
Message-ID: <20261120222624.150321-2-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120222624.150321-1-rolandschober1968@gmail.com>
References: <20261120222624.150321-1-rolandschober1968@gmail.com>
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

print_eir() copies the Shortened Local Name, the Complete Local Name
and the Broadcast Name into a buffer of 239 octets, which is enough for
the 240 octets of an Extended Inquiry Response. Advertising data from
other packets can have longer AD structures: an LE Periodic Advertising
Report with a Complete Local Name of 240 octets makes AddressSanitizer
report a write beyond the buffer.

Size the buffer for the largest AD structure.

Fixes: 854c945433fc ("monitor: Add full EIR parsing support")
Fixes: 99deeea86f15 ("btmon: Decode Broadcast Name")
Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index eddf8706a..bce3bb819 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4418,7 +4418,7 @@ static void print_eir(const char *label, const uint8_t *eir, uint8_t eir_len,
 		uint8_t field_len = eir[0];
 		const uint8_t *data = &eir[2];
 		uint8_t data_len;
-		char name[239], label[100];
+		char name[255], label[100];
 		uint8_t flags, mask;
 
 		/* Check for the end of EIR */
-- 
2.47.3

