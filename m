Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E9E3FFACC
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736171; cv=none; b=ohPxhWHxwFwB0hNiCtTB95RqN7SkbF8Gg7Ky/fm/uNCJet/za8Wn6Culi4ONjs7X1PEuwaZ1+P5IV5nKVem/Mj4MFT+3hYLUMKOVMnAgtcX1bmjEhGu8J26ACxJsouEL2JpRgL0/K57wQcB//HWIvq44LgyIgTEeguoGvqVyd50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736171; c=relaxed/simple;
	bh=NBCAFH8F/GYZGa8C5fnaEsdOolqeE10rB6PoWDthNDk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZGIqTDmivxBuvvov5olymkx+MstZx4g/9pa7sLT7siIpHw97tEUkJbobFJHPVOcP7/kbD/SH1Rzykef+E0Zn0clIsrH53x8QYsjbG1fmt4hs+Wov7rlRs4TFubqtaqQFi8C8zZCSltbCqk2+yUsRnrwsXStlBMKakkMgaXZgXxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5r0WZn7; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5r0WZn7"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37fb434c547so1293867a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 05:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782736170; x=1783340970; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G7qt4d0zyVmZxBQcfgCVKCFWMx/Dgtlkys9NrESjm3U=;
        b=C5r0WZn7LtJs6YwELB2WVy9SawBPppgpkralRfSS7qdCnWBUwdMvMtVXIxEKYrqaZ+
         MlIzXFcB/vf6gOp9sKKARj0+dcGezKroP3jzGQjT4RtXPt2FXwOxX5mTHpUmKGpH4GYf
         jRQSM4vUYEaNLqgC12PhzZYfMb7hL61pqUnJK1CTaVDj2PgPKS9+nWX3v9hdXCkqveuv
         tzpF9MfrY9eiTgzBlg39rX5NfOC7/RNz1SgGg8m/AkJ9jTQTu141Y3yguhFYlG881gZG
         P9ARd0yKpQXHc0RKUV38KTDXT5IzgtcEdI5ZZ5qTiSl8WRemyUd6uY29K8U8NmZjDL+A
         vakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736170; x=1783340970;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7qt4d0zyVmZxBQcfgCVKCFWMx/Dgtlkys9NrESjm3U=;
        b=PZOHji6QCZ2m7AE0NhYFcQwmkMRgSnPJCo6tsLVwgDbVcyi3v8l9f5n7p2fUbZvXRm
         WYuJ8cGsxQavipWImitvIdFWvWt9awhtIvA95Ty+HlOk1QGTRWt1JXY8ueI7PnYukwnI
         y1egPToHJWgERdbzlX0X8f2eur6tXMSOkZ+bDz388IklfZoeJgiL2d1aE4Ye22QZ9lOw
         VQHrZ93rAW04C4DF6pLxi4F1ESRtUQbLA8JwGasBDJKeCiCRl2qabuUXZXF/rxj1hzac
         Kd8Iw2S/vXhk6hndlhtXqSCblVc/GpIw+OXXoX/2l4twJ2sAL+y1ZW1imFHYrzDFaj3d
         8mYA==
X-Gm-Message-State: AOJu0YwAA60DZCszOrGcdnbVO1ExM9Gio9Owee4zQ4hFcnJTVn8oDU24
	ge+vGQc3Wb5enceC9lDeVJw075NgLmUaKOeRU3Ir9YWSEjd3npb79uDyjSh1JQ==
X-Gm-Gg: AfdE7cmhPTX0wEtR3p6HCFOoMwEYiAN2k9EHfMcC4LI+hkBzDiP1FrbD9JJMOjH5IbS
	yYvZRz1euEW/kZbuGV89BXnbgcR9v6shpaelkqRNqHzm12pcVvYUlsSOqAHOqy68C2eZw1m/umq
	5QZzcR33fnqJf1jKWmUO+anaMbtWYd9CbSFrFJVORZcowq73Ix/04HiDJKkmmymK+VDAtLOSKxV
	28dI3h/gmABW0pj8SuihKnyFxjybN+cDE+kjG7ZVI+nfV9U0H+fw0Jsb0FX25Mm5Z1darkaEJ1A
	C1xYqlWGmu1YggUBQTEwy70DFmwgrrOxXAvYPRiQi+lvryWlM5BR6b4XcpnF4g+POByTqpzgdIB
	dLrHmP8XlR6iRzUHJGxofbfd/v90lQ7oRtTpknF0jEs7hcP8oZlVt8WbCeUtt5HSxeFugH4eGIN
	6GHfoNjLL+kiAG2q/xAA==
X-Received: by 2002:a17:90b:1a8b:b0:37f:133a:3e01 with SMTP id 98e67ed59e1d1-37f133a3f91mr8975715a91.4.1782736169932;
        Mon, 29 Jun 2026 05:29:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.3.221.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e228a1d19sm5756827a91.14.2026.06.29.05.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:29:29 -0700 (PDT)
Message-ID: <6a426529.ab1c8a22.3c84b0.dd44@mx.google.com>
Date: Mon, 29 Jun 2026 05:29:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4248795822768191268=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ghwns6743@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_disconn_ind
In-Reply-To: <20260629110515.29689-1-ghwns6743@gmail.com>
References: <20260629110515.29689-1-ghwns6743@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4248795822768191268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1118122

---Test result---

Test Summary:
CheckPatch                    PASS      1.22 seconds
VerifyFixes                   PASS      0.24 seconds
VerifySignedoff               PASS      0.30 seconds
GitLint                       PASS      0.63 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      27.16 seconds
CheckAllWarning               PASS      29.56 seconds
CheckSparse                   PASS      28.40 seconds
BuildKernel32                 PASS      26.30 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      497.73 seconds
TestRunner_l2cap-tester       PASS      59.17 seconds
TestRunner_iso-tester         PASS      76.47 seconds
TestRunner_bnep-tester        PASS      18.99 seconds
TestRunner_mgmt-tester        FAIL      209.55 seconds
TestRunner_rfcomm-tester      PASS      25.52 seconds
TestRunner_sco-tester         PASS      32.27 seconds
TestRunner_ioctl-tester       PASS      26.32 seconds
TestRunner_mesh-tester        FAIL      25.97 seconds
TestRunner_smp-tester         PASS      23.04 seconds
TestRunner_userchan-tester    PASS      19.91 seconds
TestRunner_6lowpan-tester     PASS      22.71 seconds
IncrementalBuild              PASS      25.67 seconds

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
Total: 494, Passed: 487 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.232 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.348 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.388 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.655 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/367

---
Regards,
Linux Bluetooth


--===============4248795822768191268==--
