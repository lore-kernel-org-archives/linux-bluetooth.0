Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E523018CC15
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682137; cv=none; b=nntFUY0epUAEZIMxVSkT0qetoOJwQrsMilon5nJvT1k5qcAOblGD3ho+FSQ1h5ulu/wp/wu0gewdi68kZSgjcefUFLNnlYflghGr/LjtYBJIjEWe4gKuSl0GTXgr06PUZfgbhC8uWUWYbt40EecwxSqIxSQw9KrtsXJfeJiTfoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682137; c=relaxed/simple;
	bh=r6mpwCQWm3MnSbm8PnUnXKYi+JUNBMClfJ/CZBr/7FM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fPEAMsC0GBEoHyCuPQZtXaH4BH7YP46buqrR9nEt1Umlmd45voNrqyorsWY+CHH0536aK1rB7MCMt91ajXgvhS+dAcyU9Wkjyybz7lKOAof0wPHyI7JqRKR7fJFsXI1iT68+gAS9JgGdfUgloLu+x09tOg0x+jsIm+cHjk872tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxuKbiyE; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxuKbiyE"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e89b6b5342so7373306d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 10:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740682133; x=1741286933; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kqga+kynbjrmQBRUDVV5s/wuGLmqWqnjqObopIoZf5k=;
        b=dxuKbiyEEQrfBmvKSCNWkVDQqWINzdMjfUiNYzAetMd5Ig4VG7TiB/U0IDMXX/9sJS
         LBIvxDdcHoSkrpgVnt87tPNogsmaDfRyhnIPOmXJ7aynE1AD/bBl2ZaiC4f0fx8Si1Ia
         mUzMpoCbAQDqusb1pRx0oSrnRqIw8MpfZXzFhwqh9GE32nB+iIj6XyMi2qJOXaLm6QZx
         a7wqONPQwdZ7UmxI6DlT3xmlf+adGH5u0yVpGFJEQbjBF8sEnr/QU1BuQusDrM1MkCEy
         eHmS94jd7LIL9KYj0KOZJycTR/Ql0SISv4riY3DPWQVdi4lmuwNZ3r5Ci9pWw6WHeem/
         mV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682133; x=1741286933;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kqga+kynbjrmQBRUDVV5s/wuGLmqWqnjqObopIoZf5k=;
        b=kKTMlAUt5O7y4lmH41ikneGWkUz5gpG+aALHRJfN8PdGiWPzeNyw5FuISEq/Diy0/3
         p9MXMzBpVVdkpKxjU87pVpaLgu5wFW8gqQnOwgX/W8rxX4Uh5qPy6jCUfeMF/uMLGR/V
         IUEODc3eEl0pAyuNgn2yTukiu9d74NUM9MlDFFQjIBYI1vnObrLGchypIiclPYBSsajO
         nI2WhyNaIm1Fqklh3DhYfEDNFHZd2Cm74ti3gPomA0hNR6+huEBxBZkMOiMuiQY/NIQr
         FRXUjLddqgLy/pCGa7W/6tLh0jcUrIPUPG6GY7vzX2vuKwshTyQPtZTRc1uv4sphyzx/
         Ck+g==
X-Gm-Message-State: AOJu0Yz4wCe67gJQen2ITItDTl2ZP46D7h9G9YBGwiqIK5S0Pkoonr02
	DXJHP+OQr/lM8Ht0ARabxLyCuK9W8cbgDB3dmfNcpbCNGlTmc/kxdwPkzg==
X-Gm-Gg: ASbGncsFya/bHL7BAw8ElqFtk4sBa++OQkoVzkXsKHWKpAHDzz4bAKFmEoAxnVKM7OZ
	RQkDJdGJAGGmikryH6lqtl3F2bA4+4OGszqdo/ijKOl10tvjOICAfD7Gwd3Oq5qjtUDGSqf+0Ab
	hi8wQ/1WN7W3haZn0iVZihzDQQx/yP5oRZ67uuKGNQ4CbVOS/NHo1uO46WdjJ25741O8I8BkRgB
	8ks8XL3fyO6fUEWh1bfGmW2vpXDs4oWNhz6s4N4vEh3t+LUEyJohZD71jJlwaCnHGYzOYTqytmV
	AGkfOy3ZxBalBvoEtZa9i1trEoJZfol4GIc=
X-Google-Smtp-Source: AGHT+IHPiH7VQvXC1HS1Jb4ideXeJqQAzWZBnqzhf1NnmY3LOsv4cO19N0QM1JwFSMjsBts0h8T8dQ==
X-Received: by 2002:a05:6214:21e7:b0:6d8:850a:4d6a with SMTP id 6a1803df08f44-6e8a0c801a7mr8230586d6.1.1740682133456;
        Thu, 27 Feb 2025 10:48:53 -0800 (PST)
Received: from [172.17.0.2] ([172.183.110.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec3absm12593696d6.122.2025.02.27.10.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:48:53 -0800 (PST)
Message-ID: <67c0b395.050a0220.3817ee.565b@mx.google.com>
Date: Thu, 27 Feb 2025 10:48:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4461343079520580104=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1,1/2] Bluetooth: btnxpuart: Move vendor specific initialization to .post_init
In-Reply-To: <20250227182620.740323-1-neeraj.sanjaykale@nxp.com>
References: <20250227182620.740323-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4461343079520580104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=938640

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      23.95 seconds
CheckAllWarning               PASS      26.71 seconds
CheckSparse                   PASS      29.81 seconds
BuildKernel32                 PASS      23.77 seconds
TestRunnerSetup               PASS      427.85 seconds
TestRunner_l2cap-tester       PASS      21.02 seconds
TestRunner_iso-tester         PASS      38.03 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        FAIL      120.37 seconds
TestRunner_rfcomm-tester      PASS      7.85 seconds
TestRunner_sco-tester         PASS      9.53 seconds
TestRunner_ioctl-tester       PASS      8.47 seconds
TestRunner_mesh-tester        PASS      5.94 seconds
TestRunner_smp-tester         PASS      7.16 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PENDING   0.56 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.194 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4461343079520580104==--
