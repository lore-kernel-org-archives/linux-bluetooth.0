Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839B13C82F
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 04:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713934566; cv=none; b=mT/2/4ZEaqIs9UviMsIzywZNW8eYexlvMrASu3o0Xlw56M8UGrqz4TV60/etGThvDQkz5VIRahGwq4KHgnusepw0/Bl+y0iaGonzxEPz58DFgXFlwMPinEAwkUS1SeJDnXtMVT8xuE6GBc/VUxJEto3eTmypKTesKhSCijDXOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713934566; c=relaxed/simple;
	bh=X1oEts5Y/Dn1LQAAW42gndRTqHrKAkP0YuawmypiSho=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=d2nZwV5d9nkYH/vH8CN/U//qjZEl33aQgxX21pCpVB9hC454AGYRMGWuZGm7b5Bf1FD3K2U9wObOddhx9OqirM2Qa3wtV/jm4yRM6SlqsSgGFJivNiq/xLEBSIWVS6aQTqkYut0wBN9Fl8sxu+1vlmr48sDAq4eEA8Wc68MtfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw4zxBfH; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw4zxBfH"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-439884be4efso21175171cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 21:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713934564; x=1714539364; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EdJVyq0g0kTtAxKrViFdC1wg4H0DJIsZrLSwcOtvQcc=;
        b=Hw4zxBfH20S2ar+6aaEc/Ev3R8xZ0Roys/yZhtKOCVI034ST5A1jkzuMSkPdWdgM/F
         H36/NPlrkRFCGflZOTOAaJ2dR0ZKvJmEx319Sd/aA+CXi7P3nQdTXIGEgr+O0uwaAivn
         /3chF4QamxH3h6LAKly/yQHvQZoge6KetSooe74hWYbyv0z+Fsu/q3cYmrm6NMT/Y7rd
         AuhDWKo07kzM3kMnsfR8g/4+bzKfPGi0du427HTd+3iFztnXXoPvgtEJnmsz7y7CroMz
         d2guPzWwtWlVL1y6pCrLlN8mG9OVq2YWDXNHsEaySIwJoJMLizomUGf4uB/eqB297V3K
         dKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713934564; x=1714539364;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdJVyq0g0kTtAxKrViFdC1wg4H0DJIsZrLSwcOtvQcc=;
        b=YYMQovW7iKoxPXKJNTKkY1rGF+UCudUE8swbJcVpqS1vX0B98qf1DrFXES5xrpbeg7
         uzC77ypl7YpR2WZqxJAhXYmzBSRrRkk0bCcVnKeQikGiUmysj951tLhsqzX1qEhP5ZQg
         5PTJyR/t6FOcen/qIJzYQQI/3Mq0DCCV3t6l412Elc6R/p8bmE7vOccyqFxOo1qCBKbr
         oi4ZmJY9N1xF2TEixpi3BrF81PZNBFGx0egqcEzwfhNDIOsTLUxgzr7OtSTo4VtHTMiO
         QSTsHQMvFKQBOH6fRLJiGVK6kGezHVQ7v8AEON+SioxZctPYhU24wxHPjyBn5JxQd53m
         QnXw==
X-Gm-Message-State: AOJu0Yx7JgkQiHwRfP2xooXs3IpSe81gsT+86Qgc8vikCCbcMEMAeiWB
	+M4SGiEfcTKoQ8fun8h+Trq9CbJ7mZeHqMkW5SDAoaHLRPH2yg90Jzxeiw==
X-Google-Smtp-Source: AGHT+IFxlZ4SHksMOgUg0alUSRj4IRUniGrIgbKX4Qwkrwuy9ijM6Og+B/k3blnP7NeoL1sBUq2sww==
X-Received: by 2002:ac8:5802:0:b0:439:85b8:f71d with SMTP id g2-20020ac85802000000b0043985b8f71dmr1544691qtg.58.1713934563952;
        Tue, 23 Apr 2024 21:56:03 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.196.148])
        by smtp.gmail.com with ESMTPSA id z7-20020ac875c7000000b004367bb1a200sm5777711qtq.70.2024.04.23.21.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 21:56:03 -0700 (PDT)
Message-ID: <662890e3.c80a0220.85326.a8ee@mx.google.com>
Date: Tue, 23 Apr 2024 21:56:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6257798231400288114=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Fix two BT regression issues for QCA6390
In-Reply-To: <1713932807-19619-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1713932807-19619-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6257798231400288114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=847290

---Test result---

Test Summary:
CheckPatch                    FAIL      1.59 seconds
GitLint                       FAIL      0.79 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      30.46 seconds
CheckAllWarning               PASS      32.43 seconds
CheckSparse                   PASS      38.38 seconds
CheckSmatch                   FAIL      34.52 seconds
BuildKernel32                 PASS      28.60 seconds
TestRunnerSetup               PASS      514.95 seconds
TestRunner_l2cap-tester       PASS      18.26 seconds
TestRunner_iso-tester         PASS      28.93 seconds
TestRunner_bnep-tester        PASS      4.66 seconds
TestRunner_mgmt-tester        PASS      124.62 seconds
TestRunner_rfcomm-tester      PASS      7.11 seconds
TestRunner_sco-tester         PASS      10.80 seconds
TestRunner_ioctl-tester       PASS      7.55 seconds
TestRunner_mesh-tester        PASS      5.70 seconds
TestRunner_smp-tester         PASS      6.72 seconds
TestRunner_userchan-tester    PASS      4.82 seconds
IncrementalBuild              PASS      33.01 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v7,1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#121: 
Reported-by: Wren Turkal <wt@penguintechs.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13641176.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v7,1/2] Bluetooth: qca: Fix BT enable failure for QCA6390

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
16: B3 Line contains hard tab characters (\t): "  	dev_warn(&serdev->dev, "failed to acquire enable gpio\n");"
17: B3 Line contains hard tab characters (\t): "	power_ctrl_enabled = false;"
25: B1 Line exceeds max length (139>80): "Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f"
32: B2 Line has trailing whitespace: "V1 -> V3: Don't revert the whole wrong commit but focus on impacted device "
[v7,2/2] Bluetooth: qca: Fix BT enable failure for QCA6390 after disable then warm reboot

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (89>80): "[v7,2/2] Bluetooth: qca: Fix BT enable failure for QCA6390 after disable then warm reboot"
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


---
Regards,
Linux Bluetooth


--===============6257798231400288114==--
