Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15D3921DC
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549832; cv=none; b=JWxEcy+suNyyPZb+UU9w0HifrUm16agFYH1/48vwh1jD0UQk6cuqTyJ7rt8TxEUOUeMVhSkAuQu/ZxawpM1wH82ERQmZrJlWhRbJFBy37paHfSZZCxyMnEEzi87hlB9RIU7TcrTZmDP1vFMrfnOPREYIzJ+f+1edwrZUPlxO71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549832; c=relaxed/simple;
	bh=DhpWPIePWOrHb4FubrAOxOjnF3dJoy0GsEyAWBlpwk8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Fmm0iRkwO5LwXl/p2Bhl6OMBzxi4p//vZWY/v4LJDrzyazQ/Cd7l0UyVK57viLZeN2YCYPvGWrl4i9MeLGGCLRigBqG+a480l2sctHDZxzCmWWxODuvqG14/QPEsUbS49nnMXJD+0PalThDvYAhos++gCeEm308AH+9rRrHgzf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYfLSnTs; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYfLSnTs"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so11952313eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 01:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775549830; x=1776154630; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q7+pKJ3zJkmlmoW+YRWJCUJw9U6UXDctuCju9lXTh60=;
        b=XYfLSnTsvfm8LJiHxhXCrLsSOHlGhHrfqQubl0Y0oVHXTzVtLDWoCvcm0+kQLUdR1d
         /fXB2XjGIeGnYdb2+4K2FfchCLG+cS+iROfaAEi821jho6zOH5IhHxsQpZU3R6G0DBhk
         G8f4i3srIaMtHDSxRflPu800d71ScxBNrKC/qbwinnIbrX+qnL0joyHGyccW4PrTc+Fk
         rNJtuNjDUPG6+MW4HisUmrONmUuQjg0g3OCjoj2C9d9otPE9sqzoj1Sx9W8wd6fhkDq1
         H5B2k/Vg8eTCXAaBjQHrmUDxh+1V9SZy7vH2eF0OrlDe4/PkPArmxjU9LoBxoFymj3mJ
         zlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775549830; x=1776154630;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7+pKJ3zJkmlmoW+YRWJCUJw9U6UXDctuCju9lXTh60=;
        b=cXaV1Byo2BPknwZI3KC2Itj2zpTJg2mREYPAzYFbGH0YgGreWX/7Gxq4SN5s989f6r
         gCEGRYxBj0DJfz+TbUIotyvrY+l3pb340FiR7yKuFhbEcgeaHA9aSexbw2zyapsrF+by
         bx6YRWlu0r/vH2/LbmRtKaxWwDLlQICfzsRqAqCJRjyOj1WDYjFH+2AUXX0cs+AnRp0t
         txclDL+d7x7wKrMHVo/N8IQNpYdXO50zVXYUnv/oZQutm7qdAY8I/tDjWK/vFaI2UGsN
         wHEPcYY0B2GzIInkPmse56hKmC0QSmRnhYpl6Uk27vQuc+srlDDiKmDJX9pYOGJmP2BO
         9pVQ==
X-Gm-Message-State: AOJu0Yz9uc8jZW3JsrdTJANIZqM7JZCVm+l8fmloDKOl4+nI4tLkPYJH
	6MvmEnC3r3BsE5w8zEeJ8xZkcfGRFPB/AgYHMNDypCLQpnCtzaAilgLVVaExFw==
X-Gm-Gg: AeBDies4Z9Ldt/4OcqdIaphmKQ+2SppRkI/SNcPdeoINzB5za6z9bGvziDrjCcpKUCI
	3UotkX32TfdzWtmBbZrXassYd1nBkqtV86J2+LdEkJbMAvmIGd0/aeGLNg31zdUeZuPk1ZQ6dHR
	GgKqAMUfcefS1Pg568Nirb1UqRMgEPteNyzEcpxz44jz+ZHQ6vL372geZQ3tx0zqulYKQe4mptt
	krqqkY++CgUhjwJVwccTWEO9Zp5rT2CGdGv+Ep5s9+aNZ7QNGaZ9W99zM86j5vjXNeQ0OS101If
	aodReS3CKr0svjCvKOkde5AuEjr4NHLC4qmyKKWySdLLR7OfCFzP6asZYlSuaT6sdQgi55Tn8PV
	hzHjo9RzM7mtlTKDntk7o7FFQRNd55ElpgkmauZV25G5Vzc6i2OBANsWr3B+Mmm+xwOnF+g1BOY
	TE6ehZrybxapOEsVPEWUgQr3nch4+j
X-Received: by 2002:a05:693c:3005:b0:2c9:1943:e7ff with SMTP id 5a478bee46e88-2cbfa5bd848mr8169537eec.10.1775549829859;
        Tue, 07 Apr 2026 01:17:09 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.226.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df8942sm20073147eec.2.2026.04.07.01.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:17:09 -0700 (PDT)
Message-ID: <69d4bd85.050a0220.ccc59.534e@mx.google.com>
Date: Tue, 07 Apr 2026 01:17:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3347602623781579019=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [RESEND,v1] Bluetooth: btusb: MT7922: Add VID/PID 0e8d/223c
In-Reply-To: <20260407065053.3037036-1-chris.lu@mediatek.com>
References: <20260407065053.3037036-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3347602623781579019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077968

---Test result---

Test Summary:
CheckPatch                    PENDING   0.54 seconds
GitLint                       PENDING   0.39 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.57 seconds
CheckAllWarning               PASS      31.12 seconds
CheckSparse                   PASS      27.23 seconds
BuildKernel32                 PASS      24.98 seconds
TestRunnerSetup               PASS      561.92 seconds
TestRunner_l2cap-tester       PASS      27.54 seconds
TestRunner_iso-tester         PASS      37.27 seconds
TestRunner_bnep-tester        PASS      6.20 seconds
TestRunner_mgmt-tester        FAIL      112.89 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.36 seconds
TestRunner_ioctl-tester       PASS      10.08 seconds
TestRunner_mesh-tester        FAIL      11.55 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   0.58 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.110 seconds
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
Mesh - Send cancel - 1                               Timed out    1.833 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3347602623781579019==--
