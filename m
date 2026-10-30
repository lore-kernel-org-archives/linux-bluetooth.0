Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378481;
	b=D7Oe6wRB+lUZGqfaeN74HcrsZga3beh0NNF9siI/L2S48eFpHDtzuF/Tcho8kRD5+m+S
	 hxhXb4rsRLNY/VobE3fxTYIlq1GNm7sWSCjcVTnyK8ePT2vvzA6v4y9q1YNQlzujE2ZFd
	 y0S7Zqa4/ylrv1Yx63Og+eRHZ+dV3UBe5YhSWrSTbw+4XfTJGIUkVzzhhoO0cYMzdlNkq
	 As7Yvtdp519atwxh2sa8GI66SIR22iAx52gTbrfsZT0iM0mQv3tgkEJZvvNLkYWd27L79
	 +1ML/ps78rXQ6pzRz27ecJfDxJm1XYIl0QB04qYDn/5fp49LnzCB/cVxcOiuMG+qtow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=SNZ+lV3ZncyWD1SFmJ5HvchteqODnPDWJMqK/tNcvWk=;
	b=zVUo0v54ucBPhKbkCV07C6N/LEXME80AhYqiazTlt/4gDdtzEVafhosDkOTEwNQ4CGDK
	 U2gw9JZEialJzTjPJPmqj7VHTTTsJC8G6jOcIJHUfwwNYyWO5STAO1/iU2HQwgL3KvXHf
	 lq++IrL6c/4JczKc8KIeKiRHybgMmELRV8kYSWHURXeuTWr0Avt63rQSSe69IeQa/rBAv
	 fasd+4WcpG4YGFsm3xfn3XrOggVtyI0DS0RlFLmUZGZaM+NbNKNSTRjjDbxLkxrvAF3yS
	 A0QfRdOVXrsWh2tZ4pIxSYuY2v0RaF58elOOhDx7R2jttyFunC6uNZOM005yh9csHHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ydP04tB9;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2AC606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 16:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E2AC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ydP04tB9
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so537161fac.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793378480; x=1793983280; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SNZ+lV3ZncyWD1SFmJ5HvchteqODnPDWJMqK/tNcvWk=;
        b=ydP04tB98uZhe9VsQbinMXz1OOLplQ10j8EPMxWG7ynpiEjfP0HF4nBoEkdqhifKsM
         pclzj+vwLw1G987hjF7LwwO9wVzjDR5qUv9eojpPCMXdrFJ/UwV+c7ChSiokv2th8OSu
         vkOc0ZEeZ/bSZVFIX9c0Oojr97O9R2sThAMHYUjkpvp3uRljBO1YBGLpOvofReZLEwbR
         ACvgNdOjNDLVR472ZYfaOzvEHzJs31KWFEHzrcSvKnB5bJh9thVvDDarkoma+IXbyz7n
         DLtAwDmRAZcdZPXsBr+yl5uECco1B5fYVIxL7Xl3VikJIqxSCW1oZsUl/pmPNVmTv2Ya
         VoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793378480; x=1793983280;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SNZ+lV3ZncyWD1SFmJ5HvchteqODnPDWJMqK/tNcvWk=;
        b=zfx50/4zxCv2JN+okCQ3+LChaTj967JH25lzzKMqvNlvhjMmzlH8BMEF1ePplmH4Zu
         ycwMjBR9VBOuH4Xr0NfDhSVmzhkvLyDLsYy6Owna/8/kykjrT+tmzvACxOFxHyYIr6Hd
         qL0awy8DvPkZ4cGvFSup+mLM5W5n2NVHm8pPs+oGoVZeFENWXgvY6lRPDzJYd2ZN6dEs
         03L7iCKINZyaTwajZu1ifyRXp+0PnxdQezLiL/T0jkKw4ej7UfyqHw1LaeHqmMAT8dCj
         celDINM/hlNZeA9YeZrbAngnI9zP7UTJXYKIzdBymNGIHJQ1poBbHEy6Hs7+LIbHgDlZ
         kL2g==
X-Gm-Message-State: AFq9FYIlOdo1xVSLQ1CUVvP4fCtl/kGTMYMnq42lVAzevyu88lEgTktv
	NoD2bV+LbY/lm32aZ9If+lwdLQVwSP4T247qPZMJWZ4aOnB3QSIB+wUSTrknSw==
X-Gm-Gg: AYBFou0X0jEGDEBvxiT3RRzW2CMTH8ENVu/n44EMH1sFAKfl5aCJAsA6Arf7GrfD/gF
	tt518xZB+qF3HvU3KnVK2wSYuO/FQ0t9UcfVrEypCCbX9Orc7b5iwTnACtZSqoK87VaQjIPCfXI
	Jz+G8DlRAB4eTv0LRpqpQNKs7Y6LmdnTfALvN3y6yw5dch//rYnKdPc64JbUf0Hk0NLAOy2v1nx
	4uz3cYKOPa4Ab7Phl4uZnmy9N47EnnMjsTovKe5KZF3+Jx8wx7S4GtrDtc2vPKloKm+5KDshi0W
	Z7bEUXCZvadgdh6+8Lr8A5gkbVKHDaaWnCqLQFI7/8OcCqRXnmpKf7hvEoX4x//XCCUiDLEuwc6
	mBppRnRUIDAGLSKhgfQT2d01n2hzzjOm6B90J+ikR/ySYoYuHWcxQsW4ienaPyueIUNzRCUl6Uy
	HvMKHPS8+a3k1GuhlGaHTk58nwcMF14O+dGw8cqDqw6O2fFxn/gQ5YOWdR9qNJAMAKMCTYJ0kDd
	AhdNTf8z9AHtZ7fR8FGC+0YAEXMv4Z8UWDWbVOBhMyyZpgzzuFkEHJ5S5QV7B/Uow==
X-Received: by 2002:a05:6870:8092:b0:475:e2e9:4f4b with SMTP id 586e51a60fabf-4a9076b7448mr1757981fac.25.1793378480147;
        Fri, 30 Oct 2026 09:41:20 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.254.209])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a92196578fsm378948fac.7.2026.10.30.09.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:41:19 -0700 (PDT)
Message-ID: <6ae4c8af.f81d2e1b.37c053.3bd7@mx.google.com>
Date: Fri, 30 Oct 2026 09:41:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8444615772126969256=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: SMP: Serialize root channel updates
In-Reply-To: <pm-bluetooth-objects-candidate-0184-v7-c26e53b52c260063ab6a-1@gmail.com>
References: <pm-bluetooth-objects-candidate-0184-v7-c26e53b52c260063ab6a-1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8444615772126969256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1197223/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.92 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.57 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      26.32 seconds
CheckAllWarning               PASS      29.35 seconds
CheckSparse                   PASS      30.87 seconds
BuildKernel32                 PASS      26.63 seconds
CheckKernelLLVM               PASS      26.68 seconds
TestRunnerSetup               PASS      604.48 seconds
TestRunner_l2cap-tester       FAIL      12.24 seconds
TestRunner_iso-tester         PASS      9.92 seconds
TestRunner_bnep-tester        PASS      2.91 seconds
TestRunner_mgmt-tester        PASS      85.26 seconds
TestRunner_rfcomm-tester      PASS      4.15 seconds
TestRunner_sco-tester         PASS      5.23 seconds
TestRunner_ioctl-tester       PASS      4.34 seconds
TestRunner_mesh-tester        PASS      6.72 seconds
TestRunner_smp-tester         PASS      4.26 seconds
TestRunner_userchan-tester    PASS      2.92 seconds
TestRunner_6lowpan-tester     PASS      4.14 seconds
IncrementalBuild              PASS      26.88 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/2] Bluetooth: SMP: Serialize forced BR/EDR channel changes
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#176: 
    Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI

total: 0 errors, 1 warnings, 0 checks, 26 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14927653.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[2/2] Bluetooth: SMP: Serialize root channel replacement
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#281: 
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10c358

total: 0 errors, 1 warnings, 0 checks, 48 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14927654.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] Bluetooth: SMP: Serialize forced BR/EDR channel changes

53: B1 Line exceeds max length (116>80): "    Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI"
55: B1 Line exceeds max length (107>80): "    CPU: 1 UID: 0 PID: 497 Comm: kworker/u17:0 Not tainted 7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy)"
56: B1 Line exceeds max length (119>80): "    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014"
59: B1 Line exceeds max length (203>80): "    Code: c1 ea 03 80 3c 02 00 0f 85 70 01 00 00 4c 8b a5 a8 04 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 6d 01 00 00 4d 8b 64 24 08 4d 85 e4 74 19 e8 2b"
119: B1 Line exceeds max length (96>80): "    CPU: 1 UID: 0 PID: 493 Comm: sh Not tainted 7.2.0-rc6-pmb-bt-functional-v1+ #2 PREEMPT(lazy)"
120: B1 Line exceeds max length (119>80): "    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014"
147: B1 Line exceeds max length (203>80): "    Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff"
[2/2] Bluetooth: SMP: Serialize root channel replacement

59: B1 Line exceeds max length (125>80): "    CPU: 0 UID: 0 PID: 520 Comm: kworker/u17:0 Tainted: G        W           7.2.0-rc6-pmb-bt-functional-v1+ #6 PREEMPT(lazy)"
61: B1 Line exceeds max length (119>80): "    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014"
185: B1 Line exceeds max length (125>80): "    CPU: 0 UID: 0 PID: 500 Comm: kworker/u17:2 Tainted: G        W           7.2.0-rc6-pmb-bt-functional-v1+ #2 PREEMPT(lazy)"
187: B1 Line exceeds max length (119>80): "    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014"
299: B1 Line exceeds max length (94>80): "    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8881071f4e00 pfn:0x1071f4"
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==35==ERROR: AddressSanitizer: heap-use-after-free on address 0x7c24aa8e33d0 at pc 0x55dc41eebe8e bp 0x7ffd90feee80 sp 0x7ffd90feee70
READ of size 4 at 0x7c24aa8e33d0 thread T0
    #0 0x55dc41eebe8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x55dc41eecb75 in timeout_callback src/shared/mainloop.c:270
    #2 0x55dc41eedaa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x55dc41ef03fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x55dc41ef564b in tester_run src/shared/tester.c:1223
    #5 0x55dc41e1f17d in main tools/l2cap-tester.c:3918
    #6 0x7fe4ab80d600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7fe4ab80d717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x55dc41e25c84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7c24aa8e33d0 is located 0 bytes inside of 40-byte region [0x7c24aa8e33d0,0x7c24aa8e33f8)
freed by thread T0 here:
    #0 0x7fe4ac14b3ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x55dc41eec36a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7fe4ac14c60f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55dc41ed62d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1033

---
Regards,
Linux Bluetooth


--===============8444615772126969256==--
