Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3616F150990
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792797; cv=none; b=r5pAvrhHzUjM9KFhSAwGBuxjOvxqPxUHuqTHOkVY8rdOynUq3PQjo5dc0dTcq1rAMVnXZXn3J4bMqyOZQM+6Mn5/u72ypOHlVv2bAuvLC6RQgdJbmdvb/ydTRYWqAGyrK8PddESDEnI2wl7kCeg3b0fNe8Dd0uRda6x8ML53EhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792797; c=relaxed/simple;
	bh=T/8QPH2Ge0n1QLApMNOoIav4xczoNureaXhiyHAk+Vk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MB1trIVUfBjVbjFk/YExvYqChB9SMc4fEkPpY/rdcxUb9Ipcl2Xi3MVfLpIkf5mehhGN9WBqjzJuKFvlzGKz1ZHkua+VbLCU+lfAyxF4WM0iOoOXxOIGAkM+hTIr21bsKwWw7j2DwdWTqXtY2Y3oz7Veu0ndbV8vXLhHWtHeVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvYYE8gZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvYYE8gZ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e651a9f3ffso23967385ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 06:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713792795; x=1714397595; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9qUp9nQQb0hw/f64k3KcIvJNOFB1AIq70+fUL34faNU=;
        b=BvYYE8gZ5h8/2szM7DNDECRRFxi1zBwxp2fZZewYjDqUlziouMS0Uxllcz3/5U4dJW
         e4CGWDRTzdAn7aDAtptKW5PzzSgf7vM2pwfzsFO5BIE/Q6w1Y0rRL4PQTNGZ4nWeLOg3
         gzbMdCwMCo1QmwexR71/LH2Co5fhLDfloySf5sD3pczi718g/rK7vVb7PJL31YiBJ7EZ
         IpWum8Hc6X61G0WmYveM4uKPXHi35EPnV6GMfgdv+8MOr8KSLPKhMlj/1+fOwqpkWgMS
         sTTw99QORAYxT6uh1+CqfGQLRPWDSS6puOgw+fpTmwj0F5xQPP6VNLeE6mC+8yex3BwA
         CvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792795; x=1714397595;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qUp9nQQb0hw/f64k3KcIvJNOFB1AIq70+fUL34faNU=;
        b=AAx0KpBCv3+gAOcW63jgVEwfHInXnfR1HbEH0S2VsPwZqvsvmM0S8fVd2m4MkoGcHS
         EMVPcKqKrrL51pvaH3+n2KdJSJTHNkDVuWK+9rktbpE7zWpPaWk12xIb0atOW5dZOTFx
         KSXYx5C5lNMpgPLytcoBvmHah4zSkS4putuDvZ5dK+TMTF4ZHVsB8QDohFQLpyCCsz1f
         EU9zsXVeXvGGYVpCyXwFrGYoQ3DuEmWQAKdvrI41gldCI5vc6PYsd1lXqOKlW+t/KO3T
         UDhB7iTRuc0MMYXyd1Z1uNNo3W5PWyC6hanjhn0xSGXL2tIOUosRx8iCb7piU3t3WbTf
         XN6Q==
X-Gm-Message-State: AOJu0YwIs3CQExZm7iCP/hEvYHJYADZ9ifUrb6rPLfGUc2kgF4NmJujz
	h3IiVO80/P/ldX8AFw/G38exGiJCIJ0BZplDQzwseR17fD1nIq4FpLV91g==
X-Google-Smtp-Source: AGHT+IHTggX7mC6AdnQLBiQYlkzEtJ7yvx2eg+T3dXOD4mUE1uc+qG2KolIe5TaimUV5GOmW80GHUw==
X-Received: by 2002:a17:902:b486:b0:1e2:718d:f290 with SMTP id y6-20020a170902b48600b001e2718df290mr9763204plr.67.1713792795046;
        Mon, 22 Apr 2024 06:33:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.17.135])
        by smtp.gmail.com with ESMTPSA id k124-20020a633d82000000b005f7d61ec8afsm5980500pga.91.2024.04.22.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:33:14 -0700 (PDT)
Message-ID: <6626671a.630a0220.f2d2e.37c7@mx.google.com>
Date: Mon, 22 Apr 2024 06:33:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5945179458833856578=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()
In-Reply-To: <20240422130036.31856-1-brgl@bgdev.pl>
References: <20240422130036.31856-1-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5945179458833856578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846671

---Test result---

Test Summary:
CheckPatch                    FAIL      0.99 seconds
GitLint                       FAIL      0.48 seconds
SubjectPrefix                 PASS      2.50 seconds
BuildKernel                   PASS      30.21 seconds
CheckAllWarning               PASS      32.96 seconds
CheckSparse                   PASS      38.14 seconds
CheckSmatch                   FAIL      36.37 seconds
BuildKernel32                 PASS      29.14 seconds
TestRunnerSetup               PASS      525.20 seconds
TestRunner_l2cap-tester       PASS      22.51 seconds
TestRunner_iso-tester         PASS      30.96 seconds
TestRunner_bnep-tester        PASS      4.65 seconds
TestRunner_mgmt-tester        FAIL      110.64 seconds
TestRunner_rfcomm-tester      PASS      7.23 seconds
TestRunner_sco-tester         PASS      14.91 seconds
TestRunner_ioctl-tester       PASS      7.72 seconds
TestRunner_mesh-tester        PASS      5.73 seconds
TestRunner_smp-tester         PASS      6.74 seconds
TestRunner_userchan-tester    PASS      4.84 seconds
IncrementalBuild              PASS      28.08 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#107: 
Reported-by: Wren Turkal <wt@penguintechs.org>
Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>

total: 0 errors, 1 warnings, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13638518.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
14: B1 Line exceeds max length (106>80): "Closes: https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/"
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
LL Privacy - Add Device 7 (AL is full)               Failed       0.198 seconds


---
Regards,
Linux Bluetooth


--===============5945179458833856578==--
