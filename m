Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256362;
	b=SLSP5lyK7d2NpLONOAvTNGvSUhpALBZlvHhuMmk5BJqiyiXWI9NjcKVwLzRC7ONkFumg
	 vSZj6ikAeKiBv7C866p29qUgn8v4urxBDb1J/uM+d3tRdF0MGYta1ADWNx9EJ2qoqFDdf
	 b+Ox/5c0I8oo7DPpe4pDlZ3Kw/kRmNEVVJWyGXhYL4Uv7SqKnxomMbnRLI2s+Q3YDk/YG
	 1OjR11zrgFz0bBP7sSRzqSlXn6gW9BU/c4qIkgFnXLB0EFhF5t0dJzoGC3yewRMiye4hL
	 caJ1FuQDsJww3y7e/VBMbYdQxnJ7zRlqNrPk60PyirbAq0f3m5no7R51bTUBvdulm6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=/QXPvoIfF3F9hxGB5X0UF8YaazyIaKuMrwWCLkw8uP8=;
	b=0/NJu1XTR4FSDAdahY4K84pvZL5/J2rH35kSjIl4nBjMgKfuRRfrzE4vbiT04l59s9cr
	 akJcZHl64ANphFIzF+tjPrvMSO+1OcBO0QJPwFzEOlhfy3jdD1b7wD7Ldn23nkUejuN/6
	 +AuaExms3zA5AzZDvZuvtfPVfhCoEaWR/Qub2PddXnXvPCCfXPIYzDM+yBAJOhDUv51FT
	 jQchh6vudRAQu6MogT8ZnwMrQnLVPubub62YRGojBXqEANrAH0fFjqh1N1MOMcZaemG+s
	 pUqy8gMGPJ79bAMpyF6IGnoKEH92xt1IwOTsUQVAQHOsqVUD28DL2OKFahuZMxwCI3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VoCqv5b/";
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2C606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 10:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CA2C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VoCqv5b/
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-921367ef6b3so12241066d6.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 02:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795256361; x=1795861161; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/QXPvoIfF3F9hxGB5X0UF8YaazyIaKuMrwWCLkw8uP8=;
        b=VoCqv5b/ScGtJesoiS4mSwLWBiunE19eiXLQbBJiJU1jh0sxAWWcj+gokpdlVKwx6u
         qMHyk7VzghLlZil41pBrdA5K6jF7NMpuSlVUUoLxUNs9rq10zGMShjm2jVJT5x5w6XI3
         UpKYy9JjH0Pd4fMv2a/LRwGW67qqEg+xq+U34Amo2k/Pgzc6eFUh+JVGlZmDA4zSdagM
         G3yYOow3bL4z4U38iTTP61l6df7aPCA7A6WTyFOSmzzyBWwhauFvWKI9L9y9fhyScMoF
         8d8nW/L/Sh+XvtTiKyRaISy7dDQYR/YT8hghrRAXEX+/HIe0HZ/LTtTxVqVYJv9N4zjB
         O6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795256361; x=1795861161;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/QXPvoIfF3F9hxGB5X0UF8YaazyIaKuMrwWCLkw8uP8=;
        b=prScONX1kaxvMTZGCP2VFyzraLm0d3I/R64nhb3aeEEn6f/7EnPkjnqac2o3ip6CoW
         iDyF22JzyAWKzJfUmb/mRzbzDKGaTXXsFDqxmaRRlt2WOKl13eAcolJMBO2Ojw3ARoSx
         /c5suVTRNWX4vWTLP3+SMSQGqlf6L+FrO4LHNyUaX+hr/TzrB+mGibLIWJYOi1ZguZZ2
         auGLYFtUPHTwFpIcRTJyOgUq+iFlD0aqKNXq21eo4fJ4/gdE2q2lshjr3KM7G8uBHIIk
         EAeO1z0Z97/TCalVwfrAxL+h1djPp3veIr9trkuhWt34WSBsloeonWB39zkl1/AbXhRS
         Wv1Q==
X-Gm-Message-State: APuU4Z+MwESK/Ib6Zk0e88zOPDyiG9JrE3Hz+4x+F81gqG+NvnT5oCP6
	yNairaLHCKSjOgumqZlS9Nblal+GUcfSLG/Vy2EHOJWfwhivq+4xxeJlvhVP8NiF
X-Gm-Gg: AZFdTZfWhAcyOVDcRtWKRtO1DsAJCEppjDrAIGboAADr7ebrI/hH4JCZfjY2YXxHe25
	9QanOdkRfRZTP+AVIaDbcW1ymqWcuj6KMHOeWBMPN4vETQaDlu3T+mztYbzvaB/tzArZN6LqCJF
	vESHydkab32tm+lFzo7ZNMMhXlfoTRDoQKn6ddkxJZ/S4i+WII3c/R3FbAqjwjZLPQhGyedKNaG
	wK1bxZt3BvNhU6FzWu+kR6gRCgoLQSAR9bb2ZLxOt9Gj5vphBmS9NLowpXDO0xrobvZbs4UGJGr
	+/Bwpd5ugfNAXK5B/NVPrcady1Zrf1cXy4L/XWY1xcekuMb0ltLvggyh8R0Vn5HlmG7gS1RJghY
	r+1Vqf5nsIygVIkL5a1bC5/dAWDiOmeDAmFYLWojWHx70BTDGzmsCCqlQ/ptBfdMu2JuodHvMGv
	c2OtJHEaGedZBzcLUijkFdHT99+Ud+f+No2Ko+8TDwJpUltfnXnUZbJq8qSo36F9Wff/QWC+29/
	ZVJXJUJhY221wld1E6Ht4hypa9NVCJkMyt2+DRzTGZPUAJo86+4cBPMY0+msgxPOaU2dkTOi9EB
	xvvroL97
X-Received: by 2002:a05:622a:229f:b0:55d:30c0:237e with SMTP id d75a77b69052e-55d76a2047emr98685541cf.45.1795256361415;
        Sat, 21 Nov 2026 02:19:21 -0800 (PST)
Received: from [172.17.0.2] ([20.15.103.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921347a0b6bsm49667836d6.1.2026.11.21.02.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 02:19:20 -0800 (PST)
Message-ID: <6b017028.b225ac8d.1621d.527c@mx.google.com>
Date: Sat, 21 Nov 2026 02:19:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2785260286725193291=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: shared/timeout: Keep callback data alive during removal
In-Reply-To: <20261106042339.811655-1-cochcoder@proton.me>
References: <20261106042339.811655-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2785260286725193291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       shared/timeout: Keep callback data alive during removal
   Pull Request: https://github.com/bluez/bluez/pull/2769
   Created:      2026-11-06 09:57:17+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============2785260286725193291==--
