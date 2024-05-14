Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606FB53E15
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711836; cv=none; b=OAPXzj34Cr+FcCZAS7hAg73LVKgCDgVRM+SbUvN2OsR2YeRjHL/MN4gZf38PEd9chdZx5qDX5YGrsuyWr59csSIXPcxBGbmjnQgX3cqgrycoJv7X9RhhiFSS3NZsKFWYmWLBj7tLNOflHswrMTD0h7sb1ULZDauRGqPdtWc+N9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711836; c=relaxed/simple;
	bh=tvJ7Oav86ZU6ocGL12cZL/pw1rXS7noa7+f7E0uCBOE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D1f8tIyqIFPeMziCvlFuF9uRbYj/DUPR1ZJCYl7ybdVC8ED3UKFZusQLT6Qn5d85/voTWi0jtXKgNt4TioxTRA6jpPYGDc0s1+2Wq4r6yZaNlnhwrL4L/XTCd6T3R9vYb954H8Enu4fziAED6bm7bBvlzPN08EEItNSbYVmlzR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdp0X9Pq; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdp0X9Pq"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7f7c0f2b525so1068595241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 11:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715711834; x=1716316634; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zmf+J7gCF1vg2dpYFUg7NrtLGIwV7Bop5wKU2TCZ/MM=;
        b=cdp0X9Pqx78J6kvrve76VNfDnIc9JHJ9E/wNV4v+k7gJviAuB+YoznJzGrke48hm7T
         MTANWMCEDpsA1jK+egd+vU2ay5yZZhSLA0QgaGXJ/c/yyde5wGVt8+fGJIgDJ7pglR69
         Mm73Trmgot0tFkKWQ26pu2DaHTbeaC+ifZroS1xb0aCotiCUc9Yk8aWJRoyeBhmpar6i
         aDEXIxsZzAmyFCwd8rHNtSmsAx5Y2edsiOees2JWfkgvfl1V0Ukq85Z9tN0Cj7pg4PzL
         TFlTkKCM3ktpa6PSPoKX+gDHIzylbEWT874DLyuGTbR535HlA3qpMpQ5Dyy96Tz2M0Rf
         vflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715711834; x=1716316634;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zmf+J7gCF1vg2dpYFUg7NrtLGIwV7Bop5wKU2TCZ/MM=;
        b=JfyTdUPHpQYZ8ojI9cSJcpNEfjZzI5qo89JJmA6i9Itx6wnjdfJU6frRuU0Z/F3U2M
         5gdiMSdsj/zDoiU1tGjf9DT7BQ9X3mrkJJLtTym+Jq3MUsvGjqNl+gk2aPSlaUiX+0Dg
         /rxULMy9Z4D779Y21IND0ZHHccOjPSc8DaOJAGQk67DAbd/+ePVK2VJC/MC8RfEap8QQ
         J5TgDBuYjfKaDRcu0n9h1HIquHfcpxcO/4ueO6YQwSuS6xgoR1iJRmA9KiQfoNDpHA+P
         +wvNOeZVGmZkSstBOsZJo9J7zHk2mf4Rj7pRWKAKutQA2HRQohQKQzX6/Kr7GlgUTC8u
         NNKg==
X-Gm-Message-State: AOJu0Yx+Nk/6Fte4x7LTnO89cU2oOTDwpV5L3iWy5QxoVcN1s/57BOTb
	7hxKLK6udnSCZDjrI8ESJuMIXuemLp/lhCnqpLlfpLagKEbZO1nF7NFnvA==
X-Google-Smtp-Source: AGHT+IFX62sVXCNJqnSxq2NCFQZm1vAwxY9CCEZgrnbQP4nB/t+gyakwig+Gj+YwG4RtCa0KtsdV8Q==
X-Received: by 2002:a05:6102:6d3:b0:47f:2478:b763 with SMTP id ada2fe7eead31-48077e9dd37mr11710835137.33.1715711833723;
        Tue, 14 May 2024 11:37:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.46.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f179967sm55070896d6.28.2024.05.14.11.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 11:37:13 -0700 (PDT)
Message-ID: <6643af59.0c0a0220.8776f.2984@mx.google.com>
Date: Tue, 14 May 2024 11:37:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4716844871105467408=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,v4] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection
In-Reply-To: <20240514174755.750764-1-luiz.dentz@gmail.com>
References: <20240514174755.750764-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4716844871105467408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853196

---Test result---

Test Summary:
CheckPatch                    PASS      16.53 seconds
GitLint                       FAIL      3.37 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      30.15 seconds
CheckAllWarning               PASS      32.80 seconds
CheckSparse                   PASS      38.06 seconds
CheckSmatch                   FAIL      35.29 seconds
BuildKernel32                 PASS      29.14 seconds
TestRunnerSetup               PASS      524.29 seconds
TestRunner_l2cap-tester       FAIL      23.05 seconds
TestRunner_iso-tester         FAIL      37.23 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        FAIL      122.87 seconds
TestRunner_rfcomm-tester      PASS      7.38 seconds
TestRunner_sco-tester         FAIL      17.42 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        FAIL      6.02 seconds
TestRunner_smp-tester         PASS      6.82 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PASS      36.21 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC,v4] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[RFC,v4] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection"
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
L2CAP BR/EDR Client - TX Timestamping                Timed out    2.313 seconds
L2CAP LE Client - TX Timestamping                    Timed out    2.208 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 118 (96.7%), Failed: 4, Not Run: 0

Failed Test Cases
ISO Send - TX Timestamping                           Timed out    2.741 seconds
ISO Send - TX Sched Timestamping                     Timed out    1.990 seconds
ISO Send - TX CMSG Timestamping                      Timed out    2.002 seconds
ISO Send - TX No Poll Timestamping                   Failed       0.162 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
Read Exp Feature - Success (Index None)              Failed       0.080 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
Total: 15, Passed: 14 (93.3%), Failed: 1, Not Run: 0

Failed Test Cases
SCO CVSD Send - TX Timestamping                      Timed out    2.245 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.104 seconds


---
Regards,
Linux Bluetooth


--===============4716844871105467408==--
