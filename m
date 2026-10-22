Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692540;
	b=dq0z5wLvnArBj9q0gXI+FO/1KN5XceJnHpLPhAey+XP7LpPILsDRwFdKgQD+VplyqMDW
	 j7mAar2gfgFbXNFm6U0wf2LPvx+XkmW2HeZvKcoW+b8UOF/0KVPLxPIveC2vJxZXhHXjE
	 9NaGvc7bkG0eWhJqlB70tAHUg+v3atTCszHCVkqly96nGKiN77z3UvLeADD1GqwjAFAaT
	 GCb0g/pQoMNeGVqsKFHql5NEhXhID/IlHcUtviSbUbcvqrn1CK9K1EsnKxKOkrhbGnj5E
	 coc1w0mdrkXZe+TSYtlk7siQ+C8oVXN82VxTL8IpIR2JswtxxZuOTfC5Az6ZwCoeaKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=TIMHDSvQjlzVoPonihclTQVzfCh791uVW4fb7jOQ7tI=;
	b=VqgDSssFAAFQGJBXhk91JB0byu4j0vqv88XXCbxCdF18zemtT0WG5jc18Fdree1UHPUf
	 9q6R2G4uXI9K6MJjvb3DBsXyX64091sSvYtxCxc6blbsrTtEUqbHXdzYA1k84Lp3rC9T1
	 4Bk8qlpfgIIZxtKgEPl/LSnEGSgBXcV/7AFtLpDK/vpshD9E8vwrFLjSuP9n/mIpIo/GE
	 lyvwQN3UX4PQJY2T/5a7OrxYUILKVOTqw8Zt0zX3oVBlL/OORcqThKnP0MUKUxWtsdfZK
	 UeMN08Yh3/VeIysPS+fK5ye6fyQfNixkgHbW95/ZdemTQRkcVIE4xbpjIGN2AtEDf7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o2iEieSn;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583EF606A319
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 18:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 583EF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o2iEieSn
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6fe4372c5f3so49287eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792692539; x=1793297339; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TIMHDSvQjlzVoPonihclTQVzfCh791uVW4fb7jOQ7tI=;
        b=o2iEieSn/dBSBa5UyCYcf92dLPX60GF6n7IucL4xf4nQDVeAsRMp7nq+3v8PKuWZOq
         oHUrMsnMK3pDCIVHCn56sDaQ+JDD3szXgzUJOTzq7ZEr9KLNn2RF82UzSrmQjAyWfOs2
         hBkVxyH5Jo6Efk1pKwObz7QACFf4XS2/XAcDXZGvGVZ+HlmuRZOO/WsdSMUT9w/TDADY
         kGj7yTv/rapdgrKXD2fc6bP4T28oAHkYkgjjNfErbBysEsqOV9De6RvA/7QjqZfItjGI
         kTN/IRryltWpnoROO5d6rVGp4jXvv6wR/j3csm+VAdYrX+4D5ci1BPvtZ6KRqVNW3F6i
         5V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792692539; x=1793297339;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TIMHDSvQjlzVoPonihclTQVzfCh791uVW4fb7jOQ7tI=;
        b=pCYikFpEoXgpfX9Wo+YZcMsfcETq4fdmH/Onxh4mVaWi4WMypEBy2mBxhZHoUoO6AG
         KIqj0yPycBebdVWXs+JmB2viiP3ugIVykHKJpjeVeBhxX2SbHGgTZTENQiaa1yiKmpXx
         TUoWAGqu/fSF4ILlUupWxXSl4/dcLGu7iGig0LmPao5Ec6mCiGX31MXIIrgPtVMioAZN
         ubsQPj4lFARgg99hpfhLU4fGE54QiM24uA/QoXjHz+BWZdmthL56Y9OhMcs10AUT+48G
         ixWVm10DYXi8oExttvKJyrOLvqLLNB4Xmixba4fjztAW9zTxRno4VFt6lpd23j+JRA85
         f4+g==
X-Gm-Message-State: AFq9FYLQPhnZFqd/wJf84a4WUb4MJzZDZLXRvjwMSus4HVGAbDKmznfE
	INPWMMoeu6ielyjFFpjQ3hekTBxuQCbKN9fCMZNjokS4wDV21/lIA36rgHER2cAK
X-Gm-Gg: AYBFou1KZjekPw9aIHA9rpVwO7asyzCH8YmuPRoWgyMAV3PiQBIuHM07j0eHhCgQCR5
	pk+AlJIQcyK8cYzJwTuCHqt8rtoc7LEmHw9dFguYlNY+JpIN0X2iRbQes+5ikSvkVcWsT6ae1tB
	mHZceQoRnQECl+AC4VIWtwvTlxAM5Pjb/REKuZ2bURu5z7/hM3ivSkAbSVyaqvnpdsG2FYQwcGm
	JeC5ODYpC++gHgkfEbinrDgLWCg7S0hNmLTfwL0RuN7Hj+36nHU0xIdvWBcHohif/VRqGhoMjg9
	4UySgb1giIiUwtbNWVkjTefQUIaLS9rRPOf27bJjgoGF/Q7gF3ZVm00/zzaBSWjOTePhHaD5cqO
	SuuFudtnQZ4XU7oU3mnWpDEUIstsCd0UB/+u15OGBkV1y2d6zIrkSVr6kKkQFHHQGw9aFtn5fMi
	FauDvjM17ioFybnhi8ccVnwcDeM8ssspaiiIwJ3opMKvmcMRCBLYlCcFdAJj0ufAAg7lWX3G7DH
	LuWNHZCvXj9ER2PSvdny5zGZrVNskDVMIapWAFkyhnPrGp9Dx3ROZGi47pzsQ==
X-Received: by 2002:a05:6820:1c8d:b0:6da:453d:7cd4 with SMTP id 006d021491bc7-70b889e736cmr153385eaf.23.1792692539197;
        Thu, 22 Oct 2026 11:08:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.80.111.34])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b86892de3sm546875eaf.1.2026.10.22.11.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:08:57 -0700 (PDT)
Message-ID: <6ada5139.b31e8986.2e168b.829a@mx.google.com>
Date: Thu, 22 Oct 2026 11:08:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6555290607388841802=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Allow COMPILE_TEST without ACPI
In-Reply-To: <20261022154621.3958803-1-luiz.dentz@gmail.com>
References: <20261022154621.3958803-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6555290607388841802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1191410/

---Test result---

Test Summary:
CheckPatch                    PASS      2.07 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.49 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      22.64 seconds
CheckAllWarning               PASS      20.64 seconds
CheckSparse                   PASS      23.52 seconds
BuildKernel32                 PASS      18.91 seconds
CheckKernelLLVM               PASS      21.88 seconds
TestRunnerSetup               PASS      435.67 seconds
IncrementalBuild              PASS      18.96 seconds



https://github.com/bluez/bluetooth-next/pull/983

---
Regards,
Linux Bluetooth


--===============6555290607388841802==--
