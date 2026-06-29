Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA462340A6C
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736239; cv=none; b=uKiUqrraS7ePShoEeoIdQZ/RmMjInXmFLQvBFVIrvSa7xN1q5SdKTJsAUSku2tiDYutSyfcOVXLnH0foZsWkq/CTCVaODcU+xkGuG6Kk152ZqU3vDsL6nHOjpEySbVlMuI40bJm7AeuR3T9pFSrJXF7b8HIw6bOV0fryFPDs34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736239; c=relaxed/simple;
	bh=WeYcucgW4yQNrRKhrKXC1Fd5Scs55MIH4/3jDe2EETM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aDobm4o6fZJSUEH01eKu1qlRUlC/yG9Y2cv2urw8IxfecgRiZwe8YN4XYjaVAV7bQ/4LrhejBH2zt04cBMvpaBng4eJgqfYAWGiL2ONMOxpNHhnd7qX90AeeBo3CMYthwcsFJHulfiOi5Fz0lQtYaHmm8g/xca6sshLBCfv8zBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EroNx2H+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EroNx2H+"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e602d2c0fso4947285a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 05:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782736237; x=1783341037; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ALm/0rrk6bDPLBvS416GWEWzUW9IAHg4LG2m+vOGZfI=;
        b=EroNx2H+X8FkDyeBjzDMdQ127ki0jM8qi2B8t6R8x6KlF8TSftuDZ+rlx6mdzEy7vY
         XZKUv4xN8hcs2Pb9FInXJeLZ7w512gIduq2ZZp0xJPQM8t3wYxYaPw/ljUYkrPvgsVSd
         NmRa3FAadVtGpl+CElKjBcohP+4pnMBALF5pb0qvswrYYTi9Us+2p1T8JUGbp+nWDTwp
         q9Zqf1Vuom8RNe1pMrBt1WoFvwDhHugethpacRBhfqzfjkAJEbsU741eji9YgbsqVoFm
         EM5PPL2hZmjW3/afdscx3Atlo84ay1t0TCrTdAA+QMd9Z1WSHoxgcp4UBAUAOwAeHQ3J
         wF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736237; x=1783341037;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALm/0rrk6bDPLBvS416GWEWzUW9IAHg4LG2m+vOGZfI=;
        b=KuTNt+zzsaLgI7jvBzZu70Hr8Xx8vDQ+whiRflTTfn4eGccRSxG58YmAJztAK4zYZx
         IrI+aLCkaUOytIj9A+XTTP17sOKL4vtBachRCTos+qixUVfe1+OG0/mjV3juAHwIHtXb
         s9aaXgTUEhEmXPz2GxHt/ypZjtuCC0wk53aHzS01O/hAnDnuBf5u/naYM7upSu5vPXIo
         blbLSVZwpC3V47ElQeF3ZcAqEJkQkpkdNl26e/H2qs4Jg47ETZ/l7xBRRFl2BvQB8B7C
         nrLu0CWa8W+zgDWk5a2CWcR1LroiAWVbVe0sW46/AJ11R7AC8K9Mngn4zBodlURQla79
         jHOg==
X-Gm-Message-State: AOJu0YwDMrR/1S4eOkxaFSwYo8PNxm9OJAfychCxWeDhELUIeaB2kiC5
	aBmgXFc9bzssM4LgjWxCxR1sIHsWVm+yN9cbJU/HWm6lw19l6TKD/RS4+L88iA==
X-Gm-Gg: AfdE7cmCkcTCL2jBugqC0TokaLTptx6CmyUVw01Ln+tmBscW1p6iZnrGML+uGHpYZEM
	taJ70g5RS+/8rzoQGthrTH5e7WZWhYMRqyRXDYSYBxnwlsWRBgSdUYTHPxIhU2tWx+PfhmFyO41
	LZsH6MI2nxMnGd7IWLzy26rA+njEe9hP+XWX5SWnFb1yXktmt+ugq37TANDJ2yvQYdFBlA/mK4r
	fLA9AKjifOZRLToWWWE4YtKRZ7eIk+9HlmcSG0OUktARdTYztO+nRGgwRP9JofKJeCwCpwR+2H1
	y7D+pKh2ZnzdCIOWA8PleTKDyXkrRAxYYoPgbVFTUyxgz5OcSkyuN+86BrZ53hlY+LJ7zoR3dvD
	f1Zhd1hqobJVbHrbbw/XjSe4fx/sxstFeMZEpcFIFBLNfSYwK4ociNC0TGfb+nkMRkLaBVAlCtZ
	UtRMgZvsH87MqpYPSDj5U=
X-Received: by 2002:a05:622a:3d2:b0:51c:98f:f288 with SMTP id d75a77b69052e-51c098ff87emr12780571cf.25.1782736236344;
        Mon, 29 Jun 2026 05:30:36 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.117.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51a9a3a4sm165915751cf.17.2026.06.29.05.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:30:35 -0700 (PDT)
Message-ID: <6a42656b.344b9575.10bf6.27a0@mx.google.com>
Date: Mon, 29 Jun 2026 05:30:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3279162272894041785=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: Support for block device NVMEM providers
In-Reply-To: <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com>
References: <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3279162272894041785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1118019

---Test result---

Test Summary:
CheckPatch                    FAIL      13.40 seconds
VerifyFixes                   PASS      0.36 seconds
VerifySignedoff               PASS      0.37 seconds
GitLint                       FAIL      8.96 seconds
SubjectPrefix                 FAIL      3.60 seconds
BuildKernel                   PASS      26.23 seconds
CheckAllWarning               PASS      29.02 seconds
CheckSparse                   PASS      30.50 seconds
BuildKernel32                 PASS      25.34 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      472.18 seconds
TestRunner_l2cap-tester       PASS      59.46 seconds
TestRunner_iso-tester         PASS      78.71 seconds
TestRunner_bnep-tester        PASS      19.19 seconds
TestRunner_mgmt-tester        FAIL      215.99 seconds
TestRunner_rfcomm-tester      PASS      26.36 seconds
TestRunner_sco-tester         PASS      32.71 seconds
TestRunner_ioctl-tester       PASS      26.51 seconds
TestRunner_mesh-tester        FAIL      26.18 seconds
TestRunner_smp-tester         PASS      23.02 seconds
TestRunner_userchan-tester    PASS      19.78 seconds
TestRunner_6lowpan-tester     PASS      22.58 seconds
IncrementalBuild              PASS      82.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v6,5/9] block: implement NVMEM provider
WARNING: please write a help paragraph that fully describes the config symbol with at least 4 lines
#211: FILE: block/Kconfig:212:
+config BLK_NVMEM
+	bool "Block device NVMEM provider"
+	depends on OF
+	depends on NVMEM
+	help
+	  Allow block devices (or partitions) to act as NVMEM providers,
+	  typically used with eMMC to store MAC addresses or Wi-Fi
+	  calibration data on embedded devices.
+

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#233: 
new file mode 100644

total: 0 errors, 2 warnings, 174 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14649785.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v6,9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses

1: T1 Title exceeds max length (85>80): "[v6,9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses"
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
Read Exp Feature - Success                           Failed       0.248 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.459 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/366

---
Regards,
Linux Bluetooth


--===============3279162272894041785==--
