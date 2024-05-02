Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05513537FF
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642434; cv=none; b=MQUgwePJkiB4jcII0BAkfNQw5owokLlLwRnpvDe1XhJxk1BTmEaVGRJUkvMPKY8ra2qJZpyIwXvdhxEunONfffUP2+Nb4v58Jg3K+nMG+eyxslBDmWkZdsrsDovCedQfk0ja/Ixgp2u8fGyjhfnog1Nq0xoQngMVkn0rT2G/rLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642434; c=relaxed/simple;
	bh=Xc9FEuaWs7tZNuMDf7yes+ogKyZ0xS+h2WODc0GycZQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sSVFMlBOq7gT9d6qJ4DiWqbCUkC6IIo/flxZGQyFRcTeSwV08AHISmrkXcR5mTUdAFqH2thDU2xCU5LaeWQE92aV7wErJSxq+tweW4yeGvxfpH6WsXhZx6jdv1h1yoaQJnSr2/iIoUcxHvcxBaDbdrsvYAB8KPT7hukeMpJFwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it8Kwe3k; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it8Kwe3k"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso1188733b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2024 02:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714642432; x=1715247232; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3i0V2VNXuCDG8fMnqv2G8Vphp2HOq1nlrKbITVsUwmU=;
        b=it8Kwe3kWYKi2z7Y4A0TgOV2uyocOUjKm/7R0fMxwn+x7eBYz0otO5/Z2rdCx24IoK
         tdUzAazfJ2eJnT7uzxGCRYhkJOhwiQBHO3q85QY2A/pMZCaChfXNIGnErNWwe36eyYKI
         vzVaeu1OkBQFcLY4PN8qWZI8V/AdRyDWOmzUIE4uzafZ14+j9/ouIfKTfb6DPZ3s57Vu
         ntKZmA8pvG+ANmWZkyxwdSUz9pxRuPZnzrjWIRfZzPSEFf1WFNJ6FLf1onpwxuc2uHUy
         v0IJLoWi9D6VPhGkEtyIweZbcgHFb2iq3ZAMuQjyZXyeyMhn/E2w9grkqUlu8GVQa16i
         IpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714642432; x=1715247232;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3i0V2VNXuCDG8fMnqv2G8Vphp2HOq1nlrKbITVsUwmU=;
        b=fg25p4tdSbv3zX8ZBVxeAO4sWONN7I4mPJQ8KslddUU1mwmYZOZJHunw5OpXryVe9q
         0l+Gxzf44Vzts450BVjeu+HhH1htBJTnr6qlvjt/8pLaymT2W7nvOC7HECxwsTVdGhXt
         6K2C40NHKEWIXepqyzBf3JVhVgvA9PxecE5YMJ3GquXq2ujYB7TyRGYgooHVp7EVL/Vc
         7LGIgfskK2Oki7EtEqTc5LsW9t/xibvej+2vpns4oj34yme6WfR9xFPIJALHvaFr5TCo
         7NAkPZPJ7D/md8E8zJsOCq32syt670Jcp8lCO71vHD/CMs6kcO7RBSS6OC4xvEa9DcOm
         uSLA==
X-Gm-Message-State: AOJu0YwVp2k9M78scvqUYPU0ct0hYGgg83ww1XyhzaN5gG1nTkJWiKNZ
	H03po38O44oBoMY/uTy3hT5rFaKQi1ukjpkASj9BTwd5PQCAuauTS7gN3A==
X-Google-Smtp-Source: AGHT+IEDijiKTlIOd+rGMINpU2f0bOzPDd7bTSvKIsiaKeUYv38u4RuVpPMiJk9ibzxWeNWAUuiKjQ==
X-Received: by 2002:a05:6a00:1384:b0:6ed:2f0d:8d73 with SMTP id t4-20020a056a00138400b006ed2f0d8d73mr3271946pfg.3.1714642432084;
        Thu, 02 May 2024 02:33:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.14.171])
        by smtp.gmail.com with ESMTPSA id y26-20020a056a00181a00b006ead47a65d1sm793947pfa.109.2024.05.02.02.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:33:51 -0700 (PDT)
Message-ID: <66335dff.050a0220.6350a.182e@mx.google.com>
Date: Thu, 02 May 2024 02:33:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1759309989777182829=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mahesh.talewad@nxp.com
Subject: RE: LE Create Connection command timeout changed to 20 secs
In-Reply-To: <20240502090123.5177-2-mahesh.talewad@nxp.com>
References: <20240502090123.5177-2-mahesh.talewad@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1759309989777182829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849830

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 FAIL      0.38 seconds
BuildKernel                   PASS      29.79 seconds
CheckAllWarning               PASS      32.53 seconds
CheckSparse                   PASS      37.61 seconds
CheckSmatch                   FAIL      36.25 seconds
BuildKernel32                 PASS      28.90 seconds
TestRunnerSetup               PASS      520.04 seconds
TestRunner_l2cap-tester       PASS      18.56 seconds
TestRunner_iso-tester         FAIL      33.74 seconds
TestRunner_bnep-tester        PASS      4.67 seconds
TestRunner_mgmt-tester        PASS      111.73 seconds
TestRunner_rfcomm-tester      PASS      7.27 seconds
TestRunner_sco-tester         PASS      14.93 seconds
TestRunner_ioctl-tester       PASS      7.65 seconds
TestRunner_mesh-tester        PASS      5.70 seconds
TestRunner_smp-tester         PASS      6.65 seconds
TestRunner_userchan-tester    PASS      4.85 seconds
IncrementalBuild              PASS      27.52 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
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
ISO Connect2 Suspend - Success                       Failed       4.221 seconds


---
Regards,
Linux Bluetooth


--===============1759309989777182829==--
