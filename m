Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31738DDB
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 03:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713412647; cv=none; b=mxjcGUVfkD70kp7sIthrUlopiI3kvBlmoZ4qhajbWOhlCfLa4YTw/j7s/9LgqeHg3y4AgNNOqc7Sm3gllKnzzNis5w17GA3XVpWB1u1WS56dPgS+80PrKF6fejIgqBBG/vhDsh4hIquZVfWjNGsRR2q6lOBdJgx0CrvE3AwgHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713412647; c=relaxed/simple;
	bh=A5hLCYHLUab0AOB6LXYJ7cfdIJ2Q6ufHbZ5Y+lxUzhs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bC7ZfxME7gzZa7p6AiEPQkLNBnflmd3JUX5X47xvgNHiOGV4Y3cm35kOeHWOwumVJh37gww4eCDUBjsUOvkBcwncJ6q7cUWGXTxIo2ezb11a9ZndNAEL+QJT32pWyHMyso+F5EeQnYNDR1M3018YoWufcXm8Bzalto+LjKZigoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUJTb2Uu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUJTb2Uu"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f00f24f761so394694b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 20:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713412646; x=1714017446; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dpcu9XLIU0NLp6JF7BrH6JGYmIwb1dEi9VBsXO5Obk8=;
        b=SUJTb2UulM6R1QSg+iwNmeaGZ04rLMmnsV4ODFwPNLmj7XSpT1mL0422zpM8nBs7di
         pnjEFERJA6lvxksSR0y/MbUluEE/Tr+HUMZwSaX1hDvFe+VDMPOi+mBbsD/qgcnnVbOC
         BnaNwOFk/gTDWhza84ndzeR6KF+SLsHWQwTVHQ0dnfVdn9/pLxrPMhdddMu1Yjp2lr5d
         7llk8ckSWSyrIqItjtuD+NXTOVig7UHwRC9DgBowz4meZu49k3HmuH8vZSk40IqwG5mU
         /jRdcCd80JjjC6z6LT/GJSZyD/0L7cWhRGO+xh3b93t31wOtvRDHn+LDPvh1E+goOWRb
         yN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713412646; x=1714017446;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dpcu9XLIU0NLp6JF7BrH6JGYmIwb1dEi9VBsXO5Obk8=;
        b=mDCos3qGHFJ9LshpyZ8dYdCfO7U0D6QPb2At1bCeHeGQ5Zg8qrtugDVBbDi/k2RkdM
         mM8PdMhOB/WKfUrAibsEDspy5r9l9mTbCLDOUQUXZvuOeHPN+hXGMEwrjpXsLuAfPYzu
         bdPVBCi1TCTGl2BzkQ4MiSgpGHYqcIxknib8bVIrlrQuh3EJh2wT8jjvq5uW2w8icrmK
         2mZnuYUT0al5Zq6Hb9pGT01Nv32kXAJQFAZUkqPNHH/2X7rGOTyZDD4jEb0f29R+NV7Q
         f8o0h4qtj8PouXmpBFE1blodrw8IgHzSqUeIo6RCcrssOPUtMVnan90DxfWGgZ1CLfGU
         Rqww==
X-Gm-Message-State: AOJu0YxuJ2kVrn+jYYaAxt4ORBGdklqgeoh47YjqFUvX+TtfvUkd8Uq5
	2M5PblN4Dr6Nskl4ban3xj8naQutNeKIS2LHcfusdt1ihP9edUUC3GY1wA==
X-Google-Smtp-Source: AGHT+IHZhdHkIlDkj0weMHnnVaMLpF4p8TNVNGoyursCWngA9A04TMEnU8xGvk4kLoHYblUn5BxDww==
X-Received: by 2002:a05:6a20:dc94:b0:1a7:c1a0:d33b with SMTP id ky20-20020a056a20dc9400b001a7c1a0d33bmr1696269pzb.39.1713412645653;
        Wed, 17 Apr 2024 20:57:25 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.70.177])
        by smtp.gmail.com with ESMTPSA id a19-20020a170902ee9300b001e47972a2casm443201pld.96.2024.04.17.20.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 20:57:25 -0700 (PDT)
Message-ID: <66209a25.170a0220.d1d56.1e9e@mx.google.com>
Date: Wed, 17 Apr 2024 20:57:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9020071098023371826=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Fix 2 tool btattach issues for QCA controllers
In-Reply-To: <1713409913-13042-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1713409913-13042-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9020071098023371826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845651

---Test result---

Test Summary:
CheckPatch                    PASS      2.69 seconds
GitLint                       PASS      0.72 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      29.90 seconds
CheckAllWarning               PASS      32.87 seconds
CheckSparse                   PASS      42.68 seconds
CheckSmatch                   FAIL      36.57 seconds
BuildKernel32                 PASS      28.94 seconds
TestRunnerSetup               PASS      521.39 seconds
TestRunner_l2cap-tester       PASS      18.30 seconds
TestRunner_iso-tester         FAIL      35.36 seconds
TestRunner_bnep-tester        PASS      4.63 seconds
TestRunner_mgmt-tester        PASS      111.32 seconds
TestRunner_rfcomm-tester      PASS      7.22 seconds
TestRunner_sco-tester         PASS      15.05 seconds
TestRunner_ioctl-tester       PASS      7.58 seconds
TestRunner_mesh-tester        PASS      5.69 seconds
TestRunner_smp-tester         PASS      6.65 seconds
TestRunner_userchan-tester    PASS      4.85 seconds
IncrementalBuild              PASS      45.41 seconds

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
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.179 seconds


---
Regards,
Linux Bluetooth


--===============9020071098023371826==--
