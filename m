Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD031492E5D
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913429; cv=none; b=VZkyYnLYi3ZDdJTOAahToVv5ICgs/+sKaMXGR0VJK4jlJUO7EsHxdM38iuUgjGhgR+Wq5knMmmLrOBJAaJYxusMTDEVcicr/r6GU3MZ0GWp352oiHVLbBDdsCmFzRE2xssiLa4rrr8PVwIczqajfON5P5+vhYfP+RzZnL4ukeiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913429; c=relaxed/simple;
	bh=pCZoYDmhaMCAFtlzRoOM/svLBOcT06nhLL4XtpbXs5w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kVyKTdC07/pI+kr1AUduWD6WIJfTkFN+Nr8SdicQLKiEXXycd2f6NMyC8oanL5HevJlz3otdznm+UqK2ogwMYKe5T2KHu/nO4N+lgXjw+XxyNzBWX3y8PMe4k/rdQfVWs3pbkQiAM+KzeEP6tAglTqnuGd0eKeA2/gkdLNQVV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpCPJL6v; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpCPJL6v"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d58efc7356so66801325ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 17:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788913428; x=1789518228; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K60xTosOTK+BQpNiCwMGCjaEpDDB67nDLJ5EIj0gei0=;
        b=dpCPJL6vupGqJpbpp/i3Tkqe5FmCtKOg4KP+7CR4jhAzVFYSUf8rHIWu/Iguun+bL9
         iuALcaoWH+7Ubi1RIIOuULxBUO0/9XV1DaobbRmaQBh6kmL2BJ7++bvtCCyO5RV/8Ilj
         eWEd/ppFAb7g9Uj2XxwDG+wTKvCb7/sZNZvhh3T1uWWfObgCNDmUMMzNI2R70RZ9uDjI
         YwvBbIKLLHzsHFRcVHUavdJyhD2cw9M7RL+fpPpLqDnZoMzlq9Gg5E5P7jvNtqnXlf9m
         xyvvw+U2vJzp1vWWE7kSODfxx819iS//D/WEdfz47IMDEYrqeC9HBlJZ+wf/R+BlWUuO
         qeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788913428; x=1789518228;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K60xTosOTK+BQpNiCwMGCjaEpDDB67nDLJ5EIj0gei0=;
        b=E+D42Pf1ZObBrPYV4fo2Xk9uJvVwrWh3C9lDIEJvOWodVZNaJf/8cbLpGKi1R1T9HJ
         8YtUi63N1pHXTG/mabqbXycilpcH2m5XPOpBsIsHZEw3nFwHgoaxU9tnVK3e3luUquNZ
         nUkqp74WC/8WOUYDXYquaT0FvYzJeiXrwwDPRakdPVLG/z4mcoU2q7I8kjBwmfZ5Z6/Q
         2aZo4EHp1p41dxj/6RJEEGAmIRa43NHVS7AalSK3PuJ5DMg9ETpZEcZw+v5aNX/X1Q55
         ZSml2Pm86EtyDUBEZVDfUFhgDMh1mwVf0NPzE7YHA4x1lhzwnMgLJcl6+oGiKvVE5lF9
         XyRA==
X-Gm-Message-State: AFuF++m9dRfLGXW7y1mRCRQScDTMq+CrDFMzcgJRneykPCcYz1O4lQQI
	V94QUk1tQPp455ptGI37zSOZaWm1tuZBllLYV60b6YG+UdSyVNDYhmoB7Vqzhg==
X-Gm-Gg: AYBFou16zx/Dy8OgYfG9Q/I3rCNBleO5GmfVOrlkM2QKXr3UUQBPfjh0J7iwaolOuHq
	lInv8wC2MIqBgoqZibnISEv6LWMTDM2xvrAw6/hocieCexsFlwa/ky+wrzyMgGGxt4T+WfEM/oE
	ztPwz2Yp6Ofh2BXDM2fihAd0YKc0DVI42CQCEnxMZqLPAeCdRDq703GH7uX2LsFgzgLimk8N4Qg
	FzgZXqmrRmefN1UM6kZFX4A2BXym/Sh0BbulOj8RmH3jYHq4FJnY/CFpgtvAHkJP9ty/jxnvivy
	6BeHijfYlngaRQWXV5UR02j5T/YWDX2wbFxLysnOnRum0kXkd/Jxh9l2fNyqtK0SyDjadRZXKRW
	YyMxObYq1JifvvusXqIQyfcPz3Ko5NQaaKQ2LAk4G6ZFhupHxgjJTKBFq66K20nzcD7p83byJWx
	4H0Dsdf7fhW+EUocCZkwTDE68y/t+LbVRVpDtxbNLFERmKuon1SVVz6qNm8a0KyLY=
X-Received: by 2002:a17:90b:3809:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-39b261014e2mr44968898a91.7.1788913426400;
        Tue, 08 Sep 2026 17:23:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.72.1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432424d27asm52345197c88.2.2026.09.08.17.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 17:23:42 -0700 (PDT)
Message-ID: <6aa0a70e.8e75e0cb.3a5f1c.baa5@mx.google.com>
Date: Tue, 08 Sep 2026 17:23:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5763023196036185069=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, radek@podgorny.cz
Subject: RE: Bluetooth: dial the address the peer is actually on air with
In-Reply-To: <20260909-for-upstream-le-connect-on-air-addr-v3-1-0e49c4e7abc2@podgorny.cz>
References: <20260909-for-upstream-le-connect-on-air-addr-v3-1-0e49c4e7abc2@podgorny.cz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5763023196036185069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1160889/

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.53 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      25.45 seconds
CheckAllWarning               PASS      27.91 seconds
CheckSparse                   PASS      26.74 seconds
BuildKernel32                 PASS      24.55 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      459.84 seconds
TestRunner_l2cap-tester       PASS      65.99 seconds
TestRunner_iso-tester         PASS      110.99 seconds
TestRunner_bnep-tester        PASS      18.95 seconds
TestRunner_mgmt-tester        FAIL      223.71 seconds
TestRunner_rfcomm-tester      PASS      26.23 seconds
TestRunner_sco-tester         PASS      32.16 seconds
TestRunner_ioctl-tester       PASS      26.27 seconds
TestRunner_mesh-tester        FAIL      25.89 seconds
TestRunner_smp-tester         PASS      24.07 seconds
TestRunner_userchan-tester    PASS      19.56 seconds
TestRunner_6lowpan-tester     PASS      23.07 seconds
IncrementalBuild              PASS      26.07 seconds

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
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.249 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.159 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds


https://github.com/bluez/bluetooth-next/pull/726

---
Regards,
Linux Bluetooth


--===============5763023196036185069==--
