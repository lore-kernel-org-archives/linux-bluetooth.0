Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE373B14D3
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599695; cv=none; b=fz4CBQ4+/cF14WsuTCPDesg/lAvSTbA34ezzRgAsgg3RIV2zrdkl4XcKofIIYbKo/H411owpsG8DkcaC9zvDZEViMSXxn7CVo5m+cYxab9m7FknYJ1Cx3oulKhS+IaQEEqFHXVOdMaBfJ6OjSW5fChPiZB7FCxKKLwWS/ohVZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599695; c=relaxed/simple;
	bh=8uSAq8arSVsm+loQxDS6lyItmimb8B940XyVsN43fpA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=snl5XcmMe6/m3gD9nqCXmmoXbBAtAai89zEJhsoUkMxlxl/kyqeE3GfHMpXBwKxb9w2LKNFmQ9CXDcJymBUOwaFM4Sg1QOI4e7Yx5rBIWIYchcVAg2rucrrsQtJD/1Qw8Z5ndwqzyohdyO8EJlQnQEesxq1P56Z9KJ8RrcgnZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pOaepx+T; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOaepx+T"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848595b338cso732874b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783599694; x=1784204494; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EVrXLql3UOa3SxY9clHiM5izENQFrIDZAC2yv3Xm7Co=;
        b=pOaepx+T+qUK53ca/otDp1nOCzhN6Upj65LHBsYh1QlFx+FLLKSE5k2SJW/S/K6Ffi
         gc1lNQb+fgqQjq0ZpfnsvKdEcmrOdRgNd1PkieveZXQo8y5QhQ/ecaBD/x6/2Vi1/Xpf
         h9iEwT/Hgn9mx/+3RcL34JgKes0tsPDvZvQQMRpV+C0mGDiMkR819qufrVFyWeK/TgE2
         8Qut2Z29R/yKNqetb/PDg/Uhc2dB6n2Z+0DBksh1vQHLtnllfW1eQtkRA67Jc+l8Q0xF
         Pyxf0v8CSzzlI1LW1KWi4xemPmWRVIDq4OAbkA5WpGtFUz0pQY6+tnoUpMR2z7fwFEgm
         1Xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783599694; x=1784204494;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EVrXLql3UOa3SxY9clHiM5izENQFrIDZAC2yv3Xm7Co=;
        b=BE8XD87OAYio9Nxd/punLjnbE1rn4wkiUA31onVQonXGY4kYvdkiedOyh0RUyH0ZaT
         OW99DeGNW3g8OlCijQiu3aBo442KAyMdTrqqDQez2/WWp4gDFoDyzrTBeiY+Qb9W87o/
         yWLUW97Fdj/Jue6Uv9PkJtkq5cRNNsHT+413fLvF9Lyp2G6ROWYpglQokakNZ4TawddN
         wDPqv/e+qIo3IQQy7if0h+8Lz4W61wONg2qKJ+PLXSeEOCVGeLtcgqovZjmTmtODzySJ
         QTGHfXm+x3KzHOpBRJ1+pIdzjk1z2b7P0sR9H1UQIyJrRFNG+C62bSgYR2vDm2CLg0G3
         juqQ==
X-Gm-Message-State: AOJu0YyRYboycymCAwzxsboBjH0J5BMvOa1tMOTlO3oi2RCFojKnxV7o
	3HnkGXG4gtOYtVX/ziOZukqU0ZEOMVouaYmoO/cg9AbsAvfip4rKYPGFZUEvsA==
X-Gm-Gg: AfdE7cmAUIc+e82WoEcCTJPRcfXsWLCfBXcnrB8YDFXeCfIZtyYapwPoZDgXIx5sg6I
	JzMl8of3GNrZSRP3e/xJQR+hzZx9a+95KCidKbb5FHERSyigtg9xJBVIYuMBHFdQqdwxZkced1F
	oddnVnvILO4CYZdR3QDRJpyR0KeI7sJJcDMRsZmd7+7J4XNQ2hihaG4LHGgW7o4pJBkNNXutjSp
	DQ5Q4S5D2+DwTlMQA6S7DQ4/ZyjVZ+PBriuV4xyLlA3VsgNaqrGt579ioBlzbryvXPf3Bi7X3lm
	FvvIhIrLzAj6AVqUxAqqtnMbPowe6jznXNx5lvvzoYCyPUDrHPsZxmzUkM1hp97zfhrauuy+DFL
	8RZUu84emwrBQtKnlLWKjNFutxs+kpI5EJ0Iwbm2kHERBnICcZ6JH0D8k7k9gCacROTu72R9r2J
	IcRG3lLUV29FY1VbskreYz4w==
X-Received: by 2002:a05:6a20:258e:b0:3c0:9c18:d5a8 with SMTP id adf61e73a8af0-3c0bd1c625fmr8740936637.69.1783599693377;
        Thu, 09 Jul 2026 05:21:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.210.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm35149246eec.19.2026.07.09.05.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:21:32 -0700 (PDT)
Message-ID: <6a4f924c.f1c1923d.991d1.97fa@mx.google.com>
Date: Thu, 09 Jul 2026 05:21:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0912913918223314289=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, george.moussalem@outlook.com
Subject: RE: Add support for IPQ5018 Bluetooth
In-Reply-To: <20260709-ipq5018-bluetooth-v5-1-e476c41f03b8@outlook.com>
References: <20260709-ipq5018-bluetooth-v5-1-e476c41f03b8@outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0912913918223314289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1124520

---Test result---

Test Summary:
CheckPatch                    FAIL      5.36 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      1.23 seconds
SubjectPrefix                 FAIL      0.43 seconds
BuildKernel                   PASS      27.68 seconds
CheckAllWarning               PASS      30.76 seconds
CheckSparse                   PASS      28.91 seconds
BuildKernel32                 PASS      27.09 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      503.36 seconds
TestRunner_l2cap-tester       PASS      58.63 seconds
TestRunner_iso-tester         PASS      75.61 seconds
TestRunner_bnep-tester        PASS      19.34 seconds
TestRunner_mgmt-tester        FAIL      214.55 seconds
TestRunner_rfcomm-tester      PASS      25.23 seconds
TestRunner_sco-tester         PASS      32.47 seconds
TestRunner_ioctl-tester       PASS      25.77 seconds
TestRunner_mesh-tester        FAIL      24.84 seconds
TestRunner_smp-tester         PASS      23.02 seconds
TestRunner_userchan-tester    PASS      19.89 seconds
TestRunner_6lowpan-tester     PASS      22.64 seconds
IncrementalBuild              PASS      33.55 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v5,1/6] dt-bindings: net: bluetooth: Document Qualcomm IPQ5018 Bluetooth controller
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#96: 
new file mode 100644

total: 0 errors, 1 warnings, 87 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14674953.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v5,4/6] Bluetooth: Introduce Qualcomm IPQ5018 IPC based HCI driver
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#143: 
new file mode 100644

total: 0 errors, 1 warnings, 1257 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14674958.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5,1/6] dt-bindings: net: bluetooth: Document Qualcomm IPQ5018 Bluetooth controller

1: T1 Title exceeds max length (84>80): "[v5,1/6] dt-bindings: net: bluetooth: Document Qualcomm IPQ5018 Bluetooth controller"
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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.236 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.824 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/417

---
Regards,
Linux Bluetooth


--===============0912913918223314289==--
