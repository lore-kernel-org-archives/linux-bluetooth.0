Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1EE4CDE0
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997731; cv=none; b=Ft8P78pf4qLJTCQMd9LPSx8Eo5xEPsi9ok+bR9/jUAz4M/NIAjoWBqACqFukzvr+dO0ImsF3slGja01IIaUEz5786O38YeTzwsaIlbmUKT378kSc2CoxbQM444jFZ/Ol6ngTWx3zJCrmiHJ8jxLxixmyiz7HcQsj5dK0mE7oVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997731; c=relaxed/simple;
	bh=HeX7jbP0wf97qqNi37vp2GcM14JsxO1fmFLfXQGiK8U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gHwJDDpmwtjhn7Y+YG3ADG4oFvPyv872HWG46+eER4vtnMAjLz7BW5ksr/nAMWPnkXYE5BapYwJadplJueuDWCkNAUCGU+v4upNXJjmrv3N/DZ3kMNvp3eVa0eizrg9WxQvfWLHkTWdT7zyifI04WVV+8MbPmlLARVNJlL7K85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBmm4vYo; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBmm4vYo"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6990b53a2cbso7751426d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2024 11:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711997728; x=1712602528; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eM5AVhBX3iAJ3K3rJIaCnrJsgwzZP1a0KwpP00D+olc=;
        b=MBmm4vYoefsfRW7dqAS4WsCj36YdKg/zjSVRJVyGU8/Hc03zJb62IV+3/0KdoA8qFo
         dLWzUyruAOA7GTkvPS4uNwmGfqTfBHUrV3gjwZI4WCIb051UHVTgssydNcpUU4ygTSGs
         gNksP+tflSFC6FaOJYsq2lVnWUydD8Tz6Rm7VaoThVq9xvYTWtmElttg/bnCTdDdBYCp
         bG6RnCn/98oTzGF/xNCpKlploECTVX7Tyru4wf1bhepTh9/AkuKU+nbGEEy/4kblZzGO
         cFDOtCAt9VOVTuxulQnwTwCdQEbAPmPIvHiAjnhognAUli03NkiipaOZP0D9Otm7BYl0
         G9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711997728; x=1712602528;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eM5AVhBX3iAJ3K3rJIaCnrJsgwzZP1a0KwpP00D+olc=;
        b=t1brHjUBafNNeXyQ9v7vc0AeVEloYxawOWJvS90pg4qjf/wFuHrvaoaG4jktc/8xNb
         W6VWWs63fBVk6Tubdh9wB2sYZh28pmV7i7cR+lrB7HJ9g3H/6dxU2JpjQp9vx2WkBFLH
         YVJpU8lVvMiJsR65fWvQAvlahgz/egf0Fl7/wjIMygGNsNfToNjww8tyvu9Bv/asXXgI
         JxDD68hROPLkRiHXwrY/dV6ErJnvSP+2/LwHnR3V5beK73rTnPTGAaP3hbydjIRUemil
         rPE/7sKl77yQhBtC8N5GkPOoL/ZKEZK17OYbYZJIeEmWCL3hdc/FTynyDInCVVZF7ukT
         BlmA==
X-Gm-Message-State: AOJu0YxgoBrWzD3oOx9/3tNrWFSd6ntL7nQKTtlQeK9Z6ROTEwbMlJaX
	fvtGUke0sdiAyVt+ODxOr5gGQTjiKWP3DhzZZTTBD3/ELSckUGSuu4HVqrl/
X-Google-Smtp-Source: AGHT+IH+64fqjmypd6U3lkjwmqTAPMrXE+3NK8deUI+iMBgn0ToC6GAOZ17YNM1SGmKE/V2Abyjt/g==
X-Received: by 2002:a0c:e082:0:b0:691:85a2:4434 with SMTP id l2-20020a0ce082000000b0069185a24434mr16240310qvk.26.1711997728146;
        Mon, 01 Apr 2024 11:55:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.46.185])
        by smtp.gmail.com with ESMTPSA id j13-20020a05621419cd00b00698f9a12ccbsm2760421qvc.20.2024.04.01.11.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 11:55:27 -0700 (PDT)
Message-ID: <660b031f.050a0220.285ce.9cb5@mx.google.com>
Date: Mon, 01 Apr 2024 11:55:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3316674919039631589=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nathan@kernel.org
Subject: RE: Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()
In-Reply-To: <20240401-bluetooth-fix-len-type-getsockopt_old-v1-1-c6b5448b5374@kernel.org>
References: <20240401-bluetooth-fix-len-type-getsockopt_old-v1-1-c6b5448b5374@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3316674919039631589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=840324

---Test result---

Test Summary:
CheckPatch                    PASS      0.87 seconds
GitLint                       FAIL      0.56 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.03 seconds
CheckAllWarning               PASS      32.35 seconds
CheckSparse                   WARNING   38.83 seconds
CheckSmatch                   FAIL      35.20 seconds
BuildKernel32                 PASS      28.75 seconds
TestRunnerSetup               PASS      516.50 seconds
TestRunner_l2cap-tester       PASS      17.87 seconds
TestRunner_iso-tester         PASS      29.90 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        FAIL      112.06 seconds
TestRunner_rfcomm-tester      PASS      9.34 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      7.72 seconds
TestRunner_mesh-tester        PASS      5.74 seconds
TestRunner_smp-tester         PASS      6.76 seconds
TestRunner_userchan-tester    PASS      4.94 seconds
IncrementalBuild              PASS      28.03 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
18: B1 Line exceeds max length (132>80): "  include/linux/thread_info.h:244:4: error: call to '__bad_copy_from' declared with 'error' attribute: copy source size is too small"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 3, Not Run: 2

Failed Test Cases
Start Discovery LE - (Ext Scan Param)                Failed       0.102 seconds
Start Discovery - (coded, Scan Param)                Failed       0.112 seconds
Start Discovery - (1m, 2m, coded, Scan Param)        Failed       0.109 seconds


---
Regards,
Linux Bluetooth


--===============3316674919039631589==--
