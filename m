Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514E3C0D
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716516960; cv=none; b=bkgpyT/2fkKoWYI9Q6UvvZrGTDnNINBWMsGFeUrkTe4EXNOBmEvwIC9IfCrPczL9sj77m82BuvUakn+CsZr+ospvo3k8m0l8olIWKKf37szSnCabWWrqugQb9XAgi9bjV8Y3YO/+iMiK0Rfle4xNmPce/KCX+rwgntIm57PUzAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716516960; c=relaxed/simple;
	bh=S/RcbreUoQO5a179Cw3/qxPk/4eBlKkABm8AkmySL/o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=A0HCnp80+RgZyJEG7oi9fStF78vXYyNXsm24STGwlDkTStDtQCsNTgOskEKAM3n9KzMnsnVyj95E2Sga7cgiXcZHn2eUN6xIFIEwAmg2WGLcC7McwdSl+GsfZNzwp0yF0KJoFO8x7C/V0xboMGZR0630fdEvShhthwoayIhJoYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MT+hmqH8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT+hmqH8"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2bf5797973fso495381a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 19:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716516959; x=1717121759; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N8nmF6kVgjnfvHdLMbTHpk7bjwqGxG5ozuflE3tEYEU=;
        b=MT+hmqH8pOMbau0XD2hmrzj9kjjmrU46/vc6BGZxlnz56qUhRROacUdsAGGmLWkE4H
         ySNRseBlosw1NwYN9XeS5f3Qnq9EbKX/BtDv0aEEyTb/9LjdGUQnrSmNzXdmh4Jc/q97
         LGHR6+8+hoXyuKnUlvwdpd2rHPJbjSWbBD2p0euAF77hAXuRerbKs8MdZUX+34mB/S2q
         kgf2WZPpBFL5hmgE/li+HrXaGIYZGSiSydq4d8taTiGgqkIcFoCSsuijnYdpExghufpU
         u+mKAxchiU971DCQ47dlN0Ta/dIttiTbkXbYef8aFiJaUS657QoEdqiAO9uS4dE1nfWj
         MP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716516959; x=1717121759;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8nmF6kVgjnfvHdLMbTHpk7bjwqGxG5ozuflE3tEYEU=;
        b=BhEM0eE8gE4JISlCvfwAjKRhwAaZk03V3aZGUlNK8WOhjl297GnZDbfXOUIcoqzGIZ
         m9EfSRpXgFLJNdQ+CLbHS+4BjIUa3ESi1aip3yKyRFXq9mDK4LeZncXSyU0nuP5k4dE4
         56nS3aN/89+klr6H6rguYECDKKt9in1PEl/BHSyPbcGOlelPcXujcZn8A+dXJaxq74BC
         toonH/cBjjWyHB3Gn8zDbF0WkItzXn+nbpPtbnIuwpJGEU/aEFkjcJktuGo9NB5Q9Lz/
         VxDzXIwRDJxMgyVD8yPFLp7zFJYyXrfvzcGEDr2ag/aPNhSBvybuWc8+++9i5DSKgL+y
         zTWQ==
X-Gm-Message-State: AOJu0YxsKfzlEjPgxvwJoq9PW6PXLT01EaLgMewzwW5460zvSgpFUGwd
	L5FM/UNEIGxIMtgclpC7JaK5a6bwOflo8NQdxjGsh8NpGKgnenwt9v7bOQ==
X-Google-Smtp-Source: AGHT+IEejEBQWehlyuXhUKzsJCYJ2PcgLHXeG/ZMwsYp37DzQDvz+mScIHXXFAOO7zPXG/dmY36yjw==
X-Received: by 2002:a17:90b:194c:b0:2bd:f755:bf38 with SMTP id 98e67ed59e1d1-2bf5ee145b0mr1079501a91.16.1716516958516;
        Thu, 23 May 2024 19:15:58 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.38.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f989871sm317797a91.40.2024.05.23.19.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 19:15:58 -0700 (PDT)
Message-ID: <664ff85e.170a0220.ac602.16fa@mx.google.com>
Date: Thu, 23 May 2024 19:15:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1002305679778235156=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Nobuaki.Tsunashima@infineon.com
Subject: RE: [v4] Bluetooth: btbcm: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373
In-Reply-To: <20240524013127.434500-1-nobuaki.tsunashima@infineon.com>
References: <20240524013127.434500-1-nobuaki.tsunashima@infineon.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1002305679778235156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=855541

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       FAIL      0.45 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      30.18 seconds
CheckAllWarning               PASS      32.50 seconds
CheckSparse                   PASS      38.18 seconds
CheckSmatch                   FAIL      35.54 seconds
BuildKernel32                 PASS      29.01 seconds
TestRunnerSetup               PASS      517.53 seconds
TestRunner_l2cap-tester       PASS      20.46 seconds
TestRunner_iso-tester         PASS      28.92 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        PASS      109.37 seconds
TestRunner_rfcomm-tester      PASS      7.40 seconds
TestRunner_sco-tester         PASS      14.96 seconds
TestRunner_ioctl-tester       PASS      7.81 seconds
TestRunner_mesh-tester        PASS      5.87 seconds
TestRunner_smp-tester         PASS      6.87 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PASS      27.34 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: btbcm: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
23: B1 Line exceeds max length (82>80): "V2 -> V3: Fix a few coding style warnings and change the subject as more specific."
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


--===============1002305679778235156==--
