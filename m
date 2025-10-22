Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A622F2619
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165558; cv=none; b=nzZGZz/7kdy9v8rgkaQ3FBe7nQ6UfMvEyapsffhSpb9Gb3/JEFtGa/SGSeuGJFtmyX6tHzuo9s39ARNyCY9hWj4lAtjIY4MLyjVCKUh9qsvhEgEXyUqHQOXCOutghmmIysRSGeG0FgYhzZnlo/pCgpjonYk2ON8rHtb+XcRwzZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165558; c=relaxed/simple;
	bh=KAI94qfpqgSl6UlQzUefEtakakHOOx/CwFV5zMbWaBc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=l5EypNTR4a4Ugf87tab65XVuaSNuMtf/ZSUBDfyD7r3uBJE5NJiVRPodyWVnTKWKHs2QpQ1v1hjJ4dXH9UVFnn7bPm8hAKd7RkczOb077j98GMwYYmysb1zBLxj1TuaD/52kJJQHs5+0FsIVUN7aR4QyHAE8wQYUkviO4usnFOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBs69sHI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBs69sHI"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26e68904f0eso246135ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761165555; x=1761770355; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T3bkArX0u7ozbe9sNHdds2zoxmcfo5iP4BOPY/YADpY=;
        b=QBs69sHIAy6kMWi906mzXUNoNo/zohvW/slNzC56A7QDvBvPNMAN4xUrLdyUbGnahU
         oWmpuAq9gCzuiBWS/he8saGeyFMkWyoQuq00JlzjyrzOamJF2O41D5qg3Yp2dsaqO0Wj
         dlCNGvC8L7TZOLtyHnzGA2OkBaCOe7W61qsfKt2wBiFO4Ff6AgCoHr6KPs1oQ1AvX5Ou
         wN98njlUXxlKLLvLv6QSdKRPLRid3fljZEVP+VA3R6Xq2wg68LcHHbyKXVMkt+B0WZkn
         4+KdLKjm+87iZJT7yt4nTvzlxm4X6nleBzW8FQM8lctczt6ddTGF/6zEvNhB1iTq6LET
         84DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761165555; x=1761770355;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3bkArX0u7ozbe9sNHdds2zoxmcfo5iP4BOPY/YADpY=;
        b=rum/GUTuHfeiUjkbitvmX6sE+yctVqQKfuesFDcP3SU/krCaWm3/cVRgAXuLm7OgqY
         FDJTLXkZVk7sMzsKJzp7C/+XykYKXBquu+LhN0hycNmf7ucvBFEU4GdGRQoob3rliFY3
         kn9CFYu5GEbCgj/TfmfeRC+618n5gmNhrBh0ez9DPIOjYeR5tebu6qNzgj8nX+b57AV+
         HsA/V9SJ6AHE4/fXPDabKAKsbDqbub7ZaZic8nywiss5jgVXncDIoYjLEmAWWKhNWPtY
         e6dbtBJMzzgBY8Qb+mjK4k1MX4yOHuviClZYGZDX2+89WVfNrxcJMCZb241RDiY9Sflg
         hO5A==
X-Gm-Message-State: AOJu0Yw8PMfBF/8007hKohnXsPKdM1QyEQVJ4zdrhvBQCAlvO26gz6fr
	dpkuy5ebpdUY5eMMIw1ROamFod47AWILf5G3ToIn0N6sHkS17L9WXU1l2ckpog==
X-Gm-Gg: ASbGnctP7j1weuZhkHv701b+V7qt//zlvCSrO7JCoJVtCXA+7e+g+Cd5tmPLqkd4TjF
	f+zHekEB1tWX6SC1xLSr5J3IksvzmRBUX/BVmBzBd93BW1v4+nXhywsuxpmx397+1P/A7P4jPYh
	dvIVOetZr2lnChNjuzDTnRuJw9H8L20i5dpZ2ZtOz4VQlQBMtl+Yj6/4L7m5GahcuNAPHAysxs2
	A3msDS5r7OB3OLQ/V7za8FKN8gMuYg4yefF94iTANuqnyiXtS8pWPEp+LwO2mL9bjI2ZSwQFUml
	2j4PRCRWemy8jpRNOA4EY0fXU/OhCalY/CA8uKrOXnYPvRuHUatctyEsmlrDsCx6NEZSCqLyrM7
	UFN86ALVxtHhfKk3k7cMeQ0syqzZ6pB0xVWceTcscoPgUG2U1lNFN+dqzGhA2kqkMNAHjg/Jvif
	zB1ITZucxA
X-Google-Smtp-Source: AGHT+IGM76IOwCq/eHDKzM4SpnxNNcRvXXNZ26bUyCo3i02ZJoR8vrXh6b2ZNfcdWepCbbYzJ6ec3g==
X-Received: by 2002:a17:903:1111:b0:269:82a5:f9e9 with SMTP id d9443c01a7336-290ca1214d6mr292051835ad.29.1761165555420;
        Wed, 22 Oct 2025 13:39:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.213.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dddc0e4sm286725ad.8.2025.10.22.13.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:39:15 -0700 (PDT)
Message-ID: <68f940f3.170a0220.f0a35.0265@mx.google.com>
Date: Wed, 22 Oct 2025 13:39:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1743806465927736258=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_core: Fix tracking of periodic advertisement
In-Reply-To: <20251022200319.1529849-1-luiz.dentz@gmail.com>
References: <20251022200319.1529849-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1743806465927736258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1014683

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.77 seconds
CheckAllWarning               PASS      27.40 seconds
CheckSparse                   WARNING   30.67 seconds
BuildKernel32                 PASS      24.73 seconds
TestRunnerSetup               PASS      488.81 seconds
TestRunner_l2cap-tester       PASS      23.74 seconds
TestRunner_iso-tester         FAIL      50.51 seconds
TestRunner_bnep-tester        PASS      6.16 seconds
TestRunner_mgmt-tester        FAIL      115.57 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         PASS      14.44 seconds
TestRunner_ioctl-tester       PASS      10.03 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      6.60 seconds
IncrementalBuild              PENDING   0.99 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.109 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.915 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1743806465927736258==--
