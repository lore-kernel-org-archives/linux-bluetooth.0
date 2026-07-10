Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88E416D0B
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682300; cv=none; b=HZ+DnXvX2MXDiSfIV3tuDrTAm058KxET17FJwA7DGIwQiVqeqhlyCXPfA4Ix0lV3OcvCGFKsc/v9uYwq/Oa8mcMDhPsVgv04afWYaiCf5c5FklON8TrIImwYLt1h6vj95zHLuLhLH/wEvFJ0afco8BLCLFuI8BmiXjUR/48fAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682300; c=relaxed/simple;
	bh=GpqcnbhRxgjvWe7R9lKSfABP/QGBM3R2ViveAXvszeg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U53dRYSylp8bUwGtUHO7V1w4FSf/gRdEC64cClhA914T9cCuDQKVxUyv0JAbiKSFbBzNTnd3aifQtxgPCvuN6bg5hT2+WfIJBElPXdRJsv5Rlny/sZlSqt9DW+5LlymmOR1Vq0/oPbFeCi4Q31ujazPhQLJQw9QxJHKJgbmhcaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiponF5D; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiponF5D"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9217d13c276so34741285a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 04:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783682292; x=1784287092; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zga12JDhBrPuHUUQwDty1mmsCsWgUszdP5n5GBNTl/s=;
        b=iiponF5DgSjGi165yW06svBO+vUXvek2a27w1BQ9UbVOX9QdESd8vRB4uwwm4inVpN
         P30wdxqcicfVvkf9qInQ/VaHQjslU17BbEYs6BFpKVWAC4JdqXzJ+aw0lE/Xwq/Vu9UM
         UkOjBfGlZEaSJnvdLYOt7shS7dlQA5SIYT6yqsxnmFKkLnh3vQg8D/QHhvlFQiNOtAV9
         sVqZKihad5SQPXZEConnbwqKNeqa9FV+ub7AesntjA4kMXrTCHExM28pIqFY3W/vYYv3
         S/t27lyHYBIS37GmTWXvNms8bDX0u6lWOD9jitSM4iXmGYb96LulT77Ch7dzElB/17KJ
         J81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783682292; x=1784287092;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zga12JDhBrPuHUUQwDty1mmsCsWgUszdP5n5GBNTl/s=;
        b=XBEBEkfADXU2wR8/TD2udH85ebJvnAUmsK8KK083uQ2L2wchtvqUnt1ptzHXGrTuQ7
         3NOX4POOwVrsz9wPByjrnyEW2i3J6YZc4LfeO/2Rx/YgS9qxKomyyLTxAzThQ2tVn4h9
         VbfAEQJ8S3gQdRlYnaqU5MIkkNYeRJamSpqzmPC55KE3Y1dqdXg8xZjwmWtC7TauPl3o
         tNkcMSK1T6aUjdV4vx4uYllqmIuA4LsfoXQA/kfaLsgRYTz43bsMX6UAF0fG0wMC16To
         PYzQGr663jmeZhV3b/Fogr1GnqoiAQWUq8T+oWrrf/y069QLOEyX4ieUh9Ige8UEeUa1
         EA+Q==
X-Gm-Message-State: AOJu0Yyt5hRyzjUP9IO9uDiYtGvVu16J52f3ArsBhj5UBlcuhQy4/gXJ
	ppwNXk6CbxOdjnteMmey3cwX5lXpljW+5f7hrmLZw1uTlAwTU/yvR11XXhlfzw==
X-Gm-Gg: AfdE7cnC4iwjnBMScsPFc254ftLdB+M1bhDXvrcj8uoRKl7PeWX3T/HE459SJ0pX8xE
	QqqpgqOJ7huqdZH8sYPKwD+M6T5N3bnpv8YGX85ScJUTGykrye/0lesozZWVSC8G+LhxuCRtuMy
	PIGURpz16oRpebqobIh4rR1M9e8vacPZlZYAr912Pn97YoCKq48M8S7yMSq+bWev8Tyko/R2TR8
	KFLGbkfkFjFOp+YXLKWPzpnylGUjx7FuBvzYcGljsgqj/0MeawcuBa8RbUNE1QPw1ww7F09ZXA8
	1jyfibIMGG5LJFJnCEImAqqoH+LLbG9ve24mDkYcQbupt6MTZepwvIioiVWbFbX4RojieJnCT27
	w5O249B6Hh8e9WOuj9c3tKuFe/kmJkV7PpKzsZv1EVzFW+l8FiNmnDo8g1WY8TEusRTqu7ZpXXB
	tI9hZ+AeF4gTWFu1UVVQ==
X-Received: by 2002:a05:620a:28cf:b0:92e:72a4:f291 with SMTP id af79cd13be357-92ecf612992mr1177978685a.35.1783682292408;
        Fri, 10 Jul 2026 04:18:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b86276sm171247685a.11.2026.07.10.04.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:18:11 -0700 (PDT)
Message-ID: <6a50d4f3.d6f58ba8.245457.f39b@mx.google.com>
Date: Fri, 10 Jul 2026 04:18:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2063932159008640391=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: fix hci_conn lookup RCU usage + holding refcounts
In-Reply-To: <4853db33fb044122e1eac76736c5cd0529d13349.1783671570.git.pav@iki.fi>
References: <4853db33fb044122e1eac76736c5cd0529d13349.1783671570.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2063932159008640391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1125224

---Test result---

Test Summary:
CheckPatch                    PASS      2.91 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      1.36 seconds
SubjectPrefix                 PASS      0.51 seconds
BuildKernel                   PASS      25.35 seconds
CheckAllWarning               PASS      28.18 seconds
CheckSparse                   PASS      27.07 seconds
BuildKernel32                 PASS      24.61 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      461.28 seconds
TestRunner_l2cap-tester       FAIL      62.18 seconds
TestRunner_iso-tester         PASS      87.34 seconds
TestRunner_bnep-tester        PASS      19.46 seconds
TestRunner_mgmt-tester        FAIL      208.74 seconds
TestRunner_rfcomm-tester      PASS      25.23 seconds
TestRunner_sco-tester         PASS      32.15 seconds
TestRunner_ioctl-tester       PASS      25.37 seconds
TestRunner_mesh-tester        FAIL      26.07 seconds
TestRunner_smp-tester         PASS      22.99 seconds
TestRunner_userchan-tester    PASS      21.93 seconds
TestRunner_6lowpan-tester     PASS      22.15 seconds
IncrementalBuild              PASS      39.87 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,2/4] Bluetooth: mgmt: fix locking in unpair_device/disconnect_sync

18: B2 Line has trailing whitespace: "    "
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.287 seconds
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
Mesh - Send cancel - 1                               Timed out    2.786 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/420

---
Regards,
Linux Bluetooth


--===============2063932159008640391==--
