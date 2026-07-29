Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608242668E
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360045; cv=none; b=Cjx5XPD9AinmCz55yE8KxYdFmQCCh4XvPqXK5CzOXHv6KMq/E5mzpZSsZ9c3lsmM5Pc8Kp7KOY8AmkuWRMzbASViqByZon/Gvk+hB3MK5OVDHZlFdQdUwwAzeYZNRY0/SemeAgX4UXNX3+Hueh2mWQ6FBQGTjaY5HD7B19sHnS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360045; c=relaxed/simple;
	bh=zwZRKxxUFFPFGLb6nTntnpQtIx70OklnKXxzVfjaE50=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KWvobLvmD+KzupiuEHhl0dRAZd8xaugwKQ4qQ98FAKPWrBADH3cpPjk2kGP5RCkw7sh0UMSmorwt6IpsK0jFvxiqv1a3qgEW0rwUQclvrP/b0q9ktlBmseuhrEpmgt8tDIhMifjwm+FD+l9gLty6p8VXoefN9dt0sJKJKvH5L/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEPu05Ki; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEPu05Ki"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso951635a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 14:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785360043; x=1785964843; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BREOaT6m6r2ZiRozatjihbPWfdNJ4rf+Y3ZtKKGkzdU=;
        b=GEPu05KihlPvlEn26fzsc7Cs9bKY3X/HuMLX86Hlqmd3X0uUVYpjJTKhpzjUgZMIKN
         sdi8De1dBeApCT0dOFbGWYhKQuT7R/4TpDbcoeW3QBK88e46OPJTuL85m8l0sDrsegE4
         YgnljIL+GjwVWnFyU1tQlyEwghRNVApYuCi1cOMTEyZOAHHcTUhioHtc6q9FJOmf7bdN
         Ky7atoKyK7QvrTb426O3EcNNJlM9TrHiftHRqNfxfkSvVtHjEgze33ONhfGZ2hXeUdaw
         Ma1XpbL4xi9cWj+06WdGVZYKGL7g0DhXLbnvVHVdyQRaUqrGzq9Pkk9yYJKNlui68Mju
         wJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785360043; x=1785964843;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BREOaT6m6r2ZiRozatjihbPWfdNJ4rf+Y3ZtKKGkzdU=;
        b=QXyRHt92aXWbIQp9rK36e/o5QXzM/H/5+Jpfn7LGy/9Xm3mPPqDUOMGvc0eiD1k8sO
         JiAI49cCFoem9RLNhiNnOKmVRVj8qiCFCVnvwnzDdaRgZTcsOKBK/pssf+PLArKiofX9
         Vx1H+SDevNPEXjuNECv0BHcWbUXKeRQXj/suXerg2D0dEcwSdvHJcHcwZzTCPLXEZ5x5
         M6UU1OzOVl5oYD2wIwDXSBamJfk0NRwPbkeKS9MRu9m3q3CLpysC8r/66SW65swCyTd9
         MGUxTffDwCy5C/PzF3GVaqiCusq2EStppi0KJ1ri4mCd673EmAiGD9g5df3EShnNUClo
         t9TA==
X-Gm-Message-State: AOJu0YzcNwI5l5G8hHoRGUWBWFyNSA91/N6SROWWSm53qs2p5WDvTwQr
	CpfdjqWDYn725dD9z4PfrkWsGUTIm/rvB4QFoOlQwf/w0UGhqmjdTvC6R2nUYZcM
X-Gm-Gg: AR+sD11xJThAIetG2ERiN5xeXNtcJnAeShvXkLuEiEb7EICK31CEo1fCUpGdwaEdqPr
	O5kxB+2vytEkmlvtdTypnZXNMETaAp7ULfB6QH2PZ5+do1j+O4+zohWknSxRyi6RRPCuxXGD2qk
	FGDmk8/Bbw6u5Lx1SJCf92vGRLdEtsG4ObVe0LSKjU1uM5wiCzT2stXkhev7+rlB5WntMq1DTNZ
	6pBjtjQPr2XIq+MxALKyBcVVnc90UjG1n4jwEH/VxQr3xd0rRB8C/1FssN6kZDAyv6uDih14VYD
	GI3sHlSRjSiZsK4hmdl92w04599lXPrLhUcxAK20pRF12Ih4OdrVCCl2d8BxUcNkMfIRBWL7lC1
	M+ehgy90f7K4//jmOdetM9jHer3rp1itiH92terYtlHO37SI90Y4aeWTsBJOM20068X8q7LuV/m
	hjib8gIWYtuOPedYUQTO+rqh+K2LNNqgLa1uIcuoMJQeDsrNOx2VM+7Evsv01R8W1kHA==
X-Received: by 2002:a05:6a21:6b8c:b0:3c3:652c:664e with SMTP id adf61e73a8af0-3c8ba668fa5mr9803024637.69.1785360042754;
        Wed, 29 Jul 2026 14:20:42 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.57.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b88e12sm13243350eec.11.2026.07.29.14.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 14:20:41 -0700 (PDT)
Message-ID: <6a6a6ea9.d1496011.12e41e.57a5@mx.google.com>
Date: Wed, 29 Jul 2026 14:20:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5976319871588155911=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v5,1/3] Bluetooth: Add support for Shorter Connection Interval (SCI) feature
In-Reply-To: <20260729202422.2658332-1-luiz.dentz@gmail.com>
References: <20260729202422.2658332-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5976319871588155911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1136909

---Test result---

Test Summary:
CheckPatch                    FAIL      4.08 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.75 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      26.89 seconds
CheckAllWarning               PASS      29.37 seconds
CheckSparse                   PASS      28.04 seconds
BuildKernel32                 PASS      26.27 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      491.99 seconds
TestRunner_l2cap-tester       PASS      60.00 seconds
TestRunner_iso-tester         PASS      82.21 seconds
TestRunner_bnep-tester        PASS      19.03 seconds
TestRunner_mgmt-tester        FAIL      215.55 seconds
TestRunner_rfcomm-tester      PASS      25.69 seconds
TestRunner_sco-tester         PASS      31.85 seconds
TestRunner_ioctl-tester       PASS      26.71 seconds
TestRunner_mesh-tester        FAIL      25.91 seconds
TestRunner_smp-tester         PASS      23.50 seconds
TestRunner_userchan-tester    PASS      20.07 seconds
TestRunner_6lowpan-tester     PASS      23.06 seconds
IncrementalBuild              PASS      60.36 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v5,3/3] Bluetooth: Add MGMT Load Connection Subrate command
WARNING: Prefer using '"%s...", __func__' to using 'load_conn_subrate', this function's name, in a string
#367: FILE: net/bluetooth/mgmt.c:8178:
+		bt_dev_err(hdev, "load_conn_subrate: too big param_count value %u",

WARNING: Prefer using '"%s...", __func__' to using 'load_conn_subrate', this function's name, in a string
#375: FILE: net/bluetooth/mgmt.c:8186:
+		bt_dev_err(hdev, "load_conn_subrate: expected %u bytes, got %u bytes",

total: 0 errors, 2 warnings, 0 checks, 339 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14719204.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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
Read Exp Feature - Success                           Failed       0.249 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.836 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds


https://github.com/bluez/bluetooth-next/pull/511

---
Regards,
Linux Bluetooth


--===============5976319871588155911==--
