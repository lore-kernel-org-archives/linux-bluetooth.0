Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7573B3C15
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930244; cv=none; b=Q9Ip/KZ7HOoSVznvxFYWf1gUKIgVKqjA7G/ODDjPHiW6gjIHozD1VT2oCz8BIOG5WisYdfQDTLibM4KuUPE53nlhBuROOMVuwtAjD1/XFoHo+xCa/mSl7FmSBj5v7Tko6toCN1yBa5bRyP2lhZNlYJfr9Uh09vigjhf+4BOBizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930244; c=relaxed/simple;
	bh=wkJNrzNyAA6GYifoRVZOiF3e+LhmkpbSWzB1+2bAGbo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FDJNQHPR//mDmfFrhRLy5RECUSY7JfyROM9xWXSJmjJVNHMBYK8KbDDV93mqY/kThxeNjT/LPO9JiElwUJ7Jp412m6qtXuVJuL9CT9nTDJFoh+UWwgzjRcXnBIrWjqADSaEnSrAQGRM9puvAGSRbTzb/pGRL27YGLIkhWccR3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pn4zJa60; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn4zJa60"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so914228a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 14:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784930233; x=1785535033; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TXbyjvVsS2e4snNhY81K6uk5S17KBkrPzE353LXbpEU=;
        b=Pn4zJa60mD90akHncLY6zq+Pel5LvEhXPnezHbQMHmO+uFPWPUv99whDItSkX9eeok
         AdH5jXOkMHIp3dR9UMKNNmjSsbd5KkvtjKxdQSPn+YIBN+6N2T1Qg8R2R2KTSXA5ZZ3E
         Y/9iEhsr70NB3YAS0RapVg9sXWfstUyMWOJnK4DIbPuLrzmXKMJ40D2Cvzu4JC1sGETp
         X9inNvzIkxt8iHQEn5MhifTDedN+NbGUmdmxCZomHMza26rdgKeLulOeu1eTCPVusOzX
         kzrE/eBcYEo2Cl/dSU81G0i2AgqegPUh54oQrpSgAEwkvo/G5vOTvJ0eMGr0quxEAc3c
         ijSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784930233; x=1785535033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TXbyjvVsS2e4snNhY81K6uk5S17KBkrPzE353LXbpEU=;
        b=M7SztHi+7cYEYHXN/tlk8GDp+5ep7ExuM39N4O5KCpab4qNM4/3yW6symFFfvSpEr+
         nHVa1sRN15r3XPOBO72vBoMw60Q7vjjbWZSA6FyWZiRTDzfdAcMNOco9W1ERSvpZnmPf
         Q9EGVaLd27GB45jD/OxMl0Y8h6avrJ0QApBm8KI/oODL5nG2sDFdW2OU/GkmRKgsQpu8
         3wvv6UGRwejyRZWRlIVOmAsUsuJ2lxS+N1KdemFqjorY2F6HCre44YQwOM2g3VnRSUNw
         1sAcwH/hNSYpBjThj+jK5UeBcu9bz4OIbmtW+BOh69ZupE4umgLCdOaGkggj/hxe+QqW
         AhFg==
X-Gm-Message-State: AOJu0YwslJ6nEjzQo17Shs4NWspdcoZojUhzEWnwC4KD/HJSH0DnnHtG
	VEvxiMMn0HWP91iM6I68M0Apcr6C82BrKNEyNYCOFbR5qDnBH0q2pdLQW+jLqA==
X-Gm-Gg: AR+sD10pkTC4scXJDBcfAL283OeWlO+OWkDeLohMfY9/jPtq/iwTxWdH/eV+YqP7egq
	53DE3+5QKAearsd8y3Yek9WVqkRyWX03mCC7XKVWTuEJrcPZcmeW3ZcH69UMaUQ288o3MT+/zE1
	3B7lYPWAfuPrBgzWISsnH36EH0RSxXrVQpyOX9D3rAy9u5elfHZx8xy2i0wd5FxETl2VSnBTu3B
	pAfPliUQAAafpTMxTbF49yCmqbb2A4PTbjTmKXPdXP7APwbKXAi8zWCMVZ0dKTiSvaWDfktH5j4
	L2W00X5wMSS58wGYsiRLYoYQ1twpnqNuwBDPvpHH7rDZbgpKaPo2Po8bPuZgXNWcuBdeSoVE8qn
	nWXJY/kcis5rg+0NmRHv0CCuMo+L8EmGKU8BUiAy415pNqhHJ/tuM1z4MsP5e9tkrG6MvXnZcfI
	gpPaYZSx3pFfJe1M0RM9lE
X-Received: by 2002:a05:6a21:2d43:b0:3c1:b9c:4890 with SMTP id adf61e73a8af0-3c67dd55224mr114841637.22.1784930232836;
        Fri, 24 Jul 2026 14:57:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.226.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc57ae17sm2475114eec.22.2026.07.24.14.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:57:12 -0700 (PDT)
Message-ID: <6a63dfb8.824e11a6.2fe22.c12e@mx.google.com>
Date: Fri, 24 Jul 2026 14:57:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1980412743627722570=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: ISO: fix HUP on socket release/shutdown + UAF/locking fixes
In-Reply-To: <0a86ca1839556192d402317eba371d6cba3660cc.1784923689.git.pav@iki.fi>
References: <0a86ca1839556192d402317eba371d6cba3660cc.1784923689.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1980412743627722570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1134197

---Test result---

Test Summary:
CheckPatch                    FAIL      6.73 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      4.45 seconds
SubjectPrefix                 PASS      1.68 seconds
BuildKernel                   PASS      27.02 seconds
CheckAllWarning               PASS      29.21 seconds
CheckSparse                   PASS      28.50 seconds
BuildKernel32                 PASS      25.88 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      494.62 seconds
TestRunner_l2cap-tester       PASS      60.21 seconds
TestRunner_iso-tester         PASS      75.92 seconds
TestRunner_bnep-tester        PASS      19.09 seconds
TestRunner_mgmt-tester        FAIL      215.54 seconds
TestRunner_rfcomm-tester      PASS      25.49 seconds
TestRunner_sco-tester         PASS      31.21 seconds
TestRunner_ioctl-tester       PASS      26.29 seconds
TestRunner_mesh-tester        FAIL      25.85 seconds
TestRunner_smp-tester         PASS      23.26 seconds
TestRunner_userchan-tester    PASS      20.08 seconds
TestRunner_6lowpan-tester     PASS      23.29 seconds
IncrementalBuild              PASS      63.55 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[01/11] Bluetooth: ISO: fix CONNECTED -> CLOSED transition on shutdown/release
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#90: 
Commit e824c0bbe0ec ("Bluetooth: ISO: clear iso_data always when detaching conn from hcon")

total: 0 errors, 1 warnings, 0 checks, 61 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14709653.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[01/11] Bluetooth: ISO: fix CONNECTED -> CLOSED transition on shutdown/release

3: B1 Line exceeds max length (91>80): "Commit e824c0bbe0ec ("Bluetooth: ISO: clear iso_data always when detaching conn from hcon")"
23: B2 Line has trailing whitespace: "    "
[11/11] Bluetooth: ISO: fix race of kfree vs kref_get_unless_zero

6: B3 Line contains hard tab characters (\t): "    [Task hdev->workqueue]                 	[Task 2]"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.242 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.461 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds


https://github.com/bluez/bluetooth-next/pull/491

---
Regards,
Linux Bluetooth


--===============1980412743627722570==--
