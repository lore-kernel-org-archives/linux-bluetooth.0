Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E4C41DED8
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230953; cv=none; b=qu6MK5ltZSPwDIYCNsicNH9dU4/WdoQj0/NdbxtV2+cXNvnSdqFNCV1AOwF3ksYzOVtsUHvX0CmE0V5so/sPVsK5rBg1pQLnsqucJbtPUH5EREVUxRq9mkKYz8rHFheVzlEzCvraGC2Dk9ghxpyiiSemDBLfVvLDMUdbASVXZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230953; c=relaxed/simple;
	bh=wK2+zikuJjUfOJbWZN1bA4SjCDv8wR99NnVWCUs4KsQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mZPUddKEuN9KUf2l43Q/HPTFEyxY4jwn1DFxVDH7nS8uWSfZ16mufqykuJILBD4ge29z/QxaZUzojp/a2EVH207QZzAhVGWHA2Ypb7MFowCOAP8giqKRsQ13f+OzrbWbzjXrN67k7y1YS9RzQzPtTnBXUJn022vO00SmqGvNhqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak8K+D/+; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak8K+D/+"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-44cedfaab6bso1350628fac.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 02:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785230950; x=1785835750; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K2CdWPHXiQu4VY5LmHnPN8zMnXEfADKtNqhKa6w8YYg=;
        b=Ak8K+D/+rqTN4R6HXgUPz72RzSlCPPDtmfLlezQRkXpiHvPib5TRsiiruL86X3t0fs
         F4ZJNil6f7OPi/ZzOt0qoRDQ/88OIy7w6+v+sO5vOB0KcbXKq9wUVRYpXISvccnBIiCz
         8lEmZ8NWoCrfF45GgTPNbeEaQcWqBrSBxplGCvSAvLfbuOvPEsztKfORmfEPH3Wl3jjl
         IM3UVdyBK3uzgfDKBPIyDOsvFNBvKHINDWK11uag0icortISzPYg2v13n65ospFdZLLV
         Wy9h3ymKi6748J91dPCLlO0XtMSsFup3gmbfAHznAdmHBVGkyTs2UqWVdSDXK4iI9++7
         czow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785230950; x=1785835750;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K2CdWPHXiQu4VY5LmHnPN8zMnXEfADKtNqhKa6w8YYg=;
        b=ehZ78ZZA9uAkI/DgGw2HzyZCXXhArjDb01Q6viLKVBm8PQagvLWYdIB2dUQumrQgB8
         OOEXq75HdLJEj91kqMSD0yg6dkFZgYBh26BNDq5clDbSa6smnV+phOLFyp1DqMJZwgqy
         8H4KKGoG6f1Sxbcg7wjvm4ppwPCtbAvfPhHkzX6EPu5lR6Nm/IuE4tLfNnLVM16bjkWe
         FjTbIw1sGGBAkE5tH9U+J0Ay5stOsVdjjTduGWW/LrQiSxCgVdJJ5p07rSE83aQJLFh8
         EHDab3aS7nq3v9lDbDeBViI573MHKEg2xohqb1+N/lYEzOkAyq8Eor84qeb8TdDJ38zK
         G3Eg==
X-Gm-Message-State: AOJu0YxxbMYKqQ1UJOVJD218SFB0jWaPCl/YL4PWiOMHyckjvaybp5+V
	eA6divaZ8CNuPZw0ZpJLz4qL4AcSoWo4yE4vr06pdpJiWrNsxDpYz3xegMoAXA==
X-Gm-Gg: AR+sD12rvMTq+ppqhlMBI8Wn/Wkf52L3jlkkEqP3vhvAKboohirKO7FeaClo9+QT3PD
	8hlBfTJ5T8mMKoUEjuR1/s/lzOw6sNUWOIIIIpGwNl0H+wC4ql/SvPermYgEy5sTYmvXWOBQ78b
	6kHgw8HCYN57ILvMWFumuerkz+vaWBGsu08JqEMNUGskGY/ARmmVp2ii8zDShA52tb/sSrg6TPb
	Fe3Z/5RF7JHrditC3ueoA/vXRoKzdA8qTcNzh9Ws70qYyDf5+ML+cvCyvQsGwThpcH1i0yODhNr
	2pLvKJyp3QkShtBYj7rEF/9/Uz6BqSSnYGxD7SV5XDaO0ZCj6JI/EQFn3eHqqamMJZoAAZj6MJy
	K/dDgTcCufolOdh/WMUEPu4Hau7qLQgncMLlED0R3WO6nJLqKHD3myKmdY7NN4xs32GdEsu47lh
	DbLNOolBEs
X-Received: by 2002:a05:6871:2310:b0:448:aaaa:6b93 with SMTP id 586e51a60fabf-4586cb4a740mr1076141fac.17.1785230950430;
        Tue, 28 Jul 2026 02:29:10 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.181.16])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45767488299sm18505218fac.16.2026.07.28.02.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 02:29:09 -0700 (PDT)
Message-ID: <6a687665.e28fa2c5.2a3ba5.c1f0@mx.google.com>
Date: Tue, 28 Jul 2026 02:29:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3847061652837704820=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: Miscellaneous fixes and cleanups
In-Reply-To: <20260727-generic_fix-v2-1-a57bdb81ac67@oss.qualcomm.com>
References: <20260727-generic_fix-v2-1-a57bdb81ac67@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3847061652837704820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1135668

---Test result---

Test Summary:
CheckPatch                    PASS      2.08 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.82 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      25.79 seconds
CheckAllWarning               PASS      28.60 seconds
CheckSparse                   PASS      27.02 seconds
BuildKernel32                 PASS      25.56 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      468.71 seconds
TestRunner_l2cap-tester       PASS      63.45 seconds
TestRunner_iso-tester         PASS      88.12 seconds
TestRunner_bnep-tester        PASS      19.64 seconds
TestRunner_mgmt-tester        FAIL      222.34 seconds
TestRunner_rfcomm-tester      PASS      25.87 seconds
TestRunner_sco-tester         PASS      31.54 seconds
TestRunner_ioctl-tester       PASS      26.60 seconds
TestRunner_mesh-tester        FAIL      25.96 seconds
TestRunner_smp-tester         PASS      23.33 seconds
TestRunner_userchan-tester    PASS      20.18 seconds
TestRunner_6lowpan-tester     PASS      23.27 seconds
IncrementalBuild              PASS      43.25 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,2/3] Bluetooth: btintel: Remove redundant (hdr->plen > 0) in btintel_recv_event()

1: T1 Title exceeds max length (85>80): "[v2,2/3] Bluetooth: btintel: Remove redundant (hdr->plen > 0) in btintel_recv_event()"
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
Read Exp Feature - Success                           Failed       0.260 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.362 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/504

---
Regards,
Linux Bluetooth


--===============3847061652837704820==--
