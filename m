Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCDC53E15
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711834; cv=none; b=sQNEpvklNK9oLi3CmWTY5NhaPkpdhZKAMNawGkf914BLT5AphlGmo+SHRgFyfc+KTm3tsCo5R2kpGl1BoS2RiDy3Rf9wS03KY7qW2x7nTiIrPBF8Z5zhQ8W0TlozEcO7EthGlReicw9PtDwKAlIVI8V/3HJtjEe5aRRTtNFlWVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711834; c=relaxed/simple;
	bh=tb4HNReiOrmkN0o63EdCxyZWbfNr38awbSS57fA9jBg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tSvJO6tdlTgBTSNVH5Rcoid9fmWNcxFbCa+pckjl2/40ZPhpDQigQOwCAb1q/WpUx0krxaKZeXXeNgZTLuuRn9ra7cxX7v/JYQxBoWVusKRhoDAIxoy/HkVrBth/wN76bd5cLywZeAK+HQqZxHBMFmxqOAEE9ajpkjWDBD0K4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8007A+o; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8007A+o"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c9995562fcso1679576b6e.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715711832; x=1716316632; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kfb0cjqjLe0xxuRGop6Fm3AjqRLL1Koy9JgysKXgLrg=;
        b=j8007A+o4Xf/wT+KhicDcmZr3cQAf5R0V1HP/97AT872fgHCBkZXDRBTXoG+9EVdPV
         /GowCkS6142ZIY+Xl0FYK3fvV2OTKs9m5exbyQD3MfSTgshNQPvbqTwmwt/XhTELIIvW
         UfFAqY1/VdQr5QVzNvJBeKqm4INZVgmS0UJYtsU8FnkkfRAO+9mt8yKKg+0b9iKVgDeQ
         mWHAYLfeQ2qSHzlbs854ShlRsOdzlSU0fymS+6Sf3deB3alQxeeTyzaZdXAP6prBgb2M
         bFaWDvWEJsTH997kkMXkMyphdAkMSd2hR+RyPRhXCtLLTxd9xJgVUezohJJmAqhgndYH
         8A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715711832; x=1716316632;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfb0cjqjLe0xxuRGop6Fm3AjqRLL1Koy9JgysKXgLrg=;
        b=Z/Qq6X2mST4vqm1xAxnL9iC44A8N7rHKtTMiUZHVuJpLAUNZ3pOIWXAWSOuIYeoIPI
         /fuuqDIsG6jzT62OQhHPfbQvXkk7odAkK82u+EIEXnI0n3hlUBTC/QbAj58QEesnfcyw
         /T8y0NcbeT7w1aBFp6MtlOz9E1knZI5wrgQ8pQUU6i7+CeLKuWPzYabZBzc71UyTwMcf
         owx7rCDTmmEi3hKXls69N2tL4pPgxIH1t3k8f0vN7YU3uj8Rh7wAiPKlzr7cgtF6nGZQ
         alaHZmprEExgUkmo+U1GjHEtNj7tLmt7T4MVRCCGm4LYv9XeC2YQOsizYbamuuf+LMdS
         64vQ==
X-Gm-Message-State: AOJu0YyP1DUF2tTyRITqYj0eFeuakYvXa+6doKz2EAQUKniIjHpcqt4X
	QUiCY91CnAJpNBkU0TwQgzUR2DOSOAbcKsXzM5Yqm9PdBa2e6GrNXy/1ow==
X-Google-Smtp-Source: AGHT+IF/nffVExXD1Vg7v2eIqbdBQep2ctjWI03qmI/yWkNuE1mtNWEclcFmmGBGH3eduvTYvZJDwA==
X-Received: by 2002:a05:6808:343:b0:3c9:91b7:e80d with SMTP id 5614622812f47-3c997069583mr14455330b6e.24.1715711831026;
        Tue, 14 May 2024 11:37:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.14.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fe9f0sm593103185a.90.2024.05.14.11.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 11:37:10 -0700 (PDT)
Message-ID: <6643af56.370a0220.79bd9.3866@mx.google.com>
Date: Tue, 14 May 2024 11:37:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3557917441371214581=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,v5] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection
In-Reply-To: <20240514175149.752522-1-luiz.dentz@gmail.com>
References: <20240514175149.752522-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3557917441371214581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853198

---Test result---

Test Summary:
CheckPatch                    PASS      15.35 seconds
GitLint                       FAIL      3.38 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      30.21 seconds
CheckAllWarning               PASS      33.04 seconds
CheckSparse                   PASS      38.26 seconds
CheckSmatch                   FAIL      35.13 seconds
BuildKernel32                 PASS      29.09 seconds
TestRunnerSetup               PASS      531.24 seconds
TestRunner_l2cap-tester       FAIL      25.05 seconds
TestRunner_iso-tester         FAIL      37.56 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        FAIL      116.77 seconds
TestRunner_rfcomm-tester      PASS      7.49 seconds
TestRunner_sco-tester         FAIL      17.40 seconds
TestRunner_ioctl-tester       PASS      7.76 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      6.86 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PASS      28.31 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC,v5] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[RFC,v5] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection"
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
L2CAP BR/EDR Client - TX Timestamping                Timed out    2.329 seconds
L2CAP LE Client - TX Timestamping                    Timed out    2.250 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 118 (96.7%), Failed: 4, Not Run: 0

Failed Test Cases
ISO Send - TX Timestamping                           Timed out    2.261 seconds
ISO Send - TX Sched Timestamping                     Timed out    1.989 seconds
ISO Send - TX CMSG Timestamping                      Timed out    2.003 seconds
ISO Send - TX No Poll Timestamping                   Failed       0.166 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
Read Exp Feature - Success (Index None)              Failed       0.081 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.715 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
Total: 15, Passed: 14 (93.3%), Failed: 1, Not Run: 0

Failed Test Cases
SCO CVSD Send - TX Timestamping                      Timed out    2.177 seconds


---
Regards,
Linux Bluetooth


--===============3557917441371214581==--
