Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282F7261A
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784479023; cv=none; b=SZLbe49hAJKhQZBJ+sJIbt1lEq+QSTPx3T0rx8OaZ5Kbc9PgK+CCR5LrpMOCFvmKR4pIHlLMH9vuJFKEseIuC2sfXKqu/jzyLq6K7UlFLc3Y/zxXrqAI4eWB6wxTObxziJFSKxWabxz+5vqGGzhRYSFjA9O13OJtNuZhMDgkFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784479023; c=relaxed/simple;
	bh=rbGxt6VMhdy9yNJFK5pVz6GpesNhqBHQlErib5wrBY4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I1j/VFiNPGB7bj8ZNyf56HM5bkfVwztOiVBSlQF2HuDd/7HG5iLimCcuSluKcmg67HtBgXJtZbUgnhRrVAblbcVqWQI2b9sHYOP1/E6q7jgVRSSpXmBGzG1hoxp+lFnr6scpIPe0R080KmBXMDGBFqJpiwUjZRu9PttGF9j1Spg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pc3B6Zv+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc3B6Zv+"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so3923957a91.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784479021; x=1785083821; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=50xR97ZshR8sOgJPgNyWy7GzngJNl/nc6QdkNm+0EeE=;
        b=Pc3B6Zv+WwHkb2LQ/wv7hwenQRW+cZbxqdHOEB9taxDXPInHN/UavvDIaSqHdyqxk8
         jBATp88EdFDtwL0twloY3ZIgcodzCgCshTvTPyHWA3Ezj1Oi1g3RVfWJfL1vZ5qQBkcJ
         NE0aH4TsY54xCPof8OoJ70USHyUjF5XJ5L2OVK2OZny3XksO5MvfMEyIMutqpPecKMyf
         0JoTZ46pl4DCMroRq/Dqp/TDF35XXx2tWVUNcIkWJWjhUqgyeBCszEODPAf7rruAw2MJ
         EQ1rNknEb3Wtpfuzv3OCSg8fbSvJ+Q51jrkIFYg3bW1R/oQLGr9aI++BSI58LEEgnuEc
         5Qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784479021; x=1785083821;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=50xR97ZshR8sOgJPgNyWy7GzngJNl/nc6QdkNm+0EeE=;
        b=aHo+y9F/9tT1F8KmIZaFZu18lJtdS3uRGtfn2vRZzTGfzpVpL1t7IU+Kv8La7J6pcB
         Upw/kyvq8wQ+xxHYtENMCIHCkzWZArnXtjiVpKpv+YhhOR8glXn4wiVY5YwX0s/vfeAf
         annGQJCplf9UOsbumW7TbHQFlq7ECYnAGCy0soAdSvB8UApBANd+UAnLGh05nYOHfdQ6
         Pq2531yKdGDhFPfa4gPe6jA71iZ2fTeDhPDLKE7pkmVHMiBvNSzp4BNXt/zg5kjapkjp
         jAhZRXuMRorDgOrx4ekFfen1mdKv2vBS1W3G0A4kr8fE3chiUv/Cc5M05rd3iPkI+uWl
         xcAA==
X-Gm-Message-State: AOJu0YxEoyj7oqSOYJqJWsg0hmxxAgm8wtZz1FWAiXkaas6UNfps87K8
	cDj2siXrjggQpJSpD4YAmV86mldVIHXxCzDmJ4Nj5QlCjAkQ+g50GQC6FTxONw==
X-Gm-Gg: AfdE7cmlnUDEDo7l8bf+4j1dMFAzgzXEKCDmO/TEwxP9zZkgNGY9Ej5Dq7xIX9SF+1q
	Nwvema65axgTvyadea33ZVu9pphqFf6YYm+lTUvNp9oQ2bZNgL2leAtfbU0Sa/zd+EZkhNiH8mq
	pMtkg+aisgFmTOWmGBSPeQKIX4I5PMqTJx2hRsFVyTRjtjrfwI77LW0GW3Y8IR39k4t5xpqZToI
	QnoQeIdrOWIROkN7RDS01Dk7MUr2MF7FuRZPUTmYJjXy6Pt1XMcOeFjOcPAQ6Cfq/PTQkbg0Sz3
	huSFHFXRgFmoo/F+ZreOGc006AbnA1wBrFzxpACQHGO7nVxr9jNayXvxDbicfs3htt4EZY/HZxH
	v1IOpL/VYyaqZ9ksocNEHKtRHN/XJhS7/Bz65N5pZnxut+FwKcQPImhe8TEzxV3RI+nROiqq+zW
	T7QEiDvSXjJMg=
X-Received: by 2002:a17:90a:d44e:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-38e4b3d0fdamr11019695a91.1.1784479020949;
        Sun, 19 Jul 2026 09:37:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.245.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb69bsm20601775c88.11.2026.07.19.09.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:37:00 -0700 (PDT)
Message-ID: <6a5cfd2c.92ea0e2a.4a9a5.7f96@mx.google.com>
Date: Sun, 19 Jul 2026 09:37:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3998971237899150826=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: RFCOMM: Fix session UAF in set_termios
In-Reply-To: <20260719160311.2898053-1-nicoyip.dev@gmail.com>
References: <20260719160311.2898053-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3998971237899150826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1130329

---Test result---

Test Summary:
CheckPatch                    PASS      0.89 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      20.00 seconds
CheckAllWarning               PASS      22.22 seconds
CheckSparse                   PASS      21.16 seconds
BuildKernel32                 PASS      19.44 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      361.91 seconds
TestRunner_l2cap-tester       PASS      47.05 seconds
TestRunner_iso-tester         PASS      65.58 seconds
TestRunner_bnep-tester        PASS      14.54 seconds
TestRunner_mgmt-tester        FAIL      171.52 seconds
TestRunner_rfcomm-tester      PASS      19.53 seconds
TestRunner_sco-tester         PASS      26.52 seconds
TestRunner_ioctl-tester       PASS      19.83 seconds
TestRunner_mesh-tester        FAIL      20.50 seconds
TestRunner_smp-tester         PASS      17.99 seconds
TestRunner_userchan-tester    PASS      15.91 seconds
TestRunner_6lowpan-tester     PASS      18.02 seconds
IncrementalBuild              PASS      19.23 seconds

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
Read Exp Feature - Success                           Failed       0.182 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.981 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds


https://github.com/bluez/bluetooth-next/pull/456

---
Regards,
Linux Bluetooth


--===============3998971237899150826==--
