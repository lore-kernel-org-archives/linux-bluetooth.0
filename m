Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179993546D2
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742841; cv=none; b=bByU1eEELnnYLg/icq9VCz7V6L734eIhoAbPuXx4XYwNoD53K9jf5jNU52uHwyWAyXrH1VEbIunBpE8+bC9qYsQQPF6cFJ4XaSMBUUox8tJpVaIANIlMdnFem2OrlGT2S0ILfXAySvyMXCYRgPLMAjXBewTBKfGeZDKiJrB9i/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742841; c=relaxed/simple;
	bh=0KFuuiig0CtAwjLMg9GhsFoVAA1WQkObhKLzTQsiyIw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TEKMS04nPaQ6OcP65MA+r84vS4WnA82qtW0pRNQd5Csm9mVcQAHHxCi6MjGaNWFD/7Jd3AFgICOb/gHlb5JuUohs9ZGVRkaObsr0gFR1QZiwkVAvKSS25IUukVyY4x+OQtQLED2HOh2Wuhyl//d9r4MBg0jwf02mAqMod3KD7Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBvHHbTe; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBvHHbTe"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8631d0023daso620705b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789742839; x=1790347639; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RnI8Cq8RBADWhqd+afve51MPtQJk00gx+RtjjKf7WF4=;
        b=QBvHHbTemPlhr4zpjLovELOPS8ZcxJ/Y3pTKGLn9eInsvQBEnNWsfhppdjbWmFd/6v
         2zGh6K+ympfF5O0F025NkLc8wiVAqEVwkDCId10/6+EKa0z3ArE0nltDWPzzpt/wzhn7
         2Gf/pKOhS9O5GWwzDnZzVtyvddljUjLOtI9PAEnptfTum5VTks8HRgkHKagtR4stPsAS
         uDCkodqiW7STD2ssiSNVWhkihMJQ8DtLTHIXbqS/uikBWBO6EfEaWcWGv+EUt1CYZehk
         zemR7rQzHMkx6/8I71NCg0I2Hf3f2YAhlvkkPM2pDvl7tsKBaX+YOFG9URXgkvt3gMIp
         TwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742839; x=1790347639;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RnI8Cq8RBADWhqd+afve51MPtQJk00gx+RtjjKf7WF4=;
        b=C0Qmtuqo2gdOkrIncUXPYRbOji7+5iCQcHTb7Isu4K4ewSPENO4kdQPFV2VjHag+iX
         AP+IAWbjQQIATYFbm95j+rhWKRlMgBcoydieFvTGWF3WCiVAs7a5dRk9sy4iOuAm3ITt
         69/+EjxdkMKJqowXjRZzrK0jyR16d6CnoLZqkTzHhmbchAxv0SdTUL5wOCTkN8HFiLte
         a4GFgkbtzNDgyxa1x2FP/K2lUCwj3Gdz17wV7gKnNR9Gt1m6UB6KdIo4vm86VHrGtkUO
         v20eD3YnLHm+9A8ZEPbfO+5lImyUguNged9txSiZBBMesT/cO88yAIs2FKKD/eC9TMUQ
         +B6g==
X-Gm-Message-State: AFuF++lmFIMtctrvmgznaJyNnF1ufGMN02arw3PpxhzJ+tT7LzWrzkvc
	iGHIXvtytcC1d/5pVz+yUwOJqnAwtM9+J7TxL6OHxr30CQRWDLGmPrSsGkNI5Q==
X-Gm-Gg: AYBFou2nZK9vgy04X3AwQ1RTqW050U6W+F2TyPkRJAhkcTDaq3P9YJOWpafTUailMww
	AEpNv4TXvmyDR0TE+Wou3BVM91Ms2fvmD5bo04G7VpLOSWKkbO8FxEQay8iM1LSwFDEBVmAU97j
	MkXL7qeTzdM82KF51YkQ0GhhPk+h/gW5JefnNjQb2bHBHZpcX/z+z5l7HwKYDcvhi0RU/cZ0IOP
	9buB0rS5hG2DQ52yj+ZFfqjDXUJoPcRqZtS72V26yfljNtVkoM8KIyG4nsxVMwjLneEfPUK8/jE
	pSM3IPcOuf/Eaw5X2X6yPmSjrWTmzIbnUrZgRcX25upVDB14+T7AO7rN6z9Nsttaa5y25DEBVe8
	cZiamXDid6CaNIw9Xfu8/4i1qNqwwHj02KY2a+xFRByE+UxK/uCPdnzimewHRAAPeNRsRS1k5gM
	C1fQFEBd0RgObvxmp0lPgxvN2cBFygDO0kA60yamy1+Bzs6nL4c/LMQaTvYnIaFdXb1MNLqHJEC
	O4h
X-Received: by 2002:a05:6a21:7105:b0:3c4:3321:4fe9 with SMTP id adf61e73a8af0-3dd8c3d20d1mr5697066637.7.1789742839154;
        Fri, 18 Sep 2026 07:47:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.74.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287be968sm5256335eec.26.2026.09.18.07.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:47:18 -0700 (PDT)
Message-ID: <6aad4ef6.ec46f90a.3c4792.8865@mx.google.com>
Date: Fri, 18 Sep 2026 07:47:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2164474553792041400=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ngocthang2710.1999@gmail.com
Subject: RE: [v3] Bluetooth: af_bluetooth: Fix double list_del and UAF in accept_q
In-Reply-To: <20260918104736.958613-1-ngocthang2710.1999@gmail.com>
References: <20260918104736.958613-1-ngocthang2710.1999@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2164474553792041400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1168560/

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      29.00 seconds
CheckAllWarning               PASS      31.93 seconds
CheckSparse                   PASS      34.15 seconds
BuildKernel32                 PASS      27.88 seconds
CheckKernelLLVM               PASS      31.52 seconds
TestRunnerSetup               PASS      704.03 seconds
TestRunner_l2cap-tester       PASS      16.11 seconds
TestRunner_iso-tester         PASS      36.46 seconds
TestRunner_bnep-tester        PASS      3.76 seconds
TestRunner_mgmt-tester        FAIL      60.00 seconds
TestRunner_rfcomm-tester      PASS      4.17 seconds
TestRunner_sco-tester         PASS      11.49 seconds
TestRunner_ioctl-tester       PASS      5.29 seconds
TestRunner_mesh-tester        FAIL      8.91 seconds
TestRunner_smp-tester         PASS      4.07 seconds
TestRunner_userchan-tester    PASS      2.94 seconds
TestRunner_6lowpan-tester     PASS      4.13 seconds
IncrementalBuild              PASS      30.91 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.022 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.523 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds


https://github.com/bluez/bluetooth-next/pull/790

---
Regards,
Linux Bluetooth


--===============2164474553792041400==--
