Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6413FE375
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806914; cv=none; b=MS4zxu2InKNhi1F7jjJ7JOF/ue7SQAGMIdGADf6w5ChsyOHx+N6Cx9poQwQ5cdaxoK4w7OkIKTmxW281LhVW/aHB3CFPQGq8WxOyhPkTxsCNWI/7Flwrb+LAzITV4tsrPiaGZ4C8uB3J8oibCkAYAfB4WyHfAbmp3YalL/ZDwXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806914; c=relaxed/simple;
	bh=CEavAPCWtq1ME2zYrxOFGL4ltTWUa9uBoJVPjTfpogI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GEFFIJCNjyDAluS0XeM/ltgBwr3acBnpMD1qEEkJzz/VaKsTgnZV5BLdrBnaFVIPjEAfGLkCOnV6x6MkrlVUUyl7PK22cNOq9Uma45roDC2zZykxrusW6Um5wAMLLPOnqTbTi9Al41gFP2RU3H/7jW32c9wQUrQeXYOK9yqVQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CujUx+0D; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CujUx+0D"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8be236ce888so103875386d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779806912; x=1780411712; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w7Mf50VApOofCTzVX1WJGrZx7xG0z5ZRKygGL2GOckE=;
        b=CujUx+0DFmNVPIuQqfErmw8mdidB0kaEZSUZstrQ1o2R1g0hvSJRjASGtmSB2qnySe
         2CjpzWcHhdM6M8MHtsPFwA2V+icWhJrsrM4OVMKNcx1CPlYqTxGcfiAQ3FYPVQdcdLKV
         /1SAou1HDyz2jNWYAagk4Bw+VAj6sFnZfxj2Dyj4WxsHrpuAsXBF3SiPZu/WilYRhijY
         1DF2Yo9jvLFg84q0Hn26/jxRsTU50Tw/mwktbqyxubYVDnPDHcDbenXtPEB5365SZAOA
         n2h7ZsaVsUupGRLaNoFpAkB8tTm8VQ27FKM55CQTRblIRqoKIJT0Ze/2Eat1cb136a8I
         Kbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806912; x=1780411712;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7Mf50VApOofCTzVX1WJGrZx7xG0z5ZRKygGL2GOckE=;
        b=MTN7KQggxU/EOfqAHL2md/DfiZ2on5RyDCGSbMadPkf3/AZ+9HcOCPbRKlZK6/WANv
         ujSLv6L5+EX82MMwbUTEcVLy37qjkHW010sBRyN35jJAka7bmNTK0twW0nUi20YA7qME
         uvs4nNvxhjnXjJ5qwiXpvwqkATiUvem4p+Deg8H8h0B3LbY2u2jqR6YlyaGOjJ4dmrcO
         /KbNODoixehvjMrwbpkFdA5hiw8lWFS4b+1lLIkB3he5DXqQnSFxy/K9R8/F6wwb+W7s
         YYGjU9Uhg3A6/HsMcdDhQSCvA6ha6d2ijV4zfP4TVVBMXIIeLQpdFLq58vyLQZ2aTFYi
         cmRA==
X-Gm-Message-State: AOJu0Ywoe9/eKZxd3w6dM1NPzvCIvjjOyAI6GM/OTh1CiSqoqTkltZG5
	C+645F9xpLceBLIwxrY+Q2K7WJAqMh30+oZJiwjATJwx+AQZGcVD9NJhLwwlGmr8
X-Gm-Gg: Acq92OGhbOg4g4b9PT1gLTpxtmhAwbHLu+0v7hIH4nq8n17i9zGq9BH9l15aakLGNVq
	bX79nNRLFIWS+qAklGo3+gAwkODVGKCYh319qhJ3XjsShJxFgPg0e8FCb2s9oQgkBWNTBDQdygC
	dxXeDhvauemM4g6SwiECrirY6tRPg+bZS5ZHNY3e5M4iaOtqHFKHC18YrQSWmelkbiCDGtRRKRC
	L8NHrnE2us8irBDsA4XjjC6JxcMCygsslB7YAoVhpUkHegsRrPkIe1BBBLMERspCV3nhPksvuEx
	vNd2pLtPFbRw4e4hh08DVl+5oImzzKwfIPCtHYr8ELeTvr3O3nDet9voRxLrqIG3xIApZSUViY+
	AkV6MNUtWcsvqruhXnlkvNU3JiqeFY7BY9X2p8fNrcn7aInaUizKZuFVzwBYGxMi1+5x1H2GjVc
	r8ps19bkUmDZqNCOJZHx54+FzXKsa3OJcO759AELV3LTY=
X-Received: by 2002:a05:6214:262e:b0:8ca:ee3:6e99 with SMTP id 6a1803df08f44-8cc7b6a504amr313356756d6.44.1779806912203;
        Tue, 26 May 2026 07:48:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.126.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81323f7csm142339626d6.46.2026.05.26.07.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:48:31 -0700 (PDT)
Message-ID: <6a15b2bf.50eb26ae.ba2be.2e4e@mx.google.com>
Date: Tue, 26 May 2026 07:48:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5648412516207919473=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kipreyyy@gmail.com
Subject: RE: [bluetooth-next] Bluetooth: L2CAP: fix list corruption in l2cap_ecred_conn_rsp
In-Reply-To: <20260526103441.73180-1-kipreyyy@gmail.com>
References: <20260526103441.73180-1-kipreyyy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5648412516207919473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1100866

---Test result---

Test Summary:
CheckPatch                    FAIL      0.75 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.86 seconds
CheckAllWarning               PASS      30.00 seconds
CheckSparse                   PASS      29.08 seconds
BuildKernel32                 PASS      26.70 seconds
TestRunnerSetup               PASS      591.10 seconds
TestRunner_l2cap-tester       FAIL      61.70 seconds
IncrementalBuild              PASS      25.95 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[bluetooth-next] Bluetooth: L2CAP: fix list corruption in l2cap_ecred_conn_rsp
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#103: 
  KASAN: wild-memory-access in range [0xdead000000000100-0xdead000000000107]

total: 0 errors, 1 warnings, 0 checks, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14594665.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.277 seconds


https://github.com/bluez/bluetooth-next/pull/242

---
Regards,
Linux Bluetooth


--===============5648412516207919473==--
