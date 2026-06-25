Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE127192B75
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402435; cv=none; b=bGBbZPGj/CGRGr4AwtYKwQlrzXAPx7vnUs1wxlPF0EGxtZysJJek/jjd4wgQSSlBXsSDHbltMAdVW8To/MClP23994W0xv9Ro616HMGSIqhTdy+2epP/eya0LpsH8ghB3DsiKQBSxu/RS/NHFAQ9oAtHY2BTYPlD5fcHRfDLFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402435; c=relaxed/simple;
	bh=y1tGCXfFrYiPwOfJId41dnxkkRPzB/YsWNfC61rN0k8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZInErjA9OvnQqkiL2ZwEB2kru72O6VXmORqZj5HRbt3vhtt7PVeaaL7wrk7BsKyxVraBtE1PR6s50DeMhTJ+S2xE2ATzsG5+ajp4xjXnLQItkwHfDV9GA+IqScwSonLEvJsNRBp6r/iqaNiKhNeuTv1TwljwgzImW/8DQkP5/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFbGmPWQ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFbGmPWQ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-519f758bd33so18577921cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 08:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782402433; x=1783007233; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QBymzey7IhlkaJkRh2S7qkBybbZSByeoITRDZQ1rLb0=;
        b=kFbGmPWQNjMG6EEc4zRtcoJMsihot3CHDHf8FWs1rrDTY9Wvedew0nqBDMWt1D562P
         ujzZmu4vdcmNn/KeikrOhF4IIqGH5hWVvQ3H3gg1fy6y2gRT6UzwMs8Y6p91aw0Iqh+x
         GiJzembo0ZWX+fhOU4d7vs9hp4QWKCNBirtA2ixUSPzjlCx0i8+Y1Micm8MISyjfgp3b
         G2CKZ5Uh6Y2jsvq8tiwb/r6EmC+tPRxuZ621D5n/xPDOsA7yIdaRm4szJrj5pwNodR7q
         /NVlWGYcInvqiXEhfF1bhZQQ7Glg3TJlv+SuHX0p8pI99Ha/L2aDG1TavXu9omU35PQA
         +L8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782402433; x=1783007233;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBymzey7IhlkaJkRh2S7qkBybbZSByeoITRDZQ1rLb0=;
        b=aZ02aHAySBy7rw4+qBqkOeB/ZxCwnLAAnKyaw/IrNiRZjMP8dVOX4X58doMklIMpZv
         uzHPilsciPJ00l31k50bqDPNoJLtp1V5RC4p4+uwNbzmyCG3jXCunveCcDK6fQnhR7bz
         QG+yDI6X1q3f+7kGkWOF6rbwFk92/5k43P5VVNxZDCtzREhsQ3oirKF143n1+dqxZlay
         8jQEAm+Lu9j9hXZPIWR6aHjqtjRS6R6xZAVcqUALjle+6yhgskdYbkhEgpNbqo5gYvE5
         9y0U8kFSFHAgLecY1KWjbJdWFRwJKthlr02tJdAUCG32Vc1YA5G6Me+bqcXivxH/GuGR
         urrw==
X-Gm-Message-State: AOJu0Yy/g0eZRp6kxybTpxObCNuNUKMhtctjJedF4ukLxEl+bge7nbCu
	4zPdwogHa2t3rTjy8LJbcG/hen0kT/83LWUZ/PaQHTWqKE+aOifZgT8Vgwo5+Npl
X-Gm-Gg: AfdE7clf7AwVTIYPPNW8j0xJ1M+VboSO/fKTynvkJJ66HLxMM6xEjS1tUyRGMsgQXIj
	agpqGqwKjcUO/DWhBmXByNwmbYwL8i9y40RTqjOKtEmA3iNiS3YpsdhornjzMS69867n15/RxdW
	HifV/U49QDvi5GBXXHOO9060/xTA+siaYOmEbrBMqeLX5N7jRVxLMvevPohMgX3/g3MUhA193k7
	SBEkdFMUlpfDPZuUhmfVVAFU17eENt8xLLm8VRpw5gG5F81CEzV+qZ6rv3Qb7UOnhQRA2DQx+ci
	KvS8PZKQ1gRl4bd97tceb8Je4BJrRvxr+330JtNnb2wA75cKJUi21QcAv7DgTVFOTQ3GFbuUURT
	Mr6gjExFWkxrTkkD7pe6vr1lkGv6zys/XtWGdMNLe462LIq35wj//ewh8iM4s/dENw88IdGNkJR
	NNYO0cwanb7NRhoTgw0v4i
X-Received: by 2002:a05:622a:1b07:b0:517:6508:e1f4 with SMTP id d75a77b69052e-51a72a824aemr43846711cf.42.1782402432632;
        Thu, 25 Jun 2026 08:47:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.214.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926005a1892sm853169885a.38.2026.06.25.08.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 08:47:12 -0700 (PDT)
Message-ID: <6a3d4d80.0aaa7f3a.91870.9e46@mx.google.com>
Date: Thu, 25 Jun 2026 08:47:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7611692904576294823=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, george.moussalem@outlook.com
Subject: RE: Add support for IPQ5018 Bluetooth
In-Reply-To: <20260625-ipq5018-bluetooth-v1-1-d999be0e04f7@outlook.com>
References: <20260625-ipq5018-bluetooth-v1-1-d999be0e04f7@outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7611692904576294823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1116589

---Test result---

Test Summary:
CheckPatch                    FAIL      10.08 seconds
VerifyFixes                   PASS      0.27 seconds
VerifySignedoff               PASS      0.31 seconds
GitLint                       FAIL      3.87 seconds
SubjectPrefix                 FAIL      1.71 seconds
BuildKernel                   PASS      25.31 seconds
CheckAllWarning               PASS      27.86 seconds
CheckSparse                   PASS      28.46 seconds
BuildKernel32                 PASS      24.83 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      459.56 seconds
TestRunner_l2cap-tester       PASS      58.15 seconds
TestRunner_iso-tester         PASS      74.50 seconds
TestRunner_bnep-tester        PASS      19.39 seconds
TestRunner_mgmt-tester        FAIL      211.62 seconds
TestRunner_rfcomm-tester      PASS      25.51 seconds
TestRunner_sco-tester         PASS      32.73 seconds
TestRunner_ioctl-tester       PASS      25.67 seconds
TestRunner_mesh-tester        FAIL      26.17 seconds
TestRunner_smp-tester         PASS      23.93 seconds
TestRunner_userchan-tester    PASS      19.86 seconds
TestRunner_6lowpan-tester     PASS      22.74 seconds
IncrementalBuild              PASS      37.70 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/6] dt-bindings: remoteproc: document M0 Bluetooth Subsystem secure PIL
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#108: 
new file mode 100644

total: 0 errors, 1 warnings, 72 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14645041.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[2/6] remoteproc: qcom: Add M0 BTSS secure PIL driver
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#147: 
new file mode 100644

total: 0 errors, 1 warnings, 286 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14645042.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[4/6] dt-bindings: net: bluetooth: Document Qualcomm IPQ5018 Bluetooth controller
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#106: 
new file mode 100644

total: 0 errors, 1 warnings, 63 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14645044.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[5/6] Bluetooth: Introduce Qualcomm IPQ5018 IPC based HCI driver
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#150: 
new file mode 100644

total: 0 errors, 1 warnings, 963 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14645046.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[4/6] dt-bindings: net: bluetooth: Document Qualcomm IPQ5018 Bluetooth controller

1: T1 Title exceeds max length (81>80): "[4/6] dt-bindings: net: bluetooth: Document Qualcomm IPQ5018 Bluetooth controller"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.245 seconds
LL Privacy - Unpair 1                                Timed out    1.861 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.742 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/352

---
Regards,
Linux Bluetooth


--===============7611692904576294823==--
