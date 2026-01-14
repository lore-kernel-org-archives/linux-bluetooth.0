Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EDC2F39B1
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 04:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768366513; cv=none; b=MaN58uATF1dUh69pjrK7bUOZYl4+4VrxgB4zrUhRBBbh0KtEIYkionp1QaRVJbIxhd80e67g/Y03OqsybRK685vPZnzLdQDgXdA+FrIM+Z23uTIikff7RIUlJPvb2iEsvlzwdl4R2DNzifA5Fig5JglAGro43f4onZU9a36ogKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768366513; c=relaxed/simple;
	bh=VTxhj4flpuNBmOD37YacuprdC+EOCutaFII4Arnu6w0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S/sEdb0slHZtdzNtg893LlF4Cv7Nhkdb9qmR4roVP1yTwIql4zgtrykz5bWxF20j2+rrfOQEJhnX+IaixKyeJ33Z1MwSrYWOdDSrXdgriy2oPxsYf072wo1ztM3Qq0dEO2a1f/zV+VYiB/GSZin5qVsu1uTSzDWVzrCqX7kvXVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXshTsTk; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXshTsTk"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c24f867b75so844632885a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 20:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768366487; x=1768971287; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nYN4KwkIV1368vJ/YMUVsHzV6UWmy1TerWy3qkl/jqs=;
        b=CXshTsTkQoOR9mlodBf1Oa/7Uxicr3T/P84dmyuY5QpO2X2ErYuWKZ7oi25JZaW8Yp
         LPESyq77EpjG4UYmpu4w4S71F+Q8RS1bCqU99+n1uVNQHH/fqBvGrlWUgZcZMKgb4GPb
         KtY/CxwGlMPUabrUMP77jp9RXG6YgRnFqrJMtLruB5JSsUKT2cJhYBUrkKJwQ38Taf3F
         xZhaaCa+H4sRMnZNgT4kwPgKxo+i7nhlNFgMtKz8rMDkfw5MFkGw9WaLcDNwZdihlOb1
         hE/tstDaILoTkzZPqhSRA+N0Qsd0O391NUeo+QSI7pSiRr4qChibR2o993Ql2Z7NjD78
         8dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768366487; x=1768971287;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYN4KwkIV1368vJ/YMUVsHzV6UWmy1TerWy3qkl/jqs=;
        b=DCIBEsWqL2gNr2ZobemeCMjn/1jwtyUis3/SA7mUBKLvGSlDXyUa2kJyVPzl6onXQb
         luWHQVyFefAfDIIe+8EIPvw8PLcejsMDwtnPWA8utHh8bYyGugoCNV2KXfV9Ww89cR46
         hpueuqwMPcKcaqqWN0eiaiG+96NOZIb9jO+Lc+38i4KT5CyPnThn/aq6nM8SkyNu+M12
         b6Mrs0TIyo+MnnyCTPd07GKHey90jVaoA8KU2c/E6iifkQFI2chSjauGMDdGaAfGnxbC
         aJaRE0+FH9vWkkIDzYZryVYQycccaVvAs/P01tAFYv5MIJi1VA7JNZsB7lHL9L6JgM4x
         fbJw==
X-Gm-Message-State: AOJu0Yx6xBxyMGdYxx48D9JzvTGk4z489Wq97S42jdCfD2PWU70iUpir
	wnLI7b/EdM2YCpKOjJTqh4X/5EuKk77csdwNT2zi0MsYHmkUKLZjFnWf21gvVXPp
X-Gm-Gg: AY/fxX5O/iV5a92WKHdv+AxjstPkyqK4lF3CP8y4TtFvdGWBlSg58zEyB+CFK3Mk4jw
	jcrp6wtz8C+JNMWOHDUFZKNwXutUL3lmDPCGqOWD+GTGEcFHvGShpmKWjODfNlIi0ue3VANBIz2
	MCFNqbVtxd1wSKPnHimufV8H+ZDEouKGCAIr8jS/WmOYu8kwvGieb5dDs7uDx+nq/aY2FLeoaaM
	PZTpFFHyARPVGsNZLbu8AyTBPY+NpNscAuc8cdQmksyNk6Rz6zJiWXiVnBdb+a0leuptR7IHOlQ
	4Bx7RxYz+o7Ld+v8DQxzgWOmE/9cUbFnDYU3WrQjCKlIf4h8USwPiazhsf3JqMxNMKTTrt+VGYF
	SpLqVLJEKYloJZxWFKrcRBeoQWFPU7cMATDq7mns3NimxlO/Xt2pbFoFkf2HxRNQfo1k206GT5O
	34Yq7Cz+wDEZykJilvld8=
X-Received: by 2002:a05:620a:4007:b0:8be:88e0:4722 with SMTP id af79cd13be357-8c52fb92385mr223730485a.55.1768366486518;
        Tue, 13 Jan 2026 20:54:46 -0800 (PST)
Received: from [172.17.0.2] ([145.132.102.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077267e14sm171681476d6.49.2026.01.13.20.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 20:54:46 -0800 (PST)
Message-ID: <69672196.d40a0220.13913f.485d@mx.google.com>
Date: Tue, 13 Jan 2026 20:54:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5681321416468056964=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, w27@sorz.org
Subject: RE: Bluetooth: btusb: Add new VID/PID for RTL8852CE
In-Reply-To: <20260114040335.118108-1-w27@sorz.org>
References: <20260114040335.118108-1-w27@sorz.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5681321416468056964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1042093

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.62 seconds
CheckAllWarning               PASS      28.23 seconds
CheckSparse                   PASS      30.80 seconds
BuildKernel32                 PASS      25.01 seconds
TestRunnerSetup               PASS      545.99 seconds
TestRunner_l2cap-tester       FAIL      28.20 seconds
TestRunner_iso-tester         PASS      86.03 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      115.62 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         FAIL      14.39 seconds
TestRunner_ioctl-tester       PASS      10.24 seconds
TestRunner_mesh-tester        FAIL      12.48 seconds
TestRunner_smp-tester         PASS      8.64 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
IncrementalBuild              PENDING   0.84 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP LE Client - Set PHY Coded                      Failed       0.162 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
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
Mesh - Send cancel - 1                               Timed out    2.701 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5681321416468056964==--
