Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593803BBA09
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914964; cv=none; b=fXz6gMN7QB3cVSSFIa4eTRaClaSIjQJrI/Ikl0ZVexG7/kicJ0/ljQHm2rsvNfPbEClNt/fs0cbXLdcq9t7240+TDryDRqLITPzUJvV/d5CphGMdoRCQ1VOtOxJG+/7ChE/0Zd6WT045jQi7Lwkr2l+rdeUxIqDjmsc6NheK1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914964; c=relaxed/simple;
	bh=Q5I68627WT+fSeM/QgIW8F8CYaQCE+Y0uzrA8y9/XYM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z7gR5SerQtSzZSa/Xf6d0bqDEjk4whpE69fOXUUK4AAM8UeJH0aGHVWi3xSNJCKSd/hfuQeyId2bo+VeRq0VeX9w+ziq58sQvnkBgFJiLj8eaHUiEiDiFECU3SufLHBQgQ9fe+DQRJxlb0NCFj8iodM182dE1Y0AySnyGPZyz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0TvRCq+; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0TvRCq+"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12a695044a4so1236471c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 03:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773914962; x=1774519762; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CUkyRZeHWISGV8kFBFLZGfe8wXftA2cEzw1Kda8ONrc=;
        b=e0TvRCq+hMrO/XPk4MnJ3vZiDhE/GmPywXG7mT6Pc3msBQQAoQteT76YvGHwNH3aE5
         FeFFWWe3d0Djgv0LWF+xmEpg0W3JzG1E9xvA+yFbBPttE9qkjueCYCHf5ofCnxjw999w
         09aCqz1k7Fn21ru6XEmjla8IhoPCWIrpdDPBna2nDFs2+pXosGc4K6kELWTfHscSFxhi
         MFy1NGpGeTFPWfLfuHOuzPRKVDFPX4LEqvFzaMhSkQsKljKosE2qH/xjriBY62kfgghf
         OWNzg0obKVGhZQ9pA4DvDiQ6E0YtTcwDHApGNsSXNrg3Zx0LCnLU2kIRUJWwuZIAGGmz
         iwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773914962; x=1774519762;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUkyRZeHWISGV8kFBFLZGfe8wXftA2cEzw1Kda8ONrc=;
        b=AusNhwyaI3+FHY4xdPBuDi1l7WwkhhPgLwV6nRnUOZLJut7ZpRKks4NW5jXA6y+Ud+
         dGjzuORKFjMcSwfEIdZJUFfO9i9LI8au9Xm3bsoUpWy/S1tIGSSHB06SHUnk0K+l1arZ
         br/ccUra5s+sju+irPv2VLW2YFZbAHdefgQs7iFJ5yLzatuiLygCZSkWwwbTo5BkVDhG
         BjP8ALudTP6Im3ok8Yx602GCSrqdg6OoZ8Ggd1SpDEE58FEhQkYXmQTw72UQLKjnuDPQ
         B5agk+madL+y0u0xNf8ajZsh4ZQjZ0X11Ids0iQstW1au9pHxwqMraScByR79MUx6Scq
         Ldtw==
X-Gm-Message-State: AOJu0YzkMbE3a/NvZnoZX0v2tc9lWhS5gIriKmhHEqvHYozNVm7zCEn5
	afY8dpyxFR+N8kYK6AojvqRDMiQ4xhH3HaJrgVO64GNapOGvhYX1apTHohjiZA==
X-Gm-Gg: ATEYQzwpj/ZHjdXfoxUtcZU3kEfywtHBaKNAQK0BvrN8wR/gzU9wPGFIfsUoIDXsKIA
	rV5xwFzEWW8IB9Zn2vgJwAH+uCJmApOJJT8GENQbXBSOq+0vDF0E6T+YFjg+wyYcwV2jIEldJdQ
	WsJ+A5/Uga20A3MyHiTNg14qiBOXXM98m0dqbluSGqltHkcprdvPl/rZazcUn1W8xRHYNQdlWQj
	q11PbT2Z+JARDVoCpX5Qf6Ab9Jqvg3X5Cy1sYqt974l1pv67wilex8nFB76qrjIpUEjehZbsOcI
	MbiaDeE7Hg1UejGyOfvatlJP8BO+tPEHPsVgRizixF08/i2xXyEvihiiEdx4Tq3osmUBFaHLO58
	VDjzT8uWe7LGMY+nbAYGEsN5sp14pwHsiMq6CP+ShZA7w9yZDVt2FrLmz73hY/YWBvDZZZKU7UQ
	ISu2LTguyX7aaGLt92mhBHe6QIiK2JqIIArvGMVoaRlA==
X-Received: by 2002:a05:7022:f317:b0:12a:6c84:6054 with SMTP id a92af1059eb24-12a6c8470d1mr218766c88.35.1773914961924;
        Thu, 19 Mar 2026 03:09:21 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.210.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b4136c9esm5861804c88.12.2026.03.19.03.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 03:09:21 -0700 (PDT)
Message-ID: <69bbcb51.050a0220.30520.fb76@mx.google.com>
Date: Thu, 19 Mar 2026 03:09:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0102752183690622597=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangchen200426@163.com
Subject: RE: Bluetooth: L2CAP: Fix send LE flow credits in ACL link
In-Reply-To: <20260319093211.2239158-1-zhangchen200426@163.com>
References: <20260319093211.2239158-1-zhangchen200426@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0102752183690622597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069160

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.50 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      27.19 seconds
CheckAllWarning               PASS      29.27 seconds
CheckSparse                   PASS      28.12 seconds
BuildKernel32                 PASS      25.99 seconds
TestRunnerSetup               PASS      570.00 seconds
TestRunner_l2cap-tester       FAIL      28.05 seconds
TestRunner_iso-tester         FAIL      30.47 seconds
TestRunner_bnep-tester        PASS      6.47 seconds
TestRunner_mgmt-tester        FAIL      114.83 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         FAIL      14.62 seconds
TestRunner_ioctl-tester       PASS      10.18 seconds
TestRunner_mesh-tester        FAIL      11.63 seconds
TestRunner_smp-tester         PASS      8.59 seconds
TestRunner_userchan-tester    PASS      6.64 seconds
IncrementalBuild              PENDING   0.99 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.114 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
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
Mesh - Send cancel - 1                               Timed out    1.882 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0102752183690622597==--
