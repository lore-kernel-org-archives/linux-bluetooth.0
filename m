Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7551C862D
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 02:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970895; cv=none; b=tqB5VJtxcn3KoMu0EfTGrB+xotQ5tjizqIrh7Ma3BdLcj5RN/zYJfp66a/PVGXkvfSOmYE2SYYbakNDpjhROWLXyUBg0shtB0K+qw5fHzeXWVcBmUVH9HBwQMDuShE9RRDeKrPZvNT3T57YvKP1YTMszo8+q20eSKjCOdZ7t3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970895; c=relaxed/simple;
	bh=zKw0ROZ8h1kcUErCC7AM0/UkAFMCeoYDMzSLKNhoQQg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JZ5G74WQa86odlK5hNTIpoyVgOqyTL2n/C37kL7HeebW7ussoerqP7jvQAoFt86xrHtH0zn8qMxXzFbuMMNhCWTdwsQRgWsDN98KwiMsqTSHUK5RYibiFJoJjWZcHNr/NDzCqPfLIH9TKxZubwaNX3GcTJSqw40wyPY6GHxo2l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZqgVjSB; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZqgVjSB"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1382c509485so1963098c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 19:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780970894; x=1781575694; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NuOwo8aDiHkj54MTu4bzeH5HCS6CoOQkL0cEr+86K4Q=;
        b=HZqgVjSBufP4tqp+XVZHRUz3ybEwqH2aMr3fWS6CKRZU7VU8g5nR3uhWw4G9xnSeyb
         UCEsU4YyoiADRd21vZCIiZ122nNFM6tl9dO/YbmkcqpOrudhakWz58jyspFFQIzZXiTP
         Cx6FuOd2FCHjfpdtpR3v31PU5qxunqPemHSZ3V1L94EI8BnY/bNKBEgf43cQtdKxkFuS
         AkwClWgMeiNe2tYxRKgFkAP4l2XcB7ZCqaagAUjwriC9PMzoefWGTgQzSx6SYmrQM0TL
         JfIzIVo1lPK8eQidWkpCP8c+kM64IiXqpTIU/EXU934oDcoz/qnQhY4V5w/d7Qc+Fu2O
         ewpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780970894; x=1781575694;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuOwo8aDiHkj54MTu4bzeH5HCS6CoOQkL0cEr+86K4Q=;
        b=lHRolcaI6t6HhEqVcB1oWx7BLrPBJtu0iyb6Prr9V2pw9W9EdhcnIMWJ0pM3dh3J2D
         RSCFBe+Tu1EJp2ecZSR501v70b4SslpnWNbj35/v6uekjdaUc3dCWd6K2gxcqnKne7Wl
         ahsOXKcpfAi2ZMEkKmfaJbgJV3xbZo4TwjHQtjVJ78vKHd3RCFm+981qCQsJeOtNzPfG
         WxNQAAZCLQduvYHqoOYj54Hnfc4llmelRip/cpODjGKcqWGLS9i5p6i6GXyN6b0Ovx+k
         d3qj84kboXrJ9qAhb/tioGi4y5X3G4yj6Qmssf0W+gy7YoKogDIq/xWg9tztE5ePZ7rE
         peOw==
X-Gm-Message-State: AOJu0YyaHxx6h/t1XQT3H47CmJNxsLZKXAB7Ve99zXyDuRBdFiW45vZ0
	x0EC9zyw6ea669ynJQLkKqt+IwOywCffcYKhwXSsNlhxxu5RfUxdniW0XT47fA==
X-Gm-Gg: Acq92OGbTNCquDVLeZSwrO5zNd0PynSZa0wwQsL3YgF2aqm0RZSC+/8cjsHCCjmy7xd
	J7cHunB0AyM35kz2UGutksadHjDXB9otCGm2XUAiSMNvBVee0C4VP4EDvLymv0QbicfnC3WhEHo
	YCqK4nshKWcC76iSD/LTLOndaiGzIgog4USij6fqTTrcgJRCcsOItrCYpL2VIC4CvD9J+zWxk76
	bldsTMP9nGWih5SuO91Op0FdME6gbqGzqcOqzeQCMOhFbi9J7kjqLdrGnBXUgmR+3ZrpnrQz/zu
	wHeMHJsiff/XRFp0m0pNSkWkVTUYa2EBHXXTcf205qTWgS3AY2dRmQqpxRTY2C7r6PCn0hBsi7p
	lcZ8iXgqbE5JuVArE6yE3f4arg7j4u1b3psLnShz3w2vul7tMrOT3kSxpR0HrShBOet65w2vZ41
	WwzK3AIaSdB1UjdWetMH2+VOhtcHVptpUmABwPbDA8gA==
X-Received: by 2002:a05:693c:834d:b0:307:91f5:9377 with SMTP id 5a478bee46e88-30791f63488mr5094137eec.9.1780970893514;
        Mon, 08 Jun 2026 19:08:13 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.228.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df8076csm20718374eec.29.2026.06.08.19.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 19:08:13 -0700 (PDT)
Message-ID: <6a27758d.ed85fcb1.1a4d07.38f9@mx.google.com>
Date: Mon, 08 Jun 2026 19:08:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2781659051759916745=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sam.moelius@trailofbits.com
Subject: RE: Bluetooth: vhci: validate devcoredump state before side effects
In-Reply-To: <20260608235822.1233691.33d07ec605af.bluetooth-vhci-invalid-devcoredump-state@trailofbits.com>
References: <20260608235822.1233691.33d07ec605af.bluetooth-vhci-invalid-devcoredump-state@trailofbits.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2781659051759916745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108159

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.64 seconds
CheckAllWarning               PASS      29.34 seconds
CheckSparse                   PASS      28.65 seconds
BuildKernel32                 PASS      26.87 seconds
TestRunnerSetup               PASS      571.93 seconds
TestRunner_l2cap-tester       PASS      58.86 seconds
TestRunner_iso-tester         PASS      84.06 seconds
TestRunner_bnep-tester        PASS      18.89 seconds
TestRunner_mgmt-tester        FAIL      211.74 seconds
TestRunner_rfcomm-tester      PASS      25.44 seconds
TestRunner_sco-tester         PASS      32.50 seconds
TestRunner_ioctl-tester       PASS      25.91 seconds
TestRunner_mesh-tester        FAIL      25.85 seconds
TestRunner_smp-tester         PASS      23.00 seconds
TestRunner_userchan-tester    PASS      19.92 seconds
TestRunner_6lowpan-tester     PASS      22.42 seconds
IncrementalBuild              PASS      24.45 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.244 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.373 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/295

---
Regards,
Linux Bluetooth


--===============2781659051759916745==--
