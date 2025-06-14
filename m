Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A442A99
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Jun 2025 02:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749867671; cv=none; b=XwRCoSOe3Z4nE4nDhIunMheFa7OyNFVUAZtl/Et+lB5nBU2gGDYAVAPs9j4bDuD4x4f4KpMl1JM2qYsZMGWZiy906T82jc0i3eqHJxwqe2ykWUJq9Ib8kbJGlCmrU96Yie3AZnoQZXc/M1GztYiVGbEht7eOjQEqO8qPrjHpbjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749867671; c=relaxed/simple;
	bh=zPdNzrBEurpgDS+SGTrfCz8qBUhM6woYjIoL8cob9V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SieZ0WFqjnhe0kS+LM8Pb9DyF3fJFyZIXgzo2yduG8vpgEPjJN6tfSBZqjF78JuaMBSfqe5hy2cyPZoTVX5bfVjTqrgt5rJJYDwl1tGEkDeD7DAPTXwpQWYuYGle6EjP3MIsvDWdAL8+h/qnkwe+bdnvX39n0Z/ZRnr9ckN0a9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvW1Ftuz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvW1Ftuz"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2366e5e4dbaso954865ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 19:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749867669; x=1750472469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6WyoXCVCNV2vMZ0y7GTddxgz3bTDNLW7BkV/MHs8U0=;
        b=kvW1Ftuz4pl36cm/ehbAL9LwNWDWDn4hABziguKiBcP/WTN97oO5y+tnCkocMe2SOO
         BemoDLyRSoRq3Vs0v6GZ6dFIgJMhCQQMsHuEdjJqFUA09Le1U+bL+IUjS3TC443ifR7j
         6le1qQZCcSzqessRHAXfQ16VQSftY1fjrk+9Hmi9spBx1PdcQ5IpdPxxjGd/lgDCRxKb
         I1nSJWFNBOA74b0Jr7UvisIf5ruu/PuxGNOI0qbTNFtXolxnVqn5vl1KlCa7Wjgg2yeD
         Pfbzx/pHTSV7/WvBmOLcsbPsdoVU9j+ptkJxCTAlOZhAPjvmNWXy/p3PrR5xltfg6CGT
         chhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749867669; x=1750472469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6WyoXCVCNV2vMZ0y7GTddxgz3bTDNLW7BkV/MHs8U0=;
        b=lR4j9L/gUvmXiWx/3d0a6H/HR1YqCHwTQeP7OcnCNCplZqu1PCqKHXarYqMPrOm54x
         0O+9+cY8RQV2nS23kEo8bI08SAtZYQ8RYNS64qz8Gxc7kjQFmjxXvZc93d/UpeltpJ0C
         VB4lRx82x3givu6j1YdPgXH0BZK5QrqUkY7vRQj41NwE9QQ429A1sRphRr7jusjfxRiN
         1wG/yMChO8oDQxBz1V1ihK9lGj9DQ3zBe2VOR1FaXPuOy+rBle7cArPlPbiTVvvLv8Av
         yEPUboTZ8Hke2vVcpcaWfG5WEocFw2W2mZD9YTSCGgfSV+Y8W8EM9Fj38apVLdvjNTIf
         90Qg==
X-Forwarded-Encrypted: i=1; AJvYcCV93dJlpYg84sQN+1YXXE2I37UWY67brRaL4wYwu1w8UsDktL5Tz8+DNJ4H4MQjKSUHRnAkfAkESpkIwJMAW7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweic6XxrwUn4WLkumzHLbcacjFgsv9g5KBMtYCGrwy7/G/vSk6
	lCsMLVj7DM9lAb6YSOQLDSe2JYwHQSnT2GTcFybrW52MUYKeQjlECtMxrNg+1KnopOmY
X-Gm-Gg: ASbGncvV+XXWwX5n++Ntq3cUxXH0y/iJBVHydmcR5vvyCp3gMxiUZHipiyTlkxjNxIv
	TWl7QltEdB4Qk3EsxA/UDFbWmoEvAG3OpiP/5yYHYLlbr4m0XOxYqc8IV21mQADC5mVXQRYzhc5
	aUnhvTz+VS3lgQ7ljU+uyYDROm/Pxxv4EdAXCFYKjtdbiiXQvMuZtdsxSp1bLCLkJhWSB74FCJU
	yPEE05VNSy2ugVm6ZYfHT7pNXAMoK7g9UBYeqTxv8jOp6CsAjaR3BxxAFFeZbLARNnyCenmwFvM
	x6VPcLHEWq8e4eEeQ9EYHmIC9M/v4ZRD+6KmuEd0yUjAC7dBtA==
X-Google-Smtp-Source: AGHT+IH+vgArevjEuTE/n+svok8qKYpqwxHiHtXKD4i1vtTgDGUO/EW4zksmtyBAe/TU6DA9a3QNuQ==
X-Received: by 2002:a17:902:ce0f:b0:234:b445:3f31 with SMTP id d9443c01a7336-236678a6c9fmr39705535ad.17.1749867669190;
        Fri, 13 Jun 2025 19:21:09 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de76e1asm21787985ad.112.2025.06.13.19.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 19:21:08 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: bluez.test.bot@gmail.com
Cc: kuni1840@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [v1] bluetooth: hci_core: Fix use-after-free in vhci_flush().
Date: Fri, 13 Jun 2025 19:20:43 -0700
Message-ID: <20250614022107.1368823-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <684cb56a.c80a0220.7fb1f.b9e7@mx.google.com>
References: <684cb56a.c80a0220.7fb1f.b9e7@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Date: Fri, 13 Jun 2025 16:34:02 -0700 (PDT)
From: bluez.test.bot@gmail.com
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=972027
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    PENDING   0.28 seconds
> GitLint                       PENDING   0.32 seconds
> SubjectPrefix                 FAIL      0.30 seconds
> BuildKernel                   PASS      24.78 seconds
> CheckAllWarning               PASS      27.17 seconds
> CheckSparse                   WARNING   30.51 seconds
> BuildKernel32                 PASS      24.54 seconds
> TestRunnerSetup               PASS      461.88 seconds
> TestRunner_l2cap-tester       PASS      24.94 seconds
> TestRunner_iso-tester         FAIL      7.68 seconds
> TestRunner_bnep-tester        PASS      5.92 seconds
> TestRunner_mgmt-tester        PASS      131.78 seconds
> TestRunner_rfcomm-tester      PASS      9.27 seconds
> TestRunner_sco-tester         PASS      14.67 seconds
> TestRunner_ioctl-tester       PASS      11.73 seconds
> TestRunner_mesh-tester        FAIL      7.37 seconds
> TestRunner_smp-tester         PASS      8.45 seconds
> TestRunner_userchan-tester    PASS      6.08 seconds
> IncrementalBuild              PENDING   0.78 seconds
> 
> Details
> ##############################
> Test: CheckPatch - PENDING
> Desc: Run checkpatch.pl script
> Output:
> 
> ##############################
> Test: GitLint - PENDING
> Desc: Run gitlint
> Output:
> 
> ##############################
> Test: SubjectPrefix - FAIL
> Desc: Check subject contains "Bluetooth" prefix
> Output:
> "Bluetooth: " prefix is not specified in the subject

Will use it in v2.


> ##############################
> Test: CheckSparse - WARNING
> Desc: Run sparse tool with linux kernel
> Output:
> net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):

Do we want to silence sparse by putting acquire()/release()
or is this warning acceptable like netdev tree ?

IMHO, sparse doesn't help much and I prefer lockdep.


> ##############################
> Test: TestRunner_iso-tester - FAIL
> Desc: Run iso-tester with test-runner
> Output:
> No test result found
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76b/0x7d0
> WARNING: CPU: 0 PID: 68 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
> Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

It seems the same splat can be seen on other patches.
https://lore.kernel.org/linux-bluetooth/?q=KASAN+run_timer_softirq

Is this a known issue, or are we all making the same mistake ?

If latter, can I get the full splat and some guidance to run
the same test locally (if it's easy to set up) ?

Thanks

> 
> Failed Test Cases
> Mesh - Send cancel - 1                               Failed       0.148 seconds
> ##############################
> Test: IncrementalBuild - PENDING
> Desc: Incremental build with the patches in the series
> Output:
> 
> 
> 
> ---
> Regards,
> Linux Bluetooth
