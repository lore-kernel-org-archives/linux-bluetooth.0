Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DCA1C2AF
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714628025; cv=none; b=jacOm7vSSbfZVUqmFCKfXnntxZLCAVeZmMeA5pwkoBrxk/K2mqD3YO1uFwuZKBl/p/ZSyjh3uQZ1yxTBb9aEFWghJJEaCdamPpLkabvBeVv94NW6fvxpSJaWdCLhe+YgGFsZ40gPcHmLreDsiCtVqfGvggf7m5TBFsjnjRMl3Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714628025; c=relaxed/simple;
	bh=ln0EEeuxzOhiOS4lWCQ0ppq2IPMiwt05w2n1mPg3Ras=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fTQiTa2/OSQFO1/FnhpgOTUYC1Rvm6mUI1fbxRTIlY4ofQLTrZ8DOZpi3V/IeKkBM1F0uC2v1OaiGBi5Y595aaDDEH90+h1pgPHqJXVNJOlfWKDiSjnjCgpOiyENrkrbing7oZRCaeHgLSfUJ4UdGTjjuDcDGPJMXK5tBry4dY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrJCA9NY; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrJCA9NY"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-434c695ec3dso41064331cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 May 2024 22:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714628023; x=1715232823; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SSdmPvFcVBGlcPkcBWpbInhX7mUUcs7yrorw+578tQY=;
        b=YrJCA9NYbKo7O4zg4KpFLy1yrhQAonkLpLwX/Pzz8hvIvh/ojYssV5HLEwvdDkQuBC
         MVHfByf/xPzDkb7xBrKqVevEbgMa3rhj3cwqzlNjEovskcoSQQ97Gqlnnl+0OY093YjZ
         Mrzi0Qlv5MwEFaXhtbDB3aNyt0/UV/GhoIp5By8R1mrEaWZX6rMCiNMvdRC5t9LoJ2z/
         ldWheyRvo3ZLJAo3wHfkKA9mhc9dUDWOKld3pPEoAva4W+Ut5QfqYnBbrBo7CKDasNGT
         bKPzjfyfzc9sL7FHKxxk+viTkYZr2PGhpbbAjSuwnGjJovs7G/B0LK0jPGiRga6JJuev
         KEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714628023; x=1715232823;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSdmPvFcVBGlcPkcBWpbInhX7mUUcs7yrorw+578tQY=;
        b=Kr+J+KQqxTasVP5JPOsfKlCfR7a998j4ga3ZNeL+EeiaPN8DRKDqF5wAbwPUDdFv4A
         RRhEnJWNzfqhrmI39jZvpMLTU01rncqZztk2aj4I4vYXFz8qsVTXpQCncQzoyRNJkcmc
         5aJOHW9xeGxIG7H0hOyEelcTX8xF2tDl00aSQxZiJl7Pxu7C9FGiyod+oWmJVmumnP1J
         sHKZiORkPNxthtbqLwPR0smTgbkw0UdLMmimPSaOjS7J6WF0Jlm54uwRqy84SFh4EKR5
         9sKq5pEJBARnpgpRmvW62SPGAC3LE7czwQSjl12ilq5n+1Nzs4fiKBm12nNAUx1WBgQA
         5+hQ==
X-Gm-Message-State: AOJu0YxfIBV6TQIfwRazEsrAprsLVwY3EO0MLJyI/9Ti9d1TbVObQW6S
	q5ETpF0VHqFtp9EYqBzYSrC3ZHd7eV5zUXyYHse4JcV60t0RLrCR5KRd0g==
X-Google-Smtp-Source: AGHT+IHjjeIihKe8PkqHn5EdpTwtx1bYbEd8RJtc/Y2csvW5TOKXC7jg9cTVby8V8FqUKY9yDBHxSg==
X-Received: by 2002:ac8:578a:0:b0:43b:758:6cc with SMTP id v10-20020ac8578a000000b0043b075806ccmr1192806qta.39.1714628023034;
        Wed, 01 May 2024 22:33:43 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.82.216])
        by smtp.gmail.com with ESMTPSA id bt9-20020ac86909000000b00437a02f67c5sm148081qtb.49.2024.05.01.22.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 22:33:42 -0700 (PDT)
Message-ID: <663325b6.c80a0220.19707.045d@mx.google.com>
Date: Wed, 01 May 2024 22:33:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1284782089253118698=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] Bluetooth: btintel: Add support for BlazarI
In-Reply-To: <20240502052356.2630798-1-kiran.k@intel.com>
References: <20240502052356.2630798-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1284782089253118698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849788

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
GitLint                       PASS      0.59 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      29.72 seconds
CheckAllWarning               PASS      32.10 seconds
CheckSparse                   PASS      38.11 seconds
CheckSmatch                   FAIL      35.68 seconds
BuildKernel32                 PASS      28.43 seconds
TestRunnerSetup               PASS      513.61 seconds
TestRunner_l2cap-tester       PASS      20.23 seconds
TestRunner_iso-tester         FAIL      34.77 seconds
TestRunner_bnep-tester        PASS      5.29 seconds
TestRunner_mgmt-tester        PASS      112.66 seconds
TestRunner_rfcomm-tester      PASS      7.28 seconds
TestRunner_sco-tester         PASS      14.90 seconds
TestRunner_ioctl-tester       PASS      7.54 seconds
TestRunner_mesh-tester        PASS      5.73 seconds
TestRunner_smp-tester         PASS      8.17 seconds
TestRunner_userchan-tester    PASS      4.81 seconds
IncrementalBuild              PASS      33.92 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.165 seconds


---
Regards,
Linux Bluetooth


--===============1284782089253118698==--
