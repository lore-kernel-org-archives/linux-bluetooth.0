Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37346AEEE
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772226833; cv=none; b=FcTJFsgmig02txEEKPs0+tB7KVDxE0qrG1vmInCH0yfJ0WCH//qPFH4o+azgwQXAQSiVITln1f9okbg6qKlASkks4eE0JduJNQN1KbNwzvLvCDGmSrHM65zVYKPC3oYdNdHzOXeP7rL4N2BsLQ3Eb4eOHKWyCMZB2eps/noPMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772226833; c=relaxed/simple;
	bh=OECSLvmceagdel41JSP3SToNJ3OKG1nD67jO/C6Lt/8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LVeNwAx/Yoo0KK4vNRSyJ3PabIBf28UqdKVByzZOwdvODZjQjIikjP4XyQy6fRsQHv+Rr97hJoUC3NB/PCRQTFj23ueDFNVE2szAg1P0epvsK10ACdrkpAIWqWlhzRAy6l+++B/oW3aLzWE9g7wVsm38Iiw7OG8xQBPD5KAba3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRWDdblq; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRWDdblq"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bdc47747e2so2038403eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 13:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772226831; x=1772831631; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SlLgKHCudjS1qNJse/klAQRvMY9DXGLkgkdnEqDj3K8=;
        b=KRWDdblqsROi9xmshS1j4PVb7pX3yH4SWBzku3eVfcaY2lhjury0AzQt6Bigs7Cnie
         NUx/6xqFKXruJVCmWQU2xlo9Fk0HVXXrkBgYluI973oCvb9j7ptGUhmRhpR2XDbCL9lL
         AG/NAw2rF4jnCFHQq5/qZTDz5h7cQ4kcyGzAbHozW+MW4eDJkWHyAAZzAT4PZZezzSzB
         NHxDR2YsXYaJTUtitH+PA7rWZw71BiNPJsWiZMcFGpXiZQT7sIH/DtsEPQFBFbOPygjx
         9vOY5m7M11mkAk/EihgFjm/zPnD5gzFBckDTcZhizJ9UPdNhQ8v2wDD4aJv3HJMELJ/4
         VfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772226831; x=1772831631;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlLgKHCudjS1qNJse/klAQRvMY9DXGLkgkdnEqDj3K8=;
        b=J5R6iKOx3snkUEikhM/06xDOruNuy+UHPKSVOWQPm5QaMuT/nOQ4Lo8wFW/ctoMlwk
         QXO5G7L6oiNQoAvyRCgmBDPifMCmpE8niuFHuE+gdNspjEfjCNDry4Rabgqzz4wZNVWX
         wHQQBedAbDlW21YeFjwnezhfxY1y1wIMJBMzaCIBCVVgdXBlNNpTH7x7NED+PtqUrokt
         2Ye4IjpaVfSo3MVI0HJ4PVvw9ZwK7cG3mzn0BXPg9xtSI1T7RrS5LHDBXogs9NuAgII+
         RZvHif4s09QyenuLVrr5WFLpJ/2plvCnyngN0C8Mvdmwkj1en+xZnPmhecaCFrDbJbop
         LZ8g==
X-Gm-Message-State: AOJu0Yxzu33IH4Z87IqN2vf9BUhQeVw6ZHO/x9C7eZHSN/pQWqTN1QUC
	SDHRNKSgNs7+w3KJz9Akz77X4uSH67r4yktnPd1GS5xC0Ny2r+9OPHkZNN9ysg==
X-Gm-Gg: ATEYQzynDFgi9li+SxRValGwZfePyX+wBzriAkQ5pLo3s315i3bZnM3xsTKdcHfjWmT
	0grkAeETSC1rmzUMhrLYDQrHmJYgWQYxkbPcNO5KeR5Xxua2j/YbHzwDGT/Vp8vYeq1dwGRObG6
	YuxizCVeAWmR82Yy0TdqPamb++lS8QFUDxsQnNXqxigGZEhGb/osbQD/UQCCj5i27OIz/RPJW5j
	FBGdalYPEgL9h3IkFHsxvIP8CIyYhEO5At5Uiu5CH3TC45J39x85EXidP7iuIo6oergjd79xp9r
	unIY/WMz5fsOQS+fEgdY5nxJl4W+u0ZZ/bdv+a8xPzrpPLGM6PtH/QTu6YYpS2eLFUt/ppfS7v5
	7BlwVJ5F1O9G0S0QQYzpxPOVu2V5I3KVysggLDF5aliioOjQ+XZv/SL1qpYymfzyonZWmaPzh3d
	hzeCKAJg+fI4h1aYglpzKy3R3do60BGg==
X-Received: by 2002:a05:7301:1008:b0:2ba:8f0d:cfe with SMTP id 5a478bee46e88-2bde1bb30b7mr1558759eec.9.1772226831112;
        Fri, 27 Feb 2026 13:13:51 -0800 (PST)
Received: from [172.17.0.2] ([128.24.163.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1bcea4esm4473472eec.5.2026.02.27.13.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 13:13:50 -0800 (PST)
Message-ID: <69a2090e.050a0220.d5d23.5c7e@mx.google.com>
Date: Fri, 27 Feb 2026 13:13:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9118544418995445441=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: ISO: Fix defer tests being unstable
In-Reply-To: <20260227203506.573494-1-luiz.dentz@gmail.com>
References: <20260227203506.573494-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9118544418995445441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1059247

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.35 seconds
CheckAllWarning               PASS      26.44 seconds
CheckSparse                   PASS      29.51 seconds
BuildKernel32                 PASS      23.55 seconds
TestRunnerSetup               PASS      522.70 seconds
TestRunner_l2cap-tester       FAIL      32.67 seconds
TestRunner_iso-tester         PASS      80.33 seconds
TestRunner_bnep-tester        PASS      6.40 seconds
TestRunner_mgmt-tester        FAIL      125.56 seconds
TestRunner_rfcomm-tester      PASS      9.76 seconds
TestRunner_sco-tester         FAIL      17.74 seconds
TestRunner_ioctl-tester       PASS      10.37 seconds
TestRunner_mesh-tester        FAIL      12.47 seconds
TestRunner_smp-tester         PASS      8.93 seconds
TestRunner_userchan-tester    PASS      6.76 seconds
IncrementalBuild              PENDING   0.81 seconds

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
L2CAP LE Client - Read 32k Success                   Timed out    2.512 seconds
L2CAP LE Client - RX Timestamping 32k                Timed out    1.895 seconds
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
Mesh - Send cancel - 1                               Timed out    2.642 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9118544418995445441==--
