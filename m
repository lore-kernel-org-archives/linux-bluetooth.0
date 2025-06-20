Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95DC221DAC
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457277; cv=none; b=E19Ch414fwC4ErHRIsgyo8AEnSUiXsMfEAXbcknylB4l0pIP0Z4tkRpnWYupPOPQeAuVe0u6e5ul6JvfaHN7afrZVFEDku+e9jikme4e+DKzaI0VYwjUDAXXTBMWnMEHjTKPlO3ThHPMJMDL2OfB2ftdcR2s9EYaSP897rlqpjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457277; c=relaxed/simple;
	bh=FB7uKgcTslx1h2a06F9YS/woRWO13z8eiryB5nmJcLc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K0XJMWaTIfBn0Al+X1iHpHBMDv0U6b+KqLMZn/zxfRxS57i+0Uwwsb9LO9FfVD7GyrYmSsGUZc+rJuVYjk4r311h8ZDenwYOXfFJD2le3QOmEiKDc9MFwjbQ0O2YxFFN2UDU+MdsHYNy87BLdnHuWZKXevO+q8ZDkOM8KmnXsCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Blh6+Xkw; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Blh6+Xkw"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d09f11657cso208928785a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750457274; x=1751062074; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+/GK8+N1Oh26R6i09m48unErPamHpEIfTg49ZeGYbpQ=;
        b=Blh6+XkwqGnb8r998d13Kd44SJm5CoCagZoFOpH1zy4kUmBEJWLgSicUow7XtafLnW
         g9VMcIdd1ihWZO46bbggUkwmovaOp/GeoagA8L/8Y0gpaMnHi/YMWYqr3QB87Q9LagRS
         Mf7S0eeW9xLZ9ca/bGGdJcldXG3nXItw+i0Xe2iWykSxQNUUtooZFS3ukA7l0ADWFwqv
         bm2bLKZgljwooWXq8ROSlo6a7UAreisWKoIEABW5RjvjOWaqfCuk+PBR9Et9fdO10iAW
         a05sanSTKZf/euYi8IaUIuSgp5ETnRaydkTmtB9+Ib5v5d1WKZGN0JYSWzxfOrHUopN/
         RWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457274; x=1751062074;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/GK8+N1Oh26R6i09m48unErPamHpEIfTg49ZeGYbpQ=;
        b=Tr6igcT0KQ8bh6wbYk97gM+RMh5sF94WA5pvdoCccLB7AkJfoCytbyvxcyP+C3vjei
         dVDsxvEvF13fvVtskTvOlhNdTB66McL4YBt3kH9nLuYcvfF5cnOs1YBxNzaVWFZSYcBI
         Dw1gF/JyFcEvSah7rEQ6xZL5F0lYGT7LM+8+eJ5KBNP01KV0YBc8cQXxBYXGd1kl6P2w
         krw3197kZ33Jb0FgvVKwf2PWOiPgjDvNFd1iezWFjEpr99gZeZBGdL16NdSbSf1IMrnf
         8OmnU2FVBKXcZBYYjR+LR6fHGSTkjAPlOupSw8YuZJ4iROUWDOOIPTcc7XswDUdJllL1
         1M/g==
X-Gm-Message-State: AOJu0YxJQfLLWa7YLyVvSVC9rCQZZ2eQ/xm3mw184TI+vZixOROQFrqj
	phL7l0BYF/achEDtUR6zTC7IHycTC0lnUePp4tErSA8be+oBtaOpcvnaK2LTyQ==
X-Gm-Gg: ASbGncu3nGlb9Hv8gLNwNDZxLo5tUlO5LRr7dSNLd6LdYldp1ieGXXO5EGAjKsQl82D
	oOUDd8EKXH+vnMf2uxJmStv5weDM2fbMuOLqLBiozwqBISw0G1WHY7YgsXpRxMzX4tA/4Q4f0yI
	ENiMVTsOVM1gD5AI6ODE3+dE5JWFIBZAJ1RSYwj1ahAl26d0qCCWvQJyw2fV2BPwxQ/47NqjBnR
	jSHtB3BMjZUXyLmV6G6Alusdn1dgCNQcbkciWLSNQPSADlNqN99uWseXlBrdMCLowolCgV85++M
	WeompLhS+1WdvKb66WKuSG670cpP3CKqxo3Fp8S7GnObsH/ZUsyFQE4UqSvEw1VBKC1A6A==
X-Google-Smtp-Source: AGHT+IHTc+nQuyVPCNJ8UzYrp/tQ9e+26mdFhCEhry/NCqHzlNXmgGmawBGpG5f8xG1lSwS+SzbzxQ==
X-Received: by 2002:a05:620a:8083:b0:7d3:e88d:a1d4 with SMTP id af79cd13be357-7d3f9915d7amr695592585a.33.1750457274388;
        Fri, 20 Jun 2025 15:07:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.193.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd0957f69bsm16759886d6.96.2025.06.20.15.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 15:07:53 -0700 (PDT)
Message-ID: <6855dbb9.050a0220.24eb00.7275@mx.google.com>
Date: Fri, 20 Jun 2025 15:07:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5602219566441305863=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v3] bap: don't pass in stream's own metadata to enable()
In-Reply-To: <bbaf5b867f3756fcf72b8e0cd9c2e984d2622eeb.1750451973.git.pav@iki.fi>
References: <bbaf5b867f3756fcf72b8e0cd9c2e984d2622eeb.1750451973.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5602219566441305863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974407

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      21.27 seconds
BluezMake                     PASS      2699.55 seconds
MakeCheck                     PASS      20.55 seconds
MakeDistcheck                 PASS      200.82 seconds
CheckValgrind                 PASS      276.34 seconds
CheckSmatch                   PASS      305.64 seconds
bluezmakeextell               PASS      128.79 seconds
IncrementalBuild              PENDING   0.20 seconds
ScanBuild                     PASS      909.61 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5602219566441305863==--
