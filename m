Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6DB15AC0
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jan 2024 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hliI8nCY"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-67f95d69115so78661286d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jan 2024 10:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704220532; x=1704825332; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S/IQ+3Z+nXaMidkb1sR9EjJe6IsFj1UFo6IeA/RFCJI=;
        b=hliI8nCYoU5znLXT2vfoiwcq4k5FPP89/dB1G4e0KJuUvTHXK9K2bQm+pJxFqTmiW0
         F1waGI50S72ThkB60sHm5J/pdgOETlpqutxIoga/gEfLGUZ6mN0gNPnyb45VacqCppMW
         d5MgBSg6VujDkkSkQ6kN/VP+cju4YNUOBcIFHsgj9PGH2ms4LUqEspF9BupyQsXDB/lm
         lc9Zh1i5/8LxhzZWXg6pvGfVHiSsW18amPxkxXnO+HFc/JX9Eqts1aUUrCwfdLcaHGKO
         KnBuGuG+h5GTYbGxRPvjRD7jhlt1qtX7BZ5S0RHC9Pp87LjYsmsESk0csMiyiaUztiJP
         s6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704220532; x=1704825332;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/IQ+3Z+nXaMidkb1sR9EjJe6IsFj1UFo6IeA/RFCJI=;
        b=mR6yLqa9zezOnYFqyEV+gjypa4TdD2zhX9cSomvh3bormca9OHUqigRMQel4esW/hO
         hnIA4DhR7STW6JxkEOfPsDue4zlPNccKhcsIC/P6DZHF6KwfksHDVRNkrDrT1dWfUmnR
         beUSW4Jz/q01HcGrH42E7V7LEVttodkxXC6EL+B/3/o7PWJtjdc/rKpxp9F/udbEHhyu
         Gk1Uva6VoL0zGxrJhPLT7U6tgVkvlFXYdaSt8zZoZUBejEm1zG7/VDAyCMrwAeNsLDD2
         wq8Jh8SdW+1IJ1RswprByymuGorwoQjfiTofEB4Dt3SjLZpYhBAz4GZXdJco6NGGfulG
         Ldrw==
X-Gm-Message-State: AOJu0YzUQxAPAUypmHp5qRYRiKs9WtTLHKxiOptMVXyS/dBRA7asCHYH
	BM5Ihque6xGbByY23GaT0lPjh4M8syM=
X-Google-Smtp-Source: AGHT+IFBeU4VOu45e6jPt243gxTerrCbQajMuwVd9KKMDFSCPQZL57HAslzjQkAWdKICKoQaGgSuvg==
X-Received: by 2002:a05:6214:d66:b0:67f:419f:976e with SMTP id 6-20020a0562140d6600b0067f419f976emr28152682qvs.117.1704220532138;
        Tue, 02 Jan 2024 10:35:32 -0800 (PST)
Received: from [172.17.0.2] ([40.79.247.232])
        by smtp.gmail.com with ESMTPSA id j24-20020a37ef18000000b007815c25b32bsm5265136qkk.35.2024.01.02.10.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:35:32 -0800 (PST)
Message-ID: <65945774.370a0220.6a48d.ebf2@mx.google.com>
Date: Tue, 02 Jan 2024 10:35:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1634668861510443690=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, verdre@v0yd.nl
Subject: RE: Bluetooth: hci_sync: Check the correct flag before starting a scan
In-Reply-To: <20240102180810.54515-1-verdre@v0yd.nl>
References: <20240102180810.54515-1-verdre@v0yd.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1634668861510443690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=813894

---Test result---

Test Summary:
CheckPatch                    FAIL      1.06 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.86 seconds
CheckAllWarning               PASS      30.62 seconds
CheckSparse                   PASS      36.10 seconds
CheckSmatch                   PASS      99.51 seconds
BuildKernel32                 PASS      27.13 seconds
TestRunnerSetup               PASS      435.46 seconds
TestRunner_l2cap-tester       PASS      22.92 seconds
TestRunner_iso-tester         PASS      45.88 seconds
TestRunner_bnep-tester        PASS      6.82 seconds
TestRunner_mgmt-tester        PASS      163.22 seconds
TestRunner_rfcomm-tester      PASS      10.99 seconds
TestRunner_sco-tester         PASS      14.45 seconds
TestRunner_ioctl-tester       PASS      12.15 seconds
TestRunner_mesh-tester        PASS      8.76 seconds
TestRunner_smp-tester         PASS      10.26 seconds
TestRunner_userchan-tester    PASS      7.34 seconds
IncrementalBuild              PASS      26.22 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_sync: Check the correct flag before starting a scan
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#44: 
calling hci_dev_test_flag() to test for HCI_INQUIRY, but hci_dev_test_flag()

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13509236.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1634668861510443690==--
