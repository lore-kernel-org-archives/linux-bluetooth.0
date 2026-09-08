Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D035E57267D
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883132; cv=none; b=lAAbisQPAdzFl7YLdJV9tin4Q96Fsp2lPYCCM6a4n2NCIjZrY/MDwad+fhP8P30vxot1/jhm+N9i6DkmUxT7TCT9lNiLbAXJSFKpl1bOf1VRjKku0M9T+oLZRhgo4rhwURR58awIabF+4+tyEX8CO2sSm9/pvzc/e2pW43U3Rcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883132; c=relaxed/simple;
	bh=glsToPjDzBOU81pN/5847c3hjLBWXRNBZ9/jYPCv1ds=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=j8FfOh47DIB7ai+1/BcKYNFkvmz+uiUhOpNdnkE2HUMpIEPG4M3LajVa/vnkGWlQmhY7zOHYZZznQt2zXR8aK7ENhoJhdldzPw2PiK1/Nz3+dlrW00+TdZN+UORPlBMJMCOweiYtdHomnuCK/qYrQ+z1ayKgx77RJxvDgyYIFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKKW3iom; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKKW3iom"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-8009036d745so383658a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788883129; x=1789487929; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Po5c5VEPASo1EM+DdSSbfOZGgA9C97oZUMXaM5sz0Os=;
        b=mKKW3iomCgWwjPhrauD6iZTnoyIxq9HUtt7eY4hB6yn9qvcdK+LsNOmB/1f5BdgSS5
         0ZfvzZBpyKl33xNinmQkQS3OvaWv5KmEQH2k0SyalE+xY6X0poNJvlIaxj7zZbv+mi7/
         UQhXSyDE/hkAcsk3TA5oOWwL/3LYykJHg0VmxoFvVXo3ntUDdtjzwCCvGYEYTyfgaxqk
         rIMqUjt+w3LijfMfXGmgHbk+3tLkyIEXnAVe4618oTzCZvogXun5Vgv0iH0sDaQflqyK
         q6Hov6EzWkoFku1xXasN5j5+0dPuFVEoUIx9Lqxbt3uoXU6/kqms0jXemkC/l9RCimnm
         JIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883129; x=1789487929;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Po5c5VEPASo1EM+DdSSbfOZGgA9C97oZUMXaM5sz0Os=;
        b=n54aVip6/ne5javvjVnwkAHRZYA8qETJRglkf1XJv/TyBvvpAu5CJs6mFD+pQ20eiW
         /G6UXbBjrw8h3ruSWttM71soPZNsT//wE/IRWLxjiiEqiqDRNoSv6NnlGQmznB1Ba7VM
         LvCGRTGBSPrffyJ6B7h6PQpC/OmTZncisuMtkNtB+fMl7qxnoNjEly8no2R6od7RVIP9
         eDTzR/1Y0j3YqUF9GqcnVfnjYNohYQThioC3KoLEw1XiNpO33ydgr83EU3Uyjojx4qBB
         3AiN+7W1KsCXO8/U0r0NhgymHk9htZz6Yf8R56gtUt5l+/X1vjlHo4UWCvrpaRxM+LRN
         7wow==
X-Gm-Message-State: AFuF++kBgon1c4oLLEYY+Vojdas+OCiMD2rDdYRUd7/3Aas1L+oBj3ke
	Ge9AcQiTK2IYNPogN4tQy7ChASSVMab49UBKhDZ3E/CF0YMD3Dn4WAtgXdutpg==
X-Gm-Gg: AYBFou18o/+uKhARz8Ifi0+P2jT0BHC21HoVny+H1GwTZGHg7vZdC5h4TczidIrrWDF
	r9Tm6N1NtCTEGhgfkdpaGut9cspmQE+LklBiorEFoAY25lmqsCthJUHFXD+l1VkE5oTvkf12ZZl
	zYrgxOPDZvWuIctbPkaOfU1Xln2PYrrdBhgpZF0hgl3+j7H9PmhPxzctcVHbp1b7FTrCqF2hWbV
	jkr69nHq/D9eUp+8l1qNwBVWtVDOfpkB4PIugMgldYkZgWSDmjn4lUs3s7sm3+gGruorwv/J8ql
	Hp5PfCQ8puPKU/B6P7qVLGXWdS4luzTghoUP5lk0uKgciJmq8tw65xQkOD4u+vLlLASOHj8O/AY
	NFh1sxX81K0cu9NDcEtn8tCr3g0wB8VFRYh9d9E6pX28SYJmhxcTwcuTQY/B8ilQAA5fP3aEJyh
	ehcP9vVFlTkzc56pV4osG9/SVASAElPHUJO0C67yMw/seDrnoARHTPemirVyN7dIwgdeI=
X-Received: by 2002:a4a:e909:0:b0:6b1:be9f:ce6c with SMTP id 006d021491bc7-6b6fbdc7114mr30524169eaf.4.1788883129538;
        Tue, 08 Sep 2026 08:58:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.46.239.187])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b9208f5b5dsm10293947eaf.0.2026.09.08.08.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:58:49 -0700 (PDT)
Message-ID: <6aa030b9.870d8f20.2741c4.dd20@mx.google.com>
Date: Tue, 08 Sep 2026 08:58:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3395032791365040810=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: btusb: Support Qualcomm multi-subsystem QCC2072
In-Reply-To: <20260907-btusb_qcc2072-v3-1-1f65350b03b8@oss.qualcomm.com>
References: <20260907-btusb_qcc2072-v3-1-1f65350b03b8@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3395032791365040810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1159555/

---Test result---

Test Summary:
CheckPatch                    FAIL      5.46 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.95 seconds
SubjectPrefix                 PASS      0.36 seconds
BuildKernel                   PASS      18.66 seconds
CheckAllWarning               PASS      21.60 seconds
CheckSparse                   PASS      21.08 seconds
BuildKernel32                 PASS      18.65 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      318.81 seconds
TestRunner_l2cap-tester       PASS      53.08 seconds
TestRunner_iso-tester         PASS      90.96 seconds
TestRunner_bnep-tester        PASS      13.57 seconds
TestRunner_mgmt-tester        FAIL      179.64 seconds
TestRunner_rfcomm-tester      PASS      18.97 seconds
TestRunner_sco-tester         PASS      23.66 seconds
TestRunner_ioctl-tester       PASS      19.04 seconds
TestRunner_mesh-tester        FAIL      20.39 seconds
TestRunner_smp-tester         PASS      17.16 seconds
TestRunner_userchan-tester    PASS      13.98 seconds
TestRunner_6lowpan-tester     PASS      16.75 seconds
IncrementalBuild              PASS      35.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,3/4] Bluetooth: btusb: Build the driver from multiple source files
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#169: 
 drivers/bluetooth/{btusb.c => btusb_main.c} | 0

total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14795598.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,4/4] Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#523: 
new file mode 100644

total: 0 errors, 1 warnings, 4886 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14795599.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,4/4] Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072

8: B3 Line contains hard tab characters (\t): "       USB I/F	|	   internal link	|"
9: B3 Line contains hard tab characters (\t): "BTHOST --------	|---- PERI -------------- BT	|"
10: B3 Line contains hard tab characters (\t): "		|_______________________________|"
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
Read Exp Feature - Success                           Failed       0.205 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.670 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/714

---
Regards,
Linux Bluetooth


--===============3395032791365040810==--
