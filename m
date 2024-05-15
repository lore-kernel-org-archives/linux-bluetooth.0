Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977443AA4
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758394; cv=none; b=R/MSTCSNqMakVprYSGb2xMih/V6S0Pt5FGQOTiWK81zKGHO45Uugj5BzjL8h/VqLQb2+L3uzc3i2jd6afhzDElxl6qUmv8yTiNB8wU5o0cg5doy7vkAkIaU67rKMpqTVJQrYdm2/CJPxK3UpLt1Srn9YkNVevmurvSnlSoGn23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758394; c=relaxed/simple;
	bh=TLh03MCSiqN+5UcXuSYZ52ymbXmnq0IFRrLRK252MdQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DddaMF3MrHoezVYE62B0J+K5TS3ylFTc3lc78MBYouRLI7P7NLVg8QfpWs/RjsL3ExyOowvFDcCG/Tun3CUY1Lfz/Zkk4UY5Txeq3E2PSn0oJrcuyA1Ume4yJtZoWe2hdjDUGD9QFYt9hbWdHKoduvUW5M86OIM7r3ipeSxP2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKOQcnQj; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKOQcnQj"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-47efcb120feso1951141137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715758392; x=1716363192; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OxYsEFRZ4jHBYKzbLILZDk82wmluZ7w/ABrgfc2B8Fg=;
        b=kKOQcnQjLSwjGsGtUP00KRRadRyN2RbvqEhkn8d4D/jj0kNKRfjAt5bq58aXo+R6pe
         1dTbSZeG6/1DFZ6JG5+kLePUA8X8hPOgVhxZ5JRJui3JOR+ZpRp3wd0odzAgncp7H+Cf
         a3aRW2G6H4aKHi4ceXVibtPdcUr6851Q066nyMbiC5uZGrVRmrW2utYMvWC0/K6IdBoi
         SeV/X7Axd7rx3vVjP3wLSSjKskpk9jR63wW+EwOs6LBtO6NtgOP0VT646UQ3qBTodTzQ
         oLUTA006LUN40Ahs3tSvWaIYAevzw5PWXueSZ87YPpjVjmTq4fOkXkHVIVwSW9Zo17AR
         lFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715758392; x=1716363192;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxYsEFRZ4jHBYKzbLILZDk82wmluZ7w/ABrgfc2B8Fg=;
        b=drCmlA25B5VGNhWnp7oNC1vRS+Uomy3bn92L9OaE2z8YmrgZuVi4FQaSAxxoHrsgH2
         YoXY7d/XV164mh3AicySl/UV2UHpn8fnIeL+SwvU9lHR6NKwAy7Tav97zFzdfphDKKQH
         oJF1MmsElGVpddlehFJBmJR9WoU35sc/JSnDNOzSi1YWMAgRA1sp2jNUF1iRgg8g4cxS
         alngvfvRuGVnpL5rNtwKa7hJJwO0CEoK/RIqSd1QLB7d83TcPVEbSZZM2F/3aktDHCdR
         rFWQnby6eIAyRfqDgae+iJJAVZenYQO34NFZro6Vw39PtXaD5oKJX/P1PB8oUVPSB1d8
         HojA==
X-Gm-Message-State: AOJu0YxIf3FBowbBOC/b5PkjiB1mRtKUtiNFzf28cxRmbySbJ7OJv1KG
	rySx3Lk7ml77v86hRe/aA14g2UDjaEVBieo6YKbryVB9qa2/9jQzA3/nvQ==
X-Google-Smtp-Source: AGHT+IGgU6kVCLOvw44m/TNTsjett0f8+hoyiqimdoQroyf7h4Ch6PmaCN+NjV63KH6mJguJ+c41xA==
X-Received: by 2002:a05:6102:3f01:b0:47e:fbbe:605f with SMTP id ada2fe7eead31-48077ea29camr17447544137.32.1715758391889;
        Wed, 15 May 2024 00:33:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.191.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1d6cbdsm61014696d6.104.2024.05.15.00.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:33:11 -0700 (PDT)
Message-ID: <66446537.050a0220.cf3bb.3d32@mx.google.com>
Date: Wed, 15 May 2024 00:33:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1722459042990511681=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Enable status prints for firmware download
In-Reply-To: <20240515070657.85132-2-neeraj.sanjaykale@nxp.com>
References: <20240515070657.85132-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1722459042990511681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853314

---Test result---

Test Summary:
CheckPatch                    PASS      2.18 seconds
GitLint                       FAIL      1.14 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      30.80 seconds
CheckAllWarning               PASS      33.53 seconds
CheckSparse                   PASS      39.12 seconds
CheckSmatch                   FAIL      35.57 seconds
BuildKernel32                 PASS      28.60 seconds
TestRunnerSetup               PASS      519.51 seconds
TestRunner_l2cap-tester       FAIL      23.08 seconds
TestRunner_iso-tester         FAIL      38.16 seconds
TestRunner_bnep-tester        PASS      4.67 seconds
TestRunner_mgmt-tester        FAIL      113.69 seconds
TestRunner_rfcomm-tester      PASS      7.30 seconds
TestRunner_sco-tester         FAIL      17.39 seconds
TestRunner_ioctl-tester       PASS      7.68 seconds
TestRunner_mesh-tester        PASS      5.79 seconds
TestRunner_smp-tester         PASS      6.74 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      35.92 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,1/3] Bluetooth: btnxpuart: Fix Null pointer dereference in btnxpuart_flush()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (99>80): "[   54.634586] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080"
22: B1 Line exceeds max length (391>80): "[   54.710152] Modules linked in: btnxpuart(-) overlay fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc caamalg_desc crypto_engine authenc libdes crct10dif_ce polyval_ce polyval_generic snd_soc_imx_spdif snd_soc_imx_card snd_soc_ak5558 snd_soc_ak4458 caam secvio error snd_soc_fsl_micfil snd_soc_fsl_spdif snd_soc_fsl_sai snd_soc_fsl_utils imx_pcm_dma gpio_ir_recv rc_core sch_fq_codel fuse"
23: B1 Line exceeds max length (88>80): "[   54.744357] CPU: 3 PID: 72 Comm: kworker/u9:0 Not tainted 6.6.3-otbr-g128004619037 #2"
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
L2CAP BR/EDR Client - TX Timestamping                Timed out    2.411 seconds
L2CAP LE Client - TX Timestamping                    Timed out    2.236 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 118 (96.7%), Failed: 4, Not Run: 0

Failed Test Cases
ISO Send - TX Timestamping                           Timed out    1.838 seconds
ISO Send - TX Sched Timestamping                     Timed out    1.993 seconds
ISO Send - TX CMSG Timestamping                      Timed out    1.994 seconds
ISO Send - TX No Poll Timestamping                   Failed       0.162 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
Read Exp Feature - Success (Index None)              Failed       0.075 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.170 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
Total: 15, Passed: 14 (93.3%), Failed: 1, Not Run: 0

Failed Test Cases
SCO CVSD Send - TX Timestamping                      Timed out    2.273 seconds


---
Regards,
Linux Bluetooth


--===============1722459042990511681==--
