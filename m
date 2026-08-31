Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B386C3FC5BD
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180367; cv=none; b=Mr0VPUaUMQKk1WTD9SL5L9CEM92Ps/Dp1Hd0vfURItbnBKNhgwqX9ZblxKGUAeeDRQxUzVbn6p32veyeTJQHkjuuVTBNxA70B2ru36rqkunmc+s3c19CXzAuTlDSDgDTjdnQPzX0+FRNdbN6gNwJXJPRYUnainHyvFZMxP4Ni8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180367; c=relaxed/simple;
	bh=V9pUGvUlvRdHzHVLYyBuV5o6dc3D6+APRA+pHYhhjvk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N2mznw19H8/KBPn/J72Wahrp9JbNsMXtsFBxn48hBx4F1DTFcUWV032I7gKGoki2FgwQy4yepypaOrLEStRmGczGEPjwZNMbOjmgHU9YRoG4CEK5zVn0NQnLbq6nI3aWgLDYCKYHfBybJLR1DBoKwymcaKQGFLmntsXWbnBOL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJZDeoni; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJZDeoni"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so2854228a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788180363; x=1788785163; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FRjIb76ktMJhQY+DdI/i4izl1MGacT3jgJk3tm8fQuY=;
        b=MJZDeoni46Cuj4zHiz6QycuAihK45A1HQvyKO41T3Mqlo6A/MGjkgBfeyo+8+pb6MO
         yZsulxhfPsHS3G79RKVSicW4w6C1wIxFVAV90YzeKhicC4IAhEW12Fia0zN1RvxKsGWV
         aL1ns2Ou7Ww9RyI53WtDbFg+qYir113H+P+v4YXzqVgiJzX99+VcTY8lfpkF4wZ0MGbJ
         ejxwtseGJPzpjhKZjpwmxBAefUSodaFw3jUi14MTI8KyJtYZICugPc2PA63MPNBisay6
         Sym7c14iaoKsBeu9WyZ4KT2Xdi0ediPR9vQbYUjNwMavEwq+1X7c5codRe4BptqUDYhO
         Y9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788180363; x=1788785163;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FRjIb76ktMJhQY+DdI/i4izl1MGacT3jgJk3tm8fQuY=;
        b=DhD83WbACYcrx0wAPLkFsooPGTMcDmrvsagyKCEodHEofKtqodP8lir3XKnRLDr0k6
         WdahBdDio070h/Jv8Db2o7Hu6K6e5abtbDzppBDNw0iJku4Qa4TzLo76v+Xlne7vQMFg
         ovhfGLSyKe17QOEkfKDSGAvxEHEJJMy488XE6qDTlxXm8FtHtH7aS+RJpOL/8/53CpaQ
         4vU7kowMzFRgb4XNM/GmWYWHQQ6HzvxITNh3oOoTd6HaUVm/6KOf92vaRvTodoV/+ePZ
         ghfS8HVc7PE1h9mA/joSFCVd0VIC03kZ77ACdtgdNuZGFo4E5u7ZwKu3ktpLC3Y28ulR
         Lm7g==
X-Gm-Message-State: AFuF++m54VeuSiiu7SdafFM0dAghZIFmiFZHVrQgCZm21ElyfDGB9rsO
	iId7Tpl2WgIi7tLHVcynwvjC2V5+tP43887Zq641JDzWJtf5J0uPOvmsrTZT/niU
X-Gm-Gg: AYBFou17pGpxxlQVVHZEQs+j7Lxp5ksABxtaOpb31O2kOSrPG7U7WHmpYNsqeuqdaeG
	i0LvrjkOO8/6vZW/tqzBcwxSUm0Qi38gXcXX8saCFj3n4ux97lVSYd7uPCO1KCKA3R5A7FXGUOl
	vee3qR4kqZiHNuUYH8fBvTSC1IIAq/D5g4nUjgP4eD5Y+0CThmcwNZVjy+4SYg3Ru8kV+yR2iy5
	jCkD7yYkzez0bgZkazA1WWsdy62rBOmu1agxtMK/stL3Qsu049wVcbWetmLX+5LkGPxB3cSbRGQ
	Z2JoaYHHIRZWlcxbmDWBRL16xgeTDPOPpv8O8h6zXQ6j4kolW2c1WrwCkWSztWupwigAbW+CQdR
	E2TeWHdCxWAvOGyqhfFsAMBTdrgK0UP48AML564suT1tFF4V13WgMR5Fl3W7mwdS9TXhUyUecIU
	0f+IHp5ZC+xHoDre8R5arsXCT+OqFVG9+QsCbr9qQ+oItYAbxs5JJfCC+gQvlgKn6hU4s=
X-Received: by 2002:a17:90b:2884:b0:398:c3c9:d0ae with SMTP id 98e67ed59e1d1-398c3c9d103mr16150495a91.0.1788180361088;
        Mon, 31 Aug 2026 05:46:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.123.131])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0bf8a13sm42240319c88.0.2026.08.31.05.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:46:00 -0700 (PDT)
Message-ID: <6a957788.492e23e4.3211ab.2613@mx.google.com>
Date: Mon, 31 Aug 2026 05:46:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2879513412329805049=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hnkz.64@gmail.com
Subject: RE: [v2] Bluetooth: hci_core: Fix IRK lookup lifetime races
In-Reply-To: <20260831115344.2393116-1-hnkz.64@gmail.com>
References: <20260831115344.2393116-1-hnkz.64@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2879513412329805049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1154463

---Test result---

Test Summary:
CheckPatch                    PASS      3.16 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      29.10 seconds
CheckAllWarning               PASS      31.35 seconds
CheckSparse                   PASS      29.14 seconds
BuildKernel32                 PASS      28.58 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      520.73 seconds
TestRunner_l2cap-tester       PASS      64.88 seconds
TestRunner_iso-tester         PASS      107.44 seconds
TestRunner_bnep-tester        PASS      19.44 seconds
TestRunner_mgmt-tester        FAIL      229.89 seconds
TestRunner_rfcomm-tester      PASS      26.41 seconds
TestRunner_sco-tester         PASS      32.59 seconds
TestRunner_ioctl-tester       PASS      27.71 seconds
TestRunner_mesh-tester        FAIL      27.18 seconds
TestRunner_smp-tester         PASS      25.17 seconds
TestRunner_userchan-tester    PASS      21.31 seconds
TestRunner_6lowpan-tester     PASS      24.87 seconds
IncrementalBuild              PASS      28.46 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 494 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.258 seconds
LL Privacy - Unpair 1                                Timed out    1.858 seconds
LL Privacy - Unpair 2 (Remove from AL)               Timed out    5.003 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.268 seconds
Mesh - Send cancel - 2                               Timed out    1.976 seconds


https://github.com/bluez/bluetooth-next/pull/674

---
Regards,
Linux Bluetooth


--===============2879513412329805049==--
