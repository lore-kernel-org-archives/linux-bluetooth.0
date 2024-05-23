Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED646AF
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458177; cv=none; b=bZZAyohnZVGIicWbZAlqlAMVPpfd5TwlZ6lusAZLlTmD1sEsXjjys/MPzUgbfADdGK3RawgbKb+mznLH2CZGJp0+aiI0Ymv3XzlPrzympjOKGrfjeQeDsZiNc2N7l88miQcgZIV/JLaXJ4kZ6aJTeah0EHnXhIbB46lP3q65Q3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458177; c=relaxed/simple;
	bh=sJUzu7fnVWkXhY+LWRBA0fmf4kI07m1H+vWpdtZQAPA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XDB4lrLoNod9Oh8VYohU8aMeY9mYVvR1M0uZHYDPU0TKMCwyhFkg+WFY8yK72Ddq68Z3gPRNPGMj0dvesQVwexbG5PC6EHvx+FQe4peWnd1k9zENnwOKFhcyJjGD40htxTc9h3pau6Zz1EoAgTPWtuo+vQVKiSjNXSLHlDZX8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZeKpNIV; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZeKpNIV"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43e1e98aaf0so11923131cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716458175; x=1717062975; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YBdyG8Ai396+4/E5MAJNhf1rtn7ALm6P+RycpIsKRKg=;
        b=LZeKpNIVf4d8q1ucJV3s4K7XCjSU3zzF/zFpZsNIX6GZZa82yL1OM+9jgl/GC04qEy
         QWNuUiel3jbXhhypPj5pvnys3FibIS4jEqhUDxmclU4ZSm/tZiW0iNthUWwE1NIY4FCV
         KlzFN3gGjZvMyVJR5Yhug5zKmQfpDYvU7/zdZrUtbBPFrRNc+UHn2wqNY6F8jLgJ7hvW
         wbMWWGlRJ4QsFllzPa1irr858mNQO2mPW1YKg0wXsBGzQXOccJ9+0lZ4XlmtQmn6Kd31
         cJPtDbg35OryECBP58kU+51lQIVGCFJUCyOpdQAlTApqUwuTUZ+aEEe9+JnZNaFvxcre
         WwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716458175; x=1717062975;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBdyG8Ai396+4/E5MAJNhf1rtn7ALm6P+RycpIsKRKg=;
        b=YY+H2C5VbL5bUcJ08BxoJy2LP3rIJPk3W4Le5vE+r/8+P9Zrgiy2x5KZ885zsgnl9c
         d8/pG/cfMRW3+OHMs3pnF2z6bmL7VeWig/NmXPXT7XTx+7YsBsk1OR0thFrkXkn48Ow8
         SVjw5/dpM4dUqRAFNLhc6aU2w9+Y2PE180oyOdpps+g+cUXKRMAwruiyhOO72KODINc0
         xeEdzz7Axd1k39HQsOzW9LNRETKNnXoC9CEp7xv42FPwOaaKk+Bv91buOXFHinGY3k5a
         X7Tev1u7f3UQbOG9Vl88ChDNPXQ7ruodzfaRGHUzoDhnnKrqA8UvKpxTVp25VI/fy+GH
         VhdQ==
X-Gm-Message-State: AOJu0Yykc9Pe+kyBahPRrZFXFqNKOYRP+nI0pS1AG6lwTVUrtMqgQVx3
	3oRaDhZllMl8K8UgivbriEC+1IkMVLymfwuSZj8fwiTuVXn6LXlgJUI1Aw==
X-Google-Smtp-Source: AGHT+IHKMfynIKiU9yecPzVvCtgaMEjFHGCZuOtBMY3cRK55U9ChtHyjWSmGK0qF6xqi0MmqcX1kJg==
X-Received: by 2002:a05:622a:560e:b0:43f:a025:d278 with SMTP id d75a77b69052e-43fa025d3b9mr32437211cf.3.1716458174828;
        Thu, 23 May 2024 02:56:14 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.112.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e137a737asm145511131cf.4.2024.05.23.02.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:56:14 -0700 (PDT)
Message-ID: <664f12be.050a0220.b6cbd.0558@mx.google.com>
Date: Thu, 23 May 2024 02:56:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6149310406169246711=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiangyunshui@kylinos.cn
Subject: RE: Bluetooth: 6lowpan: use DEV_STAT_INC() to avoid races
In-Reply-To: <20240523091850.1117138-1-jiangyunshui@kylinos.cn>
References: <20240523091850.1117138-1-jiangyunshui@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6149310406169246711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=855260

---Test result---

Test Summary:
CheckPatch                    FAIL      0.93 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.29 seconds
CheckAllWarning               PASS      33.02 seconds
CheckSparse                   PASS      38.08 seconds
CheckSmatch                   FAIL      36.41 seconds
BuildKernel32                 PASS      28.85 seconds
TestRunnerSetup               PASS      526.91 seconds
TestRunner_l2cap-tester       PASS      20.60 seconds
TestRunner_iso-tester         FAIL      34.63 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        PASS      111.28 seconds
TestRunner_rfcomm-tester      PASS      7.45 seconds
TestRunner_sco-tester         PASS      15.46 seconds
TestRunner_ioctl-tester       PASS      7.85 seconds
TestRunner_mesh-tester        PASS      5.90 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      5.10 seconds
IncrementalBuild              PASS      27.95 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: 6lowpan: use DEV_STAT_INC() to avoid races
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#80: 
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: yunshui <jiangyunshui@kylinos.cn>

total: 0 errors, 1 warnings, 0 checks, 45 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13671513.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.164 seconds


---
Regards,
Linux Bluetooth


--===============6149310406169246711==--
