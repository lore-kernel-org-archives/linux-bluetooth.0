Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061C015575C
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785066; cv=none; b=i3h5HDkILR4mF4qz8v4+nm/MhukFLgyvJGbuBTGdn8o4eu1t9bl4k0jUGfK521X367iqulVh8pb9ftK13RQbPS2VVGwEBB8ekLGPmH56xYM4gFuFJECzM0f8FYl/KE8Mk2xipMMqNOow1AhEW6CmcivAQ2PHylz6iyWmciBpOwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785066; c=relaxed/simple;
	bh=W8t0QAsWhgXHMjb2ssD6L5y3gW/YTNrsnAm9zZMYUVM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TW1Q/IAjpITXW52mjrtHpe3BsdkzdKOdEVgwjXw7nL56cH5XYIPunOD+SX4ZGZkdYKcUn6jp8hFZMsNjptEr6/1UNvIluVufM7ixcmVz1628awk2PUT1TnGMnXh3Rc2FNEMLYeUk31I+lTFgdDzcayWtR3rMvXzvhedPo1Qziyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2W9DWRt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2W9DWRt"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f4dcc3eeb3so4004346b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715785064; x=1716389864; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MwxjENxs1n1NOADqcOZRI2P+omMh5WFoIQfyZ9VA4Os=;
        b=R2W9DWRtCzflC0NSkVGV/tQcRdSeCRwRhU0a1Tx+aNleZw2A2t6O0BOFcPgXYbvUYw
         iJGsuAkx0HO8/axRfEC5y34sCV8ot36U5pWVzMUbfkbAKdXqRgJHwZdZk4kdf1Gk8gbV
         hunrbH1UROU2NMwEkP08E8htq2/EaLvmmffNnm3R3ZQEqNOjj0CLNEvr10XTneDODSuJ
         Zytm5aF9HzV7Ay4VekDLpbOJYFdWkwNWccadWoy9zjPBIe9aStJP2G3GPeGNyPIZNu+4
         OI9cBbrNQmilfR/W6ycB2f5WOVCDT2mvqHS2w+NjnTGqaBZq9HMsLmUe2QrUB6QI/s+N
         Hnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785064; x=1716389864;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwxjENxs1n1NOADqcOZRI2P+omMh5WFoIQfyZ9VA4Os=;
        b=GmnIFV3TnJ8l27me+uWq5BiRUgNnck+67a7JBS+9F3HEDxHG3N4pFPyqL0mmix6gmp
         FX9b7pFmdJmVkzDGY45oFIo7uhezXuzNbKn51KQ3HjsTnh02q+7GVoGkr5GdGjXdZ3u1
         pMW40x9gBIm1bDdUijtaRHrpc6TKkDAYSGv+e9OOeNCrh7BtorCXj7LchyKEHR45gcuu
         bji1sLo/YH9RQfqqa1uXJoAq64EcFYzqio7cZbPnkFw02ICKOH6Zg2nJ6G+ZD568NWCB
         IARD6E/VS63LSQgSW3B+xAz6kZGLrF+DLZJbmvHW/tYplIe63j4diqVeycMtoTtby391
         4PIg==
X-Gm-Message-State: AOJu0YxeWLoHe2VewBnIRZM03p6hgu7cwLxQp14xoaWx+z0EqU19DVwd
	GgXn/97mxbUPn8o8El7AEQ8VQB7DF+SOZww9Ic+4OIAujs9kHJ2JSQzRPQ==
X-Google-Smtp-Source: AGHT+IEjkcib/KU35jFWTUNAEYZJZOroVF6pTakJDzDnkAOOhFTpCBXjq26Un5G0tvrSouUwf51Nlw==
X-Received: by 2002:a05:6a21:3d85:b0:1a7:52fa:7d6b with SMTP id adf61e73a8af0-1afde197988mr15426182637.43.1715785064045;
        Wed, 15 May 2024 07:57:44 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.25.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827e6sm11160763b3a.55.2024.05.15.07.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 07:57:43 -0700 (PDT)
Message-ID: <6644cd67.620a0220.38ddd.cd3e@mx.google.com>
Date: Wed, 15 May 2024 07:57:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5631587012013230911=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix not using correct handle
In-Reply-To: <20240515143447.1371779-1-luiz.dentz@gmail.com>
References: <20240515143447.1371779-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5631587012013230911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853440

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      31.04 seconds
CheckAllWarning               PASS      33.50 seconds
CheckSparse                   PASS      39.09 seconds
CheckSmatch                   FAIL      35.69 seconds
BuildKernel32                 PASS      29.93 seconds
TestRunnerSetup               PASS      535.92 seconds
TestRunner_l2cap-tester       FAIL      23.26 seconds
TestRunner_iso-tester         FAIL      37.73 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        FAIL      112.30 seconds
TestRunner_rfcomm-tester      PASS      7.57 seconds
TestRunner_sco-tester         FAIL      17.53 seconds
TestRunner_ioctl-tester       PASS      7.96 seconds
TestRunner_mesh-tester        PASS      6.15 seconds
TestRunner_smp-tester         PASS      6.98 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PASS      28.83 seconds

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
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 55, Passed: 53 (96.4%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Client - TX Timestamping                Timed out    2.189 seconds
L2CAP LE Client - TX Timestamping                    Timed out    2.133 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 118 (96.7%), Failed: 4, Not Run: 0

Failed Test Cases
ISO Send - TX Timestamping                           Timed out    2.179 seconds
ISO Send - TX Sched Timestamping                     Timed out    1.992 seconds
ISO Send - TX CMSG Timestamping                      Timed out    1.995 seconds
ISO Send - TX No Poll Timestamping                   Failed       0.166 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
Read Exp Feature - Success (Index None)              Failed       0.085 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.203 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
Total: 15, Passed: 14 (93.3%), Failed: 1, Not Run: 0

Failed Test Cases
SCO CVSD Send - TX Timestamping                      Timed out    2.076 seconds


---
Regards,
Linux Bluetooth


--===============5631587012013230911==--
