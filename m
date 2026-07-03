Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26290331EDE
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060890; cv=none; b=ZHEu44L9Hfuv/OdqbDHMUmdbCwwgjnb43x9XCb7rBgLOYoPE6ZQab3YKqKw42PW1eBKpyOWjH4sU+3UJsC8ztdTTbo/E2DHmX8Lsz92PjfWSL3viH7m/GyqdY8VzAsiXWRGUAZRHOVtMuWQ0Hsu2wnrDCh66fz2PwnbyWI1mgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060890; c=relaxed/simple;
	bh=ONjK3FSevPkd75Dz2xBUMIV/SidRlFys9OLkiqUBU/Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UOPhnbsy+UlY9n94fJFje0zLd9BxNoKiIpGV1RzLFdXnaompvb5kF1OqbsZDJMQe1BQTtxB/SX3g20J7q30fLchgarblq4afR8hM40O/AhVOAkoyYNzk0jKZiRR7CEAuLMj9y6wUnfaX1ne/kbNqAkcY4qGBFJ96EPVjinruQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpZesRpO; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpZesRpO"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb545db3afso115114a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 23:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783060888; x=1783665688; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G62P+Qnz1ZPYxPUQERnKaiiFcUS69YkzDqdyJXzjVyQ=;
        b=hpZesRpOurNrH301T+xNuid0wlW3HCbKEfy9jM73OoUQRanYJ9X6h2Cq2gCOGSf1Jq
         r5GRXpBWSFhzTbQHu5PRS3wAfeolUQE1ELbt7ru5U9NCWQLVtp+t5wzjiKtRrvcWOopW
         GpvouqSnhca0zg0+3MuZLfsOX7DrelpKuoWBaIrJtNFsVnB4qRnkQbxmK5D6kq5bqTqR
         UywSVjnb/6bany6yFcxp2/m/+pwSK/LOST+ry546IPDjNXss/DPurLBCmtudlXZ1Jzm1
         qu4VWpRFafGnnyWB+nBnc1bkxkQdIAUSiBFLwo47sSzx8MQe/b3Bn0jCDacDBhNiwWPS
         JBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783060888; x=1783665688;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G62P+Qnz1ZPYxPUQERnKaiiFcUS69YkzDqdyJXzjVyQ=;
        b=Hv3TEsmr6Fna6O1h0lUWu5Uihs9hL/BIXATckdIiEG6iJxwg4xF0GwbhLbGPX4omze
         7EBPZQNT3C0bMOKHjL9OPEuyPSwWR8vNZ5km7TzVsfoNrSv5HJMK6pVaNvaf24LUjZbE
         QMvaxL5GR0pd+UwWefojYrDoHhifxuanq8UzS5NkO2D5lhoD9Y73j21ewpYBdjE4wXG4
         ll1hIXoebwyPDEhjuXKmZTi/G9pHLP0FbBNa/jjVVQo336x3kPN+INikY0wZmIZHEPib
         BvT1B9qHvayOqeqU+EHp4DG5dIxnR+5iN2zgQSQbHaoZNUG8xaV2CP9mKmqlnHtWPdTV
         Yb6Q==
X-Gm-Message-State: AOJu0YwzKepLlrSwHwrD7y9ZDHsZt1Q8u92/oFTJ3HE+ho/z4qjIqiPg
	ghN+CkheAbeol6UDQJHTdHqQHIQh6ZmrxPMVlJfo0zIeZjOkkQLusn3oaIps3Q==
X-Gm-Gg: AfdE7cnAl5jlorhifbLKTKYL3zb/LI2+5+uFpIrmq5UqLW+1TE9+r0VWjinbipcG+k1
	AHO17k7bm9PC9jANNQk1X8Dkef3zzA43LM4iXzcyQX5KSIBeSOJrhpvs76KQhQlyABuOGKSZkCl
	wharlytYoofa+v1RoTeigR8//IfRmOUsMLeYXvIdoEeghLZauiaCRGH6/9f8G0hwc2QNMs4ktYW
	K6eA7yHgMOXEdcBecEfIab5y7Opwe4IthKWvLoGJd8GF/wcWciLo2Pdw0fLiEtTx5CNLk70bDWR
	mCqA43wBcaD7YFdFREIREHHiVob/FVycBj4KWNuHNGMZOIOhgWQbGNvCtDVNvEheCBlkoCPURof
	XqNP6U9sEqxAH2RFx/0rqANagPMoEQd2JyWONDEEin0zdNuOcWauftAXv+Aze/uOmZx1eXGe/OY
	QlGgADo1AvBhe1MTs0
X-Received: by 2002:a05:6808:144f:b0:495:fa73:2e21 with SMTP id 5614622812f47-496369f3e8bmr5482376b6e.33.1783060887997;
        Thu, 02 Jul 2026 23:41:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.29.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-497d1853afbsm3310286b6e.8.2026.07.02.23.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 23:41:27 -0700 (PDT)
Message-ID: <6a475997.a96d76c3.24a25f.2382@mx.google.com>
Date: Thu, 02 Jul 2026 23:41:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2894827059730248981=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: MGMT: Fix ADD_EXT_ADV_DATA rollback of committed instances
In-Reply-To: <20260703060033.570932-1-zzzccc427@gmail.com>
References: <20260703060033.570932-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2894827059730248981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1120898

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.29 seconds
CheckAllWarning               PASS      27.74 seconds
CheckSparse                   PASS      26.35 seconds
BuildKernel32                 PASS      24.46 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      461.39 seconds
TestRunner_mgmt-tester        FAIL      220.05 seconds
TestRunner_mesh-tester        FAIL      25.86 seconds
IncrementalBuild              PASS      23.79 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: MGMT: Fix ADD_EXT_ADV_DATA rollback of committed instances

19: B1 Line exceeds max length (89>80): "BUG: KASAN: slab-use-after-free in hci_enable_ext_advertising_sync+0x99/0x190 [bluetooth]"
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
Read Exp Feature - Success                           Failed       0.247 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.399 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/390

---
Regards,
Linux Bluetooth


--===============2894827059730248981==--
