Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CC629429
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926416; cv=none; b=KyIq1rwQyOihuTd1ijkOUaRnHSYxYeUFCL/fpBIJVREnd5GKJ5M3kxjWPAx+5fXZwXE4e+5mV48atFczAvaGfaOGmeVptqNoSbAlM7rbf2GNUWhDWSkHw0ai5SPc8k8oFn+PeRtUxh/2MGtMI5vk8ZIgL0LEerHSwCRauh7LHI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926416; c=relaxed/simple;
	bh=TMA+BIYJpA/vwVv+1rADFYX/N1+G+M4KbS5KP9THjjA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rapwb0YcsO1wFuckCBFogZj8Kacv44jLxc5iXTEXxEF2++XPB0Lg+rDNjb51AlV602QPDOZ4Vy6Z2QCK0ESZV4wrOXfv5eyQRJzwrthkTR2XzvB41k3S3Y4g7j34cVomXGw+MxGBhqoRUReb013sVAtTmPxc0GT37WS9Hx46GDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4sGNd8Q; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4sGNd8Q"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b24162dd6so32247516d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 19:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713926413; x=1714531213; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6JJKZvvlRclgklQaHx/OyHmQe3e7rg4F1P6Lhcto+q0=;
        b=d4sGNd8QaNxhWvmTiyWwy92gRwORwHMOYmXikEpHkdvveP+hVTWww4sTDrKxl/40Jt
         NrUbiwbyOMLMzpN8a0NvxHjvh5JD0xLaLI/mJzQsrLfCgJmtf9PkVzDB2HVCB+wgsCfa
         5IS+0nCLCK30gM6AWNQof+8HiLRG2TqNSanc+WHkUW2vK0hg8S7bLp9sZxj0d1wwlKEI
         VxKi6A3c7OaIdD5ZMrl9sgYHM7wwY9dI0juU1SI7ME94cu2a0mWf6lF6voFKY2d0bGVF
         zf6j6BnuwBWekPU0uFTExd1zL1v0PVnSvKTnqBm7ijGDCrRtJxvFB74wJawS5/7JBc4H
         Jhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713926413; x=1714531213;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JJKZvvlRclgklQaHx/OyHmQe3e7rg4F1P6Lhcto+q0=;
        b=OniigVQSsTBrEdFhoIu5QyXCOljWXlDrH46Ur3bnmdz4L4A4kyT+z0pIxnhioqSUIQ
         ROl64CFtkyf44nACd1+8njSb0qPxtXUI2P65Z1pLGStFjRVNJItBhU5XO5GDEDdp+RR2
         PPtH6nm1BwxcPkVBx+LkZS2G+7NEAbPRU8GwTcMIgw5v7WYUdkqAwScP0HVRJ6Hm9cLt
         RG9Ss7CA7Hp1R208TtEdaSmtHK/RFBTLg514OgozBcibfVb6OrHF8MYkEt9gbx3rJJJb
         Akx0y2yBhp8afRuQ4Y6taaGFFEMFCyiTaye/ddjnkXP9e4Btg7PPq7BFhpq1TbpvyLYx
         gtcQ==
X-Gm-Message-State: AOJu0YxAtGRJim6BQ5vrKK8MbiSSSEnXnKEFNsJOH40OTyhG+GgbCaDA
	HkOe1g1Q2ZfYnjFD3ZXrx4EZGitdybkDTS728nMkN02qnxBEd2RFF93v6A==
X-Google-Smtp-Source: AGHT+IE9/6UcwKZL1z5Ondgm8Yo2RMh7HwwA2M3XltUOUs/nNzHLu27KNYqTuHlgsEL1wvs4/r3+Iw==
X-Received: by 2002:ad4:58a9:0:b0:6a0:5673:e50e with SMTP id ea9-20020ad458a9000000b006a05673e50emr1008121qvb.53.1713926413172;
        Tue, 23 Apr 2024 19:40:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.82.195])
        by smtp.gmail.com with ESMTPSA id y18-20020a0c9a92000000b0069b5ec80687sm5706204qvd.62.2024.04.23.19.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:40:13 -0700 (PDT)
Message-ID: <6628710d.0c0a0220.4a939.a190@mx.google.com>
Date: Tue, 23 Apr 2024 19:40:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0899978661227844354=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Fix two BT regression issues for QCA6390
In-Reply-To: <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0899978661227844354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=847233

---Test result---

Test Summary:
CheckPatch                    FAIL      1.47 seconds
GitLint                       FAIL      0.73 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      30.08 seconds
CheckAllWarning               PASS      32.38 seconds
CheckSparse                   PASS      37.95 seconds
CheckSmatch                   FAIL      35.95 seconds
BuildKernel32                 PASS      28.92 seconds
TestRunnerSetup               PASS      520.94 seconds
TestRunner_l2cap-tester       PASS      20.19 seconds
TestRunner_iso-tester         PASS      30.42 seconds
TestRunner_bnep-tester        PASS      4.68 seconds
TestRunner_mgmt-tester        PASS      116.79 seconds
TestRunner_rfcomm-tester      PASS      7.24 seconds
TestRunner_sco-tester         PASS      14.86 seconds
TestRunner_ioctl-tester       PASS      7.60 seconds
TestRunner_mesh-tester        PASS      5.75 seconds
TestRunner_smp-tester         PASS      6.64 seconds
TestRunner_userchan-tester    PASS      4.81 seconds
IncrementalBuild              PASS      33.01 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v6,1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#119: 
Reported-by: Wren Turkal <wt@penguintechs.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13640915.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v6,1/2] Bluetooth: qca: Fix BT enable failure for QCA6390

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
16: B3 Line contains hard tab characters (\t): "  	dev_warn(&serdev->dev, "failed to acquire enable gpio\n");"
17: B3 Line contains hard tab characters (\t): "	power_ctrl_enabled = false;"
24: B1 Line exceeds max length (139>80): "Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f"
30: B2 Line has trailing whitespace: "V1 -> V3: Don't revert the whole wrong commit but focus on impacted device "
[v6,2/2] Bluetooth: qca: Fix BT enable failure for QCA6390 after disable then warm reboot

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (89>80): "[v6,2/2] Bluetooth: qca: Fix BT enable failure for QCA6390 after disable then warm reboot"
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


---
Regards,
Linux Bluetooth


--===============0899978661227844354==--
