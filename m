Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EAB4B0494
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786065831; cv=none; b=ntkWgX+64Vo4GKYLnUg9AEGof5SfUk5CT08mduRoQcyyhEYjKBOFM8JJca69nPiBhP9GxxIiyBWP2ef6+pnvExQRMAtBeQwwtcD76zPYiodT6nJYgJ99C1utK58sIrb/v3s1gFDAjfGJJbMnrwGOW7C20MbtQb6vBz3hOMobbC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786065831; c=relaxed/simple;
	bh=WiJLyNLCfzmt4pEyVXxYHLxjEuAlZvimdn79PSMIv84=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N1c60Grkq6yfdGOIfkNw+ELIW1/Ki7bs3rrgltRYdB6ibYtyBZGbix1VqAiz3FBcr/Z25fOTDA6btBljJ7May/thMprZ+WMuWrhDqb7UMq1dEzbAe1qL+xhOSANvcRr0B4cOzN4UrtaAjgboTTvsl3lcyD9p+6WdfP8AyS3gILM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjUdrdq2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjUdrdq2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d004f135b1so34394895ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 18:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786065829; x=1786670629; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BUVVo+5oaX5oTXl2JZvUwk1AXgPThpGMYWaYjmk1y9k=;
        b=KjUdrdq2RmSEsfAKdnlUGZKyDJTm0m/aOgH9AD/jQY4L+/sG+Z1sKQpBkopWYy3SWT
         jgcQnAHy1hHHtdGu+/F9mIHTJhb14fu+LpPf14rM8j0RAHdCQDmoK2s+ndCVXXpsUQGe
         z9ehitjEkV+GvApc39ddNO5tZlmyA4gvsg/es0PD6L08ZjQ3eHEPPf1JhIDbBS6TpBMC
         NjrN/jCjLXSgDVxY6IhkRXBjAlwbDQ0na9/Miu9+6Nz3gQdD1dAlJq5iwu1AyofRJ3gD
         NCngyEPVVj9XepixMAgjO4rcxscK+58SzGZXWHmCfyEEV6+4AIHw2TjdE6zFpehFmN/Y
         Yn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786065829; x=1786670629;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BUVVo+5oaX5oTXl2JZvUwk1AXgPThpGMYWaYjmk1y9k=;
        b=Ki8tBgqARHoonO3SYvndhh+bkebY16J2ePeVashxcHN1mL/MB5ZnOohDGzb1Ttgy8K
         pQQK7mGgMU+d+1l7BVNAcv998giGjBaKhsst9gnnnl80RMnSUb46975T6xSQ6+nSjiPu
         gNEzRPf/PErf70MsAD3LF2SRRpM9tmzuf055qVZMhILwP5dXID9EQk9PLsM3oO0+XvuH
         SEfEVRYFyO0WbQ3LvnwNmwhJQam4WompU+LQvlE8ToDiYnHGHTSBQchBafPO1apV10+D
         tt8N0/9kWqNp9+vVh1NCBuMa9mD7kwYo2il699CEth1GZtPoj00USeOewQn/VzERwXW+
         8A/A==
X-Gm-Message-State: AOJu0Yy6D8WJkRQpIOU1rezAM7ZOzBYhHNH3x41xVdoNtfUQMvspoc/H
	MPe3JH0MUwxobR06MmyPyAINCCMO3BKZ/EmuaGM4IBrbZVo9/c2PxPkl3s6luEEV
X-Gm-Gg: AR+sD10Rf6Fm/QzUt+grX+rQk72CGA5GxOv+YC1jmK3wLODT85n2elQPG9cOfRvkM+F
	Ze2XpQwYaNvO7FFH1b5khG/KEKvLb+37JHVY5sMfnV94IkTUuh0uld7o+a5t5uXbX4uQkUE/A08
	7PsVGQDvF+SRV2SAmO1W9i+yTBRPGn5GJUWSGHunr5insCHY3HfIGAAgWs+v7oe5Mbqv8Ejhusp
	2FtM7HbcWJ1akX4qJhF53D2tozRBYq8SVCGJM/oV5994zjbT+6xFqQo7iPVAWogmCh16cdIo7ET
	pvAr8gCzXaN8PspZd0gVVXEEGfOBRnVB2TJhHPjKivHUN1pG+m+Vqc1WAYxO/+MiKHCZxETQr6R
	3qqQSeNO1vhdHj+DnX6eVACXtkU3TDytGRh31pLUF11OKXTrVkOLC1IljCT+hCEbTppZqT1WfgV
	JrMJWeE+eslta3L2xtRGUirwuRDb5skkQ+nbpU1oSgwbhUgEWAzqD/+7glxP2RbyWxIleshw==
X-Received: by 2002:a17:902:d58e:b0:2c9:e835:ac67 with SMTP id d9443c01a7336-2d0caa03d1fmr231739195ad.19.1786065829291;
        Thu, 06 Aug 2026 18:23:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.221.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88473sm856301eec.17.2026.08.06.18.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 18:23:48 -0700 (PDT)
Message-ID: <6a7533a4.881e6cae.4accd.1deb@mx.google.com>
Date: Thu, 06 Aug 2026 18:23:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8839762369626335712=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: Support for block device NVMEM providers
In-Reply-To: <20260806-block-as-nvmem-v10-1-be598b2a5606@oss.qualcomm.com>
References: <20260806-block-as-nvmem-v10-1-be598b2a5606@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8839762369626335712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1141567

---Test result---

Test Summary:
CheckPatch                    FAIL      7.76 seconds
VerifyFixes                   PASS      0.17 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      2.05 seconds
SubjectPrefix                 FAIL      0.64 seconds
BuildKernel                   PASS      26.06 seconds
CheckAllWarning               PASS      28.65 seconds
CheckSparse                   PASS      27.76 seconds
BuildKernel32                 PASS      25.54 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      492.34 seconds
TestRunner_l2cap-tester       PASS      62.54 seconds
TestRunner_iso-tester         PASS      77.35 seconds
TestRunner_bnep-tester        PASS      18.84 seconds
TestRunner_mgmt-tester        FAIL      213.58 seconds
TestRunner_rfcomm-tester      PASS      24.76 seconds
TestRunner_sco-tester         PASS      30.65 seconds
TestRunner_ioctl-tester       PASS      25.93 seconds
TestRunner_mesh-tester        FAIL      25.87 seconds
TestRunner_smp-tester         PASS      23.28 seconds
TestRunner_userchan-tester    PASS      20.04 seconds
TestRunner_6lowpan-tester     PASS      22.89 seconds
IncrementalBuild              PASS      72.49 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v10,06/10] block: implement NVMEM provider
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#238: 
new file mode 100644

total: 0 errors, 1 warnings, 194 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14734708.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.234 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.200 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds


https://github.com/bluez/bluetooth-next/pull/541

---
Regards,
Linux Bluetooth


--===============8839762369626335712==--
