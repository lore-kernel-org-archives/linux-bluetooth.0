Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5FD86323
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759981829; cv=none; b=ObyAPATJTXmNfg0nHV6ePBl7yAbX9Uq86qnO7l8Dd5FEgXavCBWA73JD0Z5uAHu76MMCaSdkuLNeD310BqHAJMeKoeHA7FQhGcQZS7Y8svNROPc6U5qlz1O0lVp9quyACrZ4h1ByMBfXsPTA+CFa7cnNJXTo0YIOBWzBpRtEdok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759981829; c=relaxed/simple;
	bh=pyFoepElmg/TyRPmEbBEKQ5KV5/BE4pG1/FjgIMrX/k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Wzl7xPKfZxdupJFe/niDo+G9jcRFsslqMwUK0km4JjptHFMT6wM3Thygz5F4zt79LDp1l/Q0Oo29REOdG9Ty7QUeprbTnfi8NLOD94564g6hHC6TkC7gY5+BjCuArA1qwufXlPV7bSzaiefSqry/ffXl/g4lRWufpT9jow7/Mh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XC1mYg9C; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC1mYg9C"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so290572a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Oct 2025 20:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759981827; x=1760586627; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XZZJLZgl3P2sthugnYy37Nxm3Mti4tXc5/02ovVVMZI=;
        b=XC1mYg9CwR1lTiwZiThpXdVnwhmhf8J3CnY4NMBqrVbjCUbQXzOiJOX7NODgkGm+Md
         Ah51Gy1B1b+wYKS2cqnrtt2Tj08VcCKn2yOYtTOtC8ELYJ/MmqG8v8rEtO3LRUT2OC9X
         G1JXNpDCh3cNBQyiljOK1UH79UVZNCWlGvZYSAS6Y34H7NlXcjjf4c8IH4F7gVMWxNN4
         E0c5v0J90LUPThNG4bWhDlWpPsT4TshMoOF5ErTx/P2lqdnwh0S4fy0NVIKc6PF1gauK
         tb4YaIvHE/QWImmTxEX3wfKzIu763UguydvqD7hVRabiKX2fUdXl8zLvbekxWkmU/6fe
         NJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759981827; x=1760586627;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZZJLZgl3P2sthugnYy37Nxm3Mti4tXc5/02ovVVMZI=;
        b=InjiX8jnGFHdgNRQRADO9JrzH+gIOG2XG19SwBK9GgLNhjh7d9C+TJ3mNl+GVadPxU
         RRu6PLEMAAAYuOxXqXaNfxYxMBApflzhCGa8Mxq6S6XqdHkaXyX5xggylkv7qBtWLl8p
         gnBg1OeL98RXuT8ZUcIakvppyGpuPqivTdy3sx8EjHqb67zqmUboXnWFRaT4mHM/zPSM
         7J7TJTi6l27oPkV5QNPQbQnsVuPVojkL9PRni2tjr4R0aD+wO2PLfMPlxqDjmBfLrWeh
         CDQGwTF7C6RdIM7pQucbFrHbBiQIRTH1vAg/hy+kq5HE7NFcbBLfhXvOz1sqM4cewlG8
         QHhA==
X-Gm-Message-State: AOJu0YyciLRVlpWcPtAC1Mqd9vfqCvImuz2BQG7n5SZMggcD9T2hOwRV
	O3aOJt8zZOYT5me1FAnWLjpBe5K6BPknbUlpB4i2cLHJS8mKZopIyqZXab4tJA==
X-Gm-Gg: ASbGnctYHnQMKYHVaAoFyDzYCNDxqAKnF5jjgy4a3LuymKKQ0eoYmNzjImhF7/14Z0u
	e/r6sJx4+hqfVrj99ZsIZnuyoKpsAReNBYcDZzE3ubSLPe0UOyt+J1a+nHAHIR2bf73SDd0yUcY
	U+3FbMb9P9X5QbB3TvHMkEXtv84Z/qYZ++n+ii9E/AIkYZlE4KlAIY7hfUHMziqVuEXqnwZl8Wm
	jGmqmj9kpjA8tied34eBonrBdAHp5E9Zk0oQxCFwi43+8ir16HCvN8vJWoHpY2or8lHG6AEdn80
	DRrXxdqc/jJRG9DYLVLhnKRFbJAzo97jQftRA0Usbz2BnD38Fo31pH6zqxaD1o5k875q3tL+Ysm
	r0p4cDsZjJwMxl1vuFcIP5ru/JHv+M6h0gZeTmahzDc1zsixBogfo
X-Google-Smtp-Source: AGHT+IGkNdPj+nOTEjbDFYNh44dt1xaTbKYfCsxwBMUnP3wvqzEAc6mY/MwE29CeDdt+kBenNi6EFw==
X-Received: by 2002:a17:903:2c04:b0:28d:195a:7d79 with SMTP id d9443c01a7336-290273569aamr74169825ad.5.1759981826554;
        Wed, 08 Oct 2025 20:50:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.247.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f8f9e0sm12591425ad.120.2025.10.08.20.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 20:50:26 -0700 (PDT)
Message-ID: <68e73102.170a0220.138a86.5eff@mx.google.com>
Date: Wed, 08 Oct 2025 20:50:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0506018963368463693=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eeodqql09@gmail.com
Subject: RE: [v3] Bluetooth: bfusb: Fix buffer over-read in rx processing loop
In-Reply-To: <20251009025701.3756598-2-eeodqql09@gmail.com>
References: <20251009025701.3756598-2-eeodqql09@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0506018963368463693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1009568

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.39 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.66 seconds
CheckAllWarning               PASS      27.33 seconds
CheckSparse                   PASS      30.77 seconds
BuildKernel32                 PASS      24.70 seconds
TestRunnerSetup               PASS      487.97 seconds
TestRunner_l2cap-tester       PASS      23.98 seconds
TestRunner_iso-tester         PASS      77.78 seconds
TestRunner_bnep-tester        PASS      6.79 seconds
TestRunner_mgmt-tester        FAIL      116.23 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      14.38 seconds
TestRunner_ioctl-tester       PASS      9.90 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.36 seconds
IncrementalBuild              PENDING   1.04 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.818 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0506018963368463693==--
