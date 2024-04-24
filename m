Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03115A49B
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964607; cv=none; b=M40H+wlPqfgjPPd8mu0ZbbqdmL0LGCiGpE6oqwgALjqKfln+sn8fU14g2LenYZp7O6E6QKGM5Qzfr3wKRgZkRzmhIN/hy09s08GNwHetRlwgTQbQMlixUGO9OHfDh3eLGR3IncJgfYvGXXNJqmPrYNh1RffMTNaEbbXNkbfZAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964607; c=relaxed/simple;
	bh=dWc9NiOxs61bQ8iLqxKb281U63GcvD4vMf9jjU448SE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OOM3KzpAGcE2y4/tfUm2ax4yfeiYkNZpXAsyjBM6Mcy4LOuRcHD8mxG/2vhG2kblD1nIwnMZpuvqiX6wWSPFocVBtyD7gWzGBetZMi3YJUCP659toQyE/6E0BlUEWvTj9cuaR4cu4yqlgkVD752xNfufeC+Iqa1ecLv7VddXiPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9bhr0bx; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9bhr0bx"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7906776e17aso289974585a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 06:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713964605; x=1714569405; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L6nMSC2z4IMfHQ/mx9vCVwszz1htEPpHHMn+C6AjAW0=;
        b=F9bhr0bxnq5O0eWS1zmWd59b1vMovM4SRgs4NWSpp2okEfxOqwtV3kRujKUMPISMlO
         SSixLO1OWhcm/5MHjDZUI7L8lbPqrZm9md5Zefq694sGQM/akJECHH/34Mxqpo5KjMSH
         8fjn2edUqrwM8pGk9uk9kjcKxDv1pof0A9B/tnOigStxTtsioybL84+CrQ3wL+kivg7E
         EnL2qUPjsH7UMXYJhsGUrLcirQHZDgWBuCntCeqv2t0U1boaG1Jdbs5rVH8kcBsUDqAA
         7+ejhnVfvRQ3AAjdRJGzeayY4t9pVc4zPfBbId9JRBqjOciCHv+SQO+QS2FSCXf+p+3b
         S93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964605; x=1714569405;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6nMSC2z4IMfHQ/mx9vCVwszz1htEPpHHMn+C6AjAW0=;
        b=OHbqa/DYnFyFtaaOQ7jF8Jr3LE7I3FypPKmmZGWnXDXoqM6GUvFA7iIUjOhmBdBLwd
         ETaA26aH72HhIyziavTTVskLsQsdZ5562ok0N8lZ9jCKRp4utn4b0VbEFpLk1WY5cIVK
         DzrkJ4j/mY/hLLbcL+vELdDYonw3GvFsXjgUb77L8BGImyrTcRd5lCR47aRuJfXHLW1n
         n0KEMDBeRGcp9CHqVv81jXQisFuwPnfydBcBIfFDUgagMIzatStadqJ1pMGJPyA3aer4
         4rfbM75LaSq8HXhSEwbAzx1daxsctUGg1G9EzgPtB0Aq70+btYXLBSXqPtnhx29hL074
         fTNA==
X-Gm-Message-State: AOJu0YwBVSs+QqjlDTPug/KWeIiADqlDAG67YmTOHM6NUVJnijNJlcJ9
	PfWBZrwq2YRm6qWv+24cQkXgCUP9v1kMLlD0+Ku0/g5dlDO4s+jpAgwslw==
X-Google-Smtp-Source: AGHT+IFj/Nh6d4u208wSZ4UHJBDglOj9aqVTCNFaq9PH2hFpRcidKvImnxUqsY9hhuksV61wQ8Ec0A==
X-Received: by 2002:ad4:418d:0:b0:6a0:5cc7:fd86 with SMTP id e13-20020ad4418d000000b006a05cc7fd86mr2511453qvp.21.1713964604603;
        Wed, 24 Apr 2024 06:16:44 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.52.193])
        by smtp.gmail.com with ESMTPSA id o6-20020a0ce406000000b0069b20891f0dsm6069478qvl.30.2024.04.24.06.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:16:44 -0700 (PDT)
Message-ID: <6629063c.0c0a0220.44c60.b37b@mx.google.com>
Date: Wed, 24 Apr 2024 06:16:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2185567362554729166=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: [v2] Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()
In-Reply-To: <20240424122932.79120-1-brgl@bgdev.pl>
References: <20240424122932.79120-1-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2185567362554729166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=847442

---Test result---

Test Summary:
CheckPatch                    FAIL      0.94 seconds
GitLint                       FAIL      0.51 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.92 seconds
CheckAllWarning               PASS      32.99 seconds
CheckSparse                   PASS      39.01 seconds
CheckSmatch                   FAIL      36.66 seconds
BuildKernel32                 PASS      29.51 seconds
TestRunnerSetup               PASS      537.50 seconds
TestRunner_l2cap-tester       PASS      21.34 seconds
TestRunner_iso-tester         PASS      31.05 seconds
TestRunner_bnep-tester        PASS      4.70 seconds
TestRunner_mgmt-tester        FAIL      113.32 seconds
TestRunner_rfcomm-tester      PASS      7.47 seconds
TestRunner_sco-tester         PASS      15.20 seconds
TestRunner_ioctl-tester       PASS      7.94 seconds
TestRunner_mesh-tester        PASS      5.88 seconds
TestRunner_smp-tester         PASS      7.04 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PASS      29.56 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#108: 
Reported-by: Wren Turkal <wt@penguintechs.org>
Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>

total: 0 errors, 1 warnings, 39 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13641795.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (84>80): "[v2] Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()"
16: B1 Line exceeds max length (106>80): "Closes: https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/"
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
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.174 seconds


---
Regards,
Linux Bluetooth


--===============2185567362554729166==--
