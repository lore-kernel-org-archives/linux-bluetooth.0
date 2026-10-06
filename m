Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020BA3E0724
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275655; cv=none; b=TncNf2WlSs8kyi/id7M5ioeQ2Vxjjcq9hZTJe1c6ARoUglQ65svcCIol/oA1kDeDSLutAa/l2wPgrpxDSRhkwA78kriTY3H8Lpp/+okNcMKoK6H1lXc469ihcb6xUpccjJqoM9duzfUSWT0sVGbTNDEpDLHDeJZcbXejOEeRVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275655; c=relaxed/simple;
	bh=Fbr5v18ZOuF0y17DyYqnMNWNPdxjlEJ6Ch51dbKjeaw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MDCYdtX5Yu3EF6IUIGxPKkdSfzsSOFtkuh75itv9w2+G3eWFvyo4n4XnnlLLHI162WVN+AlQtVHg9ZTuHQqkSwdvRyZro5BYwcK06RKjjyyghBL0fhYNsIOAZ54vjqVDTfAMRYeqZbIdTsLVBJY1XK2lO4djJKp1bXIU3ai3wwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrIvy6OU; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrIvy6OU"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-31490970b97so466240eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791275653; x=1791880453; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZnK2n4L6q+Rna3nDlBLn8jZtOTn6o5keP9KZhenUyUE=;
        b=VrIvy6OUzrudOpLYVhtrDe2jd9BFJV9yLNgaV9oQd7JE93QAZfsBUa2seHQnuxM3ix
         FuvCLV9XE7lU6sipad3XCIV1jBV8SGpX/dYJ2oa8nlhjbBW2UtamVoEDn51waDC+PSPB
         o1QoaP54ywZxwLmGAq1Pw7+MPekY9aztwmt7H4TQfXp53pwUiPInu7vWY3lgs+kNLjpW
         JFmWHiAOSAGSTubHRpH3YxtraPVkFzAYgXar2Lc2zmUhCvemB74cX18jsSd8DAJ/p1Gl
         dq57F+VmuQ0dp/DFMipsst4Vklbo907Vny+qgLJwCWObsvzI7EkREzxrGmle4NR48NLd
         6Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791275653; x=1791880453;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZnK2n4L6q+Rna3nDlBLn8jZtOTn6o5keP9KZhenUyUE=;
        b=fBiPmob7SFo3xGJw0bnhr1eVMt16c3jM94xtPOQOssxItCwufmigysAA7v/GSjLkeR
         foFHfGwfVBMQd3vixYJgtpf8DXKNvL2EQXCmDKriR2xDvlplIocFVz/OkWgcrmPahKGO
         3ANhrkV/M+zuXLFIWHtrekGPaQD76xS3Hyg5vDQYqyNW2SMyJM87O31BPnAub5MJ/xiy
         4EqKThNU5u2x5M40PVkiJBFvR0+MvfkNhSF6nD5zOtiCYN3iK/nPejtNfrNBbITNYHZ3
         kERrfhPUK6gxNoQecWguyn/kNn8G9kIwmZDlhCFUe9pifI3mvuELYTws7Yg1NIoAMFsQ
         DvBg==
X-Gm-Message-State: AFq9FYIfy3S+MK0wWpIG/qqcX12TVuaUhUMb0b24+Jmw8F6ib7ib2N+J
	zmeRYHMHQxSLP6PBxRzs16oGuq/Ifre3Bp2nwzAApDOwgsP1XzxHMIoiiDsKw1hkKE4=
X-Gm-Gg: AYBFou0bPrF6gWkEO7GgIW+qYZ8F8JLgn0V+OCu5N1PkHxRordgEyVwaxyxPWfTkTNq
	FfchMiLpYRMGo04AVLecQgFWtsnjgS52HPkEKiJSShT7NwhCuOayfAf3+gvWs+XR9sUousQP9vu
	doTW6GGvF4sTEF2i0mNjoC3adcz+H3hkyKTQog4QKNgvbxyJYqM3N8seFzLDbqC030qb1Vr2H5L
	PhF5vsEn2/Glz01oboXiZRtnppvHPU4lf0hEOdHpx07hV1FLsG1N41jyu4x+UJ+mH+WHG19r3VH
	KqraSsLHg/olX4Cx9ZXO49gCvUWwA4JFbSgfCyYdiFrpC+ZdjxgncQrsflu+V1RMU2xcOAsmWqc
	QvILOJ5B0oivxRh3CAjf/kPY31njxvc80Tp0KBEJ1aDNCYsdDx5bATEdmhYx2AsNU3GpHxxnJDh
	lvGgND0rL5Ebsngfum+hx3DEdxvd+TMja16Hn/rp7VCVGeBw1VR1k240jhurHOhcb6NdnkOBFXW
	iierzkAnmH0RrM=
X-Received: by 2002:a05:7300:d405:b0:34c:b75a:ac14 with SMTP id 5a478bee46e88-3514e3aafd0mr752027eec.40.1791275652750;
        Tue, 06 Oct 2026 01:34:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.56.65])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469f7617sm6392592eec.9.2026.10.06.01.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 01:34:12 -0700 (PDT)
Message-ID: <6ac4b284.2c5b8305.142fc5.bce8@mx.google.com>
Date: Tue, 06 Oct 2026 01:34:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9104440902451899805=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: hci_core: Keep RCU protection through LTK filtering
In-Reply-To: <pm-bluetooth-objects-candidate-0123-v5-83023fa5b4741c350341@gmail.com>
References: <pm-bluetooth-objects-candidate-0123-v5-83023fa5b4741c350341@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9104440902451899805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1180109/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.55 seconds
VerifyFixes                   PASS      0.30 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      23.18 seconds
CheckAllWarning               PASS      24.83 seconds
CheckSparse                   PASS      26.94 seconds
BuildKernel32                 PASS      22.17 seconds
CheckKernelLLVM               PASS      25.81 seconds
TestRunnerSetup               PASS      573.55 seconds
TestRunner_l2cap-tester       PASS      13.28 seconds
TestRunner_iso-tester         PASS      9.32 seconds
TestRunner_bnep-tester        PASS      2.79 seconds
TestRunner_mgmt-tester        PASS      56.84 seconds
TestRunner_rfcomm-tester      PASS      4.06 seconds
TestRunner_sco-tester         PASS      5.03 seconds
TestRunner_ioctl-tester       PASS      4.18 seconds
TestRunner_mesh-tester        FAIL      7.66 seconds
TestRunner_smp-tester         PASS      3.99 seconds
TestRunner_userchan-tester    PASS      2.86 seconds
TestRunner_6lowpan-tester     PASS      3.99 seconds
IncrementalBuild              PASS      21.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_core: Keep RCU protection through LTK filtering
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#156: 
    kfence-#249: 0x00000000121f2ad9-0x000000005b5bfb3d, size=72, cache=kmalloc-96

total: 0 errors, 1 warnings, 0 checks, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14869374.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_core: Keep RCU protection through LTK filtering

42: B2 Line has trailing whitespace: "    "
55: B2 Line has trailing whitespace: "    "
56: B1 Line exceeds max length (81>80): "    kfence-#249: 0x00000000121f2ad9-0x000000005b5bfb3d, size=72, cache=kmalloc-96"
57: B2 Line has trailing whitespace: "    "
66: B2 Line has trailing whitespace: "    "
86: B2 Line has trailing whitespace: "    "
87: B1 Line exceeds max length (120>80): "    CPU: 1 UID: 0 PID: 495 Comm: python3 Tainted: G           O        7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy) "
87: B2 Line has trailing whitespace: "    CPU: 1 UID: 0 PID: 495 Comm: python3 Tainted: G           O        7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy) "
89: B1 Line exceeds max length (119>80): "    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014"
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.642 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/868

---
Regards,
Linux Bluetooth


--===============9104440902451899805==--
