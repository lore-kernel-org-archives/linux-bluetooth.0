Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6F1494D8
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156186; cv=none; b=BBP81nkv8b7e7cmHzA2GJhfdOblBmxjUQh+sKFhvSj9FN7Zf2EDpK/xlRuKwuO7uHUP4WgbAzMAz5n1kRAPmG13TYknZUVoa96TWQ6WuMEYZRtos7TpA+3axY0GDdmAcGq+5KLeGQiqkhogX5Ommp5t5DMRonjL1RxRaj8VkGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156186; c=relaxed/simple;
	bh=EVMhotT6J0crjZtxBx0OiGOPbq3yIzey8A7ALLg29rI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ig9K1SPdHKfks+3byY26fyMt5Cxn+qAxzR9IFXByKg2vsnDgUqFnUfNQ3B0HITBGCTQ6BRO4Q8R3tT0u5L7HH/ymc3HcmZxC/HUGew+BdsEZXEhUKQ3Zyk1rQCwob+qUltupqu3Z1yHc5UPJXZMCuZCqrkwUZ5TSwZ1N/U0rq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0KtrQJ/; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0KtrQJ/"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6144369599bso39957547b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712156183; x=1712760983; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HKhQDx0b8Qvt3U7Mkkvlbwvo6tuG2m9ker70hoDdP3Q=;
        b=l0KtrQJ/C40CllKNR7PsCxCDt0pcbHVXKpkJH7cP0RvNknMTe6P0pHPHU/je6imbLY
         Hebyx730EJrccfizgYkKb/69ZiPV+G+Zyw5ejFVyyjkLvBTXvAJjlRrgZ9dfw8/TrBbq
         vkK8iwWh/1ZAatM08uE2/Pz03USvEtxppeCs/dKnRqgHvUiI+KOdGiOwtxXVd/wCgctC
         4pfE55AP4/+bypJnZQ9pFaiqjNN6q4QS9BDjWWRgAn6qztsuIy1NBZWM9Ag5cZy5BO6X
         +e1URli2fSz3wg7k+eeUaGaS8I+rHEJH9iFQXuH9Uj7G3/2LRqlBDzFnQQuIFBkZneC9
         qE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712156183; x=1712760983;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKhQDx0b8Qvt3U7Mkkvlbwvo6tuG2m9ker70hoDdP3Q=;
        b=m0MLKgzTg87bo3B5GiQGXjw2KsOsviKETYltvu1wgWvEy1aR1QCWMyvvFfKdmpugAT
         ncJ2Da7EFRSpAC/EeMdRfHIcPyRoKyXG0Gjd1TcU26WZRUSZlrpKz2L764e1Jz3D2DHX
         RDAZkNmKfB/Qzq5G7G4hpH/f0sxDhxX21vD1lzdOE8qMnDlgMy7d6WRdq8FgqdBcltjq
         jDmFgtK56xYlHcimfas9q/HoUy27YiEOV6UBgrx2pOXVfYED4gCdVkelt+HfBP0+AW+U
         TQJqsa44MQ/fCcaC/T1ULyp7NV0V752wTsKdKD7WUuAIddYQGITmaGCZuQZcSyTbs74N
         kwPw==
X-Gm-Message-State: AOJu0YyUoVvctr9M6HrBfPqWm+dnJSyJhfffoEWORZx94WA0zI8jYGEd
	PkeAUYwKvNR0BLpH4+zQf7PtPaCjoqTalHzs1akDBdUHIZcgF5QicZVzBecs
X-Google-Smtp-Source: AGHT+IHr9ck8Bu9rJJadT0ReBK563MREEVxL80rGezkeoqqWu3hugSBBX4jGd9CvquHO5eqW9CpGPg==
X-Received: by 2002:a0d:e84f:0:b0:615:1f78:465a with SMTP id r76-20020a0de84f000000b006151f78465amr5253074ywe.20.1712156183600;
        Wed, 03 Apr 2024 07:56:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.214.173])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a084e00b0078a48172335sm5130812qku.24.2024.04.03.07.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:56:23 -0700 (PDT)
Message-ID: <660d6e17.050a0220.6d5a2.c885@mx.google.com>
Date: Wed, 03 Apr 2024 07:56:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4745613381592966998=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmantipov@yandex.ru
Subject: RE: [RFC] Bluetooth: fix race condition in sco_connect()
In-Reply-To: <20240403142706.25748-1-dmantipov@yandex.ru>
References: <20240403142706.25748-1-dmantipov@yandex.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4745613381592966998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841114

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.73 seconds
CheckAllWarning               PASS      32.06 seconds
CheckSparse                   WARNING   39.63 seconds
CheckSmatch                   FAIL      34.58 seconds
BuildKernel32                 PASS      28.85 seconds
TestRunnerSetup               PASS      541.12 seconds
TestRunner_l2cap-tester       PASS      24.53 seconds
TestRunner_iso-tester         PASS      31.28 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        FAIL      113.37 seconds
TestRunner_rfcomm-tester      PASS      7.55 seconds
TestRunner_sco-tester         PASS      15.03 seconds
TestRunner_ioctl-tester       PASS      7.91 seconds
TestRunner_mesh-tester        PASS      5.98 seconds
TestRunner_smp-tester         PASS      6.95 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PASS      28.88 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
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
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.167 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.186 seconds


---
Regards,
Linux Bluetooth


--===============4745613381592966998==--
