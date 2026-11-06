Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793935074;
	b=Tf2lLJ2r/u7Cx15gdZ8BWpYjVTUxghtARMluanvHM9gmM3XMTW6sFtPdSklR/XG4o+3A
	 iTMsY63iGWhI8ZDz68g0jhT5AJP7vBOYzcP6FwjIMjBt4/wuIEjwNg9maXIch0YbQJsc+
	 1xTyuxuG3V7WO18++2RZZhfDEBjZ5HPxN5ZHXCxdlmf/1MlI0sabbedBQVWuoJ1Sv+x+O
	 Cv27VUrMfeN0ldlS+jJjHYDXc89SuaVqy5zEaLHWvvbaE/AKwnezh3mWS0b7fvbinWmcw
	 z977/Ug9GqOwv4u0TmJcEgjduNZKnBlyD24TkbWxdMBA5A+AWycowiRE2h6muo/Ps8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=4ISzBsIN/tegznly1nTglil5ZB1s0lfNnKiKhQqBrE4=;
	b=w1nliVhlKGKe+IxJRCiu0yHN3drJZsWofU7gWLbComFD9xpIOYpZtitd0Rs1C2K8oGvq
	 SKAVd71R89MMIwUPlPh9W9kVolY/VAqf9VjYfil3yLWFUUaVWRW2k2HMPd7rPtXJuG18L
	 jzlV8APHN0eDvFGL2o4yAOTX7ODdQwc04bZEEzkRaHh09AqUhRyh4JoBaAb4tSpKpV5Me
	 n8SdG2F8LeIO0o35e69a+sfsiFw7zV1DWhy1UPnYF2pH2ppCtEfOI3ixtkCFKLBlZP+X6
	 3MnLdVRJRR1RhEpZAoOHxK8xiCuNAD/ALTZQGwmnzAnCjHFWJBdJkf+kpHQ50rdjm3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SD0vyDBN;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11019606A332
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 03:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11019606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SD0vyDBN
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a064fac8cbso134597b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 19:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793935073; x=1794539873; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4ISzBsIN/tegznly1nTglil5ZB1s0lfNnKiKhQqBrE4=;
        b=SD0vyDBNNwvAnQjle5RZaEAx15/+eLJdMGwVCapMddnlVTBZDl5YlL7a6BMeedIWMu
         Uh7OgSoXMjwlftfXYToJKWioaOoEWZ6UBBPQuXOTx3XTjeUDvPO/hS3lbFk/ph4GnIbm
         oqbK2Trx3KboFNKhBv5WRxb73yCkRJZqArUdcwlQ+L8RZNfYfUWj/3zdRWYoxGw0YCwD
         Hd+VBSHe7Rm/dS15sZFX8F0CrDxP9bBLo0oqQXmtJGKqZeMSY2lFNhq6adPGkJ0GagFu
         RNSuEdAdK1DJd3CexC15TH0tK+OmhohFgufh+SZ6h4fkLrRoIHvZLicBEswuQZdgAT5p
         YMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793935073; x=1794539873;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4ISzBsIN/tegznly1nTglil5ZB1s0lfNnKiKhQqBrE4=;
        b=f1G7n0a9J1bC1BKOjEgNpU9vSFprHx3N+mPCkc8XNvVcrPW9tWYCF3/oCJnhMR5XKr
         nc10D2gxJ9L9r1qEIQiS/ak3Iw/yTiNbYI3ZrecLyA+lHrd5ddAPuJ6hydLN/ZCWL6kN
         py4ZcU1i50t1ZZQSUXsL4si6m1ujOsPEuXNbjsNX6ROyJ63jVBuhZxLtAyIsenvR3s5U
         lZCTtmjijCj6IL5kMznk0Uc0rPelhBjc5b2hNTM2j1U0SfUxY5tb+qsU5YAeNk7813DV
         jxD75zNU4G2chvOmG/txaoMbll0KiIznqJagWcFlXFf89lW7744DYmYAPt6D0EWZ9804
         GIjA==
X-Gm-Message-State: APuU4Z+xpn1Ti2q+h2B6qTQP9ZkPNYSJc9OCVV+Hb/w0ueD5ZvWRjPPX
	QqLyEecmIUZ9mbYxljb8fx3WqXV3PUu3XdAlj7ISusSoBjZtAbahwBZEYmsADB75
X-Gm-Gg: AYBFou3ZRxZrhPQXxhIvxllCJSpJ67iQxHG5BCF2xytiKzcMXjuyjkt3LFu276J5Aqk
	gz1E6bOG9/UCDmMmuIUcmJ8kSTs3OQ3b2cOt/CH37B1p4ErLuoBRsFUfNeUJDmYuu1YlPtb6JSZ
	y3+45Tpz0bsNysNyBT39gIcV7BjBlwVfpBButlxht2F4p7N7EhZsMOVl4XLsxjTTWWcwC14QWLJ
	ilpR3y/b6lvfGWBuh6GlLyYhFeGd1Z1VMhVwEchMow2cGmTz/iL55/uwm8RK09NOQyT+xNmN2CU
	i6wGdQsPJVH6B3R2CwXFZNJj5WV7n1Q4oHYyTyvRXqPoZ2/kRZsj2sBAR6lwpds//QUWZmxb/P9
	nvpr6XzD49a3RS2fo+c4Xl5xSzMtHLIRrn0UXqsFopJ7ZpEjwtc4smBTNi3pgk181TVrn4oThtC
	JmkTLKrNPFLKkRubT2PCiJZ6IyAoUGA29ggJNtY5d+aWeey/zy75MQ7WRiJFbhCGmIL4pBaQcct
	dj2yn6TxoICD2qqMRXyF87xJq6J3rSQGV2fCQzMj3qfTxqup7Ff2w2Z5C2U3qU=
X-Received: by 2002:a05:6a20:1603:b0:3e2:3737:75fd with SMTP id adf61e73a8af0-3ebb2a7899emr1713793637.58.1793935071636;
        Thu, 05 Nov 2026 19:17:51 -0800 (PST)
Received: from [172.17.0.2] ([52.250.17.205])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a73c99sm133437a12.20.2026.11.05.19.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:17:51 -0800 (PST)
Message-ID: <6aed46df.7ae0942e.654b8.b9cc@mx.google.com>
Date: Thu, 05 Nov 2026 19:17:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2186132588199019173=="
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
Subject: RE: [RFC,v4,1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
In-Reply-To: <20261106021723.631339-1-cochcoder@proton.me>
References: <20261106021723.631339-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2186132588199019173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1203684/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.20 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.45 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.36 seconds
CheckAllWarning               PASS      32.27 seconds
CheckSparse                   PASS      30.88 seconds
BuildKernel32                 PASS      24.22 seconds
CheckKernelLLVM               PASS      25.68 seconds
TestRunnerSetup               PASS      558.75 seconds
TestRunner_l2cap-tester       FAIL      11.79 seconds
IncrementalBuild              PASS      28.69 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,v4,1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
WARNING: Non-standard signature: Assisted-by:
#99: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#99: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 99 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14955882.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,v4,2/2] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
WARNING: Non-standard signature: Assisted-by:
#93: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#93: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14955883.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==35==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b8639ae33d0 at pc 0x5583cbda5eee bp 0x7ffd73a0c830 sp 0x7ffd73a0c820
READ of size 4 at 0x7b8639ae33d0 thread T0
    #0 0x5583cbda5eed in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x5583cbda6ed5 in timeout_callback src/shared/mainloop.c:271
    #2 0x5583cbda8006 in mainloop_run src/shared/mainloop.c:125
    #3 0x5583cbdaa96a in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x5583cbdafc4b in tester_run src/shared/tester.c:1297
    #5 0x5583cbcd91dd in main tools/l2cap-tester.c:3918
    #6 0x7f463aa34600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f463aa34717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x5583cbcdfce4 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16dce4) (BuildId: 0d2067a7ef8fe61fcf622598953c7d0f996221a0)

0x7b8639ae33d0 is located 0 bytes inside of 40-byte region [0x7b8639ae33d0,0x7b8639ae33f8)
freed by thread T0 here:
    #0 0x7f463b3723ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x5583cbda63ca in timeout_destroy src/shared/mainloop.c:252

previously allocated by thread T0 here:
    #0 0x7f463b37360f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x5583cbd90335 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1075

---
Regards,
Linux Bluetooth


--===============2186132588199019173==--
