Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AE3DEFF3
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357148; cv=none; b=O7wK0XAUogeh1onLtnaGf/9SIcszguWrlEFuddo0EagI21e1Ov9EXIvMD6saYKMYQCLSUsYlKaRo5i+HNlwM5G7KvYDjJRk5he2IpLFL9Y+dGfUCTzTANsKYuWCT5Gpz4GPHFUrk8OgRglJJPc0j7qhuzWkmEVVApD6Zo6WXI2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357148; c=relaxed/simple;
	bh=Udh45QfVg52ns9+e3SWv8GqPe94QMB4jdDsw0O7mN54=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qg6HJ7kfcnROLqFC/qtE+zn8umVDr5dNbiOJX1TwjOO9Q7WqbqEI0rakip+Wi0ywv4EEKwXbYALDayqGL0Y8VGPSJD1jg6OrNvN+neDpJsx6cOy9+BH7Tagg8iyi6NzsucdfOGkTJ2uYrCOyE+/4NlJVja2FtE7zKLxnfAJ1olQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l39qMIRe; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l39qMIRe"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e7632b193so112880385a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785357146; x=1785961946; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nPDWniSxPPYZrJTjqeWrKBny2skahnB0HHphsKZiXLA=;
        b=l39qMIRe+svweJFf25x4fArwMyjQiMC4gTl9N8zYSMZoUNnD6vd5mTC/2e7UIx0ZRN
         lYmQnDmqQYVR6NeLLsieVu+b59TeFZBzLwyMkks2149hug7b4JbFPErau5jdtZMjpnGr
         iOwsGV8gCtPfJAOcUtdR5gWCUcZHTDo58X5WX4BMgB8MU0zefsPfbfUZGmUY72lO5mu9
         TnnnqTxEINk7+Rj6nlsw0CQambvo3flQjpg9f6ADY6hiRt6sB273KxlPff/2C9Bp0Hec
         A9+E8pZk5nRaYzjPQFWolr/quNdp3KwO+KCjhKBgmtol5x1V4507e15VUoEG8Crf+OpA
         Enow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785357146; x=1785961946;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nPDWniSxPPYZrJTjqeWrKBny2skahnB0HHphsKZiXLA=;
        b=cB74iQ8nWMAWdAJ3WrX1sWgnn+Oc/Yql9fNwBiucYUxSONL+bkiYA8zVJ9GGHXAbwb
         Vyew1LWtmAZEGd0gflt/3ykccZAoK0+YXjNNLuQ/SbooLshAnLJtjKiHhkhTq8GAPHJH
         7/bhIYbo5Xgd+A6AaSMaZ6E6UGcxtoaa5vYkG+EMHXpPld2/P9dMUXeqUpX1qBaNhhYv
         xFAomuq26korngGIrkGwqMvf9FrFRpYyWEjB5S9bOzPdIRaxvt7Wv91lp0Bn6JTn2rll
         zvjlh8M4WEfh2C51foVVLsEURP8lxNa4mywBLMIcSHz5xZUJNnnI2Nz+DmPL7dLqpdxQ
         8ijg==
X-Gm-Message-State: AOJu0YzAGn7rSQyIofBdpWmnIamKt4hXgZqtqW65+HA9OHfrlVkd9rgm
	i5LGt/3ylTkDhpY/KXIJzmSTvxc9ZiXRVB9CcVkT1JGx1O78n0NdvGvEbevZ2A==
X-Gm-Gg: AR+sD13kYEDaMrDKSHAVMmojB55XNVxB0+1EMdnKF33+RDly0qC2c4LxrYTl1AOZFSy
	5jO2HB7niRlbj9/yL/egy/uayNTJ2yd1AF9JQHAbts7T4CuUydnWoPLEONYFG5NatI7m1wQ0tjK
	254QqhcwaidFrafulPi2ckxDHWEYBu4/IFmFTXanr+zoD0wLbeWEU21N2Bz/MNFPpb8eYua5C8J
	fJgFJNyxi46fK5WxJq4a4OHHiVEbc0JcUAI0bLqVkOLq6arCf8hFB8P3TrUpGra+MPxp6m0CGxS
	JrtKpPMZfx7sHgl2p2QQRb4Id0vXMrMisFHevlTNoPJjvFY7UUiWLiv1wP6804qZvlUEVxMvY3+
	7ZShcmN9xX1SFeg5pmmwhc1GP2FxN5kmiRIVlVPiwI2t80WHcY3Zq9iUutAn3c3BQEPg3n+tzIc
	D9hW7Q/HofGzJfeqwjCkABGHV30ZDG/H0rlLnOSFn86cthxcmYTm4FH2KMMLKYYodc3Q==
X-Received: by 2002:a05:620a:3715:b0:930:bae4:65c1 with SMTP id af79cd13be357-93483f59d39mr42811385a.91.1785357145754;
        Wed, 29 Jul 2026 13:32:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dc68182sm32653156d6.11.2026.07.29.13.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 13:32:25 -0700 (PDT)
Message-ID: <6a6a6359.a8f5276e.3c25fd.2f8c@mx.google.com>
Date: Wed, 29 Jul 2026 13:32:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5458420941403001178=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4,1/3] Bluetooth: Add support for Shorter Connection Interval (SCI) feature
In-Reply-To: <20260729192002.2636087-1-luiz.dentz@gmail.com>
References: <20260729192002.2636087-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5458420941403001178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1136871

---Test result---

Test Summary:
CheckPatch                    FAIL      4.41 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.38 seconds
BuildKernel                   PASS      24.98 seconds
CheckAllWarning               PASS      27.62 seconds
CheckSparse                   PASS      26.23 seconds
BuildKernel32                 PASS      24.31 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      452.58 seconds
TestRunner_l2cap-tester       PASS      60.27 seconds
TestRunner_iso-tester         PASS      79.99 seconds
TestRunner_bnep-tester        PASS      18.81 seconds
TestRunner_mgmt-tester        FAIL      216.35 seconds
TestRunner_rfcomm-tester      PASS      25.45 seconds
TestRunner_sco-tester         PASS      31.41 seconds
TestRunner_ioctl-tester       PASS      26.35 seconds
TestRunner_mesh-tester        FAIL      25.23 seconds
TestRunner_smp-tester         PASS      23.44 seconds
TestRunner_userchan-tester    PASS      19.89 seconds
TestRunner_6lowpan-tester     PASS      22.82 seconds
IncrementalBuild              PASS      57.20 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,3/3] Bluetooth: Add MGMT Load Connection Subrate command
WARNING: Prefer using '"%s...", __func__' to using 'load_conn_subrate', this function's name, in a string
#367: FILE: net/bluetooth/mgmt.c:8178:
+		bt_dev_err(hdev, "load_conn_subrate: too big param_count value %u",

WARNING: Prefer using '"%s...", __func__' to using 'load_conn_subrate', this function's name, in a string
#375: FILE: net/bluetooth/mgmt.c:8186:
+		bt_dev_err(hdev, "load_conn_subrate: expected %u bytes, got %u bytes",

total: 0 errors, 2 warnings, 0 checks, 339 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14719084.patch has style problems, please review.

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
Read Exp Feature - Success                           Failed       0.252 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.832 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/510

---
Regards,
Linux Bluetooth


--===============5458420941403001178==--
