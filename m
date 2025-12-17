Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3496E33EAE7
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973210; cv=none; b=mBQcw2QPhWfW1YchUkbD3BR6UgTGhozRcdsdRItUESA6dBHawu8Uj6SwVk6iwv3lFjAzcEPofiCFQVoRKLHCo/20ALK6wgfsMNMtL0hi3dmEMDjJWG6MTgSIDamNrH6UVWBV0SWrv2vHMva/2BykityG11w6hdD/djl+kf7xWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973210; c=relaxed/simple;
	bh=TvHAQuvRK+5P6VWrV/ydFVCr6u0m470KlRsJaAr3ZfQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JDFm8eD0CwcePFJReNjxzWvRfG7sn68DCT9Oi212aMU2jPISFRGmVQKrFCWsXRp86zPoUIcbx/vd5w8dxbjlZfB8HpdFVOkRJNYzna35IWHH7NNcoz+m+tQKk2cG2t8pCCerKqSGm19KAM0KAzodWoEaWDHD/7EUbSZ8QWhulpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5WJW3bH; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5WJW3bH"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0b4320665so51159775ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 04:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765973204; x=1766578004; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5HbZfO3Sm/G38cQpUABRqcyh6Ve0/9/513+3tPAdnyA=;
        b=C5WJW3bH3i5Rbj4g2W2v1X8QcpZmp7Hvmc7OfL/TOsnJtak3EnQ/BUQbu+ymqiD80r
         DJu4nOBzaTrZjDxxy4ry9gNfzP/TD5Spio0h8+22NN1br/bLgA2EDFYNarURystnKj9f
         S/gcvjEA7TAifa74yYJZLWwEbXNrLxci+00tBaq0GcnRlz1CsBbV9/kfTCc6CSDyUuuX
         pK+guq9MikIs7DaIbIBLyaSPd0YNNiXTsYXj7G+pOeMpTU4JoETiQaJZCxMJflo4QaAA
         ImJr4zV651hUqCNLrD3h6xZtbJRk4dpo5asKt98jSGsBaMojy3jF/SwsY5kgWyzOzZpi
         NMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765973204; x=1766578004;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HbZfO3Sm/G38cQpUABRqcyh6Ve0/9/513+3tPAdnyA=;
        b=a9K3ARmJiIAsqwe4469XM0r8h0ZVaHWW8iXEq7xzVHQJtwn/EctWQHjz24fIevH2z7
         LdzvpJUb5VGAuv8YNK4npi9SPZGbZ3CLXmuV3ZcSwz/dpW1iFwOtkPV484XUYHxsspUk
         RO/4dT3lMpW6/lZQak65GKJuGfZdaEGX6188JR2y+M+gwoUrzFAu037+eBgnzoCJS+gk
         oNJTe9N3BKMEIDw2t5N83Oi1D+BzN9W2W4xYGibGPvhMSwzESunRHvunG8mRXqfZYdkk
         xpE2CRL/9CRvg2Dh0mEoSgA/TUw2UfOmCs0vbXiqvcPPoOiFzXsoUshVJ816LX3xqEiD
         AA7A==
X-Gm-Message-State: AOJu0YyQj8tDtC7XSoRpt8HAbbt1VQwFGFSbmyH1G3b+vy8PamtxySCf
	APtcX3EuYIbFgA0H6H5Q6A+tGg5uADd9K3pHUInrk/cTahl27ZmqhsHLyebH6fnz
X-Gm-Gg: AY/fxX7vAxJ+GbBToMIpd0hHaK6+qkYa/JVnh2M5xQDkhv+aSKqyqQBgiArUhFWNuGh
	RlrcU2cxm7sr/33u8f0vHfzKecGr3Rvaz3KMO9wxULnMMSk4tLC6dWStA429XneAQBAvDPYdreR
	sQhtPIcHNCwgTxh9LjZcvdjwwir+ZHta8U5yfPrysR8mMLyO+WMPRyR/gR+wWDSDR0fBRxIAdUc
	W06iDwfPnL+cd7sq/XF3lQqxneFKPB/AX2pNLrjVgCqwNzMwXMr6bhhbr55UrnBsPVLQqE7Mq9e
	PL/mmq/lFZQb+DzSR4X8BJ2i9F2ZyZJF4ex8FbYDEDIWtV8UwHFxzcKzFxbpZVMYD0mQJjBVFlI
	ugLIzWrWRtZjeZ9/mmBsGBicAp7X04nruYEXX7zVmwI9Ijp502k58wwluufnOt47Oy93f7bfV0e
	exDR7mpKUKqKnM/LHI0Q==
X-Google-Smtp-Source: AGHT+IHlljZ9Q+mpKvb+VepwyYdbNqNRaUUGHH1nobGdjcWjdQup9lsAdtsh+kf6dJNH5WtYFdkHZw==
X-Received: by 2002:a05:701b:2908:b0:119:e56c:18b7 with SMTP id a92af1059eb24-11f34c1bb1cmr8185017c88.31.1765973204142;
        Wed, 17 Dec 2025 04:06:44 -0800 (PST)
Received: from [172.17.0.2] ([20.168.107.212])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30497fsm62255570c88.15.2025.12.17.04.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:06:43 -0800 (PST)
Message-ID: <69429cd3.050a0220.2dd6a8.18f0@mx.google.com>
Date: Wed, 17 Dec 2025 04:06:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4188012666161677378=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: [v2] Bluetooth: hci_sync: Add LE Channel Sounding HCI Command/event structures
In-Reply-To: <20251217112523.2671279-1-naga.akella@oss.qualcomm.com>
References: <20251217112523.2671279-1-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4188012666161677378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1034169

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.91 seconds
CheckAllWarning               PASS      34.31 seconds
CheckSparse                   PASS      37.11 seconds
BuildKernel32                 PASS      30.57 seconds
TestRunnerSetup               PASS      670.42 seconds
TestRunner_l2cap-tester       PASS      33.86 seconds
TestRunner_iso-tester         PASS      127.99 seconds
TestRunner_bnep-tester        PASS      8.04 seconds
TestRunner_mgmt-tester        FAIL      144.71 seconds
TestRunner_rfcomm-tester      PASS      13.25 seconds
TestRunner_sco-tester         FAIL      18.44 seconds
TestRunner_ioctl-tester       PASS      13.32 seconds
TestRunner_mesh-tester        FAIL      13.68 seconds
TestRunner_smp-tester         PASS      11.20 seconds
TestRunner_userchan-tester    PASS      8.92 seconds
IncrementalBuild              PENDING   1.13 seconds

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
Total: 494, Passed: 486 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.153 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.271 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.272 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.214 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.849 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4188012666161677378==--
