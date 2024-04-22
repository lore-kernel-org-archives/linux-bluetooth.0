Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009C8446D1
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774982; cv=none; b=HOgTbqw2KMuUS2MBHgtBONWlvftj2/2LRwHGaYkvKKT6DViBMjgbbxhS0sb/unBmcNOmYNCIIDscCVZvVSVj2rI20lRavrTHAX+URW4VySzbKbMKjnr9mQcw9wR/CxJIBtipbeDZK/fFyE0d9sWWsEXCsge6bXCkbZJxjnVUCPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774982; c=relaxed/simple;
	bh=xxRzVEFBGLJ4QZmOXefes2YRTJ6hb+wvBm5O027jMDs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IUpUnmaX6BeyHM31N12R2HMrSq37vjZXqDjr9TQF/I/pIciL8v3agoCUFHUx4tk48YHvp+oWDf8R2L/WzglkS1aUEJdUOeYKsnrUnrsqibxexAku1J1deaZAJQkvZZC3KGJAPGQQ4mRvBGKEBG0wzvnviKVZpw0qKHl9TJJ+Gww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1ab3oAP; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1ab3oAP"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78edc3e7cd9so278811785a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713774980; x=1714379780; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M5Nixbz7b67O90VFZCywd6PwlMRhcf5WbJ/3H+7w4R0=;
        b=g1ab3oAPzKd4rhmfEeQM4WECRVYhHvcgvP+db50OIESfF8HH5Jkk5YEaf1haWQAmPZ
         s0U152meDH3MsH/3kUxN2e2e/fCA7MBLQSgGfhUImUd7RvT4+xVviFhUFdZue+FQKZTo
         gGtQ7Jk5z6InlgIzCssmzjIEXsQnH0hEbJSSpfWud/PvB1TiT0eny3W1n4NRi+E+i+yd
         vcPB+x9bZES4hqHWpLFLvk2qQoucwTysUapAM0eDyHEgGMyRNuwoZXt+32m/1qkX/yK0
         akjtWkLqJKc0wDBTTz+cGYxKA2MMjaZk9x1zCeDkWyW2MnNGr1821g3kUUWatN9aWdx+
         sqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713774980; x=1714379780;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5Nixbz7b67O90VFZCywd6PwlMRhcf5WbJ/3H+7w4R0=;
        b=M+TkYaK0dveahJxuEeg01dYEC+ft1FyR6T2cR263wHpvYGgDRc/3TInj3ci7TOKkNx
         BaSqkaKKLf4MmhkgA53JKwgScuprcdcQpX2XVeqGnhVmkeUsdf7+TLWyywQHUHR1mxkQ
         49No990iIOX1jR++rSgcE2YzwOIaTtLjnnhJTlUvaf/SBAqCVSLbb4TVNKFqIts3MKCK
         RwTs/9KfBdySIpcsNKe5iKiAchbjm21EDpoRrp5m7tocuUiwv+2tyXLmmOoO4MEbkvF3
         ZO5tIB+EbL0437nYBCWlRcuTL5fUnr0+Si+x3OSriNlrIRKB86XQI9gzRis+ZhNVJEAo
         F2ww==
X-Gm-Message-State: AOJu0YyKxucLVddbJCy8bKGXVkTQ5werPJwR0uqO7S+QpAajRdwyAIu6
	ln101jbORppKjJsap4H6nMWZWmRnKkEcydkLlrfnBVUooQMViTYbr9SSCw==
X-Google-Smtp-Source: AGHT+IF4WLp8YJAkTQP2fV7BE4kARY0iOFLDcajEyMY8BKw0cHTUhlUMf/BARicbqDwR2LCjjemhGg==
X-Received: by 2002:ae9:f014:0:b0:78d:68fa:6e41 with SMTP id l20-20020ae9f014000000b0078d68fa6e41mr10040640qkg.64.1713774979679;
        Mon, 22 Apr 2024 01:36:19 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.5.180])
        by smtp.gmail.com with ESMTPSA id c13-20020ae9e20d000000b0078efd245e09sm4096515qkc.79.2024.04.22.01.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:36:19 -0700 (PDT)
Message-ID: <66262183.e90a0220.6e36a.0e88@mx.google.com>
Date: Mon, 22 Apr 2024 01:36:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3008430838979440101=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Fix two regression issues for QCA controllers
In-Reply-To: <1713771497-5733-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1713771497-5733-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3008430838979440101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846527

---Test result---

Test Summary:
CheckPatch                    FAIL      1.59 seconds
GitLint                       FAIL      0.90 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      30.10 seconds
CheckAllWarning               PASS      32.58 seconds
CheckSparse                   PASS      38.41 seconds
CheckSmatch                   FAIL      36.09 seconds
BuildKernel32                 PASS      28.87 seconds
TestRunnerSetup               PASS      518.43 seconds
TestRunner_l2cap-tester       PASS      20.48 seconds
TestRunner_iso-tester         PASS      28.64 seconds
TestRunner_bnep-tester        PASS      4.71 seconds
TestRunner_mgmt-tester        PASS      109.59 seconds
TestRunner_rfcomm-tester      PASS      7.29 seconds
TestRunner_sco-tester         PASS      14.97 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        PASS      5.72 seconds
TestRunner_smp-tester         PASS      6.72 seconds
TestRunner_userchan-tester    PASS      4.85 seconds
IncrementalBuild              PASS      33.12 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v5,1/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#119: 
Reported-by: Wren Turkal <wt@penguintechs.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13637840.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5,1/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
16: B3 Line contains hard tab characters (\t): "  	dev_warn(&serdev->dev, "failed to acquire enable gpio\n");"
17: B3 Line contains hard tab characters (\t): "	power_ctrl_enabled = false;"
24: B1 Line exceeds max length (139>80): "Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f"
[v5,2/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable then warm reboot

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (93>80): "[v5,2/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable then warm reboot"
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


---
Regards,
Linux Bluetooth


--===============3008430838979440101==--
