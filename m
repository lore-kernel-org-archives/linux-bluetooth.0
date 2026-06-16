Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC483A8746
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625990; cv=none; b=TcJotuagq4r6ZXIduXKobPH9r3wFNKUQF0k7IHNp2YnWZGBLl5Gk0Hez6v9BVnBNSQGm7HrXjwQvPBEy/EgJr3P2kV9Nr+n/WGBPAmudFZNKSASGhkYsBRZOTCyGJHV20Veporwwed+2FSCzxFVEBlrnpUvsnfs7rmqNE/zEISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625990; c=relaxed/simple;
	bh=Yz/BZtR01nXZjGxO7a7gtud6e5n5+B9qcrM+OsGM38o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WHaRWVq24JHBaWwcfP4XzUIbBqf3TLqkST6WqL7Wg4reW4f/hahN3OBgWSOzdbCZ6rR3xSUaG/2f6pkITAXPnRMhfIiTLKTV5bCW4DuHL0GWA/C33JRF6cKnfQmBictVZRdBJoOstMgnPXrGaX/xIcIieXoIdL26jRxP7a2SnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpJsUqrr; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpJsUqrr"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30bb7d20ad9so1046227eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781625988; x=1782230788; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8ko+xSr4br8AmYXN0n2TT3xeRf30FLnpVzfvhscclTA=;
        b=HpJsUqrr0VHbTNQBqZcgKo95IeYCIIwWd2fQILsPPBV5zE/oNqTvKi0SNYSJnj5EDh
         PtR74eMIPCBg+fV0uE2MKiO3tqPffL1u6Jv0/Ds56kSEt3zofR60nlFmW8hMdwU4LQLb
         3IYmY95ImBFrdOCoI5H+eD+pwifINgfr7Rt4rD14n/ifX7ozqjO0HuLCWB/OocZ454Hz
         hZEC270L6Re19I/Zeln2PwPEFR4kMcB4ScAvYhLkOCmWB335bUj29RHzsH9JtYmb4OkN
         3GtxLJ7jAHyNBCQfL1h/0G9Cof7tXDtLWbCEaoYUn+iJHXGseR2m3Cr0/x4epXvyjHPd
         JnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781625988; x=1782230788;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ko+xSr4br8AmYXN0n2TT3xeRf30FLnpVzfvhscclTA=;
        b=QTjg4MpiPKGUoxVepGyXG3S3eJSbwtQlAu7p2UC94Y5NoQpuhdMZlYL7QPnjl7jnhr
         NjcnBse84f2ZQ4rqNmBtmRxMCvda2vzuFETv2gyqEud+rVVNc1DvnVMcLlwWo1JS7Q34
         YD5fcSRzJKa1/SuCk8jn4OSUAO0YzHZwzjbnH5MaAAIpv+/2FFBd24QGDGKz8eO6X2iI
         +jbMLTBEpSzKx0u5+Yyo97c/ToyXyUTDAthRyBIoubpZTo33PQ7sDVf6zjP4B4J0Ag42
         RJpl7lhhxg+UFn9SsapN9xjxDrfu6j8XUrs6X5wW3mVXGiWxwyHwC1MwMaz2Z5WhwKnK
         kJiA==
X-Gm-Message-State: AOJu0Yx0L6QdDXBk/Bsn/j1ILVD9s8t+++u6QlAj37k8ZDexpp+Nf+9s
	0Erw3SvcxmmQsPzErzrdpaiCpIKIvsQqEkiaG19d8pLfS7cpULMa6SwWr4xKkg==
X-Gm-Gg: Acq92OG8NqaPW8PLQzK1qqjXDSk5qhvz4lnEm11i8ouKcMHRO522gW5MRIRszz97g/8
	Qt03O00D+K5cRCO5WFiilsz5hcxJf/OQ33in99Qessn6WJQcVdccQbR18XPRgcndgMGQzq36Yd+
	9eaU6WtVSid0t367V6EeOuU/9eAMv9T943EKEReSo2tcJg0UlxVoUoITiMIy8QSCKQHgjBCsz4p
	LI4rA+mtRQbgmyAUJT4h0djvfNCdtkYoFsFFVJN6fhiRmCzem0kgL0g9D/gAcrJVXilSMYu7WmG
	lJpQNuAXe2NrVPEKY6nekUXeLkKRLETbOzBZI8F64cqm/ul6B8nnCl6vCCiaBVWNbNxut//3MVK
	refC1zHvLWqAFT7GFj/mB4deyVQOgQyY/gfJxVBRfFajRpmFA8VhkVJ6UpaVDE4TtB76v2nj40E
	z53Tdn6PrRyzZZQq3V5BBHcSRsruZKEZDsogyitGI=
X-Received: by 2002:a05:693c:6399:10b0:30b:bd53:d11e with SMTP id 5a478bee46e88-30bbd53f538mr729240eec.22.1781625988309;
        Tue, 16 Jun 2026 09:06:28 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.7.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48c3dcsm20372386eec.1.2026.06.16.09.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:06:27 -0700 (PDT)
Message-ID: <6a317483.6139c123.2df0db.f355@mx.google.com>
Date: Tue, 16 Jun 2026 09:06:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7749844532336941747=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [v2] Bluetooth: MGMT: Add management security level changed event
In-Reply-To: <20260616145855.342740-1-frederic.danis@collabora.com>
References: <20260616145855.342740-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7749844532336941747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1112403

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.77 seconds
CheckAllWarning               PASS      29.14 seconds
CheckSparse                   PASS      27.75 seconds
BuildKernel32                 PASS      25.71 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      576.60 seconds
TestRunner_l2cap-tester       PASS      58.98 seconds
TestRunner_iso-tester         PASS      78.50 seconds
TestRunner_bnep-tester        PASS      18.77 seconds
TestRunner_mgmt-tester        FAIL      208.08 seconds
TestRunner_rfcomm-tester      PASS      25.39 seconds
TestRunner_sco-tester         PASS      32.28 seconds
TestRunner_ioctl-tester       PASS      25.58 seconds
TestRunner_mesh-tester        FAIL      24.95 seconds
TestRunner_smp-tester         PASS      23.13 seconds
TestRunner_userchan-tester    PASS      19.70 seconds
TestRunner_6lowpan-tester     PASS      22.49 seconds
IncrementalBuild              PASS      24.70 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.245 seconds
LL Privacy - Unpair 1                                Timed out    1.853 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.826 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/320

---
Regards,
Linux Bluetooth


--===============7749844532336941747==--
