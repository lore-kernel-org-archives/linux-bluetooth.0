Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B493B9DA4
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532444; cv=none; b=F+l6uPg3BFQlwb4lHsZl0fBOMLIUGQQdV9hdzo8L4AAWKjcO4SdwI/PAcwbSffb/k+ZvNuPRfbDr04g2E2nliFVVKEZ5o1LZPmLByt/3fvbioX1POCb9IRQrnwKulkcJeIDGyIIoZIjyfR6I+nYgKqXOIdzbrGTldSeUDfwDUiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532444; c=relaxed/simple;
	bh=4Om6qyLwJtGIvPlYu2vI5irh/sc2tnZZsWvCHV1YRE4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nWb8c8j2nvmnnrxBgFuRFJZHIYEjpVLHwyfDapiR0QePQQ6SZlXGV1SraB/PQbIrLkD8o+Gf2MRA69N5QoenY7CqlixLpKzL6CxEiBnerQA+EPS4bjeBbhsiovbkyX1QheMNzkXjEyWjtLfWLegp0+DAvkH70IV4j8CQn1j5BZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpQyNDBx; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpQyNDBx"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92ed19f4d60so310237885a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 00:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532435; x=1785137235; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+WtNaQs6IFV5I7qBiLh8zSIs1DvTq04FXDNL/KGfsN8=;
        b=QpQyNDBxWIkjDFpBuytpyrMH6CFb0ngXZEYYRJFWQkoq8gtGVVC+RK+wTkQnjaLzhi
         IW9jGP1wxq/Ncop6q3+MX4EOhXkD3qvULmcBNnnGVHk7lq2N36vgH1RiVJtgkZ53K4yt
         oAgGdZ+3xSbH/USJhDHN4fZ+NPQBELZQnXnb16SgV+NukajpuV58Zhgw+W78wyxHAicE
         +YgvtYx1V4OfI4NstdasXDsb2lN3+/pPJYbjUBlqP+OAn68F30w+m1784erDbki1xALC
         Nu5v/RFvn9LT+j+LfK20sAmI9XUUu0vSUCLsGwijJ3kjFjJhkpWwvZIRTrCnIAVIScm/
         PnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532435; x=1785137235;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+WtNaQs6IFV5I7qBiLh8zSIs1DvTq04FXDNL/KGfsN8=;
        b=CxVQo+qfoJxY2hszvpIT229R0ZKkjWRqXq6a0Klgc0nfC408JZM/FAmNgRonEyUGxk
         nfQ72r5n42a/ezO6HZnj/YEuBnyzv2gJiNIe9RA8PW5yBVNiS/6ZJnPgEbRCZIzd7E9T
         SKzE4K3UKqnYBBqzEZ805QfxT7CJonkSTflCHNlbasjGwr1qF85d3OJZArOGE943AoLh
         3W54RtXRo5pQcQXgsHp6yFxWushoNkZWkS+cC1o+cx85nH40QfF6Uv/KVnkLtQAHoLIq
         2Vsi1U1ILqGKf6gR6mfnyktwPhosv0+c/xV4DKAv93yBtWFMG5++196PGKyKsLxLL2c0
         eSvg==
X-Gm-Message-State: AOJu0Yyb4OLq0fC3dbDCu1XoqUbe+GLs9L8GEDPKP8cQPbaiyidTQAst
	SR9QU4XYBSk83VtVnGoHJrp8dIR+jC8M5e+OL3j1aiMZtpwAOXcaoofNjBheMQ==
X-Gm-Gg: AfdE7cmc5WGLrZaYXQ97P3k7aMWVouNO06AATqIvYec0y0/5Op+wDKA3RSKpUJ2lrrL
	Z74MUX8DN05tQD7SdNgee5BIrk/SkjpkcElj5wl0CB0iz8JwA/Zw3neTnz7dObP47uIw3WXZL4q
	tt3ECd9Kq9m9ddeVirM+lh8pdsVsMim1xppnlVpM1dvu9mdc0Mrk0bo+GxLodB8oTeY8AIEnHK4
	W5YR/92wanbw+YixtHiao7qkQNUQdUHLOql0/vLlwVhf7Yq5FggztObLVzjHbM0BZp9sXRMtL1D
	7WBVgl6RN2oKPK5b+whFa6YExuS2fr3tsEM/hom6vOgQspM6IjxnVpcohcgLCAiVdgVt8aW8pDc
	j2PU64aQzNJAaREp/fHLVv6a9JoktdCOEJcRJo4w5uYfrPpYKQufdU8kWwA3NyBXpYr+BYjvXF+
	B2WKfzU8/ScakUKHdf9g==
X-Received: by 2002:a05:620a:440b:b0:915:5216:e5bf with SMTP id af79cd13be357-930b492fe84mr1244245985a.22.1784532435049;
        Mon, 20 Jul 2026 00:27:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.222.82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52fa8dfsm818461385a.11.2026.07.20.00.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:27:14 -0700 (PDT)
Message-ID: <6a5dcdd2.d6f58ba8.b07dc.472a@mx.google.com>
Date: Mon, 20 Jul 2026 00:27:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6574271992990624621=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, enjou1224z@gmail.com
Subject: RE: [1/1] Bluetooth: Fix parent socket UAF in accept queues
In-Reply-To: <65767989c644f8adf52f35334f4034c66f47881f.1784383243.git.xizh2024@lzu.edu.cn>
References: <65767989c644f8adf52f35334f4034c66f47881f.1784383243.git.xizh2024@lzu.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6574271992990624621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1130532

---Test result---

Test Summary:
CheckPatch                    FAIL      1.37 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.05 seconds
CheckAllWarning               PASS      27.83 seconds
CheckSparse                   PASS      26.63 seconds
BuildKernel32                 PASS      24.65 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      456.17 seconds
TestRunner_l2cap-tester       PASS      57.19 seconds
TestRunner_iso-tester         PASS      77.39 seconds
TestRunner_bnep-tester        PASS      18.86 seconds
TestRunner_mgmt-tester        FAIL      208.44 seconds
TestRunner_rfcomm-tester      PASS      24.73 seconds
TestRunner_sco-tester         PASS      30.92 seconds
TestRunner_ioctl-tester       PASS      25.33 seconds
TestRunner_mesh-tester        FAIL      25.92 seconds
TestRunner_smp-tester         PASS      23.06 seconds
TestRunner_userchan-tester    PASS      19.67 seconds
TestRunner_6lowpan-tester     PASS      22.49 seconds
IncrementalBuild              PASS      23.44 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: Fix parent socket UAF in accept queues
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#128: 
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4

total: 0 errors, 1 warnings, 0 checks, 47 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14696741.patch has style problems, please review.

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
Read Exp Feature - Success                           Failed       0.234 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.553 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/459

---
Regards,
Linux Bluetooth


--===============6574271992990624621==--
