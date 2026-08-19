Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A63AB292
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787147588; cv=none; b=jO9usWeyQAvxO6ssDQc8noQvX6qc53LinDA+FPAG2VsTKZmYwepbvRg3DP+fAzBVAOXb+8VGC0sg8+8JbTMipijjzfiR6ByLbd9VcLHNdIObuZ5O/S8h3X3nRK8qvQzIs/dPTzD8XkwPSqDTMG2r6cngNbWfLAPcy5kZBbOxw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787147588; c=relaxed/simple;
	bh=PXMHqHMNwMxvC/rCO5kemd44gyPq0GNjRnn+uXapvzI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V5+7588YgNC0UDOcLmtJrf0hQtH5Df+xQ5l+iuzcZbtUVVOZ6uYKB3Do5QWxgsOLnRs13VDNT/7xaoju1wHIaJa1g0NYkS2jg4eJVCJ/RPxstRMy6cFanVw6F7/QqQTTdrRdX0iaDht3Cv6PVmW59QbGOGArPTMwYf3PstjitjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb3DyoU4; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb3DyoU4"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f432ac553fso791090a34.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787147586; x=1787752386; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ViDb9vX/f58UHqLuAYYGXFJL3H9hU3cDHXoEJkkZz0g=;
        b=Gb3DyoU4mIfKhV6i3xlzq8CU8AjOfRp/55pKmAnHLTo0/gDDoLxdC8NYvgRgvIpUH2
         KpypRZnn1eBRdE6VfiIRyhkiiTC/G/Ebd8AMl36Q/wAdRVNXpFQUsTdOHvJitmrzveN3
         zeI6UGjsF1tvBz6Emlk66NuW5OTgXEmT/I3dpaMy1Ihlnk4mhrpej8Imi1XkNiBOkw9c
         0e5e0o+b1oSU06i6/kAalREaKpR4pGuFSYiFIaaONH1Jdkv6Je3EYOjxeGxf900WYV1f
         ltWD7uVxcPLb7Rbn42x2VWqOkBWiCHiBi0EaWYrdCj6aLM3uq7MsJblwxQrOtRHf1mtd
         MDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787147586; x=1787752386;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ViDb9vX/f58UHqLuAYYGXFJL3H9hU3cDHXoEJkkZz0g=;
        b=UDI39u7NUP2957qP5DZ1OuPwf0RqC0nA4Czs9DksdcAFajQEgdqY7kpbi0U/QsdDLx
         s30qJ+nILTp1oNmjiWeyV8kiqAjPv6t+cibNFNxLi+i9p1VceCuT25ITDixzHZYYeTiC
         Z7Z3WVZv2iN1IcmV8J4j84DOzLIIeYFC0qeo95JxeEGrkxCbrPmdYfmTVItboJLN7ZjV
         sFORiBdh3MJE16f8HEw/4SBInMj+LEsyNKxSJcZ2OVnc07M1t1/16zJsFprFkytvBu8j
         gu+jlA6m4JCFTdkchTjvsIo4j9rNzMa5rmUysB++zEM8XQjftzcyvAEFi35lhZPgjLC8
         viZg==
X-Gm-Message-State: AOJu0YwPwls/+nqtgZKxDKq1zsoDcugHgMmHE1U1563uEbP2opX8mL2C
	ncTjUQ4gLbZCnX7qwDVFeokA4Z76pDXg5NaqnmfekFrrebOQsTC7tTqzGIRPkQ==
X-Gm-Gg: AR+sD13yCIUlwMzlMR6toiZzT5MRQrQlGF9Jfre5/A6WAKMyO7JnSv3Wa99vUKFWKSF
	VTsx5bzfF1BDUvCSVlXBfNUVqgEa2MrxAIrrUzCtxgT3ahLTn316RYOgwVhimYfOiYNBDtJRRcb
	4nJAscAlsyXtKJEFnGqz00oOs7UqiQnJgV0PodYem81/tVFZJiVe5gX46k605nc1bcfajPFQK68
	GylJwnBmPxvDuSADRONVzlODPSInwIhuElR26g+YBI1rcZaXT3tzKLbWZv0reKoJTkgiB1BLlwa
	ltzJydUXp+XnZZmabk0zyyWaOSYTrJnuD+7BIhf77N7RXh7Iad7T3KCOHVwHLvYcsllm35ZKxQ0
	5AE+lipa/ZJYAmsyqzh2ffosMCau9P+G4cao17mMxNkWr9BVzJu1EEhdCV2F0/QphbDGx6cdpOf
	0cv0+YmebUkJCNlwrm5ZV4HazsV8sBt63ZM7ErRVoYDQSGsyW1I/xAswcbO5Zm5UBK9e3L
X-Received: by 2002:a05:6820:1692:b0:6a3:7ee4:11c7 with SMTP id 006d021491bc7-6b13c5b006dmr3951571eaf.29.1787147586251;
        Wed, 19 Aug 2026 06:53:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.165.163])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe70721sm1746301a34.6.2026.08.19.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 06:53:05 -0700 (PDT)
Message-ID: <6a85b541.60a87ef9.1b030c.7700@mx.google.com>
Date: Wed, 19 Aug 2026 06:53:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5805687476617573547=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johannes.goede@oss.qualcomm.com
Subject: RE: serdev: ttyport: Clear serport->tty after freeing
In-Reply-To: <20260819125748.194377-1-johannes.goede@oss.qualcomm.com>
References: <20260819125748.194377-1-johannes.goede@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5805687476617573547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148478

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 FAIL      0.10 seconds
BuildKernel                   PASS      18.72 seconds
CheckAllWarning               PASS      21.80 seconds
CheckSparse                   PASS      19.98 seconds
BuildKernel32                 PASS      17.30 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      311.28 seconds
TestRunner_l2cap-tester       PASS      52.41 seconds
TestRunner_iso-tester         PASS      60.32 seconds
TestRunner_bnep-tester        PASS      13.37 seconds
TestRunner_mgmt-tester        FAIL      184.01 seconds
TestRunner_rfcomm-tester      PASS      18.32 seconds
TestRunner_sco-tester         PASS      24.48 seconds
TestRunner_ioctl-tester       PASS      20.20 seconds
TestRunner_mesh-tester        FAIL      19.39 seconds
TestRunner_smp-tester         PASS      18.21 seconds
TestRunner_userchan-tester    PASS      14.49 seconds
TestRunner_6lowpan-tester     PASS      16.63 seconds
IncrementalBuild              PASS      18.44 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
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
Read Exp Feature - Success                           Failed       0.195 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.937 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/617

---
Regards,
Linux Bluetooth


--===============5805687476617573547==--
