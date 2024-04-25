Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5C14A0A0
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057005; cv=none; b=Te6uCaiRDstAXe7CZtAcBehMJ+tni1p03d4JQ+WAyQsa5Csjv7ttO+hIEUHJ4rfmqBYOL+ItwvLnHlsw0SfybtyRdt7ukTdIjFOu7B2zWpM1EpzdLPOs0FFuXh0GXO0HywQkzCbYury/tE3zCcUSOe6CpacdCGJAr2N5ii6EAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057005; c=relaxed/simple;
	bh=nFez4K9yCPJT5RzNtVMz/011FtFXsflr6LqV11S2fiM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ObXV6D9O9+ZcYGTSnhfKU7tEIrjwoa/4puJTv2439HkepG0RRtBDhJtBGsy4lF2IvY2NQPUyygOvV4Q4QVYJ6IIGAsXCDJynBCXCe8C556fQMTFBL0B9eNVvkSHCQ2w43FZ5YYVmtMXTeJbzRRiX3SMgqZIm2cXLUqSZ6P5yaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3vXnuHl; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3vXnuHl"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c749aa444fso666660b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714057003; x=1714661803; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Bknw90UYKmXmLUAmOMEAb+u562Q2pHL/pgVlcTj8zE=;
        b=k3vXnuHlMD5KXwljfPQNUwbjNUhAPUGTCsgcA/nJwXxkODC8/JWEeKhLp1wRyMox9L
         HrUC+fib07oC4k0f55Z7w7jMn9KFbl4jcPndEUlxPGHJZ0qw8VY6T3MvtrWqvTka/Lvn
         g3WK7UocLL/Xg5fpsM7faZAZM4osGOIJVw26ZVXHERTA4nJxoIBnycSupr44Vxonjmy8
         YNjTQ6BiNNur5w2zF6jRPZ/WKLhroqsaDxFIAVIkJrYjei4Mqp3snxd/0L8FXM/QT8UG
         u/cC8MUQCuVo7WMKNMhjmzyX67nnOUyXLScFiiZSjsBgxtoSfieMd0gSiJE+AOi4/S25
         BqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714057003; x=1714661803;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Bknw90UYKmXmLUAmOMEAb+u562Q2pHL/pgVlcTj8zE=;
        b=nrTFfNpkxm76046y9u0l+7GvzOpy7BBXn3vR1rKGeJKLXbLWKazdx9nqZx3YQnnkdx
         hKS+hyItAEAB3IfWl7v/9J19hsJnjwKNc9DJ2GCbtqyFwt0H2KVEdnIK9862NRtbRrUD
         hXhRCaMR8ZSRsGqjDtzKJRj2Zz1Rx84pI8KCS3S+fStlT7jl5eqq9fQY4Uw9W0gAnwKX
         SgsTLeB/APfQr2HxQIy76sv6qA7Br8lBlrGXHrVc8OW9NjIgnx4J0XJuMnKhmWOfzTRv
         e04Fzgsd9n/7k8EcPwdbaVCXvUIVyF+dkFj/o3+loS2IkgvQ9C8W3pwtn1DfaXqq0vqz
         dxsg==
X-Gm-Message-State: AOJu0YwjbXfPZUM2PMZ4aaM6ymTvmEr8o/J+zynBaKlLcRH4iQeWX060
	iZ+AC5wwd60H9rPmPAvW+1ual8N1NcNJtUOHC7/rM1t6Sooljw7S1qE1Ng==
X-Google-Smtp-Source: AGHT+IGAi/B45xpFCmM3wNLg+WL4JU+a9KqwN1lB+8rpGjJmXbiF8fi9Umy/VLQTva6Ne/2UnBVCPQ==
X-Received: by 2002:a05:6808:234e:b0:3c8:4300:eed5 with SMTP id ef14-20020a056808234e00b003c84300eed5mr4984977oib.20.1714057003228;
        Thu, 25 Apr 2024 07:56:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.84.127.98])
        by smtp.gmail.com with ESMTPSA id k11-20020a0cf28b000000b006a053b4c3adsm6992650qvl.118.2024.04.25.07.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:56:43 -0700 (PDT)
Message-ID: <662a6f2b.0c0a0220.7699f.21dc@mx.google.com>
Date: Thu, 25 Apr 2024 07:56:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3833140132704632744=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, duoming@zju.edu.cn
Subject: RE: Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout
In-Reply-To: <20240425142345.47229-1-duoming@zju.edu.cn>
References: <20240425142345.47229-1-duoming@zju.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3833140132704632744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=847884

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.97 seconds
CheckAllWarning               PASS      32.81 seconds
CheckSparse                   WARNING   38.27 seconds
CheckSmatch                   FAIL      34.61 seconds
BuildKernel32                 PASS      32.37 seconds
TestRunnerSetup               PASS      519.21 seconds
TestRunner_l2cap-tester       PASS      18.34 seconds
TestRunner_iso-tester         FAIL      36.97 seconds
TestRunner_bnep-tester        PASS      4.63 seconds
TestRunner_mgmt-tester        PASS      110.77 seconds
TestRunner_rfcomm-tester      PASS      7.40 seconds
TestRunner_sco-tester         PASS      14.91 seconds
TestRunner_ioctl-tester       PASS      7.60 seconds
TestRunner_mesh-tester        PASS      5.80 seconds
TestRunner_smp-tester         PASS      6.68 seconds
TestRunner_userchan-tester    PASS      4.85 seconds
IncrementalBuild              PASS      28.19 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
22: B1 Line exceeds max length (81>80): "[   95.890016] =================================================================="
88: B1 Line exceeds max length (103>80): "[   95.890755] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88800c38a800 pfn:0xc388"
92: B1 Line exceeds max length (87>80): "[   95.890755] raw: 0100000000000840 ffff888006842dc0 0000000000000000 0000000000000001"
93: B1 Line exceeds max length (87>80): "[   95.890755] raw: ffff88800c38a800 000000000010000a 00000001ffffffff 0000000000000000"
94: B1 Line exceeds max length (88>80): "[   95.890755] head: 0100000000000840 ffff888006842dc0 0000000000000000 0000000000000001"
95: B1 Line exceeds max length (88>80): "[   95.890755] head: ffff88800c38a800 000000000010000a 00000001ffffffff 0000000000000000"
96: B1 Line exceeds max length (88>80): "[   95.890755] head: 0100000000000003 ffffea000030e201 ffffea000030e248 00000000ffffffff"
97: B1 Line exceeds max length (88>80): "[   95.890755] head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000"
101: B1 Line exceeds max length (81>80): "[   95.890755]  ffff88800c387f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc"
102: B1 Line exceeds max length (81>80): "[   95.890755]  ffff88800c388000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb"
103: B1 Line exceeds max length (81>80): "[   95.890755] >ffff88800c388080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb"
105: B1 Line exceeds max length (81>80): "[   95.890755]  ffff88800c388100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb"
106: B1 Line exceeds max length (81>80): "[   95.890755]  ffff88800c388180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb"
107: B1 Line exceeds max length (81>80): "[   95.890755] =================================================================="
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
ISO Connect2 Suspend - Success                       Failed       6.230 seconds


---
Regards,
Linux Bluetooth


--===============3833140132704632744==--
