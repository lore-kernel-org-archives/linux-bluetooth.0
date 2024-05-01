Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E703FB09
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 04:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714539444; cv=none; b=Qyz4HeabOXjJiKdodTxhqeRp5IPIxgnQbAYYd3t2tC9GvlMMt6cOXbf4F7h4Nzy/H3v8A228rMLL1WrUaC96609IWrgkhYUQXva2In507HkxbsVm5QBW1THGNOwcRChBRLfK9WX4Nz4OqIRg5fHh1uBg7rGXoDl6QrRLSNbx4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714539444; c=relaxed/simple;
	bh=tKFJjH55IHg3Q8ssQSkQdunpDp+hqOPQmSjxDLTBscE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WQPlcJdMi14ZcleWiT1nC9mBJLs0C5FdqU4kkfqlckbLwBQMF9rJuCPSl8gLkqMj9BhT9REL5YOB/HqFuXRp9GZH1SiyUNJKTEuT2+G3G/Bj4SeptK9rxOKGqwIp69P9utpcThJuMrHZOJqjeBFvARLByxuzOA1arsPotHyxf3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp+qc0w1; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp+qc0w1"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78efd1a0022so502895585a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2024 21:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714539441; x=1715144241; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oDCDJdyjNImmGyCTb9PR8Z8LgtD+uMPzDjMQCLRZv0I=;
        b=Bp+qc0w1IASQTNZhhLrn7fFFz14QfJK95W3CdrYT7hyNCGDMsd35oZPHtLKV5dPze4
         G8gaUc8/kdl9ncAVlhZUKtTilkDiN/Q/fQnmzUsizv/eBgDneC1SxN0UkVKWDq5pwcaO
         JY+CtjRgtAD2raSWn92OpbHJBDT+m7sXTn67trMAPs/k32j2BQJOxQN5+J6YM/44MNBM
         l8NuMAyIur+BWwEdUAWMlLLEFvVssfEdru1zSrtWvfG6/k0CXYTDU7SW+vx3jgSiFAda
         e1PkvMKIfuSSLbrrehSc52hlWwj1u0jN1+3E/bp/PyMyuZNZ63gA1nLYkad8rde1u87s
         4ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714539441; x=1715144241;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDCDJdyjNImmGyCTb9PR8Z8LgtD+uMPzDjMQCLRZv0I=;
        b=lDQE2Cjgi8QRpSgepuB0Bw+NwDt29KhPFTtlfLKGIAMxSNWUoHULsj3HBsGb5jR+Z7
         BySDiPMOfqpzUUZsj/SJpxvkLVM0Y9K3XRqm/HIuiOI11asHNG6Ocp3qBt90kterT8tP
         tIilicR3GOa+7iWf0R0FIZbcqnDSz/JljOhCdeXijdbITXA861Z3L8RZGhx4IFOShKE7
         8DsKueKgOYmixxomx52CPg+pjbbBJ3XxjLDfsGiJTst2HlkCtEAKtHwm5fEXmAmYLzBk
         TUd9Q8Zh1LTToAFG0sMQgoTlhBRGYxP+DIChpsabYa/Q94SGKhC6iOZvIhn3KsXRQPPp
         EkZQ==
X-Gm-Message-State: AOJu0YxEAX129QL2EtdiyKU3qTu96vfa0A4lKdN9C+aoEHqokC3+9z9d
	rnJ02imb54Z0QOE1xUHp7YwMp+myH9nJWht4gDwVHqpEmjcSbvWeSDzD1ij1
X-Google-Smtp-Source: AGHT+IGoz249fjcqSHoL/tEalKNWv74nDk93D3VVf2rvVfhyKsMsqkAlKirtrutDfSXgnSSAjpCXXQ==
X-Received: by 2002:a05:620a:3782:b0:790:ad27:41a8 with SMTP id pi2-20020a05620a378200b00790ad2741a8mr1167801qkn.8.1714539441208;
        Tue, 30 Apr 2024 21:57:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.184.188.234])
        by smtp.gmail.com with ESMTPSA id h14-20020a05620a10ae00b0078d6303c099sm12013992qkk.112.2024.04.30.21.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:57:21 -0700 (PDT)
Message-ID: <6631cbb1.050a0220.2f3d5.71ee@mx.google.com>
Date: Tue, 30 Apr 2024 21:57:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3502491486361169370=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: [v2] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()
In-Reply-To: <20240501042936.2579739-1-iam@sung-woo.kim>
References: <20240501042936.2579739-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3502491486361169370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849562

---Test result---

Test Summary:
CheckPatch                    FAIL      1.30 seconds
GitLint                       FAIL      0.52 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.98 seconds
CheckAllWarning               PASS      34.78 seconds
CheckSparse                   WARNING   41.73 seconds
CheckSmatch                   FAIL      36.49 seconds
BuildKernel32                 PASS      29.28 seconds
TestRunnerSetup               PASS      525.06 seconds
TestRunner_l2cap-tester       PASS      23.57 seconds
TestRunner_iso-tester         PASS      31.38 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      119.48 seconds
TestRunner_rfcomm-tester      PASS      7.26 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      7.70 seconds
TestRunner_mesh-tester        FAIL      5.98 seconds
TestRunner_smp-tester         PASS      6.85 seconds
TestRunner_userchan-tester    PASS      4.94 seconds
IncrementalBuild              PASS      28.88 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#122: 
CPU: 0 PID: 67 Comm: kworker/u5:0 Tainted: G        W          6.9.0-rc5+ #20

total: 0 errors, 1 warnings, 0 checks, 40 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13650236.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
44: B1 Line exceeds max length (199>80): "Code: e8 17 17 0c 00 66 41 89 9f 84 00 00 00 bf 01 00 00 00 41 b8 02 00 00 00 4c 89 fe 4c 89 e2 89 d9 e8 27 17 0c 00 44 89 f0 31 d2 <66> f7 f3 89 c3 ff c3 4d 8d b7 88 00 00 00 4c 89 f0 48 c1 e8 03 42"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
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
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.163 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.099 seconds


---
Regards,
Linux Bluetooth


--===============3502491486361169370==--
