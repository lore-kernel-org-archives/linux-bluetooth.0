Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0074DC527
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343272; cv=none; b=NxjUgK86pgpfL5x27qA9Et3oBehUxBHzZQWaIXLtAP3ZtG6XxaliEv7iJJvCX91tJLJJ93+N14Vic3w1tS3HIOUlAAXmv01CRJpa2o0NftHiKnobE8KFTtur+PX5L1QuOS8xZ6rMEPydbH5rddbzdrq185ubf82HGCtZigwHwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343272; c=relaxed/simple;
	bh=PKqPZhd+NDOr+dGwNOl0sRXT0lT+PDCZZZNHOs1wyzs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jiOM1DnglYexMVAQB3JWCWYMb5LsqOld5BdMiZuEhiqppsqyyzXaLcWPUAghLfCFR16lGx1qcpHXXHK3pJgxxhh0DFTCdlyuf/JVP9BoIfsukD38yuU8rhQFho5GcuVXnbqSFz+2Y3Fy+ElGnageibDiaKQs6WiOBqtDOLS4d7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvIaf/J0; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvIaf/J0"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9034b6b7674so8160826d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785343270; x=1785948070; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=08nHbGNlNUGnbLC7OfgJKqiQW1LxaOsvZh+AAU+1a7o=;
        b=cvIaf/J0kI79ewJggna/27I/StkzFJdnztw/morWj8CGVSoz3JD3XSZOG/OkRsH43k
         PnUbYFz1debNS8nr3547RiPLcKeQc4waclcegX3dJlDw3WCi4/DvAjalJbjGcLaWbWwf
         QwKg8Dij+Fo9qPURnLxmR0I5Pb5uXyoRdG+vDbbmPM5ZGCxic9E7tMamxNFFhQ8biFUO
         L9TUv00NtdTSCNlUb+xnLcf01dDqABPlIQZpxp6Pm7cH5NITz7jd4YUqmvA9ylV1xlGN
         8IMjr4rmPHRyG5PGVrQgjgf7OV1OBWIGqsrbY2V5ud35Bm9jjQk+C/8qB4BQ0E+/sIvt
         Yn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785343270; x=1785948070;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=08nHbGNlNUGnbLC7OfgJKqiQW1LxaOsvZh+AAU+1a7o=;
        b=kzP6gsuCG/ZhC3OViqZkFhqgbYXVrcYvqwzst0B6wAtJ7fplx+PVvdmz7BPMDZveuv
         QTtkWnLImiCVkBEVe+zBWUp7pL6AAgJ20/p35zHxMYiCyrxwzZHdRtRAIVPsZo/e7vnK
         6Nx4G5EHI+0Ry7fFaNaX+JOggdJpyqXM9hah9UdGRvMoKrUfT2NmTsV0MT3zD610yW/w
         SUHu7mbN20rIAqkkoXtYPgNup4JOzV5mLx9tcnYf7/Va1V2O6DecZ4pcXqT44D8U38B1
         IMJIoWf8gEzyImLmi3yuD3OV0lPm2bvTQkOvz307DITj2yx3BBw8u3AsGEDXCwQNsHVt
         lSIw==
X-Gm-Message-State: AOJu0YxTlYWl+k5wtLcQBo8Yc+u2dwSAT2CZdtfJXuTPX2x9y/frz5w9
	ZYCBJpVklYF03MNhKCzhEXHLc/wV9yv7w0UxbxD+hFf1lfZXDhPyCG4KeTAt7Q==
X-Gm-Gg: AR+sD13tBj8QVIaNfyixkSii/iIF1RdaHs7aV5LJoE1sEthk0cV+tiX2YQdpay81StE
	xz7dtFCTjYuN426Ccp7AebaC4oGrNtASm16ffnX0YebNSZVNgn1qE/F26RjRkVu2eZJKrSZMVav
	Wfb1c4iFEk6IYUoTwqgquR6KbikFzvLjZNgDdd09+AjooZy9iU7DrNEhCErwymx5Z5zrn8fn5jt
	z8ekDPjjTh/a9E5NvqWi4L+JeQ2XeM0EhAkCL9geo+I1rluMZl01o8sj51tURAwYwiSPxc6AG5/
	6KCBD1ebTvP//X9X64A5quaeX23WYd/tKLQYIU9kjCrCmoOAN573p0apGvRHSzAG3mY+yS8eyej
	mrO2eU21j359IyiIBSrx7uPCsWvYjI3QQWDkVx/Lm1YYmU65TO/wsxK9Xazwk7FFcxQP+39fn0S
	/OkBwCXXtWyzLm+CzwL8pHQucX5up2QU5ke9q2F2M+WMym7G/2+Tr8TgWsBL/B2+A=
X-Received: by 2002:a05:6214:3f8c:b0:8df:10fd:93f with SMTP id 6a1803df08f44-90816fa8defmr85996236d6.12.1785343269662;
        Wed, 29 Jul 2026 09:41:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.15.9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dc915f8sm28049726d6.22.2026.07.29.09.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:41:09 -0700 (PDT)
Message-ID: <6a6a2d25.03d33f19.143c4d.d3a8@mx.google.com>
Date: Wed, 29 Jul 2026 09:41:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2555699685465358702=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/3] Bluetooth: Add support for Shorter Connection Interval (SCI) feature
In-Reply-To: <20260729153412.2564039-1-luiz.dentz@gmail.com>
References: <20260729153412.2564039-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2555699685465358702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1136773

---Test result---

Test Summary:
CheckPatch                    FAIL      4.39 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      1.01 seconds
SubjectPrefix                 PASS      0.39 seconds
BuildKernel                   PASS      24.77 seconds
CheckAllWarning               PASS      36.78 seconds
CheckSparse                   PASS      26.83 seconds
BuildKernel32                 PASS      24.74 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      459.04 seconds
TestRunner_l2cap-tester       PASS      60.02 seconds
TestRunner_iso-tester         PASS      79.65 seconds
TestRunner_bnep-tester        PASS      19.05 seconds
TestRunner_mgmt-tester        FAIL      213.56 seconds
TestRunner_rfcomm-tester      PASS      24.96 seconds
TestRunner_sco-tester         PASS      30.90 seconds
TestRunner_ioctl-tester       PASS      25.98 seconds
TestRunner_mesh-tester        FAIL      26.78 seconds
TestRunner_smp-tester         PASS      23.14 seconds
TestRunner_userchan-tester    PASS      20.00 seconds
TestRunner_6lowpan-tester     PASS      22.99 seconds
IncrementalBuild              PASS      56.69 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,3/3] Bluetooth: Add MGMT Load Connection Subrate command
WARNING: Prefer using '"%s...", __func__' to using 'load_conn_subrate', this function's name, in a string
#367: FILE: net/bluetooth/mgmt.c:8178:
+		bt_dev_err(hdev, "load_conn_subrate: too big param_count value %u",

WARNING: Prefer using '"%s...", __func__' to using 'load_conn_subrate', this function's name, in a string
#375: FILE: net/bluetooth/mgmt.c:8186:
+		bt_dev_err(hdev, "load_conn_subrate: expected %u bytes, got %u bytes",

total: 0 errors, 2 warnings, 0 checks, 339 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14718755.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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
Read Exp Feature - Success                           Failed       0.240 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.702 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/509

---
Regards,
Linux Bluetooth


--===============2555699685465358702==--
