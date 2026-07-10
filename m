Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C843ACA7E
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682328; cv=none; b=frKLVPuGTz+IdyURbQmI0Ie1uKvPe9ucfLTx0F1nO4tmhvUhZjf0RmusAetj6gYkvUOuBQEhtzKTDSOqpdAqh+EPSO2ObUTUKDg1hlrHBPiLjx+Exb2fSyD393EtdZuwbiUFVKZEBhtzgjouppHtonSlv9mj6xDt24J2nwx5JME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682328; c=relaxed/simple;
	bh=8tYMD1Mm34Uttgd4ykTjQa8x22FSDA+SXn7LfWBNTcQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jo33aM3Udq70m648b1hOfG6LnHiVO/GMoGclMPkpojVR5yJ/qaAx5j0tEHlzPRD6QCAfL+yrWfX8nUEjyocIYwer03AjxGTLl7bD0B8rAPyM7q1oztZZBZx5lXk+0xDPQBGuMOlAEl9erdxNGW+meuVFd6jTuHQBlrfHIN0es6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGQzzD4s; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGQzzD4s"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so572074a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 04:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783682325; x=1784287125; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VbbHixsMPVIU8dgCRjfNDrh5QodnHnFdLNRFSIyaXEw=;
        b=JGQzzD4sLyeXH8QOSzbwUDfXJzzySFHMGwD7GNyHZ7eq66J4ZHl6a1DPEdQXvg3r3y
         NIKbOz5sNT2RG7DPkPrJXIQhFw4zCXLRpbLi+rSAVSj+A8/gazneOZZR6Sx9+usfJemi
         41ZFC2iU7PFAiOHmZ3/eFKEt949f08fTZisIWU8R6w6iHzhqHfhsdxaVtXHZkDBJkT7J
         kpeOvWmipxzOdCbtcy2JOhvOkZSNPg3wmU2XUyhpB8SHLrEgNRPc9Uyxc4xmBgLzu0BF
         63XIqT2Nw+jlVUrrNzCLj84ZQEWH3y5MRvmSjEePDPyaLXobH+Pbf38mf442lyIiZ+Iu
         6SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783682325; x=1784287125;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VbbHixsMPVIU8dgCRjfNDrh5QodnHnFdLNRFSIyaXEw=;
        b=sNCE16hsqiK2Mw74tEB5Ix52PnMkW4wtGHuLvL3vUkEgyvZ9RldFwXJC9w7ezefuBo
         LOmMIPLk81T9NyPREXtDxCBC7ChHuROWAD3M1zc2TGzGMdmyH6cch1JwW/gtxjJW4Iqs
         pZOiXnIvOFL2in+i2rusCtNrMePUufpiijIy6DnqfDHamn9nf+cW27BjOtUINB+9HSeE
         GVB/0ENB8p9IV2uy8Q+KuOvTZsZ6E16epr6/0UzWijugMdUaDarP14dFRgVqZj8eCNSw
         rFQvcPKRwvJqss6ij5x5B994qM9FnAS6lXqti0YO2dD+JbUFUcDIxtOW2EdfPm+mQmYu
         C3jg==
X-Gm-Message-State: AOJu0Yxz+CSBPz+HKbobcKm8RgPQRdLTq5mbNYQFexpMokrs4UisNltg
	yczleNNYfp3E1bA0MTsTdxQRxWMOAZROEmZaOuqK2XDI7Y+uPo7qmJOSIVRXkQ==
X-Gm-Gg: AfdE7clkUTW7m8PpVYjb2plCnCHQljKI6Ae2UCjc/fBx7w+hanZG8njfnVamEZBU9r+
	agrx6Cumw+ZXGxnFEW9Wrn4O4Dt89p46Wtl5Wj9gmuCZu+kaLYORgl4atvm36KnHEPn1WIOp1Pa
	fIwPe+NjwqbXGeQRmUR5X7EyUAFEpko/UmEtLwMB/aTk0oUomM34bE174uHI1ln/e5eaisJs2Wk
	NyGpq+uza0k1HM/FklztPZMkCJ5Vg6k1PXnq6/YBU/jjMpCusUB0Koj8WWzPHPB5XzWx2HSxlSL
	ilB1WU6vAF8KaQF9vHPPPdzNere5uoXtkHlnyaoLDyfe67Jo6laTl9rthua/tBcpXrdxXOjh+Ao
	4U52xW+M3a0PSFFTQ2tfWfvsQrvBMqZmO0l29plqN1lJyC8rVbBOU853l3r6Iw5c37nCbOCDHbj
	WYxkO+YgMeci/TpULyBZPa
X-Received: by 2002:a05:6a20:918c:b0:3bf:a9cb:b794 with SMTP id adf61e73a8af0-3c0bcf28326mr12922785637.53.1783682325157;
        Fri, 10 Jul 2026 04:18:45 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.226.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm64262269eec.29.2026.07.10.04.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:18:44 -0700 (PDT)
Message-ID: <6a50d514.da8bafd3.14cd50.2976@mx.google.com>
Date: Fri, 10 Jul 2026 04:18:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0693448689094591723=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mikhail.v.gavrilov@gmail.com
Subject: RE: Bluetooth: mgmt: Translate HCI reason in Device Disconnected event
In-Reply-To: <20260710094731.59767-1-mikhail.v.gavrilov@gmail.com>
References: <20260710094731.59767-1-mikhail.v.gavrilov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0693448689094591723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1125289

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.91 seconds
CheckAllWarning               PASS      29.67 seconds
CheckSparse                   PASS      28.29 seconds
BuildKernel32                 PASS      26.59 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      498.82 seconds
TestRunner_l2cap-tester       PASS      58.33 seconds
TestRunner_iso-tester         PASS      90.75 seconds
TestRunner_bnep-tester        PASS      18.81 seconds
TestRunner_mgmt-tester        FAIL      209.21 seconds
TestRunner_rfcomm-tester      PASS      25.35 seconds
TestRunner_sco-tester         PASS      32.72 seconds
TestRunner_ioctl-tester       PASS      25.73 seconds
TestRunner_mesh-tester        FAIL      26.28 seconds
TestRunner_smp-tester         PASS      23.59 seconds
TestRunner_userchan-tester    PASS      20.22 seconds
TestRunner_6lowpan-tester     PASS      22.22 seconds
IncrementalBuild              PASS      25.22 seconds

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
Read Exp Feature - Success                           Failed       0.242 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.662 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/421

---
Regards,
Linux Bluetooth


--===============0693448689094591723==--
