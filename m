Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE11182B4
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732285889; cv=none; b=m2fyQ9vI0rtxLeXdozE9qgTyYsGAheq3z2O5+CAvcJFx+OH2A8QghBufCGRSRTIIgGcZeLq0tCz1RJuOKPwCbX/OhzEGJ/k74gFbZh/UxpmjzaMfgQ1c47b0A4m2Bn6XnecPe0gS1VbfHAR3LTZeQBM4f10O3ouhLOZFvefrUq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732285889; c=relaxed/simple;
	bh=cRBDOtR//kAimRjj57A1T4CrNPjakuh/Vl9Z/rG6SsY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H8sX2jCxlI8wC7ixkOGx2H/XuquPCl7+x0dQMOV1aU28KD9dGgNsJW/KTBdHIRcTI2s2LGhIsSoKRhvjGTAFizFrcnHtTCz3756I+mWTvUJjt1tov5Vy3+fNV5uuvNIWcnnvZInwTxiM9Q/edXSZJrQCnZCqHXXVpGxacuk3pNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGpcIChY; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGpcIChY"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f8b37edeb7so1947273a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 06:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732285887; x=1732890687; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wbv77VCj8RvW4EnTdrGeLB+BV7jZqY8u5Kro9Y73874=;
        b=NGpcIChYv+7QUSCz7yT6rTIJ+MLCLyp3K85PD5ShozDuyZtWxNplSu2WCWkY+bqhsZ
         zxbjw7UshECHka6rCPAX0zP0yHQXWvOGj9OZzSxrc/zuOB95gfb9uUbrVb6y9s6aH3gh
         iGY6Yd7smed0+/oRPjdZvIlv8tGRMfbi5Wzm9A+iaq5cjznfc69jZjjjJTKlcrpmMYns
         r7RxbP7ARjBdhq9s6JfkBaleu2zLLB8cpB5xFQAkKjzV7CC7bS3fg4X0gxiwULEl75lK
         HUenuZehRcCdq4TkBznc2Lwfn1xjl0a2JJrFLg9Csv7iavCdPH5mFg0GaYPV6ARmYrJ7
         6gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732285887; x=1732890687;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wbv77VCj8RvW4EnTdrGeLB+BV7jZqY8u5Kro9Y73874=;
        b=EZkwf4EP/lTuioAb/cFnQInusgh7BJDb6g6rYgVbxo1ZeICu53Pom08lw1PDMz+lPk
         5ul0ai6G7+0JPPozmvt/DGf9V+DWXxjCaj9aQPskuNCgnWVwCkfCWR42/JXCYfleBrUy
         TmKr1Fwv6DYf9bXfvx/liYtSSVNsBd+LIy5KalEXxKtlbsFrzjRKj7yuGvWj1qISddpm
         3GIe3DkhbNb3WxTu2rc9rg2qLUb9X8q0QAgneaP53O41xKcmHa1XM2qScAAUssTmB/Jn
         1NLEW/x8b5+m+zkNMt7xe2lMfDWwnomi5AlGMWkAidK4utmZLwFxNTdMFw/YPBt/pG1j
         Oa1A==
X-Gm-Message-State: AOJu0YyGv0NYz9jqxRFcDINpuHTYmVWOwWGoMrRlwmqTxkRrLflQCgzG
	w+hq6BBlJTZVLNeOWK7Pwo0rIHqgvm1+dTPzvIWS7Tdj8BRl5aUAUehRGA==
X-Gm-Gg: ASbGncsBUURWccmmyx5p/WSVj6dbkL/9rVcV6gAVgc08xGncWAr5pwUKz9lmMd5xB+C
	uoDHbQvNBfRBQX/zdl4a8Galb39xDslqzBl4dOAztWyRZZiGFVR0teKHATiiVvq1RBlV/WYUfaC
	UcYgS240QHHe5CyDZl87eibka8Mc37iJhx+ut+BG3mcjrB3zlantKy1Gl8NvlIGyxFOgnaE+uHC
	6Zge1+W6mfwy0q7RhYGWGFFk7aQdLLOsH2aDoUgcgTGTtS2iVMKsw==
X-Google-Smtp-Source: AGHT+IEtnrVDMrB/yBJm+p3tAOGatEYJxHS1dtkX6cXB80jrxaU0KlTY41EThNPnCADDRj1XpPxWuw==
X-Received: by 2002:a05:6a20:c888:b0:1d9:d04:586d with SMTP id adf61e73a8af0-1e09e5ac9femr4620790637.38.1732285886892;
        Fri, 22 Nov 2024 06:31:26 -0800 (PST)
Received: from [172.17.0.2] ([20.172.5.83])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3fae30sm1688205a12.76.2024.11.22.06.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 06:31:26 -0800 (PST)
Message-ID: <674095be.630a0220.2928b8.6c1a@mx.google.com>
Date: Fri, 22 Nov 2024 06:31:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2513613454434584146=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, festevam@gmail.com
Subject: RE: Bluetooth: btnxpuart: Switch to SYSTEM_SLEEP_PM_OPS
In-Reply-To: <20241122135939.337327-1-festevam@gmail.com>
References: <20241122135939.337327-1-festevam@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2513613454434584146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911801

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.91 seconds
CheckAllWarning               PASS      27.57 seconds
CheckSparse                   PASS      30.16 seconds
BuildKernel32                 PASS      28.02 seconds
TestRunnerSetup               PASS      434.25 seconds
TestRunner_l2cap-tester       PASS      20.16 seconds
TestRunner_iso-tester         FAIL      34.34 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      121.11 seconds
TestRunner_rfcomm-tester      PASS      7.54 seconds
TestRunner_sco-tester         PASS      13.50 seconds
TestRunner_ioctl-tester       PASS      8.07 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PENDING   0.80 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.202 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2513613454434584146==--
