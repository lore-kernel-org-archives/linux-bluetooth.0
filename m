Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3521CC50
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584022; cv=none; b=bXYyQpJA+ClZNtucdEvcC9j984X4BSUEAc62YxjqsIxUcX5AhEp1cod1RC3qjv4BoKVxPfSWkqowSrxLb1K1AxZqOqpANLKCsO4qq31QliOKun0700JzG3JPhGn7hLyWzmRKbHseTNqLOlVDAseobxESa0BvCmZ7aAvn3XIphDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584022; c=relaxed/simple;
	bh=YcZNGFfgmFzxcQSG7lbnfoZpO9nd/Qj3aNJqwkR0/Ug=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OmY3DLZZLLTCBsnmQkwiFH//U/90nM630Az3ZUcO9Wmj2hr0TsZW2wgtkDbXqcpwYFrlCxL/9uvUcVovQClws65sCeNYVRZolVbPAHs17CAQiQfvj+DcFrfJEKrA3GEJXJTfkofvLlPgiTRXqucGOcicnjCMOLPSj27/j++Ww4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFCBfEk5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFCBfEk5"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220e989edb6so192245865ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 07:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740584020; x=1741188820; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aaotXswYLMdEqUzmKPoAAcQ6xcb3qD763aslmX2+uho=;
        b=kFCBfEk5+ZwNfZQEk84r4WctZm1UVNagPAmrFITcqos1Ck7hXtg9oiTnCgyakqT7Pu
         B21WLGqOn0xNSGQVzzigHvPvfX9mdzwimgp9yVhY9dIlrXKh5gBAi0nVaQ2kg3yDnXef
         aJJyyUe4tyvgowV7cscye2GxMSlW65d5In+8SA44eThquAWkxYbKhtUBKHj30EHF26k3
         nG55knfX47DAOQtSYrF3jnmKCUKFe/8+gWrNz//b6dJr73qF40m00qGn81ZH+I6+YqMV
         aXAmFLdfPs5OcoVxh6S1Qjt4T8ncQ05SBADMgYrBoNt1Jskk0p3CHNViFlO67spZPwgZ
         Y+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584020; x=1741188820;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaotXswYLMdEqUzmKPoAAcQ6xcb3qD763aslmX2+uho=;
        b=rCBWNs7DHmmmfv7KXd44ywspMNPNnE/TqmaJkkMMSz2riKZTPlbsMFGfZdiIJHfw5H
         iCvNqbBH0ty/WisUaweGRxSKA/en9wgjvdiBP720sb5P6HZ6r3cfvOq+s7/Wh2YWWZnC
         ATHA4Is1WCgHQyI7GFSgi16bh8OyK3QMeWAE+3tMJOTkZ5Nii/Bi93vc0XDO1fNbbf/P
         cKgpUpmEXFt6+dAvdc7A8RE6cp1rVXQul9ceSTqaV3X8+iGVqw3uqKxf7DCE8StRwdqS
         1jHKpoArifU6pSYC69UXTJm4DdJXK43J3QnCPZ8AaDf0JzHgLJJxWeUuTI3bQOw1dAGT
         gyRw==
X-Gm-Message-State: AOJu0YyV/so1v0emrxr4JPs0/EEElkB8aVz6dveTkayEchtOJMJFFC6g
	1rvJ1iNWRaeq9bBTY1ZM8ch4zrZs/cNI9BFq6H43k/3JqPxWjn/wDbKH2A==
X-Gm-Gg: ASbGncshpk7Hn2yekIYty0Og80pk3TTYQPW/6pL4X0MXWQIMlly6seIxXvlIAEciDr6
	XjApapXMGWl9uQTcdUaIryqKf1gtraBdvAhYw77m0LJlUgte7OaOuvFIP+uGivq+XaG7mE2mUdP
	2508jrKGluWd6nF1+C7jP2i4yGPDVpZy26RL52hRxdywpG3TIpUNl4uCqtZGXhneGkzvsOtUrD4
	qZjx+/7bI5wTsUcsPJpxLynwO58L7bN6667fTkEGa1ymSRKWnLD6DHeACkraSTv0nX0G6WWOGVu
	Clwry9xmFK3dZYe1sjqLIX90eGge1jc=
X-Google-Smtp-Source: AGHT+IHWgTbbN8QdYbXsG/mMTj8E3yelmu+ROD/+nRNmkpI6WXz8UtIWRbvqITZNK9CB/0+cX8u8Ww==
X-Received: by 2002:a05:6a00:3903:b0:725:cfd0:dffa with SMTP id d2e1a72fcca58-734790a7df1mr10798442b3a.5.1740584019779;
        Wed, 26 Feb 2025 07:33:39 -0800 (PST)
Received: from [172.17.0.2] ([52.155.59.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a839d96sm3727587b3a.171.2025.02.26.07.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:33:39 -0800 (PST)
Message-ID: <67bf3453.a70a0220.868d.2e0c@mx.google.com>
Date: Wed, 26 Feb 2025 07:33:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0543486145029993576=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@linaro.org
Subject: RE: [1/2] Bluetooth: btnxpuart: Add VIN regulator support
In-Reply-To: <20250226150553.1015106-1-loic.poulain@linaro.org>
References: <20250226150553.1015106-1-loic.poulain@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0543486145029993576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=938097

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 FAIL      0.39 seconds
BuildKernel                   PASS      24.14 seconds
CheckAllWarning               PASS      26.55 seconds
CheckSparse                   PASS      29.95 seconds
BuildKernel32                 PASS      23.90 seconds
TestRunnerSetup               PASS      425.98 seconds
TestRunner_l2cap-tester       PASS      20.87 seconds
TestRunner_iso-tester         PASS      35.61 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      120.85 seconds
TestRunner_rfcomm-tester      PASS      7.88 seconds
TestRunner_sco-tester         PASS      9.53 seconds
TestRunner_ioctl-tester       PASS      8.21 seconds
TestRunner_mesh-tester        FAIL      6.23 seconds
TestRunner_smp-tester         PASS      7.15 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PENDING   0.74 seconds

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
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.182 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.161 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 67 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.127 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0543486145029993576==--
