Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4F4436B
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659396; cv=none; b=N+bN9cmKtIuvIVBY6qoWFXhTwx2fAtXsOAZdYADOclpbHirqZJdSQ3J/9ZEUsG8HfxSXMWX/Zjpnjjr0KG0F+T5IK/EZ23Fz3oRbusTjMV/IbKptKDgVWWzRG3Ub2P5WENJWf7/M9RgXlInbc3q7K4oo5h3H7VfX2SaMbXkiaNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659396; c=relaxed/simple;
	bh=gab6GSKH5nxKrUVY7j8UNUBZesibI26jPpaH9qULm4w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h1aHpmMUxm/lZVvI6XclqJ0RjaqBshTuoPy8Yy3/XHubdWzxYQ7ayho/8D/hB347qKLLbnjWq29iJjSjA/hKz/qWcOatYlTv/2zkWyPEZQgU6Vb9kmS9VVf5WNYqgcc4lkLjaBrU0RBH9t6jIjC2VWXaWkYWU5ca5xXLVzdHu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E40QGBM6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E40QGBM6"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d8b519e438so999144a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711659394; x=1712264194; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/fTYkIPn5Lus+FeBwv8emtdIzJCzwSmMaGqm1gdubd4=;
        b=E40QGBM61YE09YZuJpzp29ZEnpwaOGEmIcA3y3bfyTf9bB98IJrWJCRWVCWdvkR3VU
         gWksokYlRcZfHAJRITXXsf5jH3GgQY9RTnJD8bT/P3sqUIykQh7JK9gTyMuVpBTWjQzt
         oyodO2TKo5f/FsENGrxXSxq6gcm9ruT72DJfb3Nx2/fNdscjef4GW5j1XRr5OfQSgMmG
         U+7O+9rSBNuThwS+EAgssIBlKUPxO+Jrkiy8FEw3kriKcSRIJn/U+6YyTDL14tVG2Umg
         839F6+I7BYdCx1e/WUN9U1QSL5V2947fO3yfDp14txLagjTw2K6wsbKESPdKZFPViEKz
         oGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711659394; x=1712264194;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fTYkIPn5Lus+FeBwv8emtdIzJCzwSmMaGqm1gdubd4=;
        b=Cg+olkjashL8whGLXtKrfxyVQ6l2bzaBXOVpPDLGdsTScDNNjsevF6rsIiYKPxB9mQ
         oQSUYSID5kIJ8GB6rCQeV5Dso8f0Zn/pIQVWKheDTw319S4AtDI0bM+bPpmpIq8l1yN+
         Y3jc7NgtZgndQAAzw6IClc8iytFSeVd/vnp1S9xQZNG/dfVZBwPZWPI31/pSZzKSL56c
         BrbnnC5IHidt0Z0FegOZhcO7FM7DOgt/hQIZu/rPwQrSYFbJPoAnHAiapU1WVCfJCOUF
         PMQFTyXxSdRY+cx/6/4Ax7TgIm2DZra6QUjVm5gA3EYNLdbJcUZjhXb38MTO7koVxGzU
         bM4Q==
X-Gm-Message-State: AOJu0YyDSsYfEsHpHUQyUFKbJCMsDGxDZrC8klEiApbyWscl3G5R5vvd
	fTs7D10xHThXnKdjQjl/i7BgtlUFbP7OeVSQeyVNUUl6X5UCd/IfjKdBRaZZ
X-Google-Smtp-Source: AGHT+IHEhahlUI3uGwWlsbq4SUokkyG8cdQrzqSwB/G4WuB/9DH0fbW2oi7SYMHreDshDZfX6spDbQ==
X-Received: by 2002:a17:90a:6007:b0:29d:f0f4:1e63 with SMTP id y7-20020a17090a600700b0029df0f41e63mr561960pji.39.1711659394015;
        Thu, 28 Mar 2024 13:56:34 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.114.102])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090ab78e00b0029c68206e2bsm1806730pjr.0.2024.03.28.13.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:56:33 -0700 (PDT)
Message-ID: <6605d981.170a0220.69a1.5a8b@mx.google.com>
Date: Thu, 28 Mar 2024 13:56:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6111891402838808987=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/2] Bluetooth: Add proper definitions for scan interval and window
In-Reply-To: <20240328201554.1791904-1-luiz.dentz@gmail.com>
References: <20240328201554.1791904-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6111891402838808987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=839528

---Test result---

Test Summary:
CheckPatch                    PASS      1.22 seconds
GitLint                       FAIL      0.68 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      30.55 seconds
CheckAllWarning               PASS      33.06 seconds
CheckSparse                   PASS      38.57 seconds
CheckSmatch                   FAIL      36.38 seconds
BuildKernel32                 PASS      29.39 seconds
TestRunnerSetup               PASS      527.37 seconds
TestRunner_l2cap-tester       PASS      18.27 seconds
TestRunner_iso-tester         PASS      32.58 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        FAIL      113.40 seconds
TestRunner_rfcomm-tester      PASS      7.34 seconds
TestRunner_sco-tester         PASS      15.04 seconds
TestRunner_ioctl-tester       PASS      7.75 seconds
TestRunner_mesh-tester        PASS      5.84 seconds
TestRunner_smp-tester         PASS      6.82 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PASS      33.88 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,2/2] Bluetooth: hci_sync: Fix using the same interval and window for Coded PHY

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v1,2/2] Bluetooth: hci_sync: Fix using the same interval and window for Coded PHY"
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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 486 (98.8%), Failed: 4, Not Run: 2

Failed Test Cases
Start Discovery LE - (Ext Scan Param)                Failed       0.110 seconds
Start Discovery - (coded, Scan Param)                Failed       0.109 seconds
Start Discovery - (1m, 2m, coded, Scan Param)        Failed       0.105 seconds
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.158 seconds


---
Regards,
Linux Bluetooth


--===============6111891402838808987==--
