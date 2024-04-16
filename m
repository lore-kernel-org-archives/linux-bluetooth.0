Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09D213A885
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299539; cv=none; b=FVGdVhzBzymMIOS3P4LIW0/5ciLN17nuU2TtR9RBlKK8+RIgwkHOptBgynR34MCaYF1/D3vbeEvu0DizpX41SUS3joC3pdGINmN+F2zORFodl4BOwYIPtlZzlZhQsvNJb3ZO7gfTjwCHU54H+zVPxUzkFYvZXMH5vkxYIG9REwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299539; c=relaxed/simple;
	bh=YXMfhyU3vqSY+22elUH27TZtYDArtsvcgPm1/EAukGo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VB6NYxV35Q3BnevxRJRGV47BvbBRSpm0eDv3Xgvuii9be6JS2OgOfBbeZ+JcYLIvw2mrS/XfkRfOKv0doMO+SdDrpZ05xYpcLiiSR4/HeKPcmA6TLtRAhVDFJFRlE5chMwHQ8Jp0HJ7699297w6Kcpvlh4xu5Se1NSSE84kpugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUKZ1ept; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUKZ1ept"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78d620408f8so372821185a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 13:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713299537; x=1713904337; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AKNUX/6zbpkhC2B4qItn4x+a/5eSN3axRebgpYA+Nhk=;
        b=TUKZ1eptB2thm74nkuoOVlht3fopoELUahlvmjtZ0vNfuZ1RHUWPNOdy/ILt+ugWtb
         64s12R5yjVG9iJ47iRVGZTVHB2zALFB52VIYlTtGw7CRCDqXDccPjWjCfHpJlzikyj5C
         1bhE+Cdq+UOxyPC2Cwpar6uKZiwIw7TR3r58a3tY5Dru6GefyY6kOZDA2yZKtw2QDiS0
         lbASoJkzob6hNQcP5zPGTdSUDuA43MxXiF+7MQDzJyvnQX8y3JEIXL8lFN54WAKNE0DJ
         MRN8/3YqcTh+d52VckTxwzLL2kwfzW53sbWqbM9mxQf/PRIS0C1PMYOc3IvmgY735yC9
         +5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713299537; x=1713904337;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKNUX/6zbpkhC2B4qItn4x+a/5eSN3axRebgpYA+Nhk=;
        b=GMHaLQG+2V5OHzM2MUmFGuBcJ0j3VyuULFIf2rKn46GVX1oDHcCI16uBONi72IzQow
         9Du9IJAfBKIKlIX/E+qWDadaois64/vnpElDlquqn39N3ifGGDVVQCoGbgWZNogDyT9U
         YyOJLxeprODhXxbRXdPNoEUgGMOWDzowXULTOjf+1KCcnxr+5plxCkQMNzl1TDn0VKgo
         HeMUktUx5pp9MlbGBVxGb1RqLMZvfetHFQ1hYmFHHO7623Q2M2dOwm3MZI71f0FF31aE
         V2QKnltrlHZ6+7xmsfxFFVtBMnl0l4iKeDBIxUbxYlPq3FZhMIKroNRN8fW04dACQCme
         izYw==
X-Gm-Message-State: AOJu0YxezMV3OJoYyZhn+1kWc5HHcsc2V0uXfNb+UxQIfQbkGu49cF7D
	NxrJb9oCaJjKE+FwQA/UMDK1a74monQPVaA4KGPQCsKqyY5Rnmyzodb0sw==
X-Google-Smtp-Source: AGHT+IHeUzpZnKGlAvNu6U7EiP4fnyt5VjXThKO2sfNGKXbauGd/jjJwSgYsJ/jOtcKysahpwykVdw==
X-Received: by 2002:a05:620a:953:b0:78b:bb19:b77b with SMTP id w19-20020a05620a095300b0078bbb19b77bmr14223384qkw.78.1713299536492;
        Tue, 16 Apr 2024 13:32:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.191.55])
        by smtp.gmail.com with ESMTPSA id s26-20020ae9f71a000000b0078d3b54eb76sm7810127qkg.78.2024.04.16.13.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 13:32:16 -0700 (PDT)
Message-ID: <661ee050.e90a0220.2c080.509d@mx.google.com>
Date: Tue, 16 Apr 2024 13:32:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1425523785206839261=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: MGMT: Fix failing to MGMT_OP_ADD_UUID/MGMT_OP_REMOVE_UUID
In-Reply-To: <20240416195407.1153243-1-luiz.dentz@gmail.com>
References: <20240416195407.1153243-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1425523785206839261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845185

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.92 seconds
CheckAllWarning               PASS      32.38 seconds
CheckSparse                   PASS      41.10 seconds
CheckSmatch                   FAIL      35.89 seconds
BuildKernel32                 PASS      28.92 seconds
TestRunnerSetup               PASS      515.09 seconds
TestRunner_l2cap-tester       PASS      18.36 seconds
TestRunner_iso-tester         FAIL      36.70 seconds
TestRunner_bnep-tester        PASS      4.71 seconds
TestRunner_mgmt-tester        FAIL      114.78 seconds
TestRunner_rfcomm-tester      PASS      7.54 seconds
TestRunner_sco-tester         PASS      12.88 seconds
TestRunner_ioctl-tester       PASS      7.56 seconds
TestRunner_mesh-tester        PASS      6.17 seconds
TestRunner_smp-tester         PASS      6.64 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PASS      28.06 seconds

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
ISO Connect2 Suspend - Success                       Failed      10.260 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    1.838 seconds


---
Regards,
Linux Bluetooth


--===============1425523785206839261==--
