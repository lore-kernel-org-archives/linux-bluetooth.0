Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B308302CD5
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826862; cv=none; b=nd8BxMsZM0b2Oeh2XsAYgS4T0+bRG1IHX6TxHwoBZu+sUkonMFqZVh3+julYjPC16C/qIGDv+OFTMwun9zuChlFoBKYWd7HXb9cak13nieWXH3FmCgCCp5t28ZOEs8DpfE3imw8P5Ny5+8C3sSkMFlp2NoyZa5sVZtBVtH5yJAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826862; c=relaxed/simple;
	bh=5EUsHrPHP29sOSwXyhvlYs//iZ2kIGghruNKxigRRNY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=msy+uxYyMjiizfxzcl1PkG/Uwo29xzGZ1EcCgMveKLhiwDNMYa6MZ4tV2KuKSjZqxHDPFpqOPYOU2iirXj4A1Wrndprl4zOoBTZHyalYuuCOePI8GvFwcwhQy9WccSiKSIlBpgXkvrJ6rBcbycmNSTWO9SDWwmiI6hdeww0GePc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAy2Cu3H; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAy2Cu3H"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c01089e8aso5942091cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784826860; x=1785431660; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XxSHfH0yLTALysurhqIGm3YQOHrQ5icd3ex+dBHDV9E=;
        b=mAy2Cu3HXxMvcEXD7vq/gusoD2U/rSfwVsinMNPE+LXDTDFT0TAxJMYiiSt6ncSSVt
         GGnAqmsD51et6nvA+XWi53LugIprx/V7F0pud6XtJqWafSkUQcIZt1t62RVQHJjB9VO7
         f9tLGTRLgOrZu/a0HLUa2t84Ya+vtiMwe8fLcT3TEJ202GKpVTxltcLN92/CK5n98Yvg
         UVGu9HxAVG1v+aTvJEbt7/WwBA36UVm9HyuVVMs61owk8XoWuglxQYarFq8vOOFI4vSl
         iGdOKTLOYH9L4yngsmcnhsAGjdZU8xdPeXFQzJsdg3p/r8csyQWkvBtC7wMlXx9o3h8s
         zxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826860; x=1785431660;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XxSHfH0yLTALysurhqIGm3YQOHrQ5icd3ex+dBHDV9E=;
        b=nlay3WVrBeeI/mLfVyWFiQLcQgdpSQt3NJPh1YTh4rsfAahToYmVwvPFIZVpZAiBPW
         QN7uPrI/9i2Gtcr1d3h0t44zWKnVjJH/CYYnqqm3kK/g+790ZJAdMC/G/kyJcB2wzd3l
         vy7rfPGhRyodJCy6pA85+lbsyup0Pf2SdWbIh2+YkJCluZBj7Cdpa3qc6QdVWvEZ4E+4
         YBSrfbe21zSseDbgmXEzYWQEa/quYUHMpmJLmLmoJ+uuEnSeq4+OOYk944/kg7GkaCHH
         qAyuDjr6PNdst1mcE9J5F3F9tPj697x24Y1jfTjqiX+HaD0+cy8UZPhK/Az6bWBoN3Ix
         jxtA==
X-Gm-Message-State: AOJu0YyHFvsg0pdJIame/DvTh/hSfK6dMDEyU15WOIcnKRpB4UriKd6S
	nJw2J7og+Bmb1VSl+ak8fYyUqC63AnVyOUYwvBmI69CdqKqTP+w/ZFST+RQSxg==
X-Gm-Gg: AR+sD137zWeqtcAH1M1seyqOaFzJVtQw+o1MEzMJwB34QzqSZOq+aLEMg+9A92zVTuU
	4/9No0HCg4g5RtCS+Q29mwdzAtTziIWyphFaFfs83O1aLc6O8CZazgX6R49jSBHeBnaAVuZ+vjd
	Zi4P5ibEGJLUqGS284krxyfnEXXngnJlFcFyUGUsG5kLpzR3u51mEFkuSCkdp7NnLGIuLDVlAvd
	1uqKtqEgY68rVsReyvVmwC+eI1uAa54MPoMteJiamLtuMJ4V+KG2yMuIIUFJDdTNLDlhjR+6vie
	OrQC8BuRl+G8aFIPVbzF/y9k/Fz13q+jSRP4TG9GX26Dl13FkqhO5laFOp7nQbwuBNtzmHLf8rK
	JmS1C7gH8yWyK4J9oXA+huQvWOhWns3U32L8tsThuMSak53BznBBOMgw7fntp/ZN/F2VR6F7HPK
	rBVAEDf5Hcwg==
X-Received: by 2002:a05:620a:3704:b0:915:5cbd:1d96 with SMTP id af79cd13be357-9310360605fmr406344685a.33.1784826860066;
        Thu, 23 Jul 2026 10:14:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.176.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a036dasm457043485a.29.2026.07.23.10.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:14:19 -0700 (PDT)
Message-ID: <6a624beb.068af3ef.37f5d.20a8@mx.google.com>
Date: Thu, 23 Jul 2026 10:14:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1422301435647526518=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: Fix advertising data UAFs
In-Reply-To: <20260723153440.3224299-1-nicoyip.dev@gmail.com>
References: <20260723153440.3224299-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1422301435647526518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1133349

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      20.64 seconds
CheckAllWarning               PASS      22.71 seconds
CheckSparse                   PASS      22.03 seconds
BuildKernel32                 PASS      20.53 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      362.71 seconds
TestRunner_l2cap-tester       PASS      47.86 seconds
TestRunner_iso-tester         PASS      59.20 seconds
TestRunner_bnep-tester        PASS      14.82 seconds
TestRunner_mgmt-tester        FAIL      175.90 seconds
TestRunner_rfcomm-tester      PASS      20.03 seconds
TestRunner_sco-tester         PASS      25.31 seconds
TestRunner_ioctl-tester       PASS      20.43 seconds
TestRunner_mesh-tester        FAIL      20.60 seconds
TestRunner_smp-tester         PASS      18.07 seconds
TestRunner_userchan-tester    PASS      15.68 seconds
TestRunner_6lowpan-tester     PASS      17.92 seconds
IncrementalBuild              PASS      19.86 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.189 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.830 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/483

---
Regards,
Linux Bluetooth


--===============1422301435647526518==--
