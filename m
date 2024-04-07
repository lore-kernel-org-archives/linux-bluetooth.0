Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9492B9B8
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Apr 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712505412; cv=none; b=fkKz196T5bRHQK9TuFrqIN49WfO3Zh1iC9cscx3TkHPrO8fd6FCra/B7qXRAQ71ehKLY6hyU9J6OHID4A2UKII+Lv0AxSfvbpxcZ59E8NWRgCS/waSKLRaQY7e93ap0f6N1pIc6HeYdYNtzlqqXWFVpBeniCnSHvEdmx1sfbX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712505412; c=relaxed/simple;
	bh=V3fo7wiTsJ0BKJNGVwL0IS+s5sjUz42mNCNPHRmAbF4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gvaZV8HB3loPTHqPcQR2E3i0Qb15DfScFEiLI2410kIa7VwToiHv4smvIo19i3qCtZGP/YYnTzPjwQr8LU/jAm7IrNMHY5WbNjX3sZUdFikDg+uYME+MZ0lWkzNVQh415CtTu04cRuYDcArvs+hH+ejDfc5Rt/VlvSzCgYNQHQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdVeqZS6; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdVeqZS6"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4349685c845so1328781cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Apr 2024 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712505409; x=1713110209; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D6W3bqXFm6/f3uPJJ38iqyFSsWA6cicavxhqQ56AfxU=;
        b=VdVeqZS6byTscd0mHjE4YqAv8bya7U6widoHh93BBrbGz1xd457c4qhqHeWHVzSAb4
         jWh2vqgyrqyrzVJlejE4wwwfhd9WgQl9h0EaO4G+OJEDa86LWNFNS35jR8GcNtshDocE
         TDtoMFLRSuKJB0SRClbAtgf+liT00JDycAH2UNopsX7yaGexUlQxeg1IKX/cXivd0dku
         6sGvdpLIokH6MkPf3Pf8cZJfMMjTbG8j8MKAX1c6CiG79wEbV1n4a+keUiHtD30u/6gd
         x8c0xZOQLIISdabt0GaQuhFJfZf8lSShCwgd0RuurOQF+CDGTkxrV6PO8ppkKD3PT3jh
         +5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712505409; x=1713110209;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6W3bqXFm6/f3uPJJ38iqyFSsWA6cicavxhqQ56AfxU=;
        b=XoKzVuhREWrGl9feLme4MlnndVMxX3lghdpf/ffR/+5JgLY1xT1oVDiM5o6c9FYJ0R
         MTBowXsyH7P0HgEScLkqJP0fOrb6QKzdNYqOVVmMU2WSx9LQTDkiopBvS2825SABTvRe
         RPaquy/zb1k/2IMPit23uodyLg9KU/BT2q37UC/AYb/lHh6hVToNEPA76DqzG6v9WaHd
         YbgyOBeeoJHzVII5YD2c7WJo6XX9JVsqxWSf8UEBP/jXs4dKNzc8Y+YjWA+iSSlC8leI
         DsjNH9DJUAE67VSByvIMoQtcC4US4EC0xea5Oh8XtnxskxgLB4yZhXbALfF1DW4a5jOP
         lvtQ==
X-Gm-Message-State: AOJu0YxjWzOD/L7NTlFsXroiZ+S4LXwe+OUac77ZiulkBgKMMZT35Bj/
	EgJ/xLqObren/F8XzJfaYCpDsHgQlxkO1aoOnOKQ6vhyjqYqmYgdX2wHkoVI
X-Google-Smtp-Source: AGHT+IETDMBYxMHzfImdyuTQikOor82QAozEY8VoB86n+u2bfU2oK2yheJv93ZaJhUzytyrFel4TQg==
X-Received: by 2002:ac8:574e:0:b0:434:4886:fe53 with SMTP id 14-20020ac8574e000000b004344886fe53mr8076949qtx.48.1712505409464;
        Sun, 07 Apr 2024 08:56:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.206.225])
        by smtp.gmail.com with ESMTPSA id u3-20020a05622a17c300b004345ce545b8sm2727107qtk.61.2024.04.07.08.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 08:56:49 -0700 (PDT)
Message-ID: <6612c241.050a0220.2b1e2.093e@mx.google.com>
Date: Sun, 07 Apr 2024 08:56:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6142732736150798296=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: add experimental BT_POLL_ERRQUEUE socket option
In-Reply-To: <f57e065bb571d633f811610d273711c7047af335.1712499936.git.pav@iki.fi>
References: <f57e065bb571d633f811610d273711c7047af335.1712499936.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6142732736150798296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=842180

---Test result---

Test Summary:
CheckPatch                    PASS      1.73 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.08 seconds
CheckAllWarning               PASS      32.97 seconds
CheckSparse                   WARNING   38.44 seconds
CheckSmatch                   FAIL      36.55 seconds
BuildKernel32                 PASS      31.61 seconds
TestRunnerSetup               PASS      523.12 seconds
TestRunner_l2cap-tester       PASS      20.36 seconds
TestRunner_iso-tester         PASS      30.57 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        FAIL      111.13 seconds
TestRunner_rfcomm-tester      PASS      7.30 seconds
TestRunner_sco-tester         PASS      14.93 seconds
TestRunner_ioctl-tester       PASS      7.72 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      6.81 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      28.40 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/af_bluetooth.c:226:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic blocknet/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
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
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
Read Exp Feature - Success (Index None)              Failed       0.087 seconds


---
Regards,
Linux Bluetooth


--===============6142732736150798296==--
