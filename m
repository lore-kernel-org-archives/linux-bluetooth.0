Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D861B1EDA2B
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770883763; cv=none; b=EsLLs0eWhk+nfv/QBh1CrbOPqCx3ui8kJIGqwQZAJCCnDaOtOkskymq8HYFJMzVy2SGOwLe3llcwmpbf5qM3rW3VUEa/g4rAdUJZurLv0tKxneFfzZeEhZRHAQ/GDfgZMs24jcR2Ez901q6IJFfSHzVkKzO6IISkpBEujZdiveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770883763; c=relaxed/simple;
	bh=au7l8O54AIPXFVK0PRN9TILkytdwKmIo46y4q+2OF0Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xl/JL9Jh0DuIOdgh97NhAAlPIA2NJp0kHjkiSvIgD4LrsrjuIISG/n0SrDnIsHc+AsSeYVqiiKFdDWDr28si/5xZ2o054cd2ZvE4be3kc5WYImBj+bIReohDhl8e+mq3ZQUv/5tXexU6PZVgCwKDXclwRavQsjkD0ItK6TxbhEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9NumHDU; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9NumHDU"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8946e0884afso110364896d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 00:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770883761; x=1771488561; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2DfohUEyyiU+OFzbYagJrqIHMUo3EHOCtw8wpvNOzBU=;
        b=m9NumHDUAgwO0LRSrJXGhGPGUiaLT1OpBgVo7RpdcQ7/U3NqfjwHahRim82t/KfgGi
         9WL1LPT7xuuWys2ErJ4NbCyzmFZEZiV9+7gvk7UZy1dXv6GaZTFZiwIptBe2GAwbUBlV
         9Zu7Xn0Lae312AZ2rYaQJU/BI0TQ59dhjTdLeWiSc4StPpE+IVWpDamWNHqwKTUZDxAk
         r21SBhSuLcbAITiSXxBFBlupNXolcrOu35kf5wCQzzCS3RMzqruuUKXSpTBBGzsVOs0R
         bxhiNBIZ3jaaJ2dFb0HiAT6n0JkuC7P1ha2qTkiXRScFbR8RxLxFReFbIljx7B3/WM2r
         sUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770883761; x=1771488561;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DfohUEyyiU+OFzbYagJrqIHMUo3EHOCtw8wpvNOzBU=;
        b=vxe3d7Le1Eqw4crpdNjIh6oXwnohAY/6fAGL0tbgfaD2PqCFzx7YJ0HfKeEYnPx5k8
         5rbwoGLPx+xX5YVLCVRh17g6ENCcV4K+gPCDrthITl9WzF65juBuA4V7va8GtmvbVh4Q
         3sythd1nn4/MdiZBZNeSWsp99jVowp2+aLu1ZXoQoCfvaA89YBqEc27+kZAugAS0z5te
         M7OUtGp7hdbcT35nzi/vjG/dKCq0NXTbu9ROvupKg9mPUSEXZK0Qa9zNfSgwKXT3HmdU
         5TT1xECS2+pUb3kBWKfOGRTfyvH/oshoOgMiyK6eY4DUTqA3af41ZxQ8PIXreVWIAtax
         447Q==
X-Gm-Message-State: AOJu0YwaHP5MuZMu5cp3ojwW5EwYFxa3cX2malx8yKeycPyIpcaItX+i
	fkAVfGjH1/3IHP8X5ZQ6s6TH6OuC1XFrQn4G6kRR8MwZAhxKgSulGGG/jlFU8aTg
X-Gm-Gg: AZuq6aLyKfY/zbj1uWEt3sFIxHembDrPK14WtY7WvOCnkGGuRujuDRpIncOqwIP5hPP
	IZ8qfVfZcc2HK3AU+phAbfl/EBKjZAmAkcqDnNBNFpr35W/5R+ZPmnqDNFU7rwOhNzsqsYV6UQL
	3Ma9RPkf+zZkuE8W9I9eMEHVk9jyuQVc3kWIe9XhCvTco1Q7aadKDdFhn+BycqCMGm4H+on6I0g
	6+Mh3jZYT444i+mDyGW10DR4CYyPTpL6SEPWTfCKAFcdIdILXTj7OygS04FMTZYwYm185FOiNDc
	VRMaNMWPmti83Ngx/6fPIBTSQObgDW4E/vx12QhFmq6k7T5eL/lKAqFRHU1rtRbPI7kNO+FdUJ9
	O3iQVSh57cXpbtgHA2Bt2uPlW3CkJSTUeY8idBudU/t5eKGEROwhB6XM0JIazZFjehoi2eOBIv9
	M7ynkyNpo3nnBHhb1WdVCT4XvAuwQ9F+s=
X-Received: by 2002:a05:6214:d03:b0:895:c06:8cbe with SMTP id 6a1803df08f44-897279ff251mr32405476d6.69.1770883760531;
        Thu, 12 Feb 2026 00:09:20 -0800 (PST)
Received: from [172.17.0.2] ([172.178.119.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cdbf972sm32326396d6.44.2026.02.12.00.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 00:09:20 -0800 (PST)
Message-ID: <698d8ab0.050a0220.1f26f6.db08@mx.google.com>
Date: Thu, 12 Feb 2026 00:09:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0061648388494545464=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mariusz.skamra@codecoup.pl
Subject: RE: Bluetooth: Fix CIS host feature condition
In-Reply-To: <20260212074111.316980-1-mariusz.skamra@codecoup.pl>
References: <20260212074111.316980-1-mariusz.skamra@codecoup.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0061648388494545464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1053412

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.22 seconds
CheckAllWarning               PASS      28.62 seconds
CheckSparse                   PASS      32.13 seconds
BuildKernel32                 PASS      25.73 seconds
TestRunnerSetup               PASS      564.50 seconds
TestRunner_l2cap-tester       PASS      28.93 seconds
TestRunner_iso-tester         PASS      98.53 seconds
TestRunner_bnep-tester        PASS      6.45 seconds
TestRunner_mgmt-tester        FAIL      114.30 seconds
TestRunner_rfcomm-tester      PASS      9.58 seconds
TestRunner_sco-tester         FAIL      14.71 seconds
TestRunner_ioctl-tester       PASS      10.25 seconds
TestRunner_mesh-tester        FAIL      12.55 seconds
TestRunner_smp-tester         PASS      8.68 seconds
TestRunner_userchan-tester    PASS      6.81 seconds
IncrementalBuild              PENDING   0.86 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.101 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.737 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0061648388494545464==--
