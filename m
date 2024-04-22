Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69735C8F3
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772577; cv=none; b=iMfYXO8bM3TFY5pZZVP+I7vZuZ9PRh3E3/us0xCGNurQWCQ6M5tXbsHtdAgfo3EqTJfXmkgdmaYUUQ3wz5gKGQ5ql7sDgRZGBFiH3C0+4Cjq1G4lmipxP0Lmq955skNI53fIi2HKh3+tv9TM0QaE2KwdMop6BIfo1SNiJWApkxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772577; c=relaxed/simple;
	bh=9dgxjWeVgkNWG647JbvoCl/AKPsNE/z8292oJpiLFzM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IHFZUIqCBIHysAc+gU12euRckBgP9ckKT1xAoO7+g9nw61ESfVZ9PCAETUgIAlMPbxmYDPZ12htXqrjWXAykA7vKME3oawcYJ3tO8kUdsBC70fG0wDI1/zEVZJjXq9n8glmYHH1M7yxE3O0xrkKiWKm0pWPongWyXLJJv+lzDxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhDjZ+sX; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhDjZ+sX"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78ef9ce897bso287630085a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 00:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713772575; x=1714377375; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X1B5XP/+ByR9+4BYHNMMf/Qq/3bF5N+q92TDf3Es8T4=;
        b=VhDjZ+sXHtbV0HaYS8FOX25//kQVOefwyZH0MSMchZ27gE3mEuIXYT1LFLPjKSmVKy
         JyiJO5j+ZQzmTvChGKRMnmNJIWnb7D7aYjEW8CUbuHFgwYqOcFtGMW9bDmXbSNx+r0Cg
         sZFlNpUxyaTJyH+aaMCGm1aXPZfnGn86RiEnvLyfWgHkj9h1rQjeaou0g/LivoZJNt99
         QYh3ng5uk23PIR++UOHdsl/6GVuwgx+MJI7yABP1lwyuy19Um94onSy9TZHw8yVDh2DN
         r9VvItebr0yDTBmMW/vFF+b3ZdJ5vwu+HwN52knphSQRh0dc/iMFRgYouWmqQcoFyBso
         htsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713772575; x=1714377375;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1B5XP/+ByR9+4BYHNMMf/Qq/3bF5N+q92TDf3Es8T4=;
        b=L9lINo5HKNJaYzIeS4G4OFl6FrYhxhtU4B/Mrzz+gkdp91F00xTaGZsq83mz/kymWW
         QNj2a3PY5gN83O+XEEx3YYOOPq0vcmCLsH9afZb7U/YPblmV/e+wYQavsBRldaKpDZhb
         CdbY5cb5mQJtJ1K9lMFbUoQ/vk4vBFQv7UtkP62pFzaS0hBwKsKQ39g9FJE9i7MEE4mQ
         ZkEFDPAJ63LQy3mXwPNfklZtbUIXbFAfRbJkiBK23VC+FRSctrjvqaknx6SSiqIqmTBM
         k7nqaXjdcMYTV5+DFfcNFXQXzQDK3xHIFzOYkBBJ/I2JQ2RDbKcZOBmYwXHFfUPdX4Mh
         4NLA==
X-Gm-Message-State: AOJu0YxBLPN/xdooya6+y4hVizK2bcydsMtY3x1Z6BFtbCUDwQoEypm4
	WQKUrCsLLTOpYO0Wzb3UNM+XqFn24jQAQKXmXdE0xsVum8JVOgugLNjEsQ==
X-Google-Smtp-Source: AGHT+IFIJVTw4XY5IWgAXgubxALPKWuhwGST3TdkE0N6qf6rU5pu4IvDsbXGrCNHP78gqK1aD2ZETQ==
X-Received: by 2002:a05:620a:60c4:b0:78d:7636:305f with SMTP id dy4-20020a05620a60c400b0078d7636305fmr9864486qkb.44.1713772575326;
        Mon, 22 Apr 2024 00:56:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.147.192])
        by smtp.gmail.com with ESMTPSA id a20-20020a05620a103400b0078d6cad412bsm4083046qkk.128.2024.04.22.00.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:56:15 -0700 (PDT)
Message-ID: <6626181f.050a0220.898d5.0eb6@mx.google.com>
Date: Mon, 22 Apr 2024 00:56:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6843359090096774192=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Bluetooth: Populate hci_set_hw_info for Intel and Realtek
In-Reply-To: <20240422152413.1.Ib96985e197f3db620a127a84aa20f3f3017aaf57@changeid>
References: <20240422152413.1.Ib96985e197f3db620a127a84aa20f3f3017aaf57@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6843359090096774192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846521

---Test result---

Test Summary:
CheckPatch                    PASS      1.14 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      30.67 seconds
CheckAllWarning               PASS      33.38 seconds
CheckSparse                   PASS      38.88 seconds
CheckSmatch                   FAIL      36.77 seconds
BuildKernel32                 PASS      29.10 seconds
TestRunnerSetup               PASS      524.07 seconds
TestRunner_l2cap-tester       PASS      18.38 seconds
TestRunner_iso-tester         PASS      30.65 seconds
TestRunner_bnep-tester        PASS      4.68 seconds
TestRunner_mgmt-tester        FAIL      111.18 seconds
TestRunner_rfcomm-tester      PASS      7.23 seconds
TestRunner_sco-tester         PASS      14.97 seconds
TestRunner_ioctl-tester       PASS      7.51 seconds
TestRunner_mesh-tester        PASS      5.68 seconds
TestRunner_smp-tester         PASS      6.74 seconds
TestRunner_userchan-tester    PASS      4.81 seconds
IncrementalBuild              PASS      27.98 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.170 seconds


---
Regards,
Linux Bluetooth


--===============6843359090096774192==--
