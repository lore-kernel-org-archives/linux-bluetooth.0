Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E105B5AB
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788742236; cv=none; b=WGIMknjNBpMT8P+r+OcwvKGuZmMhlS2dMl9adhZMoomoARI+RYgNid5iIyUKNOXFTmGIvm9VKrTi9J5wIMAtdd1IpfnOFHbWvmRfq1KLFpz9ofG8POc95doMTYAytAhgeGNY9oL3D2wow6BUK6maV2yTv9e7q7QerPu5BYuRItU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788742236; c=relaxed/simple;
	bh=iFPk2/sLFWDYwzkxfkEvt2pG0zhwf2MGESFNN4vSNo4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=n/r72XnjoI6Kyf5W0gActuu/wFVyKfBAhOUN8s7Luu6R1SycCB74gnDCU4TT6QYhCew3PJPMv78xbIGnS2bzIrlcvO80NtMszgOEvYp9YwasVZXf0p+mK374u97ihwUVewshiHgyoGEDffjcIhSeIwJ3xYqSQ51YnLRTjt9Ho6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VISsgftk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VISsgftk"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9309d4ea213so320870485a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Sep 2026 17:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788742234; x=1789347034; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0eJ5TvqlGtp7+n2fF+/KcdHTBkBZ14rYysNi18Tn8e0=;
        b=VISsgftknXcQ+8RztxrPskTBrTDD8DuIstFZwXJP4g44kExNgfZ3wE0xMMIKQzLsDi
         cKjl/4WfkYNUd8ZwQZG/8FLN0DiCUeJYR6ZLB0FGUKpVw4de5Z0aW3SW+A6IsSGUB+Xp
         euDS5WrrWEMAaYn4KDAp6sa4XT70r8MxpCEuUCPvqr5g7xtMvXpVsmxOMxdnLMQZVzkV
         igoJVnAxQQE1F72oln8lg5lsgT+e0lvodf2KBPtMxFlSixjtKMYmTcU0ktv9awUomP+A
         v2/4i663TwVPUZCxGCydeTd6eii4/Vgeej484DLwZARqG1Lg4nMJQC7fkBdIrbxBVaBV
         cLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788742234; x=1789347034;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0eJ5TvqlGtp7+n2fF+/KcdHTBkBZ14rYysNi18Tn8e0=;
        b=Lke7+oU96Ybu/yFH5PjMXnx+Vc9vSCJBFVbHbxkJ/Qeh/JgWwfieW36xS2bEuP2KxM
         IhfIfa4B5udHpmVORUtDYMqsdYBZZpzm4hX1mEcF6aNHk9yPfOkhxZvDWiS2QVBoV0XE
         EVKyL3TA0isB7jg8JoztBbMp8ry3VTZsGh2dtPIZ8LNfltTTTYPpc4DTUKjQ7koZoFkS
         ZDWXFVITNpH+vxTyzPu66HO7CxoUeYKuNTfZwKax4ZYOc5/LuZy6Lm3JZirOxR7bkV//
         1MU3tSy18+9uHaVWRnwMGXYqO6ve0yj/i97VVNNILbfxyLOBu9oR6lLsOaUs5tPXxDMc
         vuRg==
X-Gm-Message-State: AFuF++k6/dogqO0ewUr2rLI2cVWRkxpfxziiq+Oa+l5PxX8MrYj/8WB2
	lCrJ3L5AQOvrhMfBMIOU9cnvWJ210NJQcTsyD3RvaziNUIXCNxl0v9uOOnmMwQ==
X-Gm-Gg: AYBFou3JgKojWGWOfsGaxtIOC2ZcP/22uIBx1LklElKFAddQZv64rmDOTxJeHf+hF3s
	WJFXqBG8ZYd/B9QoiPHd+z6c+XUoNJ/81dOOliLRi+kUa7zNkDI4A9lGmuwaLwd8fqhTXPVyP0Z
	1yGi5TSWaHQgRWolXvMrlzuszAV2ZChAisl2bjdqRWxsUknOP2CtW0mBleGY5D8SFUStxoiOlu2
	pTxIENbdH7pqV2kpzTOOno8eCe6gAUdgnvNFmPxTjO6fcsQq5OYD0D43HfPol+UYSKcrQ6cNe/c
	7rBv8lRpi3vDociml6SMmaGLUFGIMswjW28SMdLrTmcaYEeyavWVPKHeuj9iTosouEwyH6cERga
	d0x5XWHH70k/nBC5DwEHV+BfPbHZYVk1D+QawhUdwZVuCacNeD43y5fzr7m6/DikClvfDDeuRlu
	BDiE0ajYumFJX4CNhhlTW7B1e4jB0GvPXEujxl4EYmhXc0oyY5rhm+uO2PUu4M2rNj3z0=
X-Received: by 2002:a05:620a:f0b:b0:939:a1cc:f234 with SMTP id af79cd13be357-939a1ccf31fmr634366885a.5.1788742233858;
        Sun, 06 Sep 2026 17:50:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.85.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040693abbsm79521736d6.37.2026.09.06.17.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 17:50:33 -0700 (PDT)
Message-ID: <6a9e0a59.9ff83133.35e3a3.6681@mx.google.com>
Date: Sun, 06 Sep 2026 17:50:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7355536888957470732=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, elb12345@hotmail.co.uk
Subject: RE: Bluetooth: eir: validate service data length before reading UUID
In-Reply-To: <AS8P251MB00013029B476B1D2E05DF190C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
References: <AS8P251MB00013029B476B1D2E05DF190C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7355536888957470732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1159232

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.78 seconds
CheckAllWarning               PASS      31.12 seconds
CheckSparse                   PASS      29.39 seconds
BuildKernel32                 PASS      27.05 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      511.96 seconds
TestRunner_l2cap-tester       PASS      67.22 seconds
TestRunner_iso-tester         PASS      109.86 seconds
TestRunner_bnep-tester        PASS      20.20 seconds
TestRunner_mgmt-tester        FAIL      228.04 seconds
TestRunner_rfcomm-tester      PASS      27.18 seconds
TestRunner_sco-tester         PASS      33.25 seconds
TestRunner_ioctl-tester       PASS      27.93 seconds
TestRunner_mesh-tester        FAIL      27.37 seconds
TestRunner_smp-tester         PASS      24.28 seconds
TestRunner_userchan-tester    PASS      21.10 seconds
TestRunner_6lowpan-tester     PASS      24.05 seconds
IncrementalBuild              PASS      26.07 seconds

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
Total: 501, Passed: 495 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.260 seconds
LL Privacy - Unpair 1                                Timed out    1.876 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.588 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/713

---
Regards,
Linux Bluetooth


--===============7355536888957470732==--
