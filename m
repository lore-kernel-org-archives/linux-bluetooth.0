Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE7A5F
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jun 2024 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544076; cv=none; b=n1Wp8sC1bLH4V/fBwbEc+3KoWM+ygg2K/L+qqb7p3rNP2Iy1R2uDjpCrOLKs1ulCMAz7DBVo8N1vrRzYqScaa5ChEbyRhzfoeOHcQT8t+F8qfysP7EId5sQMv2VuHsbC9l9nB46zmrQv+qn+/5xiNRh20c/piG7AbqgqMEmS5aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544076; c=relaxed/simple;
	bh=pBPTkXXvFg4BhFT3rx8FS5yU3jyGWzshezpG/kc/Qzw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dQNdewIP2hPK+eJkzsEb8HL5hGtK6RcRUEhDTxmZIFMMf0q85/z92vYFJ5q6crxbOop65uWuufgDDX5ba7Ji8nUF6yl/o3LSJeczt5kkFVEqNLCo9eFj5TcWOsFc9q43bfYk+z0aFKRrai2v4X713/1cAHDSMAeIQLWA0OoFULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRIc2Vew; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRIc2Vew"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-681ad26f4a5so3612751a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jun 2024 16:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717544074; x=1718148874; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tUmYVbefyf2P5AyFTjwHnHB3iX6iQBsFJvAE2fyepVQ=;
        b=WRIc2Vew34pQ07Hje4YsvZ4e/PJZwUh05A442ifFgQULDAOmgeTHhK6U+xlgj2fq0J
         4Si4/fQcy6f1isy4nnW/xM/Kc5MLb7xeZI/adalCLm5A86KZhyGzmiJOzWnHqHqlO0KI
         dz3mokTAnBjUsl25pO5lnn4OHsWstH60bFh0OkqzNtxq3ql5ue1EyXgyEj1RM3rZnmGy
         J3HCEoFPijvaNUXZAuW7SxaQsCWaXqjUs0kbd8QjXt1pWgYVjAGIIvT7knUjK7LCqCSc
         yCV7zLqv2RHBTwOQjbjo7mJucAf9F5ZJxnm5Srpmky6zmP1KgjFHSLaSoemGwybPwDld
         au1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717544074; x=1718148874;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUmYVbefyf2P5AyFTjwHnHB3iX6iQBsFJvAE2fyepVQ=;
        b=JkxQcpf6pYGIdnx5n420bMZC5Ndz3TdKDMYU4h3NFWTu5OFInPYGFcoKe/2N9B59lW
         yu8cAfqry+PUUXk801+UScoqWWD3sjN3ip8lATXmzlc31T9zS4e2Ida10rf/bkq22so+
         ycNz8w6ASlJ5iTBMmCxIWD8kIDfs441yLVKk7fE4P2TsXceRLaO6xShJLJi6Ojyp3oHU
         xJ7AmeOsvhharisw/a/7GA/DrgrisJap6DaleMcBoNvsG8sZHV5nbrxmIuAUd8UKJJ+s
         9z9dgh4Vrq7KEo/FInSVT2GBt49WyeW+1tOz/8Fpo+fBDAA6Y9jiDnJvmWUIprpyi0Ix
         QXTA==
X-Gm-Message-State: AOJu0Yx9jLHyJ7ROU7buVSlVgOuaT3cAkrR4uODpppv+OQs/gkdAbYE3
	cMD7E6l9Pjb80cJbvXHHFNUPq6YZeH1nO59KcMwtCkK66s3kwiFwHjZvkg==
X-Google-Smtp-Source: AGHT+IHnSLcGXkNBKyX0XRP90KPLBxfuikZ5yQDVD4ux51JNkjLqfpZTX0Ksa+2dLnZ3Te0sSv8/gA==
X-Received: by 2002:a17:90a:ab97:b0:2bd:dd7f:76a1 with SMTP id 98e67ed59e1d1-2c27db581b1mr950131a91.38.1717544073475;
        Tue, 04 Jun 2024 16:34:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.38.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28067d508sm84590a91.20.2024.06.04.16.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 16:34:33 -0700 (PDT)
Message-ID: <665fa489.170a0220.1718a3.0564@mx.google.com>
Date: Tue, 04 Jun 2024 16:34:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4875267186106505329=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean.wang@kernel.org
Subject: RE: [1/2] Bluetooth: btusb: mediatek: remove the unnecessary goto tag
In-Reply-To: <8f809ae0094c89ed99efb4074472edd119db8ec1.1717540338.git.sean.wang@kernel.org>
References: <8f809ae0094c89ed99efb4074472edd119db8ec1.1717540338.git.sean.wang@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4875267186106505329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=858840

---Test result---

Test Summary:
CheckPatch                    PASS      1.00 seconds
GitLint                       PASS      0.40 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.32 seconds
CheckAllWarning               PASS      32.32 seconds
CheckSparse                   PASS      37.66 seconds
CheckSmatch                   FAIL      35.68 seconds
BuildKernel32                 PASS      28.33 seconds
TestRunnerSetup               PASS      516.17 seconds
TestRunner_l2cap-tester       PASS      18.50 seconds
TestRunner_iso-tester         FAIL      30.18 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        PASS      111.34 seconds
TestRunner_rfcomm-tester      PASS      7.19 seconds
TestRunner_sco-tester         PASS      16.44 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        PASS      5.77 seconds
TestRunner_smp-tester         PASS      6.75 seconds
TestRunner_userchan-tester    PASS      4.90 seconds
IncrementalBuild              PASS      32.33 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.237 seconds


---
Regards,
Linux Bluetooth


--===============4875267186106505329==--
