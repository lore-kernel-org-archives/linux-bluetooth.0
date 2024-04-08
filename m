Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE02B57882
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572555; cv=none; b=WvzRVNgc3EHm+2Rv3YBZL33cEC8BLYL0uoZcfmFu9n5n3ITSePSeo7ZE8iJnDzdeo+YfgAw33YkSy0gBh1jqREfwk7d5V3P8F5qpeAQczi9UBaztak+M850tCt8jsE3DV+9SMAyNpfF5FgbjVlJ0FYC7gDel3Gxkv//6nPvqo18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572555; c=relaxed/simple;
	bh=z0SUZoV16SiT6qHHcs0z5MkD5Fb6DzyMCLRZmAqF2UE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N744JM8TU8ncxpiGlPfBu57IDBG+7oLFhhEF5w/ieGOMKhzWyrTH44NbpR7h5OfLi3GwtMm0Z+94JqXGQ8quC0Hcm/cJZH8XkrxAp4G9Cj9G531FbZk3rKFmqHWA08vRmZ5nPY+1oSr2Yv0VOlYT6lR5mXfzdKRhpQEYU7ZWyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2tFCFw4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2tFCFw4"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed01c63657so2236548b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712572553; x=1713177353; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NG4iO/vzEZf1kmMm5JboZcViVkA0NhR4MnQl49hlPrs=;
        b=K2tFCFw4rqrNXqhc/ioiCofQnpf9kZj3akhiLjpWFsRXy13CwEPNaoGysDeaI2mZ1H
         BxNJv9XcCZoURVFZ/SRUIwupf54KNAB0R6zvy97mXDQrXBsgvZ7MxihVo9wXgyI+rJIy
         UYW78vMKxX/eXvXbuq43jkR0fxxOHBkQEKJVWseDLvqVsapWKDMfCyL8L+737HLWQfow
         QtBXCVz7yubVBsxn12JiTWrXhODkZxgvOp3dioGBQLl4CM7J/Z2iRmZef/ffCYyJz86s
         c+JdEkA/HkG4cVegjtCVdZCMycfJCeGiCC/Cd81DCaLf59TzXRopiKK0r4utNUqpHnZF
         kBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712572553; x=1713177353;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NG4iO/vzEZf1kmMm5JboZcViVkA0NhR4MnQl49hlPrs=;
        b=ftnV5+6lXTmdyhvNvVp/RsZ5F1NYgikbyxq0mkEoZaTb13lNjiq41bS6VJTKRksA99
         OuGcizC4FMWGR5PGqNT3K+07deTq0/OERRi5Iz4dnfCxDV08MXIgVxv6+rzdakFftMXv
         96EL1yyRESbmukBeEb6JAbQOcS8r4mWn0SjLpZG8MfOYgYUKZns8nXHanToidbpPVONT
         kaMC7jlKI8z5ZDZ3/SM3rAhvjU4m2Co1YufjthHz1Wg+eUTF88EG+0z7o3M+pI/L8kj6
         kYeaHwYeOK2zNlvsRNGuAaZx3Hq00cuwC9hxBeQp1o1p4ySqg4q9Vd15+MiL3wU3QUCf
         hbYA==
X-Gm-Message-State: AOJu0YzF1eKR3rs2TpblH9cwjwySfDnJJk33Nqg8rWcRMijmCJAxNeP2
	/0hBCjrmOfBir156DgxND4bqtGWQvzRitl0w0YRtfx+1+D+mu/F362pVzCo7
X-Google-Smtp-Source: AGHT+IEyITvDLcmFiNumv/XSJSeVzWQGZOAe81C4rL1W4HxoFlQ5hiLvXyTWHoGUjauq/ehtDoCnUw==
X-Received: by 2002:a05:6a20:43ab:b0:1a3:c8d5:707a with SMTP id i43-20020a056a2043ab00b001a3c8d5707amr10314309pzl.7.1712572552910;
        Mon, 08 Apr 2024 03:35:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.46.66])
        by smtp.gmail.com with ESMTPSA id ju10-20020a170903428a00b001e2bbc0a66fsm6616294plb.234.2024.04.08.03.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 03:35:52 -0700 (PDT)
Message-ID: <6613c888.170a0220.7e35e.0772@mx.google.com>
Date: Mon, 08 Apr 2024 03:35:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1236913354239419429=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, surban@surban.net
Subject: RE: [v4] Bluetooth: compute LE flow credits based on recvbuf space
In-Reply-To: <20240408094141.720096-1-surban@surban.net>
References: <20240408094141.720096-1-surban@surban.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1236913354239419429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=842388

---Test result---

Test Summary:
CheckPatch                    PASS      0.96 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.01 seconds
CheckAllWarning               PASS      32.77 seconds
CheckSparse                   PASS      38.02 seconds
CheckSmatch                   FAIL      35.04 seconds
BuildKernel32                 PASS      29.01 seconds
TestRunnerSetup               PASS      521.51 seconds
TestRunner_l2cap-tester       FAIL      20.61 seconds
TestRunner_iso-tester         PASS      127.88 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        PASS      110.45 seconds
TestRunner_rfcomm-tester      PASS      7.26 seconds
TestRunner_sco-tester         PASS      15.03 seconds
TestRunner_ioctl-tester       PASS      7.69 seconds
TestRunner_mesh-tester        PASS      5.84 seconds
TestRunner_smp-tester         PASS      6.78 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PASS      28.05 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 55, Passed: 51 (92.7%), Failed: 4, Not Run: 0

Failed Test Cases
L2CAP LE Server - Success                            Failed       0.093 seconds
L2CAP Ext-Flowctl Server - Success                   Failed       0.102 seconds
L2CAP LE EATT Server - Success                       Failed       0.111 seconds
L2CAP LE EATT Server - Reject                        Failed       0.090 seconds


---
Regards,
Linux Bluetooth


--===============1236913354239419429==--
