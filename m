Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE979DA
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 00:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776816519; cv=none; b=iVo1eH2c0GmDQRSLMrcSEmP7D8pfYm0pRIOyiOzd6obqTn9YJFLJPEdm1KPiWzW4lwRVuxOx70qHb8XvOt5YY2+KDHP11wmZFMCyh3X+CiL/91DoqSWpUrRLBaiPDFrPnGFdMRGtejdx25qRp8JI+CqAPDLClkndVSeLuHsKne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776816519; c=relaxed/simple;
	bh=mJ6qg1zy4KGb4XmO3yjoGrRln6D0mX5eETDUbmUyNi4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CDaJfmk2MiHPXtdGUMuoF0cpX+vSvr/mwUOVG8hW48woENBp6BRP4ka+a+w6pRXkFaicRrmhUOBjTVDwow7odDBi9K3IHQtguYSNcYVKd521sMPkUPbe/zx3fH9F2wdoVdpYMW8DZcUy1utHAvkEUnLyxtPmupVg8rgloNyvltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYP+6Oyl; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYP+6Oyl"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c45281a06so6522779c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 17:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776816517; x=1777421317; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=obLMuwnA/DvWQ061YKFG0f2D3osj2JQCbayJYxvj1oA=;
        b=bYP+6OyldLTfQWmMTAglapotn+w0hA423sEnC6cXgSVKbKyEh7XmVnD7eAN4V9qQoO
         rJUloP+OuNDcNOw/9xLlPO26T2sJS7inwukoeuXYUJ5m6RXRTrZHj0dqi3Za9oOnAhyl
         cInuZkNqVtAy3aCkw1RVQCCC9rXrv4O3fquBlANRF6T0+VZY9gpP8dAh9ASywz6A0kxY
         qkPqXsDT8+c33E4qCoAzvIoRdTSRA3ZzA82Xeb32wBt38BuwGgCj0Q5yeYXT1GvZD0U8
         WtUBFfV5fv4l2v4g2hJIA+M1XIF1nmVIiWoG0xrC4wgsvkz/zeOoJaQd+3nucIgMRWg/
         9B2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776816517; x=1777421317;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obLMuwnA/DvWQ061YKFG0f2D3osj2JQCbayJYxvj1oA=;
        b=iahuRSCgvBQAzQURycyCDaVHSTaYRE5YP4rNy2k0I0OyVfJCGVbnmEld9v3MtcVtwr
         oBBMS7RwEuzLnqQtznLZvCNqgFA2BOtMOCOCmfF7Ayf3YvBwzPZuhAg0NrVxyvplktY5
         /fbUoAurPr4B8DN6O1YiQ5Q4kcfMbqaYTbLpKvP2aVduuHnmhhRZ/ijxpjTem4ezO8KF
         +4Ac5XR01Kr3Yt8n0Pm/r60fKKjC51AYu17KWOfmCXfjnMblvwsD3xAB22SInBEh6rWI
         M62Uxlj+ctI7nxYppgg0m8e1gBT/FQfH0Vn68BEHaQdgDZIxLvooKXbLjHaSSFjJ1e+S
         WVJQ==
X-Gm-Message-State: AOJu0YyRhh8gPOIkS1fTZGFzau0E+R1VCz+qoyIVDv/F22Ri0JrBWBmM
	m9CyUAUGvLldvTK3Qf0qoCCNK4sg/Zlj25E6lFA3Zh/tjkzgqE3Wi1uoG7a9Aw==
X-Gm-Gg: AeBDieuwGs4OXJibBUMDNGaiDMGYn4dYuO78kwS81QhdliJTPSrlVh1OowfA4V1TgYN
	7SPBoJNmR0gpfvBadqECpLpRaFWlR0cNIZwype4v1l+P1OzGF5lTJHaFrDNntuPpU9G+u6NQQpQ
	iR6Qdl9JbjBhG6cm6mwjZ7cLH1U3Oor/0N/tmCYrpVvEE8fNiJxwgocYrOqRAVbopZgeHSpquWt
	NrMG91tZH9FxscTfpevZq9JsHZ7EGvjPDQeb0RmvCUzmb7Fgm/eclDnFAwrxtsl+3Kzcx1hClJE
	0VfRVZP7zqa/w4BhapXS7sHd7mN9qjPA+may46+0w2LtVNumOBg43VGv0+7XqT71A2qk5hdHBFj
	JNMc+CBVlGwzZuIYM1fHyUhp0BhfBbqahV/0k82acSHGzVPflWsJF57FTcVrFJbxM5sTT6x6MkX
	8pCIdmDbQuVsc338y02azj7n8QhKW3FVWU/cUOd/UASA==
X-Received: by 2002:a05:7300:4349:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-2e466044e0fmr10874284eec.5.1776816516693;
        Tue, 21 Apr 2026 17:08:36 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.160.160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfc1dsm20439417eec.22.2026.04.21.17.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 17:08:36 -0700 (PDT)
Message-ID: <69e81184.050a0220.343b8b.d048@mx.google.com>
Date: Tue, 21 Apr 2026 17:08:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1881267715018985072=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ebiggers@kernel.org
Subject: RE: Bluetooth: Use AES-CMAC library API
In-Reply-To: <20260421230917.7057-2-ebiggers@kernel.org>
References: <20260421230917.7057-2-ebiggers@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1881267715018985072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1084071

---Test result---

Test Summary:
CheckPatch                    PASS      1.56 seconds
GitLint                       PASS      0.49 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   FAIL      20.93 seconds
CheckAllWarning               FAIL      23.01 seconds
CheckSparse                   FAIL      22.09 seconds
BuildKernel32                 FAIL      20.31 seconds
TestRunnerSetup               FAIL      488.99 seconds
TestRunner_l2cap-tester       FAIL      0.11 seconds
TestRunner_iso-tester         FAIL      0.11 seconds
TestRunner_bnep-tester        FAIL      0.53 seconds
TestRunner_mgmt-tester        FAIL      0.11 seconds
TestRunner_rfcomm-tester      FAIL      0.11 seconds
TestRunner_sco-tester         FAIL      0.11 seconds
TestRunner_ioctl-tester       FAIL      0.11 seconds
TestRunner_mesh-tester        FAIL      0.11 seconds
TestRunner_smp-tester         FAIL      0.10 seconds
TestRunner_userchan-tester    FAIL      0.10 seconds
TestRunner_6lowpan-tester     FAIL      0.11 seconds
IncrementalBuild              FAIL      26.35 seconds

Details
##############################
Test: BuildKernel - FAIL
Desc: Build Kernel for Bluetooth
Output:

net/bluetooth/smp.c:25:10: fatal error: crypto/aes-cbc-macs.h: No such file or directory
   25 | #include <crypto/aes-cbc-macs.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:289: net/bluetooth/smp.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:548: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:548: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:2105: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2
##############################
Test: CheckAllWarning - FAIL
Desc: Run linux kernel with all warning enabled
Output:

net/bluetooth/smp.c:25:10: fatal error: crypto/aes-cbc-macs.h: No such file or directory
   25 | #include <crypto/aes-cbc-macs.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:289: net/bluetooth/smp.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:548: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:548: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:2105: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2
##############################
Test: CheckSparse - FAIL
Desc: Run sparse tool with linux kernel
Output:

/github/workspace/src/src/Makefile:1208: C=1 specified, but sparse is not available or not up to date
/github/workspace/src/src/Makefile:1208: C=1 specified, but sparse is not available or not up to date
net/bluetooth/smp.c:25:10: fatal error: crypto/aes-cbc-macs.h: No such file or directory
   25 | #include <crypto/aes-cbc-macs.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:289: net/bluetooth/smp.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:548: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:548: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:2105: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2
##############################
Test: BuildKernel32 - FAIL
Desc: Build 32bit Kernel for Bluetooth
Output:

net/bluetooth/smp.c:25:10: fatal error: crypto/aes-cbc-macs.h: No such file or directory
   25 | #include <crypto/aes-cbc-macs.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:289: net/bluetooth/smp.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:548: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:548: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:2105: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2
##############################
Test: TestRunnerSetup - FAIL
Desc: Setup kernel and bluez for test-runner
Output:
Kernel: 
net/bluetooth/smp.c:25:10: fatal error: crypto/aes-cbc-macs.h: No such file or directory
   25 | #include <crypto/aes-cbc-macs.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:289: net/bluetooth/smp.o] Error 1
make[3]: *** [scripts/Makefile.build:548: net/bluetooth] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:548: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:2105: .] Error 2
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
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu: could not open kernel file '/github/workspace/src/src/arch/x86/boot/bzImage': No such file or directory
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:

net/bluetooth/smp.c:25:10: fatal error: crypto/aes-cbc-macs.h: No such file or directory
   25 | #include <crypto/aes-cbc-macs.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:289: net/bluetooth/smp.o] Error 1
make[3]: *** [scripts/Makefile.build:548: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:548: net] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:2105: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2
[v2,2/2] Bluetooth: SMP: Use AES-CMAC library API

net/bluetooth/smp.c:25:10: fatal error: crypto/aes-cbc-macs.h: No such file or directory
   25 | #include <crypto/aes-cbc-macs.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:289: net/bluetooth/smp.o] Error 1
make[3]: *** [scripts/Makefile.build:548: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:548: net] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:2105: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2


https://github.com/bluez/bluetooth-next/pull/114

---
Regards,
Linux Bluetooth


--===============1881267715018985072==--
