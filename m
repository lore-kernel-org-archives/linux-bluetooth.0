Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8819992C
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540236; cv=none; b=Q7o/zfa18/j4EqxwprA9kFUnwGmPWamkthzb2ZssnDTBcdOjgp5LWIVZfynZFmrErBbLo/Ngpt34e8Im3jVniloBTN2HDcL6uzMirUtNflq7bUsecte8dimPxh2unhRIMsgi6Cdem1eYOyNIkRpxSMmsFW/wjpS0FU2B1bNYsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540236; c=relaxed/simple;
	bh=7r+pjLSZ4XGhaDaDdnxYMzQ9bECNBwOt9n8hkclbMv4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ocdkHymPNeBrn4ukNv6UiVgSF7+sj8ep90s4wS04AT9oKko7Rw2TpUN3DHcgR5ip8Vk1UOfTkGBVTMPzMCv2wbr5SbKfrLceKR/g658DnZTId33jRMSOz7yN6C1SfVQux9GhNvdluFyOA+NSHnemcBudkLofderja2JRCKtijNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MduurPAk; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MduurPAk"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4138136f02eso623028fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Mar 2026 04:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772540233; x=1773145033; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1Eg3vDFveVHthHrsFCM5E2Yv27F2vWZfbJcgCCnfl+4=;
        b=MduurPAkUuMw4P5xujLoV5WjhWMBSbtDd01hvYVubGqGVeUSZdbkEW+ivayRLKJk8L
         6uSHhK8sW1EKxqgbkWN4Un/ftVKQk81Zwhidfi4pIKN9hYjZ76tG7vBmmkFMNw/9HU9V
         i6WzkZ9hJ+ITjsLDIwSO+fUYGSgwoTgIYtcJcjbtMbxZl28iAEMW5m5AoJ79fRuoHDbQ
         W2jLHYfwhPn05EU9JfyORZ9QSSoynIVjf898TO6uvdiPDZk/2F5xB1lfT3vgFHwX/S5G
         219n0WifYeI89gQhLcHzQfyQ3hhGPBIbZ+N0mY6YBJ2BeTqfK8O58ANoWwdPUjqZ18nv
         ah9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772540233; x=1773145033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Eg3vDFveVHthHrsFCM5E2Yv27F2vWZfbJcgCCnfl+4=;
        b=kQYLYXRTUlliaQ+iCvpFrNmQXT2DLwsw5f+yUwQ84TQGm3cFBwJABtxUuUly5aceeF
         D3sI/7C5HZohfWI3OcP0Z2VAdyRU1XBJQ9MV6/DWCIwllGbus6TE7fCzNnj0K/Fh+TFr
         n3bDT4O/pOcFEyUgQfSifFvEHT9C6tHd7NHmXD+tE6WWwYVtSoFW4cbdxkQdFIoxmALH
         18+4yXJXvN+H9Jh6gaglsphNxAru4+2sEN7eGd2m2NBQzCma0wBRoJzysfNb0lg/N4zP
         26LmMnWFAX4/FNjjjLe3mWwrgR0j7pRrQWQYd/wFJiQGGTPbMz3I/+iQUoM0ePUNEJ2r
         v7SA==
X-Gm-Message-State: AOJu0Yz3a/wY3PfoBVTaNsFSntWhn2RomZOj7IFJ4+joH+uN605ZQeL0
	4zcwq+WpWqc+YM2wSYMC9fCdDtv3y+J0dL23bVVYizhFP9aMSbe4CRq8oQ9S6g==
X-Gm-Gg: ATEYQzxo93j2nH+bhccjTNlo7FVJL4u8fqf8BlLOrRtT/G1z01fOB5FKScUsAvN7VBW
	QoTVffwd09sgH5otAor+7AbVI8Wf6axn2O62x9/vz3+iFMfxniUQtBjtSfp8g70FfkyqoT5k5oG
	U5mnPu8KWWp++ErJyqcTvyXHx6zRsZDvPb/mWaKIlUueTKj+qSK71HOD9A0HYTA+khG4EC6075J
	7ik1zUohU+CV7aVgpMEOuSnFw9WVF4E9Src5GVKwh45ZufF6wa3HRdnezPyqrdQYxxoMe/+cHyB
	Pn5og7MsdBtrLX/KGMohJ+IYsZ01AWuRUWjemvMr+tkTvoMCS+RJktajNxEh2VrodBi93vyPy3P
	Jgk0NEvGY5IKUuurESfpsyLG7363EI2XSTe86t42B5//ZINLDSoNqnHL3zz4QMJN3ocT5djTqkY
	49iEH7XIe2UHYRYxLw0ymIHZ+4RqP/tg==
X-Received: by 2002:a05:6870:590:b0:409:5ade:7063 with SMTP id 586e51a60fabf-41626f9af45mr10124899fac.32.1772540233406;
        Tue, 03 Mar 2026 04:17:13 -0800 (PST)
Received: from [172.17.0.2] ([52.165.251.174])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d2cf00fsm14243881fac.20.2026.03.03.04.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 04:17:12 -0800 (PST)
Message-ID: <69a6d148.050a0220.126bb0.a983@mx.google.com>
Date: Tue, 03 Mar 2026 04:17:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0127810734534606638=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Align shared DMA memory to 128 bytes
In-Reply-To: <20260303120102.284396-1-kiran.k@intel.com>
References: <20260303120102.284396-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0127810734534606638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1060579

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.75 seconds
CheckAllWarning               PASS      29.25 seconds
CheckSparse                   PASS      33.32 seconds
BuildKernel32                 PASS      26.52 seconds
TestRunnerSetup               PASS      580.39 seconds
TestRunner_l2cap-tester       FAIL      32.61 seconds
TestRunner_iso-tester         PASS      94.50 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      116.42 seconds
TestRunner_rfcomm-tester      PASS      10.16 seconds
TestRunner_sco-tester         FAIL      14.92 seconds
TestRunner_ioctl-tester       PASS      10.55 seconds
TestRunner_mesh-tester        FAIL      12.45 seconds
TestRunner_smp-tester         PASS      8.86 seconds
TestRunner_userchan-tester    PASS      6.83 seconds
IncrementalBuild              PENDING   0.99 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 94 (97.9%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP LE Client - Read 32k Success                   Timed out    2.406 seconds
L2CAP LE Client - RX Timestamping 32k                Timed out    1.888 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.114 seconds
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
Mesh - Send cancel - 1                               Timed out    2.773 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0127810734534606638==--
