Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD44A11
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745773357; cv=none; b=pG+4Ovqb6eWxa4E1yqW0OsmXeMlcpmmnZZrNMdF6gbX6wLGgAsYzTAaPWsXq2cfsMip2glli+S3ObUp5EW1CYnwRB1qLcWx6o67nGdl+uD5STvmzgb2w3Bal/lrl5wZ/2UhElVf/+UO/Z0YpJsW+4sN1O/QN6P+fCQhTHgqRq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745773357; c=relaxed/simple;
	bh=cBTJvr1Z9OikN7subXSQov5t++9idK+tsxH0uJfIWm0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CjVz1UmmPjRe+yWWBRFqgLe+TQ5vBIbZNGagNdBSMivW9awLUuIUjF69gqU+tF2do12x+3krdW51jaNey715rftZW6kG4dGSQs99dv/TPMdlHIadbp82Pw6XNcDCe9XJEUmpzudvlTjAIcy9v7WPMfxKdNKQAFfOzV7H+64wE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsG/KLND; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsG/KLND"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4775ccf3e56so63879401cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745773354; x=1746378154; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gSijhjmTb0nM5VRjJDBrCRK4pGw8Dwfz1wGT68gR0SU=;
        b=MsG/KLNDysNEPKf6RCsFwqe9CKprRe2kFyBLK0ONGsAHihgTPiwfqN8etKb4ai7DsS
         hgomCCghF6sY6eLIkjfcfBtCow1ClGMVvWTh4WaoOYd13T6Nd9FSsmy3fFeLxE53LSxu
         O2g9z7i2IuDSznimfIcwwLElgalJ6BO4S25n20EwatwFrdultoffDRjAOtxqnohCnem4
         Jy7vA9NuDNHvTTjgGgK/jh/MeyhIdl7cGQtcKrx8TaRpceBnK91qDWZbt5E7ham5tPZD
         TCaZgy34W7OczbqauXs9gqvY1t/FKzYlTxnNz4NLHVE9LRTbUMF9VdFPel/E9whwSOn9
         +vDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745773354; x=1746378154;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSijhjmTb0nM5VRjJDBrCRK4pGw8Dwfz1wGT68gR0SU=;
        b=OkL6HladI5P8uK6rbcw/pmZ6osPuRErXJXta+Nx/zzeVCw7VN1MvvIiUhzT2fUOcn+
         lEJo9iWJztA76jufpHKsRM2/Yc3omRLy/060dh5dvqLkAyqbENAJkeenlRbClTnHbyy7
         GGHdBVqGWKNzgl79zHOdb0+ZnRQBsvm0en8dzHtXnMakfe3nz4bmnoYy7UnLjRChEuUo
         ivwAq1Y9AN9lHCnA8Aw0Etvu2llff2KSDbD2ghLTdX2e81HEY5feh2/gYE3FN35v7AMe
         KkMt+BdkoUWn28VuvcSh/8Yx07xpjfQbjkiOMq+XXl0VhaBGc4k6dpYJiZZGoIR7YgHJ
         CLgQ==
X-Gm-Message-State: AOJu0YwPokoGv+SnZUEYuNx+CN5ThsrS3aaCpjlcCSOvGC8FJlcmFJTX
	Kts6Rjw8wqWObeahi9oWXx2D9coDbgulTVVEwBmGF5RJ0UayuPA4c+/ivA==
X-Gm-Gg: ASbGncvBa+I39wFkvEUi9xtVHRhYBbcqvM2DZcXC+SLORdFI1hvaAEZsiCgZ0vs2GKE
	0o6zhKrP235/Je5lUXfibStRUk+pvDzLSEuS97XoPPL9rmlZ8NUz9Y6XO1LU4xwle7wPBep3qHz
	4Nulll/y/MDyf2+BjpfjZr07EmIDs4/uN4g1hAdkbScIAA8+zTmTccgZ7aMp6slo57fVOwUa1UB
	HaQdKsOL+OPyGCex+Gb78fb3JZODIw1mDBZ4HMy0pnRHsoHHDXhJUwKaV1s4ycBT+WV4frn2zI7
	BfDM/Lf1P1zrDOmpYhGKcd16AlrorILgE4rw0u2Cm9soKZLkmb4H0Zkq
X-Google-Smtp-Source: AGHT+IGvBW2ik3ikeBisR9ojslbCLBkGkKTgoLilcjs/9Da9wyfC1GBGi3+SYTz705uQJfYIRHHPyA==
X-Received: by 2002:a05:6214:202b:b0:6eb:1c23:63c3 with SMTP id 6a1803df08f44-6f4c0b88d8emr228070956d6.0.1745773354087;
        Sun, 27 Apr 2025 10:02:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.47.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c09342f0sm46534206d6.42.2025.04.27.10.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 10:02:33 -0700 (PDT)
Message-ID: <680e6329.d40a0220.35f553.e3f6@mx.google.com>
Date: Sun, 27 Apr 2025 10:02:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3350441496038884818=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, salah.triki@gmail.com
Subject: RE: drivers: bluetooth: bpa10x: use usb_{get,put}_dev in bpa10x_{probe,disconnect}
In-Reply-To: <aA5Z_gOXAwrWDI7E@pc>
References: <aA5Z_gOXAwrWDI7E@pc>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3350441496038884818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957507

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 FAIL      0.34 seconds
BuildKernel                   PASS      24.64 seconds
CheckAllWarning               PASS      27.38 seconds
CheckSparse                   PASS      30.84 seconds
BuildKernel32                 PASS      25.42 seconds
TestRunnerSetup               PASS      463.54 seconds
TestRunner_l2cap-tester       PASS      21.21 seconds
TestRunner_iso-tester         PASS      31.57 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        FAIL      121.25 seconds
TestRunner_rfcomm-tester      PASS      7.80 seconds
TestRunner_sco-tester         PASS      12.69 seconds
TestRunner_ioctl-tester       PASS      8.57 seconds
TestRunner_mesh-tester        PASS      6.02 seconds
TestRunner_smp-tester         PASS      7.22 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PENDING   0.43 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.190 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.175 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3350441496038884818==--
