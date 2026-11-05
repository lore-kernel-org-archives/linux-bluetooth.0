Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917008;
	b=wj9Cl9xJ3orP1fwmirp5LAhCjgsgPzJLe2swbXpfEMV1s48DcyRT+BYjNUqfjoeOqrKx
	 YUobj3Vr59x3PI2qkp43C0eVFjo234vhxm0L0fU5dRelUZLsuzXvVIzmKb4Dt7hRhzu3m
	 Ei9wmjTCYGU5wcoSs9ErQhk+bDLMlol3G2OyBdDWTpKYk1IG9m4DSeocDP15pdvifetd3
	 CTJqof5tx/K6PdSjVPWhgDvhuQw4M7G5h5LMrtUfQ4THUddUNozmJxIpvAnF06ZB30xYL
	 lriDDaKCQ7p8JWo2Ftmfm69HVriiqeyxWCTyuDJFNd1T8P7Hdx/uW+iJLybL71Bva+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tiN9jGyxDCQIm9Vd5hXGBbGHl9C1PhHqQqTlkkrI4yo=;
	b=DpI7FakF45UGSOYhit27oW3XRh6F+aPBhQrAOeoestX9rLiRtnd4IWxAFWtHZ2+78JlD
	 7Mz4rfuprw37jX91BqbpGjEkq5ZoUzzxSKNCjOyvtW2rBI9D1Qy6y2lQpoxmnIruL0eFU
	 MwCBK7qOULyjvDhnRQBCf6nNz0enJ0mLVxql22iKiMhY+Es6OcWBRHSKLOSUFC8CLC2cH
	 L3o9N8jjxf0sO93CJmWRr2f7+l4Miy0gIGsaY5mWlH8fKNPnVmkw62HUYGtcIsvP7RoJw
	 fW2o5TttX+gBTok0FXdSaNS2pkAOPxUjRW61k5EUpv/lltazTryqGX3zcHQ+KAveIHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KnuCPXwJ;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467ED606A331
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 22:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 467ED606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KnuCPXwJ
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-99071945aa7so1266719241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 14:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917007; x=1794521807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tiN9jGyxDCQIm9Vd5hXGBbGHl9C1PhHqQqTlkkrI4yo=;
        b=KnuCPXwJrHX0HrQ0iuZeiiIo3CM8aYOgtQ/pcaof9RW58Ve69aS05VtfDJifeHlWoR
         tUgRFSrd+TEZAecyjohlJ8Ux5hNPLPNB4y2ildY+t84QRZWA+vM23cSuk63EfCwv4wIO
         gwS8URaduKVUAZcg8sdfykEFz3ZkqJsY71uqtbTmDw2xV6XCXMlbxWyevEcAQrstRe2c
         KOw1rYnOA3WV5tBsc8+UKvNpiawzQfkL0pERI+VxNb5UyK5SPxVUib/9VxolJYHp3RbC
         BXyRoyXVr+ae37wIIMDVwQvTB9TU7SPWR1xsf9/wxPrdAbcDthbVQPkB2F3Ub5WXdAXh
         mnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917007; x=1794521807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tiN9jGyxDCQIm9Vd5hXGBbGHl9C1PhHqQqTlkkrI4yo=;
        b=LVcMTUDq4/40z8Sm2gxoHskj1t7MtPpLphuhVI5Mmp2wQZfD3YSO/EAy6/x/vC33Jp
         vAenk19a4k73CFEQPWj9M1MsxC2EltyCEmxn2pbDu5ggDS3mfELzSmUCUV/L7xPN9zMo
         AIzIfW7YwlKpuVl9+mnOrF8fUjJV8YLOIst5zuoKHNCfaWSwPFNIoI8F0itdYo01FIBO
         jK+rIvlPiFrAqBqAWzbdEWULcnU+z9DHjLJaL0mqM/WrB9ImBAOV6CTOUpdFQMyszG0C
         iljsIICs9OpjGRO8FF3QWHHOgena54iYK13LOIx3W/qqChYhmV9/mP9CWXAemOuGReEX
         K1jg==
X-Gm-Message-State: APuU4Z8nV7mCcEXNd+GpCQdgupInbckTlfrQ8OjJvLkY0Ombg8gGcBTe
	6Hmpthv8tJTk8xctEdfZcDu0TtwKZyRWExa4/M5lrtsNWq9fLSF7Y09ZY6+jRg==
X-Gm-Gg: AYBFou0sG3y8/PFmrW3CiAglsnhmLYVJyA3816R7Et5b1soiuOYL6DK9yiJg6ncbvZ0
	Z1EFyelwxrH7bKdrBWl4lShN32dGCCSAyp7ot+t0m53WKlMxakRYviSifS0ZdsGJlQw6TwJ9pgc
	8NR2L7VpvlW8vYvwa2urKCaeJR8OWixJfKzHdpvHBnPfQheasbqLDX2SSuvNIfP8R/0DKT4UvwC
	2eLSGB2SPK9ORGs3Ok76fJQNL59Q1AgdNLsrZ4c7ysNdahigvGxZGGEKVwT+vN5qn3YK2bG860n
	N5/kZJaHyw3ZaFIvMzo7NVS5FDYOAoOnR3z6fRqr4YlBTtSjOyQk93MuwLtyDMxocROTzQxx7md
	4IYcbQO6SCDyq1OD/ePB/R5rc64Ajxy3/tgajQvWI3+n5bl/NlgHRVOPNy2PobTGfO32pX5aBVZ
	2/DXfchIA6bcUaYpDZ9QqV2Jd4a7LBtF5SdFBSrxdY9Zc3MPHSkebcjZWsrFmrTsHrJ0QQow1+U
	YUCHVZJd0CoJHw1QIYyyd0EMDdKx7LXaduKi2QYkFY0Kg0iCJnk/PDJFxBVI+ASE9gH6+D0ojwp
	Yn9gCG/AsDNbHBthZe3Tn6SvLjf24ZM/kDgNU10VXqZwWw+nskOufyzAK05olLCtXY1lK1ZXf3A
	no+NMMUPCexER/ppWXfBS01o2I4DLrWEL40DU+WHe4ngECCGX9LPzna8KPf6Q7XwIzXZqyw7Qhj
	9X4gk=
X-Received: by 2002:a05:6102:6051:b0:7d2:7654:86ac with SMTP id ada2fe7eead31-7d2a12dfdfdmr707758137.4.1793917007161;
        Thu, 05 Nov 2026 14:16:47 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d29d1ea0efsm1355419137.6.2026.11.05.14.16.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:16:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 6/8] shared/gatt-client: Fix parsing Read Multiple Variable Length response
Date: Thu,  5 Nov 2026 17:16:36 -0500
Message-ID: <20261105221638.2332398-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105221638.2332398-1-luiz.dentz@gmail.com>
References: <20261105221638.2332398-1-luiz.dentz@gmail.com>
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

The Length Value Tuple loop never advanced past each value, and a
length exceeding the remaining data grew the remaining length instead
of truncating the value, passing data past the end of the PDU to the
callback.

Fixes: 6ea204dca0b2 ("shared/gatt-client: Add support for Read Multiple Variable Length")
Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/gatt-client.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 2b6da611b9f1..6902903e7b02 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2942,9 +2942,12 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
 		 * current ATT_MTU.
 		 */
 		if (len > length)
-			length = len;
+			len = length;
 
 		op->callback(success, att_ecode, pdu, len, op->user_data);
+
+		length -= len;
+		pdu += len;
 	}
 }
 
-- 
2.56.0

