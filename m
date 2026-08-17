Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D03ED3C4
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963477; cv=none; b=GGVuaa+UTBDFb1mUO6kwAjxAN5Gnz8++A7o16MBE2HXSdmjPMKNCmtVvbjs8D/8la4GR5VVbMpUEVmMDTXQQnaa6qMc+1dHebvhTgOe37vcuiL8XE1B7YEybd0inmXnYo/9nNwT9eYtP8oY5VUjaiLCSZK+qbLIvqA8TIWHHl58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963477; c=relaxed/simple;
	bh=JyfAv6mL8148/v16VYuUqAWpbXCsx2pxloVy4DX+sW4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XfUpiUMKDKLrPfW6bXLT96KMdTEf6lWReVAIhVSL9ObmRgTfdEZYRDWBrSVV4K+CvP7ko9tQEWd3jKzcG6Z4wRDXjTYFjd3BlxnX9q0wjXAXV9VNnQ/8x2dL62Z8+9svLNfM/ePlwjE/qJWVI/T7AwTjCJfhaI6RR6agYdveZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHqwQorB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHqwQorB"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc61541f8cso51889255ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786963474; x=1787568274; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hJKIw7xzEdri+iwZDsK7i1u3UvVj/oofkEDxWiCdJiY=;
        b=WHqwQorBU6rYUYuBNDXCaugj6kWg8O/vzN26KacafVt3WYkhoKJujpY27D5Hs0Mnon
         46EkRLj2EHP5Sr/eNroaBcRc6F42hG4C1m+Rx3sCkc5DM4w0UD3PMWAeoeyJamfLMn+3
         +CD+pY4+l5zYJOh+zo5lCorMmsZhJ0AFNaV+pgD20u7NfPimyU12ctGB2wLKvgHt0qNR
         1rqIDmd6UXuW96o41ynabXzjkezqNsfcjw+RlVW/kztVJTlPJhfxVCLHrB3Sui8vI+Rl
         iyrAoNwJmwOX/HBUES9nI0vV5yLtDEeRRbrC4+Y8EzRe6xb8hYZvp17bcNGJd86I9etM
         flmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786963474; x=1787568274;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hJKIw7xzEdri+iwZDsK7i1u3UvVj/oofkEDxWiCdJiY=;
        b=NioDdnO/Lw2OSz6BHTL2qQpkVyIHVGwLY3f6WHDafvWMMGENWPEqBTtN/R0p2SLa/b
         pagzLmTZphOrxMWx7K2SbWinV0Xhc9jAhvSTVoXJ8lFth/XKwR0WM0g7G6/GDa5BRjMz
         pNUWPzOSJPB18EzibW2iXP8q1A4x+OrmtNC57WF2Jnl1NpkaB7SSrAZTf/8pGmFfS97e
         b5X+N8PgRv/2Wwx/4PW4PrsIGp7DopJ5dFoXqi5LfQoENkLx4hRXRrhA4Tm4cQU1fH7N
         QfcTPVr4Ht4bBzwSULpu2rRrRLqwnH2AkxnYKgcBOwFCUojQ4/KmP+zuhmajZ6E45E48
         fDZA==
X-Gm-Message-State: AOJu0Yzanh+YYaM0i5P1UnSTnvmikEvGAT9DmhsStBNql+Eo9cZcgD8h
	jSqdulI8+WJBePRMNIABKOER2jrw94TNxo5zO/7ORX2QHcNeUnu9E3NSgYW9Fg==
X-Gm-Gg: AR+sD135wBmW8qKNxq2RSA9Kv1BYxmBsLPvPHLZvpDFpDEVSHV/mUB1WKUsXhTjG0z2
	h8O6lCdXHykVBYwhG6dAb3FH28IglxY9VUABcYaIGOndaYCdh2qKSRe0Oz3Ztjq5qfsEEBRrc14
	cPUFY/hW1eBuFPPq3tTERd/pvMLN4fIfCkYY1boNtM/3HEPYWB22j9ZZ1qikPt+dY0D8WBFkJTH
	oauLPpVqEKVE9GxJv3c1nacXiP0SdaXQKH2gkbPkxCeBUu7OXIdF24VlduS3sTSsEfmiQo3XE/0
	rli0YiymbOYBXYgtDIzaFyUB9MuELUrR707+ULBrp6xAfpxeaXs/xYNFIMPxznYbu2PbksXVxH7
	bbSJPiFtOvUm2pAmKC6zvSps2q5aA+MVrkmB+f2MKRK6HBJEZiz/VzYY1R0m+GiTRkfdsBEOosf
	EbgX1Qiz7Ii5yNU6Wz9Hnd+NFqHerutM/u8nJxdBfou7S3ncWIPS7ftqSTe/H3OIeNRw+fZKHej
	qEyq/7t
X-Received: by 2002:a17:903:947:b0:2d0:401c:2edc with SMTP id d9443c01a7336-2d37f5cdb6cmr359797605ad.1.1786963473665;
        Mon, 17 Aug 2026 03:44:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.216.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32678dd26a0sm6875620eec.2.2026.08.17.03.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 03:44:33 -0700 (PDT)
Message-ID: <6a82e611.7270d2fd.2a8f15.70cc@mx.google.com>
Date: Mon, 17 Aug 2026 03:44:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8538915755817318347=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaihsin.chung@synaptics.corp-partner.google.com
Subject: RE: Add support for the Synaptics BCM4384 Bluetooth controller.
In-Reply-To: <20260817095550.648774-2-kaihsin.chung@synaptics.com>
References: <20260817095550.648774-2-kaihsin.chung@synaptics.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8538915755817318347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147103

---Test result---

Test Summary:
CheckPatch                    FAIL      2.73 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.71 seconds
SubjectPrefix                 FAIL      0.17 seconds
BuildKernel                   PASS      26.59 seconds
CheckAllWarning               PASS      29.14 seconds
CheckSparse                   PASS      27.88 seconds
BuildKernel32                 PASS      25.74 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      471.48 seconds
TestRunner_l2cap-tester       PASS      65.71 seconds
TestRunner_iso-tester         PASS      91.40 seconds
TestRunner_bnep-tester        PASS      19.30 seconds
TestRunner_mgmt-tester        FAIL      228.63 seconds
TestRunner_rfcomm-tester      PASS      25.30 seconds
TestRunner_sco-tester         PASS      31.72 seconds
TestRunner_ioctl-tester       PASS      26.89 seconds
TestRunner_mesh-tester        FAIL      26.23 seconds
TestRunner_smp-tester         PASS      23.84 seconds
TestRunner_userchan-tester    PASS      20.05 seconds
TestRunner_6lowpan-tester     PASS      22.79 seconds
IncrementalBuild              PASS      26.59 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/2] dt-bindings: net: bluetooth: add BCM4384
WARNING: From:/Signed-off-by: email address mismatch: 'From: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>' != 'Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>'

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14753286.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support
WARNING: From:/Signed-off-by: email address mismatch: 'From: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>' != 'Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>'

total: 0 errors, 1 warnings, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14753287.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
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
Read Exp Feature - Success                           Failed       0.240 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.924 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/598

---
Regards,
Linux Bluetooth


--===============8538915755817318347==--
