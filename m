Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DBA175542
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352704; cv=none; b=OUW5FoHIg1qvtS7ePJe5ubcUbPnOHjyATUoPhZEAL5IAP0wWH9+UPiNvZkmdMsJDsBQkezAUQ3Pvuc07SR31rHMMXzRWKV0U5/G+2TakPrMsFbd7rYSxLpJlK6hmwZCRZxEUAx5n6VDdLMsjFog/q1OAmGdGQRONLsM6v5lsxP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352704; c=relaxed/simple;
	bh=d6wh+gzDJdiATBi5G+U2OqFpxjarrn4H0Plo1ksyP4A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m6zW2ULYUhGKj3+bw211tAf4KuxXMwLEqgl80XoNEYKO/+2yJw88wRncqpqZ+D0rVYHG3LoFidA/dnRG3bFCXuylj3cqmkVCR4l8r+Z24DyoYDRb31RLbuU8sEHMrdr/GyG2+aDZFKP4qfGPzJTxzWnBoy7k+lIjcaceIuVEdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsL/zEHV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsL/zEHV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e2b137d666so18800845ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712352702; x=1712957502; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tbQVNiHXWbp5t25Ow9UeEpG6ku8wMVCbICJx9Z/8XMU=;
        b=lsL/zEHVBT88vD8dF70/k/jTrbdmtSv2OHaH4t2Dcqmm2/SQAk1DQqY4yIZxLa0j2I
         3PCkl2tMJ7jvACLmT669pYaYccf/VZrmuDM8CYLPD9XyyOJJnCA9x8jUj5RAB9NyivVq
         xwjqbvCYD18FALdP/K1RYvOt/aXCM3sE27OKndMrV2q+mi+cPSCrfiKABJSKfzYaL0eg
         ldZlXwJJ8Y0iPc+z0kWxXtd/kauI9JugHoOtmG4jKEwk2BV+vQOcJyM4RP67PdK5VVyT
         RW8uccr7QkHmk/choea7ZY1JQMAlvCozGr0lz/vv8GYeXKrdF+OldgaJtvECLofeKkdC
         mJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712352702; x=1712957502;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbQVNiHXWbp5t25Ow9UeEpG6ku8wMVCbICJx9Z/8XMU=;
        b=G37y14nj1uytKNC/okflSIePmV+JQzWHqNy1JrwQ/4IKId+izceBaSMT9TPLx+zhH7
         tUfGEps9ap3wQEAcP8vuemCUns0Kf6aIg+PBVFNTDH/V/o1XdrDMwnbnwe/afcXobvp9
         RUAmiEiqilIB8n7eBlo4yNPqr7HEv1k58lEigGbXH7g5uKqGUl7egtuYMR41ho9QgOjx
         MIebjSWM3sWEVTgfAWzX5QSOcZmM+/wIBHH2SCHIFF50d28bVYYf8dqEgUx4JJs13s/m
         DVgDlH7QIYhNp4B4TYZbJVzRYBPnpI9u1X82XMNFKRlwMN2gqfdOO7O+a16KLwSujrW/
         +X4Q==
X-Gm-Message-State: AOJu0YwkjVkRGKbKf/xD8+RxGVv9cVhmeWO/cA0hlIv8/wYX/ghNE9Lr
	sbj0qtlUMZIJTmK70CH93gPjvhSfBEOXd705b2r3bEJ9ifhv7PJ8WmVsuAqP
X-Google-Smtp-Source: AGHT+IH4uPQ0EO6WVnCdrbJHsz+ROJjUOsD5ok7j7rlHqy8VssGdny8f6ysID5oe1gzppyC6Dd2tLw==
X-Received: by 2002:a17:902:dac9:b0:1e3:cfc5:589c with SMTP id q9-20020a170902dac900b001e3cfc5589cmr1520438plx.28.1712352701649;
        Fri, 05 Apr 2024 14:31:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.24.211])
        by smtp.gmail.com with ESMTPSA id 3-20020a631843000000b005e485fbd455sm1952047pgy.45.2024.04.05.14.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:31:41 -0700 (PDT)
Message-ID: <66106dbd.630a0220.51c1c.68cb@mx.google.com>
Date: Fri, 05 Apr 2024 14:31:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6105317154969037549=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/5] Bluetooth: SCO: Fix not validating setsockopt user input
In-Reply-To: <20240405204827.3458726-1-luiz.dentz@gmail.com>
References: <20240405204827.3458726-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6105317154969037549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841947

---Test result---

Test Summary:
CheckPatch                    FAIL      3.11 seconds
GitLint                       PASS      1.10 seconds
SubjectPrefix                 PASS      0.36 seconds
BuildKernel                   PASS      29.78 seconds
CheckAllWarning               PASS      32.66 seconds
CheckSparse                   WARNING   38.45 seconds
CheckSmatch                   FAIL      36.08 seconds
BuildKernel32                 PASS      29.07 seconds
TestRunnerSetup               PASS      521.30 seconds
TestRunner_l2cap-tester       PASS      18.21 seconds
TestRunner_iso-tester         FAIL      36.63 seconds
TestRunner_bnep-tester        PASS      5.08 seconds
TestRunner_mgmt-tester        PASS      107.86 seconds
TestRunner_rfcomm-tester      PASS      7.25 seconds
TestRunner_sco-tester         PASS      14.88 seconds
TestRunner_ioctl-tester       PASS      9.16 seconds
TestRunner_mesh-tester        FAIL      5.92 seconds
TestRunner_smp-tester         PASS      6.64 seconds
TestRunner_userchan-tester    PASS      4.76 seconds
IncrementalBuild              PASS      47.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/5] Bluetooth: SCO: Fix not validating setsockopt user input
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#107: 
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>

total: 0 errors, 1 warnings, 0 checks, 72 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13619406.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,2/5] Bluetooth: RFCOMM: Fix not validating setsockopt user input
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#112: 
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>

total: 0 errors, 1 warnings, 0 checks, 40 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13619407.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
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
Total: 121, Passed: 119 (98.3%), Failed: 2, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.187 seconds
ISO Connect2 Suspend - Success                       Failed       6.220 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.096 seconds


---
Regards,
Linux Bluetooth


--===============6105317154969037549==--
