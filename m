Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE97B3BFE4F
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065387; cv=none; b=rUMhjffLxRH/laW3A8XRQa4HfzKpsJqwQL13cgAkoB2P/ZKsLc6+OvWkQ5xamrkXfaiy/Nmc1uE6t9lcArDR+KkfukUvftVHuPN9B5ypDcQKHfW5VxL02kv/6SVwpT4XqHE+PxtkboehouO7h4TDlSUWsCxL+VgCeXHcr2aOZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065387; c=relaxed/simple;
	bh=L4b6KfuDVAQmBsQi7pBIg4T4VYVtFiH6i1JbDhCqtic=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YzBzqR2xGJMlFEGbu5vluIaunoxGSrmF9eAa6TqR0RyynNN3c/uVYos9Xd42vIvZkp8sDfp42iA/giApT2hmzPZmV02tTXI8RMPyGwtJ5gTHnypntOpPj3+pmhK1kFRn7hrkT3XMGaPR6coDm3WLp8MgwE1xP/fa+n1q0O2iWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtZniDl1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtZniDl1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso29961a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065385; x=1789670185; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jyu+h7pDWLs3qMYCZs6CttbxB4dWBnvQUenhxMiDTqg=;
        b=gtZniDl102Zii68qqz8m8EdDS5q3lXVAEsc3r6RCiOr5MC3m2J71RxWB4+UB3+JFQn
         sjslKy2InvlKt33T7Mt389I6I12+gw+fmi1Tx46SwKjMFodJmUcN/Vt5jG1BhcoAj264
         XFaAu47IDou38GMi7dCEqdsAR7wCEuedn8FJPc6ToxbgpiQjgR6RmDr6DC83V3oHPSN8
         OY1hFz4VU7JYEEAoBfgQFA4S0+poVZ2PXFG2T1L1e1gPcpDYGO4IojQxdXgOWXOUL9NA
         3JvB8geAwtGzBu61b9goSNbLphM9FlOOJgjDWW7SGTBENMc20u0ydx6kRipEn3oL5VNW
         y32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065385; x=1789670185;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jyu+h7pDWLs3qMYCZs6CttbxB4dWBnvQUenhxMiDTqg=;
        b=gqNpViiiFTop0GHBWgqa02y0MEl5s8Ciu7dczOh3xW7LFyHd7j4PPZMohWvKtzhN2w
         fwtZlXrZTGcAOL62yKUXWpe7E1pLOt4mxfhXMTGupdRSHKy5FCyGF454ka1d6nyn4+2s
         bbx/40PtFOF2rmogS/dqCBDvmD65Q3j/5eYZHKlAcsNW/RszAzXKprl8Qe8jm2U2sjAz
         gcEenLbw1gXhAb/8LeewsD08ZSiv2ZvBKeDHTsVCWzvIb19WrGkeIDUSthJlV5QQ8biE
         +9p5WIRCBpCuH3l7yIamlVJRS9cn/il0Fkq0LTwYEGKoli0LUqhhD0KTkbt/wflMzN6t
         gonA==
X-Gm-Message-State: AFuF++mosIrAbDSF8Q8cNVhgWKYW8eMROelBhA2KPodCAOdTV9EPfGl6
	xOds+8Q6fh8I/2wBr0UiC5Cbc2OXTr0eCibxkBoUnAy2EfFeVbDSjbFFmWOp8Q==
X-Gm-Gg: AYBFou2qS8bIS3jbSyhrWU4oAIqFBoB/XS9MN+7IX3OFiLokOQeIWeoWk0kC7msgzYk
	0ti6VDGFBU8V3E46UCykYP8vJdQdR50M4KCF51EOGCi77Zae6/PMKWkUeY7cpxq3r96gkbuhAOl
	rkK7if0rRpqbmn4IYznurAQZo51f4hOqPjDpYocG6+oVxRUiD38vMqozGe591pPSy83/wcrc7ZU
	Gncu+EvZzaWYLzVtGbA4lJoT3KVqQ6Y41twgrm4hXj2Bl3xmKhN1kwJQKqRENtMDRHUAhxo7DOp
	ckiBGRgjMh/UuvPgI1xyg2eqD6RxbK+bLjnce73QeDEQNhwKjsbjiVfSCBsqH2O48ABTBa0DGm/
	kjujQSFH3LxoZaadoCg5XhSUkRB7ORqTKb3jxPUsN0WcFKneXdT7RzWtB9FPJGgbtDiNryHIG2x
	nUm1XAX6HrxAI+oraJrjVpYDt2q0nryuMr8EbMep+BqxOE/ahN1YNi6Asl3h8OsJ1xd+Tn089Iv
	tA=
X-Received: by 2002:a17:90b:578c:b0:398:e6b6:acc2 with SMTP id 98e67ed59e1d1-39b261e7649mr68118682a91.12.1789065384908;
        Thu, 10 Sep 2026 11:36:24 -0700 (PDT)
Received: from [172.17.0.2] ([134.33.71.67])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b78d59sm449232c88.8.2026.09.10.11.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:36:23 -0700 (PDT)
Message-ID: <6aa2f8a7.7c5c4032.147fe4.4e06@mx.google.com>
Date: Thu, 10 Sep 2026 11:36:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0400155012152087051=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, triet.hoang.dev@gmail.com
Subject: RE: Bluetooth: hci_qca: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
In-Reply-To: <20260820044258.1954272-1-triet.hoang.dev@gmail.com>
References: <20260820044258.1954272-1-triet.hoang.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0400155012152087051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1148805/

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      21.50 seconds
CheckAllWarning               PASS      27.36 seconds
CheckSparse                   PASS      27.33 seconds
BuildKernel32                 PASS      21.74 seconds
CheckKernelLLVM               PASS      25.34 seconds
TestRunnerSetup               PASS      566.23 seconds
IncrementalBuild              PASS      21.36 seconds



https://github.com/bluez/bluetooth-next/pull/736

---
Regards,
Linux Bluetooth


--===============0400155012152087051==--
