Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3E6FB6
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 May 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714901616; cv=none; b=gj6qSxFbEa/IbSDSySZY/00qauHP3oAjobByBaFb+cf3N9J2j/lD5vtRjvL6nO8CYC1e28sN5n+K246HJuFZicZ3Bny8PmjmYoHLBgLN8bR0iwLXsbORUSc+Re5BRMjZFepHivimGSyEeF2YOpBZ8h7UVfjtFP6bfS+5mAi6fI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714901616; c=relaxed/simple;
	bh=iFJB+IoywXBhiFALe5MVltGulL0MnKnZ9sJNPcChWeY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EldWR+2voUgw8pRDlkWYe3vrZM1b4rKlt7s+Ko2ZO0ZQvjiXPd0gnUnrpHxWRV2qRXkwOGIUmTmmlQ3s8h1TpuESpcJqx59oRrzNmPUG5sLTMa7QNFvdAkCqbZUB1UK1P1AwW2dGlsEHtnC6y4NWPLbQOG4qYa5jF4isg9e8JOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMJ4/RtK; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMJ4/RtK"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78f05e56cb3so83820785a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 May 2024 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714901614; x=1715506414; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A/TGlimAJzY0aK9w0NN+hoozRum/OiygJaVZE8dvLH4=;
        b=nMJ4/RtK6IEwOZi4ONAhshwqgZ5HigAiOaS+uGE7Fu5Wzh/CZEkXMWjCJdO/YzePGP
         GRIv+I/pHFKUBBK8v5Sh8jz2Ax6rGuxxn8MPNpipeoNprerxJsxIeUmaufUaxozvHwUj
         qiIJCcObjKn+DHIrgXB5hSWNn4BiSOVLhIhrztRHI6YlmrpkQaOv0I39o/hieMpn8yKR
         zBCddiGHQ9hlBF5rFxlD1xG3u7cT4HKumq37Zx8+GoRNHlXIyUXJJkqHi0xmNPPvf95X
         b4vj+GLw9euUvPqiovLHuQ6KXYvanDVr9yBrMGwnCSIbTAEEAO8oe0ardBdZlACL9EpL
         AeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714901614; x=1715506414;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/TGlimAJzY0aK9w0NN+hoozRum/OiygJaVZE8dvLH4=;
        b=DZrNy1t7fvt6tZLeuLOhgcd/E5R3TrcTT739b7NFOUnfCxgCVun03hdE4loBdl5nM+
         6g8zkB4OEfF1UlxLulrBfuV0A/rCpcp8w1V8/4DCe86fgxyEeHcxG0bwypEVR6DNly4W
         EsoN8h4rBg4jaBrHPrRktNCSx5eTYGU7K8mYZnoR5PUgWjk2vtT2t9hapalIcYm0czQu
         PZseunA6iufOg+fbg6Y/4Gku/IVZN66mTUvSiBHaPY01q9Mm0NzYZaKCW/R90MSZInFA
         zG11ujKGoJUUWxrAWdO44lOxBqNXublBbMoxJGYLr50Ny33asIppuDCqG4fF1niyB9hI
         DlJQ==
X-Gm-Message-State: AOJu0Yy0KWl8vmR3MjCgJa6Nen/68EeFnMrCRcmIre7Ndrhz1+iDmH2Z
	cSqW4MRQ/TRmG+yJBv1DB/T6wbOtKbYgL0H5uE6wLVzIDcz78HoqnjwwAg==
X-Google-Smtp-Source: AGHT+IGnROX40QAqEFNvlrycHFHOzR9T/WZYBQvp1Au9djXkbLXx5rh250qWbnXpNnz5ldbecP+E5g==
X-Received: by 2002:a05:622a:84:b0:43b:86d:744d with SMTP id o4-20020a05622a008400b0043b086d744dmr8990608qtw.9.1714901612585;
        Sun, 05 May 2024 02:33:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.130.200])
        by smtp.gmail.com with ESMTPSA id bp20-20020a05622a1b9400b00434a165d45asm3827847qtb.38.2024.05.05.02.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 02:33:32 -0700 (PDT)
Message-ID: <6637526c.050a0220.13e1d.c41a@mx.google.com>
Date: Sun, 05 May 2024 02:33:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8968310472048159504=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Markus.Elfring@web.de
Subject: RE: Bluetooth: qca: Use common error handling code in two functions
In-Reply-To: <fd9f738e-8e78-4afb-96fd-907f72fb4e13@web.de>
References: <fd9f738e-8e78-4afb-96fd-907f72fb4e13@web.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8968310472048159504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=850522

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.70 seconds
CheckAllWarning               PASS      32.31 seconds
CheckSparse                   PASS      38.38 seconds
CheckSmatch                   FAIL      34.98 seconds
BuildKernel32                 PASS      28.68 seconds
TestRunnerSetup               PASS      518.82 seconds
TestRunner_l2cap-tester       PASS      18.36 seconds
TestRunner_iso-tester         FAIL      35.11 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        PASS      111.01 seconds
TestRunner_rfcomm-tester      PASS      7.26 seconds
TestRunner_sco-tester         PASS      15.13 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        PASS      5.85 seconds
TestRunner_smp-tester         PASS      6.82 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PASS      27.54 seconds

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
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.169 seconds


---
Regards,
Linux Bluetooth


--===============8968310472048159504==--
