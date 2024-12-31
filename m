Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D076EB7D
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Dec 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735630284; cv=none; b=XOFIdf+qRbePpUBQP8rORdV2MhFFXTN8rIgNnb+fPiZ4UJ5jYUDok1+re61KOFJJte2cvGIzWBTAQTwU/Y4HbGunOHHz9WcXcwXP6SOZPDtFZpZ6k+OkhD8XotKM1bJk4m37Za4vj7twkvjCbkzB97QMPJ2r1Gjk+Cr9TnoE+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735630284; c=relaxed/simple;
	bh=2NLbON3zKT8WMQ1NWf1I0p76iWPWLRB89nOcODzYvek=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a5AWLcz71kMV57VHu8HFkMdl0EL4AQ97bzKsvmK6ZnJXVhb8ea8pQBkQK8lcZ+p5vnvmdOL/peqeSlyYUu96CYA6uax3vz6mqqrV8/zxZe3MoJ1MvCmwcZngfOlMLk3h5GDQGJONtiNntFkjAfR78dHDbDDK9IY4eN9CwwVbaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FH64gRNG; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH64gRNG"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2efb17478adso12922962a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Dec 2024 23:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735630281; x=1736235081; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1gndwM4RPaUunLw1r/sUWAAnowG9aHBoTmUMpojsOn8=;
        b=FH64gRNGVo+bkPCkAbZJZ23Ga0ujeIr9yk2clNZqFIonwKMX6JZUnQpmISo9DP314p
         2V1HfAGrd9l4089AP6txnZvI1Sx4YElYqC+YVxwD2zxMfmv8/xm6OkBKt5m1BpnVQDaN
         F6uj8s01uUcG/wxfE5jm8gAd5649D5zEbQpMP4ShulN62wkwQ+60YZ5RYdBKLo7ebMYU
         k+IQiEcUgTulAx4yxHByqGCfs+GffURHynDMO8igUdbMOrf8PSJIuAOjpDpQytkFtbVl
         pXTjHwPmoRy0evJH3nWtF1VUXovrE+R2J/3Crte6q/mIKyIkmKhHs/rFE2QF6wR007o7
         /HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735630281; x=1736235081;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gndwM4RPaUunLw1r/sUWAAnowG9aHBoTmUMpojsOn8=;
        b=P0LssJSOjhhstO+JW4vmBiLFswsFp4innh6jv+7uZe+fWV9hZK2v7eDnq7iN46mPY8
         t44v3RtYq5R9Pnxaxl/GSAC1Eqec8tcdthLFqtdAKEncuD28LIon5Mmg82OEMSKEyH19
         wqHDaA5tc9Qb/Eq+RpoLLRV8rlU4PMvIOsCKxo995RbMi76RV1Tuy/Cx7wh8/epkzONG
         8SpgndVqCbxCJ6OqpIuX3T7J8G0z9osr/XbYBjdn1YvSgkjj0rsSpjkkEDDeRgr1LsoS
         VIhIACLyMvovlhMwoLCWjpAHSX9gNfXajfC3YchCfuLTOyLVuZlVJv86nVJ2PoO4eb/z
         FCsQ==
X-Gm-Message-State: AOJu0Yw7JoiuL4MPdpT4gvo8LPPfMPuqlsScmxMV5f14xcxJpZdqG9x9
	5b3X45UuIVgyu2T5x6n3fME7dFfjrnjBbe7Zcs/QHWyNKxy2E0uFfytF5A==
X-Gm-Gg: ASbGnctcPDz1C40yWxlMjj2F4fQCna50E9fUlbvlrV/hfoi2hkVY0G0Sos6hchw8ek2
	Sb5671rBC6J399mfe45Y5D2L+l1NXFYx3JN0qNjp/i6KG/sfDajIa/zEiYIPyoXnFEZbRKa/OCS
	a/fzbL1Z6SgmSGZnnUeTH5RJsy2xUxE56WvkQNMthWlIZ/7xk0oGR/X1rO7tzur5wR4uhxoZN3K
	wXdDM/oefp2BlEFuWSvZaymGu9IMmV6SdCaOn7FQgU8w/7MOXEY1f6z6d/kj2k=
X-Google-Smtp-Source: AGHT+IFgFe5SpkINCBFcgthTLqjnXW1DRF/ntr3P6E0V/M5WJhUQTRcy04h7r95VT/dGcbI8Co7IMQ==
X-Received: by 2002:a17:90b:6cb:b0:2ee:863e:9fff with SMTP id 98e67ed59e1d1-2f452e22560mr58541991a91.10.1735630281370;
        Mon, 30 Dec 2024 23:31:21 -0800 (PST)
Received: from [172.17.0.2] ([52.225.76.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62b30asm24034070a91.12.2024.12.30.23.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 23:31:21 -0800 (PST)
Message-ID: <67739dc9.170a0220.1205d5.cf5b@mx.google.com>
Date: Mon, 30 Dec 2024 23:31:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2308021612762084486=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: Bluetooth: btrtl: check for NULL in btrtl_setup_realtek()
In-Reply-To: <20241231065719.4840-1-max.chou@realtek.com>
References: <20241231065719.4840-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2308021612762084486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=921519

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.43 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.78 seconds
CheckAllWarning               PASS      27.93 seconds
CheckSparse                   PASS      31.26 seconds
BuildKernel32                 PASS      25.25 seconds
TestRunnerSetup               PASS      445.05 seconds
TestRunner_l2cap-tester       PASS      20.67 seconds
TestRunner_iso-tester         PASS      36.51 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        FAIL      126.21 seconds
TestRunner_rfcomm-tester      PASS      7.63 seconds
TestRunner_sco-tester         PASS      9.47 seconds
TestRunner_ioctl-tester       PASS      9.00 seconds
TestRunner_mesh-tester        FAIL      6.30 seconds
TestRunner_smp-tester         PASS      7.10 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PENDING   1.01 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.168 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.165 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76c/0x7d0
WARNING: CPU: 0 PID: 65 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.116 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2308021612762084486==--
