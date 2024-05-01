Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7C12BEBE
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714569050; cv=none; b=pii5Up6HBLBm7pD0+1FhUNUMNr8a1cNqN51uTwXYqIhCqjtMNugJH/hbkSDJrwtyvPr6bkH06K1mPSw43vBL/fBojH7nc1YNb+9ib58Y4Ah5WFCACMlfznZvMFJM9ndkSeZf1oX1iz9w0zGzignjoul4tXFUeP5a9BAWGROY9y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714569050; c=relaxed/simple;
	bh=RHNtsfFCxaaNxeWF7tjJn3c2hu9ZQfZnYMqG0oL+Rm8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rmVSFvJ0mCGKOzLmc2gRI/7FnWUAB7tH8x5wzmuThKLAMLntCC1z07Uc8unYotyCMUzKYcbvYc3X1QiJqE4kH+ULgtji2kSZt0ppp1ODFLrOhIsU+/XsCoaxWqXissJXOgIkNQcFp+J+1LBpNu9lHO86j9H3OIP68cbQ3s5+5fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhtaG84N; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhtaG84N"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed627829e6so7990811b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 May 2024 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714569048; x=1715173848; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kp9CS6sTzIT+H+W2evts++tr/KLBHxsXqfVwck9oHKw=;
        b=jhtaG84NhASrkSVcIrEztg7mZINQdxcW5StKlu2cFiT4DFmqLLYrn73lyxh0HIfdQD
         sOiCjy65x5E15SebvQOecULWrP/EBn2wLfzO6oE6FnQN8/CvM9dZlAviRz+N09J+mee4
         GBpZDCEBAZOd3Za4vQmFAt41NmobIjAIFg6llf3oEoyrXRZyGzVes2xpyJ0N9gIm51Xq
         uGFl14cgk/NZvnc+sEPhk/YJvVlXiWu+04cMxujlTXzHuHWsFSEgXuX/+jR7ffiKz9zW
         uKBKJ/TIZ63V2X1ZssBHtWQUvd2vJF/+AxUyY79BZkoE1XDy7MtmA4Y63ckhBRwDnU1u
         fiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714569048; x=1715173848;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kp9CS6sTzIT+H+W2evts++tr/KLBHxsXqfVwck9oHKw=;
        b=YgPR1kwtO4TfH5UaF3miyMxMN26OJev3fPsr3tAul6YmCT1UxDGHZ+RJ76JOST2Vfx
         QTcIwDYxuKKAU1vHer/OfWAPLAhUNBxsaQEexjYfdcUFi9YXYz7eHvbINsEdtv1P1qdj
         VZ+sNqOVFffF/58olctqfQLpSSCa4/pDgpRspWoxjbBJax/TjKPTGpBQugUEk/KVvGFz
         l99mDxq8FDVqTDMe6UQD9T3pHAWX0ZpMuOR0xs+vbsdLUpnlIJc05U1/V1IOnJLMmr8H
         oaa/BiFTixjaAoDFdY3eotbMDWSE7VKJiE2gGnkMkL7VoN2I7ACXDGOfdrBXpf8m6ltX
         JVtg==
X-Gm-Message-State: AOJu0YyiOtSoFfKgy1yciaUCa+eR6a0Owym93vW0MC+A9LP+wand1LSB
	8L1pizAASAaOkmdU74lBl1lTw1GeEGF7HKDJ0kupbVgyNtuv5n02deKjdQ==
X-Google-Smtp-Source: AGHT+IER7JSnmlOEg38bSO8eDDOiDvfr/mq/HQsC51PtfmFFBHoWF61La9OG8jHGGg3q5ecM/SRk+Q==
X-Received: by 2002:a05:6a21:1789:b0:1ad:27ca:6347 with SMTP id nx9-20020a056a21178900b001ad27ca6347mr2651323pzb.43.1714569048347;
        Wed, 01 May 2024 06:10:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.78.147])
        by smtp.gmail.com with ESMTPSA id r89-20020a17090a43e200b002a7e4b99752sm3170355pjg.0.2024.05.01.06.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 06:10:48 -0700 (PDT)
Message-ID: <66323f58.170a0220.e8b7c.92be@mx.google.com>
Date: Wed, 01 May 2024 06:10:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3769756593729623576=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: qca: info leak fixes and cleanups
In-Reply-To: <20240501123456.6712-2-johan+linaro@kernel.org>
References: <20240501123456.6712-2-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3769756593729623576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849631

---Test result---

Test Summary:
CheckPatch                    PASS      2.80 seconds
GitLint                       FAIL      1.45 seconds
SubjectPrefix                 PASS      0.40 seconds
BuildKernel                   PASS      30.14 seconds
CheckAllWarning               PASS      32.95 seconds
CheckSparse                   PASS      43.36 seconds
CheckSmatch                   FAIL      36.62 seconds
BuildKernel32                 PASS      29.42 seconds
TestRunnerSetup               PASS      526.69 seconds
TestRunner_l2cap-tester       PASS      20.37 seconds
TestRunner_iso-tester         FAIL      31.41 seconds
TestRunner_bnep-tester        PASS      4.68 seconds
TestRunner_mgmt-tester        PASS      107.70 seconds
TestRunner_rfcomm-tester      PASS      7.21 seconds
TestRunner_sco-tester         PASS      15.02 seconds
TestRunner_ioctl-tester       PASS      7.77 seconds
TestRunner_mesh-tester        FAIL      6.02 seconds
TestRunner_smp-tester         PASS      8.34 seconds
TestRunner_userchan-tester    PASS      5.18 seconds
IncrementalBuild              PASS      47.33 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/5] Bluetooth: qca: fix info leak when fetching fw build id

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B3 Line contains hard tab characters (\t): "Cc: stable@vger.kernel.org	# 5.12"
[2/5] Bluetooth: qca: fix info leak when fetching board id

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B3 Line contains hard tab characters (\t): "Cc: stable@vger.kernel.org	# 6.7"
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
ISO Connect2 Suspend - Success                       Failed       4.226 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.094 seconds


---
Regards,
Linux Bluetooth


--===============3769756593729623576==--
