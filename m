Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F42F1FC9
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770151934; cv=none; b=WpH8HUf8M8O4F9d0u3bVKVaqGvcyF+N/ES7FvJOiB1Vh6oYrcYclPiYiifhfcP6JmFYD5M1lUm9i4/y/dcpHTx1j3NZDfV/we+jIJ/n5biKJTOHVYa7ZtllcPRuzi5rCTWoYa5bYHIEI6QJtcuqfGtCWA8A32inLaAtRXYB/c8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770151934; c=relaxed/simple;
	bh=ySAvKmpG5HigZAbwxI3dq1bAgR4OmJ8rm5k/OucOmyM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JPf3NLga6O0eg1U3CpB1kRkkMFw8Z1bv5FA/EJc/h1eQ7wXWEiIkR31ZNrQWqWrbbJeNVHG+e/qK6Y1lXDZgAoy2REKdj/LlSvTLiQxJXMQZ08gzd3WGawQlFX+jH5rDTZMMFBLqFgcqqvdnoDHwPyc8cj+J5f0NtG/AAjanz0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRnwW4vF; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRnwW4vF"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-502a407dabaso642551cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Feb 2026 12:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770151932; x=1770756732; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sDrHCl1B8KXvgCZMQrW9aOy7kjT/+s4yyMDiEyiDssk=;
        b=NRnwW4vFdbNCxQLUbUGmwaPYfPk74xvycQtOwfqtKluyMHrmiNKuIhMY6SUbqhxEq2
         2N/Dqt+8r8Tz+sgnVyyW7UamEA7050A3WS3pVUdemh56KhxtaSlMAppo+Fxxziwouu4G
         jOOndaN4G4JvUqFdFZynq/NkB8ZiuBWw03APAGzim5ft8Zf5T00sKXLUJ9i7XmKa859M
         dtDwL30hZiptlZbjo3C8zvUXIkb19qHvVHm35Rt57g5XUYAUx4eGikQkOsbPJCdZmuY1
         WiTIBoOQywFRZAEkbWT7Sgl5KdV61HTMLh5pRAkSzGTYxKi6qcYFWSKi6jdRbCvaTHgK
         UX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770151932; x=1770756732;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDrHCl1B8KXvgCZMQrW9aOy7kjT/+s4yyMDiEyiDssk=;
        b=jnvnSDw8Ic/DRfxPvz4sZKOjhOuAjY9jSlYP/9t2G7MLFdtoDqD2pHN64Dc8/SM5Ju
         UKZVtaxr95So2L08Q/E6PTq+OACuRR9p709C/L5uFUgLiXS4iNGSbnZ5AGfz0tKfEDEt
         P847PIYJ8/mYHuEF7c78AcnAF5B30tYsuNqokz6FpPo5UsbuFFY4z5I1QzuQkyajehmb
         qSOtTaT2ytheZrTfgCdMRq/UqX+YMUqa3wU9Cn1iu0rjxjxlUZIWIoX2QN4W2X4jUgvM
         3kKEniL6lUGIsCLxdpOa7uwRXc5zvAj3qVcaVKeA00rys4wEC822PveWUZbUFMYJWpmA
         mFKQ==
X-Gm-Message-State: AOJu0Yw3++pRHNGwiMWvDwwrCsr9+b3QDX/kf8TLbSydvb95RlCyRHFs
	Mls93EBvx2mHZRDUdmzL0LXmnM6+UBOqw7Wpk++vB6NqkV9mar2zQsc+1kGOaP5m
X-Gm-Gg: AZuq6aIiRV4XuQSfL92qzY+Re3zi/SnzDfyGvUAq/uKU4SOd5jmDjq0T8ToHt2VXcoC
	mzy/kVSWZ3iMgzJ52WLqIcunyNLzONGy11Tps/nlwu1qDHDW3wwuU+4VyKry3P2c8UyBlU3oQbC
	gdBXFx5/piZ/pPPIFHq7pJHYXwk1/1nTGibC5lAZnn3YUI4MmKannQDtFofiKWF/SdTIJyqH3Vz
	iz1Nhoufd09Ny+UPezfRoKamSGm0ECVZewL80rIk3Trb/Tybj9ZvgkvNn0RQoAAjonThrE2O/wG
	/VH+BlckNVB0kM9esDogPwQ49lLxIFDv9suuhhVOf40CYM9MoBFoWQj/1Y29zMmCAK3KBaYi4jU
	BsI65rb361lFjawpKrcok8lw7VlRWeTCrZyeZ5p+OUHRDYBl1KeZF0cgkbjlPGFQKdTQh/ftmWN
	AWlfRxHZEOm2BiR5FKNgaY1zeGQKzM
X-Received: by 2002:a05:622a:d6:b0:503:2f41:abaa with SMTP id d75a77b69052e-5061c1a0c79mr7508581cf.40.1770151931622;
        Tue, 03 Feb 2026 12:52:11 -0800 (PST)
Received: from [172.17.0.2] ([135.232.200.19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c147f42sm3750291cf.3.2026.02.03.12.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 12:52:11 -0800 (PST)
Message-ID: <69825ffb.c80a0220.944ed.2bfc@mx.google.com>
Date: Tue, 03 Feb 2026 12:52:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0087165303012071487=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_core: Rate limit the logging of invalid ISO handle
In-Reply-To: <a62daa4ff8e59ef01438d96484b45cc2273db1f3.1770146705.git.pav@iki.fi>
References: <a62daa4ff8e59ef01438d96484b45cc2273db1f3.1770146705.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0087165303012071487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1050469

---Test result---

Test Summary:
CheckPatch                    PENDING   0.52 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.01 seconds
CheckAllWarning               PASS      27.93 seconds
CheckSparse                   WARNING   31.37 seconds
BuildKernel32                 PASS      24.65 seconds
TestRunnerSetup               PASS      552.12 seconds
TestRunner_l2cap-tester       PASS      28.26 seconds
TestRunner_iso-tester         PASS      75.09 seconds
TestRunner_bnep-tester        PASS      6.27 seconds
TestRunner_mgmt-tester        FAIL      112.88 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         FAIL      14.43 seconds
TestRunner_ioctl-tester       PASS      10.06 seconds
TestRunner_mesh-tester        FAIL      11.71 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      6.53 seconds
IncrementalBuild              PENDING   0.69 seconds

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
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    1.857 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0087165303012071487==--
