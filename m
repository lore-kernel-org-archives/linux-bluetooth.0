Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89FD1A6803
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jun 2026 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782613811; cv=none; b=OjCgx5qStlBA65f1feRr/8rGISxG3NJolr8a/BXYqhPg97RSx4223488dLPMru3Pg8rXV99M+uzZE7B3hy6Skw5xDQTWsU2gNNX5GuhGDGEcOvNZsPze3uE+d+9VE8AQlXron3frxCiklvKbpOCOtOccVlk7YlOyDQx/qJHFP84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782613811; c=relaxed/simple;
	bh=V49e0bD6LhrP3oLtzzluS6jgRePD2GF3gW6LMWYfS+c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OjinruEiYEJ5QiHLwfeRhZf5nuLtge6d+Ib5ElAIQVRXFVfVoE9mbW/CT+9FimLOUq2ZwXhd/NCZwH4TPyId1fPaS0R6V85twpng2Sqtneggnp2p6JHu2JabwB+EjikWhA4UPE8eLEVbdBJRSyBm8Wx1HYQfYrvEHanUK7rDLt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVnPdLc3; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVnPdLc3"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-494027f9299so1683329b6e.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 19:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782613809; x=1783218609; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HDM7bjtLv0zOV5HtfuDLCqaIGYPz3oBa+eFLQoQX3Co=;
        b=LVnPdLc3ZRNQbHPwhh1jnE/CI21Uyi34zJ/OwTUcTgo7FIA9hCu43Bjib7ywMC+nhq
         jIhzEp7DLt+i5q63Y+l8BFsPc2fBA9NWntkS/aHchxg42rDr4Xcb6sAvwXybEGSkq+ok
         oFOXFpr8fhKub20cnqyv7QEtK/9dNj7AhB2Q0MYsZ4Va575Qb7Ce7LBke3noctPInTmT
         uWIV3OzQgwuSQa5KlE18jPgYDJh5YG5WkKkH5hnllC6QtP+16zyAY0KCBmPnnQs4UeZu
         PapRbrwlZtxJiOaknrz1i98X3aeH3koCZ6tf2pMGpugQLVcs2UCWGewPj0X5axKD0eLJ
         1HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782613809; x=1783218609;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDM7bjtLv0zOV5HtfuDLCqaIGYPz3oBa+eFLQoQX3Co=;
        b=YBCsgm+dha8dmER7U5zeQesOaBAyc+aIenVFDC0Cts+okrpcMss1Jk+UhQXTxGGrUc
         PbzcjNght1dLbZrZVX5uBujNvNrPzVByFqdelZSWsishBM04frHw449ZB7PbAPEtobbl
         2BulpkF/bL2O/F5C1zAa9zW1azo3KrF3yC/X/+4x6P+rAq7+/6pxWUChPFF3hLKIpuvH
         wzu+xxi8ZFCXh2dT0oP7gAxJ/Nc/+UIl+TgVFtbDx1Oxy6ptClrwZRf0/RpUJDyZwjU8
         x1rZqFPw46qnHybyCx16QLZT36MYXiNowHvCJVu4HP6yeNeHDeXzddPc83S9XMtAB4gy
         WNJw==
X-Gm-Message-State: AOJu0Yw/Nh1D1UzIz6WE+lmWPS3Xag9VTheGjxTLhdAxPxb//0QfA4Lf
	qNXyq2VUOrQH1pQI45Pc/Crn2H4JshZnMcmQjf7Na7sava3MJxxz0MK+eLoMEA==
X-Gm-Gg: AfdE7clQMo8Zw2pGkDrcj/29zjMP1cJg2+qBN6wqHVGLEx0bg4PksGkw7ouJYFUMNS+
	sEAyRxTMzbWaq7O0beY5ruVH5E2tbibjt8KO7l1HAV+rWMzlnLogltK4MF6r5de0A3VPJT/29Ou
	/Psup01X5VPel43FAuq0ExIEcnMq2mRCbEyAQxNyUwKNid+mJ+Hi9HTzDh1u9Kgi2RDm726sbpE
	cYWW/Fe5GEgDnHkaqtVm/tcwxSYNmHBG87jms4GYxzO/1/UaQ/HV5U75vA+XsrXC321OJcgFkNz
	1DCN81BB0RyCDuD/VGepsqpvt0vIhThjabDp8xH0+TpnqWwOEa+8na60O9/S2oRW+r70FS26WMX
	THOIzjV9QaqZ7XMMR2iBmUGJ6IAATK2JQk5fAAter482YGnIeKq3JhPAd+uNVaIoMlEZKKo1Ktb
	GZnS2ZuvDZZTfnZ8pttug=
X-Received: by 2002:a05:6808:c117:b0:495:7d58:77c0 with SMTP id 5614622812f47-4957d587a51mr1434186b6e.20.1782613808851;
        Sat, 27 Jun 2026 19:30:08 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.131.97])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-49354e517dfsm4282230b6e.11.2026.06.27.19.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 19:30:08 -0700 (PDT)
Message-ID: <6a408730.d0a63f45.184c06.74a1@mx.google.com>
Date: Sat, 27 Jun 2026 19:30:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5310640836081539672=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alhouseenyousef@gmail.com
Subject: RE: Bluetooth: fix UAF in bt_accept_dequeue()
In-Reply-To: <20260628002305.22823-1-alhouseenyousef@gmail.com>
References: <20260628002305.22823-1-alhouseenyousef@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5310640836081539672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1117553

---Test result---

Test Summary:
CheckPatch                    PASS      1.36 seconds
VerifyFixes                   PASS      0.23 seconds
VerifySignedoff               PASS      0.22 seconds
GitLint                       PASS      0.63 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      27.92 seconds
CheckAllWarning               PASS      29.42 seconds
CheckSparse                   PASS      28.30 seconds
BuildKernel32                 PASS      26.06 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      495.64 seconds
TestRunner_l2cap-tester       PASS      57.70 seconds
TestRunner_iso-tester         PASS      83.51 seconds
TestRunner_bnep-tester        PASS      19.08 seconds
TestRunner_mgmt-tester        FAIL      206.56 seconds
TestRunner_rfcomm-tester      PASS      25.63 seconds
TestRunner_sco-tester         PASS      33.10 seconds
TestRunner_ioctl-tester       PASS      25.91 seconds
TestRunner_mesh-tester        FAIL      27.07 seconds
TestRunner_smp-tester         PASS      23.20 seconds
TestRunner_userchan-tester    PASS      22.72 seconds
TestRunner_6lowpan-tester     PASS      22.35 seconds
IncrementalBuild              PASS      29.80 seconds

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
Read Exp Feature - Success                           Failed       0.237 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.629 seconds
Mesh - Send cancel - 2                               Timed out    1.985 seconds


https://github.com/bluez/bluetooth-next/pull/359

---
Regards,
Linux Bluetooth


--===============5310640836081539672==--
