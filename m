Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795731056;
	b=huLvVMdmkoItrVgfnTi3YsvkO3nnKI4ms7oB6Imtrfs0qcxrwhrwNTKWP+PdvgT3eCxJ
	 mRq0oTWc6/77ge55UA+sZDZ0Hl+RbpVJX1JW4JuKyAQs1rqu0G4jXHRv9Rk0SDohjzczm
	 3G6G0iqzDUwvZ714lh8pekCM06RSIt+CSnNkTAnD+I7VLVIDYTgX3C6DSjG3epzQW5wBd
	 V5MolMYPDl568lI/KHkp9oKHA/qxrOu59j3z+07VHloJt2q3dRkBbglD8G40VMu72VijB
	 K+mi1mp2bXgaPs/JbVSgPdbD1oYoVA0z007z7h05T+8WG5aj0p94tXdrx7KBbsgJg8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795731056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=jN4fC6U2Q8cIqcEpv2ARYkKsvUqae9Y+8UF2rc7befY=;
	b=IkvMX7WiHniueHYUPKSzlBeR5oK+TMh0d2tqEntErtYfOhLhd9uCB8AFtqMiwGEt4awZ
	 qwSIbq4Yqm0Mkm6CNkdIa1V7itJK7M5qZVs3Xm5acnY8pKZMrskx5qcYAjNwyXaFJrrk2
	 ToIr6WNjFMPCH64PH6jOiPPRQqdrq/q8KCY8HtGugprjMJl51wS3joMOZgHa2MkOAG2cH
	 mkH2log8X1dLw0rKTOE6+8rdTzRRPgCOOKfJfJl8IhkgifJ7VN3GMhJjsgunftzyeVYXP
	 t7tdZJ6uVlR17YjxbWpxuc89j2UzWm/X+WB/KF5Chh0ct0A68dI25MGghpPCcW8VLyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=An+PRLlw;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D3606A31E
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 22:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 128D3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=An+PRLlw
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-86156cf8a7eso5924333a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 14:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795731055; x=1796335855; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jN4fC6U2Q8cIqcEpv2ARYkKsvUqae9Y+8UF2rc7befY=;
        b=An+PRLlwpBAXwu9ASP0Hcn22QMhcX/KaGO126jVtqTptKtNQMCqyXV70iTgRvRbkr4
         tXr7cHsLHw8Y4bDEane97TK8iIr46PF5yqbsnxSqQvDm+9SjQDA+aIRiNmhgc9WfAaTe
         gAN5fHSomE9RJDGRhOacLto55mUNd9S61bIMhQkj/2gTlbYbdGZxBEvrA7EjGFh4PZwu
         jaHlJ2YoqJ0guHsq5WWWKrQSg7VjAPneD8kV2ANOluKpaEq7BG1X5WODYc4hvvJdSUtx
         TWvZMATHvwAOVtAaMeywPXpyoe0wP/nUNSZl+ZNX3+EkBRId+b5mesRJGBEv+KOOHjN7
         lj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795731055; x=1796335855;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jN4fC6U2Q8cIqcEpv2ARYkKsvUqae9Y+8UF2rc7befY=;
        b=HgUL8YCUs059Na3O1hXuzWCUun5YESLHlhUJj7cb2EacWQIMxJfxoysw0WJfEbunIT
         KZUwo4mFP8pf0Ln5fuOglAQIuGVBTIk3h2hEmC9cf+sHjv6976F0/MEE5mE+2I7MypoP
         QY87mwlcDfaHD1VGTSOIGdPLNV8XwSQDz2E119ugo6WsVnw899EDPKZEZ8qhJMVddaEb
         WkXjyrI+8iTqxKCPQJj+36VUzQM5t+tLWS3mrH5kG0Rq8Mg0xQUL6tBsGgodb10EzPS6
         Ev+AiePCOL8+PZGuxgP/VeIbQ24wuczBPO6HMRxCPu5e/6siOidMXa1M560k6l9gkqlX
         Fyzg==
X-Gm-Message-State: APuU4Z+OJbdiVdwOUEMZubjcj1o5e/1x05StqxuXislEzxS58kCLDq/n
	WwkU7Pr462AxTSe2tjWXDGotmFfEqXHP8t//n5ZL8oZcjHb187vjGLPG7XGSuA==
X-Gm-Gg: AZFdTZeA2pE47jCk3/PxmVJqeE/bKU6AhyZ5FvUlEhCd8S9AiPV1l4VVfyYQ/LwOVmG
	HksTjc0CZwgDC+6+fInjtznaHRtK26k6v8qeqVE7J8yHrpUNBSRxoRdl274kJVWRrO0Pk/nj5/L
	FQCTdIZgCVHXQ1RdkGGf03AJU+B+87B46KkKoM9IyoihTYrASMkRxjzjYMBgr6eyu/gLImN9K9Q
	wGYWsG3KkcaykhtzNU8whLo5MuOJu/O4Re6SubvGlCik9EwMPgmhEx44pJp26TvkeNvZYjUHTaS
	wOwom6pIFDNXgkBljSrJJDdutVs65ZlJblhPA5hUTRC/wPuYZOIjj80FZsDsQIlN9SB74MR0o9I
	OqTEcwaMjiaq6qEpOYtP0Qtd3MVf04emjJrrHfM6kSOWD+Ta5KYwJWvSgbiCwUH4F55yETuAocM
	Yxqw91wLf4Q3sCbsBn/0qvNaWrXn365prTeqjbDHfA+SqBt/crwAX7ZhyrmXa1U44ix/9eVDBxU
	B6MA8PbeVmNDgi4wdXZ/G3Caqy4rECaHzAQzL72NyRGCwSkFmRMBtsxIZdHIDM=
X-Received: by 2002:a05:6820:1ca6:b0:6dc:7513:c06d with SMTP id 006d021491bc7-71b327956f4mr15942197eaf.50.1795731054968;
        Thu, 26 Nov 2026 14:10:54 -0800 (PST)
Received: from [172.17.0.2] ([132.196.83.38])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm18628674fac.0.2026.11.26.14.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 14:10:54 -0800 (PST)
Message-ID: <6b08ae6e.36cccf01.14fab7.0683@mx.google.com>
Date: Thu, 26 Nov 2026 14:10:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8871880166135547814=="
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
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: Bluetooth: MGMT: Fix Read Advertising Features hiding instances
In-Reply-To: <20261126161933.923041-1-yaroslav.voytovych@gmail.com>
References: <20261126161933.923041-1-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8871880166135547814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1223545/

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      31.03 seconds
CheckAllWarning               PASS      35.30 seconds
CheckSparse                   PASS      37.14 seconds
BuildKernel32                 PASS      31.23 seconds
CheckKernelLLVM               PASS      34.85 seconds
TestRunnerSetup               PASS      750.17 seconds
TestRunner_mgmt-tester        PASS      88.85 seconds
TestRunner_mesh-tester        PASS      4.46 seconds
IncrementalBuild              PASS      28.46 seconds



https://github.com/bluez/bluetooth-next/pull/1233

---
Regards,
Linux Bluetooth


--===============8871880166135547814==--
