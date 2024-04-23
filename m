Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8646B91
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857574; cv=none; b=WE+K3gmK4dwa50qIgbu/cIhbypLAoWUg5a0EhQ3c8LEiK55GqyjWytGozmGDUF7uNJElqnuW3KP5dNUbknf4wP6ZAh48s+oMHIHcqzQgalkeytfALe+vycq/QdJIG1g6mZaxyzQhQFomVYvgMJvWVx2vE4V+rKnjEtRdRxZ9F70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857574; c=relaxed/simple;
	bh=9O+B0+ysEyxh0GCpwWhGDWWsXm84B+qWM761x7OiIQY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=daozalPrWll/35SRd/rnwdbRJTZeHIL6W/nzdzXJss0aF3ucPW0PJwlFVM4V9LctbKBpmrasdTXzw6fFJwNGMnyXtQRHgZ6DuLB5pJC7hV9t281aC4Ncw/yxmbISUYrhGlAVn7UaMPinAXfkWaswdHUmKFDDUg4DHDhFoYsyPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+/+FO8D; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+/+FO8D"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso4434213b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713857572; x=1714462372; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mB1aEDuSv2S7VdNSKVKMCgoK37Tz5lBvaLAp9PIrFJc=;
        b=O+/+FO8DTm4jtiJ02yHqmBhckaNl9BPNznlNiZJeRW7ngej8FdojDNESuv1hgclBrv
         RPFOWgO88XQlh/rVAJkC95+V0WrhLx4ipQgILd5scgslu1vjmLqhj+VkxsbQdLaUIpfi
         68SK+NFT6Kjtl6X+KHL+zbAHRBrtI1+UtikLOLKjejYtAII+cVkv26Wo+07ZU2p6DuFa
         ehmxy8M6EqH5eUf6Wc50mYVdtqsLFSGsTRXKV22kg5MgxsxCFsE3ChpcBo4cTM2VGqb0
         GFK5AMK6exJ/+DeO/AuYWhNknWyke59bnSHq/SYVB3yaHFAyF9U2KcLIODRool8pkq2L
         RRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713857572; x=1714462372;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mB1aEDuSv2S7VdNSKVKMCgoK37Tz5lBvaLAp9PIrFJc=;
        b=gxiSqpbzOhhZP6r3YbVGxjUPWKF0gSuvIgDOgTSpcBi4c/6yIhmLF0fZnE6g55qKzV
         /M8301/Sew8ZNaBnAY7J8dk2jpBYX4PITGNyAjgDzkbpLSSlT3BZZbS+wXGJ6j2/rwPb
         HLE/SIM/orTIT50DEOueEhySzD3YofbY/j8J+1Q9ri09LCFh0XV0/OVfGjRYb1qaznOl
         GPpxTZhwsLznSnQzHoU9ALSHVMnmsVuqwsuXCErX9IiUcsp9mwJQ36gp2M2B2Ksai1SR
         +3I6Utx9tn0ALB8X2Sge7syPIBY0VXNQUqha8N+1a4CuStEHUBsCWbFqdgKTL5bQJe+w
         jWtA==
X-Gm-Message-State: AOJu0YwJevRtvCE7gluW++3aCTAoytI0QrFRRg41Yj1F3L/jT/BwUeMg
	MVWzRKb8TvrkliCRtqJ8HGzuOLKEGgfP8sXZG3/Z6XxQQe0suxBq2xqIZA==
X-Google-Smtp-Source: AGHT+IEnj9LhlPUv8btqWXVTUT1LcDPXhUZhT3jePmQ5ZLPrtByTERnDv+MJIIo8uvnbKsSY9Qshbg==
X-Received: by 2002:a05:6300:8085:b0:1a9:694b:5b0 with SMTP id ap5-20020a056300808500b001a9694b05b0mr12172103pzc.21.1713857571821;
        Tue, 23 Apr 2024 00:32:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.5.86])
        by smtp.gmail.com with ESMTPSA id kr3-20020a056a004b4300b006ed26aa0ae6sm8968100pfb.54.2024.04.23.00.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:32:51 -0700 (PDT)
Message-ID: <66276423.050a0220.49641.db9c@mx.google.com>
Date: Tue, 23 Apr 2024 00:32:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6797530884593487267=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiande.lu@mediatek.com
Subject: RE: [v5,1/2] Bluetooth: btusb: Add USB HW IDs for MT7921/MT7922/MT7925
In-Reply-To: <20240423065157.21805-1-jiande.lu@mediatek.com>
References: <20240423065157.21805-1-jiande.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6797530884593487267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846880

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
GitLint                       PASS      0.44 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.59 seconds
CheckAllWarning               PASS      33.12 seconds
CheckSparse                   PASS      39.13 seconds
CheckSmatch                   FAIL      36.71 seconds
BuildKernel32                 PASS      29.46 seconds
TestRunnerSetup               PASS      531.55 seconds
TestRunner_l2cap-tester       PASS      18.41 seconds
TestRunner_iso-tester         FAIL      39.83 seconds
TestRunner_bnep-tester        PASS      4.68 seconds
TestRunner_mgmt-tester        FAIL      120.30 seconds
TestRunner_rfcomm-tester      PASS      7.26 seconds
TestRunner_sco-tester         PASS      15.31 seconds
TestRunner_ioctl-tester       PASS      7.68 seconds
TestRunner_mesh-tester        PASS      5.75 seconds
TestRunner_smp-tester         PASS      6.75 seconds
TestRunner_userchan-tester    PASS      4.83 seconds
IncrementalBuild              PASS      34.16 seconds

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
ISO Connect2 Suspend - Success                       Failed       8.202 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.194 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.449 seconds


---
Regards,
Linux Bluetooth


--===============6797530884593487267==--
