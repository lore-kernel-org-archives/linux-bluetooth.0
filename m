Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233313D556
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711975257; cv=none; b=A5gkCOQ9+L8Yjqxlq5lm7Tvlu20TlfDkm67tscQJ8S3kW/v5il4aeuNfqU6r6SK2CGtez3/ONONtXDtcVCln6kCz1bexBcEaRTZD+xohWLFpMc3ZeajGVkgj4Ehn9mCgUl4ZyfCemMtdwypkvSz2LN+Vg8HBRT4VSmrM+BmsvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711975257; c=relaxed/simple;
	bh=kxQ4MP6nqh8JZK+2F1MfglkH0AqkSE1b57hXkn1y0dQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jeMgf1tRecq2wo14SVvEEsK4EOE0fGk0k3WeAhAFz12qvy3QmF/pMg5IAFSQmOUYgm1hT61yRzQgnp1Xdii0b55XLTss4VDuVT9FuSqwj6/ZDSfwyMEOCyOUsEmKX/AU83d+9DuE10NfG9RvLOFRS/M4+5ZS0dFw1WCHinbI7PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDiHClUS; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDiHClUS"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-229b2396180so2378515fac.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2024 05:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711975255; x=1712580055; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s/FryuT0N4E00RVIHl7eoGAR6cwEdFif3rkfqCWArnY=;
        b=BDiHClUSs07aWvxRSKFFYFfcPoaysjMWXy7VZgRpgaNAA5akUI+ghSPvRbWm/dUC/6
         bxF2z8WZSDGC+7WTx7D1v5dS3qCNFOTntO5g7WP5LsRLp6pme2rMm8MNA6z9KNpFf5ZT
         71K+7843kqNFNvk8oTpJaW8J/DLuFqkQ304G4OwVNA7WyNrc9Bytqa1P0hbpsgenLxsA
         Bi87dA+cBJzlHrgthVlELAieIPSRHTii7HF5RL5gal++ms4RCjI2lhAKhAC1dpB6tNMD
         TYZoeCvRosUe0XhbYBzHWSlj4Xei/YeUAnMcvMAAAbF5QMW+gpL+eDkkqzmzF7kbox5N
         cbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711975255; x=1712580055;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/FryuT0N4E00RVIHl7eoGAR6cwEdFif3rkfqCWArnY=;
        b=NWO1cJXONT05zUpkGkUiQ/0Jsv3nhEvCQJ8vnCwOYy26yqLJsSHlR/Q/HIRmozwzSM
         TIapfGhz45zSWDL2vW6vVNzPW69L2SP6XtF6Bvpn9Jx3p7h76rzUJPUQLAO4SgCpAeNR
         ItIX2cdHbSPVbAdpRC3qO+lE0sgsHXPyF5fLbwNtqacNy8lxOJw29Si+r5qf4Iv8KHNA
         Sb4nRvla7ag13fWTx5855Ildty91Xe0NyiI2jNF2i/bYdE6vrvLdLt7FBtgB3j9f0nXR
         r4eP53MHDSGsmf09zU26avEFUEzTEB4fgx9SCZv81/0Pum2lmzHwRzir7nUq8xHbS4cq
         0udg==
X-Gm-Message-State: AOJu0YxEITcAv0aWN08xmuYiy6Q+p8lp0GJaC4zMSo2/Arbwqo/y4nai
	BGbn7dxELncA1ElaS2aA5PjIXHYhKnRNLrAOxV38DVIgpAu4Zl2oQYE2eFCz
X-Google-Smtp-Source: AGHT+IH8Fy6KgPUSWfHk9jTqCoe7iqLEUrAI+uvpE1GGtk1NgrO6bjD2hSXo34QxngEptyc+5liwHg==
X-Received: by 2002:a05:6870:3481:b0:221:8a03:6de7 with SMTP id n1-20020a056870348100b002218a036de7mr9169174oah.32.1711975254845;
        Mon, 01 Apr 2024 05:40:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.23.49])
        by smtp.gmail.com with ESMTPSA id e3-20020a636903000000b005dc4806ad7dsm7735592pgc.40.2024.04.01.05.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 05:40:54 -0700 (PDT)
Message-ID: <660aab56.630a0220.d0f51.23a3@mx.google.com>
Date: Mon, 01 Apr 2024 05:40:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6736664523195113121=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/2] Bluetooth: btintel: Dump exception event
In-Reply-To: <20240401122559.1097489-1-kiran.k@intel.com>
References: <20240401122559.1097489-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6736664523195113121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=840240

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.48 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      30.06 seconds
CheckAllWarning               PASS      32.69 seconds
CheckSparse                   PASS      37.65 seconds
CheckSmatch                   FAIL      34.67 seconds
BuildKernel32                 PASS      28.90 seconds
TestRunnerSetup               PASS      522.61 seconds
TestRunner_l2cap-tester       PASS      17.84 seconds
TestRunner_iso-tester         FAIL      31.02 seconds
TestRunner_bnep-tester        PASS      4.68 seconds
TestRunner_mgmt-tester        PASS      112.40 seconds
TestRunner_rfcomm-tester      PASS      7.39 seconds
TestRunner_sco-tester         PASS      15.34 seconds
TestRunner_ioctl-tester       PASS      7.70 seconds
TestRunner_mesh-tester        PASS      5.75 seconds
TestRunner_smp-tester         PASS      6.75 seconds
TestRunner_userchan-tester    PASS      4.86 seconds
IncrementalBuild              PASS      32.48 seconds

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
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.219 seconds


---
Regards,
Linux Bluetooth


--===============6736664523195113121==--
