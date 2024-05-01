Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F34D9E8
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714548814; cv=none; b=MNBYYAUoRc/AdfksJulN6USLOJGY2wBrfblwze1npsyhkObJZsAcTOuolRi3EZBjlc9/tltPECJidlWm4F7EvQsdnENbXf7RifFzJQ+mrtU8WLeZQSXRFBKNw0LGD5YhtctDd2cB9dgVzljjKCcSVIYdfzNnL4SqYoU5hLLQts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714548814; c=relaxed/simple;
	bh=U95fMg20qAmFQq9KqolQDyi6Yy65DMF/jm2f0QMGviw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bchYsP2/fIBlCAlA8KiXyoLFn8T5ViUBaJ87MVYAvjV/XlvdMke0kvUECrlRTDr8K3kjDXqdOBjPlCIfVKodb1Tuja5eLUDfoGPaDnkBRyUFBcmn80JUh8Hy7RxYzyaGJk3o1fPC3lihbMY09yZSgBIeyrVY8/IkqNnDASgheIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgaKKsc8; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgaKKsc8"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78f049ddd7dso519265185a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 May 2024 00:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714548812; x=1715153612; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QEhYAfNRzOiz7KfRiTDGhXZh10qAy5O/FE5Ia9bwYv4=;
        b=QgaKKsc8hqyVAMNO6tk+6+g6r4PzeUGLXBYVgY6m9ZSUe5K3GulbNTAo7NMRBvRLJa
         O8mNWUl6B4HTTcWiCE7ASzljD4Fjl4GWSB+Jy1xYn1fIpaXSPi5L2Lvsj6vS4vf9NXi+
         uUAykabTgg3/1Ay+gmGbAl4Qv5vBk+iTGwWdAQCpn3nX0l1wUJ5cssHN4gC/YfpaUAkP
         GQJuWjkaIEA36gbPzqIBScFQvJNrWcviX/1WePj36W3s1xBA9nhb9c5VKZdjvs4QEBAJ
         wNV9ATwM4lPF2vfYd0JtSw3CzmFpzQPeIGLpRK4sF1PrZ8MZ9XD0CoMylyeOg9kfPahT
         Qf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714548812; x=1715153612;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEhYAfNRzOiz7KfRiTDGhXZh10qAy5O/FE5Ia9bwYv4=;
        b=KGlFQSYoaBurMRzWMJZ22pJt33SdhWJeOl0gnZxmxKYMCRUKYsaiLEAT3zxJXfXnKi
         6zoyVEnZUx610/j+W8MHB3eWSooavUvVXyUv5sANXvIVvGRR8gjJcDkRNw6pcN7AmxNA
         wQiN9+BQ7fo1bEyeW15LaiA7vh0xJnvP2fc1SejQGG/3p7cvk47pYh4BYWO+r2YK0dQZ
         B+jQHpUCM7UlYpZl0Zo+t8WwW4bni3SDlzheeKSgSe2t+plJpFzH/7RoeQD0VmY5Nrcz
         mVLTYYm8RKdjwk02TXqGsJSFds2dr9RltKSmJxMvGx6kg5cFj8O0q7mDCMNLuFrHmPow
         5SEA==
X-Gm-Message-State: AOJu0YwRtyNzuF26forxf5elJ+rsxY4byEmIBnuXqhS0fkbilMycJaco
	S57Jy3HbFnkePZBhwNdO9wTpaDkfmycWVTTBjMct+PlT6WWo8B0UJpvxyg==
X-Google-Smtp-Source: AGHT+IFYUEd4SsRBTAI1QsiiqrYtZuMB1hffBsomXdeqtNRwuP6AAu1+v5r3AdtKra5hu7gD1uYxUA==
X-Received: by 2002:a05:620a:4789:b0:78d:61ff:d608 with SMTP id dt9-20020a05620a478900b0078d61ffd608mr1735554qkb.22.1714548812257;
        Wed, 01 May 2024 00:33:32 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.5.177])
        by smtp.gmail.com with ESMTPSA id y22-20020a05620a0e1600b0078ec71866f7sm12027640qkm.58.2024.05.01.00.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 00:33:32 -0700 (PDT)
Message-ID: <6631f04c.050a0220.9b0bd.741b@mx.google.com>
Date: Wed, 01 May 2024 00:33:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2641588110807018296=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: qca: fix firmware check error path
In-Reply-To: <20240501063740.32066-1-johan+linaro@kernel.org>
References: <20240501063740.32066-1-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2641588110807018296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849572

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.20 seconds
CheckAllWarning               PASS      32.88 seconds
CheckSparse                   PASS      38.56 seconds
CheckSmatch                   FAIL      36.25 seconds
BuildKernel32                 PASS      29.14 seconds
TestRunnerSetup               PASS      521.38 seconds
TestRunner_l2cap-tester       PASS      20.56 seconds
TestRunner_iso-tester         PASS      31.65 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        FAIL      109.86 seconds
TestRunner_rfcomm-tester      PASS      7.35 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      7.72 seconds
TestRunner_mesh-tester        PASS      5.85 seconds
TestRunner_smp-tester         PASS      6.74 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PASS      28.64 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 3, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.155 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.196 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.175 seconds


---
Regards,
Linux Bluetooth


--===============2641588110807018296==--
