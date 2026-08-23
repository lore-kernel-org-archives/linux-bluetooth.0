Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B82E1722
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505507; cv=none; b=hXFoW20nl+c05ZXzt82NoIPgfU2nxGPJkuT9aWPiJx3cdKtfIDG2zzgQbLrVZ/fq7zg1QiKsfai/jCZp0WcmpzHin7I/lJ7KIumPYczYqP2Mlf20KoqLEf/ZcWvoU9Ho6vblcUu63jrDZYf31xcL0WFxLVmDrjmsZ60rgl0MWm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505507; c=relaxed/simple;
	bh=zDPsEgI10I99gCwORRXnarttmNlOQRKbeJtTeCswk6o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BgzRNkluY5EeYOkomaRlBpt8nb/UAJ+J7rGlgfXij3yrUARyNpf+pZNCd5J+H5hq+gGnfUNuiRHxLUUdrsHZexIyQ6NH9+6S1TRZ+B9V7LyumLjnskDfsi1aUsiprZ12clVtjW+HKuiXTWsspZIH/l3Pq6KlROyrIFXMnMjG8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sOHY+nNZ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOHY+nNZ"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4b21f09ec76so1872867b6e.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505496; x=1788110296; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jlO6c5+JUoBAunjnZIqakC4xBIkFqn43JGbnnjKyBio=;
        b=sOHY+nNZOB8UDXo6Wi8pA5EfaUrxDJ/Ey0W8IivpWm2GKhOvcsSU9z3mXC3Ntq4+NO
         iuLchxSCsFBd2pvboet5eKpf0vW6IaWtyQMy0v090B4YLcpULBbujUJOmAcEYtNtCADD
         ingAnCXSpbvGtuctg9BpXRVDIaINzdBXPn/q0R0zhET5X/pj0VgxGsY8h47kx64FksuV
         YvQXbPZPJKc38VwmIQRhR5G1JVYcD+ca3U5xnBClbnmin8/Sa+Osv9VmFhPfX3yfJ5Of
         tG9CxxefCT6tunW0VHm6HfSJv+VJLhRcngIlIkG+nKCbkslavgfhVlC7kpbPePYABPuX
         O03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505496; x=1788110296;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jlO6c5+JUoBAunjnZIqakC4xBIkFqn43JGbnnjKyBio=;
        b=TbD/7We2dUEatAg8kHh49SLK+heR3jU+MQ53/nUlNcbZty2MYC2SHL/QdN1VqkE/u+
         D/xIJENLcVVQS6NJnp2OWuKxWKXUHaDo4ZEhGnUhfg0T23ZJBBX1BSvQD9gJjhYJNx/g
         aiopFMRALrichnXenFVNjUGNWZ8CsyhxmgTZJrHjj1AA1rHCa3EZnqcWyNfGJpZ6AH2q
         NQZ48066X02Sm+k+VkcU5cdsAF1jJ0FOZjBP4hrHwIToec6+FOH25iYodBGhcYMbMoTg
         UjPVgbDsKAryprW8KC4If7511YkzAAIk3c/Lpg3Ibb6/IAbNrdYDm+hclSmXsAvzKJ73
         XKmA==
X-Gm-Message-State: AFuF++kA/MvKKGFdnbAxq/aO+q2t5mUbTcrzCjBkPeOJIag4jzh6n0Du
	Mn7AOjvIGgmShF/lnpl6VKz0ygYn/G2Vin9h2aP7ESnfaRA8xGdBkZ3PaUzROsoE
X-Gm-Gg: AR+sD13SLTt05IRywpCDqXVOt6BZq4HI2BTxA4Q8U4GOgYmsMoPlwFNGGwga0KbABK/
	+l7444x6Z/sdPBs8yczpjz22RDXN5yGnZ+rdY1+dhuNbqpdvzN+t8w9UCn+h3Sbnf3d5/oeb6dV
	4mCwkK/76rTM/hzkotlP1JGfr/17+7w1vqYn9A1jxt2r4KIrUy+h07x8npEKmOjfN0n+NKNnS1S
	Hqu6KaN7EqCPLQxiLhVi49dlLNUazMu7gljHznOnjqWkUjHPtWykr3Ju0g7rDPhC5+2iDM9NUpR
	6FLVImr8x/eUxf6+9FqGI+4SacRhPBQ5h+reuUgCedpY9/BO+4dfvE4XozwvgjzicFgJBNN27Uj
	hpGFLI9VI6m9BwdEGmGZIfSS3Xw8+8e6ClcRPZgOvftQlQrjCxkfurpY8EY+g2ElQly1jqCNRei
	CBAoSuDbVF5xyTi4yEK/kLRnsI4TDHfHQbjt7MWn98K4w9tOBMta7M5pD7uqhN5VfKIwbHLWSpI
	fQATQ==
X-Received: by 2002:a05:6808:c1d7:b0:4a4:934:b316 with SMTP id 5614622812f47-4b2ef4fddc7mr22929260b6e.21.1787505496495;
        Sun, 23 Aug 2026 10:18:16 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.189.16])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b32c834d0dsm1512647b6e.10.2026.08.23.10.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:18:15 -0700 (PDT)
Message-ID: <6a8b2b57.12ed5c4a.59cf1.a36a@mx.google.com>
Date: Sun, 23 Aug 2026 10:18:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0733497087753544917=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, acharyalaxman8848@gmail.com
Subject: RE: Bluetooth: hci_codec: validate vendor codec count length
In-Reply-To: <20260823161638.32348-1-acharyalaxman8848@gmail.com>
References: <20260823161638.32348-1-acharyalaxman8848@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0733497087753544917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1150464

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.30 seconds
CheckAllWarning               PASS      27.63 seconds
CheckSparse                   PASS      26.36 seconds
BuildKernel32                 PASS      24.39 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      461.06 seconds
TestRunner_l2cap-tester       PASS      68.63 seconds
TestRunner_iso-tester         PASS      80.81 seconds
TestRunner_bnep-tester        PASS      18.78 seconds
TestRunner_mgmt-tester        FAIL      226.98 seconds
TestRunner_rfcomm-tester      PASS      25.28 seconds
TestRunner_sco-tester         PASS      33.01 seconds
TestRunner_ioctl-tester       PASS      26.44 seconds
TestRunner_mesh-tester        FAIL      25.89 seconds
TestRunner_smp-tester         PASS      23.25 seconds
TestRunner_userchan-tester    PASS      19.90 seconds
TestRunner_6lowpan-tester     PASS      22.91 seconds
IncrementalBuild              PASS      23.20 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.256 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.567 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/638

---
Regards,
Linux Bluetooth


--===============0733497087753544917==--
