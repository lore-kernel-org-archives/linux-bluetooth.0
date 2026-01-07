Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F62D6E64
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775483; cv=none; b=Ykt4l+C/q7hV8dbSkvgiTvJ2Ua6R4e8uu5szqz2/wh56S3Dmm7KUkRDBFrygb1ruJvPPDYoysYumsyoIry4Ec7Q3zHNhnPdq0gj9CsKAAW+tCVUv9yQdQF6pfOPXVGUU196mKbe2s3Z2p93W39/PUfzaq9pgBwal0arqPYIbJ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775483; c=relaxed/simple;
	bh=cwFImRhBRuqQTNDrYa2zmy/2R7itttm8gNuZVrYfaDY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Q4adjuO3SvFJVqXpp5HVsSMBYHUSUy6XRDfOe3CGO8MoSy90FXEhqncZj68WQ27BAEPzgFrhpqeKLgLjB4tZF6XS3BH5thUNU2wE5C8pE68C+Ul8QoMhr5OM807Go9VkPeV1dgr6/1u8LuQwDNaboKVV1kxdh5DHnJhunYJG+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I53sviaX; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I53sviaX"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-4f4a88e75a5so16397681cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jan 2026 00:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767775481; x=1768380281; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7CAKwH3QK/uK/KpuasqaCxjSGWebeNc93WtkyasjnMI=;
        b=I53sviaX4oOKf/7rxdzD6A2FvDzFTI080CE80wXNHixhUglX+mCu+s/SiSREaocHZ8
         WSBJlZpepORb9DJvEFLEtMY0Wp3/rQ3f/9EUQDnhtxsdxMJTXPNBAv3fJOR/YdnEZXHv
         00kuBReUlBuCtWEQYgiG5/Lt7A6pXDi6wYERosJ+xX6vMzZpySi/v0/D76AZqnMuO242
         47ZPa6HWrNagof6G1nH2xp7BuSkU+Dcm1qxZ/OAR80bFf8TXFoE9b8Ix8g2kok/8Y/Uh
         RTmutCTAm2hqw2iMYdqzISnCg1PvO4F26osPezu9eRyVAw4r1jE/4s8dERCBkCSw51nr
         YD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767775481; x=1768380281;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CAKwH3QK/uK/KpuasqaCxjSGWebeNc93WtkyasjnMI=;
        b=wax9WrzW+zqWucMIMHiGJpYY7du6gSMVIHGsrLxJyYVedM2zT+eemEfT9bPenYZEz2
         S1KQDDpOkGQEyGLUkr+/BnoBDrBgw3ORJgDRBzI5LEoUXo8pmjZvP1LFNHtpk7f0X9r9
         108Dx5oygl3Zg5FwuRavImteMytu9L48E7P9dhdeaqzIpWTKv7IcP1M47bNPjLbKfAt0
         J9e/f19Ey9stQ0y9bYMH0JkAhnPjEwIBlHlVS5bAd6EdZTH0sn+J1SK4CkEbWeUkpw9x
         mm+fNA9tNgfKJZAPMiI8JbvZ4UMgab81B7aniSgDIvcZyWF+qraMIVTLIJhmcS9b42va
         djaw==
X-Gm-Message-State: AOJu0YyPMGNFAW3rKQCL0xaA2iQq1wCcQp3uhiNccD1xV/UKPcTgcvKX
	0xfaAexst6QL1EloIdC1jqG8UqIgYqQKwT0Zt3HIgysCXLiwHWmhebtehykDyAth
X-Gm-Gg: AY/fxX4JqpYqk0D4aI16nHOjAcsLHlp5BPd/9+YA81rlpcsTJ3zytawbdlvcuz0HEux
	6DuHtv2VPk9x6fh2h8j/vOjGgdk13PmF2b4EvpHj97qu8m1GHtaX9fZe1Lwq2GWSqmSWe3jVXhS
	oRrVF2P4cjPxCaeZUfKgqP9DygWr4TfBitBkfTaqYYLQ/Pd8VEjT7JnarwLg0kSuCNM1HAVuM5o
	sDGR4ZO4VTdIo0Zr6YYTgbGPqn4u5PNmNDPhb5mZy+XjLgJfdMnPbvaXzgllPp1l2SvLDyiViyR
	lfzvK2gW1oPnCsz0HMUXopeBK8HOWSG5pAst5zsbeXDY3uUc5re/k/LQni2ta0oFvhFt23xqiCY
	Lt47UNJPL+0UBnI/tVzj9s0iT6A9zE5ui5S89H37AgSScaSr7pIa6wMBOOrd97PVKJ+2AAV5QFY
	ajiDN15fN3fGu0aJjnWpE=
X-Google-Smtp-Source: AGHT+IELLGyyVkEhBd+iLqRt4lPyzPj/BE9Eqdn8DX/F0mvnVh+KclRU1H4hOUilFmuoO14MIxPOEg==
X-Received: by 2002:ac8:5755:0:b0:4ff:b27c:c023 with SMTP id d75a77b69052e-4ffb4875cb9mr23570321cf.27.1767775480836;
        Wed, 07 Jan 2026 00:44:40 -0800 (PST)
Received: from [172.17.0.2] ([172.174.223.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e5d4c8sm26167071cf.28.2026.01.07.00.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 00:44:40 -0800 (PST)
Message-ID: <695e1cf8.c80a0220.35d582.a123@mx.google.com>
Date: Wed, 07 Jan 2026 00:44:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3488409540113960747=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ot_zhangchao.zhang@mediatek.com
Subject: RE: Bluetooth:btusb:MT7922:Add VID/PID 0e8d/e0d8
In-Reply-To: <20260107080154.2635403-1-ot_zhangchao.zhang@mediatek.com>
References: <20260107080154.2635403-1-ot_zhangchao.zhang@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3488409540113960747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1039270

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 FAIL      0.37 seconds
BuildKernel                   PASS      25.33 seconds
CheckAllWarning               PASS      27.76 seconds
CheckSparse                   PASS      33.52 seconds
BuildKernel32                 PASS      25.08 seconds
TestRunnerSetup               PASS      549.88 seconds
TestRunner_l2cap-tester       PASS      28.34 seconds
TestRunner_iso-tester         PASS      69.22 seconds
TestRunner_bnep-tester        PASS      6.19 seconds
TestRunner_mgmt-tester        FAIL      114.34 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         FAIL      14.66 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        FAIL      11.53 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      6.55 seconds
IncrementalBuild              PENDING   0.80 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.147 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.821 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3488409540113960747==--
