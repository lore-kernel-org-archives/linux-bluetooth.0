Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589A386557
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598540; cv=none; b=qWkBbT5UOYbfoafvuzI+LO79RovhATYmTUF6yoVQrnajkBbLz6OEcf7u9wB/ugNS2+UusdXgmMiTEeP6kWYYYZhIs+GUkk3y7fDUvWJb33lzn3TLXU0C1aZyDxPE8Hpd7Ftiz9+x7S3JFmUSBQQyRlZYMIjzRbobCzBdxJv+oCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598540; c=relaxed/simple;
	bh=EF07r1vGDRJw1Fpm0/uMbxWyMynjQGxAVBqabxU78aw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k5VzCtP0igD2hjah+5XXsdSZdSYNRcmOq+kE0AzK7oc+F8+qRZdCbMEEnzWVzy/90zVafdLPDzjoFUm3Z36u2tEyRLY3ep4czSCm8ieQMG4P38YWesJiV62eN1YGFJURy+GJtKaaLbRKMYIiUyELKV9vDXegMRDJzHiHOKmZEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ppsuYFiy; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppsuYFiy"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137f27712fdso721958c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780598538; x=1781203338; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DhKs+WZZyvrBxNbGTNCB2o+cP0kvzxX7yKfV43/roGE=;
        b=ppsuYFiylOpJPnyvQvI1rGDL8m17fAFREwDrMSwRMWdVvBgh093VO45TXCOnxUoKGi
         NkpDfspaJnSYUyVLOlQatLyf6OGPSMYK/bOWLUy5Zc5Z9sXS0SZhyl722Xv274M7gtyI
         qesYLoyblF2Zp5vP6eo3ToUvlZr4/3VN7SJ9sNJaUdThuQU3JCHJbRPnW8Y+DpMRa/oi
         IRnVqeZc2vnlSdWs83ZAs4uw6HfKkscKshBVuoeiAI4YCwLYA0Qt7dkCvVeMKh4rvChT
         mskWmzAGTEWHGkbAID0m89/3GoDSQa9O+RYqo9tgrv4mp9u0Qv7TsroYmuw6CblH1WXw
         mVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780598538; x=1781203338;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhKs+WZZyvrBxNbGTNCB2o+cP0kvzxX7yKfV43/roGE=;
        b=cqpU1vDWko1Le1I0OGH97UpLijtGcc+W8+gnPnIP0hS+JId0kFvnUmUpC0M2NELdJ7
         RPLgRpFqXO+G+ALrX0+czuZ4DDTzba54ooYoSIxSc5wE5fu5XQ1hwl/WLKIgYiR7DZKl
         DBTPjb/oGii5NG9ruHhKEw3REln6nBRSrAIb0mcyIj4ucpWYZo1RBFmcy+/iQRXKOOIx
         iYdGkSrfdY9Wwb3VC2iMcEGIyh4Dx2x3qzcWD0T6Koh/WOl3kD/xnIlmPy84WYM28Uyc
         7VnryWkIqnaVTXaGVeenTA3NYh0HfyoDywEn9p8n7QvPfhm7J08KaT1cxWxv9yiDvzIK
         rYfA==
X-Gm-Message-State: AOJu0Yx4TM+ZCMgRrDaZb4zJ4Fm18ykb4KcM/zfovUwMwnUKnzuz7UOp
	/tN1Wmp5h7XH4KcD1nTeRF84gUJphdog64sZHz64CN3DN521d4TnsMIbZ7TNpA==
X-Gm-Gg: Acq92OHhIWsnlRl8cFvMxPaUl1OiDLz5O0erlP8d2qi99ZkRpGTkYzPU9fyQ/V4lolC
	K6knFh+jZ3Y6BfQciG5ovovH0AqAnC3W7AAh/xr993Th9UmRSnsFtSZWXLjskLdx2wmHdDC9/Jr
	Zi9r/4hRtR1vosO5RFVSBI+fGK9V0wwh+Qqn5phEy7ecIHJteR2cTEQmxOZ74MMaXECSOo+fOnR
	Y4LhUF6vWvqzlZuIoZ9CJ7t4xRM0F8vE8YXVEHxiGkY3g9PBQPr++LauYGFQDoCgE0U7XNjKic4
	wmiTXH2VDewY81t+rEltVnxmaQ+Es+9qbWSV4wF/nC8ZrJnSD5r6TMch7x4+24Z5bFrRU/OF8WW
	lLlNyKIgEmbfWt/L0N2592OoCBGaG0xG1T5bVAQWQbppLOPDjxLlbUuiNEokBnUEZUr3w51X9rj
	dHuN9fiuMVpLl4dUxMyWRRkS1lHO2ByPam0kI8Ew==
X-Received: by 2002:a05:7022:390:b0:137:6bdb:5842 with SMTP id a92af1059eb24-138065bad3dmr190241c88.0.1780598537986;
        Thu, 04 Jun 2026 11:42:17 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.61.37])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138063de4a5sm199801c88.13.2026.06.04.11.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:42:17 -0700 (PDT)
Message-ID: <6a21c709.a8e23d06.327054.aa15@mx.google.com>
Date: Thu, 04 Jun 2026 11:42:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8345007841048443580=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Tim.Bird@sony.com
Subject: RE: [v3] Bluetooth: Add SPDX id lines to some source files
In-Reply-To: <20260604170633.730139-1-tim.bird@sony.com>
References: <20260604170633.730139-1-tim.bird@sony.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8345007841048443580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1106120

---Test result---

Test Summary:
CheckPatch                    PASS      14.08 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      28.01 seconds
CheckAllWarning               PASS      30.79 seconds
CheckSparse                   PASS      28.62 seconds
BuildKernel32                 PASS      26.74 seconds
TestRunnerSetup               PASS      574.60 seconds
TestRunner_l2cap-tester       PASS      59.92 seconds
TestRunner_iso-tester         PASS      73.94 seconds
TestRunner_bnep-tester        PASS      20.27 seconds
TestRunner_mgmt-tester        FAIL      221.58 seconds
TestRunner_rfcomm-tester      PASS      25.87 seconds
TestRunner_sco-tester         PASS      33.28 seconds
TestRunner_ioctl-tester       PASS      26.45 seconds
TestRunner_mesh-tester        FAIL      25.84 seconds
TestRunner_smp-tester         PASS      23.53 seconds
TestRunner_userchan-tester    PASS      20.26 seconds
TestRunner_6lowpan-tester     PASS      23.11 seconds
IncrementalBuild              PASS      25.43 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.247 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.944 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds


https://github.com/bluez/bluetooth-next/pull/288

---
Regards,
Linux Bluetooth


--===============8345007841048443580==--
