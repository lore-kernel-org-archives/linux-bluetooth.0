Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D842040B6
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119788; cv=none; b=ps25uPjEujWjTKxQPLxc0eQY0yIcdi/RO7iqUK9j9zcyD/c6mtypslwtklgPizEG7whIWBYoYuFgIwNLpr/XYvqmRj5dOunE2FwLHuSuCc3K9OMtKHq1PSHKpiyqYuNAyMDLotxQWZ38AIpbXfhZn0vvtwDgn219CwUQB0ajhW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119788; c=relaxed/simple;
	bh=n3CsZNMqLAgCTbGOsixpx4WFDPPQD5iyD0vo51vtSEA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YtPpsBqeK2DbyT9kFbE+11P3U6kElNNHuyv5oMh/aBnUTM4k9YyEsDet9Q9kNGCvTM8wnZdMu/3w8VYwi+6kJ6HOTq1j7q/KWC4s8vPcTi7xEWiI2c8eSpKqLftvmmlAKMWSjgQJ3wkm3VVm9M5tTZVk21B+CWAfCyRzdfDTz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCgWZUVj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCgWZUVj"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234c5b57557so7312415ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749119786; x=1749724586; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+3xNWeQK2owStpaNJ0K8XolsjAYDu+xElG0tUxccCM=;
        b=XCgWZUVjtdz/s8VNGVbqUy2e2xw1Aw+sSVRi6NxbR2nL1nYIaa0Rz8H/HjKkVgzr4o
         yZe4P3N6quNRwYa/LKMjoAvdTF1gf4xrX1aRYMn90ZIDZUcsPGqihrKvDN192goaNFsd
         Kvu7R8P1JvX3q7oMZlgXaAzZ6xyBfybjwHx7EO0nUhdibV2zwfk2RE2AOu51oDL79v7D
         WJAEXNd396yqUwgHoVb8+gq/Bh5M+SzBGRSMNAl7uxvTyR0hzcKyQMKjoL90tXPBcoFs
         l+MEnKqjqxXu2RcmR+Zb5j0v3XrrVDpn7RR8RVL7CLPO34Xp4+sB8hNEkSU7RfID+kRd
         Gfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119786; x=1749724586;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+3xNWeQK2owStpaNJ0K8XolsjAYDu+xElG0tUxccCM=;
        b=wQIi3hw29a5RxGfVy8VB69OQrtpbUf/E9uwIWT7rH7g6T10iA3sUwhFIP8XxXRzTnE
         Jlgt3ner3KzlkzbJwHuhEWtcTIpEoNV3TEh79+ebSvzv1R9vutCc/Ylii4ER42c95IdP
         tJ1Wcj3/SY42Ube9iWuuLU4RPJ67QnszSbrR38a2pZoIq1z1Ikr5YxAWgrtfJG5auFgB
         MikK15yTkfeBTwseZqxU0KkKtC3M2yOZ6Cgzx6oQMPhgdxGnIK6eP6h6yiqql4iN+Vv4
         BoePm6mfgpE4hNvwjxj/dQFNuCtezlMfNKs8QosV5LegIXEnEMGndxC1sjmRG8HzzDB/
         P7Ng==
X-Gm-Message-State: AOJu0YxB3aQzx8gw9NwoVxHp0QRpBrvaGOcgqLoBvGbCoXY5+xR7CMjG
	xmkNuFVAnKVrNWFGh5lP3u/L1qUyuB69fx9/Q3S/SKGlx5rmpO7VyI8Za5tHOA==
X-Gm-Gg: ASbGncu8b9eBTf7A1s6ono4P+O3w+WmtjyPcLuL4glhnUbyuAUfEFNZubpUAGfr7+mi
	F72MdLo9rLft+9g335Q9HPu62jDUP4TGJLcMKpWmWeH2hRRdrbCKY3HT4Dvx5O9J3P8UPaoneNZ
	WimfFojYo2iw16nx7D3RlgOe9+xPwGrmhlR6BIGqZ3BqyJCWhidiOTQHGgZPdlcNqH4HoiJG8R5
	mEQ2Aw3+5YqUixqNJsNZ59zPLnrPfPF5c8DeYpFS5K9y8RgjXg5v60D2Rd3TsT+rVpFrAORvPzX
	rMGrU4jbw6lB/bdnQCmff46I1gTtz8PZD0UaJlnOLpHxwilbQ6Jd+Mk3
X-Google-Smtp-Source: AGHT+IH9QEClwPk3ndGwxopoueoY12ZQys2ZUm2BC7viNQ3knG4tepn6lg8gXl4pKc3GXEPSYoWUAw==
X-Received: by 2002:a17:903:1245:b0:234:8f5d:e3a4 with SMTP id d9443c01a7336-235e112bd56mr82775475ad.2.1749119786419;
        Thu, 05 Jun 2025 03:36:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.42.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc889csm117329275ad.15.2025.06.05.03.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:36:25 -0700 (PDT)
Message-ID: <68417329.170a0220.2ae944.7903@mx.google.com>
Date: Thu, 05 Jun 2025 03:36:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2756583539005654958=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ot_zhangchao.zhang@mediatek.com
Subject: RE: [v2] Bluetooth: BT Driver: mediatek: add gpio pin to reset bt
In-Reply-To: <20250605095300.22989-1-ot_zhangchao.zhang@mediatek.com>
References: <20250605095300.22989-1-ot_zhangchao.zhang@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2756583539005654958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=968875

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.40 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.23 seconds
CheckAllWarning               PASS      28.18 seconds
CheckSparse                   PASS      30.37 seconds
BuildKernel32                 PASS      24.90 seconds
TestRunnerSetup               PASS      458.65 seconds
TestRunner_l2cap-tester       PASS      25.00 seconds
TestRunner_iso-tester         PASS      49.50 seconds
TestRunner_bnep-tester        PASS      5.88 seconds
TestRunner_mgmt-tester        PASS      133.40 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         PASS      14.83 seconds
TestRunner_ioctl-tester       PASS      10.13 seconds
TestRunner_mesh-tester        FAIL      7.78 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.20 seconds
IncrementalBuild              PENDING   0.64 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76b/0x7d0
WARNING: CPU: 0 PID: 68 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.142 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2756583539005654958==--
