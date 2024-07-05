Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D7146A96
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180668; cv=none; b=uxL5Mwt7qTcxiCmfUCo/7exaGBeMuldpeNE243bWgJoLu48coiyxroKL3xNWgbl/TicAzH9H/sGr8Aihynj+4uf2m39+UpeYS+zX1oxG8d4ueGztn34+czTf2Oqa+n7czxR/G1B8ZE/+6+voMGypnH1xr2v8nBjTzzZ/Duvkz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180668; c=relaxed/simple;
	bh=euq7dg3yLnfzyKAYjw6SMTYtz7/kDtHgtM7tA2RtMgA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WwYyTgluv4XO4cT9k+XEJ+PXxXbk01VES8jkMBDnye2Q2KcoZf99x3nurPB0E6lM77aGHoSCkc0UBmx8xbpDbQ08XZNGhN3v4WTCPWTHMCMo0HtA8qxBKye2l/e/d0BDqxSGNMS4Cgew995sjulhoimJFYGaEGX780yPSZtKz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpHenVTy; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpHenVTy"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e036105251eso1567216276.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2024 04:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720180665; x=1720785465; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ja6Vyhe5OEOeKfN4ARoj0Sfj4TC+D+2nz7XKzvko52Q=;
        b=hpHenVTyCEWx6/kAd17sGCICmIXYgeeTWGx7UbFdeI2x09Q+KUJO9p8cDCHizqlQ+1
         ImHwVi8aQSpDjTRI8rXaHcM3Kf8nUtRgJTmiePFUwbXAt72ZO6IBYu1BNtHwbjYzKPgm
         Iy40qL0l1d0qJ6o0ci/aA+/7Xe7Z9Klm1uduYjjZ7kpNXnjpuGmTP53u4RRDieb8Liq+
         rw9omTC/Og2qZ6e0A0HIPo0rTTiaM0LTxTD0Rme6/y4ImUUBQt3iYN+Yt/VfsLzxs1fK
         5jhnrkOYwXjyzeVjaVJrUQOod1+Wewbtv6AT5x+uGSTJ301ATpFuqRETrKg69hAZvpvO
         QBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720180665; x=1720785465;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ja6Vyhe5OEOeKfN4ARoj0Sfj4TC+D+2nz7XKzvko52Q=;
        b=hrRydXa9yVAnDda4u+swzFquAz7Suz6JcbNztk6IxsLtmRniptNB5ETtO9ojKkwHrw
         ExWWJ3SwszJ+1pSclrM/saJsRKJZIRbmavLw2RWryu1JsCrHzgFXkjBgyp2pGmW+xk3F
         raJQezAwsa+I0WicKWloaDH4NQXWt6li6gXXt80nvIJBeRsgYHlUYJO+tbR3++Iuq2zB
         3XvDfDXlkRV1nJQnJjXOz9xTvmK+P6yEf6wwQElMMQ5HLB05vQupnshYIGWp0AxALQ4d
         GCOwjUbejkqt1zXgdqdUlT+hVt9PLpyMMkdSmv4VmO37Wy9AvqGV1dfd4R/54cxGRuMJ
         3gPw==
X-Gm-Message-State: AOJu0Yz8Yr5Cb2hyu4Y0ugzVktkQgAT7cBun9rvYB8fwHxi8gfB1p0SA
	/oD9xHCbOOyoFNK1mB49WROH5rC++iIDi6LktTTah73CoPds2EFdP/rhfw==
X-Google-Smtp-Source: AGHT+IGkzjGfNaqaA4KORlS2OEjGEsaANmrDk+/52bp2xTm1l6QhFYzQdJ00yrq26LtpsHPDFzCwQQ==
X-Received: by 2002:a25:2694:0:b0:dff:2eaa:4946 with SMTP id 3f1490d57ef6-e03c190c6d6mr4864843276.20.1720180664918;
        Fri, 05 Jul 2024 04:57:44 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.91.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5eb6309fcsm15663296d6.133.2024.07.05.04.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:57:44 -0700 (PDT)
Message-ID: <6687dfb8.050a0220.f6c5d.4d0d@mx.google.com>
Date: Fri, 05 Jul 2024 04:57:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3406713192227699927=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+yang.li.amlogic.com@kernel.org
Subject: RE: Add support for Amlogic HCI UART
In-Reply-To: <20240705-btaml-v1-1-7f1538f98cef@amlogic.com>
References: <20240705-btaml-v1-1-7f1538f98cef@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3406713192227699927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868771

---Test result---

Test Summary:
CheckPatch                    FAIL      3.93 seconds
GitLint                       PASS      1.09 seconds
SubjectPrefix                 FAIL      0.62 seconds
BuildKernel                   PASS      29.63 seconds
CheckAllWarning               PASS      31.70 seconds
CheckSparse                   PASS      37.61 seconds
CheckSmatch                   PASS      102.57 seconds
BuildKernel32                 PASS      28.14 seconds
TestRunnerSetup               PASS      516.65 seconds
TestRunner_l2cap-tester       PASS      24.03 seconds
TestRunner_iso-tester         PASS      36.81 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        PASS      114.97 seconds
TestRunner_rfcomm-tester      PASS      7.36 seconds
TestRunner_sco-tester         PASS      15.02 seconds
TestRunner_ioctl-tester       PASS      7.77 seconds
TestRunner_mesh-tester        PASS      7.94 seconds
TestRunner_smp-tester         PASS      6.88 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PASS      43.79 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/4] dt-bindings: net: bluetooth: Add support for Amlogic Bluetooth
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#93: 
new file mode 100644

total: 0 errors, 1 warnings, 62 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13724976.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[2/4] Bluetooth: hci_uart: Add support for Amlogic HCI UART
WARNING: Co-developed-by and Signed-off-by: name/email do not match
#90: 
Co-developed-by: Ye He <ye.he@amlogic.com>
Signed-off-by: Yang Li <yang.li@amlogic.com>

WARNING: please write a help paragraph that fully describes the config symbol
#108: FILE: drivers/bluetooth/Kconfig:276:
+config BT_HCIUART_AML
+	bool "Amlogic protocol support"
+	depends on BT_HCIUART
+	depends on BT_HCIUART_SERDEV
+	select BT_HCIUART_H4
+	select FW_LOADER
+	select POWER_SEQUENCING_AML_WCN
+	help
+	  The Amlogic protocol support enables Bluetooth HCI over serial
+	  port interface for Amlogic Bluetooth controllers.
+
+	  Say Y here to compile support for HCI AML protocol.
+

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#135: 
new file mode 100644

total: 0 errors, 3 warnings, 816 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13724978.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============3406713192227699927==--
