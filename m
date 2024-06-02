Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B1D63B8
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jun 2024 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717324336; cv=none; b=oYbq87RXnxwh1xJlqjYGbcQ5AQMTcgwfWoQAjKrrHyqXlsXcSk9tDcDH1dXOxKWxhuzqQU4Q9kOdp8uCBOdFMqqNMYgaE8hVxZXTIAHxNtcA/SBYsf8eIaJ7sHEwjnbe2UUJfyMTLGdsFgPCiqJb50jrd7nZEmCrtjCJG/cnhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717324336; c=relaxed/simple;
	bh=0sEaEL0pqaQl28Ax63Tlc8hPVHJimmcibIuQbfEaI/c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aFEbwvb4lkGc7dPMTlwUhGyFPZZZIe3WCAO1uakU/Dk1Wwv/eRtGWFv6GCU0TNRLUQwQcBLWRIaxTVdtp1FQBGvYDvqsGVtsYMpuSmoXdIzNVu2p5NMVs691gKzG8c8S8qx3m4KrZ5vixIW+CpVSLb1f5OQMeIou2cIbXKvZU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRFGjGx+; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRFGjGx+"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-794ab181ff7so239360885a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Jun 2024 03:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717324334; x=1717929134; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qfkjrJ3Qqm50sWWJBih2ozZJYCr8wPNeGyOTrZ5rArU=;
        b=WRFGjGx+03qQmmWk9Pt0HpjBElLkE+PHroPNtNQWvBCwzZb9WhwvT5h+CMQCQEXtgl
         Vie7OyPzN9e3qkR7BZGAlg4wJBwfkQEhngQIUl+uGemZlOTYvxM6XDi4SwEu9CxhB5P4
         hBBcKd15e2g9tQtYXyPgBnjTZ7k2RRRQgPKUNe5XmJl85a959tnj5WDKb2o+2PZ9tcay
         kDJxMFs6jb06zoakrBI9/+vfNEGhrhcSKl/QEMQjEUXrZYfihpDLq8/UNxZ3NQotjRim
         2dzQCvUw1T5QSaBzTYZmZ3MI6V+yp3tRgbKMgFiJVPNx5pqeY75xzhEMx+JRxCE2MHQ5
         qroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717324334; x=1717929134;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfkjrJ3Qqm50sWWJBih2ozZJYCr8wPNeGyOTrZ5rArU=;
        b=lll2vaF/vpAEcppjOwibwYoqpQNveiasCOtcpdgDKPA/De7VUl4xJhLYSZNgJQFBmN
         xI2ShlBL3qx/KqSpI0rQp+f/eUNdsC4ojJSAFkOTs2LXmgaFYL3vAlj6yqo83UP8ngu/
         xtxIXdtb89Yvn104RdiKB2MGMavB8BISyCwZFt8Z703obDDT0StBvTt36vvUtZMhrDFJ
         bk/chfx/dKXAlpnDiEbu0eVQs3YtKqbSwDWrIs6NOlarAesNm6SLUKAAKSRT08LEnz9q
         M/wH9KbTIeV3GTMq5G01XtPrKrJ5NVsKQM9Oqxb8hNSxtv1ZOnYKzLzcVyaojLwT317R
         cLiQ==
X-Gm-Message-State: AOJu0YyNkiSukgHF/4qOIYwP0tpq2ac1hOzsRDiwoPfs4ssS29i+Yooq
	0mDRW9Zy2L5obfkaPA6xqgBnQ89Xt/ract8cDIGNCPwKR1DYWblmAH0cmA==
X-Google-Smtp-Source: AGHT+IGMlQ8rLkJsdqK4PNHphf0nHAsHFSC/wCD90x2mEJ+h5XttB5VRWRhW57hhGIICBgXvWvrPVg==
X-Received: by 2002:a05:620a:136c:b0:792:c025:a36e with SMTP id af79cd13be357-794f5c7a505mr664186485a.32.1717324333924;
        Sun, 02 Jun 2024 03:32:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.53.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f2f042dasm196780585a.22.2024.06.02.03.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 03:32:13 -0700 (PDT)
Message-ID: <665c4a2d.050a0220.8a9a4.966a@mx.google.com>
Date: Sun, 02 Jun 2024 03:32:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6945289534087167896=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+sven.svenpeter.dev@kernel.org
Subject: RE: Bluetooth: hci_bcm4377: Add BCM4388 support
In-Reply-To: <20240602-btbcm4388-v1-1-210e4b4eeb3b@svenpeter.dev>
References: <20240602-btbcm4388-v1-1-210e4b4eeb3b@svenpeter.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6945289534087167896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=858002

---Test result---

Test Summary:
CheckPatch                    PASS      0.87 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.38 seconds
CheckAllWarning               PASS      32.57 seconds
CheckSparse                   PASS      37.35 seconds
CheckSmatch                   FAIL      34.82 seconds
BuildKernel32                 PASS      28.38 seconds
TestRunnerSetup               PASS      513.41 seconds
TestRunner_l2cap-tester       PASS      20.19 seconds
TestRunner_iso-tester         FAIL      30.48 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      110.91 seconds
TestRunner_rfcomm-tester      PASS      7.42 seconds
TestRunner_sco-tester         PASS      15.02 seconds
TestRunner_ioctl-tester       PASS      7.82 seconds
TestRunner_mesh-tester        PASS      5.97 seconds
TestRunner_smp-tester         PASS      6.90 seconds
TestRunner_userchan-tester    PASS      6.49 seconds
IncrementalBuild              PASS      28.22 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.240 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.170 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.198 seconds


---
Regards,
Linux Bluetooth


--===============6945289534087167896==--
