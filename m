Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BE613E88F
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590313; cv=none; b=evOj4RBWWZ4y5zq9FilFDRpdqfNAfXCUs4SXF7EhcTKuSIe8V78NyOZhMAShCKDQf1hMnTvPnFTMpNvA/ShhcsNO9tWs7r1tGSt37wlwbCT50SWXm56eMCM5OzrB7z5CIvPRWnt48FvfHOriGSC0dLviqklP6AT5zE01m2x3ASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590313; c=relaxed/simple;
	bh=BRlK72lt66YjMjyXX+wzhPcFTd1QZ2eQd1d+esKwZL0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tdWKyUZk9U1GT3IgCFkg3pUSkCyL5A6Ew60DePUjLuRHawtlDfMiJfNOkebvH1IRtECX2UhUhlzZ+/wbHKNI7L39cSfPyHGu58GJkOjC80dZL/eJQiDIvxoX/cuLd8ueFON/hBoivpJVZ1wTB0ms+vbtBvCWUxYkqNNhhyPTlew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbemQaoh; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbemQaoh"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-617e6c873f3so20859917b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712590311; x=1713195111; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fSYqYNdaUCwLpfFHlXFqA9cg6DjP1VyQDiQPuJcnDCk=;
        b=HbemQaohY+wY6wo3QZSYZNH2VSCu7Wnk//hHzvIa/wSuLXH0V7harSdbCrT1PyVBKt
         tReB0zN63F+zyYCT1tWPs0HrhNZP2nsV3seH4mNuJNdBifu+i19vo5FBelYqD6pbfius
         L8NUgcTAqykjo7eNDCbj9DDgu6PSL8S0wnsaPfliV3lHbgx10T2ae6zX0xj3dmjft/Pu
         1j1OQBX2+vqCCU9f0BkdsR0xHrW5T/PjUbEVL2nd1LGPV0Me2BmSXhDlOmlH4ol5L6mr
         b9mEskmu2Bzh/yTzJvmT23oV9CbapvLbwyP+uZaCFg11XS+f43+ZoaXalLG3FkawFDiB
         tJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712590311; x=1713195111;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSYqYNdaUCwLpfFHlXFqA9cg6DjP1VyQDiQPuJcnDCk=;
        b=Rd+XGnb91BYqy+cXHuRvNHVFWP0tslAX9xyJMIXmfSQQ5hIpwHwDXfagty5AvyN+AK
         GNNCfWmISbimwiMVPiohAYhgTrLji/rJEcnGWA0guxMmcXQ6c2SPvKKtpvcVk2z2dvN2
         7D1mvCzuOdNjuKXRuaLL3ZgrCGmuTAVVBcOgCt+c7G/ufM+6s1lbIgEFCsGCmoD/IHqF
         yOsTVlQ4ojS0q/aOJw71uhdIYopStXDrvBnrHiXvJusYAZKAMKl/DSi2UabHgB/4vOQO
         t+j9kX1kDq94RamoV5cGktIwlT7995chM1JoL4wzrZa0ZimCrePGEpocR64NAD3u6gqi
         gTBQ==
X-Gm-Message-State: AOJu0YzjTEu5ae/OAgm5vhVVjeRgDrlWA1hPHJAy7lA1ByzOE8GaG2K/
	o/uErVKYTpqhHLt2B6acGJ3VM9jO218oteZGjuew+6q0kmsxcMwLRDM9UNvu
X-Google-Smtp-Source: AGHT+IFLPZWphQdVxCJhIgEmo11IA729PrVwmprkVWFvIVcScZwhFcb3qpgoB1ikto3PCyZNFh9s0A==
X-Received: by 2002:a81:de4f:0:b0:615:3332:f352 with SMTP id o15-20020a81de4f000000b006153332f352mr7445196ywl.52.1712590310806;
        Mon, 08 Apr 2024 08:31:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.162.192])
        by smtp.gmail.com with ESMTPSA id j4-20020a81fe04000000b0061800d957a6sm689853ywn.26.2024.04.08.08.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:31:50 -0700 (PDT)
Message-ID: <66140de6.810a0220.c9f57.31fb@mx.google.com>
Date: Mon, 08 Apr 2024 08:31:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5913621113606969353=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, duoming@zju.edu.cn
Subject: RE: Bluetooth: Fix use-after-free bug caused by hci_cmd_timeout
In-Reply-To: <20240408144302.105777-1-duoming@zju.edu.cn>
References: <20240408144302.105777-1-duoming@zju.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5913621113606969353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=842493

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.02 seconds
CheckAllWarning               PASS      32.99 seconds
CheckSparse                   PASS      39.79 seconds
CheckSmatch                   FAIL      36.07 seconds
BuildKernel32                 PASS      28.87 seconds
TestRunnerSetup               PASS      520.44 seconds
TestRunner_l2cap-tester       PASS      18.34 seconds
TestRunner_iso-tester         FAIL      34.77 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        PASS      108.22 seconds
TestRunner_rfcomm-tester      PASS      7.19 seconds
TestRunner_sco-tester         PASS      14.90 seconds
TestRunner_ioctl-tester       PASS      7.54 seconds
TestRunner_mesh-tester        PASS      5.69 seconds
TestRunner_smp-tester         PASS      6.66 seconds
TestRunner_userchan-tester    PASS      4.85 seconds
IncrementalBuild              PASS      27.65 seconds

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
Total: 121, Passed: 120 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.180 seconds


---
Regards,
Linux Bluetooth


--===============5913621113606969353==--
