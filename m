Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305116;
	b=dKUM89M9n+tW9vnbGITDCNJiKvWu4ByKXdAYNl0iLX6CKNiALuPUcFQ83bEUzTkwJ0w0
	 OWKlbkZveAgGY/vjmnAh15jGYIbe+4BBY7+vapsadNK+pK5zOhN7MKdw7fBO7m8wamKOe
	 bozis/1yCxUj0B6Qmm+/yVPjs41x6Y+t6QNgtSGGV9wfr1q4qseBzg6Lqv6ABN7xAonMA
	 xH2yYopJCYhUEuBxgmEakt5N1FcWbEsZPsxL6PVho6cCxF/aoP3b/ZaQQgh9x3vSStElN
	 MZr8VEK3m6SzNQ1thH16aS1GsumC8M2HJO0l1JhA7dJdQHvr5A7RFm4AsMmJyFqJNhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=YH0YjaT2F1yTXNWYeAI2BYW3BRVPswgJRIMODCfGYts=;
	b=5my2vBYJRxRhOyZjN0bkNrQgyrr/39DN5+Edf8BlY+wbla0SBt+CsweNIGAMicjmHSNj
	 N4VeftmPEHJkqPU1GQjh67NK3YmP9MH70hd9l+bkVkJKh0HOUsF8f20UiENZFiG1qpFKa
	 iCS0f7dLcHzruTA7QnO/LNjA0xjb4n0DlxPcOWPMggmgCJDfBOZ8Ep4Iy/bHkfk9Bvsik
	 97etdXci9vsBdRjyaBafccX+4X23nuP32ouYgUyP9Xe04Q6MWWZgTh3xQAFeRJz/Xgz+G
	 EGP45WTvoYnQ8YmiX/qHMYs572xgJeeI7VAD/b1SN3Zm+szGuHmxBaFC9PH75UrEXVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFCzQZ+G;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD03060A3810
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 20:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD03060A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFCzQZ+G
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93ead211f14so3543685a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793305115; x=1793909915; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YH0YjaT2F1yTXNWYeAI2BYW3BRVPswgJRIMODCfGYts=;
        b=bFCzQZ+G3fN9t/ZQo1WAPNx/l1SWLLmvQJARHUgbKa7M4a5actk1MA2FziTl+VfHrc
         b82CqFGcYXg/HW3Jsn3sv9M/Y2mYvlD/aKSAKaHY94ZEYfCJFRnGJGgvNur9chF0Z2Cm
         pOt3II/nn0usOGIGUZKASydrvmu7I/+vKvI6JPDcbrcQx4l3prbQWtYf6PnqSbOoUGZ5
         5xqoX8LyQd+1uq1hlb2jIqCF4whc1ht3siZzUm5PlZzimlOwhhqXr7X9xeO/O5+5IdIp
         VJHhrKYudbVzBc4wDpYgBf717wmag0ZnTvSM3Ib1UXrMO69HDV9STHa0LjJPxxSgqLOF
         ylDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793305115; x=1793909915;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YH0YjaT2F1yTXNWYeAI2BYW3BRVPswgJRIMODCfGYts=;
        b=l2bk4g0SuNDT12k0/W+kBbfj6MlqjvNmUgQPDUDXvylcfDFvEUuGPBbXfhYG8rK9YZ
         iFFZjZOdBQadcJKlK1mC8A/vREHhj09eVvNOqQg0ZEzWTSrzXs5BM3C8WUPyXinq+vMd
         9SbkB+G+VrWqWG3Ex0Ww3+FeEjtv2N9e0r7T1IQyuiaSirzkkKbwLhJ5Y7KqL65XjGKs
         oNtzVXBS0A/txfRwJMkmdarOS5Q0VoJCIEk7DfoYsoj2enYg8oDZeQL9eaOuCrSMygs/
         621V5KvKVVit5hdzLHGVcXQLzD1GqyEMRo7voiWUYPtx5v7Qjugou3y9OGEJtyQN3ywa
         uqwg==
X-Gm-Message-State: AFq9FYIlOG0ZIsRJ1TTFRBLscdsQW0U1RHmAi9OO1DXmTSFZ/rwnK7zH
	7osUcm2lHLe4R17FDMKmyYE/tqNDrlVBgsQTybqMLlIOZPezIT0535nMbDiuwA==
X-Gm-Gg: AYBFou3XaeP+87ljPmvujTFK7z8rFBccMJl0evNqm8Fa6CqA1tB+zevRN6y1xKdpNMM
	Hobh6AUvdyWODlIiMEcVWezDu8u/p34v2ZVvZ2P/YDXuBrqciP7UHqIT6Tx42XZEzERlAlIirdU
	6bov14F/DnKR4LGQp2qL0pRRxAUU94uj5j8ijv2xbq+1W42R2YKleBRZfSqLWLgLhqTmytt+Jk8
	de0MfGUzmWI4hRpwdGmvoMWLRv1vGS5NWBZZccHumodRJ1a6puF3wAd1xUuV1+CAagGqrxIpB8r
	WrGum7JGHw1dSgBH4o9NUC0Z0wUOpErb/NBTvBVCVxf9nt70hH4lM8ErmY6Eah/ZanG6RWwHBH3
	/iC8gPY6P07Zx9RUJDaWvDIuxcLwSQgmzwBXXulKfX2Rt2wt7mgyPC8vi/Hvp36INqIEwgv1W2r
	/xQ9uv1eTZQfkaH9pLw03qpMleer8xX3aPihDHjYAQPIKledh2b3gYZjkgBQds7SRW8vZ1BaWLk
	FBGMj3rtUBrB3osorZXDaCg1y8+m5tyJSrod2xmxAQ2QKGxSRu6wNU/jylLqg==
X-Received: by 2002:a05:620a:3950:b0:93e:618f:8127 with SMTP id af79cd13be357-94413359242mr488280585a.8.1793305114707;
        Thu, 29 Oct 2026 13:18:34 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.78.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94421252364sm31552485a.28.2026.10.29.13.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 13:18:34 -0700 (PDT)
Message-ID: <6ae3aa1a.0a372733.bc8ee.27f6@mx.google.com>
Date: Thu, 29 Oct 2026 13:18:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3012403690348588122=="
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
Subject: RE: [v4,1/1] Bluetooth: btusb: support larger LE packets on TP-Link UB500
In-Reply-To: <7136cfd8f427b90d6d931a836e93dad5ea6164a0.1793296023.git.cochcoder@proton.me>
References: <7136cfd8f427b90d6d931a836e93dad5ea6164a0.1793296023.git.cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3012403690348588122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1196502/

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
VerifyFixes                   PASS      1.90 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      31.72 seconds
CheckAllWarning               PASS      42.74 seconds
CheckSparse                   PASS      38.52 seconds
BuildKernel32                 PASS      31.66 seconds
CheckKernelLLVM               PASS      35.47 seconds
TestRunnerSetup               PASS      745.10 seconds
IncrementalBuild              PASS      29.63 seconds



https://github.com/bluez/bluetooth-next/pull/1024

---
Regards,
Linux Bluetooth


--===============3012403690348588122==--
