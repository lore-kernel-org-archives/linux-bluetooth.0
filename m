Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354403;
	b=RBB4HNh2IoGoL0BmizRwjLSN4AMY8SQAwl9a3hm1lODvJK0yRXzeHOXIltiW4tgeP7w1
	 4/YGwmoa2CstmNp7hycQH0b95qrm2jMn25MfBMQQ95vmjmr1GeCH/qotse23rG0Uj/hVg
	 w6BSILEDIZVbia0F+Rsa82LV2xIQ6baYiRDobVzmxWV5zT0qjT8S7LgxRAxKRks7RGmhT
	 3J5AcmQfG0/LNPOd0u4WAGvtHbT5LMHACeEqX0qNIFebYb3oA5JNC74/J/7v4oCv3y4gr
	 q42RDSXMdE5gV9gASA98ZyfDmB9zjUpa/8Imxs4N60zl6EJZl2KoqrNNkLLW6qfZ5yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=uQ2U4CMRoiXUvsma70xkYTIcv9BT3jd0u/cN8z6TV30=;
	b=D3nMxinhSXcw2u6UFWOLbGHNBqMcyxA+uGbBLjxBCp5we5rtS7cTvkYrSdD8bWTdVFF8
	 Ok1PBQ0HnXxIHK/2Q8dG20hMnEK9CzTtrHEsfPHKanO4anKPM2oEru55WflfZ+Qh9UKNr
	 oH4PUoklgK4mHow7BrnrIkygs5elB0LQr4m63poJ0HPhq0FH5xDI01rtcls+DWgebd1xj
	 H5YTw5hszfv7R8ELs3sDC5Wv0M9VLJufnGIy1sq8VWFiJboEu3jpbJcLDMDLMMzsh8UhV
	 ErMTOBNQlwRQH2el+6aZtD+EjbIvL4JLaHCnGibOR/FHe4henzpB9ArFb85ceIiIRuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q9Y5Zs6k;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C64606A31D
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 10:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20C64606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q9Y5Zs6k
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a315ed211so660076eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 03:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793354402; x=1793959202; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uQ2U4CMRoiXUvsma70xkYTIcv9BT3jd0u/cN8z6TV30=;
        b=q9Y5Zs6kmzsfJ5RpSFDnNa3N/Yt763mmyPS2NGPq4rpn4XSZ+guQkSeQO7+8EbZfcB
         rWK1oFNhGGyBfDQQGUuHjdOyuhrwCDzrRuTZQN+W7VMrQPzey0RpNQtYbR9jXtPG/Nih
         i2uj5666o4Nik5YSgplg2xclJW3RMwEEVZ6vGFtlmFA+ebLl6W/X+1oghMcn1a5/5XKj
         sxZqecAZbnJKMgYNl8UIujIHEy+ObByENmGEiHI5biOvQIak2DExKCjZtfCsAp5+mDRN
         guwDaxsR5u2Vjft+H1ZBt3BNrHCltx+pPuJoKAAMUvA23PUJZ87XvnClyzx44TMyZ6eh
         K1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793354402; x=1793959202;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uQ2U4CMRoiXUvsma70xkYTIcv9BT3jd0u/cN8z6TV30=;
        b=muMR0CfPug44M6KnLhJPY42/FwSu4rSVeqBArgS6dkAutxgZaiS1dt+FVFzJlZzVEK
         s4pfFz8iMlkPDiJdHfRJtkM+UxqW+fkTk0xFgcYk/aAq1JkZnJ3aElU4skCJ03r+Xsbd
         x7PVdYpGgMHNbLur2OIKNeCdZdYqhw0N9mIsGQxIh416IVxcDHIEGgtvxnZfEAfq+wpx
         fIEI8WlKYyRefoFrvRAQb2u0BF94K/uG2iwoKpmzcg7nRXNONfz4Fi9TYQWvA/8H9Qqe
         4q0YBsjGV+RuykuyjZz5URDYmuA6dBlzki8wWuOkYfJjSTMz5Q9p4Zv7TofGnNp+7Inw
         f2Lg==
X-Gm-Message-State: AFq9FYJmmiBe7yzP0MJOZy2UPm1pNkF1ID/70W0GEv3dFdOA/dKrWu84
	stYdAGWKfJgIbxeJLR7TjocffYY7TMkgfLjJ4eIO3QiIRcKVwVbqV1HdNdgD6g==
X-Gm-Gg: AYBFou0zuBTMvM3wKQ4iXRtjuEk8kHyJvD6esgKRGJgDfFsFMcoucBG1QMpyBU+JdEw
	osYnx2ywijJeDG5EgBjQXk5ht6zavonZys+IvyTJjHytCFah2k6/n/ah6BSfDCrByXBT6iuDY2k
	1P4UTrTREQYeINhOxUEXoXOyJTYUtd4AJTIGVgvabzsnxnCG//5Sa7u9ph0xm9emaYPzeqZjhOD
	DgtrzD50ZCblWZfa4J6ohM9QjR27niekXqH6eIqjlckSU3GL3IXh41FvZmpQh0MwLzAmqtmV8c0
	cMjW+ABVlHRNK0n6PpS6697hINWPiGNik1iVQIzAoL1hJz9BCRtQnD7swNtQ+ufW5vCP7K1utpu
	5pxkE0YtQu4CTqxRw4KVr8iRCvRaR1YmcZ9jsKLovBmx5dEgWu50zaxfNFqQrMF0Len7alcCVv7
	BkprlfrrAShv1Z/Dahz1ebZDKPVvQI6EtISIB2ZV6cGGEuBxL4EEOleA35c9sH5bJqZXNHGCgNM
	sazZ5x9Za/CJdI3wksa2tUBb9hlxaH8bgeFnndtAdPJKBGs4OdITSRZwR0Ro/Pj/g==
X-Received: by 2002:a05:693c:8806:20b0:36a:15ba:43ea with SMTP id 5a478bee46e88-36a423407dbmr2788293eec.5.1793354401803;
        Fri, 30 Oct 2026 03:00:01 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.174.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm6994093eec.26.2026.10.30.03.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:00:01 -0700 (PDT)
Message-ID: <6ae46aa1.ec2c7a27.3152a9.2090@mx.google.com>
Date: Fri, 30 Oct 2026 03:00:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7426919683833535813=="
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
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: [v4] Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery
In-Reply-To: <20261030042437.42733-1-kevin@simpleble.org>
References: <20261030042437.42733-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7426919683833535813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1196813/

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      31.77 seconds
CheckAllWarning               PASS      39.02 seconds
CheckSparse                   WARNING   40.88 seconds
BuildKernel32                 PASS      32.72 seconds
CheckKernelLLVM               PASS      36.03 seconds
TestRunnerSetup               PASS      744.11 seconds
TestRunner_l2cap-tester       FAIL      10.51 seconds
TestRunner_iso-tester         PASS      10.72 seconds
TestRunner_bnep-tester        PASS      3.11 seconds
TestRunner_mgmt-tester        PASS      87.92 seconds
TestRunner_rfcomm-tester      PASS      5.43 seconds
TestRunner_sco-tester         PASS      5.64 seconds
TestRunner_ioctl-tester       PASS      4.65 seconds
TestRunner_mesh-tester        PASS      5.50 seconds
TestRunner_smp-tester         PASS      4.31 seconds
TestRunner_userchan-tester    PASS      3.19 seconds
TestRunner_6lowpan-tester     PASS      4.41 seconds
IncrementalBuild              PASS      36.79 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==35==ERROR: AddressSanitizer: heap-use-after-free on address 0x7bc59a8e33d0 at pc 0x561c09478e8e bp 0x7ffe3ee10190 sp 0x7ffe3ee10180
READ of size 4 at 0x7bc59a8e33d0 thread T0
    #0 0x561c09478e8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x561c09479b75 in timeout_callback src/shared/mainloop.c:270
    #2 0x561c0947aaa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x561c0947d3fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x561c0948264b in tester_run src/shared/tester.c:1223
    #5 0x561c093ac17d in main tools/l2cap-tester.c:3918
    #6 0x7f859b817600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f859b817717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x561c093b2c84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7bc59a8e33d0 is located 0 bytes inside of 40-byte region [0x7bc59a8e33d0,0x7bc59a8e33f8)
freed by thread T0 here:
    #0 0x7f859c1553ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x561c0947936a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7f859c15660f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x561c094632d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1028

---
Regards,
Linux Bluetooth


--===============7426919683833535813==--
