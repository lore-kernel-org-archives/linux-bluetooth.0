Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F11F3FF1B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412876; cv=none; b=M67u2KasgEx73w/5cAwJEUQv//Ae9t5MbWGohihg8/yocYa9bHAg9luOTPvf6KP13D3/I3cjaTBKyC0Cxmo1VVRgg9HUC0m3EXdLftOTNh6ziTuyUvMhGg8AQWabSZbDvIdDqbnSMdbnwr9NDIuP64N/4U6xGbpx14unVh868HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412876; c=relaxed/simple;
	bh=QAIUSK1ScUk2VtPjt0neU1ySGTnpzmlanwMf+AejOQg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T/5TfehJrUa+Ex+usdXGf/jQuMrK5Cc4qVjskpqGw82qrwgpCWaCBukrhfpiJ9RewY5pdzjwadekvT/XpdEhcbMpBA0pU0bd9awDXM3I4lCx1z1rfX1Rr62czYIn0/M/3vgMAnTeC1Xk+GMo+VqRSqsdgmmO8BrV0iDWOmEiKCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niiFyFdQ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niiFyFdQ"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c04bf4711so18429241cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 05:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785412874; x=1786017674; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MOl4w/YDYTwA/vX6Lt9S2PPzOeYZLYct6jgBogVlH/k=;
        b=niiFyFdQz38few2FqA053Fh7HYuwYZfq8Z1Vv0elcLHKkuA12kbtTLHU6w+GlE3cFp
         Vn1w5VVBB6/v3F4de+/6CDiDu9WG0N9UeyRgtyIdnw90cCPLmmUf6J0DVLY6eeSgf3Ql
         pSzp8V3a+vXBxndyDi4f+5p9gPCrAcDCsK28BUaDZ3CPURPniUob2gU8owB0fyyiwrza
         TYE6K8Zrslg3HPWb7AVpiOmNlJhmgIYDYzrRo56qiD4sMVwxAK5bk1YXCETie76OMMmN
         hj21cqVt2Od7o+QVzJchXSjYYrYFRW4l0oEkLJlrolL3O3tHQ5t/JOTMbfLVkcldmjh9
         WVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785412874; x=1786017674;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MOl4w/YDYTwA/vX6Lt9S2PPzOeYZLYct6jgBogVlH/k=;
        b=kpwVX65nllqgNwCWZxZQfLhgdv1FZqMGbWFNij3ObUIuT+Xy4r7oyWc5Dx8Cg2kbDE
         Ah0wZJeWEZqx+LnjeRTjSWDDrC1t/o0A1RnpBnaGzt+OZf1qZqnD6IOicTIkgjik2nlj
         yP08DcYk+6IX1p/lxTIMSz+23R9ssJ1rpJIQ4ZRJErsgtaJMEfEhIyyhu+YNvskD5X4y
         HXSGJYqO9ajkD2b218PzxwIFEbrtB57t41eqyLAu21iyvNs+d9i3Au637D8sCaugzAzl
         /JI13L9NJSPOU1ttY7tEGNNGeUMrnqgZIEKS9K9D6VNHcCguRaEYheOlhXVLtql5hXZi
         sj0w==
X-Gm-Message-State: AOJu0YySMRIx0K058x5WCqsb8ZW5VKeW7lkrt+h+nO/f5VckP3tGJqQ6
	RgnY2Ra2oyD9LhHAhIQB0Q60iPUXdF5pSD9dJKb02MIu7DC3ZoCD9TmiUuwNmA==
X-Gm-Gg: AR+sD13hZMoaDJRfNQScUpTSNMG9i0gNYHO9dqROFQs/FtvTpHWXZZZayEhhUDa68Lg
	if8LCZGEdSXEHXmJfoTQGwR/sDPeMaN8mK9lUR1rKPsQODbFFWJr1JvVxq9xVLDVzX1wZtL6hCE
	/bDcgOGcvrEljHZE23VIFX4vFlMxD3Yc/rtr7/bcp/apwbLmbr44Gtu/4faP593TEd7QXPTWMt6
	IUDfhnT5ZMaPBuA3LU79rBUXMESYmsbptoeVa0nshdxvV2C7+mgrafbbqZ3j4VVEsFB6JXNnllG
	8xNeza4q94/apVedyoBXS+1vROVFdH2B6iYDsuZzfWPtgFmNHXkpi0qcCP3H+aiDP+adKzq2tmx
	i0G+QcDlhANRq/vlCXnuqpC4xxgxrSEBr9ulpQomz8EDSfFejnm8hdljRPIMO1CcBGFjmqT5QfH
	DQEey++tM4kZrnw8sw0aNLCByX6S/7amle1/EAO3NLB/oHJybZcEwt61GgsYrzvCeco7E=
X-Received: by 2002:a05:622a:120c:b0:51c:404:af7a with SMTP id d75a77b69052e-52b384b29fcmr23383631cf.31.1785412873985;
        Thu, 30 Jul 2026 05:01:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e30f2a96sm39380691cf.28.2026.07.30.05.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:01:13 -0700 (PDT)
Message-ID: <6a6b3d09.a80a6acc.2aae2f.2a94@mx.google.com>
Date: Thu, 30 Jul 2026 05:01:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7384948468031508650=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix accept list UAF during suspend
In-Reply-To: <20260730092331.2069741-1-nicoyip.dev@gmail.com>
References: <20260730092331.2069741-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7384948468031508650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1137271

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.55 seconds
CheckAllWarning               PASS      29.04 seconds
CheckSparse                   PASS      27.76 seconds
BuildKernel32                 PASS      25.73 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      492.07 seconds
TestRunner_l2cap-tester       PASS      60.43 seconds
TestRunner_iso-tester         PASS      79.77 seconds
TestRunner_bnep-tester        PASS      18.83 seconds
TestRunner_mgmt-tester        FAIL      221.14 seconds
TestRunner_rfcomm-tester      PASS      26.11 seconds
TestRunner_sco-tester         PASS      31.57 seconds
TestRunner_ioctl-tester       PASS      26.50 seconds
TestRunner_mesh-tester        FAIL      25.90 seconds
TestRunner_smp-tester         PASS      23.14 seconds
TestRunner_userchan-tester    PASS      19.88 seconds
TestRunner_6lowpan-tester     PASS      23.03 seconds
IncrementalBuild              PASS      25.17 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.246 seconds
LL Privacy - Unpair 1                                Timed out    1.953 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.410 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/514

---
Regards,
Linux Bluetooth


--===============7384948468031508650==--
