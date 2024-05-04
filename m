Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8261E51E
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 May 2024 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714852538; cv=none; b=QYjR7WR4okmVg2ucVK3CCWL54tTSyapyL5QhcKd9JCj95pHRttTRZm0ZEBRx61KbobaiLOyC9Wz+9aoFY6CtVi8mgVpjKzxEYf4Hpu/ZSBYyiE90if+eEbreAP3WFLcQimy0yiYZYd8tu9x1iiZOQUrxfmFGFva6qljTmEMgJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714852538; c=relaxed/simple;
	bh=smRlI5Bl6TI3DU7RNq6LsqVz360gcSqAzLwXuvtWtMg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=akDkpcpS6B2onngtamWnIpyshPyvss+PtUm/rLAKRLHzn3ag1EZof7wEpSrwhHXatZ6106nTWbqk49wqTqtvpKFcFAEGQqdtqV6b5XFChggqVzGaTX0R3p4Gqbn+wB2k9liEZTvBLfUTIBlhKUhbKyQxyChpFpSaRS3Cdfmou4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fY6oRukW; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY6oRukW"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de477949644so764681276.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 May 2024 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714852536; x=1715457336; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tkE02CnuD0QbDW8FbjKul8QVNArjaUkf9TXscGKx1NQ=;
        b=fY6oRukW7pdiKzc9Eeqiu7AI/cxt72YFI2TIX86cT03eEpvI2vuTV0E1DGbkkwqPoe
         EHWjhpAMuBhvPLou+9FyJf6FXiGSACBKueH/QjjIfe9Idr4m8kb+iUIImYkN7HvC+VNh
         PdrP8BJH1SyvOcRfnLi+OGfkZwUTjPbZDcx0ypCm7Hoh5I9HiOYf9sTvNdQpSk/WmWRI
         J0A5/BAFWog5GTwSyPltHWTeKTj19uvqtmtaHfaG4YsSuAMJdilqCLhzJhBPXb5OuZAW
         es2GpAs4MklsamZRplqo/B028EgwDTRhX71pjFXBZTlvKYZMemOd1RT/isOKVBSGmqe0
         sSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714852536; x=1715457336;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkE02CnuD0QbDW8FbjKul8QVNArjaUkf9TXscGKx1NQ=;
        b=PkFMOue8pu7WnmZJtuHh/X/5jwJP4IZdWjq6DWowk1X6PC7ikuR81U4R/G1Qae4j82
         dAf7OlVJVXfji29o46rTaRIXJAKIG9ExBS6mdKU6oXAYwIVlV67KYbJYTX4xy8WDFYYS
         FmBEij7IvGUo5gNnfUlRK7iTFgQsaYYuwwkZz5ulkbTCj/I7KyMzpRpRF4YX29pK4jjr
         JHu9SjusSvB3n6wtJQ7XZgKnGcIJhCBOYBR1b9E2ti83CEYmH/syP2PM7daKBK4Aq0j0
         RIGoCklJlNH43iPBa4EZCpibwqoHOmaZMhFkSXun6VYXbbQ7VMz4+a6j5DVFOmyAU5R2
         kNdQ==
X-Gm-Message-State: AOJu0Ywz0GM1T3SjA1WvYcqDKkzyEyp+tzpz0nmrGI3ejBMxxGhz2yOU
	JZ7OPnPRl9bhdsOLF/ypT+zWM/ErRdvi0e+I9DgsdEXrCF4t5FF4sS/7qg==
X-Google-Smtp-Source: AGHT+IGd0iIAgkUNfp/MkDwGMNcc+QDp1eyDdPGKSeiqdiJS86th//qeLGJx22YWt5SQkVkonNSPcQ==
X-Received: by 2002:a25:8711:0:b0:de5:a4e3:9d3e with SMTP id a17-20020a258711000000b00de5a4e39d3emr7397839ybl.9.1714852535934;
        Sat, 04 May 2024 12:55:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.88.15.127])
        by smtp.gmail.com with ESMTPSA id d125-20020a25cd83000000b00de5852c4d35sm1187900ybf.19.2024.05.04.12.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 12:55:35 -0700 (PDT)
Message-ID: <663692b7.250a0220.34a429.500b@mx.google.com>
Date: Sat, 04 May 2024 12:55:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8466159939501898911=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: [v4] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()
In-Reply-To: <20240504192329.351126-1-iam@sung-woo.kim>
References: <20240504192329.351126-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8466159939501898911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=850490

---Test result---

Test Summary:
CheckPatch                    FAIL      2.01 seconds
GitLint                       FAIL      0.50 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.25 seconds
CheckAllWarning               PASS      31.80 seconds
CheckSparse                   WARNING   37.26 seconds
CheckSmatch                   FAIL      35.23 seconds
BuildKernel32                 PASS      28.22 seconds
TestRunnerSetup               PASS      511.11 seconds
TestRunner_l2cap-tester       PASS      20.21 seconds
TestRunner_iso-tester         PASS      28.19 seconds
TestRunner_bnep-tester        PASS      4.66 seconds
TestRunner_mgmt-tester        FAIL      108.29 seconds
TestRunner_rfcomm-tester      PASS      7.13 seconds
TestRunner_sco-tester         PASS      14.83 seconds
TestRunner_ioctl-tester       PASS      7.42 seconds
TestRunner_mesh-tester        PASS      5.68 seconds
TestRunner_smp-tester         PASS      6.68 seconds
TestRunner_userchan-tester    PASS      4.79 seconds
IncrementalBuild              PASS      27.22 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#96: 
CPU: 0 PID: 67 Comm: kworker/u5:0 Tainted: G        W          6.9.0-rc5+ #20

total: 0 errors, 1 warnings, 0 checks, 340 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13654104.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
18: B1 Line exceeds max length (199>80): "Code: e8 17 17 0c 00 66 41 89 9f 84 00 00 00 bf 01 00 00 00 41 b8 02 00 00 00 4c 89 fe 4c 89 e2 89 d9 e8 27 17 0c 00 44 89 f0 31 d2 <66> f7 f3 89 c3 ff c3 4d 8d b7 88 00 00 00 4c 89 f0 48 c1 e8 03 42"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
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
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.154 seconds


---
Regards,
Linux Bluetooth


--===============8466159939501898911==--
