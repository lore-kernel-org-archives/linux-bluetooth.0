Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920773;
	b=APFQvgMhL7cemxNQGt65PvtKjflxdfZTZ8jULzyqUK9I7RoYT9TEsgCSnEDMzkHh9Sp6
	 6Nk9f2fGcbvmy8+oeZhIVe8osUAFRDBp2Ox4S6CIi/9AqTdtsIOFElm7nIAA8HqeWncyZ
	 m9Yj4J62rGJXg5Mg4RYMt5U5kiC4wB3k7B7KzBlcnZBTeyqcIqW7VVXU8vAEw3DGdCVr+
	 MLr0yYmzQ91QJRBRB93EOHtR7PUYWaHOLNHBVCTgcLuTN357yE+GN112+9pmr36cIMS1z
	 HlfiDWVCk3mTMYYdZ3bIG9rb2bpXOyFIvgIg57vbib2s80DOWjGPKu4FaB08dLn/2rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=oCeD41lgv2N2xDhMARJ2dCJIGpotXLDHMun54r5XllM=;
	b=uB0YEA5DE1kT9Si9t3PV0Nlx3olslvd7JmVBymHqtTrwtQmKND9lVAHTjvAB3iMLBYoy
	 vLOhTl5IuYjniBIL3dPPGOUaYKFJpfL3aAlFlBMBkPC75rF8OSDWyhwhWaqttSlJrD7B0
	 FFy0KroOddTvQtSTcSTZhwOMSSSmdGp65ocG1KjhveB1Ay6X7IePyyyXXW1COmkoWjlG1
	 HjpZfksNFV8FPE3W6mxId3o/USPeByrOCdgOjuGI+Jd7oqm9CA/exsvBtV91fKRfJjpPY
	 L3xBdAo6daukrwCWTMefAhOJLs23WihEF+2C3X/w+cQSyakE3cpDUOS8oLSDc/cOGdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdgAXk+Q;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59231606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 23:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59231606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdgAXk+Q
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso73236eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 15:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793920772; x=1794525572; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oCeD41lgv2N2xDhMARJ2dCJIGpotXLDHMun54r5XllM=;
        b=xdgAXk+QjMetczu24+3wJdQcN/fQn2aQ/WaN4Oe0R0F/DcDep7KZVCvPU5dEoqhtXN
         QLYnW3sI51Hc9D7Tl/fmQMNN+bukfyuB4mp8EDdYJtpAMQkvTIQvzu255OKbtZrYbs7c
         jM81V3z8JFrNhrWPw5u2Abgrbd3Oe8wOij0H4fqFZZv1RHAzW8YhmHIMhH4lB5IBkhEp
         LD4QIMgZ77eaH/zBuhEDzXASc/3e76hQzJkn8PNe1lfX0R/3wLHhI4oc4VnDOOfWYdK1
         /RCnEFCCi+hxHmcUST3fOoOM/4euDje7SJyxoQrw6YIdsY4TKpmi26bDouSmcusSErKP
         ocEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920772; x=1794525572;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oCeD41lgv2N2xDhMARJ2dCJIGpotXLDHMun54r5XllM=;
        b=AbRGKnT1lwu9/m2ZngbTPLvvX8cAc42/wuba2R9tQ2HcuWJucMntWr6f2uhQBJFJHC
         wk9C+OdJduWacX86DdiJL1LXl7iHYBqLPTpqAC5YFtkWbCIVNnr89apwUGCdcz27vaYo
         eOvvxcCGJ/1NGZtdLfwmbxVQSTzuivCNolXuVaBwkN23S4npZUI2a95aBU8uynm/hCLQ
         QVoMoaV29PUrWrN8i8qHwL/tu+hsfmYUSH61p0hvvCfozo8EL49C9Ud3rRiMwQccsXyO
         qanuw49NQEKYZGG0S1YGfmQJ9VW4poaek+7z33l3A6s8q3jGm4EOOGNVt0lItcom1cfq
         f4+w==
X-Gm-Message-State: APuU4Z/bWIbJqU4NScD5UQYfpVg4NmTZuxQ38gqNZhVR9B+qBHXqgWdk
	f1CB1rrLtCfjwSWMogxJwfamQCkFGdlCNPOEzvoZrVFlTbDY4Lr9cRkmN6RUFg==
X-Gm-Gg: AYBFou3IR7yLizFzN+6hJLpQjdbn5W3xXFaa47FqXHKQH7Tr8CMSpBMwxDQ62yAooi8
	jocWz3szoxMj+A/BE79y/VYnG0CIe8IdtPRmWXTAkA3YYq2IQdIAMKosrxsvznv5BTumTOBqrEq
	TzkogQrwojN1WwMAunBQtpjUyeRmKTiM4JTue3F1wg1u2PMXBYEgBTp2SFeaGyjgfmm9ZQ24+pG
	TpQazlGLExKdcDAiXz8CQUIHcrN6KS3VPruwRn6mSYZ8OCS0RJOFr9GuNNNmfBOZPrWxxuV8oFN
	N/+Qk6rSoLFVflBQXL4EN8Gy7KG0Sx6DzafZt9ZXPEJ7Xv6rnIX/fvIZyMpprMrnDnFBNsn3lEB
	alwJhXUhd2wrH/oCmJJ0cDS/b8p+qQBBRjmDcqPrHvIMSw0sgekUTDgAU6evCiQOgBLs0E7YPfI
	wH8zcd9j23L4nkseIciQ9i2gFmW/tX1z67Ok64gif3eRsQlGnR7cBsYfyJcw5pRGNJAOCejyhx0
	sIVvzyh3/gpDmbEVC0YdVhnkkk2x4lUd8UMoKVqTwfUvX3zbPR30eua6O2szxw=
X-Received: by 2002:a05:693c:66c1:10b0:36c:9d4c:6465 with SMTP id 5a478bee46e88-36f76225d27mr803620eec.24.1793920771952;
        Thu, 05 Nov 2026 15:19:31 -0800 (PST)
Received: from [172.17.0.2] ([52.155.45.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa4b7404sm386919eec.24.2026.11.05.15.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 15:19:31 -0800 (PST)
Message-ID: <6aed0f03.78c6c619.11c6ab.4fac@mx.google.com>
Date: Thu, 05 Nov 2026 15:19:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6190017017170735431=="
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
In-Reply-To: <20261105205056.2218652-2-luiz.dentz@gmail.com>
References: <20261105205056.2218652-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6190017017170735431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1203536/

---Test result---

Test Summary:
CheckPatch                    PASS      15.22 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      1.50 seconds
SubjectPrefix                 PASS      0.40 seconds
BuildKernel                   PASS      31.68 seconds
CheckAllWarning               PASS      35.58 seconds
CheckSparse                   WARNING   38.60 seconds
BuildKernel32                 PASS      31.93 seconds
CheckKernelLLVM               PASS      33.16 seconds
TestRunnerSetup               PASS      758.96 seconds
TestRunner_l2cap-tester       FAIL      10.68 seconds
TestRunner_iso-tester         PASS      14.78 seconds
TestRunner_bnep-tester        PASS      3.13 seconds
TestRunner_mgmt-tester        PASS      88.48 seconds
TestRunner_rfcomm-tester      PASS      4.47 seconds
TestRunner_sco-tester         PASS      5.65 seconds
TestRunner_ioctl-tester       PASS      4.66 seconds
TestRunner_mesh-tester        PASS      5.57 seconds
TestRunner_smp-tester         PASS      4.80 seconds
TestRunner_userchan-tester    PASS      9.20 seconds
TestRunner_6lowpan-tester     PASS      4.51 seconds
IncrementalBuild              PASS      131.11 seconds

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
==37==ERROR: AddressSanitizer: heap-use-after-free on address 0x7ba92b6e33d0 at pc 0x5597e9b15eee bp 0x7ffe1e100760 sp 0x7ffe1e100750
READ of size 4 at 0x7ba92b6e33d0 thread T0
    #0 0x5597e9b15eed in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x5597e9b16ed5 in timeout_callback src/shared/mainloop.c:271
    #2 0x5597e9b18006 in mainloop_run src/shared/mainloop.c:125
    #3 0x5597e9b1a96a in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x5597e9b1fc4b in tester_run src/shared/tester.c:1297
    #5 0x5597e9a491dd in main tools/l2cap-tester.c:3918
    #6 0x7f692c614600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f692c614717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x5597e9a4fce4 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16dce4) (BuildId: 0d2067a7ef8fe61fcf622598953c7d0f996221a0)

0x7ba92b6e33d0 is located 0 bytes inside of 40-byte region [0x7ba92b6e33d0,0x7ba92b6e33f8)
freed by thread T0 here:
    #0 0x7f692cf523ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x5597e9b163ca in timeout_destroy src/shared/mainloop.c:252

previously allocated by thread T0 here:
    #0 0x7f692cf5360f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x5597e9b00335 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1074

---
Regards,
Linux Bluetooth


--===============6190017017170735431==--
