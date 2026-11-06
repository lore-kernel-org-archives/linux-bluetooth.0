Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987064;
	b=5eevv75qiXH8KTDlUd88vqlNQRl62reAsYppgWO/VNEiMggJeT5pvZaMi5j4UsMEf73T
	 coDx+ALzQEO0OSoqurmz2qkLGpey4pXFYv0NeW90d6BYzTa9Waa+DH8Bg136ZoTTWGXQk
	 1MntmNAho7a0OF3I9HRpfiKcFRLPsFL9zZlGShGcf/WGcOrqCLmZyB0mKOcoFEp+fpcsp
	 LNKBqbS3wPn2N+dlm7GDhWbi2jwmOhpCl9xPQEITg1eEFkt7b1763EX+S8Niw6CGf44Zw
	 CnqOquDmK87fv1piNp6LHp8iv29Joio4DjABKyK3IIaOFFlL1TPb1mGVRl7+McMmlRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Mu5QfYxdfYxdLzuAXHRb6THoTDe0uwdMglAntipJqEM=;
	b=U6CIORyuGzcIS56xCrjIdr7DUYGBlaXoKfdB9Fi2hyZbBHdxSeVdBxslGEj6XzjPRaa3
	 CcTLtShHcqe18O6mPSHwkViQZDafo42Itwpkrt0ZPsVNZi5MTfsGRdvSWafs6+R6qptBI
	 kyvkHGu/mrd0qTc4t+UZgzSC+YB41pwWHfzrtm/dhB0Nco1f5Gi9E+EZiGCVMP64WebOd
	 Qk6dJ8URyeA3Z/BEmSkd1hgz52NtE2Ls6GI+/MJMPsi1Q6nxjw/yu1ebhb8w1O+0m9Mk5
	 4sGj8rGWwWj0SFBubxbkwijm9c7htgJFzIsC+K8ApB+aivYTgpT5mlwc5JhTk71/Hug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=knVhfwyO;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F23606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 17:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12F23606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=knVhfwyO
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43bf9548df4so766528fac.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 09:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793987063; x=1794591863; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mu5QfYxdfYxdLzuAXHRb6THoTDe0uwdMglAntipJqEM=;
        b=knVhfwyOQIw1JV7A/DhZcLKyyuQirhBMHSXcjghh9QlQjbF1M6Acl1gLW1mNWwfN/D
         V/lUMm1kbOUVcETizBry4m60neFnCOiSG54rdIw1me+JD4XACEa9tIno/iqwm9KMLBbW
         FHu1lfQ9Ot9ev1BRKiRgPXqFEajo1JBDYv9pM6cfoOPfOnZhFZPhIAoJH9tMIqsiYJ77
         hq7t5wQh2ONYLi8tLu1m8l6+AL5sBH8PeptWu7TZQZzl4WSwX0PXitKny9QONo/FW42W
         hMBBGoaiulKYCKRnFLOklDnSXadK9VVenTqqliHk16d6BPS1FXYjvXPl75OCPDZoYa0u
         hhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987063; x=1794591863;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mu5QfYxdfYxdLzuAXHRb6THoTDe0uwdMglAntipJqEM=;
        b=HeUCFzQHA39Q2Nm8ZIe8NuvsADzzkuWif1zbag3nWrZeQZ8zx13QfQG2n/1IEs+nps
         kHGHj9FlQ6iXjm2CmsHY3ZHFlrjci2kAApFz3kJAUKiXD3XF6Fh8f45iWImEBZFdnf7z
         SEq4p45lNiC55nTENCsmMCKvBWf4gGKbGoskIAUxRyejy1ucTg5zSWQmoQj8X4bokpQ0
         +mV0C9SCv0d8FpRNVBI6C6Gz5e1luotLVB5JcbZiiTj/DU2oDiEZGALL/YG6yRPcHsPs
         Jq28BXPTDsNkjnwjOa0GSPshX4KVmES3I4R6sXPvp5i+t7+PVaaNPdv07V3yNKBxqxIb
         LrMw==
X-Gm-Message-State: APuU4Z/mUHi0vPEatcKSmCRiOh2FFVlymZfkMAwjmzh9ZSapcOp859at
	r0DKpdvFgu6NWMR4IorFq/i1hHGEH/ndqMZwrsHL9V5XlFTJg9cCn2I4QVksGA==
X-Gm-Gg: AYBFou1oMGWiu5wsKhLUsbqjhEhXMzHBX1h/g9nxhYaAiBwlq6dWizANnnqNKN7MRo7
	npMCN1gUc3hykiJ5HntR3a4ksvRaOJY3ci+YTOB9UOkptXDWS6cjea2tpj6CzYNT8/raf4daw0d
	4RMuRJzEja2weRV5SezQr+dk1UWGkASJ5Bo45Hh/iPTRzJF38f2NwDxO7JwKrgfOEexuCJv69oi
	tNEjSVBasisI17MvFSCdXnjA24vjEgDMbKXqO0xIYwPmAexW5KLC2Yb1BwuGn0qDVlkIcwlrzD9
	25KJQL5zeMvOJ9Jh7JQXP378g2tWWVNVdHYzdDUJj+2Te42/F9PE4p+r1O01+5Ihjgd65fRJWws
	rlTT9LBhM8QTt4wAWt+ZFos0XY8Fgd0+Jo3uqMEvPgaUoTMWod7r3p/vzWmagOugfHuCQLME+Td
	MCKci0HUp20GHZBZ5wbvP2IbCb9C3PUF7FCItLH21/FtQiIE6cedXZfUyQie5ve75pcG9rMdw0+
	f41ngy/K4EzuSkslHx0hkSrli/NvOeD1Od29Ysbih6HHt4F1xo/NengbTisAm0IbP/v82VCI1lx
	vnHom4hb
X-Received: by 2002:a05:6871:3865:b0:4a7:4c9a:f458 with SMTP id 586e51a60fabf-4ad98c4d39dmr2236218fac.60.1793987062830;
        Fri, 06 Nov 2026 09:44:22 -0800 (PST)
Received: from [172.17.0.2] ([52.252.244.41])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ad9704a81bsm2548650fac.0.2026.11.06.09.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:44:22 -0800 (PST)
Message-ID: <6aee11f6.36cccf01.28f85.c2e4@mx.google.com>
Date: Fri, 06 Nov 2026 09:44:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6499492785281622777=="
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
In-Reply-To: <20261106161227.2814291-2-luiz.dentz@gmail.com>
References: <20261106161227.2814291-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6499492785281622777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1204338/

---Test result---

Test Summary:
CheckPatch                    PASS      10.71 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      1.66 seconds
SubjectPrefix                 PASS      0.66 seconds
BuildKernel                   PASS      20.45 seconds
CheckAllWarning               PASS      24.32 seconds
CheckSparse                   WARNING   24.73 seconds
BuildKernel32                 PASS      20.25 seconds
CheckKernelLLVM               PASS      20.67 seconds
TestRunnerSetup               PASS      455.37 seconds
TestRunner_l2cap-tester       FAIL      11.76 seconds
TestRunner_iso-tester         PASS      9.13 seconds
TestRunner_bnep-tester        PASS      2.82 seconds
TestRunner_mgmt-tester        PASS      82.14 seconds
TestRunner_rfcomm-tester      PASS      4.00 seconds
TestRunner_sco-tester         PASS      4.99 seconds
TestRunner_ioctl-tester       PASS      6.55 seconds
TestRunner_mesh-tester        PASS      5.08 seconds
TestRunner_smp-tester         PASS      3.94 seconds
TestRunner_userchan-tester    PASS      2.82 seconds
TestRunner_6lowpan-tester     PASS      4.01 seconds
IncrementalBuild              PASS      81.52 seconds

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
==37==ERROR: AddressSanitizer: heap-use-after-free on address 0x7bbd699e33d0 at pc 0x55bef042ceee bp 0x7ffdd0fd6870 sp 0x7ffdd0fd6860
READ of size 4 at 0x7bbd699e33d0 thread T0
    #0 0x55bef042ceed in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x55bef042ded5 in timeout_callback src/shared/mainloop.c:271
    #2 0x55bef042f006 in mainloop_run src/shared/mainloop.c:125
    #3 0x55bef043196a in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x55bef0436c4b in tester_run src/shared/tester.c:1297
    #5 0x55bef03601dd in main tools/l2cap-tester.c:3918
    #6 0x7f7d6a9ba600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f7d6a9ba717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x55bef0366ce4 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16dce4) (BuildId: 0d2067a7ef8fe61fcf622598953c7d0f996221a0)

0x7bbd699e33d0 is located 0 bytes inside of 40-byte region [0x7bbd699e33d0,0x7bbd699e33f8)
freed by thread T0 here:
    #0 0x7f7d6b2f83ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x55bef042d3ca in timeout_destroy src/shared/mainloop.c:252

previously allocated by thread T0 here:
    #0 0x7f7d6b2f960f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55bef0417335 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1079

---
Regards,
Linux Bluetooth


--===============6499492785281622777==--
