Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6150152517
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800031; cv=none; b=FT8DR3QJonL7D2ShcEH1WQGUNHnXNq/2qYwTEKUcGwK+SfOQ4NETHsy9gJXngg0XFeyeII0Emxuv1/U8xj1Xn01OkY8YYdwaG23/xmg7eh8iPTmUiJihDP23qnL813Lu13v1EgEVpFiKBbFvHs2nWEwnZebpJg4mW7yzSC0v08s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800031; c=relaxed/simple;
	bh=f+Y9Wi2XTqK6Hfz0kk36bTqr0N5lGDBkcbzrOSKgJdU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OAUZ2a2MLc9TrjuZ8JQU1Fq4G3fYk3ZbEyL8GsZgZt3QLn+IPal8iLBX3XFJbvQCmj6k1wXNTXA3g05wpoAh5V9PRyT/I0KJiaSXresgDriLbgzVS5YK20r/s8Wtz8vXnRihOI4dO3911NYy1vOjopyZidLcLzIKNsUBfi4wUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTRHOJ6f; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTRHOJ6f"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78f0628da1eso287023785a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 08:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713800029; x=1714404829; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y2q4pluLOIAZIkSnwbEzNN9iV0wfgBJ6Hqkjc16/TL8=;
        b=hTRHOJ6fW2d/Y0CWQv4DHnTOsKjZxoDTXRytog0LA4qBoOIMxgsWT57cK6V5WT2dvs
         yrcjmCSO7fT4l9UE7yI3IRb0kvzL/Wlf9dZCfaW1vIMXc4w5x2FKIbDQ9rDVRC6QG1Ub
         smOoiwo+NPP36yVnb/o717hWM+hURa/0cLMZ7oSTqZ1VGukNpZLVWXnfZQNqeq1oqreL
         VNuLkNrTv6s+15Zz6hVMQj7/qN4jywH6kJ6I5rhoGJ5oatuoDXdI9poEQRX2a8tKR6se
         D4pH2xRL10d4mHaLfgvHf7dcEb2WDA30pFoorMCBmGAoG/LggWMQXIkAwa1v2B0BoGyB
         MVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800029; x=1714404829;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2q4pluLOIAZIkSnwbEzNN9iV0wfgBJ6Hqkjc16/TL8=;
        b=T62vOBqyK2y7fYEFygZ8dvu3R3WfcEYUzJmulc2X8cdx5Jm4gp6ZKQfmesv6h/nFmW
         6KEv/kOLC4gaqkPIQHRm5PYh4ktQ0JEVmnJj9LAQuhnAfJ1ervbYJdEbYTBCt+kW+LY4
         gjEDJAbBFT4SWi54V/9OuCZpgmOi2ef+sVl2rThU20TTIaLDQ2l5YcJ6/WfHeje1QQhU
         gS2+hLu030BtOc1TH9bsw05irk7cci6nBddYlyV2NL0rMw3QvVcUz/bYgjaJb50IXHm7
         pRt5v0OGuztvJTdC32YcjSpNejyke6PN/hmguh4xJ/3s8kLFu/sG4BtxAau40bm5+Syg
         4oDA==
X-Gm-Message-State: AOJu0YzhG5xBpTLRq54VSE7cWi8HawbXIEFNRy0U7uf8q8AiZGKfflLg
	FQ/2/bwsVqUYU+aVYuNogMIliOPETfSOFC/999CcPVVQJO9Q2YuvQbnaIg==
X-Google-Smtp-Source: AGHT+IFCGgIZrBGvEB2n0Dd5+I2SzLURHnK2k9xDtacAfia9nrf7krqPTRUpIFHLSR9kijW00E65cg==
X-Received: by 2002:a0c:8bd9:0:b0:69b:2066:fc58 with SMTP id a25-20020a0c8bd9000000b0069b2066fc58mr11241930qvc.57.1713800028637;
        Mon, 22 Apr 2024 08:33:48 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.254.128])
        by smtp.gmail.com with ESMTPSA id m14-20020a0c9d0e000000b0069b748abd98sm4396069qvf.89.2024.04.22.08.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:33:48 -0700 (PDT)
Message-ID: <6626835c.0c0a0220.5f553.2453@mx.google.com>
Date: Mon, 22 Apr 2024 08:33:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4475545073089730408=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1,RESEND] Bluetooth: btusb: Correct timeout macro argument used to receive control message
In-Reply-To: <1713797830-24600-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713797830-24600-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4475545073089730408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846709

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       FAIL      0.52 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.30 seconds
CheckAllWarning               PASS      33.23 seconds
CheckSparse                   PASS      38.88 seconds
CheckSmatch                   FAIL      36.36 seconds
BuildKernel32                 PASS      29.20 seconds
TestRunnerSetup               PASS      523.77 seconds
TestRunner_l2cap-tester       PASS      18.39 seconds
TestRunner_iso-tester         FAIL      35.39 seconds
TestRunner_bnep-tester        PASS      4.70 seconds
TestRunner_mgmt-tester        PASS      112.38 seconds
TestRunner_rfcomm-tester      PASS      7.28 seconds
TestRunner_sco-tester         PASS      15.10 seconds
TestRunner_ioctl-tester       PASS      7.66 seconds
TestRunner_mesh-tester        PASS      5.81 seconds
TestRunner_smp-tester         PASS      6.82 seconds
TestRunner_userchan-tester    PASS      4.94 seconds
IncrementalBuild              PASS      28.28 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,RESEND] Bluetooth: btusb: Correct timeout macro argument used to receive control message

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (92>80): "[v1,RESEND] Bluetooth: btusb: Correct timeout macro argument used to receive control message"
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
ISO Connect2 Suspend - Success                       Failed       8.199 seconds


---
Regards,
Linux Bluetooth


--===============4475545073089730408==--
