Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7621640B
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818182; cv=none; b=auE3PyJxtvZB2ftcOyRHCzxGPISlsuPM2WuVIXGuN1LUKevajm8PGrqws54/w3fiwhMUVXHW6fvad6xtYRvBlZlMBO1uCWgjTnmeGGZh9/krV1oYFEbGP8AVdgel63SJ2zTCxeCadjH5+zPPWF4cUDDg8UVOoaGVql+rfV9AaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818182; c=relaxed/simple;
	bh=NNQ/EBPGM9ZqlLBOXhDr2E7wKj+yGxNttKWKEoE3Yc0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YZAMXsYNQcmDvQbWwW6k0mb/mBHdCuJYdci6XPQMQpCB1w6tsESCMs4lKGcQIqfnmFeYK2tB+za7xKSdqC9Flv/Wv9ZxystTu7Q2/fb1uIrovF/8W4PZtzJoQITPm0jXhhYXZuJQ31MykmyhwfWmTuZiI8IHDOhIuQAdZaSxqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7S1PgwQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7S1PgwQ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6fbbd937719so1905951b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 06:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716818180; x=1717422980; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qEPtuia/R2nnwPQ342ApH51M2D2tfllXiPxSAFnsUpY=;
        b=E7S1PgwQBkeryXEfh3muBVdda+mW9AOf3RxSllGno+tXVVEIppirsvtQJCmsSIiRYV
         QR+NN+y38vGNEGeD7yxDnc5XlpwXxRl1y+xzLU9mXgNJsj1lEHRoVdSMEYpbvnuTgLyD
         iwfsZ4b4bNWAgZbQxQyLJtXsv1evcw/W/8aJN/ebive7L3Ho8oqGbzIv+yYf6htLAyN1
         RNXuytaUNqvxqe0GIZDiict4HCfEMdweIy9IxQghhAyUb7k+YImttBvb8KCWws8KLkTr
         U6HrBeFs3gG14iv2wNiXBXqJ6Wxda/HrVrdrCCe9j3Aqp8PTUZuQdELQ2+0FdH+FJ6X7
         Hxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716818180; x=1717422980;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEPtuia/R2nnwPQ342ApH51M2D2tfllXiPxSAFnsUpY=;
        b=vjjLLOFC0vTrLtU5pgx0HEnJ2uxfhjGexpvYzaB42/gp+SrE6yL0GDiX+yio6suM7T
         Ks21Ge+yNbr82+1NWhzhaxMvr6tEbrKKzDEjLFGCLBTL/Y79snVfnbLIABoC9dIFK9e1
         IdM5rPortzLZCYYMA9sOy8DumYCxNtUHRSkRnDJWR7gnrjR74GOMK0w/a42JYYRhy2kw
         0nfLVoDU458pD7K9bQaT+hTc7UozouIQNvfzmLXyV7/sGmEQdDH+2ueeDTabyzLukKpO
         W5noSpInx8bq/rFwhjWInNDw2r5Hw0rWmaiFAJ2L0TH8ugF3cG8D3SvtgCQHYw9yeQNc
         7MOQ==
X-Gm-Message-State: AOJu0YyREEKUoM01VNJzIm8qETSgjujGtQeZ96uuAgn+q96u/9WSU0ft
	3xlIiNA4ZU6yUIGPGsgq0VTz8hUIN8oJ309KkCT4l15PG7FkJmi2/0st0A==
X-Google-Smtp-Source: AGHT+IHbUxwVijuLJRM/9rkRqF7XJYX3AQ2iKBVAmXE+7wltRRfBeYdi7Qr3h54grQkVD9qqqdZJ5g==
X-Received: by 2002:a05:6a20:3945:b0:1af:ce5e:ca5e with SMTP id adf61e73a8af0-1b212d0f9d0mr10909398637.22.1716818180109;
        Mon, 27 May 2024 06:56:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.28.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d51a2sm4887923b3a.189.2024.05.27.06.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:56:19 -0700 (PDT)
Message-ID: <66549103.a70a0220.af32d.bfc3@mx.google.com>
Date: Mon, 27 May 2024 06:56:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5409592004357117324=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: RE: [1/1] Bluetooth: hci_bcm4377: Convert PCIBIOS_* return codes to errnos
In-Reply-To: <20240527132552.14119-1-ilpo.jarvinen@linux.intel.com>
References: <20240527132552.14119-1-ilpo.jarvinen@linux.intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5409592004357117324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=856174

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.98 seconds
CheckAllWarning               PASS      33.58 seconds
CheckSparse                   PASS      38.99 seconds
CheckSmatch                   FAIL      36.25 seconds
BuildKernel32                 PASS      30.08 seconds
TestRunnerSetup               PASS      538.33 seconds
TestRunner_l2cap-tester       PASS      18.73 seconds
TestRunner_iso-tester         FAIL      35.79 seconds
TestRunner_bnep-tester        PASS      4.90 seconds
TestRunner_mgmt-tester        PASS      111.85 seconds
TestRunner_rfcomm-tester      PASS      7.63 seconds
TestRunner_sco-tester         PASS      15.16 seconds
TestRunner_ioctl-tester       PASS      8.03 seconds
TestRunner_mesh-tester        FAIL      6.27 seconds
TestRunner_smp-tester         PASS      7.08 seconds
TestRunner_userchan-tester    PASS      5.16 seconds
IncrementalBuild              PASS      28.91 seconds

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
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.172 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.110 seconds


---
Regards,
Linux Bluetooth


--===============5409592004357117324==--
