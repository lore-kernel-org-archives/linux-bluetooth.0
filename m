Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2316D1BC
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265015; cv=none; b=ONBHx7H9ATJThgBNtBC6EKdz/k7nvB/rXoXz+QRRbbTuqPo+NmQUDcejGhpVo76o7EDfOLn8MH6GLlMV5pBdf96vbAtgagNpwm11Z1bAC8xbf0isVmKtrFm0J/0cbqUPy4gmJ66uLx4raRdXnaZWuyzpK119tMFEeLzPiv4Q+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265015; c=relaxed/simple;
	bh=GfjYEL6lvKGkpFWeq5M9SAKF1tREQkd6sCPAoie/9YU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=huI8S3fqI9DhwB8R80RGYl2pWGUq4gE4fl2DVOTwhDWfdUdJZ1nFW9VffeipS05zTUDGtj84HTj75+TctRJEsQlazom+6Z9g+gFHgqTAeJqN4bWCngwxb+3/8430c86TW3LWKFxyTI60dCNbbLfbj8Tl0FOtmSaLV/u4mJ4+F3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/T7edBw; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/T7edBw"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69b0f08a877so22270356d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 03:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713265012; x=1713869812; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mXVtiUfDANbmZAxGgD/+3jguS8AietCz+Y07me9etCw=;
        b=Y/T7edBwi4O63bfQkXyQ4pF9yOnnUh68POoQT6IUmKqR9exNDMt/jEJkBvOgBfC5Ae
         vgvMO9R4Gysd2hVjOJF8yAGccv7WgcRufjnTIvfuOdY7Wys+GAttpyT8DAXiEvotlU1+
         hs4mC8rUtOdrFBCmB0GJGvS0UXg7stEP04q/hS2TGTDtV1hCDLyLFhS56uAzdvJrzUy0
         H+xtZcGFu/Yx3b2Z+7RBgymJ3FGVIeKp4/x7cjlft7iJjyEQ4ehjAGWKHhdWPltqDVCO
         3pubioEfjX5ZUXG9K4rPS6jujhjO6ekpK0b1tbqoYsPi2Z8TYt4v+t0CTmosLzQAQczo
         q0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713265012; x=1713869812;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXVtiUfDANbmZAxGgD/+3jguS8AietCz+Y07me9etCw=;
        b=HHTp2a0FLrVwkNN2uY0oXQnLpL2MlTj2TE0aKAFSea5OPDxD91xW/4g/ZP6Q2e0cmf
         nSrl0g57r3Tfv9cQ+6BxOKL3Rtf1mfnew3R878AX+LGdlOBGQOdovNSLKH0UJbzhP9Tu
         adw39AQYMDt5tg4CZQ18BbfASQNO+SvQhZUl8LYbGo4bD1ZM1rlkhisrabssWXKXwiwh
         41jOSBdjLdKqtmZAZj5aPugv129g+44DkOukViD95rUem4bn5edMrRvUUVElYIMBsfGK
         pFdKo3S+mGPxu4x4DFTF9EUZwmTLITGe96WiBImBuOYSiNqCfh0hgBSk8J4LB6GdZI++
         MS9Q==
X-Gm-Message-State: AOJu0YzQjv4wmo4K+973nURxHPFvs3Jaf4MNDWHJOUVwn9H1xthYAAt+
	PqWrPcAcbyAcABps2KnXFfdlg3fmruMdG6ICCoZa4i/E0CvqR6P5f8LSKQ==
X-Google-Smtp-Source: AGHT+IF6eTGekuB/lkKcD32eMWyC/d2wFfUc27RqV7QK5mo6PcheQUBUSxa7vM26ewseNH9WVQd/Ng==
X-Received: by 2002:a05:6214:330:b0:699:49d9:1498 with SMTP id j16-20020a056214033000b0069949d91498mr14276796qvu.30.1713265012635;
        Tue, 16 Apr 2024 03:56:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.35.226])
        by smtp.gmail.com with ESMTPSA id x9-20020a0cff29000000b0069b10f48ecbsm3136430qvt.47.2024.04.16.03.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:56:52 -0700 (PDT)
Message-ID: <661e5974.0c0a0220.a8d29.6c5d@mx.google.com>
Date: Tue, 16 Apr 2024 03:56:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4208883972819530973=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: Bluetooth: hci_event: Fix setting of broadcast qos interval and latency
In-Reply-To: <20240416102501.42996-2-vlad.pruteanu@nxp.com>
References: <20240416102501.42996-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4208883972819530973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845006

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      30.90 seconds
CheckAllWarning               PASS      33.73 seconds
CheckSparse                   WARNING   42.95 seconds
CheckSmatch                   FAIL      37.49 seconds
BuildKernel32                 PASS      29.91 seconds
TestRunnerSetup               PASS      538.69 seconds
TestRunner_l2cap-tester       PASS      18.36 seconds
TestRunner_iso-tester         FAIL      33.38 seconds
TestRunner_bnep-tester        PASS      4.67 seconds
TestRunner_mgmt-tester        FAIL      109.90 seconds
TestRunner_rfcomm-tester      PASS      7.27 seconds
TestRunner_sco-tester         PASS      15.03 seconds
TestRunner_ioctl-tester       PASS      7.70 seconds
TestRunner_mesh-tester        FAIL      5.87 seconds
TestRunner_smp-tester         PASS      6.72 seconds
TestRunner_userchan-tester    PASS      4.83 seconds
IncrementalBuild              PASS      28.16 seconds

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
ISO Connect2 Suspend - Success                       Failed       6.244 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.130 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.095 seconds


---
Regards,
Linux Bluetooth


--===============4208883972819530973==--
