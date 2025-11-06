Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5B276051
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762454635; cv=none; b=SBtpfExXamG0smfHCEY2omF7zrk6ERUuVXU2QSaqEpQ2UIoJvywREjiDj+1t8Qdd5dJu22JushcMwZ69APDE0zsT/RteBz2ybrNkvKJEnqEFIux9qnXJKzrvfFs0r0NaOPVRhCI3lGwA0ZaG1X8nlfwBkZXp8+6D2Gnmsk2xCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762454635; c=relaxed/simple;
	bh=U4tsrRzvEY2ilqdCSgKU7hrhbDA+lRMdVFQcpjlaOMQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=naQ2MzNbcssdrLIDer07yJTuflm5Owuu7h9hXeW/o2b8lWo7PQ+A+LAGVAiUQ0t1modRf6DHDu1TnWN6iq6ycojqrJEcGJnxzWwK7pyEH58/2Cr74gcWJq0/zW72S7ilFkEfFjxZ3qcv8uuuPExzo/bPe8wlCEESvP1uYn1j3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3D41yM9; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3D41yM9"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-88703c873d5so48983439f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 10:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762454629; x=1763059429; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VvKjktfLVAz7kVYGgl/LXigrKUE6b90nvgyGGglnh7k=;
        b=k3D41yM9j+evDxI3Dx5CvEta1lbh5rYUDpnRQpfjMb25ygR7MDlW8VgUZeOBtECP6W
         DKtH/iLyy0QEyKuS3rivNXAALRD0TfxxuIyDMyUGAL1rC2L/6CqOCH2eYWqR1ohIF3cK
         0rAP/Sh2ZslPJSg4R0Bjx6208FSEY4CKnQ6Bap7+qWmf/W300Dj9bLa5FNPv170VFuUO
         ns2737EGtPIDRsjHnYgcUAdP7XlaNT1kW4jbWWFbRVPvXmRJ3w4IwkJ+eRs1KYJ7iWSZ
         DbGCE672JYubDhX7Cow0r2gylJpKXQq5b6udyXVdjdxjgCuAaS9+R7WjJe78qwFh720g
         rNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762454629; x=1763059429;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvKjktfLVAz7kVYGgl/LXigrKUE6b90nvgyGGglnh7k=;
        b=s3dbTFPMW/hOs6HaaKykONSsr2/Pizc6pTvHPTq+mP4xLdRglbdgkv/pBiriLLUD21
         sWj8FdTvB91gba16QOU0wV4Eyjne1gbBmFfx/CEuW9v8vEG6NSuZunItX+akb7O+0eT8
         I5AzUCoQjWfI7dpChEQ2hFU5nyeYcMvPcCMGy84LlG5CNZpd6F2skgDeea8ryshkUHZl
         4VtHp8CgP/TvURNkuDpsPNc06M5Qhs6l6J45ULP2IDXir0ByYPe4YdBJSKiXlrH1DFOs
         rbq2iIvepbP2GeQzPRkOpoM2r91iZnCKheNx3oi+NeOCp6+qOOz54WGO0DCPaYISL6pe
         1d1g==
X-Gm-Message-State: AOJu0YxLh5MCLsVDNyD4KNp6TSsn3x9OZnDSmMskIe7CpyvUYDSdrog9
	F+i3k+DRxsqCRPm/zE1bqHA0L/aNN9E0hd+4df6ZnwKZzk8xTDCbPmfdv1GQlg==
X-Gm-Gg: ASbGnct65f9HC1DzH9zrL3b0/kWDNJIeRHAVHXeMQJ7njdmnMTS9t2KrCDDOUEVGAm1
	uTraetiAWqEEdFfIN3thSdCSVhLcnR8NmUo5OnDKtB2CVqffrAA+5XZl0wtekKRgfEAMfcp+qbY
	7N68HwSH/ZDtKDq2MYnBoggvXqBReZbrg5HTHTUPTl54DNYHrtaxFdi4i3xnCdVHnmjJs0b0LY/
	7E5hiLaf8ZQAX3tSL8uA4FJKzXOXJ9AlEaMS/r6ix8tULGuvqmGrgFmStoQ2kUgteOFShdbNHOT
	jacQFyPV9z799Y0FfH6/FVBbxuABncSRpCUBZ1Uwt/KGVJHq9a579A8pcAlKQyd+X3R2Y3CqLo8
	FIpAb7ZUAAenEVJrczD0h1IjadTtH7TFSPWrNX2FhhlcKBnzuKi1lq2XWGGPXPVsfPLoYekxz0p
	CZPguvEKGm
X-Google-Smtp-Source: AGHT+IG4/80CAXqxGI/RmOxFd0L4gYdld8yKR2+oNlZW/0GuMOsR04StzPXz5AvMjGPkfFcS2iunBQ==
X-Received: by 2002:a05:6e02:b2a:b0:430:aec5:9bd9 with SMTP id e9e14a558f8ab-4335f3a6b97mr7605275ab.5.1762454628930;
        Thu, 06 Nov 2025 10:43:48 -0800 (PST)
Received: from [172.17.0.2] ([135.232.177.116])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7467fced5sm1166289173.16.2025.11.06.10.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:43:48 -0800 (PST)
Message-ID: <690cec64.020a0220.4997d.2089@mx.google.com>
Date: Thu, 06 Nov 2025 10:43:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5789166241435781063=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ssrane_b23@ee.vjti.ac.in
Subject: RE: [v2,1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user
In-Reply-To: <20251106182016.26508-1-ssranevjti@gmail.com>
References: <20251106182016.26508-1-ssranevjti@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5789166241435781063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020593

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.44 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.66 seconds
CheckAllWarning               PASS      28.03 seconds
CheckSparse                   PASS      31.80 seconds
BuildKernel32                 PASS      25.17 seconds
TestRunnerSetup               PASS      501.49 seconds
TestRunner_l2cap-tester       PASS      23.83 seconds
TestRunner_iso-tester         PASS      78.32 seconds
TestRunner_bnep-tester        PASS      6.18 seconds
TestRunner_mgmt-tester        FAIL      113.92 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         PASS      14.31 seconds
TestRunner_ioctl-tester       PASS      9.92 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.43 seconds
TestRunner_userchan-tester    PASS      6.47 seconds
IncrementalBuild              PENDING   0.87 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.192 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.196 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.897 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5789166241435781063==--
