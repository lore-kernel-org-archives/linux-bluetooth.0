Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE18331EDE
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060895; cv=none; b=B/M4UlAX1+2C2b2i2HJwvU/LLfG9sVvLtytYUNUovYVfcG7NPeebR+nN7y0VRmgtSIQ0jR2jPNbajQvSGXmNgBM6rrxc2pfqjutGFuoUvzxW1OOUfXm/eiaxoedZvMdoO1M1h/e2TUWRXk8ndBufbtemZmKJJpsxy71i+mkeKGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060895; c=relaxed/simple;
	bh=HRaSov8zRyO/3tQ391lakQFhkgIlZX/d9s0EsxO4KBU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uQq+OryZ3PYH5QTqw/GoGEg6OHeBG/f1rkaL714ngBwfemttia4zaZCygT/+K2a7u7Bmecg/N6oYXplD4Nn9qWDZo4PMsMZP0Fr5og3Vpl46hzNGUtEDKD5luZwwBimZJFrk5BrxZCa0mJXZEelB/SlRIxjoLPgXZH3jE8smZ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7lMyOOu; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7lMyOOu"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso181365a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 23:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783060894; x=1783665694; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F+SmNzZWNj0aanm9f2Yu2jlnPr10IWMTlheN/4vYtD0=;
        b=Y7lMyOOu69EPiUEdC7CbQAvsEm753INLucKGfIUheKqcKFCc06839qSlkJ1toRpj5U
         SbREcT9fXhpCPwDxCeve7D4Y4DcWB4gANNHCftv9dFSwynFvw5LzUV6Q5ozCHlDWtVD2
         R5gCL0Jvvl+pQBQP5zgGxcJU9Kow9O98dgS/Hmb1nGT0hGXuEccYZ0t0MpPcFT8eIalY
         leL3QKIjEi/9VbTMMkEfIiQp0Co6YMwKx60RqBX3GAsuCrFT2M+LXj9cGzkNC3s8WD7N
         OqlvVfOGYBr64TBo84MV0dox0ndKZlarfMtvbRclZkEyNW5nayvvL6ob3f/jcxcb820w
         TDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783060894; x=1783665694;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+SmNzZWNj0aanm9f2Yu2jlnPr10IWMTlheN/4vYtD0=;
        b=dhs7xvV4l7ij408zbCeJ5bQydhiXhh1QaGWGPGTT+rGzkNYI4oB5K69MZHjJ+wbomz
         2D87/2Myu6Q0SLZe8d3VYbpTlklLdso5AagR3nilv+jVTfPva7HbBhP/30X+3uCblYpH
         w7Imo6yIOgPvjJEd3waH7eV8LnZ5TuzLeucZMLxqJ3q3G+gqB4FaeyrCtzx1yrYSChCU
         iUXM7XqmQOITRV5RMcOqzIzUOTD1bDGxA+arrjtcH3Cvp1rPiiZ8CMj4/iCq6AJaI3zW
         K7u7dBlFjqnb/HJ5IoNXyToH+pIXpO/QNYg3mL+LfyO49PB+18g8PhH2bYJPIQjb6L+O
         SWJQ==
X-Gm-Message-State: AOJu0YxleiAJFUwNxr6rr3sYYmCO8vdb50h1tntWUEhOgW5WDNZNhAcb
	39h/NmBCzCdgeD8Glm5PHcnpk4YkovIj4k7r6AQCVak3pCmFsnbaz0E66r2oDA==
X-Gm-Gg: AfdE7ckrS8zZ37s6MmdjnVqERFGUxgnbBWw/CQ2muJaLXP+ldmMdLUvG0oCH9R1bKoi
	LP59gD8g+BOdlseC3MxMKSmba1yc6dc/k2EB+/3HfquKbnfTATN21meV+aIpP9ybEz825+rIy2K
	cNUY3gsx34g2Uq6g5POVvt9zqmbjwJ5gDJngIiKvT71dFq6zIZLPDTcD0mEQ2Mqu56R56v8XNVo
	khzaE5pNr0fdYx6m57x1hZ/0SOnhPAAJP4gCOcUBocX767Tb1aQW6OKYpAWB3Ov60CjqMigDI12
	+uTzW4nbygTLGOg9rtAjTs3BQAYvBOZv2JFB1tw0qwnAttNxSMOOW2pEyu0mHIReN9VUqWonkKx
	QD/imb7xarwrXAC9UnI6JgKto+T77u04CY2ks4E0xkpAAoKqgyzUA+Kzl022QDd5nFH54l/wFXt
	6aAyFNITu0qGq01dDAALYW
X-Received: by 2002:a05:6a21:699:b0:3bf:b885:2fad with SMTP id adf61e73a8af0-3bfed5f64bfmr10945975637.53.1783060893457;
        Thu, 02 Jul 2026 23:41:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.65])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm3769154eec.27.2026.07.02.23.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 23:41:33 -0700 (PDT)
Message-ID: <6a47599d.f732ad81.1d8ca.5103@mx.google.com>
Date: Thu, 02 Jul 2026 23:41:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1943916726154472678=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: MGMT: snapshot LOAD_CONN_PARAM data before queueing update
In-Reply-To: <20260703060016.570188-1-zzzccc427@gmail.com>
References: <20260703060016.570188-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1943916726154472678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1120896

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.76 seconds
CheckAllWarning               PASS      29.20 seconds
CheckSparse                   PASS      27.84 seconds
BuildKernel32                 PASS      25.77 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      490.90 seconds
TestRunner_mgmt-tester        FAIL      205.90 seconds
TestRunner_mesh-tester        FAIL      24.85 seconds
IncrementalBuild              PASS      25.73 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.230 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.961 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/388

---
Regards,
Linux Bluetooth


--===============1943916726154472678==--
