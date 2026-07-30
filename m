Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F278738AC80
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432626; cv=none; b=UtRYRn7PCvRfA+pEvCKPbjShwaGxLeLh3SjqjwqCNnLTqWbHxsQC7o1oipsAei/zDMBh2HWOvhHf2eLw6YTFw5vrv0rSNCk7EqOzOmjVTi2Nx/UdHHeo0Wndpb6/0myN1YbOWTuCl0yC4TAr9lNGGZ8vF9cqjFVq3Y6tZJEJevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432626; c=relaxed/simple;
	bh=XYpjoDfqrQRkkBxItccoUMm3Of47H0uIkePjTrkxBrA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UYqJri9BFzgSOYflnhwCexjauBiniPiPdnRsDFhJ5OaUKguCgtidft0QCF3EpP5qD6+2wVQLfe8zG3RsTHqOqATD8hDT3VFKYOqz/+ebp6TjEbQWtlh4Arr/f8ymD/B9aJs4yuN3Mp7/sBfuRsUk+RymVy1oLmWfbSzOekEDr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxNMbr6a; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxNMbr6a"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so35178a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785432624; x=1786037424; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=98SilquF5VvflMsg11i7zEQ6eGn4sylLzI0pitqKFs0=;
        b=dxNMbr6asPWzaXXT2lPnt/aINMNq61vBZtZ48bgLuNpiyRiYVtZZ5VtOxF/AFoZsC6
         lEOhN9prVkkqEtCKaN39vT9C12xgUGgyDxGvxdQLJGqYxEnUIHSJxGTShwS8LoIa9hw4
         3NvrtoTJ7qSynKiR48hMQXBrX+7jxv1/C+GgoYUCPzLDIZ1B8XihL2qmUGUo6YssoG3m
         7Zyyii1cw/Rm+GaBT38r0KUgWy7Ia1KCac9cYefFZ1BbbI9dBT/BdQpmQFdk7s8OhLI1
         /5XRoATdFCGiaodVEeJ+9yZMeSmVhtl7k62oZWBIv0lV0HecSEdo59qkq7S2HSop8Yns
         Qywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785432624; x=1786037424;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=98SilquF5VvflMsg11i7zEQ6eGn4sylLzI0pitqKFs0=;
        b=Br4Pm+vHzyvTNKjyKDXiHI+Mb0oSBqkMBjaHqfjeoGztVQ8fN+39wXzdgMHyz35INP
         Ym4x4/3PCOghvnAy9WimGSFl60oy5stxk86tcmGNLuLNOA2+VnCprPt4WS8U6BNUehFB
         SWT9YjwuGbGbwWLhTTwunIUON/RCDFZpuERJVXD13icPUCPWGlG8GZVgxnFmyDbTWjPC
         HVeDAtNain1q9mKL0DlGc5bPkopSKS0hK6RWAFMQ4dSD8DkA+WHNrI9yShUBdrHcpVT5
         u9ltL8Qxq4dxhWMycmh4I3ZBfz7ZcGLTQWrK6Sgby2zHEqWqCuKuuGFCslCLQtHk2mWV
         25eA==
X-Gm-Message-State: AOJu0YyV66KOtlgX26kOmM7uIKoondmpOEh/Ab4tXd4E/SIZ3Xc+jwOE
	rzlbgqtyaT1tDPhxHFleNGawRaUMfuMwBt62qWjBjY4rpXqrb+NT4gD4OkGhdQ==
X-Gm-Gg: AR+sD10ndxYhtXBhQX6xUPWJSMSUyQsJXZ+Fu/4aSTAvuvL2aaDjb3OiPB2QMsVhS07
	AoYosYVL5uWCJRomEMYLWHyelzmvPpijBoyilh5p3szTXas+mpcRl2jxeiZUXNjHrmX12yFLBda
	3ThUokeohDUv0QomYs6+2X7jQtH00kZpYgvpd95yqN5XFePsaBEjgsjokFhFBHig8AwvJhGEQcT
	mIr+4pWp0MxUYYMswtxnwAvF5+Rs6R3zbHUzxFcY/MT4H17zvrNQySnA4Wu6uTlnmveKG6OMGMI
	UuLLgKClPhpzymsyYrrNyySiCLq6P33qUgo9o7zm7luA1bNumYRokwLps6h+xw19Noym+0wXjWR
	JBiJxc12foSoCf3zLv2w8kJyE9Gbkkf/GAXwg1pBdqFAsisk9UzwFby21z//WraxeM70LY5DFBb
	fZAUcS0rbNNCNHqbDHpvRI2CXUX7KC4qGkyBRMKkEWOz5sL7u4lZejwmTz0/lWqz60rzl7Cd9Jo
	ntyH759EAKEM9E+
X-Received: by 2002:a05:6a20:cfa8:b0:3b4:8880:2089 with SMTP id adf61e73a8af0-3c90066d703mr3386881637.16.1785432624178;
        Thu, 30 Jul 2026 10:30:24 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.3.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b670cfsm21597308eec.8.2026.07.30.10.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 10:30:23 -0700 (PDT)
Message-ID: <6a6b8a2f.21a19891.1e44db.9f64@mx.google.com>
Date: Thu, 30 Jul 2026 10:30:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0438154111203801029=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: Support for block device NVMEM providers
In-Reply-To: <20260730-block-as-nvmem-v9-1-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-1-f72935817dbf@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0438154111203801029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1137570

---Test result---

Test Summary:
CheckPatch                    FAIL      7.82 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      2.32 seconds
SubjectPrefix                 FAIL      0.82 seconds
BuildKernel                   PASS      24.20 seconds
CheckAllWarning               PASS      27.02 seconds
CheckSparse                   PASS      26.03 seconds
BuildKernel32                 PASS      23.83 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      441.18 seconds
TestRunner_l2cap-tester       PASS      64.99 seconds
TestRunner_iso-tester         PASS      92.37 seconds
TestRunner_bnep-tester        PASS      18.91 seconds
TestRunner_mgmt-tester        FAIL      233.05 seconds
TestRunner_rfcomm-tester      PASS      25.34 seconds
TestRunner_sco-tester         PASS      31.47 seconds
TestRunner_ioctl-tester       PASS      26.19 seconds
TestRunner_mesh-tester        FAIL      24.81 seconds
TestRunner_smp-tester         PASS      23.26 seconds
TestRunner_userchan-tester    PASS      19.52 seconds
TestRunner_6lowpan-tester     PASS      22.78 seconds
IncrementalBuild              PASS      68.30 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v9,06/10] block: implement NVMEM provider
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#241: 
new file mode 100644

total: 0 errors, 1 warnings, 186 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14721276.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v9,10/10] arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses

1: T1 Title exceeds max length (87>80): "[v9,10/10] arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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
Total: 501, Passed: 487 (97.2%), Failed: 4, Not Run: 10

Failed Test Cases
Set Low Energy on 6.2 - SCI Setting                  Failed       0.379 seconds
Read Exp Feature - Success                           Failed       0.271 seconds
LL Privacy - Unpair 1                                Timed out    2.043 seconds
LL Privacy - Unpair 2 (Remove from AL)               Timed out    4.930 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.849 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/518

---
Regards,
Linux Bluetooth


--===============0438154111203801029==--
