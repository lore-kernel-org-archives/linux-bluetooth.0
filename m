Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FFB165EFC
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229394; cv=none; b=oGWY1LcfHcz5OtA3v2lb2R6VAaFkUTdhqNyfAr6frpb5lR7tBFVEKIY9G5awp5Eacq9obXUbq3ZiA8DixgCMoezJDL6QXM5Wq3BpPb+W8YaExyv71WByrlqIzu9vy4Hpgh4p7NuXtKrghx7Or5Fsw7hKsHutUjQ8Kju+aXBXwzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229394; c=relaxed/simple;
	bh=eMe0Dp0umLuZ+AlyGV1LO2B1qHUjGN8iHR8AGg38Ckk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EOw7jK2R0jkvXw8P2T/6zkdshRLCDvHySMLn6BA4pn0qJCrot2z29BoB0d40s65VY6YLdukMi6ynmiO8tFOQxyWI4PFJtd0gYCY3gtJw7AYHYTGrX4JaBwqhenwYLhF7/cZX9/l5iF1iDqDwf9/Hz1suoembflfiQyLZSb1BgcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcKmwBza; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcKmwBza"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225df540edcso58462405ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 09:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742229392; x=1742834192; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I0mNdkTCeh5L5TkegKP1dF65xkWn3ljCDYz/EKp0SUI=;
        b=DcKmwBza6gEwHU+r63/2YHuNAOyVUwF9y4hRkvSUkCTLJmDJhPuTB7Ku4yR6Kaa7TA
         Eqe6VtDt1jTRf7rrFqLqLxVK+8DO+piXYOz2nu8gGdRhHhQih6mE94kD8KlruKNXtB43
         84VFyXRW8RutrgFDUQncDEbGwIL/Fc4Mmyti5dSXiQPHGdnemLJ15kDV3yubaienHvhp
         FStUAxbYDPMOlZCqxdd1ms+7p4k6g3/t0bbChaDIoJRwtZ3iXuodifvZZdhOctFGCMTI
         VM0fMu/UTfjDp9UmpPuESebAj5A2CqyrEe3IbGBef6Ndf2Wad/T0G0Szy/in7nqqjO4J
         LzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229392; x=1742834192;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0mNdkTCeh5L5TkegKP1dF65xkWn3ljCDYz/EKp0SUI=;
        b=FAy6H0+hUz+35/Jd/LoK19/H7QX3IGF8zDEql+6e4jV0v/yPvqQTn3uNVGhdwDP/MM
         wsiXqVdurhALVA1z0VIVOVXm2MZhPfHvMVq+4KA6m/vFCg6PmOQO5m0jo83e20ULM9fz
         Qa0QM7qtYJn9fpK1c35VM7zlr6iLApBrNVa0nlrOeudA6r4x3Jw2ZlTz+vHoOQXG3tU7
         iZy2f+n1BhWdwPH5Z+XiYpnF836qCJTJMSZS8YIu7+E1KzBbiII3zokvSnWE5DEip9iP
         +n+ZfgK4NdeGLKCnsxbdY8WLk6ZyUbJR+dVUIWHtJGoMe1ard808q7rYyyQ6kptvBwRc
         06Qw==
X-Gm-Message-State: AOJu0YzWw7eulog86RJ7BGDkeT/QQHo0p3pmy7urDo64dJb8NfhW2+I6
	qTLP2b4cuafNCO0d1vTUTwxnR4OpSPwCz1eg/fZyYqkrRQ5/lseD0ag1Ew==
X-Gm-Gg: ASbGncsYzN53d46WYwD1IlhSRNQQ7vW/q4ysSKU0ytCSwetGhAF82hy/BEPQQm54tnm
	4U6gWecxL25ZIt6HyP5fvwWPmdLX7BmpBcwS+YSVFNapqkhXDFShXANnd9SIbNwjk7VbOGcauB+
	X/oWqYhQQ9jfm9F1dOFyZCwoUgaGBY2/WhSafOlnfOY0t4YElhMlw31zOwPQeBsmNoNkSR2MoB3
	HerRpQMFOZzpy82dhkH8czVRRgHMBfiqKtctX/1c8cF4auFtir5aHNC9ToWluRbow/IOZKBiM9j
	fNkRf2eitkLLpjP/PHEXc3s9L1R2xGuA3AhsRib8Qp6NHfqTxg==
X-Google-Smtp-Source: AGHT+IHRPOp+h8zN7arjXJ9xdT4cIV+Z5iFivhyE9duuNK0E00ws23vJdNZJS+QuWPU+A1pPHgy/EQ==
X-Received: by 2002:a05:6a00:10ce:b0:734:ded8:77aa with SMTP id d2e1a72fcca58-737577c6e8fmr149015b3a.9.1742229391985;
        Mon, 17 Mar 2025 09:36:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.14.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711529597sm7761380b3a.27.2025.03.17.09.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:36:31 -0700 (PDT)
Message-ID: <67d84f8f.620a0220.a1752.d102@mx.google.com>
Date: Mon, 17 Mar 2025 09:36:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3811128958223077560=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, guanwentao@uniontech.com
Subject: RE: Bluetooth: HCI: Add definition of hci_rp_remote_name_req_cancel
In-Reply-To: <20250317154715.15023-1-guanwentao@uniontech.com>
References: <20250317154715.15023-1-guanwentao@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3811128958223077560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=944728

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.25 seconds
CheckAllWarning               PASS      27.58 seconds
CheckSparse                   WARNING   30.98 seconds
BuildKernel32                 PASS      24.69 seconds
TestRunnerSetup               PASS      440.96 seconds
TestRunner_l2cap-tester       PASS      21.11 seconds
TestRunner_iso-tester         PASS      37.47 seconds
TestRunner_bnep-tester        PASS      4.98 seconds
TestRunner_mgmt-tester        FAIL      122.05 seconds
TestRunner_rfcomm-tester      PASS      7.91 seconds
TestRunner_sco-tester         PASS      12.39 seconds
TestRunner_ioctl-tester       PASS      8.20 seconds
TestRunner_mesh-tester        FAIL      6.30 seconds
TestRunner_smp-tester         PASS      7.19 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PENDING   1.02 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.186 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.154 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 35 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.112 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3811128958223077560==--
