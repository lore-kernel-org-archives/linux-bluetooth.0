Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA6220691
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799769; cv=none; b=PyXwAiU3yIZbRM0XjFO/RHA69EffCb83OaOnwORoqFBI8fXLiHEjDP6jJJFKZbKiNAfj6L3SeJWoP9+kQ1YZSSfPKrvAEEel2bCV9CI7rd658GV0B/kDkvu2f3IV1apuTfwswQArKHPUST8uyQEthvWs33fg6iOd4HN8sRsCpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799769; c=relaxed/simple;
	bh=sdZrvL4X1mIztYIM5G4MUv5HmrdnkKZHaCjKZ3lhReQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sVVG/mOSjVWNISJcrisVDvXpLEDWZwT05biafNmqtkP+IPYMWDzqYwZYjaZsHbiHt/g/tIUm85czTuh23ydUUjSM7BFQdUgAUS+rPPkPDy8HMRCekbr9eZSH1AlX08hjQmNmBI/NFaWyAb+zVs0e5E9F0eR73cWawfL0g5BY1vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUKVscl5; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUKVscl5"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af9925bbeb7so4853622a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 03:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744799766; x=1745404566; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fyi2i1u0w1SAzDIFYE6KK6P80jYfuoqGxIb8wDCGwkk=;
        b=mUKVscl5LRnIRebbq8311OUzo83BdkNSJ6XCn8pPofCI1QBbPIUeF4DpEdwB1O7mwi
         3Mt8yMgK2mmT1AL4EwP9tFm7d1dFtZvI0+/Xwd8gxlHe3mt+2gyBsxt4AjoZOol08yaJ
         5WYdIdei0RKo4oCkKErUQuqJD+u2sx61cvjt1WYWPPOfgChPEJlugvgus9SIYNY3KPkl
         xZ4z4huhXbFM3OJPqvk/QFQqkUE4iy/f9iozaxq4e7KSY7Ad7gUL6ksMbyaywmg8iYoh
         xXwKsFryPBqxxkG/Ck+639gyaWq1322nA2oZFUzYSoybVMHJabSBLDF247Cw4gHrtbts
         gYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744799766; x=1745404566;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyi2i1u0w1SAzDIFYE6KK6P80jYfuoqGxIb8wDCGwkk=;
        b=VlFs/edUdx9aSwk0MNw4VmkIED3W480scv9J6IvB3c7f8tDE8ZM9Pb0DOffVJtTKjE
         sYY/f3ZwFAOO7ECy6MP5shqPjvPInLt6Imfj9kkSyHjExGtqw5OW/m/x76C7awOFOxhR
         8MLr4shDsnbnYKWLwonjiqx3rXP4TGoTBIAbq6IKFfsJYqSRqrWnNafatIeGu0kV+AUP
         Vmj8gANUOijFA3JxBJ9QtKKRE2ipFE3WdcqhtHRIOZT7w44+KexqyXv7UCkp4siLRBxk
         4CfSiid9sXg2bii1Q4R/8l6uF1IU0mph/cI+Sj5O6Srv/ShQ3l/n2DoBTDAS3wFCvW/g
         cxVw==
X-Gm-Message-State: AOJu0Yw/bcwmaDSF3CDFzBK16lqRgTvk8XekOdSIJDj+ODiYWuJiQ/vW
	+OMfVlfrCxxLOB/rB4YOWtYw07zKfjCU/NhqLsPlxPyOhJYHwLKtF1pA9Q==
X-Gm-Gg: ASbGncskVlWGIMfgGpMekW4cecI2IFX4Pwmp+npRzsdMKffgojJuIVoTgUTjO9c6Wfz
	+crh3wkxJXNTq1ouZEX5eqHZB/L8JrNgz42ncPhcFRY+RBQgfBAXk19wAVTkwNEjD9b1keVwCTs
	AIbu/tMoNaxurWnR9ntAifub4puWRLgc/l5D0chK5/1Zgu0aeK0rzyrux6Eah8URc2Iql6JoT6f
	N7UIQ2jGIvOqFFs1Av3+ibTAz4ym+ib4SsYw4wR2NOA6G4ceySZP6X/f7wd/zrBZfMSZ0JrkPiN
	fF8/xSMTfl5Mkee87UkppGmo+wEPGZDHtwCHEWlDqC+VO6Wnb1HOcT4=
X-Google-Smtp-Source: AGHT+IEMs+BjcXUdLUu/vi1v7dRU1LBALOKrIISXgHkUAmpZS0GYS7PqjrJDoY/zgqHADXMlkYwNwg==
X-Received: by 2002:a17:90b:5864:b0:301:a0e9:66f with SMTP id 98e67ed59e1d1-30863f1994dmr2508290a91.14.1744799766446;
        Wed, 16 Apr 2025 03:36:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.42.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1d07bsm10663675ad.94.2025.04.16.03.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:36:05 -0700 (PDT)
Message-ID: <67ff8815.170a0220.1e4e84.3c81@mx.google.com>
Date: Wed, 16 Apr 2025 03:36:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8970958179421722227=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: [v2,1/4] Bluetooth: Introduce HCI Driver protocol
In-Reply-To: <20250416095505.769906-1-chharry@google.com>
References: <20250416095505.769906-1-chharry@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8970958179421722227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=953913

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      3.42 seconds
BuildKernel                   PASS      25.58 seconds
CheckAllWarning               PASS      28.36 seconds
CheckSparse                   PASS      40.61 seconds
BuildKernel32                 PASS      32.78 seconds
TestRunnerSetup               PASS      484.26 seconds
TestRunner_l2cap-tester       PASS      22.46 seconds
TestRunner_iso-tester         PASS      37.98 seconds
TestRunner_bnep-tester        PASS      4.95 seconds
TestRunner_mgmt-tester        FAIL      126.63 seconds
TestRunner_rfcomm-tester      PASS      8.44 seconds
TestRunner_sco-tester         PASS      28.71 seconds
TestRunner_ioctl-tester       PASS      8.94 seconds
TestRunner_mesh-tester        PASS      6.37 seconds
TestRunner_smp-tester         PASS      7.56 seconds
TestRunner_userchan-tester    PASS      7.87 seconds
IncrementalBuild              PENDING   0.64 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.180 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8970958179421722227==--
