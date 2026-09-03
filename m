Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA044DF4C7
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448956; cv=none; b=Udbe6LtU18q8RnRFQi03d2qjpGNai847J61I/rkSz867KXmaOYpQzc4ZC5MfCqJhEF3ul0ZBxGFxlx1ejsuK0Tbtbq9QmsUq3jvsE31bO4ELEjwQl8avm96kuh2nZJsHZFPEm7trUNBPNNP/IZRNqeIAFN4o491tmZgQyDGhFlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448956; c=relaxed/simple;
	bh=jJiECTwdJdy5B3aZcyXUAN+ecGbThvga0pi8kltE0Xg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fNDGOtekagXfpO7XdyuoG6eM2Dk7iaCx3XZ1PlbtfEEGK9Z6ors66dWeH0zRMLb2olE/sYYNlBqNFdE67NKOKqsPBeCxLQ8dG3dRf1Wu14izWNos4Yo2n0y1Z5B/pLf6g/Emuipfw3qxgn10USU+vb4tVlYcIKl6UXHoSPJV0Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kihjAKDw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kihjAKDw"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-52fa9c055b5so16531031cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 08:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788448954; x=1789053754; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r0YfNzlu4gy475kVJSqdrjHmghdWcDN+m8406WrCjlE=;
        b=kihjAKDwVImmIC2+KEo58uBih7UkN9UhXlwTnoT0vMwKSI/TeG6AA9GNrGp8EWS8kH
         PysF4WY0vwIFrDhk7nNEGXOKFOJFqUd0YmAXuoz+ulWrcpeFbf1G+K69iQa2oyjKYwk+
         u4tvnMvYFz96n041GZMW1v9zAzv7Ix8T3275quIlUJiHiFuWAa5Yl3cqh1pA0Bcz69Jy
         xf8MMQIt9BX+53RS5+I3hm8bxEm0z83DYhM83PPhz74Nytpp2IZ9iPwImO9TLKs62Qy0
         cqKLuWct0S3z/yX2rJpUjsSJyy+dVb2Q18BU/NYvKlK7Kxc8NSSSiC89jjOervECPgXb
         z53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448954; x=1789053754;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r0YfNzlu4gy475kVJSqdrjHmghdWcDN+m8406WrCjlE=;
        b=SNVzqE+Izsbv4qD5u+xmiFt+YJkwzlIX7paBJKFR9TznIAwDksow6JtCh5LogAIS8A
         8VQV+XULAHi2O2KIjwHgDW9rzrqBfu2ZMWf6mu9aT9Me3+o5T8j2mZ3l10gSAZOndqe/
         ilGpFYVfC/4lPDp4cRN4ZrNC07TLHMcIDJfG7BN5CdXefKf7eWRsjEV32GTUChqUebTE
         Mi6oZxZutsNjn5wYghHfYZcYT0KS7I1w98SFYNCaXdIlYg9OT3RTgb3TsZ7WuzMgIeOl
         sA7pydpD/WUxL+X/rD1i+j/9L5TFEE3aVwprVfm147lkgUwsJPX6otXRILd7fGJ1hs2Y
         owGg==
X-Gm-Message-State: AFuF++nJ+REPXovIZilnYCEaMRdb2BEKbATh+qXAt/rAtXNxLz2UPABY
	rKVWA7JBgA36nyHgLkufSX6c4tIp4wALfnvciureo88+z8qIh2ui2cOm8VK8Dw==
X-Gm-Gg: AYBFou0rLu0WAvB72l7gPEa2SCM+wgNbUUtwCp3NNOkNWss7CQBZh0vz0iylLIIub6l
	qSZ2Q3L3vbgeGFCo+KhFnGbDbFNERxs+uP5MwC9enZB49ATsxsskhoAL2Yje4QaMj5x+kZ2bP0m
	QuU3u/e9WHd2M/ld2Xbln1FpkXL8E8CNYgNjAlPiuMV0eo7LSMPWDxDcEi7X9gsWEgWodP7zRJF
	F7hRBySgl11TfF8uWGhEbt9ew+6NqCiwzGNoTt5pkcbpKUZw+rhT2foOQa82Bp5yxEDUXmKp1w9
	MorWekeb6JCwGA3BFmMAV1rrc009wb10Om/XWWWEfctD2ZpFFNWr8E+sU/JISnjtX36FcuBTJit
	MzA5wPCJ21xIl2ANkkt9jXoSCOCO3q/V3glzFR1TOLHV7PLtUx3PixJZnvI9LuDW6o9V1cfcdpT
	bWI5CzB/dDH4V9IDAVmvRpzo0CIR9/i4KwG8QcBkVaHnLP5k1OiSA=
X-Received: by 2002:a05:622a:1b8f:b0:530:2ded:eb32 with SMTP id d75a77b69052e-53042f6dbe6mr67628371cf.2.1788448953570;
        Thu, 03 Sep 2026 08:22:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.206.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53033252530sm44403651cf.28.2026.09.03.08.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:22:31 -0700 (PDT)
Message-ID: <6a9990b7.a80a6acc.15421f.45e1@mx.google.com>
Date: Thu, 03 Sep 2026 08:22:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6478200425685650129=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zihanx@nebusec.ai
Subject: RE: Bluetooth: Fix parent socket UAF in accept queues
In-Reply-To: <34824eaea68a895a3fe9ed5337248eca1d81f74f.1788259244.git.zihanx@nebusec.ai>
References: <34824eaea68a895a3fe9ed5337248eca1d81f74f.1788259244.git.zihanx@nebusec.ai>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6478200425685650129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157009

---Test result---

Test Summary:
CheckPatch                    FAIL      1.38 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.76 seconds
CheckAllWarning               PASS      30.27 seconds
CheckSparse                   PASS      28.94 seconds
BuildKernel32                 PASS      26.69 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      497.30 seconds
TestRunner_l2cap-tester       PASS      63.80 seconds
TestRunner_iso-tester         PASS      103.21 seconds
TestRunner_bnep-tester        PASS      19.02 seconds
TestRunner_mgmt-tester        FAIL      212.07 seconds
TestRunner_rfcomm-tester      PASS      24.99 seconds
TestRunner_sco-tester         PASS      31.30 seconds
TestRunner_ioctl-tester       PASS      25.62 seconds
TestRunner_mesh-tester        FAIL      25.15 seconds
TestRunner_smp-tester         PASS      23.13 seconds
TestRunner_userchan-tester    PASS      22.76 seconds
TestRunner_6lowpan-tester     PASS      22.43 seconds
IncrementalBuild              PASS      25.42 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/1] Bluetooth: Fix parent socket UAF in accept queues
WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#124: 
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4

total: 0 errors, 1 warnings, 0 checks, 47 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14787479.patch has style problems, please review.

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
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.233 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.148 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/694

---
Regards,
Linux Bluetooth


--===============6478200425685650129==--
