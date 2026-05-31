Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B11B33E346
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780248210; cv=none; b=FXGrSkQ59R4abIzOx82Hg5rvEErZZ7QZkBqindyNMG5zkfingbIH7NlnrEp7crRZD1sM3W4C/lk4S5U0hvswaCZdqerYxAE6Gd3tItaZdiXMFQaycbaCKuhmNUtip7rboSG3qPpsLYsAc5uPwpen9CnDYeH4nRdRuRDpPuFudXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780248210; c=relaxed/simple;
	bh=ed8cGAUJXMrDa/zB4xiSh2e20nmAe/Bp9C4Zt8RrF5A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OGzFaVQn7cke4Fu8C/UWtJT/sRz3ZzUl8THHQGkYoyEpRx80U6GB4/1opyEBUIerGF2KGIFVZ9SWVFpRCXklhBU2XhGjyB5LvTBp/ht6li7C17qH8FAr6HbgrVYgoErNAXx1sePW2kyP77rwuKGcem2QA1/A0FTkaKKiDj3TJVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1bKNTsV; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1bKNTsV"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304545f5206so12981127eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780248208; x=1780853008; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NnwOZ0b2UX+36BtPrHlQWBUcX+WRDVlAYXTed57P+7w=;
        b=Q1bKNTsVrsWLhxX/WmBzTJ17neEXaJzHr3B7y5LCcD25gnduVpcXag757gEcK51dpb
         w++511CnunRw4a77fpgG7OKhzdylfaqHeOo94lhoYUeANPKA8glNHJ2bT9BQr713463n
         Y8Lu+0HqCceIbKa17ZFbGX2h/mAkhViroy3O+rB+7n4/g9YAGZwuGf6alD2ageJ6b94V
         FJkc2qXe68/CvBb4x9l9J6RtpbHuugoSbgspvtVAS8B+rGlkXa1dRKnv2X+R3cTkl0X5
         BV2KO+QxZkjNyhJVzLGLm9W2RM0/YEQfZZDLMwoqDK4sVvLaA8j/yJ+PKcCfK+2s/+pP
         zgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780248208; x=1780853008;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnwOZ0b2UX+36BtPrHlQWBUcX+WRDVlAYXTed57P+7w=;
        b=r7Y2QX8dE5T5cPQTt+1isPOUsOATwVsIzL59FtALTBb1ekPxCqwJoE1SUlVHRVd4Y7
         0+DPINkGfBYAxoAO3JzyyQJJDGV3V422dIR4wnOjUpBmtIk0CWggcGTDfJe800AqRVyW
         A3O9Ma9ci9PVWszhMZcQQjn9o4CNb+0VscNG2v+WfkdpdXU4NJ1Evrjw/xOSWvfDZAbq
         c/TOZYccGcRbd6kFzxeBGtMixl/3SbF2prJb85qToXkbaOzW1/1Sq0GGTfFy0yGrEJnz
         aK3MN3Ou9Wnp5M3SQ+8fXFBuu+yHHTW0yFrlsl6uMMIJOKWuiZqjgYlCF4YtCB8nBDpa
         Ouqg==
X-Gm-Message-State: AOJu0YyXAjGyRtEeowaNh92iVkTAJU38W64NETD5EE4a/hzJN/FiTTa8
	cER/7Ora+JGpZFSkanJ8LmpKSSIqLmMjK9gAzFdhMeHQ8s5TexvlpkC7fc8Fxg==
X-Gm-Gg: Acq92OG0l5hI1oze4el/qoNgxHvFt3YCSKnNdMKGHIE50x/6R2aaoiLNHBA05nO2zCl
	VIJkGKIRNRsah5u1RqOo2H6a71PwEloqUXhCNvNgEiKES1zntaRrkhkax+uYBYX5Xq//9p5mTL2
	eCTFUB+wrc6yKfpx9ihClSn1WfX+s9pY5ec6BnViFfh20cfiA9qtQpdF3hmxbjAMqDCa88oXUnE
	ZTxLYDBOjADLbserj6+LsOxJg1FPOCpwdWv2nTwDNnfV1aT2dPMUccb9onNlNgu5VhWpSzt6+Km
	rmPTVsVf5DhlwC8e5oaeqezGG7NDfXVAlpiQMShy1R4c0eVUD0zVF6wHa4TMbP9xIMzYJ2qfZ3a
	2PaSnQua6PHoxcIN+c7/wEPoxcUS2R/aWrQ4WHqyl2I93QLLwsNEbPBrO941laEt6uVoT0+0b44
	qYy9XyNOoF6UwSItoIgpB1WmXk3DGyBW0uf5CBWcQevss=
X-Received: by 2002:a05:7300:a887:b0:2d9:2b54:ea9c with SMTP id 5a478bee46e88-304fa5a76c7mr3068533eec.18.1780248208132;
        Sun, 31 May 2026 10:23:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.219.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed3358b1sm6523056eec.13.2026.05.31.10.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 10:23:27 -0700 (PDT)
Message-ID: <6a1c6e8f.d7da0740.122411.1a82@mx.google.com>
Date: Sun, 31 May 2026 10:23:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0434523206949411642=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kbreddy.rpbc@gmail.com
Subject: RE: [v2] Bluetooth: fix memory leak in error path of hci_alloc_dev()
In-Reply-To: <20260531163032.102728-1-kbreddy.rpbc@gmail.com>
References: <20260531163032.102728-1-kbreddy.rpbc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0434523206949411642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1103634

---Test result---

Test Summary:
CheckPatch                    FAIL      0.60 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.95 seconds
CheckAllWarning               PASS      27.43 seconds
CheckSparse                   PASS      26.70 seconds
BuildKernel32                 PASS      24.35 seconds
TestRunnerSetup               PASS      520.47 seconds
TestRunner_l2cap-tester       PASS      57.78 seconds
TestRunner_iso-tester         PASS      74.71 seconds
TestRunner_bnep-tester        PASS      19.35 seconds
TestRunner_mgmt-tester        FAIL      210.09 seconds
TestRunner_rfcomm-tester      PASS      25.18 seconds
TestRunner_sco-tester         PASS      32.15 seconds
TestRunner_ioctl-tester       PASS      26.43 seconds
TestRunner_mesh-tester        FAIL      25.90 seconds
TestRunner_smp-tester         PASS      23.34 seconds
TestRunner_userchan-tester    PASS      20.13 seconds
TestRunner_6lowpan-tester     PASS      22.82 seconds
IncrementalBuild              PASS      23.50 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: fix memory leak in error path of hci_alloc_dev()
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#116: 
Reported-by: syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com
Tested-by: syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com

CHECK: Unbalanced braces around else statement
#132: FILE: net/bluetooth/hci_sysfs.c:88:
+	else {

WARNING: The commit message has 'syzkaller', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 2 warnings, 1 checks, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14603853.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.236 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.331 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds


https://github.com/bluez/bluetooth-next/pull/260

---
Regards,
Linux Bluetooth


--===============0434523206949411642==--
