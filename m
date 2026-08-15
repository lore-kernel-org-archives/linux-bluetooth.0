Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FDE231832
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786777464; cv=none; b=gquezbNbOmtUlD+Q5YRZg4idiBCRm88J1o43TdiXdVqQMo9wIogUiTiNXxEe9jAFzuhC53B0t6XlA5CVcWmq5z5mNaW5LY88xA+A9Cswk5J3JRTTUwRiib5FTTBUNeWQFibIgl8QUhM+JX6sgiRk7ZYUAtIGt+jWsdhz8reQHxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786777464; c=relaxed/simple;
	bh=fjAu0bxdtz3fKzsND/aI6odg3IOcGwQZmVGSLEZTPSA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gMEHMsXNZBkBe1tPRLc9NhnV0l4b9maHWVqHKIVCoBhobOxJ91gmcaoRi28AKcGylDfAzIGTHdNDHPOmJGCWmfn4qGKUafIhSOx2YxGkNqrBTfXv0+qhoyWAt5AHLZdn0OpmONxe4ibOva25AVXnSFfGbkCwoNDBxSvdiSx8CvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIMT2nkC; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIMT2nkC"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6ae3faeb9c3so1059018eaf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 00:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786777462; x=1787382262; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hbyBFVW868nnCaokSvjCE1ybnVyaUG7EZRkZ2Z2ewzw=;
        b=TIMT2nkCw7SsA1+pzSQG3Z8XoiDmvNE70ET1qVMwIKx/1EJ+XU8iHfwmuoCNmBQg4W
         naxwLCVtNIqqwH8vnfF5ntUyB/g6yj5/l0vqgESzFPgqwahCDfIBK1lzeUqbdWMe7LE4
         R5w5Iyc/Gm2bUUb7IeCDXfGBGh+JC6JPZtdL0seA3odkUaFxUKZ1m81nRO/p9dHGEb80
         ZJJwUXJvjOrV9DVLv75YrDO5Vrl73qnZNDP/MmuUxs5i08McSqjT109T3ZBCvbniLcl0
         8S3lYcwc+XRpew1MdHFqD/V+vWYP5eoXK2VuzlSNh6qXyzLWETpXeHt9ucboA9qnr6PC
         8t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786777462; x=1787382262;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hbyBFVW868nnCaokSvjCE1ybnVyaUG7EZRkZ2Z2ewzw=;
        b=cWxi6LEVMrUh9dCAAAtFlscmrCF7StssLjN8UQSfGHymbLhaqG6VH9YfDGTzGpZbkZ
         qP1v9b4iuhHJwaLflBuPYIx3WDu2vgnLf9Ig74rTUMxSBtEvvV/+2YTysM0Z/s+s/l4u
         HIHvL+QgHCQC3dVtfiErfMUUwn8xjodoox2YFKXFtLYri6GIA+QLWoVSWan/JVVLGDu3
         UxnUd2GP81lj/0yThiFrWWaXo8OEW18JDk2FHgy2NozVGjtBIU7p8HHuoClAN8LJXUBk
         Zb9ArpTHua61MKV1501l1/wJ/FqSMqCT1/2gIETzxcllg7gnKRHEgi0wY1jJRy0cNEdW
         LXUQ==
X-Gm-Message-State: AOJu0YzcH4umdzuMzc4uhiMYPLfxUXs8Sop4Cmhwml/ObA0VFXd9vM+n
	39xrZnOxi3aFYVFbIk6XZmVI7iH8vHHFb/GfbD3rSrkVX7SewfkhEXucGFHNg7GQ
X-Gm-Gg: AR+sD10Um7C1DhrHptgAcQGdAHejZjehmc1v2KUDoE7RDoOdGjkjz1jLWCTLT5ZDv7p
	95gqu8g3sQrzd+TTMcKu9DLtDPVLYo30snw70Gieh0Bz41na9PndDGBK/TNZOJ9VyQWeyyzAkZV
	IzLgBa3+Tf1jEkBH+8+/MV2AaDxs42U4P5fD6Yb0M2MQMWkSPqcYm8z80T27c45IxcGgxfN32nl
	8M22s4JGVuS05fTXlKFERqdKqVjHqScP/Dzu98GD7Emv9XcrM8im4j8oxVw6UOjIFIFbOURoae8
	yrQVu5iwCgbK+7BWQJtqGKdU7q+hmP1PMPuSiS4ZKl8aEClYItEv1pbN29XHZHgxHmEwZx5BNo1
	zlt2PUXoh6NJI385UbRxdoWLFusVZxXbbS4d+ojt7TiVUOlSG+magjBJN/O2J5TFtKY/YabWnnc
	x0MJbjxDEFQj62zbk7dIFlXhkQt45iLrngdOcPgo7xWFoaqCf2gDtT1XkVOpDoMuZfWZiGYQ==
X-Received: by 2002:a05:6820:2225:b0:6ac:b3b1:a5a4 with SMTP id 006d021491bc7-6b0d5dbfea4mr9559043eaf.0.1786777461822;
        Sat, 15 Aug 2026 00:04:21 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.146.234])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0d963f345sm3861319eaf.7.2026.08.15.00.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 00:04:21 -0700 (PDT)
Message-ID: <6a800f75.77a0a7d7.299ae1.7476@mx.google.com>
Date: Sat, 15 Aug 2026 00:04:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7754405500015136886=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sammiee5311@gmail.com
Subject: RE: [v3] Bluetooth: eir: Fix OOB read in eir_get_service_data()
In-Reply-To: <20260815062419.37489-1-sammiee5311@gmail.com>
References: <20260815062419.37489-1-sammiee5311@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7754405500015136886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146395

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.80 seconds
CheckAllWarning               PASS      28.20 seconds
CheckSparse                   PASS      27.07 seconds
BuildKernel32                 PASS      24.71 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      469.06 seconds
TestRunner_l2cap-tester       PASS      69.64 seconds
TestRunner_iso-tester         PASS      87.24 seconds
TestRunner_bnep-tester        PASS      19.03 seconds
TestRunner_mgmt-tester        FAIL      229.28 seconds
TestRunner_rfcomm-tester      PASS      25.90 seconds
TestRunner_sco-tester         PASS      32.23 seconds
TestRunner_ioctl-tester       PASS      27.03 seconds
TestRunner_mesh-tester        FAIL      25.92 seconds
TestRunner_smp-tester         PASS      23.79 seconds
TestRunner_userchan-tester    PASS      20.05 seconds
TestRunner_6lowpan-tester     PASS      23.11 seconds
IncrementalBuild              PASS      23.49 seconds

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
Read Exp Feature - Success                           Failed       0.268 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.430 seconds
Mesh - Send cancel - 2                               Timed out    1.985 seconds


https://github.com/bluez/bluetooth-next/pull/587

---
Regards,
Linux Bluetooth


--===============7754405500015136886==--
