Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FDB36AEF
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907205; cv=none; b=AhaO/VaVexBKKfKuw2+KEqb3RZDfEimxKIGih07L4IVZokFYP7HLVrvSteFu4FmnidekGkk2V1K1BOaaTzKAI/6etEwKVWlYYbu8P2UqoSN3hGVm1YmG66LBPMGXAOnmVEhiPW2lPJkc4zSX+3kew13/YpHhWcfwqgZsBNcIof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907205; c=relaxed/simple;
	bh=0GhATHKIMJTLewywGqNkohm5pWdoSD4iwyN68Nqtmb0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H9khEMcqfIjYAVMVr6sC1mdFdXszleuoofcnYOXAGMzg4smKK0mQQn7usjb2vuZCFowivudn+eFTivIDBvlNJ2VqDrQmqG/oajyFwwbbk4Fd8S1dCtIzftdm+7JOPeDPzcA8toIp1PkT2nHg5q7/M5mTZVGARhMtFcgfPd4ZTmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTJh8QB6; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTJh8QB6"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78ec0d2e1e9so27278285a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 00:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712907202; x=1713512002; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qHMFPaNwvlCeDgCNz6ceDYVB/v0pkUfC1LAeCcgkj+o=;
        b=UTJh8QB68YEBSVmaMPjltEtu0cYDKj6f5Sa4mDs+Kq70wP9mRvgJpDJRwYNrqo/WF4
         pLd0PkW+jxQ4kTxx6+lr075RPGuFCHhJKWnDxT/hzHjxpFyO3eGD+XhPpyLl0+tHhU2s
         mFM3koBVLqfgfM4Q5PYa8HE4btBnyuZhzH1bhW5+gOIePF5bWRt/EtcOmkLPuaMsY1+x
         I0UgPfckdvn8vFf0UmT7ZjSW/BC/jOwjmb8mD6Ka/3hSVc3WECBtlkAnOgDJdUl6R8W+
         SSdjPaRpLqBNugexMuahntm3dhiBzKBasXcIXPFbXYZw3wfkx5TI96rUpW7h5hJrRjxe
         bqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712907202; x=1713512002;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHMFPaNwvlCeDgCNz6ceDYVB/v0pkUfC1LAeCcgkj+o=;
        b=uYGeR0AcNBEXB23F05U9OpcFEvZsUoe+eZLyRuXpkWW/xlkf5XhX3qsKrUJldXEkcD
         gSa6OE1um9xxpSXxjeqKkuDbKlEtujwpYIqQYoBpwgjBZ3IiMnL7xB6WI1WqbAcAXMnU
         H/0XArib5Qvl68nA5SbAVydOKB2jtuZwJCVY3fCGkmaPBRD03fD2Va1kRm4nn9w/o7Dr
         MBCDYyCSsEqyYpJohLq0vkmIebM3N7jO2rDmrrDkVISXTf8oxVqOmjAJ8vp7+m5MdzDH
         kTLqr5Gt+reMbP+y29LAjFLHOVeRhRb3FLvYrjjQLSCrsV1B5/H5VOobIBaCehOZUbg6
         /4HQ==
X-Gm-Message-State: AOJu0Ywnf2XVYKyJh9J14bprvxao2xtCTV/Axu8r9p4v7bZbaG5yxLPM
	Ev5l8bnZXParihX66BJUpI1pvtVwvM+5pc8X14RtgIKZTVKBx1+zFnp1BvCb
X-Google-Smtp-Source: AGHT+IEi0B30qOUpXGQ6gnSTVwh473pPjhz1uoDwvd/vvJGR25v09ty7ca78pBXN4pmp4pBuscWlkg==
X-Received: by 2002:a05:620a:248f:b0:78e:d157:d114 with SMTP id i15-20020a05620a248f00b0078ed157d114mr129100qkn.53.1712907202476;
        Fri, 12 Apr 2024 00:33:22 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.58.168])
        by smtp.gmail.com with ESMTPSA id n7-20020a05620a222700b0078ec4733decsm1605247qkh.80.2024.04.12.00.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:33:22 -0700 (PDT)
Message-ID: <6618e3c2.050a0220.c21af.3b4f@mx.google.com>
Date: Fri, 12 Apr 2024 00:33:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1026709928739663515=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiande.lu@mediatek.com
Subject: RE: [v4] Bluetooth: btusb: Add USB HWID to usb_device_id table for Acer NB
In-Reply-To: <20240412064307.6478-1-jiande.lu@mediatek.com>
References: <20240412064307.6478-1-jiande.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1026709928739663515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843875

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      29.94 seconds
CheckAllWarning               PASS      32.78 seconds
CheckSparse                   PASS      38.17 seconds
CheckSmatch                   FAIL      36.20 seconds
BuildKernel32                 PASS      29.45 seconds
TestRunnerSetup               PASS      524.89 seconds
TestRunner_l2cap-tester       PASS      18.50 seconds
TestRunner_iso-tester         PASS      31.04 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        FAIL      112.29 seconds
TestRunner_rfcomm-tester      PASS      7.47 seconds
TestRunner_sco-tester         PASS      15.17 seconds
TestRunner_ioctl-tester       PASS      7.82 seconds
TestRunner_mesh-tester        PASS      5.94 seconds
TestRunner_smp-tester         PASS      6.87 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PASS      27.79 seconds

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
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
Pairing Acceptor - SMP over BR/EDR 1                 Timed out    2.486 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.170 seconds


---
Regards,
Linux Bluetooth


--===============1026709928739663515==--
