Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B438398D
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061220; cv=none; b=kD7JX6t94lnc5dMX1u5H9PUnNy1Ggvq2ZMpqFCTcpBNT5DfYnYCEUoVDSye/DP1EgBZ/oOn6iNBUc+IpwZeemKJnU1a6jR4NS3itz7A/Smkp7iPwJQpAR09h0OcuuUrnJkzCZmyA5mzP1FEZp5elcS6qAb+lW5NfntSyLn1Ic4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061220; c=relaxed/simple;
	bh=8MzjfVoFFHv1CUFiJVYnawFJBOnm5r5E/rf3UvHl5Wk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rwSfcEKYqu5/ejMdaS8Y5/UPnxmhC5nOoCDuByvuih23B9l3t440AuLsuDYhVL77grrEbClTrDDg7LS6FTzqjzTl+7zF3N6IaBENX8UmItJ13yX6iPQqrPUjYtrCGjPdIqOIwRVyRhbOie96V708TfCETaiGRF3VcxmQSVE8wGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0DIJ6kk; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0DIJ6kk"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44cb68d549fso101301fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 23:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783061215; x=1783666015; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0JkQNCS2k6J4FSFw+OC3exyjvqqF9DZed0yfQfC2mdc=;
        b=S0DIJ6kkV0bRSMFNAek7SUmzUskuNJ9HSbiyPxA4guGalQV2bkNlG+9D7RjvvMF3/t
         iE08veWQNHzl57k1LJYfwJiM0PQfWOhDbzqAb6XuS+hr5xkbOr2hw3ZMrXcHGjmXH7qD
         YQcmUZNH+Ork5QyjSzHJTJms35IECOCHHfLfIQ0YbAWfcp/DyJOU9dJNIhxGkJPuQvhd
         w3MjQmjHh8F8HMS1KHhESdvenyKnejCKwH17TO1Ge/qMZiFfuYJwCjQiEvB9suAq/G4s
         4dBiVlb/7BMqgvr+2j+Om1zpN24u/XWjuRsHAaw5dQi1yhSSfKgDtDmd38NKvieIrCr3
         k/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783061215; x=1783666015;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JkQNCS2k6J4FSFw+OC3exyjvqqF9DZed0yfQfC2mdc=;
        b=s/hK5FlsCRjPwjLs9sFdWPsd4bMQXfV0mCdyPJ+8TffdOt1sITlmmCSG4P7Aaf/t4c
         7RvP62wIPF0y3puXN8uHkpLME5jZQe4/jEZl7QAggPGYQ6A5Ih0dJLIbHD+SE8tS3Fzo
         H+7hcAh0ILI/XhMMvDPoXU8iBwqicjcxYRIrhNkGGB9RYTLhsTIewM/PrBqr0dMIwo/G
         ruO9YvZHG8jvmEDtMFpl1HK/ChhLZdcsWCi4Pq6m/g4z1zKo+dFRFtVyYEanFhO8flkw
         gpVcrHAABcasLBPTIkv0csVTN/rzb38/Y9YMFJjgE7iL8b9wzKeP93YvVaWJbhsZrsVa
         eTNA==
X-Gm-Message-State: AOJu0Yyu9k4QPNaaAUOOgU8J1oCFh2fUdpq4gwmIVrWm9XlMheGkawFA
	uQvb7iEiakhXy+jVgnjmpkvOBJxE+Twq6mf3odDohN+uG32n2w9v+iMw/t90yQ==
X-Gm-Gg: AfdE7clTiW0UV25ANPId4kHAhcWtSMWv5cYqVDEC/ouYr8q2j4AHmHKbqecDp80fdXx
	7Mr+LPF6ZKVCPyOwh80c2VtdqqIFjRnyC26MRA5OpMADpk3rDn8CaB+kX3R5z/nMnhlFKIVvRbD
	kipVl95nkER+Otvd18WoxgnFYOtfd0ZfMrmuhIaXR9a9jZzoNiJBrKl71vC8Jb2NlVp09JGMXe1
	pBcjnrX+nEUZdTdsuLHAM6Sj/hm643kdytYDZtnBZQIrJEC+PobVlSsiZFWwcCpo5UcRqLmXQVF
	lAqkh1efWGnlHgMC4kLgnQQzrh/DMbD8KPKSe9ajoLzts72HUCiKPGFzD3V+8kpW/HNGVvrdGIc
	RFrgf28Uf2U7dPF2tL1B7LwbgS/QkhsXUBlgmyEsFdzuCXAPcpSIEgnWUqa/7RZgXrGDzyc/0cS
	Q5C94TfoR89fv6K9syBgY=
X-Received: by 2002:a05:6870:aa94:b0:448:d407:d4cc with SMTP id 586e51a60fabf-44ce9a8c58dmr1788908fac.0.1783061215438;
        Thu, 02 Jul 2026 23:46:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.80.108.166])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb5e257bsm1075915fac.14.2026.07.02.23.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 23:46:54 -0700 (PDT)
Message-ID: <6a475ade.44924ed9.3a8bfa.0456@mx.google.com>
Date: Thu, 02 Jul 2026 23:46:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4402015558262628258=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, george.moussalem@outlook.com
Subject: RE: Add support for IPQ5018 Bluetooth
In-Reply-To: <20260703-ipq5018-bluetooth-v3-1-62da72818ab3@outlook.com>
References: <20260703-ipq5018-bluetooth-v3-1-62da72818ab3@outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4402015558262628258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1120861

---Test result---

Test Summary:
CheckPatch                    FAIL      5.23 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      1.59 seconds
SubjectPrefix                 FAIL      0.57 seconds
BuildKernel                   PASS      25.18 seconds
CheckAllWarning               PASS      27.27 seconds
CheckSparse                   PASS      26.30 seconds
BuildKernel32                 PASS      24.29 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      456.45 seconds
TestRunner_l2cap-tester       PASS      58.83 seconds
TestRunner_iso-tester         PASS      82.41 seconds
TestRunner_bnep-tester        PASS      18.53 seconds
TestRunner_mgmt-tester        FAIL      216.33 seconds
TestRunner_rfcomm-tester      PASS      29.68 seconds
TestRunner_sco-tester         PASS      32.57 seconds
TestRunner_ioctl-tester       PASS      26.21 seconds
TestRunner_mesh-tester        FAIL      30.98 seconds
TestRunner_smp-tester         PASS      22.90 seconds
TestRunner_userchan-tester    PASS      19.78 seconds
TestRunner_6lowpan-tester     PASS      22.34 seconds
IncrementalBuild              PASS      30.46 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/6] dt-bindings: net: bluetooth: Document Qualcomm IPQ5018 Bluetooth controller
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#94: 
new file mode 100644

total: 0 errors, 1 warnings, 86 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14660835.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,4/6] Bluetooth: Introduce Qualcomm IPQ5018 IPC based HCI driver
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#140: 
new file mode 100644

total: 0 errors, 1 warnings, 1065 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14660839.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/6] dt-bindings: net: bluetooth: Document Qualcomm IPQ5018 Bluetooth controller

1: T1 Title exceeds max length (84>80): "[v3,1/6] dt-bindings: net: bluetooth: Document Qualcomm IPQ5018 Bluetooth controller"
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
Read Exp Feature - Success                           Failed       0.251 seconds
LL Privacy - Unpair 1                                Timed out    1.899 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.512 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/387

---
Regards,
Linux Bluetooth


--===============4402015558262628258==--
