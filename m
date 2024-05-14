Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93C354903
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680603; cv=none; b=MARvB5dZS2iDvyvdMJ6yQGfxPYevy7G6bDW+38YeKk4mZFNGedY0J2LbBR6y7CvMjfslsafTbcd2NxXmEIwFK4llTLp75h1xfiNT5gqaXIDKb8QTV3DCVewHlcfoasAFtXQYzGLv2tnRVfSeLAKUa1bYuz8COAyugIeAMahaR0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680603; c=relaxed/simple;
	bh=UAiU8CNIsYCaSXJAyvf1mAfnOHF436Ify88Py9eZX3o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tILjmdpN80wiu7uFnfIDjwdmInGrk36bNfl3UDJ6zZSVovvEJlDDbIt/zpSAsHiF24sTU5WH2ll7qqzdrChkujCZ0D1BgDmJycG5FHQp0SH6snVJ4Ue4SFPutL51u0arSq6jIdmY8QkYM2KsgrEMgjyAEsgap7jGnvdQqBLpB4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPww/YKC; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPww/YKC"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de60d05adafso5084843276.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 02:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715680600; x=1716285400; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AdCoAyX64I24rY9WK7+jsv2g/fdBjH5h+EoRVnbv+yk=;
        b=MPww/YKCFzWoHzKp806J6PMHEvCLN/hN2kpg+I7+vhoFIm0slvZAn0+d3gnbxtEiC8
         5QkpWNVfDV60E7HJiqzqV8qRRSW9m0i0LO5gsdjZ/ngBHKWSX8jhU9TO7Fh7PyUXpTrQ
         /aL4Y9gjqkXK3wjzjbhTMb0ccnZqloeqmrrnPTxtopJM86iWS0nyglHq1RqLLgPEr2zo
         63uhrzY9R3gVWrAEtRoUOSgWQ3++WFuZ8okZVejNZUpqFqvBEd5raFwbu1vfJNc1FNrN
         oGDQGMkIucn5yHAUErZtxBcqDwZb+gsyX0U+pIa6nMRBb3BIwvMiwfEWZHemiiTV0aFQ
         tGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715680600; x=1716285400;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdCoAyX64I24rY9WK7+jsv2g/fdBjH5h+EoRVnbv+yk=;
        b=gc66S3oNz1Vg42Hgs6wxpbP3zFFrO03p6xpM4JJXc6yLXqSM3zdhuehJcN3gPDa9PM
         xh4u7XdixqRLgoCVmUg5bSr6EAt4280I0LeceuRyZuGnd6C+99f9g3Tv6McwxBE+RSk/
         U3HA1P1Tl8oTQhHaCjs137BaarHCPOh85t7xshp1SfeVcSbERgYpBOSS5dZjwx1ntccT
         DUIT3rhIrrc9L873Qi/nCwsIjGsKlvcTLq4l9WFsp9A1QsWqmtT2/LFy9LNCen5v+ZLv
         bsWSo8cxGVqbA0k6RoF0ZM/oW05W+WjWrEnkYqzUVBKGmXwWtZHv4GR6SLLudc7hGi10
         U7AA==
X-Gm-Message-State: AOJu0YxPlatjCew8GAJlJoE/koP8p0uMIAS19XlanBlxmlm9Mt83i8hy
	HaveDuhl2s745s3ROheCXbE+7kDP8azjugPaEkYVxNu9XVWvjF2Rw7gXKcH3
X-Google-Smtp-Source: AGHT+IH6UZZPsidzXlAhI4lvMqMovprOZ5dMqTrvoRVHBkBNmD3viNsBMAa9FmscTKeouXrDJxfDew==
X-Received: by 2002:a25:dcc8:0:b0:de6:1352:5931 with SMTP id 3f1490d57ef6-dee4f30e60bmr9099103276.9.1715680600509;
        Tue, 14 May 2024 02:56:40 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.135.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f17a3d6sm52090816d6.18.2024.05.14.02.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 02:56:40 -0700 (PDT)
Message-ID: <66433558.0c0a0220.d1196.03a1@mx.google.com>
Date: Tue, 14 May 2024 02:56:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3800303717346730088=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v3] Bluetooth: btnxpuart: Enable status prints for firmware download
In-Reply-To: <20240514091444.1508033-1-neeraj.sanjaykale@nxp.com>
References: <20240514091444.1508033-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3800303717346730088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853012

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.39 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.00 seconds
CheckAllWarning               PASS      32.53 seconds
CheckSparse                   PASS      38.20 seconds
CheckSmatch                   FAIL      36.10 seconds
BuildKernel32                 PASS      28.97 seconds
TestRunnerSetup               PASS      521.76 seconds
TestRunner_l2cap-tester       PASS      20.55 seconds
TestRunner_iso-tester         PASS      29.31 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        PASS      111.61 seconds
TestRunner_rfcomm-tester      PASS      7.99 seconds
TestRunner_sco-tester         PASS      15.09 seconds
TestRunner_ioctl-tester       PASS      7.85 seconds
TestRunner_mesh-tester        PASS      5.96 seconds
TestRunner_smp-tester         PASS      6.90 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PASS      28.15 seconds

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


---
Regards,
Linux Bluetooth


--===============3800303717346730088==--
