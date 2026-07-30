Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D1388E72
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405390; cv=none; b=pE3yUS3W5JBgSxzBdrNwWTzxi39qmGg/1E+cX+WdW8jpyGH+FL0gLTF6Fll9CkL7TuaeLvHyO+fMCss71cn8vC2CiCgiUPlj50XCTFAeyYHVpAa1pgnjUc75Ci7/M4NW03U5EoWUcnNm2mJBkKRPBJ7+xtiCqmcIbT03ZWjGuJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405390; c=relaxed/simple;
	bh=x41ncffwaMe83BcjcTtxJ2cHEtkOenRrzNz+0kLS0QQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rwX/fvlFn+AxyZZEezTJrXa2zBz6Ivig2Ce1YnxotTjy6dPd0msnyOfU/7oR++AJAwmM/7bH85YpwdOERhunwJS9tzIC0af+2NSteWQ7jbfHVm+NX3mPvXA+1g0DosW88EBvOwS4wOhsoYyO6ap6EjtbDIYio+d6KEj6lmCI1IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGF+SRq1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGF+SRq1"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-848d21bbaffso2143891b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 02:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785405389; x=1786010189; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9TPc7OnmGhQ48oT94drx1YwCn+ZzyQjGk3X9zBgyW5U=;
        b=MGF+SRq1w4eF09ODGB9R6iTJGwUvVOSdOrvz7LAUlmkuxfUIJyfhCqIlkg3Jp6rDyf
         tARMFNzMdUMBCw91lKBHZ+5Ots0oaOJlQ876fWYhU+rE4OzuXlishC7F3zA2oBDG59cl
         dIamgXH7nXxGV/ofGy6OBNNHaDf83xdNX4iSy8raqGSZdg2dHU8a7JFtTsRyPyQ0CmPC
         5Rtr3YTSQ+RelBr5/GbdPmvg5srMPqtkEZvzN5suPp42Z3fRDD/vGSkdsd3hXaY9PnQf
         2sbCXRBOSlxz0wqg+i9TTaLXfQOnbxYtJfJRVCYu0JLjRs8GyXa11BSJrR92YW+ZJ1eT
         CtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785405389; x=1786010189;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9TPc7OnmGhQ48oT94drx1YwCn+ZzyQjGk3X9zBgyW5U=;
        b=P9og2VmYZCMlp3j9yPhMsLIU05RBn1fznRxtybW9vdp4Q5kjNQ8JTe5u5DJjUXfi9U
         uRv5CI+Hu6u1lmNz/rjVtnODEH5GeUHviYYJldd+94XB1x5Qkr+fpekzQJBsVaAE23Tx
         kYLLpnK+j4FCESwyMgf4WW3aFIF4D+oHUjm8MYKAPAuZ8IasF+wUbbyUVaOfuOtDjm8H
         ezS3WfyOoB0v9i6GBgsdV6qplylFCE99hMWElXZPA67aQ+1MI5qHTHVQ2pqe3/RH3yxx
         uxuePhfkCcjYiGEEiz71nKS5Kz1t+3ZOJ+DL/+MfNSEdRd+pZjwTZj/WyzhZLtu75O2d
         rjuA==
X-Gm-Message-State: AOJu0YxX3GCM/IGQotoGkrRJOMCKBAb79TBzJu7rB/5G3BlOtatZXjxk
	WyWokYSYZKNs+ay+oAV1/OYVEefllksxFYW7i/7aisTGadtQqzD8W1fvAaoxzWXT
X-Gm-Gg: AR+sD12chIxg5c2ZU6QuB+Sv9Mcv7xS9EB3N51Gd3m7TXB/182upntRw7QlOmBLxHTE
	m8e4abxVwZ2mu3v5Rk5vyGo36+AR+OyiknA50xt5xcuS9Md0rJAwgolPgeQeYi2Ro/Hkyrc7cV6
	0BGE1Yi0dwMLeNRjoeWJrtHhPVZDXSJNw17s+MZws8lNQquF4PxwWqZM4j0+1T2PbjwgrK17LE5
	4HkJRCjAYssC7GrjjOYbFAC1xcP6p0XbaGVsBavyY7TzuhQ7WodStA/AOAgZ4naNtDzmqxm7ykM
	gVAAUlUXojnVtF0+FD9rdpJ3AWOCDa0ZD7AdR9ji/C779+eCcYEvPwhrmJi8CS8PdQiQPSLqT5D
	/UJzP105EnrjkgpRnh1D2Zc4Pfe67xAfCRJi4meVG8bGWf71y1c1oM8SO6Hh6dSuDaCcVhyJLGx
	omoDisgDp5afQrYLSHUy51QEbdYy1F0erl7Y5DETI+P1SB+Yg1HtE6C77aiO/+bhiVT1Zp8g==
X-Received: by 2002:a05:6a00:987:b0:848:2a71:a48a with SMTP id d2e1a72fcca58-84ebc1fd5a9mr1953044b3a.13.1785405388736;
        Thu, 30 Jul 2026 02:56:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.190.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02f8461sm2779249b3a.28.2026.07.30.02.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:56:28 -0700 (PDT)
Message-ID: <6a6b1fcc.037bf287.1a3a1a.1dc1@mx.google.com>
Date: Thu, 30 Jul 2026 02:56:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3076137030737250453=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: hci_event: fix LE list UAF on reset
In-Reply-To: <20260730083202.2065336-1-nicoyip.dev@gmail.com>
References: <20260730083202.2065336-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3076137030737250453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1137217

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.67 seconds
CheckAllWarning               PASS      29.40 seconds
CheckSparse                   PASS      27.88 seconds
BuildKernel32                 PASS      25.77 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      494.31 seconds
TestRunner_l2cap-tester       PASS      61.70 seconds
TestRunner_iso-tester         PASS      92.56 seconds
TestRunner_bnep-tester        PASS      19.62 seconds
TestRunner_mgmt-tester        FAIL      216.16 seconds
TestRunner_rfcomm-tester      PASS      25.08 seconds
TestRunner_sco-tester         PASS      31.17 seconds
TestRunner_ioctl-tester       PASS      25.89 seconds
TestRunner_mesh-tester        FAIL      25.84 seconds
TestRunner_smp-tester         PASS      22.77 seconds
TestRunner_userchan-tester    PASS      25.16 seconds
TestRunner_6lowpan-tester     PASS      22.94 seconds
IncrementalBuild              PASS      25.20 seconds

Details
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
Read Exp Feature - Success                           Failed       0.252 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.516 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/513

---
Regards,
Linux Bluetooth


--===============3076137030737250453==--
