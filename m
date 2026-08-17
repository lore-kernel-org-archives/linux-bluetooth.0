Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161F3F44EC
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963462; cv=none; b=CXJgFlbNM9ixA43esQOW9ZwRq7Q4Hdul8sd8Z/rFl7IXfnIMirvwMy28P8OoFtyIrgQc4QDlTNiiMnMp1PQ/rORNCsacpeQuP2JUP7ejHEjuTSUS9DWgt4npRrtP4XzuhRD9H9VC6kW1HpqqrdMPMs8TC0sRRFGpKa3xmMMz8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963462; c=relaxed/simple;
	bh=+awPsOzsX9jEMwi+8xUdzUDvLmsPwMfZJHpWotXDzQo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=i84iIvYmpZPGswnzVXWoLo/Q6FVCT9sXavombvdVCKPqyJvfMfq6uI9FQUxmfGIRI9ltmf3V5pHVbt2RMKgLHUfqMReVFqPAKESGLCzR0xDnWY2QW/lYNm06wahL0hMGK2XOyJ2HW38GWuAM9PFReZMyi7IS3jouNX90IRO9pg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jclPca/R; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jclPca/R"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8f186025973so29984866d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786963458; x=1787568258; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IXNePYWFz73WwewH233V2L7D9EQ0R6HLZ54sF8dscX8=;
        b=jclPca/R7ygxrzCl2A4HI1e2y5kaRvWryNV2UBP9gAcbAdJEesqxBsNuk3fIooXrSu
         Cxk3QlDHOBCwJ+tRa5ZvihmfW3tnx0GBL2MdFDKbqwj93IrtE1nH1gvdPYe8+fWei0US
         Kkck0mQF42Ez+6alTpbjrHa7OOM7V8N5TF5acqdh5M8yWLgc3iNokoP775woFD6jo4UY
         63usNb3ToaF4i/mvMIdja8NpkNLqduJWD24A+pU5WXBFecK7HqhZQnp3eBszTCPZHer1
         K/yOWuVsKhxLPATPSJouCxKKi+V36ZeaMDwVY+2Db667bvMUivuEKMMuNG+gBE+rSRMs
         uoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786963458; x=1787568258;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IXNePYWFz73WwewH233V2L7D9EQ0R6HLZ54sF8dscX8=;
        b=sug0/MUECXqkIJ6p+jHfcAopeGt6ab9iHcDiDHFqEAJj7GnJ8BQU/XLfIQD6NtXE/d
         cmqc/ETdtzvW6r0YsWLs39JnAEMQHqDK5JiUkK+1/L/zOx7kTCA54EJhhnF/G4ep4HqZ
         2U/tR4tZQVmOYCMYzmOqAoxjXkKEaw5nEtBPW26Vc2/M/U3gghI7r8+7HU+orTuSOljs
         XsphilVmtIvpjGIgRO07x3vFJUMaQbXxyo2LNACzk23gaPpQCUunCTu9ocjeYan3C4rR
         gkXdPMXkYLo6D+5tIM/w/hP9/rV+sMGn7zyJWI2Tau2tPUZWS2lxy4t/VxCD1CEQV8pC
         lV8w==
X-Gm-Message-State: AOJu0YzTN+8Wx3Ye0TUCuS4QuIZkx9T2gApTqJhJM/XRVgBpcdcS6mVT
	YP2E2EhjmeFQa4B6iv3R9ywz9bst+iQhv1E8gUQXHwHPNp+IAhBspEzRYV1ppg==
X-Gm-Gg: AR+sD11s1RzytvlPxxjM/zPvjrQkoo6pGCc3OTuvuA7DUDcL/Gb+M5Sxot4daAJ+eRu
	OvOuca6Ap33Hkc4jwDrR4dWrC1NJ/c5MkTDPDzuFocF8qjwVChErIo5A6lmG8GYJ4RMciqn+Zjy
	VmSNJjEB2QYxfBgO/sngquOrBz8CucvilzvThhZ6T1RF0+pUk5reIhSz0W4MdqF+/3utwkgFfAy
	IAcGDIOkQHtiIq2y+FZ7hqgnxkoXb01s9Y0xDB/f5yinhL0bwUBLFHRDVIrfmdIabC2ukiZroVo
	5/bUASaOnEHn7Fh4pXUeOxbky5CzN6+mf+zNlF6lmZX2kCYnSbCWg32A+WtrwTf3LjkagoQlWtx
	/cGPZehwUHYOnqlcqwyo+5cyg0aqk8Rl22yNSdSnLu1NZCo2vscu6wgpuIbN0W6d1JLbBBVl8Rl
	nX44jEbXwUqeROVHNjjFyhFqIdyTqguIckJPD4UTIk7UjxfI2sozI4QvMnXl/zH/O7
X-Received: by 2002:a05:6214:468a:b0:8ca:f47:25ea with SMTP id 6a1803df08f44-90a91a3c8edmr302753046d6.0.1786963457841;
        Mon, 17 Aug 2026 03:44:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.47.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c45936724sm5959476d6.27.2026.08.17.03.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 03:44:17 -0700 (PDT)
Message-ID: <6a82e601.7306e961.36f27d.a920@mx.google.com>
Date: Mon, 17 Aug 2026 03:44:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2973251414745960892=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaihsin.chung@synaptics.corp-partner.google.com
Subject: RE: Bluetooth: add Synaptics BCM4384 support
In-Reply-To: <20260817092723.637956-2-kaihsin.chung@synaptics.com>
References: <20260817092723.637956-2-kaihsin.chung@synaptics.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2973251414745960892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147085

---Test result---

Test Summary:
CheckPatch                    FAIL      2.42 seconds
VerifyFixes                   PASS      0.30 seconds
VerifySignedoff               PASS      0.29 seconds
GitLint                       FAIL      0.82 seconds
SubjectPrefix                 FAIL      0.30 seconds
BuildKernel                   PASS      28.18 seconds
CheckAllWarning               PASS      30.76 seconds
CheckSparse                   PASS      29.59 seconds
BuildKernel32                 PASS      27.16 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      510.14 seconds
TestRunner_l2cap-tester       PASS      66.12 seconds
TestRunner_iso-tester         PASS      84.59 seconds
TestRunner_bnep-tester        PASS      19.75 seconds
TestRunner_mgmt-tester        FAIL      227.00 seconds
TestRunner_rfcomm-tester      PASS      26.09 seconds
TestRunner_sco-tester         PASS      32.75 seconds
TestRunner_ioctl-tester       PASS      26.92 seconds
TestRunner_mesh-tester        FAIL      26.94 seconds
TestRunner_smp-tester         PASS      23.51 seconds
TestRunner_userchan-tester    PASS      20.23 seconds
TestRunner_6lowpan-tester     PASS      28.53 seconds
IncrementalBuild              PASS      29.75 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/2] dt-bindings: net: bluetooth: add BCM4384
WARNING: From:/Signed-off-by: email address mismatch: 'From: kaihsin <kaihsin.chung@synaptics.corp-partner.google.com>' != 'Signed-off-by: kaihsin <kaihsin.chung@synaptics.com>'

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14753255.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support Add support for the Synaptics 4384 Bluetooth controller by adding the corresponding chip IDs.
WARNING: From:/Signed-off-by: email address mismatch: 'From: kaihsin <kaihsin.chung@synaptics.corp-partner.google.com>' != 'Signed-off-by: kaihsin <kaihsin.chung@synaptics.com>'

total: 0 errors, 1 warnings, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14753256.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support Add support for the Synaptics 4384 Bluetooth controller by adding the corresponding chip IDs.

1: T1 Title exceeds max length (149>80): "[2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support Add support for the Synaptics 4384 Bluetooth controller by adding the corresponding chip IDs."
1: T3 Title has trailing punctuation (.): "[2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support Add support for the Synaptics 4384 Bluetooth controller by adding the corresponding chip IDs."
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
Read Exp Feature - Success                           Failed       0.258 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.596 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/596

---
Regards,
Linux Bluetooth


--===============2973251414745960892==--
