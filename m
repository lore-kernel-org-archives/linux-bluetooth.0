Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793209425;
	b=VjkCABQmdhe/x0cNNk2/vMTde0OROVX7tzQ6+/gVy0LfxGjnI/02rYVHGdX8Ld0FbkYQ
	 cQusqNyqhXzg8gJuWJwCrjuVSap3I2BvaXYHOM4Cb/TikEke49UtnuwPG4EjEIPtNm5mF
	 ttuiVeBPyQdmgXu4WAfsnwLG5B5xVB9T7Kf1pYUnbnQIMLanvQqvFRChhzWGwOqaTBzxa
	 h2mqXU7F3X1WpdgmrntzPR34b2+EopQN2214rUTMQP1TDQ54qqwsEJCre+w/RVBoKVZRo
	 4Qi5fmBB6rohBcyaBrsHE6n+i8JQZUm6J6MaRSM52vawoZNK3lOW8181/hl+JozMMXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=sceaI660snz8RvtuiB4Fbw0/A3zvomosupW/EMLDLW0=;
	b=OKcPUk2JmQ4UVlTzeSpDz+zPbpXE8JP9rL7+EPbM8W2uCqqJIa1QIak1jfCbFVBj2N3R
	 Lb4K+5p04fdef6ttRwNxEXZxF10oFn96YrLBKNS0ib7YgecURn9lCrWNc6aIzCK0mhvhy
	 EJIB1tEBLtGQpflpujRWeKPd1Jer/mLucyj6D0lz4mM7h8sn+9drNqXvTYE3Tm80RGgAU
	 /vi3BMbF5BIel+9yAL9s4HSsrsvmyqgxftmBYFGqisSKTs7f0SS6WJjMJiZ4bjdUP490g
	 zg9YnFLsMKKOUubrTnCRNlpxBUGCXkSrCxIEYqZ7kvqBhXdJfsrEcv8QRbg14dnny1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LVg7k5Nf;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC783606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 17:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC783606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LVg7k5Nf
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4a85c656c58so903568fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793209423; x=1793814223; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sceaI660snz8RvtuiB4Fbw0/A3zvomosupW/EMLDLW0=;
        b=LVg7k5Nfyq8FWrQRReY62ISqnYWCfJuZr0NoZz/a8DzSDeb7d8kmDnFQPwWRih0Y3R
         YfMyJEaAn2g11/kuq/bbA9lU+60mJkTYGACMhKqS145korDQ/4VC/ZwycKqin29rMavU
         k53yct9BacdCIYEapWHeF/CycOSQIhaNV+POwiLl0kYCMRnZ/TYr4mj4DEcS6ZbDhDK9
         +MlUIEKnel5MI7zRWhoLZr4YYVANMVBL0TSl16OR4OYA0Ghk7z9TMBaoqDGEC0zecgEN
         LFCnGiPui6repO6jG7I3ZnzvqYjC774agNJ03L5cvOcF82goarPm3Ei92pbndtEWVgOM
         PA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793209423; x=1793814223;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sceaI660snz8RvtuiB4Fbw0/A3zvomosupW/EMLDLW0=;
        b=T2t903SBWp2h9Rwsiidq+7saDfjqtFHmJPdqlcopw++KLCgZxR014aT9dDa6wVZEql
         0BMOt7cbmbhYhI5OU/MHZTA70jkeVhOnXRbXbqsRJdNy+mewfocg+O284/+pqJ7gec5C
         /u9RufPYoly8MneagHx4kmGay2wQKdjM6MfMD79ztbxp59KJywLjJABR3d8NXPn4zxl8
         n4ywjNfoLDqkD9QsNUw45oZP0SiOg/+7pr0sHbDWb+xF96EuukrY5NPE+ZEVPZ02lT19
         hgFzCxiCbXuf9rpEnXFEcAz0cgTEZ4lw3wuIlLglkotTQyZdYO0lxMIHBChL2XeRtDJN
         3/0g==
X-Gm-Message-State: AFq9FYIz8kg07Y5RBbmc8IPwC6EEp2qJq9PQsd2PeF0kUeco8urHdtME
	KnzZeTRMyjjzYILUCq+4J7tLfsezb363oSZJNoNg0L2AN7Ii7+gqf8r4r9P6Qw==
X-Gm-Gg: AYBFou3oY/S6ROqySUguZvBVTusZqtcs5suK4C4B4ds2UGnRmi5ZHVYXJdaLt0v+Ot9
	KrYMMLos1VsTLL5COJYA8MWCoAq05W1wD560v4VjPnfvnaEAC4putquSRQ1pXwrV/lTda16ePlo
	d13iLcl3ah6ebWiaww6Dowu3VvhLdeEZwhdWsLe0RFbQScmQnbFQoLz5yT7V6CndLZliXHzIRvm
	1brCKo8edhep3Z1mXXt7ctmTB0EI7WmJwHUcNzVIxs9Fqxy47IssrUJLckyr5GvEapcbpkXk13b
	G36aTulBMI7/QSVssoNBGTRNXCUPgw+GT41DIRLePytIiadRp+c8U66S2SGL5w52bM8eLHCfn8D
	fZcOgbdWsQ8FMogBVy6k38UJGyzaELrCHJ6YewQUkXI8JdGszgTSX31SF1qAuujMLC43g/zWZqV
	Pd2HR57FVwjMWqnwBKtg2ViQ7noQSzpSKKvSNz0GH1cAiP5meXAocQ7htYIA2WPzFXZSi6ysZMB
	MX/ZPKAFur9bjQDieL6mlwuE3+TPvALYh+sRijC3IxP6nWlfT+MipSdy9nu1mY=
X-Received: by 2002:a05:6870:2189:b0:45e:25a9:5455 with SMTP id 586e51a60fabf-4a8bb1a2084mr2454305fac.2.1793209423603;
        Wed, 28 Oct 2026 10:43:43 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.237.92])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b77abffcsm3052462fac.4.2026.10.28.10.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:43:43 -0700 (PDT)
Message-ID: <6ae2344f.6464a4ac.3cb0b4.d3cd@mx.google.com>
Date: Wed, 28 Oct 2026 10:43:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0963041818298636044=="
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
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: Bluetooth: hci_qca: Reopen port after power on for QCA2066
In-Reply-To: <20261028111839.2148515-2-shuai.zhang@oss.qualcomm.com>
References: <20261028111839.2148515-2-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0963041818298636044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195343/

---Test result---

Test Summary:
CheckPatch                    PASS      1.18 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.60 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      19.50 seconds
CheckAllWarning               PASS      22.98 seconds
CheckSparse                   PASS      24.63 seconds
BuildKernel32                 PASS      19.97 seconds
CheckKernelLLVM               PASS      20.79 seconds
TestRunnerSetup               PASS      442.62 seconds
IncrementalBuild              PASS      21.55 seconds



https://github.com/bluez/bluetooth-next/pull/1016

---
Regards,
Linux Bluetooth


--===============0963041818298636044==--
