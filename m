Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CE925B0AC
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788835; cv=none; b=vFiHSadzzggPbP3OhGsQE//syrhQ+2p5eDxWYtYSHg4gCcU63PM30Rj9iiSFaXy6R6NbaL4GhNAtTL2xyjIp71bDhxJjzBczVDQZ1bdScHGOQCvjdJAHDyaU+jhpqHBEWu5j5L4iU952NxpLfBlqe2zI4AjpoxEheLOP2kYr1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788835; c=relaxed/simple;
	bh=/4+qn1CSrocsKliEN+7VsMR//pUR9PzGBV06npcux9s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kRs1azWkjG0osfpaOkkB/uKV7kIP/3/JkXC9ICvorXme0ABtHIgfmm6ZnoLo+sp+P1xOqhEpj2nZlTx7tAul2jeb6xB/XHgV8ETKeCpuF6caEGVMBRoe0dG8Qdlpjr6onOzxa8AlbYlEOU2isc5/Rolr81fFkmtNdnXOVTbfd48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9VuDUzF; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9VuDUzF"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e6cee520ccso550070a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781788833; x=1782393633; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Nd6MZZy2if00XtW4Hv28Q0+TOZRPauUtpMLZszEMkE=;
        b=j9VuDUzFii8DDX2NuG472GTHuyjleHuc2v3C5iNdhe97CI+fGx1f67ap4Rnbp5jmDL
         mufoedDJqCxCdW0Q9RJDPToWhmEp7TSIuMQ7LMCUPdaiehd+t6vBPUSm83iKibB7EehI
         olSkzrT3/hSh4D68irJUz9/SZBu0oBL4M3ubYrm2OCJj+GU7PBbrolBB+FfTDLcQPeU2
         rXf5itqKWmTOYxz1I0r8gT3XHeYbTqFgXLxAA/loIOn51UQ5vNviLf0HrfL9RrEut/4v
         lpv+z+OeLa1iSoxGs15N7uf081tUrKTSmLX+yKEHm6+Xj7nMJiJmS3nUvzgPYjRGBZW/
         +Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781788833; x=1782393633;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Nd6MZZy2if00XtW4Hv28Q0+TOZRPauUtpMLZszEMkE=;
        b=mwh5M0VrEQXkw2+65QJngVEGicpAN/eoc8cuLR7t/amI8PdPKgj9dW0Oj9F5NQJDQx
         RbomjnOITnwkr/iCJQE7dYjmvuB4p75UO6MKNDKsl7wV4trGQ6Lj2XPdLJG2GlR9kDen
         8exvYeVFeHq3nFJ1HoIbHnrMa7WKl/W41GcExd4f6NXNUZ5+WVPSvQTReetdoMSfnsqu
         nvTBn2N2cSlK+iCI3INKWIdAplk7v9x1uS23/UpGXQYsLR6WY5DmeMsmFKhjux8yplUA
         QsOuTqa75LouM+v709FgeNAdoT+HQH7ptAhxzXbVsRslsc6cbuSjAzrV0Pw6KmuiDckU
         vcig==
X-Gm-Message-State: AOJu0Yx+QiiTi4HVvd8BpjcqMnh+5LrzkzY8qsHRh9mZ7MqXldsL/fIU
	IkaLyqlHlJ0zt/bgwv/vgUoFwKZmqmHtgl6YWCutK/T/zY0GUbZExM5rwm0Uxw==
X-Gm-Gg: Acq92OF+wNQYItpc52rDjXwhVKZf0hOh1Xl+nuzc/HHnZFWCk+ZbP1V23AXGJyQnmg4
	2D+E7RWoKCpKwpVsWtdjukuvW2gf1abA2rqBuV+qya4zc7cRd+oppQPnOFAhqNMmDy+qJb0a/vw
	z/uIfL5DUoF/ViSKYMvA9kv4rMKbYa8yuWhMcNUm3HZV1qfW+kdTImvSA2BYNIcRJQP3VZPcEvn
	qGI1gKoTnoLu8fxA+QBHuL9ZjYxalWsmyt1qRhoww8ZwKiiOieD+q9heDuAnCepg0hHnbGjoA1t
	uAopZtmvUtZ1TE/0km1m5K1AErcZ1O+jcwIIpt/gDpWQNQlzf3kWd+fqtbN10V00vhsdfU02PUM
	4l+aM3xa7TP3VOwTBxkXzZS6id6hRUU5qMnD7b40OgloygjCtSMjl5Qh3CQo2IA3XELY04s7RBn
	Y6GW8ZiZmLh8wZaDfkrt4=
X-Received: by 2002:a05:6830:6413:b0:7dc:d7e5:8d43 with SMTP id 46e09a7af769-7e91aaace79mr2870543a34.2.1781788833044;
        Thu, 18 Jun 2026 06:20:33 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.38.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a12e4sm12528408a34.6.2026.06.18.06.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 06:20:32 -0700 (PDT)
Message-ID: <6a33f0a0.7aaed6a2.1a2201.202f@mx.google.com>
Date: Thu, 18 Jun 2026 06:20:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6825203598664667638=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: mgmt: copy pending command data under the list lock
In-Reply-To: <20260618102134.3339999-1-zzzccc427@gmail.com>
References: <20260618102134.3339999-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6825203598664667638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1113386

---Test result---

Test Summary:
CheckPatch                    FAIL      1.09 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.00 seconds
CheckAllWarning               PASS      29.02 seconds
CheckSparse                   PASS      28.07 seconds
BuildKernel32                 PASS      25.88 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      575.19 seconds
TestRunner_l2cap-tester       PASS      57.33 seconds
TestRunner_iso-tester         PASS      77.04 seconds
TestRunner_bnep-tester        PASS      18.66 seconds
TestRunner_mgmt-tester        FAIL      207.50 seconds
TestRunner_rfcomm-tester      PASS      25.16 seconds
TestRunner_sco-tester         PASS      31.86 seconds
TestRunner_ioctl-tester       PASS      25.58 seconds
TestRunner_mesh-tester        FAIL      25.86 seconds
TestRunner_smp-tester         PASS      22.94 seconds
TestRunner_userchan-tester    PASS      20.24 seconds
TestRunner_6lowpan-tester     PASS      22.17 seconds
IncrementalBuild              PASS      25.48 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: mgmt: copy pending command data under the list lock
WARNING: The commit message has 'Call Trace:', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 113 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14635032.patch has style problems, please review.

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
Read Exp Feature - Success                           Failed       0.237 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.645 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/331

---
Regards,
Linux Bluetooth


--===============6825203598664667638==--
