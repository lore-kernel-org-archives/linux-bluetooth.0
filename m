Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FC62C11DE
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524666; cv=none; b=hukE08ul3Dgzhq1f68/G2GFvS0nluQ7iN+DvgsM7NQRhJSBMCRUiKB0pjOXATJTOIdVLIHiGbQ8cHllrIoyINGVmIVB39HAmdpfg3LGP+RN+hbDCcOMwFs6OkA7ZQPI6gb3td/LMvFIna/q12CkTWnPO6erFO33LjgV8Z9hOJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524666; c=relaxed/simple;
	bh=WyaTMeshmB8hvyKn6lf4ukmDnk+ihnVAlOA4eS+ibYk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mh5hBZSdPQiQ7ZHjCPUWVJZT12Z2uQtN2z4NBsoCk9A8TFMq3yM6i4niXhwTNKbn+MK2YZF8l1m+p5ISF72yhz8zDUmdLHHMZ0GO7E8i2G6x0Ijym2f63fimPByToV9d0d15bmmaTa1Yc4QRbBuM/MEC6FKq4/igw7qeOd2JnEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf/L0kGy; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf/L0kGy"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-911afafcc20so255877339f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 03:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760524663; x=1761129463; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5nWLlZeofl8QeBtqn+B1vy6nl5WYuYQ84UQBUxmYSPQ=;
        b=Jf/L0kGy74Um3fTqFoZY4c33Nx4v/EMFo4zoeM8GNXlH7r9969cQRwG7i2IbYpFdH5
         R2KSaAzD06LiNyUEdJ4NhkYc6ebq5ca3LBGfJHorhu1iNvL8fzAjxlsinpphDJr6iF3b
         3TumTeuWsVS62oSG30V1f5nq26OrFpMnREVlhaJQ2Kqsls3zJeWKHpXMW6f6PTopNzOl
         JsUpQNOi4YiRBUNIoTnPU4D5ER1J+mVB//gKbWN189YJsU9kp4zw9jzxYChjv7EWVW84
         HErNyY7SAm4Id4zCQp98HhQDnu3WzaXLNmkXPSYw7MAJNYX6wVFAyt6521tfzoAnCAiP
         I0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524663; x=1761129463;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nWLlZeofl8QeBtqn+B1vy6nl5WYuYQ84UQBUxmYSPQ=;
        b=abcv0GE7dfaEzEUCSB4SOgudCiAsdtTkEUYdkWhra5PRmpDcHUR/lIC5wTvnADBZ2U
         RPez/UKgtgv3GlJOoWmawU4Lu2LmV3o9swEDEybyNL9DwFw4S/L7Cut27esuRkkos6VN
         sh3C3t5vTfc0mZEh8sAHaREz1lJ5TsSJTnN8ViGQshrHIaydENNdjsvCgJkTo5IB3EYe
         S2esXl5qQCyHsM+sCJEizj2cgcvfyoquk9PlUveyVLbfhxUVoTxmUzBkPcYeqzgBAbts
         SJ28McmD+QCEoMXnmdidcxS3stqltHElEN2fi+k6zLGM6ZEH1oiH/EuPIQ4drK5Wgwfd
         j7sA==
X-Gm-Message-State: AOJu0YyAyi0SHu38QDfeSOOuPt9hvOj7ryHbH6G68uboILDvWNvEE/mi
	WrSliKqrB8PyIUU22owJB7tSRkx/ly8z2grpxu3BPLFkXbc2Gz7yF1JZpPUnfA==
X-Gm-Gg: ASbGncsqii0J9nd8rQElDCT+LDAnvn/K1GCf7yOtOfgXLW5u4+icIfZDfiJWs+Lq4cu
	qgSKifgEjybYdp3yx5VYEeofr83ksJ1XKpylJrpj5mQY0+45GFqm8/MapDuvzxlhlxsxgYz9qY+
	xfCPFsfoEkGRpF/jUT7e051IKKNJ8x5ZcYaKK0i6jLxVmOULfkT3ALOlqSTs1oHNtY/gkyA7scL
	EDlh5oN0wbpTXZsdwigbM6KwRGvzXEEWwczL1J3ivuwl/oy4rG2aKDlPhiBzfaLzNz3ZpKOMJoL
	CwXik5HNWAqKFEEUNIW1mO4H2Nkq26U1HWT8pApYkQBy5tWoMJJbRDx5BcYENaSagJoXYoG+JQZ
	CiYiFPNhISsneKzCDpyCO9jJUbWZWcEqsG4cx8nuSkMHmdKQ=
X-Google-Smtp-Source: AGHT+IF2PGZ+CvLNG1XpFfuBlZF+d887hL1dxR0MusgKcXuifhDkcKRsK/Lh4Y7tFvKuBa+9a7/MxA==
X-Received: by 2002:a05:6e02:1889:b0:430:aff9:a82e with SMTP id e9e14a558f8ab-430aff9ab5cmr5612935ab.16.1760524663073;
        Wed, 15 Oct 2025 03:37:43 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.108.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f7328cb2csm5754243173.63.2025.10.15.03.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:37:42 -0700 (PDT)
Message-ID: <68ef7976.050a0220.1cb572.8eb3@mx.google.com>
Date: Wed, 15 Oct 2025 03:37:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4554444100263321045=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Fix event packet loss issue
In-Reply-To: <20251015101436.2579377-1-kiran.k@intel.com>
References: <20251015101436.2579377-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4554444100263321045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1011786

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.89 seconds
CheckAllWarning               PASS      27.43 seconds
CheckSparse                   PASS      31.17 seconds
BuildKernel32                 PASS      25.11 seconds
TestRunnerSetup               PASS      497.61 seconds
TestRunner_l2cap-tester       PASS      24.07 seconds
TestRunner_iso-tester         PASS      84.73 seconds
TestRunner_bnep-tester        PASS      6.21 seconds
TestRunner_mgmt-tester        FAIL      123.63 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         PASS      12.77 seconds
TestRunner_ioctl-tester       FAIL      10.36 seconds
TestRunner_mesh-tester        FAIL      11.38 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.47 seconds
IncrementalBuild              PENDING   0.82 seconds

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
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Pair Device - Legacy Success 1                       Failed       0.195 seconds
Pair Device - Sec Mode 3 Success 1                   Failed       0.174 seconds
Pair Device - Legacy Reject 2                        Failed       0.163 seconds
Read Exp Feature - Success                           Failed       0.110 seconds
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 26 (92.9%), Failed: 2, Not Run: 0

Failed Test Cases
Connection List                                      Failed       1.002 seconds
Connection Info                                      Failed       0.140 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.850 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4554444100263321045==--
