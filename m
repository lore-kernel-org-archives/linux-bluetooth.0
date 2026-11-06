Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793935570;
	b=QAvrPuhGLTx29BYXQ1nE+f6SbvLvLhEVWMoyI7YGEIP4PXoqwyvF++R1+IvrXMwI+OjK
	 2jOlVc+oEQ0p2ODLHqxnq5ifAqe1B4z9QhNRTCfVr47qPtChdFB2dSVNazUBnSW+xWxLz
	 NFfQpHkew2cris0QHvjfDpUl1iFjkl7kPkiDL+1Cg5QM5s+fyK73kqCC7ZrJ9yCMy3Xbs
	 mxqzQ4IMVzdHKDVzgehG3l2kYnvFM3gHWbcRVEv98M7kDKf2l9mR5qKKsXDFrLFUcKIBe
	 +AOkzEKM0MRoy9QtqmQJCD7NqdCdsqt8bL4G8YMu31f1Dl/ooDMPa75E5wsWIYnaEag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=8RF0Ngy8I8iIsQFGGXYdFJ8eOXPnmdpQBXjWtB1N60E=;
	b=ekpFz9QfcHFJKf8ffz+BnnFofpFeeybm9mVNhbWpsXiJDOfHW23U6mcLXLFd92PcEiO7
	 oMYmJxfTw8ogAOBOhJo6mFS7PYorNmZyZX3twfyKMqlZkAg/Sju0OIPoMaybGKzGWNEq8
	 lwcpR3dYnsberjjaR3bqUHEFoUk0ZPWY1lTco5nhHW5zaAW1ETBhG8QRwpdRVQZ/EKHVb
	 fAoAYkQnGhq4/8GmyYdDcviIyDjTerLpYkSB2W5Hoq4iDuLWUMgzflr1KYElXQ4mm05jQ
	 M8hI6wiyW58Vurqvu8DaTdSZHceNNDkxKj5iLK1WBJoJ1mt46bG996fuzvjvL/qDBzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="C/7myzjB";
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B0606A329
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 03:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 468B0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C/7myzjB
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93a40a9a01aso158731385a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 19:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793935569; x=1794540369; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8RF0Ngy8I8iIsQFGGXYdFJ8eOXPnmdpQBXjWtB1N60E=;
        b=C/7myzjBV5MprUunnLYVppR3gvzQLFh6c3qXcMsvm7BH9xXsRdThuC67oMFPFsYIjl
         0LY973phKGk8u8vL32dnxafSjIKrMZF+e5Pjj6vRN063Bytv0+uML4cXUTw4u4SzLDMs
         Io7ojR/x3N+v7aJpkcsAilgwNfqKvfEz9UaaJdRPnUuzH/K0kYR0n1bczKMyb8KgHVQY
         o0hyF+jZuNf7u9y+Ke+MlhB0kwpon+mXYp/WZNzOJ3W9sNXkY0haoHOZ01kvOvQ5DDYJ
         N53pxpwGI4o5TXwEh/TzVPAhlgb2LmSaBypUyNYfc/Oeq3C3f/q964+Z3vuCyXTu5my3
         C3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793935569; x=1794540369;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8RF0Ngy8I8iIsQFGGXYdFJ8eOXPnmdpQBXjWtB1N60E=;
        b=jWcYD760d/LCl7/L5NiheFYw9HnYAYtYA3XsEuv5TTyLAW1xleut7ZvumjtB9vVQjC
         hBHkkcl80sM0TLa1k1QCzQEmkR8Fd0rcaOThTO49TcT+HgK/EU09fIT0UcsV6Hyr4EUj
         R6Thyr0H53nxTO85AZRlRRUUxBxVMY1fBk03RGcoiF0Is3aH7yzmLDB29V9mK0PuT1pJ
         S6Z6zfrEAhHQqMeu47/iN/Z1BpgftW03a+3jSLHrpJyjjvrl/czbSO24g6yVQVEBpR2M
         RMeOZXDbsEVd649EjNdOuqRj6b32xjnueFjC8t7OA7XHESOCnKSY2JpVxfBGaElHaZMK
         NvQw==
X-Gm-Message-State: APuU4Z8NLsgJca2HtotRPTF6yU/wX/SOAMK4uD0epPHnrLWXkWXHfKGy
	1tNktrMj/WGY3vZMixQTSxittaA1Cz9eq9n5QZpXiLTVkwnTHlDayaErxVVNAQ==
X-Gm-Gg: AYBFou37kPnANCua0ks0yTB3QnJaDYv7fDwGXRV7Kb8wsk67xmzP+zpIqecqzxzo7fh
	PG1+B/03RpynnVpDpspudmwhXgVvSb7ndqgxqUOZPspkBm6YmI69AlME9mM21ob8NRYn4SnoFib
	XLHJNk9UQviRuBzaMyWvNLj4LLKFfVVPe9VT8X3CI7ZSiO1CaAfp+S9pD/Y6zTifC2A4EJSaynv
	kqjszW1sAabRoH8KWGPzoThQGqPRDiVH67UewQMrkALKhbwCqwnP5sMvlSJyGewGK7f81M9ACFF
	P2J0V9NB3KOEwszGzPoeMp3cVQGjPiVcg8sxjwqNNU8vEa4ewpc8BqOo4I3FV/mFaMTEGAMEryb
	IC9rhfZCiGbkYq6JuDGYzmS3vLaefEIbLYQgagOUQ4YdbZtcN5KCISfUPjFUIIlMix1eQgSJ1j7
	Hcf88kKLfVYNOt87T8fNS5pm/N9Y2p419fh0AVxBZ4Ro6LVOLPbruCjjGYl81WPgYfhcegNiQsG
	npLOH4BXLLeHnhsLpHxXQh0RjrDud1Caq5RREQc5sfKYYk5P11TrVkSD6aUCswo
X-Received: by 2002:a05:620a:4044:b0:93f:8f9:7a83 with SMTP id af79cd13be357-945e17fde02mr758163085a.43.1793935569008;
        Thu, 05 Nov 2026 19:26:09 -0800 (PST)
Received: from [172.17.0.2] ([172.208.62.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f5bfc57asm42577585a.31.2026.11.05.19.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:26:08 -0800 (PST)
Message-ID: <6aed48d0.27a8fa0c.ab8a3.c92a@mx.google.com>
Date: Thu, 05 Nov 2026 19:26:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0476574425823349171=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [1/1] Bluetooth: reject invalid LE supervision timeout relationships
In-Reply-To: <20261106021809.631456-1-cochcoder@proton.me>
References: <20261106021809.631456-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0476574425823349171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1203685/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.38 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      4.33 seconds
GitLint                       PASS      2.87 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      42.30 seconds
CheckAllWarning               PASS      36.61 seconds
CheckSparse                   PASS      39.09 seconds
BuildKernel32                 PASS      34.96 seconds
CheckKernelLLVM               PASS      35.11 seconds
TestRunnerSetup               PASS      755.31 seconds
TestRunner_l2cap-tester       FAIL      10.73 seconds
TestRunner_iso-tester         PASS      11.05 seconds
TestRunner_bnep-tester        PASS      3.24 seconds
TestRunner_mgmt-tester        PASS      89.13 seconds
TestRunner_rfcomm-tester      PASS      4.73 seconds
TestRunner_sco-tester         PASS      5.73 seconds
TestRunner_ioctl-tester       PASS      4.75 seconds
TestRunner_mesh-tester        PASS      5.63 seconds
TestRunner_smp-tester         PASS      4.43 seconds
TestRunner_userchan-tester    PASS      3.44 seconds
TestRunner_6lowpan-tester     PASS      4.90 seconds
IncrementalBuild              PASS      29.31 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: reject invalid LE supervision timeout relationships
WARNING: Non-standard signature: Assisted-by:
#99: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#99: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 30 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14955884.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==35==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b7dc18e33d0 at pc 0x560bc1481eee bp 0x7fff2ba55e70 sp 0x7fff2ba55e60
READ of size 4 at 0x7b7dc18e33d0 thread T0
    #0 0x560bc1481eed in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x560bc1482ed5 in timeout_callback src/shared/mainloop.c:271
    #2 0x560bc1484006 in mainloop_run src/shared/mainloop.c:125
    #3 0x560bc148696a in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x560bc148bc4b in tester_run src/shared/tester.c:1297
    #5 0x560bc13b51dd in main tools/l2cap-tester.c:3918
    #6 0x7f3dc27ec600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f3dc27ec717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x560bc13bbce4 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16dce4) (BuildId: 0d2067a7ef8fe61fcf622598953c7d0f996221a0)

0x7b7dc18e33d0 is located 0 bytes inside of 40-byte region [0x7b7dc18e33d0,0x7b7dc18e33f8)
freed by thread T0 here:
    #0 0x7f3dc312a3ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x560bc14823ca in timeout_destroy src/shared/mainloop.c:252

previously allocated by thread T0 here:
    #0 0x7f3dc312b60f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x560bc146c335 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1076

---
Regards,
Linux Bluetooth


--===============0476574425823349171==--
