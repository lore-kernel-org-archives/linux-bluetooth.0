Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5113806DA
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025717; cv=none; b=DHTjZK0AwW0wJM69hGTP2m6RYouY7UO6MTmANUBSHaVKSBPsiCGev4jShJ/GyFQt6rUVRAGal6sjnIiMCFaBXI5+NRBelxfOKOzbzt7YlyegGOuKZG+pF7315jCHqtFAotg2JDbCJu1Inc/DKx1q2lVDXi6C3MTnEm0LrB02JLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025717; c=relaxed/simple;
	bh=g8Xflg2hPePEf2bwZpH1fFh33JpW93+HQR7JGVYbfYo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=O3tKS6rpIZR5m5EljXlJ7TOXNH/k1sl9y/ornb+CUUWPkiTF8RcW1VE2ldithcHdUF0zXUtKMSFypvacD7ShQJOohHatENkOyQjZZmqIQ/aFxQTJtO2zIdE8oFNcFEOT4X+b6AoRBV3Ovvx2P2utzBqX//vDqoi8o+hJJ5xlHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGG0I+/8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGG0I+/8"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e041ea211so2463681a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 07:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786025713; x=1786630513; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aHf8igUDAfIFy7OuGinqIvYnSLT22wWCk/6Rav8byRM=;
        b=nGG0I+/8NCiDNkGSUN8ModRWZgzEXHb0/cpwSGpSSb7dW0UJBuH/b4ffVaZeF15LlR
         caRmGRQPQ/xmgTOM1ZuGQjxszTNyJBoLx7wm8E2F0QCemb6ohsa5dQ84fh6PzAyHcsEn
         B9nJs+Yj4u9bPntOehlDERuLY8oLT6CBCwUFxWNBF1un0C5JjU6uOudDt3UJzK4JF0ni
         DJdg6Y5KD+axEH0cq2fFYE8AoW5fKKUZ2BWVKrrA3MNer/UTbf/b1KFeFN4Wqxvds0CK
         W/Llf84LFPuE88qVdJE6qC71oaGcg6T/iLCVIljFC5k4aOHvwCHtZxSyXu96n3jc8gdb
         wNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025713; x=1786630513;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aHf8igUDAfIFy7OuGinqIvYnSLT22wWCk/6Rav8byRM=;
        b=GfojPkV4W10d1cU9O2bAm/ahlmHiRWXbpsqEQoazXUnqV4VdrCBad8sF1f7Qk7V/JA
         gQ2GOtr4aO9r54FzvUD2f8Vks49J5/Fi0QbZjUgzncOT23Wy/5VycKv/Tinol0OliGhm
         OHQJfIGj8D+LBQ3EEBmhSUUyD7sswq04lbuFNEbxIrBnl+A518cQ6rDroUmkTKOUEN+r
         ueTi+FUO8dRNyME89Glt0K1qdOcjjnB+hBQm1tO5mFLFwgRNuqGPcnM/B4m2CvlKjm+w
         9rWig0EYGUvHBZ2eH0Q2fsjuWBUdRTUDCdeED+rOaWqvLk0jUXg2mSkX3lKKdLzp+ooZ
         5PeA==
X-Gm-Message-State: AOJu0YyW0Kk64fcZMY5zDwSVDJPaJJbvNH4K4r1jSPoKXlRrsUwivMrd
	UEHmVjU9TAV7pcXzruhiVvUoqJJ0a/kv3m85ZKD8sAdwFJ2QG+NstmwGL4gu8g==
X-Gm-Gg: AR+sD13Iq/guFg3+2ld2U2cqC0B5CH+dyKMnWLSM3XSR7R+NZNb+kZcdDT7NJ9YH6WA
	EI8VtxdIwGo3JGYxZECnIMYsap1RUWNB+KabLjE+cQJG43jtGBZYpGWSI4U63AVLGnkV/jpjFDM
	WgD+XLUaVwtTctA53wTLkCfKgQWaxLYlbbNBksEAButgaVMwEW5UC+doc2awW8ASXiC2m6kRkVB
	da4np/i8x/CD0SMFtHwo1cWNFVQoIAA8NyeO7eaRyXHmxLr+dIjfSbA+CeOyLtPKmvreXcPHpgQ
	6LMC3lPILooZ4rHY5V8Dn+ZdkH+cS4rNvadaBatQj9zEapNuJY7c/mQJMdJOhgTE4wIZepu6JrJ
	kxBpfWJ8slyWk2J5aFor6IWc0nWGYMrX+OZ7MGPwO8EsmF2E7uIgpERyIr6KwG9iQUIM/pwKWhf
	eRhTz28Xx7aL3ZZH4VgbDByIblz3jZPqPRkTpTi4JD2dbvddk0klNd3B8Tv8wxMJZJUA==
X-Received: by 2002:a17:90b:5203:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-3903c598ce5mr16630614a91.7.1786025711499;
        Thu, 06 Aug 2026 07:15:11 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.42.38])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586162e80sm32190742eec.0.2026.08.06.07.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:15:10 -0700 (PDT)
Message-ID: <6a7496ee.510f576d.25a50.fec3@mx.google.com>
Date: Thu, 06 Aug 2026 07:15:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4483349071209048167=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lilinmao@kylinos.cn
Subject: RE: Bluetooth: fix cmd_sync payload lifetimes on the cancel path
In-Reply-To: <20260806125957.698760-2-lilinmao@kylinos.cn>
References: <20260806125957.698760-2-lilinmao@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4483349071209048167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1141501

---Test result---

Test Summary:
CheckPatch                    PASS      2.13 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      0.84 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      27.37 seconds
CheckAllWarning               PASS      30.02 seconds
CheckSparse                   PASS      28.60 seconds
BuildKernel32                 PASS      26.62 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      507.04 seconds
TestRunner_l2cap-tester       PASS      65.22 seconds
TestRunner_iso-tester         PASS      86.41 seconds
TestRunner_bnep-tester        PASS      19.23 seconds
TestRunner_mgmt-tester        FAIL      224.39 seconds
TestRunner_rfcomm-tester      PASS      25.86 seconds
TestRunner_sco-tester         PASS      32.39 seconds
TestRunner_ioctl-tester       PASS      27.30 seconds
TestRunner_mesh-tester        FAIL      26.87 seconds
TestRunner_smp-tester         PASS      23.99 seconds
TestRunner_userchan-tester    PASS      20.69 seconds
TestRunner_6lowpan-tester     PASS      23.36 seconds
IncrementalBuild              PASS      35.61 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[2/4] Bluetooth: hci_sync: free the advertising instance on the failure and cancel paths

1: T1 Title exceeds max length (88>80): "[2/4] Bluetooth: hci_sync: free the advertising instance on the failure and cancel paths"
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
Read Exp Feature - Success                           Failed       0.257 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.387 seconds
Mesh - Send cancel - 2                               Timed out    1.985 seconds


https://github.com/bluez/bluetooth-next/pull/540

---
Regards,
Linux Bluetooth


--===============4483349071209048167==--
