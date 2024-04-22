Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5294F1F2
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772591; cv=none; b=ly+ers0ZnQyELGLyPQCcEhhw0DnMbWtdoX2fZedBKHOJJ08akhXLQ5dD6ErVwuK2XpPiimFp/gzoDWzUADrF96lAKZbyTlmRJvWD5wsTAUuGeTE44ku8QHsSMUREgMyHMR9FsQA8Bqen48ufKzMc18CbBAWOnJFb+YbJuBdqX5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772591; c=relaxed/simple;
	bh=wQ0CYqDD59VBD0vF/ja5fwevPb/kl5mrD3rRSxBW4ac=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QyLcF7IPMem0Qc5FDBrb4L/ZaNn8NI0bh2GV+yKmdy3pSQoey45HQqGtnoo6isO+jtL6De6mE4HrxampO6WABqXb7v9UcRCSK2thKZPCeina5mKc0h1LvqOnDA231FS7M2lZ+Lwo406ywJMmQmeousEwSTeMUTcZcnuEsBG5zPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU3IIvTR; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU3IIvTR"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6164d7a02d2so48584577b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 00:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713772588; x=1714377388; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7ChQVy2KUL6bPZSnz6FMerJnevXUvunrMVgpHOIPXuU=;
        b=PU3IIvTRDXUunjJxdWoGO1dOagyf2uAbX0AHI+JR8oBhiW2yIL8mILbgik0n/kxShm
         K/UCy/8aA406e7I89yW+c6hSp5QNu9THon8Y+pM309GC47Ro1ZoVrGTMaNKva91o/on8
         kNwfdJMDw0uCgJeD1x8M7yei0CPLpHTSsfGgpzBm3zzn9swMWAHdqhAlHViqx8zIEjBT
         DgJPwDKUJOPkwWccc53z7I6aKxXkr7+buukAJNeS5dQXjoX5lO4aLAuh2at59crHcLHi
         c2c8pGHVOQxtBajaG9+jYDHXTv6pQLYag1Mdnx6cK0LZ+ahCTsuXQg5A+nkFXWxb+xpC
         1KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713772588; x=1714377388;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ChQVy2KUL6bPZSnz6FMerJnevXUvunrMVgpHOIPXuU=;
        b=QL1jSag9df+f6fPLZZaZXanYzxMrf3iv7QqTyMvKcY/a5neoeSW2t6y2vIyjetA9IK
         b+U8haHX8AisVLqIc27ne9vP4FjWy0mD7NOTxspNalZBIzCI8bQs1VdT9KrS3qD4gxq5
         2eTmObKSOtiNyJQOCNEEWzMwE8oEq7XpmTXy3Sp0osvfV/5julTz7GSN2UCDv/sRER/O
         hdkLV3znoToDD8hVynRw8JwO376thUyGUFHR/esemWTidBmX0VWGkm1VVpDlwdote3g7
         XYqjGVQk6AG6zaxhgnLWuzVIhEAsR7RhfoW7nHZG67NR9ZxHkbTYaal7WPByufereivQ
         0iLQ==
X-Gm-Message-State: AOJu0YyQOSqxfwItcAdYD5C2NqcXhTaX5jWQ2OxVBYG/vcDJJB/Ko4Iv
	4eBthcumQOwqjAf//gjtHQnvswZT8AYZEoYKS6yWaa0b1HjFWwbOJYsp+Q==
X-Google-Smtp-Source: AGHT+IHSe6xFzi+3WvjTxZRr5ifN+6s6gdNQZ4ZEPzvxFLfpT0n48rcCJ45S4iIsDjltwRX0v69dQg==
X-Received: by 2002:a05:690c:7486:b0:615:46dc:44db with SMTP id jv6-20020a05690c748600b0061546dc44dbmr9217118ywb.35.1713772588597;
        Mon, 22 Apr 2024 00:56:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.6])
        by smtp.gmail.com with ESMTPSA id w66-20020a817b45000000b0061521b0bb33sm1862898ywc.63.2024.04.22.00.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:56:28 -0700 (PDT)
Message-ID: <6626182c.810a0220.4da5f.9382@mx.google.com>
Date: Mon, 22 Apr 2024 00:56:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6157260834431413043=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Bluetooth: btusb: Add debugfs to force toggling remote wakeup
In-Reply-To: <20240422152500.1.I8939e49084a6fef78496eb73edafdf3c2c4afbf4@changeid>
References: <20240422152500.1.I8939e49084a6fef78496eb73edafdf3c2c4afbf4@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6157260834431413043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846522

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.89 seconds
CheckAllWarning               PASS      32.63 seconds
CheckSparse                   PASS      37.87 seconds
CheckSmatch                   FAIL      35.74 seconds
BuildKernel32                 PASS      28.73 seconds
TestRunnerSetup               PASS      527.30 seconds
TestRunner_l2cap-tester       PASS      20.41 seconds
TestRunner_iso-tester         PASS      31.07 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      113.58 seconds
TestRunner_rfcomm-tester      PASS      7.51 seconds
TestRunner_sco-tester         PASS      15.17 seconds
TestRunner_ioctl-tester       PASS      7.88 seconds
TestRunner_mesh-tester        PASS      5.95 seconds
TestRunner_smp-tester         PASS      7.00 seconds
TestRunner_userchan-tester    PASS      5.07 seconds
IncrementalBuild              PASS      29.30 seconds

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
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.170 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.203 seconds


---
Regards,
Linux Bluetooth


--===============6157260834431413043==--
