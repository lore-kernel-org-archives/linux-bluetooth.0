Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287B91C36
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352702; cv=none; b=u1DKNVk86b88qzPXzuKxacVmoQ9RpH0zgdBwuHx8aEBRv8r3/oIr9sceiv3NrC8ZfnrB2Q9VrJc5DnLqJyRy60aFGCkJCWRdItUoqak/yhgeuiChZAw6Zz2cM1CzF8lENZ1z6zxBHYEI7mxJb6V9B/d75C16sqkCCri7nXHuM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352702; c=relaxed/simple;
	bh=5KxKxploAs9zSA/rC8mgHeVtQXE9Erkjde2eEqHAZ84=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hADWavn6cBLNvlbyxjO/9Gqf6AD/gTEgarhrdypjjZrbkPj7ssxDl2uzYzIz7pyjCtobpD8akacYykVc4BwQ4WoazvoURsCBwdGxQvROgzmfSGB8vk2+yTAZC/pBXgbDp1LDpj1V/8/+tJTx+YeHlh002RabH9DWDac1YyBqgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT0oOWsz; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT0oOWsz"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-222a9eae9a7so1262204fac.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 14:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712352700; x=1712957500; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IuItlfnMBeiVhsEPMqXh6mkNzk+oR8zcdy2GkakojfU=;
        b=DT0oOWszTPzLgMyDsE84kxJtcEntp5xLJVVtERdqnqK116VDmisMNwXULxDH+ZLWJA
         JsB0xQsLhoyhABaxSuFTOIbYgh9J2IaIlb1cqzJg6Le7aEWNHgdOJLWAPsZnxj+fDfYp
         TB2PGJ6ioLmGsM6SSAgmUjx6AoFNjpJe6x0aXqRiSOT9rXm2U9U1Khyh+PXrE44mt/iK
         piHP2LSLtXNKxAzmpDVhvWe4YExlwVGvRdrEhWsMRC+LeLNGfCgQsGqgDJ+RV5d3Bevo
         SIO9w9o3h7nWjtvFZM8xnxllGNzkr9IdPZBy1Vr8Ni8T0ciSNHVD/c4nBiFaFV4NoROp
         Tu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712352700; x=1712957500;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IuItlfnMBeiVhsEPMqXh6mkNzk+oR8zcdy2GkakojfU=;
        b=SQ6mG10i+xE+U45+B7N12zq986BO7ggY6ze3Mu1oim1abeWhHUzVzoCviQTuVSuVjP
         loE8JZ3UnTfqUrLwcuHpY4KYr5arnPMq1wZMJxvDk6tBruS91wQBYNf4HLmi2+/yl8Dv
         FaxD7raZY5mBUAyQ5iB9XCFj/fCqX9m0R6Tx5SoT2lcIikR9VGfOF5QE9KJNQ9Gl0vsw
         4Ptr24nD+LtfcmVVh5eIeuxPEfGvYNJiLbOLlQL+HeCynabVUcU6ShX+mWNRIcOHuZqi
         5Kw9i835leRAJ8rZKDzNHfe+BLXV+J9wmqOTPQQ68mUZdXHdTagZWsgxr+GlyRYebI12
         0/jg==
X-Gm-Message-State: AOJu0Yxr5ZY/JRcJ+f2djWBstFjfFd6lPqMRM3lAdMSof+RfALGPWtQm
	UdO7PUKDaYfK/OMMcI8a7YOfPX6aTMau0fyBv/+VdjEoikv6S/BJilBvCGb1
X-Google-Smtp-Source: AGHT+IGreJSK6WFoL8710uky/Og3HW9LEILekYpKiUt61vlfQYFlZDqTR1iH8uuszjmBYet1VKlCVA==
X-Received: by 2002:a05:6870:93ca:b0:22b:a8f3:36b7 with SMTP id c10-20020a05687093ca00b0022ba8f336b7mr2945199oal.55.1712352700053;
        Fri, 05 Apr 2024 14:31:40 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.21.241])
        by smtp.gmail.com with ESMTPSA id o24-20020a05620a22d800b0078bdd8fa570sm962047qki.106.2024.04.05.14.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:31:39 -0700 (PDT)
Message-ID: <66106dbb.050a0220.1f98f.6fff@mx.google.com>
Date: Fri, 05 Apr 2024 14:31:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2779491084290305563=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync
In-Reply-To: <20240405204037.3451091-1-luiz.dentz@gmail.com>
References: <20240405204037.3451091-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2779491084290305563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841940

---Test result---

Test Summary:
CheckPatch                    PASS      1.42 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.80 seconds
CheckAllWarning               PASS      33.87 seconds
CheckSparse                   WARNING   38.40 seconds
CheckSmatch                   FAIL      35.62 seconds
BuildKernel32                 PASS      29.76 seconds
TestRunnerSetup               PASS      538.83 seconds
TestRunner_l2cap-tester       PASS      20.58 seconds
TestRunner_iso-tester         PASS      33.21 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      117.42 seconds
TestRunner_rfcomm-tester      PASS      7.38 seconds
TestRunner_sco-tester         PASS      14.98 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        PASS      5.74 seconds
TestRunner_smp-tester         PASS      6.85 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PASS      28.67 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
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
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.170 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    1.918 seconds


---
Regards,
Linux Bluetooth


--===============2779491084290305563==--
