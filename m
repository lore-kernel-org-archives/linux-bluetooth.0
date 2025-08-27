Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7AE30AD02
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 04:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270662; cv=none; b=AUXrGhcLyMse5vv3k2e0FBnS1/X6RaaitNOj6izKTY3OlXQz+JQwGhpnpdmb7pxbr0XjpM44JqHk6PiH4Jxrs5MV69A0kx1X1jjvZQa5bpe4HVEJI8D6xjXbVWxlqAvxmKEGK+uJ3FtR/cpkWzxTNA9F9TFeXUdLyvLo59nqV64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270662; c=relaxed/simple;
	bh=LOy8luKuhbOKYt4VO8nCAm5mG0HtRHdg8BsMdQfiy5w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=X41DvNWnU074VeJnixpPat+gIAAbeIXi1onx9O45SKXJys2DOaYX+mBMQiMjVgsSCnGFLDegNeWoZk+VOBezVqABKSEi0+z0fxu/QVeqpBPlg74vYFAyn+DuPgHd9W6apV3rikT3msyQlHAxUI7rc9++ig8UF+1kpd+Ll1hK5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UptoxktM; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UptoxktM"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e86f90d162so58954985a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 21:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756270660; x=1756875460; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u3o4doBG5g9nxPodUGWtGLVR9ap7NbeaYc/hBNdFVyE=;
        b=UptoxktMBHYdrrBUF0Qyh/SNFVMQVYqASq9v6ZqWinv3MvGoqltNbol57m+TApHIUl
         umxhdabgG1NOjE89abQRUGbso9/88YCCpKzD9J9ID7woDiF8Yk1x80K3kqVXwZimP3uK
         YirQlrs8nn75XIxGKU4GJEVPvz9qL3r8VXMKhzfvGP+3M1mD36cgBrEvdsOmHb5nXEHc
         2CMIc4QLHO9RDBCmycnRBJE9h+WRrp6va1je/kdOkX5tlCThka/DaNW+SYqnY/c0Kw8z
         4c08vH3TzBjxrR9SUfJ2Mf4BZSrisvJmy9zne8YHSQ0YDYg5uaEyqwkGDpu8tkMF+uvw
         M6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756270660; x=1756875460;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3o4doBG5g9nxPodUGWtGLVR9ap7NbeaYc/hBNdFVyE=;
        b=tffaSJW/49G0JfEzS5CRf1POGscQG+CLDNo4bLaw4k2zO/aA8i4UqakECr0AYR+Vd3
         F6qFxXVfVSd6aAYIr86ClkdxCuS/+CvOFg45ZoIOHyu+SDmnLjSZBAmkMfzhRkb2WeqT
         p0Vh7VrenV548PMwxn+wRty4Oe6PzYMjH/PuDVM/lfuuN8U/RO0crAMJq3qsU5wE1hQI
         Ajb83mAjQq29y6rezH9KMT5wsSdeY89YOVfe/gaSXbVSzOFene7kPG5yLG7+UE1iw8SP
         JuzzRs32H12C6z25au/1x5UdAEQ3i1OzA2W4Pdeiv3eHUyOBZIPWwcIhfgdRlamFd52o
         XFvA==
X-Gm-Message-State: AOJu0YyiV9zLOILGRPS3MYGFI4VosVNmjoSJGobOMFQJniRlrPawXZi/
	Vdj9O99Fdrod7BzDHCzwG0xAvEIFWz87sT0OBOeCAybcYek9QG1RF00zIW1yCw==
X-Gm-Gg: ASbGncsV7BT0TqMtQVPkedyaNY9r3B6Wtq04WTDpGOWnh/wdHZCdQdeJRJ0xsVqqI34
	qHkSoYG23COVbGlptpICxoEW5WQ9QSkArQ2/gUeCijrOJvP1KMn7QnVH7TtAlqM5MbPN82lPz6p
	H/vSgHVmIWbzcWwHtmvwRe9pYsRfzsMNjrypWmkNONuldubdQWCpIYOM8KwjhkTb4RS7p7x0dpQ
	bWYwCNd9XRORiwy1sa4giMR9PmTCukyGIzJ4jOv/k35Z+pTiFf7gr2qSKPW4m/ppY/Fo+703aiT
	6cXfuFrrHn+NcULOn8u/IUcE5rhLcKn8fjn+qWez5AqJM0uBuQ2DKizmuIh3I3pyYHbsDGs7005
	Tlc6bLbgMh8EJL8cvLXfgOUZus+8D7w==
X-Google-Smtp-Source: AGHT+IFBrOVhVH2WAP/tNxWfPR+np53EmYYGd+fdu9mk2E0IbZvUn74OEYso0npF6rnNi/Y++6+IXg==
X-Received: by 2002:a05:620a:460d:b0:7ea:1064:a8ff with SMTP id af79cd13be357-7f58d941d01mr394527585a.42.1756270659617;
        Tue, 26 Aug 2025 21:57:39 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.243.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf35f00a1sm797760585a.53.2025.08.26.21.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 21:57:39 -0700 (PDT)
Message-ID: <68ae9043.050a0220.209db5.e0e7@mx.google.com>
Date: Tue, 26 Aug 2025 21:57:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0566322150082412348=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jgnieto@cs.stanford.edu
Subject: RE: Bluetooth: hci_h5: implement CRC data integrity
In-Reply-To: <20250827043254.26611-1-jgnieto@cs.stanford.edu>
References: <20250827043254.26611-1-jgnieto@cs.stanford.edu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0566322150082412348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=995878

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      23.96 seconds
CheckAllWarning               PASS      26.44 seconds
CheckSparse                   PASS      29.68 seconds
BuildKernel32                 PASS      24.10 seconds
TestRunnerSetup               FAIL      462.90 seconds
TestRunner_l2cap-tester       FAIL      0.14 seconds
TestRunner_iso-tester         FAIL      0.14 seconds
TestRunner_bnep-tester        FAIL      0.14 seconds
TestRunner_mgmt-tester        FAIL      0.14 seconds
TestRunner_rfcomm-tester      FAIL      0.15 seconds
TestRunner_sco-tester         FAIL      0.14 seconds
TestRunner_ioctl-tester       FAIL      0.14 seconds
TestRunner_mesh-tester        FAIL      0.14 seconds
TestRunner_smp-tester         FAIL      0.14 seconds
TestRunner_userchan-tester    FAIL      0.14 seconds
IncrementalBuild              PENDING   0.52 seconds

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
Test: TestRunnerSetup - FAIL
Desc: Setup kernel and bluez for test-runner
Output:
Kernel: 
ld: vmlinux.o: in function `h5_rx_crc':
hci_h5.c:(.text+0xd938d9): undefined reference to `crc_ccitt'
ld: vmlinux.o: in function `h5_prepare_pkt':
hci_h5.c:(.text+0xd94798): undefined reference to `crc_ccitt'
ld: hci_h5.c:(.text+0xd947a6): undefined reference to `crc_ccitt'
make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux.unstripped] Error 1
make[1]: *** [/github/workspace/src/src/Makefile:1236: vmlinux] Error 2
make: *** [Makefile:248: __sub-make] Error 2
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu: could not open kernel file '/github/workspace/src/src/arch/x86/boot/bzImage': No such file or directory
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu: could not open kernel file '/github/workspace/src/src/arch/x86/boot/bzImage': No such file or directory
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu: could not open kernel file '/github/workspace/src/src/arch/x86/boot/bzImage': No such file or directory
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu: could not open kernel file '/github/workspace/src/src/arch/x86/boot/bzImage': No such file or directory
##############################
Test: TestRunner_rfcomm-tester - FAIL
Desc: Run rfcomm-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu: could not open kernel file '/github/workspace/src/src/arch/x86/boot/bzImage': No such file or directory
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu: could not open kernel file '/github/workspace/src/src/arch/x86/boot/bzImage': No such file or directory
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu: could not open kernel file '/github/workspace/src/src/arch/x86/boot/bzImage': No such file or directory
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu: could not open kernel file '/github/workspace/src/src/arch/x86/boot/bzImage': No such file or directory
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu: could not open kernel file '/github/workspace/src/src/arch/x86/boot/bzImage': No such file or directory
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu: could not open kernel file '/github/workspace/src/src/arch/x86/boot/bzImage': No such file or directory
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0566322150082412348==--
