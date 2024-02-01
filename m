Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9564B85264
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815513; cv=none; b=HgJ+v1h3//mCPTYkjIDcpbqoLqgmPqn/8spqoOLDdr/bKQo9aX5CLDq+Ey5DUDTa30xwqUlrTGRg9hij6lBEfGceoTB/U+UTJLFY4Srv1vwenKPvQ1POVr5BrseImZpMEwlauMzPVanwzzZYQxSh+xIIL8TYLHVJb3wqtFqMhrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815513; c=relaxed/simple;
	bh=QANQIg7AVuRR+97tATgicZ/hUW0EzZjWb47vj10P99o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=L3Y4RPtvr/YquV9VbdWJV39tgKyfKRKUOUR6n7NaX2QYjrJQF2SrWMqFbiPjK4fmRfCGc3LRuixnhLaHfydDPG9qr5NAQuqTmbUw0lH09DyfYfXGywxUlbOnkE/LC8PbUS1f4nPgtXm/0Ai0K4mdxvyPSBG/UG90gI1g/3c9YB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lE2f/qem; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lE2f/qem"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-204f50f305cso804476fac.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 11:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706815510; x=1707420310; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nwORX6bNgLsi87XyifnuO0HeDLUSdW9xyQMVLGnMZTU=;
        b=lE2f/qemrZ7/BrJc3zdkrDrl0klAteexXP61LTypNWCbzd2Sej35EMG0Oga/mc4o/H
         xIthUddwzIETB1JyodDI6p93ITzZQb2tbIPcZI7ENgKdlKcJ3hAtDTuyJwMqYDinbpmR
         7EVYLXB5Y3p7lgLNT5XDYxlD71T2hWcJYtW9BwOvr/FWwUPEVOO/2i1uuqDyacTkwi4V
         DohId3MTtAJp3Ds1kpkKUV9AJ1kFzSgHH4p5n92Dy+MArHUuVQQOqgA2XzFbbYOejGMI
         t0P1JnlyakqkmB0/9QSZG6iEYhtliuy5KLgcNSvdlBMRgGEA1vHzsi5rfBQP6x9vmZ8J
         RB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706815510; x=1707420310;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwORX6bNgLsi87XyifnuO0HeDLUSdW9xyQMVLGnMZTU=;
        b=g4HdJUX3y3cGukhLp4Id1lrpjjWu1nYmLB/OJxcuIqqofYG+LMpn1cbVlxRl09OJok
         iNtMc8Fo/Ih/zUbpZISM2MJdvAuFLwrQWpQBfAFGGdCdEDfqqJEtzjh/aT67jrlR4So1
         /NgHJetSVgbiHHPSySlFnMdEDCfQYgqSD8HQx9ZwEHTXgZ9tIq1q2XrDhFGEDp/03++c
         /n7bVFNdeiNDFOvVOMKyjdpVMD+JuVXiHaEP+UZ1wobxSQ0FFbyRB4tUyaihNDAf7bAt
         yx6pn4eN+LM3RTaYyJqyHx0jJ9CtON5UZkcaGDoPnjTrKVkztYEfzt7fYkbZFUwTgWiH
         K7lg==
X-Gm-Message-State: AOJu0Yy+n5Sa5d5yNc1UWzv6F3YqSN51GV6PSm8fZvgzjOGIZYm1mN3M
	q0lgZOUmSw2z6XhugbIpDEVxEEeyNxrN7U+iqHzKWJ8W10uZeOh5rCfwpCTr
X-Google-Smtp-Source: AGHT+IEDiDY3a4B741yuVt4NH8UHy+iOuYKn+EO+5mJhwHC7ofsNK47T4j2BPzDgOS6he7bFayoxuA==
X-Received: by 2002:a05:6870:6c0a:b0:206:85a2:643b with SMTP id na10-20020a0568706c0a00b0020685a2643bmr6848685oab.35.1706815509812;
        Thu, 01 Feb 2024 11:25:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXKBBkU38Vv112tQfOGBnjPo0gktMpWBtpt+HfNU46HnmALIg3B7+gvsxb8VZf+e2OspWwL0tvFjNZ4g9Ym+HyjTRo3Zw==
Received: from [172.17.0.2] ([172.183.51.69])
        by smtp.gmail.com with ESMTPSA id lq8-20020a0562145b8800b00685422c9e35sm56312qvb.84.2024.02.01.11.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:25:09 -0800 (PST)
Message-ID: <65bbf015.050a0220.bc5e1.07f3@mx.google.com>
Date: Thu, 01 Feb 2024 11:25:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8578852555307685614=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: Remove BT_HS
In-Reply-To: <20240201184937.1104620-1-luiz.dentz@gmail.com>
References: <20240201184937.1104620-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8578852555307685614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=822244

---Test result---

Test Summary:
CheckPatch                    FAIL      1.40 seconds
GitLint                       PASS      0.54 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   FAIL      18.74 seconds
CheckAllWarning               FAIL      21.07 seconds
CheckSparse                   FAIL      24.31 seconds
CheckSmatch                   FAIL      53.04 seconds
BuildKernel32                 FAIL      17.86 seconds
TestRunnerSetup               FAIL      411.03 seconds
TestRunner_l2cap-tester       FAIL      0.13 seconds
TestRunner_iso-tester         FAIL      0.14 seconds
TestRunner_bnep-tester        FAIL      0.13 seconds
TestRunner_mgmt-tester        FAIL      0.43 seconds
TestRunner_rfcomm-tester      FAIL      0.13 seconds
TestRunner_sco-tester         FAIL      0.13 seconds
TestRunner_ioctl-tester       FAIL      0.35 seconds
TestRunner_mesh-tester        FAIL      0.13 seconds
TestRunner_smp-tester         FAIL      0.13 seconds
TestRunner_userchan-tester    FAIL      0.15 seconds
IncrementalBuild              FAIL      17.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] Bluetooth: Remove BT_HS
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#94: 
https://www.bluetooth.com/blog/new-core-specification-v5-3-feature-enhancements/

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#142: 
deleted file mode 100644

total: 0 errors, 2 warnings, 21 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13541659.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: BuildKernel - FAIL
Desc: Build Kernel for Bluetooth
Output:

net/bluetooth/hci_conn.c:39:10: fatal error: a2mp.h: No such file or directory
   39 | #include "a2mp.h"
      |          ^~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:243: net/bluetooth/hci_conn.o] Error 1
make[3]: *** [scripts/Makefile.build:480: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:480: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:1911: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2
##############################
Test: CheckAllWarning - FAIL
Desc: Run linux kernel with all warning enabled
Output:

net/bluetooth/hci_conn.c:39:10: fatal error: a2mp.h: No such file or directory
   39 | #include "a2mp.h"
      |          ^~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:243: net/bluetooth/hci_conn.o] Error 1
make[3]: *** [scripts/Makefile.build:480: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:480: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:1911: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2
##############################
Test: CheckSparse - FAIL
Desc: Run sparse tool with linux kernel
Output:

net/bluetooth/af_bluetooth.c:223:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block
net/bluetooth/hci_conn.c:39:10: fatal error: a2mp.h: No such file or directory
   39 | #include "a2mp.h"
      |          ^~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:243: net/bluetooth/hci_conn.o] Error 1
make[3]: *** [scripts/Makefile.build:480: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:480: net] Error 2
make[2]: *** Waiting for unfinished jobs....
drivers/bluetooth/hci_ag6xx.c:257:24: warning: restricted __le32 degrades to integer
drivers/bluetooth/hci_mrvl.c:170:23: warning: restricted __le16 degrades to integer
drivers/bluetooth/hci_mrvl.c:203:23: warning: restricted __le16 degrades to integer
drivers/bluetooth/hci_nokia.c:284:23: warning: incorrect type in assignment (different base types)
drivers/bluetooth/hci_nokia.c:284:23:    expected unsigned short [usertype] baud
drivers/bluetooth/hci_nokia.c:284:23:    got restricted __le16 [usertype]
drivers/bluetooth/hci_nokia.c:287:26: warning: incorrect type in assignment (different base types)
drivers/bluetooth/hci_nokia.c:287:26:    expected unsigned short [usertype] sys_clk
drivers/bluetooth/hci_nokia.c:287:26:    got restricted __le16 [usertype]
make[1]: *** [/github/workspace/src/src/Makefile:1911: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

net/bluetooth/hci_conn.c:39:10: fatal error: a2mp.h: No such file or directory
   39 | #include "a2mp.h"
      |          ^~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:243: net/bluetooth/hci_conn.o] Error 1
make[3]: *** [scripts/Makefile.build:480: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:480: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:1911: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2
##############################
Test: BuildKernel32 - FAIL
Desc: Build 32bit Kernel for Bluetooth
Output:

net/bluetooth/hci_conn.c:39:10: fatal error: a2mp.h: No such file or directory
   39 | #include "a2mp.h"
      |          ^~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:243: net/bluetooth/hci_conn.o] Error 1
make[3]: *** [scripts/Makefile.build:480: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:480: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:1911: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2
##############################
Test: TestRunnerSetup - FAIL
Desc: Setup kernel and bluez for test-runner
Output:
Kernel: 
net/bluetooth/hci_conn.c:39:10: fatal error: a2mp.h: No such file or directory
   39 | #include "a2mp.h"
      |          ^~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:243: net/bluetooth/hci_conn.o] Error 1
make[3]: *** [scripts/Makefile.build:480: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:480: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:1911: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2
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
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:
[v1] Bluetooth: Remove BT_HS

net/bluetooth/hci_conn.c:39:10: fatal error: a2mp.h: No such file or directory
   39 | #include "a2mp.h"
      |          ^~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:243: net/bluetooth/hci_conn.o] Error 1
make[3]: *** [scripts/Makefile.build:480: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:480: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:1911: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============8578852555307685614==--
