Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D071E4A8
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Apr 2024 05:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714197194; cv=none; b=gvJGihyLCsPFqzigfTSto7h4HNIPsN9I25lZFFfhYSV5xrXmEoaj5SwmuapVP+QCvG7Da2CDrysjK/H3V53BzOkoWXNC3DmbfzXSiXH7g2Cv/kqtWuG66TN1gOaIJ/1cwoWwu0Rc0wntOiJtqEdwEIlF7EzXykThxNI5Aq1GRFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714197194; c=relaxed/simple;
	bh=5q9Z8MVMsT5mQQf2cgbPa7EUa5HCTcoGDam6Aazv9N4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hqHNo21M06Re1mN5wYRZ6Bj2ZrL5cOvI3R0ri0Iwn9YakdG/jMEAXvgA+vCb3OegZmUlz8JXtER5o2gj/dQbtoOH8rJYR/9V7ytJrf4jy/QQ/X+MRqZ08gIlWGcukEq3PXC0G4LgzMq9dviDaia4xCXmwUvXekyYkvMTQxRN3nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5SyTrem; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5SyTrem"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-434d0e3f213so11621091cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 22:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714197192; x=1714801992; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Xwj6+WC/uk+vYcq94kjHgIbFPQwTXxHFTntfNrdmW4=;
        b=E5SyTremBbDL7YT2gW2GV2edZvUo+FBAfLPcFfgFSK/YbIcSE3htv+FOp1q9IvMhNI
         /lGSHCuzPjEmEjw7zRgPwQgX74X2WgKh7S1el0QoWsNzp6pzBUb9SH4sTLg7y42EPAP9
         SBlcfn493Gn17s0G2F5oHdY8btrsAMqDwIyCmVCnRFHOVJzDNq/J0SOco8lI9eqG3cJR
         KrrscHcp/TK9nDAVcKkTmQhwCgnmv6iRd0+ZnR9/nhqw+06PTCao5jVC5GrVnD0nDkbw
         T1pHZmzOFTGNf2laIoSDIb3w2C0jgVZ5B93NOwA54NhdukvQ3wI14U3th1fAt3aGTB60
         HGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714197192; x=1714801992;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Xwj6+WC/uk+vYcq94kjHgIbFPQwTXxHFTntfNrdmW4=;
        b=HcG0ah7OUu7vG45+7gI2NJJ8KzkHiQHBpTgnL3UtRA7LbMIcJu0zvoZ3TgjRjxscwa
         CvTTGRn1zygUKEIcuMvUHLPsfuicjnqhjwmOAHUzX1tNzh7VNsNiwQcjzyQOx6lrk1qA
         ooZBXUWSORR2gJnWdyQ9D0ntdvC2b5FUsjK14CHidRVAtWtlNVo4PXelal0CkHbhERce
         Pk9y5TWkrz97oA5NAj3CS4qqNALyTQ1h9zO5Y9ulKqw5qSZLeFxWbhE01vmymUPPA5Lb
         xjMSDi5daShWJFGhqTSLux8ArHzZSS9Xjfz0Mj1o6vY2Z2mQrY84wAvHD9Dr3eHs4P2v
         Zukg==
X-Gm-Message-State: AOJu0YzqaFspc/2++hGLoqFPMAJLIEelJ+MoyPqniiwIltiSF/BoaFVf
	eHdke3M3ObmS8kagj6tEmjYSNKKfdq2kq6w6yWy/eO4+Gdv7ioIwSk/jqQ==
X-Google-Smtp-Source: AGHT+IGlisi5wKNOz133poUsQSzGN6pROn9j1olWd9Am5xli7dwGgkfMJ7MEpykFaDn1V2BWBG1eMA==
X-Received: by 2002:a05:622a:2:b0:43a:b15a:f8c3 with SMTP id x2-20020a05622a000200b0043ab15af8c3mr158469qtw.29.1714197191876;
        Fri, 26 Apr 2024 22:53:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.108.37])
        by smtp.gmail.com with ESMTPSA id r22-20020ac867d6000000b00434e990098bsm8518175qtp.77.2024.04.26.22.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 22:53:11 -0700 (PDT)
Message-ID: <662c92c7.c80a0220.47e82.e1ec@mx.google.com>
Date: Fri, 26 Apr 2024 22:53:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1737304411530877115=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: msft: fix slab-use-after-free in msft_do_close()
In-Reply-To: <20240427051934.879051-1-iam@sung-woo.kim>
References: <20240427051934.879051-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1737304411530877115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=848460

---Test result---

Test Summary:
CheckPatch                    FAIL      1.00 seconds
GitLint                       FAIL      0.48 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      30.37 seconds
CheckAllWarning               PASS      32.62 seconds
CheckSparse                   PASS      38.84 seconds
CheckSmatch                   FAIL      36.55 seconds
BuildKernel32                 PASS      29.93 seconds
TestRunnerSetup               PASS      521.44 seconds
TestRunner_l2cap-tester       FAIL      4.60 seconds
TestRunner_iso-tester         FAIL      4.63 seconds
TestRunner_bnep-tester        FAIL      4.54 seconds
TestRunner_mgmt-tester        FAIL      4.67 seconds
TestRunner_rfcomm-tester      FAIL      4.60 seconds
TestRunner_sco-tester         FAIL      4.57 seconds
TestRunner_ioctl-tester       FAIL      4.65 seconds
TestRunner_mesh-tester        FAIL      4.60 seconds
TestRunner_smp-tester         FAIL      5.68 seconds
TestRunner_userchan-tester    FAIL      4.65 seconds
IncrementalBuild              PASS      28.36 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: msft: fix slab-use-after-free in msft_do_close()
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#100: 
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014

total: 0 errors, 1 warnings, 0 checks, 287 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13645561.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: msft: fix slab-use-after-free in msft_do_close()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
19: B1 Line exceeds max length (90>80): "BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:587 [inline]"
20: B1 Line exceeds max length (85>80): "BUG: KASAN: slab-use-after-free in __mutex_lock+0x8f/0xc30 kernel/locking/mutex.c:752"
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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_rfcomm-tester - FAIL
Desc: Run rfcomm-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
No test result found


---
Regards,
Linux Bluetooth


--===============1737304411530877115==--
