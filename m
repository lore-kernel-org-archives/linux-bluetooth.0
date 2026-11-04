Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793831156;
	b=1CeLKHCFO4CO8WvTKd+6Fx51wXKYBj3EM4CerEnABvHpvfqcCW6ZToe/ys+toKCksmoQ
	 1iniLXXkLT0bXh5Rz4HukC5B/EcSUEZ+hkJpEfwees4YUrIkNFJ72qOum72yrCFHZnFYc
	 hcemL0qJ2DYbGmT74k6EQa30dAY3GDb7AP693Z44f+6VSRS1wT95jFDMmyZMYNdArw8ZM
	 tTDIzJgVGy1pp7lGlFvdhVnmaPhKr2Kf7hPQ8lmiY0gpsFepPTb9FK9A2Rp6ei+xazQ7/
	 uo2XDvJFD/y+vsBChDkOuRcxJjfNWcw4CO1IOvMQxeErCnOUrHj3YoJy+ceax+S8uzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=MNLn7J3Iy6tkwdAyYpDE8Ay+FYlX2h/UDjRuMU0NCqY=;
	b=03Cx9hcUmZd4LuGt37nCBmu4prXAEbP6rf7U3XO4wObbGC/WjXs5L9DUn8v6MgWUJxNs
	 /uk0JlTcXf5uuitlucAvbsyAZ5XwdfCDegJAjenNO5OtxCsRBC0j8aeRFtKioDlJQ9Y6D
	 MaispUp+geSmsw3i2B79VCdvgQF0L8asjSqagnatVIwDmm8eKCM/GzZ7j7M1rFYlZvLd5
	 3pz5gasduQz8dD+1MhQ/pHh9LNvnwzyjttxzPNWuV9h6DcI8eFW67Pr4PrUFf5nZbT3Rx
	 ptSQrxdUEiVpHsYo6ODjbCVEgbzvE2yoIAvgu2vqbIbkQVIG5pwGwZLWVPtm9Kp9nRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S6Z2d6O8;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93B606D81A
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 22:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F93B606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S6Z2d6O8
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a2af4c8d00so2711444c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 14:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793831156; x=1794435956; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MNLn7J3Iy6tkwdAyYpDE8Ay+FYlX2h/UDjRuMU0NCqY=;
        b=S6Z2d6O8zs8ZlbLqSLWYg6BPu/d0t1kmzwWIf+zZ6FUwHief9Q/zGu0nuQyx/B7nfT
         YpBQVQf1se2EbnflMizlyvKAz2GT836hGEKGwdNEVS3bq+uF1HgrUvdDSyVByj6KqYl9
         ROVaK8CPmxT7w85NwtQrqfhNLOovzpWTQL2zPJXdO6K6vu6ll5MLlRZfKjQF3l4gVcEU
         VjrLqEIQ2FxComtjpt4zdN3wuqXQ80moEoY/YBA3K0zZffzYsHM4Pn+oeSDmJzmwOviE
         nJBdTh/xkpU+NhHDkLe1Twe34L8xxBIJUKB7t8h3ZGHjzD5gnU2an9k5AuRj/EleOjdm
         +m/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793831156; x=1794435956;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MNLn7J3Iy6tkwdAyYpDE8Ay+FYlX2h/UDjRuMU0NCqY=;
        b=FX0ARuxUWjCxCYTR7xg5rngo1tV+RIfNxcesYPFl43oqv7+M48XfMKCDOrZonK3FVX
         /nRNVB73dOF9NweRXo8sIa9uVlX687a+bpGO5O3J2cH6kbNpsrGpbb3THe04GwUfTmC+
         rUXcsNXbNuxC6V5006me7AwOTWLYdDO9BgbWsHNWwPByaHwIAgKhfgJnNFKs7c0J54Nh
         SaKAz9mVZuanYpR69HBBj+fmQivdrvKUuaXTJXrPx/xWGzJNsZ/7IMBnGX6JFmq0K/FO
         wrAnaEtyyuUBjHbZNfwZbb1cd7+UjsowXDOfXat3YP29v7gqx+xv5yZ7/uQxCAO/mHA2
         pj5g==
X-Gm-Message-State: APuU4Z9HNn9A8EBVISgz6/iNRYmhbUloIqDDq9/GterGihQAsfxgOqhv
	SsMVXIaOd3HWYUTQjZYbO20E7nPbYrNDzitY7NNXw9+6HJ4rKrUvhSk7mBa7vQ==
X-Gm-Gg: AYBFou1GmQ3ronKRkJ0PGBJpu9tsO/crLtoFSOd2wAGzrgoCbpFs5xPbmydQe1CUn8I
	eQrH0+tniPvLGIWsCu8nmmTB3M8mxnwrKIukpchWh+6N5J5r51RjcSqJGyA+1gfLd7lIq8+y74w
	/g0wTc4194SEAZ590dKDpZLPG6K44cxr/tph+eePyjOu4Wu/n/Ve9QZIhVRdDTlB9zNWSP9Pkfu
	pd/kCFKm/YgLlTpGV/KFTooCT4cVW1q3WHxazE7nCzjKZRBfzc+f/YOsWPUVmOMFq09WxkMkBBf
	/ezTvOy8MjRCW/vlxpbeaDmoSxbRVyImOVoL4Uo/AkL7/lbZ4wpS7sOeGlp3oM/fIbWzWaCsb3n
	sKQVw/Y2IZbkQs3AfnjQq9CqJoq1BMC24+fOj6yDqzgXZ+Ee5/Dc3jtE1qU5nTnwo/yZTKQ+8zc
	7lghq0H9sqNk2aEi23J4zoaaXe0/nXv7RG6Co+qIvvxKUFR7KI1xVgiHVglLbFW1u7QcNOHPDPK
	ba2Rb2r0Vkgn5W6NugWs/u9JjO/gHleGN02kkOMShGDNZeYYYqchKqUOqCpkw==
X-Received: by 2002:a05:7022:1117:b0:195:49ee:94c7 with SMTP id a92af1059eb24-1ac5a0b579emr23023609c88.8.1793831155386;
        Wed, 04 Nov 2026 14:25:55 -0800 (PST)
Received: from [172.17.0.2] ([52.161.51.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c748eesm10533370c88.23.2026.11.04.14.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:25:54 -0800 (PST)
Message-ID: <6aebb0f2.e8a50b02.2bf656.39b0@mx.google.com>
Date: Wed, 04 Nov 2026 14:25:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6491893918527572898=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: Add support for HDT and EKS
In-Reply-To: <20261104183626.838825-2-luiz.dentz@gmail.com>
References: <20261104183626.838825-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6491893918527572898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1202166/

---Test result---

Test Summary:
CheckPatch                    PASS      11.82 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      1.45 seconds
SubjectPrefix                 PASS      0.50 seconds
BuildKernel                   PASS      23.62 seconds
CheckAllWarning               PASS      26.76 seconds
CheckSparse                   WARNING   29.42 seconds
BuildKernel32                 PASS      23.60 seconds
CheckKernelLLVM               PASS      24.49 seconds
TestRunnerSetup               PASS      550.35 seconds
TestRunner_l2cap-tester       FAIL      11.84 seconds
TestRunner_iso-tester         PASS      11.55 seconds
TestRunner_bnep-tester        PASS      2.92 seconds
TestRunner_mgmt-tester        PASS      84.37 seconds
TestRunner_rfcomm-tester      PASS      4.09 seconds
TestRunner_sco-tester         PASS      5.18 seconds
TestRunner_ioctl-tester       PASS      4.28 seconds
TestRunner_mesh-tester        PASS      5.15 seconds
TestRunner_smp-tester         PASS      4.03 seconds
TestRunner_userchan-tester    PASS      2.96 seconds
TestRunner_6lowpan-tester     PASS      4.08 seconds
IncrementalBuild              PASS      129.25 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==37==ERROR: AddressSanitizer: heap-use-after-free on address 0x7be44abe33d0 at pc 0x55b3402a4eee bp 0x7ffe04f85de0 sp 0x7ffe04f85dd0
READ of size 4 at 0x7be44abe33d0 thread T0
    #0 0x55b3402a4eed in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x55b3402a5ed5 in timeout_callback src/shared/mainloop.c:271
    #2 0x55b3402a7006 in mainloop_run src/shared/mainloop.c:125
    #3 0x55b3402a996a in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x55b3402aec4b in tester_run src/shared/tester.c:1297
    #5 0x55b3401d81dd in main tools/l2cap-tester.c:3918
    #6 0x7fa44bb91600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7fa44bb91717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x55b3401dece4 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16dce4) (BuildId: 4b6cbb2e2c80ac13520eedc70b7cea5c676c63f3)

0x7be44abe33d0 is located 0 bytes inside of 40-byte region [0x7be44abe33d0,0x7be44abe33f8)
freed by thread T0 here:
    #0 0x7fa44c4cf3ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x55b3402a53ca in timeout_destroy src/shared/mainloop.c:252

previously allocated by thread T0 here:
    #0 0x7fa44c4d060f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55b34028f335 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1066

---
Regards,
Linux Bluetooth


--===============6491893918527572898==--
