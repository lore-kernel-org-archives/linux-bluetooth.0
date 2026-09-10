Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8ED56852F
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066186; cv=none; b=PdZF2baQh+tlofYU01jy6TLs6jaeNIAOIgz2m3CiKnI5uKBwBmfDNCiv5l/Qh9/ikgkX4WDrcEhGpGfGW320BCeG6bGhsjVY8FJCVWQmRxfaOmVxbV9iIWgRKPyv1O1vyMHWxmoeoXJWWkAoWBIIDSiOTY1mbZSNq2ek5uZ2YbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066186; c=relaxed/simple;
	bh=HV4RTCrNy8JRfhdgbICMWWGwyV1mS8WSv5JVz8NGmo4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FqquLX9fxR8L1eLVFc6DPFlA3qq+7eI5TLYiT4axLCEbUYc2poJYWDxs3G5AOTKSzVEMBc1UQCgwmi+KHH8NY43NkwrN4mc6KHdpBLQH8oOuaj6CFs0y5zBG2VBr74Tv58SXvsY8/tki3Ukx+oiVvxpckU6jPMVwZ+0MQiOmvNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg9E2+n7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg9E2+n7"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9103f5b813aso268736d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789066184; x=1789670984; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QZMA1q767nmsU11vX/G98APdvsQxjRbDT63EWlxLtgM=;
        b=Cg9E2+n7qvEToX7Y9RwF8CmQt8GpwYPAbn9g2YjIIphA/u6yDvIRSSC9U7Bi90wES3
         vp5XXGmN5X3yFI0N9jOpit3/v+RhWQDelrkD7I9vIRuj4AvHb7hqQ2F58x0UF1HUrzKa
         Fudv6VbOxmzAWi5dB4SLQ/372ccV3XEeqPIqTDSZc4765cSYdEr3KXGTpbaexTbirwse
         WIFVnqpfveEPUDIAXOaEz/VVFiyB9tDfqlVwrmHWTy6d+RBhsWTet8YdJxso3GluUfLM
         beVn3NUVGDvtMcNKpWXpvsVRP9hDQv3q1nlB1/4lamRPGsmGYfJfie0GFsaypt3Wwiyd
         COmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066184; x=1789670984;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QZMA1q767nmsU11vX/G98APdvsQxjRbDT63EWlxLtgM=;
        b=L/Hbv6gs4ZzCuqFuowrhNh53y7qm+RDsOp41f1GjQ4H0YicbXurtxBL9BXIr9PRTek
         BaQyNaU4n0uKlSNVdnwkLiM2vTpyXFn/ggswKWd/cJ0Oc5LCuTpLkVeu2CRg1hIZfqLG
         Uiuz2gA354u+VgYeWxGQJJSQi/BYGAiCoW7GiSIgCkcrPgk6f4AQ3nLF323NSp+HSNv7
         Tyk8odSdP99swK6aUvTt+AczBlJstGTsrb/gYtD8+KGV6c8J+YgZcPACAzWFcZ+bcNvR
         DF2XM1cue8qqx9nyolKmxo+kPZxObFP/6+9owtm7kWO1dEkv7jeBxR9jZ5eMnnroNZXu
         dxNQ==
X-Gm-Message-State: AFuF++k6UxjgiiJY+sNjGYX9O72Cd2w1dlZJP6a0S5JrWy6nYnYSnTF6
	UZRqgNCXB3F2RwEkpCeEE7cjN+Ia50J6eBurmBoeT09hi8Xk8ClNTqEbD30H1w==
X-Gm-Gg: AYBFou0klXrwQoO64600nLk0s6nYehhz52mzTYWrlB6CehW98JrylM4T08zKIRw8E3D
	u9EyKGM9b2lE7/+G4WIQLhV36TtXLT3E57qzlfg72x1Tro9nrRdgkBNnnYGDJlHQitahisdrRfi
	5aobOP3flBAMU60uXBv+FSGXSZyaj28yFl2nHYWK/VU/4aQXOn6AI1jSOXy5H24VMX6NyaXIQwr
	iufm0/xWAhX7yfQtddC8sEMPdFLmnRKQjFFk1yCY1C4b12Cfdpe7piZ7Om1QsrYWiWEWsZota7S
	fhVQNUKcU0bDCRJ11Os0ayRu4y4HzzCvxOybazgHyINm9h+HcpO20wZGkUYaDmUGIWYHfu+2DNn
	ZGg7owc3zAsQWzrO7ITsRfZ5CV0x4FmfQBOMwfZMzU257zkxvuajcZC68YP8+rJf5Zc4HyOoMlZ
	2zUO1vjeyfUQiQrZIyVXsq+L7J2udXPiUQO0n8v6uUwQw82w7ZYT0+qjfJbPqNYHBB7BYUvEKkN
	WIYmg==
X-Received: by 2002:a05:620a:d8e:b0:939:93a1:1383 with SMTP id af79cd13be357-939ea2037d6mr18404485a.32.1789066181370;
        Thu, 10 Sep 2026 11:49:41 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.191.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80fcee6sm48235785a.45.2026.09.10.11.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:49:40 -0700 (PDT)
Message-ID: <6aa2fbc4.4a395752.27ded9.8aed@mx.google.com>
Date: Thu, 10 Sep 2026 11:49:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8986963034525386641=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johannes.goede@oss.qualcomm.com
Subject: RE: serdev: ttyport: Clear serport->tty after freeing
In-Reply-To: <20260819125748.194377-1-johannes.goede@oss.qualcomm.com>
References: <20260819125748.194377-1-johannes.goede@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8986963034525386641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1148478/

---Test result---

Test Summary:
CheckPatch                    PASS      2.47 seconds
VerifyFixes                   PASS      0.51 seconds
VerifySignedoff               PASS      0.67 seconds
GitLint                       PASS      5.46 seconds
SubjectPrefix                 FAIL      0.11 seconds
BuildKernel                   PASS      29.01 seconds
CheckAllWarning               PASS      32.98 seconds
CheckSparse                   PASS      35.59 seconds
BuildKernel32                 PASS      28.97 seconds
CheckKernelLLVM               PASS      35.10 seconds
TestRunnerSetup               PASS      783.35 seconds
TestRunner_l2cap-tester       PASS      44.82 seconds
TestRunner_iso-tester         PASS      87.01 seconds
TestRunner_bnep-tester        PASS      20.14 seconds
TestRunner_mgmt-tester        FAIL      151.26 seconds
TestRunner_rfcomm-tester      PASS      16.48 seconds
TestRunner_sco-tester         PASS      28.55 seconds
TestRunner_ioctl-tester       PASS      17.67 seconds
TestRunner_mesh-tester        FAIL      21.92 seconds
TestRunner_smp-tester         PASS      15.43 seconds
TestRunner_userchan-tester    PASS      13.39 seconds
TestRunner_6lowpan-tester     PASS      15.97 seconds
IncrementalBuild              PASS      27.02 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.151 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.856 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/735

---
Regards,
Linux Bluetooth


--===============8986963034525386641==--
