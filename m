Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795446284;
	b=sUsjATWOrgmcJ/LNkbXY+jOzV7WXQE84Endaqh0UsBbLKpJag4jkN2fDkaQjV9WQvFtK
	 PtF0/NXchJVn/tfg7zETOCHaUgKMgCm/f1o4BBpggwULS2CgU03gSOTmFg+8RByp3Y8DT
	 ZlRMiW0mt/nrDxARPW3kBrRha7lCFK8b/OIhQMaLCxS4SxhK+TQIEAKigK/bk6Ow1bTOU
	 o+I4fzdbP3hTIIbOHpbEe1v4QddfovwrSZCv1/M7PJEbxCe2mJ98TX4pabMImo+jSAhAt
	 9vqW+han6wJX3btppzp+pkfgpEu6kPCbjSN3ukHkrjRsH1Xxx8W2scyaDMBiu5v/7nA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=o1z2sjLQr8Sfx+Z0vG5c+kPgAcs0xrCYv8DavQudbzQ=;
	b=HbOSevbY7pYhWr+N/VXiazsokbEtAYly7x8indCsPVCTGNdNLc4LbupkKBsRdS8LcwAl
	 2chYOTq/WOxWPz0v+TEYKY6nLjqiKDxri9ZZlEnBy5JBCFCcdtP+m3IdN093NeeJ3dP7n
	 E4r7NOe/ZPRt3RqoJz4elMBk8YECQpspzO7qljDi4O9nYj3VR8CL/hXkdjaV8Xg/1CpOd
	 7ek5rLuNBA5cPZcdz1UySeIllRg7rzW8MU8eKrnyFFG3BbW1sLrtMj+2sHkEd9jzFViVm
	 SPLkarDP/fGbNEYD2Vlr6uGXyLxDdJfOI2uxsBoUATlgyg7/V5J3eF5K8QRhKqczTbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NAQByvpo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91E606A321
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 15:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE91E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NAQByvpo
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-679aeeddc6bso3045472d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 07:04:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795446283; cv=none;
        d=google.com; s=arc-20260327;
        b=jBUTipK5pxfmNFpm9q4aHSt2FDF25r+xxmlCdCUdAL6ylt93dEI9HWk1JZoxlIts6L
         on5MwIMQ4EHVdQDKFuqU2gmn4EJArfvO3kAOHt814840F5OB7UG8q0qLjeQntLfuXrrQ
         HRApNH/H7mQ0SDtVWBPpUFYAhAlde0yyosGAdCsEJWLofzhUOrkZD9MOy+W28zYpM+TV
         YQ3pMFfwpeE5foGg6rHrEMbU2aht0SlTkNjU1z1maTjcJ0i7eKsYOKRyvGx2WsHNQNLO
         pLp/rg3Kqxq1AMD7l3IU3HuO2tpTscW5OiNC7rROb5o5uxa9o2rIsndrns3XuanZEVXM
         2DXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o1z2sjLQr8Sfx+Z0vG5c+kPgAcs0xrCYv8DavQudbzQ=;
        fh=XJYgDvkETP4e4OXOI39kHnN3Aa9uPpApAZWb5/OMrns=;
        b=JKHxEnX78DpVQmg3hRhkJHPqlwfQWrTek7grHG2KbhqA3Faos6eMN6+a24Swd2HPNg
         JMeJ9g5z96RKXVoHVytCZOVqjsdXSz84tjBh0fnG6R8LnCNfMsvuJCaK1O53ox8WX2Hs
         sG9ZdRMCKfMcmPpR3KAXSTCmf0lvdcmgwDcnAzBgzQF001y1XxjA3mPoxwOwMbLZCFC2
         Q3b0hgCqcZDjhV5MxWDpEy5cmX5AHjeFEuCxA4KfMJF7u4R5eBOfhsy3Pamu/Io0mWRJ
         PufOUr5/ixCzZrai9tF3tZ+WHEpkCVKKixkeaMMaLhj4Zb/39RFBkyA9QWT9upsGonJq
         y9OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446283; x=1796051083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o1z2sjLQr8Sfx+Z0vG5c+kPgAcs0xrCYv8DavQudbzQ=;
        b=NAQByvpoSRC3TzNj16/JnpbMYeh8yjm3RGWvtUTn/2IP7SbuKmjPo81AIzcVmcaYOU
         Sps2Al5olBzY/51n3yDQICMqJRXf5ru96TecQ439/6c59inEY8pzCWpl1nc9Qx9WuJWt
         YvTxd1g18UergzO2e+EJShsN9S7AQzvOinMMmCfftmGiXjfROHp6DK4BfWhntT25QOfU
         B1jBTWg1z3sinmxm3FMY2KGAsTdtlxXN33MzsrHafcv5pQWoYwIuDE10G9AF6I1OWr1H
         JWahCuvNTUrs6/9cYfygjbGKzGNt4kmBeL+DpEa9tBAnzYUQhR6TdZaRdcGoR2ZeyUZU
         yS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446283; x=1796051083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o1z2sjLQr8Sfx+Z0vG5c+kPgAcs0xrCYv8DavQudbzQ=;
        b=o7Srdo1mtwffvH/mF9fJ+/MNXi+J7+lIUEgLH705ahsEWTeeZRvtuaIOicODaiydpS
         bWFT69AZySrGQz2l4klyYJU/TCsr3wZ7DpXGC9xjgH8aqhs1CXUfphuujSc/gLhflyE4
         tZ7dea2Px3nDOZ2S68Nk5hm8cioJ9KDcEKdZhX7JiWP6L7PeeH8rRHvlJXVq2dLpuIK5
         3dz+xvJISIuD7YzFedx96Gq0Vj34dtJ6xWDKks1ajzyVljVXffp14KMvOkI5pS9ezxDo
         rtWJUUimV7bg/cDWG2kW6dZmoFsG0t2cv/GRtDwwFlZN4bZdS3+Q4wJKIFMWggVaj0QL
         SeYg==
X-Gm-Message-State: APuU4Z/Q3PBfdqtPFQiKbwZ8HXeD0I84gXbA7Y2NdjirP5ozne/PJwtF
	Jjh/BcfP6abmE5tEfaVuttt2DIg9l0dqQSPf2/+nKzFWTWEJGcv9NRFym2ICDfnCEotR4bHfoEJ
	rcEwf1C033VSJRho/8okjdTlNafdKALT1pOXc
X-Gm-Gg: AZFdTZdUvyIGB0ILKDAFqII+Fy6QIjBqZqucp0suFmOU3fi+y/XqyXDgBUP9CqEOpDs
	vnp8vzyBW7Jf9igcZeguTed/yoNL/ukbkWo6f+Qv/H9BzqtYf9JzcsRDQoTWHN/XeHat2QYPosP
	Y+MbeCE86Atxxk7vCwxB0vvtoA0ZDHF2d13j0Xf0y0pxbKt3eGfzdJZ1N4DY6xd9RFmCg8Sj0co
	/VG/xK6rymX37ELB/8MPZ/93xJK/Yn2r/AodWn011h+yMIXJIH57GuloQjWMm6vCj6gI0zZ1zDe
	JGIWgaZ7yjZ22KSO0u0EHcevGQnWG6H3Z/zmhlo86CUQG2O/yKkxdfgiVMxmicHUwVRBcG7tGOG
	8+99WkJdxRCbeDkBJhKLdgWbwdCeSZW/KCxEF1/KT1nOOMWSwdOxAmACucY0HxcVwh5i6FW7MA2
	393Pl010og+bmOaUjmr4B3l1+Jv8ytdmMmUwD5ap2Dh/rLLGLas4Ykqf2Z
X-Received: by 2002:a05:690e:440d:b0:67c:6e85:56c6 with SMTP id
 956f58d0204a3-67df442280emr2048753d50.32.1795446281318; Mon, 23 Nov 2026
 07:04:41 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122192740.2323438-1-simon.mikuda@streamunlimited.com> <6b037c64.408d4ce3.21a899.015e@mx.google.com>
In-Reply-To: <6b037c64.408d4ce3.21a899.015e@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Nov 2026 10:04:29 -0500
X-Gm-Features: Aa3M54odCNg6zn5MwoFYkqvLTtrBKZXMbP0ocdPNeSRily8va4DqctK_0nUJAx8
Message-ID: <CABBYNZJBA0x5Ki2zbdEmgdjnQdMGRz8mdkE+Uqfvgcncn5qB6w@mail.gmail.com>
Subject: Re: [BlueZ,v2] shared/att: Confirm indications without a registered handler
To: linux-bluetooth@vger.kernel.org
Cc: simon.mikuda@streamunlimited.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Sun, Nov 22, 2026 at 6:36=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1218925/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.23 seconds
> GitLint                       PASS      0.16 seconds
> BuildEll                      PASS      13.15 seconds
> BluezMake                     PASS      201.14 seconds
> MakeCheck                     PASS      0.66 seconds
> MakeDistcheck                 PASS      105.12 seconds
> CheckValgrind                 PASS      110.99 seconds
> CheckSmatch                   PASS      184.07 seconds
> bluezmakeextell               PASS      66.28 seconds
> TestFunctional                PASS      922.66 seconds
> IncrementalBuild              PASS      206.79 seconds
> ScanBuild                     PASS      710.38 seconds
>
>
>
> https://github.com/bluez/bluez/pull/2876
>
> ---
> Regards,
> Linux Bluetooth

Copilot raised a fair point: there is no test that covers this situation:

https://github.com/bluez/bluez/pull/2876#pullrequestreview-6023405971

--=20
Luiz Augusto von Dentz
