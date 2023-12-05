Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCP9WtD1"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADCE183
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 06:32:34 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77dc404d926so359370085a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Dec 2023 06:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701786753; x=1702391553; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UKNQEpFGJMblY+Kbw5RMb/FX7bhqIAX8rrtUTGkhoBo=;
        b=fCP9WtD1TUkMVOp5+pA6rnsOPFDx8s3/c3Rhov+ugoDKfknaBbHUr+8DDfHy2L1b/H
         5JgKCP3ZDHr+l+EFCuIlgCCsEg/RAoGl01FndKIZkcamYDxnxCk1zSh0Mt3O2cHVA81t
         89sihpMoThbGWGLJLpoYqivpt/xSTqO0aZRCFRA7a4TumbrD65bWYqAAtUy5EQJeVv9R
         +u/nSGZkFyKomDSkMzo4BkSKfuhnYs8Q7Yh8NpAnL7XuyHd91nfVYcoBsi2v0W69UMkE
         uEv9WH0Qk+cnqbF9AEONXGtgI78P1uhe3FwfDDjejKPzx7FK8KoF40qEVREuH9l/rpoD
         qQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701786753; x=1702391553;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKNQEpFGJMblY+Kbw5RMb/FX7bhqIAX8rrtUTGkhoBo=;
        b=FQFjP+ERIrvhCRRGMcuxHn9ixjiN/dhtcCwRqP9BYeNOna3QxbLPwVWcSdYg6753wT
         ayuh4N1Yk/qxFoVucfRrGsU9a8ywkfbvbnDk1cYEuo6hri/GnMm8apSjUggjemO+6L6l
         JEQkJ0/xMr1P3wlkE9XtlSYz+MvD45s9cQQmHnXuiKeHvB1hVydW0XftRvjrYQxrQnjy
         vOf9sdY4fG+UePJR1m57hbJfz8Txz3HH4GEda7MKbuU4yN59tU9Q2Owf2QFb7Jqaq4zV
         zxboz2LIV8MPamB/kKQsAmZ7fMHyvyW1GgyVj4l5vxOWJNzQ+9QJ9RhcddDb1mSV9u9S
         XD4g==
X-Gm-Message-State: AOJu0Yy5h/gWaKtGoBOS8HTzDvq2NfdkykxI+VaHX0sra0fsfKW0X6nf
	BGNkMWyKzQ6YflaADed4QEuC+PJP2TwtaA==
X-Google-Smtp-Source: AGHT+IFxhwvdsG/UMG+GsMIT7mUjbYQBfqGKwuDG0BxoHNlIq4OztpZAU4rwX+stmsDBJogKz/3eDg==
X-Received: by 2002:ae9:e70f:0:b0:77e:ffb0:32e4 with SMTP id m15-20020ae9e70f000000b0077effb032e4mr1343546qka.103.1701786753308;
        Tue, 05 Dec 2023 06:32:33 -0800 (PST)
Received: from [172.17.0.2] ([40.79.247.226])
        by smtp.gmail.com with ESMTPSA id bq31-20020a05620a469f00b0077d65ef6ca9sm5052833qkb.136.2023.12.05.06.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:32:33 -0800 (PST)
Message-ID: <656f3481.050a0220.b65ef.3cfa@mx.google.com>
Date: Tue, 05 Dec 2023 06:32:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1111788043246125090=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jagan@edgeble.ai
Subject: RE: bluetooth: Add device 13d3:3572 IMC Networks Bluetooth Radio
In-Reply-To: <20231205133348.350364-1-jagan@edgeble.ai>
References: <20231205133348.350364-1-jagan@edgeble.ai>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1111788043246125090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=807038

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 FAIL      0.98 seconds
BuildKernel                   PASS      28.82 seconds
CheckAllWarning               PASS      31.66 seconds
CheckSparse                   PASS      37.01 seconds
CheckSmatch                   PASS      102.78 seconds
BuildKernel32                 PASS      27.95 seconds
TestRunnerSetup               PASS      434.93 seconds
TestRunner_l2cap-tester       PASS      23.57 seconds
TestRunner_iso-tester         PASS      45.33 seconds
TestRunner_bnep-tester        PASS      7.15 seconds
TestRunner_mgmt-tester        PASS      164.85 seconds
TestRunner_rfcomm-tester      PASS      11.29 seconds
TestRunner_sco-tester         PASS      14.86 seconds
TestRunner_ioctl-tester       PASS      12.52 seconds
TestRunner_mesh-tester        PASS      9.05 seconds
TestRunner_smp-tester         PASS      10.04 seconds
TestRunner_userchan-tester    PASS      7.59 seconds
IncrementalBuild              PASS      26.75 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============1111788043246125090==--
