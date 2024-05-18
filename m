Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819FC624
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 May 2024 01:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715994392; cv=none; b=FVCJMQULWhqIdST18eduCB1ONrB9fASvID5rXFS/69PY5gX5bcRjpHNNqsiKQODdXllHHGrwcc0Av0Kgu32b6T12cyMpOHQMhI1ILVGOoA9MDaBvU1exk+qnI0fD0CbS9aPkxKWz1xuyixkElEHudxmDouoofIfwp/uzC2wHzJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715994392; c=relaxed/simple;
	bh=ug89QDe0GIU7eqqccT4qVPJGLe+0mfFjnTEAe8l/UUs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ba5LMr6YQTF2rcdTgdEFSOzVYC7deM8sNdJg2TbQM2OpoPBdQfTjYEPFHS2tqwIkSPXGhQF0eQ4yMEUqzRC4tG97JkBTiKVtMgmj0e3K+WsX5Yr3l+iU0fJidyklfT2ZScC6ZmbX3zvV01bPGxqkyG9tPYdV20ONjY+eGYQogIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ne/rNUig; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne/rNUig"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de462f3d992so763101276.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 18:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715994390; x=1716599190; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xrZ78lAwe+DJKzW0zkTE/obg/DC3GHAwXcHBwi8q05M=;
        b=ne/rNUigg6udEcG9u+3MxvLWOxBcvlP8R0k/hQ8Enu63Ex3S50QzB5P0mG73FKkrCZ
         +ZLTD/gNZZYiXa4IajFMh2nQcsNhxWCedjREB4z4+Vk2uXc/dh0sZhF+iA3h7CFNig4b
         4+Lp+ZrX0aWRufdrzj7vnRNRoRFVZybtau9sqexXiGY3yrLr9PtgBg7cGwh6mlLW9UvJ
         sEarE252xrFKcOtqO2WqbyClQ0EX/95gjbY1AvKt564axwtXsRH0IazddBa4I0Vyns7E
         m3bJYHMN8to82ffd1mvt5s+ekrTPb9RARyt2BoP8JvK7lP6uSSeyMmeQqTQVpcML7KzV
         H78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715994390; x=1716599190;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrZ78lAwe+DJKzW0zkTE/obg/DC3GHAwXcHBwi8q05M=;
        b=lJ2aFe6jHj3XVF1GA3Ea6Hoj8tLXfmOsjdlDZM1PRKOcqXm0QyFNdqQPdfJlGGiKnP
         jy9HLd7z8ZOFQzBnHV3MHf0rSso2vQGhoBuelzoiHTSvNohlqSlzqmNuh7ujtjPn1al/
         bOADXxZTJ9NvJELeuR3Cf5r5rcOnMhz+AQL5HIzoP8mawxjTjioFYVqAte5+JqMR88vY
         J73YIiDCHDx7hjptxrwUQeSXQsmoOphBrDTpppDakRyYh2MYG4O7dhSSufkTu/5Jz8yQ
         wVCx44XcvfUqZ8lLAfy6TWSCWg8yGDfk4Tgnos/6y0DJv6IVD2JgFdN+GpVWJo4uhCgF
         PMpg==
X-Gm-Message-State: AOJu0YyxZewK763PzEUskxpPHXtqIVZT3vngk44Cl0O3ALueuNzyd0fH
	/TwQFxWY60e9CIZ8MepB4LJzfq17bKwBKHW06zSFOB9At6CACbcFpaKHNw==
X-Google-Smtp-Source: AGHT+IH+SNJ2fMOUkC7h3qggRh3T83nfkDWtPCjSIW4sjBWPMZCw0shULwrizjt7M2Jiy7Y7ENhbCg==
X-Received: by 2002:a25:2c1:0:b0:df1:ae76:ca0b with SMTP id 3f1490d57ef6-df1ae76cb5fmr11272194276.43.1715994389943;
        Fri, 17 May 2024 18:06:29 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.107.245])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e0a4bdce8sm91537161cf.18.2024.05.17.18.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 18:06:29 -0700 (PDT)
Message-ID: <6647ff15.050a0220.88e1e.ecba@mx.google.com>
Date: Fri, 17 May 2024 18:06:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5688253390935905728=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dianders@chromium.org
Subject: RE: Bluetooth: qca: If memdump doesn't work, re-enable IBS
In-Reply-To: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
References: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5688253390935905728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=854121

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      29.99 seconds
CheckAllWarning               PASS      32.49 seconds
CheckSparse                   PASS      37.61 seconds
CheckSmatch                   FAIL      38.05 seconds
BuildKernel32                 PASS      28.58 seconds
TestRunnerSetup               PASS      518.20 seconds
TestRunner_l2cap-tester       PASS      20.53 seconds
TestRunner_iso-tester         FAIL      33.05 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        PASS      112.08 seconds
TestRunner_rfcomm-tester      PASS      7.30 seconds
TestRunner_sco-tester         PASS      14.85 seconds
TestRunner_ioctl-tester       PASS      7.72 seconds
TestRunner_mesh-tester        PASS      5.80 seconds
TestRunner_smp-tester         PASS      6.80 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PASS      27.90 seconds

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
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.177 seconds


---
Regards,
Linux Bluetooth


--===============5688253390935905728==--
