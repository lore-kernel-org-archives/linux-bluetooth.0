Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD5F234994
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775586643; cv=none; b=JJtingDld0z43oC7GGHLkV2JOQZXqDA0xne+7NSEZV66CullbK6ikYJ/06i56GXAqktAJTPPRHqHaqaOh71OMsyzkt4ugkVhXBL09DKXHAdDN++3PyotY7KbqWcMr+IpLxN7bbPzZ+Yzm65Sg5LhQTo9mhyat2lTEcGHV/5Zas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775586643; c=relaxed/simple;
	bh=MuDevsXE8PQpWcHIXyQNUEtFv57XewlizUamhuTpcbY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m7NWl/q+pgVP5M7e3EUIqUby4Q3mtzrwAXXfrTIQiOGXvCcKq48YuXoAV+/QyfYs/h2lB84RoW9ia4MKv4nYWBRDtulCiZ+1xlIziV24RKAX3eb+/qnrE4oinbw+e0kux+EZhSHDHD39J4qSzF+XI91f2iUOC3l2S6a+MfvJBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDq5nShn; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDq5nShn"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89fc349b5ceso86863326d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 11:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775586640; x=1776191440; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yiJ8Zdc3Lb7NmbC/zb4qDmHZ2/areDrPh13DylK6JZQ=;
        b=JDq5nShnNBpw/PUGBtv04+z00lzh1MFVOCpr8PHauQxIdu9pCEyYJAOPIM+XenOIjr
         Btuy069kikAtWmNNitPk6oW+njBN/fo8aRIwL+I7bDtadryHy7+vi8s1TLwtv9/F3HW2
         mBMplGfHxr+dhMGJS+UupntysKcXtagAPvFUK2CQPkkYEB5rZIza4UuZcp2dUS1SqG98
         ti2pFpdtu2JdMUmGk0N7srDxUK/2LYW5WH9yKo+GhdqrD0CEzJ7baLsnRAY+OzvGMZh+
         JvVIg57YeimXEy6ayVIYShm0zpxGnH3cGcL4aSKT6m5+SSX9agIJjnecySBvCJVt+PUV
         hMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775586640; x=1776191440;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiJ8Zdc3Lb7NmbC/zb4qDmHZ2/areDrPh13DylK6JZQ=;
        b=hT9sjHSbT0HaE9l5jiD5n/U/q15Ah0xSvLgHilAzetaz2Sjw/K+ZbNnBxIbvlRc+5z
         0TgyYM/aBHsm2HRhdYV8NdT/+/qqHoeZvc03p8reYXagvqzUCs5xHtXhzusz4CU07FaG
         C13JItHBUAexNQCLvcDswRYXikuHyjNPm+T7ait2mFXgQ6d3DOVYsVAp3Xv5o9huGHmt
         i/nPIY0ydkantPkclsNUagI/buxd+a1FtT+4OfHv1bWvsrg404XWPbvvrPX4VJwmfvlA
         YHn1odN1hKIENxw7d+nsm7pWa/WOu3IwbQt4NFheJULBP3Zz4Rj6+vJRZWc/mQJ9TcJy
         HJJA==
X-Gm-Message-State: AOJu0YyIzTQ+Ku/BiXYxM/ufM3zchT2k1fdxMEwPWGuLitgIN8AuVMr7
	xozhsvjQ4tXBk+MFiTozQZCBEV4TdUvzAqjttuiV9zOI7FTOTXpO1dMjePB1aw==
X-Gm-Gg: AeBDieuw6bYTNfkV0yoCq5EFv/9ERSxJzN4pge0lGSrHKrvEx1M8omAQmHiAVe5kq38
	TNSQfS2teNa/RfIUQzEVH1SMFlNRb5W4e29XT3vRZsE/0qzDurkhhdZz285MQXF2Ux8xPihGsOa
	ngowxyyYEPc14HLTJ8TGQ0qKjknl4fm7nUIrrQRZCxDQEPDtC1br1hDvlOyM2pzmoPUXpjv2BSz
	7t426DTFYd7T9LF1ECP9NQVprE+ftEbiHkz+niSjPZijFqPxTb8mvw1cC6zIxx9acyMuWHe/etT
	L4lCozOeFXcZepyDGgVOgG6pe9rATenDI9OK9U2iKnEeruVDcXfxe0pyyJdDPDvBgql1/AAW20a
	5nUoOK3p+oVm25MbUJLVq+qO/B/ldBBRNM2qGULggql4dFxkvP7efVbTtJ6zEMOD6M/koFzDsSX
	EcFXXCfjFwoTXSXoi499j5fY4hOpU=
X-Received: by 2002:a05:6214:1bce:b0:89c:dbeb:3f77 with SMTP id 6a1803df08f44-8a7025b2c4amr310804586d6.1.1775586640152;
        Tue, 07 Apr 2026 11:30:40 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.135.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5977e00b4sm151451826d6.47.2026.04.07.11.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:30:39 -0700 (PDT)
Message-ID: <69d54d4f.0c0a0220.298925.a884@mx.google.com>
Date: Tue, 07 Apr 2026 11:30:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6135792749359835079=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, fnkl.kernel@gmail.com
Subject: RE: [v2] Bluetooth: Add Broadcom channel priority commands
In-Reply-To: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
References: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6135792749359835079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078304

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.04 seconds
CheckAllWarning               PASS      28.67 seconds
CheckSparse                   PASS      27.62 seconds
BuildKernel32                 PASS      25.09 seconds
TestRunnerSetup               PASS      562.71 seconds
TestRunner_l2cap-tester       PASS      27.43 seconds
TestRunner_iso-tester         PASS      41.38 seconds
TestRunner_bnep-tester        PASS      6.37 seconds
TestRunner_mgmt-tester        FAIL      112.43 seconds
TestRunner_rfcomm-tester      PASS      9.22 seconds
TestRunner_sco-tester         FAIL      14.33 seconds
TestRunner_ioctl-tester       PASS      10.04 seconds
TestRunner_mesh-tester        FAIL      15.67 seconds
TestRunner_smp-tester         PASS      10.53 seconds
TestRunner_userchan-tester    PASS      6.76 seconds
IncrementalBuild              PENDING   0.88 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.102 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.188 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6135792749359835079==--
