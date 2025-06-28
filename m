Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF62C2FB
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Jun 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751106873; cv=none; b=Cv4QMdJE9U8KXHQrQbUp0l+YayK0yi5H9w7R6WpxZthfLyjzVx0Y0CKRndKFR7WcVT+QKJeiHSyruqIFJpa4k6thVY6n3jdRTTjr0TsqATvTKeFMyWnZEwxpd9Xwgm09IKfp4PfoQ0vAetnOT2ju6ywKcVYMIEmBUpBzvDa84/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751106873; c=relaxed/simple;
	bh=sDzMy7F/h1cN1J7RIPdc0Lc+Iy+gc0t3s8R9hiCIykA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GUr7dxjAYwkc4M3Nr7In9oEjQrK2F0LgKCNwPkYsV9jY+j5pCK1YTwcfl4WGwZa7veoWIVb76XkCKZSzO/jQVqPdYnPJt+Wua+a1g1LHPTrz0dVlKAuO0S3iovPXUVvlMkxBldAcWWWuFZIWD3GKL+KVNsf0qnXmXnaG6fpCNAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIVhJT51; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIVhJT51"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-700c7f0d9f1so1042426d6.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Jun 2025 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751106871; x=1751711671; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CLbqce8t7qNQoYifl2F6PrXwFF/Lh1poNfolwfHki4Y=;
        b=XIVhJT51MMeXq1yROnD7KFwJHITXFAe5TPJkpRaqEPZNdb2i6tOsBjH4zJgth+ViZ6
         PqAKZ6j/rypcUwaKpRJsClYrSpI7iuR+UQpUTuWM60nhnh+6aaM8WrCXmVhNqhcvrUBf
         ehtdXsAECA9CJrbN7DMjYRpmxwLjUf03V099QXjERn1D2VqUqHPtHuoQlUOTkhuhNI7d
         ULNflJO7Xxz949AFBot5SHIw74aCk7KYtgwq3z7iDbcN20H0+oz+0IAvwWO8gSrgtPvd
         4ANCtm4m/JWJ+xJcyQ6B/DSkva676e1lK4AkeDyXVry8AnJCRhdswgVaTTX/Z807Is6V
         TDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751106871; x=1751711671;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLbqce8t7qNQoYifl2F6PrXwFF/Lh1poNfolwfHki4Y=;
        b=YM2AuSh5RuG8rPKkLNp6wuh0qqzTqMOi+rzNM9OUOWS53RADXjNGwM8dmEU5CZPiNh
         X/2DxSms5CC9x4kHPs88wBE0pkGh9j4YwcPFHLxEyKMsdWJH8rfaLSCStiquNmTmXQCB
         Wn1u0YbJXcGKZ0XJfiANiJjx1kDrikg+VDPrvSFQByl0Ce6nUqOlG06ehg+2ZsU4onjq
         QkzZ720mHrr0A8Dff3QLtdb9VRbCNusLeX2Em2KMIt/gnD/0RGfT/9IvwQQC0Jm8vAfP
         QneCOJjajoI2NT4y8GHWzfyS0+WAUtszF5UFTlRZ6lgEtGfgY8jF9trxQkZZWaTjFvNS
         zA6Q==
X-Gm-Message-State: AOJu0YwlpERyE/kQxavcX4lZkRobO+OQDNddBGxMoBpByh5SRnntoOUS
	ozn2PgaVyX0/G2uCmo7dcCYPMQ75MN40BdMM4TthRKRSmrlu66siM3e1E1TLxw==
X-Gm-Gg: ASbGncs5G20blxhGAJvCQhGWPimonux2ZuAm0fKGzHK8iaK2qof6cxu3ZJL8/k2v5Sd
	i9PA9lX6InVVK+5piM9rtGXAIor9NeFvqdTcjjYcR/5y8b8Eu0qMLNGu+vdO3U1b6Sz7r7seSar
	sFTiaLGbOqoIPCTZywSxoctzcncxQGwk6ogZEKrMYvAYYXJuHddm4tQZI0nIhRUqnlTtgV0PL4A
	HZfrurQV/FZ5NeNZJj7N+mjpD4g+WvET1BGu7Zd4ooUdMPr2QtoOWvsTnht8YP+l9PKT7MejocE
	eVipVfM2UqKq1WL/r4TopTonNZdw3kOBRLwOUyUUx2mptA6LU0m9u7klus6E1xdbMAbb
X-Google-Smtp-Source: AGHT+IG+DNRERz4okvDf/rhjxFaGUvwwNVstdpxS9QVyjqB4fDQZNEAUJDm48oEBFwPNDyFuCHZwnQ==
X-Received: by 2002:a05:6214:ca7:b0:6fa:a5f6:ffce with SMTP id 6a1803df08f44-6fd753f2875mr183706466d6.19.1751106870872;
        Sat, 28 Jun 2025 03:34:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.175.0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7718da94sm35000136d6.24.2025.06.28.03.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 03:34:30 -0700 (PDT)
Message-ID: <685fc536.d40a0220.3810.b9eb@mx.google.com>
Date: Sat, 28 Jun 2025 03:34:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2645237528928628149=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yuehaibing@huawei.com
Subject: RE: [net-next] Bluetooth: btrtl: Fix passing zero to 'ERR_PTR'
In-Reply-To: <20250628103105.211049-1-yuehaibing@huawei.com>
References: <20250628103105.211049-1-yuehaibing@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2645237528928628149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=976902

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.53 seconds
CheckAllWarning               PASS      26.96 seconds
CheckSparse                   PASS      30.49 seconds
BuildKernel32                 PASS      24.28 seconds
TestRunnerSetup               PASS      473.69 seconds
TestRunner_l2cap-tester       PASS      25.26 seconds
TestRunner_iso-tester         PASS      38.34 seconds
TestRunner_bnep-tester        PASS      6.11 seconds
TestRunner_mgmt-tester        FAIL      135.36 seconds
TestRunner_rfcomm-tester      PASS      9.49 seconds
TestRunner_sco-tester         PASS      14.84 seconds
TestRunner_ioctl-tester       PASS      10.43 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.63 seconds
TestRunner_userchan-tester    PASS      6.32 seconds
IncrementalBuild              PENDING   0.44 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.184 seconds
LL Privacy - Remove Device 3 (Disable RL)            Failed       0.254 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.012 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2645237528928628149==--
