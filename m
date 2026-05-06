Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4498C48C8A5
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089149; cv=none; b=twSEDwGSRWhUAn/H1WMQnzdVspnrtwNAwMEKI97SGW1css/GSGY27FTFvwlkziY7xj9CkZGr/ZmW3dW1MPHNW4vgd+3+Q1PX27TMdKw8QTZNzpaL9sVFSt2kV6OaTs/LQwchsop3FozsRhXmuYXwf4aL6BxZ2DNqpot8vfq+HUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089149; c=relaxed/simple;
	bh=UcEb1O/k7+nG20DowsrAFkaQwfby5sdfqz3SFJG7Y/A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Kag7l998Uu+83GgGw2zggg2qA2dht6VQz2Xjmuf7fTTB2iUkVlWhQhg+UzSAk5d1e5R79iZD2exTMvgDqv6jeGXfMXMemDbFc2Zu3j/J456iwBnIeTIIeAVKjwpjJe1r0UgPkShmZ5qGQENzK9LYm1yeD3bOjB8UH847haBIpr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwMIH5oJ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwMIH5oJ"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ea8563c693so752928585a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778089147; x=1778693947; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P66AMBraLJY5LHX6cU5AOZYyjYSNdRa2VgSYnQm+LH0=;
        b=MwMIH5oJGaIxuC2IuHCqgPFtcHxECtMHmA5zeawg3yheSMJB6X2eOPVp6Snu5Juz3i
         aH0G2sNjJw1T2gfraVHvyeRB6DuR7xDGY6tHQCBAbqixhbcBP1nSRp6RIUt2baTnYJZt
         ysRKm1Uh5NsCLwEbvGObdbXum3f4P7zg2sgIrwie5UymufhHflXVNcbhfoSlAx0Vl5kF
         e+PDQq+p99om+aotjE17277FXaCvtN3mIatUpLAlB6INTqR2PhL0+baAFs8C5xVEMV+x
         un8EtVAZJLNK7Suqp/Ei+9fqaBlIsjIXdsmGVVXaBqNShxXm3mSILzcVYxfQzNqj+0kl
         9llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778089147; x=1778693947;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P66AMBraLJY5LHX6cU5AOZYyjYSNdRa2VgSYnQm+LH0=;
        b=U9+7tJFfcDCtI5NNEPXsChQEWveju6XmVz9V1n8CwKLVDqW8c/fCS/D/ynrw+8yaMe
         N8zZ3X2ARrXmyRgI9dp0DvDWrORIfihULpUpe2ji+fFefW5GtKrh5sl8bsF9ZFflbKtb
         ErsylnKM/wbpMXVXn1vQ7hJ0s9C5dsprZqbeBKRsIblZlBq1X+KF38UD8/ODlFxc+GcW
         eCZomYg72TP+p9pdFs6C8rCynkmrOf7AKqReN2r4dj7PSc1ipmpMhEiDULH93c3Z8T2U
         l270zYZgWtej+6bZn5ZRl+ZpZfvOYSZX1rMfwKxqhKlf0yLjW/9Qkvb98M8VvVY/x/D+
         Y7Uw==
X-Gm-Message-State: AOJu0YwMI9CNW/zU1ZNct0ftGO3wutSs2CbqxsNM4F9k5leyCWCjNQsZ
	M20HHeHpasCZxdhQ0MwjZft1nEXxuONndC04PTmsRioFJB/NkKdhlGwVUlM7gQ==
X-Gm-Gg: AeBDieuc7/0wIdKAimdcFf4kgp0A/6uqjLUbRT6fY2jYTSOapf7Q+gDQVFRrmxbUZCA
	g3lsAv0Zj1Ujuk8Zozd5x4klDO2u4XuIjrG02LuTe+u2Ky+5mnprSzVccEFiKVaBKEnjw9yAx4u
	2lT4fw30a3dYp70hkQYvG1Ob+p+M1uTzKmLAV1fGi7oJMFM4dhXyvRLzE0AK2DF1u7HYA69Bi7E
	xtuOnlyAOb2uNoS1zbOyGtyQbunF55JaLm+OZMHwsLUapXqVakhGc0qKv7SxmqY74k4NyG1qE7A
	zdP4yIza1g/ueuD0sJIH5+V6lKLYmzk/qu53PkZA5QXm/E9qWKgEHurrsx9yJYC/PjZlZ0b5YmM
	b0FtmSnClVZ0zzUwPwCW1UtjOw7uNZSudyzj/w54MA8TyJa57h6l/Nd4Q3iBNfr0OvFXEsut4IF
	rvy3v0DnOMR7/SAko5vr8TLnt8KluBvTH/M5xPFR4=
X-Received: by 2002:a05:620a:470e:b0:8fc:5ae9:7743 with SMTP id af79cd13be357-904d68ddad5mr638773585a.43.1778089146706;
        Wed, 06 May 2026 10:39:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.222.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm1859686785a.36.2026.05.06.10.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:39:06 -0700 (PDT)
Message-ID: <69fb7cba.050a0220.27ffe4.2dd7@mx.google.com>
Date: Wed, 06 May 2026 10:39:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8289056757458509333=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: L2CAP: avoid using hci_conn after dropping hold
In-Reply-To: <20260506155313.1412894-1-zzzccc427@gmail.com>
References: <20260506155313.1412894-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8289056757458509333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1090570

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.95 seconds
CheckAllWarning               PASS      28.20 seconds
CheckSparse                   PASS      26.80 seconds
BuildKernel32                 PASS      24.75 seconds
TestRunnerSetup               PASS      530.45 seconds
TestRunner_l2cap-tester       FAIL      20.24 seconds
IncrementalBuild              PASS      25.67 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Crash detected:
==33==    by 0x13350F: tester_run (tester.c:1085)
==33==    by 0x1142AD: main (l2cap-tester.c:3295)
==33==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
==33== 
==33== 
==33== Process terminating with default action of signal 11 (SIGSEGV)
==33==  Access not within mapped region at address 0x0
==33==    at 0x483FF54: __strcmp_sse2 (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==33==    by 0x115C46: read_info_callback (l2cap-tester.c:156)
==33==    by 0x12E860: request_complete (mgmt.c:320)
==33==    by 0x12F2F5: can_read_data (mgmt.c:408)
==33==    by 0x131D68: watch_callback (io-glib.c:173)
==33==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x133B18: mainloop_run (mainloop-glib.c:65)
==33==    by 0x133F4F: mainloop_run_with_signal (mainloop-notify.c:196)
==33==    by 0x13350F: tester_run (tester.c:1085)
==33==    by 0x1142AD: main (l2cap-tester.c:3295)
==33==  If you believe this happened as a result of a stack
==33==  overflow in your program's main thread (unlikely but
==33==  possible), you can try to increase the size of the
==33==  main thread stack using the --main-stacksize= flag.
==33==  The main thread stack size used in this run was 8388608.
==33== 
Valgrind errors:
==33==    by 0x115C46: read_info_callback (l2cap-tester.c:156)
==33==    by 0x12E860: request_complete (mgmt.c:320)
==33==    by 0x12F2F5: can_read_data (mgmt.c:408)
==33==    by 0x131D68: watch_callback (io-glib.c:173)
==33==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x133B18: mainloop_run (mainloop-glib.c:65)
==33==    by 0x133F4F: mainloop_run_with_signal (mainloop-notify.c:196)
==33==    by 0x13350F: tester_run (tester.c:1085)
==33==    by 0x1142AD: main (l2cap-tester.c:3295)
==33==  If you believe this happened as a result of a stack
==33==  overflow in your program's main thread (unlikely but
==33==  possible), you can try to increase the size of the
==33==  main thread stack using the --main-stacksize= flag.
==33==  The main thread stack size used in this run was 8388608.
==33== 
==33== HEAP SUMMARY:
==33==     in use at exit: 66,009 bytes in 462 blocks
==33==   total heap usage: 592 allocs, 130 frees, 79,004 bytes allocated
==33== 
==33== LEAK SUMMARY:
==33==    definitely lost: 0 bytes in 0 blocks
==33==    indirectly lost: 0 bytes in 0 blocks
==33==      possibly lost: 0 bytes in 0 blocks
==33==    still reachable: 66,009 bytes in 462 blocks
==33==         suppressed: 0 bytes in 0 blocks
==33== Rerun with --leak-check=full to see details of leaked memory
==33== 
==33== For lists of detected and suppressed errors, rerun with: -s
==33== ERROR SUMMARY: 51 errors from 3 contexts (suppressed: 0 from 0)
Crash detected:
==33==         suppressed: 0 bytes in 0 blocks
==33== Rerun with --leak-check=full to see details of leaked memory
==33== 
==33== For lists of detected and suppressed errors, rerun with: -s
==33== ERROR SUMMARY: 51 errors from 3 contexts (suppressed: 0 from 0)
Segmentation fault
Process 32 exited with status 139
reboot: Restarting system
reboot: machine restart
No test result found


https://github.com/bluez/bluetooth-next/pull/149

---
Regards,
Linux Bluetooth


--===============8289056757458509333==--
