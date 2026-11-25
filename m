Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641736;
	b=lHGlKi5FefSI1+G47HWX5YEyE5w5+mHOZfPPiwkKPUQHIdz52qKNYRX1ojzzNJ3yA8TI
	 Csj5jUxrb8ljS/de29u+j9mwTdIk8INyCtxqxHQiB2kTHyhe63cxlQVIOgGsIpAvbeKhs
	 XmWJjjndCExh3bn+KHyEU4E3X5E3LATLpJIaKrwQTVj6cCvK5rnBfMPOO15pUeZYsLHnJ
	 0zWCTN8OnlTf3s4lTzjwdJUYWiPWSeVPJbt0d5N5HXxHx/ojjCwiAAxHbTUY8jxZDhCOj
	 WI8RciFD5buELwdnM51UXWfwqE7qd09qrSZJj0Vydj0Ay4WG/6cEDwAcE/Ku0PNe18g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=05Le8nfAWoKQlfr9N0uPx8JIgHkY5F60LAhlF1tMgVM=;
	b=J2Dvf45vQvElH7HXOkiNY8PFAmYA5UtozpEWaBVz0gfhEw4aZWThDaBXr/SorXW0ei+q
	 rEkhHZqoYT9uFCVyXQoLRWQg1Cq6gJ/nUIa6hicjEQ0lR21xHsR7nHnvHgH/s90uYIU9J
	 uAVoXd9orjHOuDD7CKezAIzTaw3eSD/51rCM+UWNCLU+NNnoWIXqVcvOO5prXyE1it3ls
	 EfnKeMm+MCJPw2uqM1rMSFpodKneCyJnoVLW0q7q70rbrCXBbzGZMb55YsDjy8U5p5l2x
	 XQWxoup4ZhzdNM+LQ4VPJMfjsxk2sBrNTRqPqxRBVD6veZGWZeVpakRDzffX50mZA9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xcl2CsIF;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD38606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CD38606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xcl2CsIF
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5569551d19dso74605471cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641735; x=1796246535; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=05Le8nfAWoKQlfr9N0uPx8JIgHkY5F60LAhlF1tMgVM=;
        b=Xcl2CsIFbC0pu8tJP9UL8gCXfN5ttDQUkq/y74sMIRH5FrabcRIwn6jYGtyKk9Tbqv
         14Sto/A8fko3VNrg00BSNXr6WOvnFocZkq7qNLFL/Bj39xf75EMQavhbHGs4DXsHT1KG
         RhhO2T85IrjqiDWUW+icI+vxjMHnV1nvhRoPeJEg0fbyzRj4dbKv0HH82rFD+deKKEVM
         yD8PR8zlekSxwuiRW9lOCQ7a8ISao6hyFuK62+JoweN63KS1J9tOatncCWimcCthK9Zn
         06bNWlUyjIb9kDHTXWTF4L1TOB7qllT9Du0UVVnbOtGdgf/1n5+8UWXggUFvnIKRP6Q4
         jaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641735; x=1796246535;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=05Le8nfAWoKQlfr9N0uPx8JIgHkY5F60LAhlF1tMgVM=;
        b=qOUWGTFNvYNDmhAwT3iXWGbfbUe05Bb57/6xoTO5sbS+3kRkj8HZKmJqkTnwSAx7Oa
         plJEfcqQsYsfjQYLfdZXtiigwfSO96cVpdrwktOEZBaK2ml/WmTurfwknUgYGF0jXYpz
         WJgOxC0klMVj6A8ffVnAbqQOQksbT+7UdNqPX9RF5aOBmr2jSmS6VKqdELBc0136TW12
         C0sAZ/puvIIzp49MbZyza8AkF+ZKdu0SYJJfRi5tFs7FSmeSVmkhglZ6HhSyQyspl41C
         4z0W4RVmsNM9/t2R2yi/bMe7YCkkJwW6XAiBgDnEVpVRx+psXTpDf6Q9K6c+cC1JTNIG
         LN1Q==
X-Gm-Message-State: APuU4Z8jiCHmfxR+xXNSgIAWkVgeIvjeDsknu+O3Acdt+/7+4LW6+5TA
	0Ds1ghc9Nttg4Oh3clwcHqyN5+rxR/QUV4DFTPVOdU/efLBpqkhQk1bUc9Y7Kw==
X-Gm-Gg: AZFdTZfB3tbn12pBSgKzG+pIkyyaa9SjLrWmSzynvdEpTXsL7VcXzXnHBIc7qnwlwXr
	oMqSfVSERHnArI6L1dW5wnN3vs97PwVu8mnhdVIlWRn9wHYfHA4GcwFOD4Z+ZOFhHtiuAUL2EJ+
	UuHRgr0RmouXzzjN9GQa9itcDQNJ0owAQTyJqAxSnMgVPVV3efuFFteAsCmT9Y0xG6J1Mxm4gnT
	Pf0ysOL1GR+Vj/3LbAblev4P8WBRMIC8Yq7g4mRp5OqptVTJOKFSiZyPOICb9Dj32aFVo2TWWL2
	/m/ZfRq6H8iVp9NgaoC/8+b4YMMX3OcgYuQdNSOmTZMuzU5zdNT5zA8+Y08IZQLHfW8dfudUN4M
	tiHE0dQBbCHE8Wx54xIpFXEQZad+gKpXnZhm8z754RKkhV0fotHm0d1iccc/0KiuFrw+/19ADRQ
	rnzmJvdSjRAEVO9fRaYO/X6CPk4IMcBXkaysXIrX3DTaVyqzoUPsondbTshFP7dalxPy81ty5lz
	W8mP4ZRgPZp3GK3hngn4zDMdOgf/6l6NRMl31c5xpTOmX7SB8As+C3VRJXhiUp1bQ==
X-Received: by 2002:ac8:5fc5:0:b0:55d:3367:edcd with SMTP id d75a77b69052e-55d6fcdaebdmr370283921cf.20.1795641735513;
        Wed, 25 Nov 2026 13:22:15 -0800 (PST)
Received: from [172.17.0.2] ([172.174.109.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349f2186sm175120976d6.29.2026.11.25.13.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:22:15 -0800 (PST)
Message-ID: <6b075187.7970f310.ab4a9.8ae1@mx.google.com>
Date: Wed, 25 Nov 2026 13:22:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7306407351623490937=="
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
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: RFCOMM: Fix listener shutdown and TTY setup
In-Reply-To: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-1@gmail.com>
References: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7306407351623490937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222282/

---Test result---

Test Summary:
CheckPatch                    PASS      1.52 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.67 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      31.67 seconds
CheckAllWarning               PASS      35.44 seconds
CheckSparse                   PASS      37.72 seconds
BuildKernel32                 PASS      31.52 seconds
CheckKernelLLVM               PASS      32.83 seconds
TestRunnerSetup               PASS      749.95 seconds
TestRunner_rfcomm-tester      PASS      5.58 seconds
IncrementalBuild              PASS      30.72 seconds



https://github.com/bluez/bluetooth-next/pull/1227

---
Regards,
Linux Bluetooth


--===============7306407351623490937==--
