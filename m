Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E94A3B7B9E
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170372; cv=none; b=pBlDpEbv3exCdvJ+MLiVoGjy9Bf3c+DSCV62NOCY0nD9Px5h6WoVTdeqhUbUt8xzNDaHL/BN7yjIwQ8IAsU1DV0HQu5qL5bpT/LaoLvuDDfQwsD2RDWZe8qPfjUgf1TWIFIywmZwlJf0FP0ivaoBni8sPBHfY8VFIzSC0ZbFoio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170372; c=relaxed/simple;
	bh=ioQXgeG8rVqoVrcq0kb/8p2c3j9PVDfkLiXky//dcEQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GuxK7Xvks0V7ZHSmd6qQZzx8PnZy6pAsXorLrzUVgMWrKuCqwzGi7THrashEPy/RK4w3w8AjG75z5DxF1/zYSwSOEp3SosvHcXq1dcYECom8lCX2zI84P7FfKADnKeXjsq1fcM76wsNsNH9/3Mn7z5rrmQ27jQIIsl48Dmg7GcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY70aIsv; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY70aIsv"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c15849aa2cso1319392eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778170369; x=1778775169; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v2bXBOeLX8UuXcUuGOllTtwmOjRPDN5ZkWIPnjxHnrY=;
        b=lY70aIsvgl5OPaUJ/fAG6mFYWfL/yTqqd8Tl7XMn4Ewzyu2BTB6eFUiLp4hRV0+4MF
         Kr4QDhl0+1RTqWzkSh2TgztuePeB+M7FySdzNc0TbeI915IwxE/Q1RvRmRlFaFdxxU+Z
         rVYDD6PSMacwgQ4ROaSemRGTjrDPvMtJTIdInVAScnAHHme62Xvd684J1aTobD/8xHyQ
         jzYTLm3gN+AOYgmAUMxJsSJCXxglyatbeb5fl3++aFeAzrSuQTdfsgNrHYYJiUd0C18V
         qCD+qKgrKcLZ5UZXP0ZhYdqofckXLZ24l2eQ/O2oWZOvpo7MxnbIB7LwD0IORx/MmXvf
         w8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778170369; x=1778775169;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2bXBOeLX8UuXcUuGOllTtwmOjRPDN5ZkWIPnjxHnrY=;
        b=nLBI8BN5lNfXtwUMpJIWOkyIsSjFuzEPFOprLD0CESvmWLZlyECwl+H2VcW9YABwUd
         Rbyy3a8e1mbKU+s/kFcJ9tRlzaM8JCnFcEEP1GlF37Uhk3XK3dxhNkEKK3gCVSNfI2zm
         teLvOPa6i4MIwcBDiXJi1H7OiZoMESm7fHFUiFu0KHA5cv6wMcVOmcgoMxBAaDCEgVyN
         zcj9ssOtgMBhSYpXZaxq0J4XnEtHo3xxqni89jBWpfoAnvEVKzFTPYXzuJq+tfXB7z3a
         8xaJyeeZXaA3Ty17dzvW0vpca4xslKWOfQg48pC5+uu6P7ngEbI3QmUAJAWW1xWfEywJ
         xU9Q==
X-Gm-Message-State: AOJu0YwuXgfBzsOsl7YSdeJHPU4q3zDUhK6CZPBBFPbj0hAFgPenbOYA
	9dVF1haNnAWS7IpVHjtQlev2iDoWOWvgtsA/TjpkWDgr0EneqVhRv6dpKdKdyw==
X-Gm-Gg: AeBDietReodFBjTnwlwtVpr08HylX6Kpu4iK3b2omz8iNnKOaiLxyrxSdNyo0Yg5EH6
	K76S3X+8923awuouk8tHk7C9JOXx+8hLC7OjmpVWDknI4IKlS7h7g3MZjXoLeXH1Vbw22d7kfTX
	EUMYqO1XquVe1uwnSCrdAT3OIasMNHIMAZf++jFJApQ5syUvKtqJGe/8JV4tkDL28gIhI8VeMP4
	ezP1zV77UvIVN6wRLtuQGz7R9U3CoA1nBbnxnnr6rpPt64W8WS4qBoXsfetpMIr8M6A742Uy33J
	N8eflFJYDUAjieZ7C4wqX4oXZmepX5OY2WR5ll94XMqToqDI3jOKy5r+B319QrsLam/uWmmKRfk
	IT63AV45OyF2DNQIrqe6oDEU0aaUyIyAPlAJBxetxfQSRZjmY6VODJzKhl/MzaUhAMhcrukZu8/
	mIl8lnM1h9e4WV1eG4MXPJL6zfRfifktM6WTIyIcm/
X-Received: by 2002:a05:7300:aca2:b0:2c4:4363:3742 with SMTP id 5a478bee46e88-2f54869b241mr3833761eec.9.1778170368790;
        Thu, 07 May 2026 09:12:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.178.40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56f7967cfsm9045990eec.19.2026.05.07.09.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:12:48 -0700 (PDT)
Message-ID: <69fcba00.050a0220.27248a.4434@mx.google.com>
Date: Thu, 07 May 2026 09:12:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9136564273084137932=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature
In-Reply-To: <20260507151309.145613-1-luiz.dentz@gmail.com>
References: <20260507151309.145613-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9136564273084137932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1091122

---Test result---

Test Summary:
CheckPatch                    FAIL      2.11 seconds
GitLint                       FAIL      0.43 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      19.87 seconds
CheckAllWarning               PASS      22.02 seconds
CheckSparse                   PASS      21.33 seconds
BuildKernel32                 PASS      19.78 seconds
TestRunnerSetup               PASS      412.64 seconds
TestRunner_l2cap-tester       FAIL      14.48 seconds
TestRunner_iso-tester         PASS      304.01 seconds
TestRunner_bnep-tester        FAIL      14.19 seconds
TestRunner_mgmt-tester        FAIL      18.33 seconds
TestRunner_rfcomm-tester      PASS      36.80 seconds
TestRunner_sco-tester         PASS      75.93 seconds
TestRunner_ioctl-tester       FAIL      43.57 seconds
TestRunner_mesh-tester        PASS      34.73 seconds
TestRunner_smp-tester         PASS      14.37 seconds
TestRunner_userchan-tester    FAIL      14.40 seconds
TestRunner_6lowpan-tester     PASS      30.69 seconds
IncrementalBuild              PASS      35.27 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature
WARNING: Possible unnecessary 'out of memory' message
#317: FILE: net/bluetooth/hci_event.c:3989:
+		if (!sgrp) {
+			bt_dev_err(hdev, "can't allocate memory for SCI group");

total: 0 errors, 1 warnings, 0 checks, 330 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14559599.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v3,1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature"
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Crash detected:
==34==    by 0x13350F: tester_run (tester.c:1085)
==34==    by 0x1142AD: main (l2cap-tester.c:3295)
==34==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
==34== 
==34== 
==34== Process terminating with default action of signal 11 (SIGSEGV)
==34==  Access not within mapped region at address 0x0
==34==    at 0x483FF54: __strcmp_sse2 (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==34==    by 0x115C46: read_info_callback (l2cap-tester.c:156)
==34==    by 0x12E860: request_complete (mgmt.c:320)
==34==    by 0x12F2F5: can_read_data (mgmt.c:408)
==34==    by 0x131D68: watch_callback (io-glib.c:173)
==34==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x133B18: mainloop_run (mainloop-glib.c:65)
==34==    by 0x133F4F: mainloop_run_with_signal (mainloop-notify.c:196)
==34==    by 0x13350F: tester_run (tester.c:1085)
==34==    by 0x1142AD: main (l2cap-tester.c:3295)
==34==  If you believe this happened as a result of a stack
==34==  overflow in your program's main thread (unlikely but
==34==  possible), you can try to increase the size of the
==34==  main thread stack using the --main-stacksize= flag.
==34==  The main thread stack size used in this run was 8388608.
==34== 
Valgrind errors:
==34==    by 0x115C46: read_info_callback (l2cap-tester.c:156)
==34==    by 0x12E860: request_complete (mgmt.c:320)
==34==    by 0x12F2F5: can_read_data (mgmt.c:408)
==34==    by 0x131D68: watch_callback (io-glib.c:173)
==34==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x133B18: mainloop_run (mainloop-glib.c:65)
==34==    by 0x133F4F: mainloop_run_with_signal (mainloop-notify.c:196)
==34==    by 0x13350F: tester_run (tester.c:1085)
==34==    by 0x1142AD: main (l2cap-tester.c:3295)
==34==  If you believe this happened as a result of a stack
==34==  overflow in your program's main thread (unlikely but
==34==  possible), you can try to increase the size of the
==34==  main thread stack using the --main-stacksize= flag.
==34==  The main thread stack size used in this run was 8388608.
==34== 
==34== HEAP SUMMARY:
==34==     in use at exit: 66,009 bytes in 462 blocks
==34==   total heap usage: 592 allocs, 130 frees, 79,004 bytes allocated
==34== 
==34== LEAK SUMMARY:
==34==    definitely lost: 0 bytes in 0 blocks
==34==    indirectly lost: 0 bytes in 0 blocks
==34==      possibly lost: 0 bytes in 0 blocks
==34==    still reachable: 66,009 bytes in 462 blocks
==34==         suppressed: 0 bytes in 0 blocks
==34== Rerun with --leak-check=full to see details of leaked memory
==34== 
==34== For lists of detected and suppressed errors, rerun with: -s
==34== ERROR SUMMARY: 51 errors from 3 contexts (suppressed: 0 from 0)
Crash detected:
==34==         suppressed: 0 bytes in 0 blocks
==34== Rerun with --leak-check=full to see details of leaked memory
==34== 
==34== For lists of detected and suppressed errors, rerun with: -s
==34== ERROR SUMMARY: 51 errors from 3 contexts (suppressed: 0 from 0)
Segmentation fault
Process 33 exited with status 139
reboot: Restarting system
reboot: machine restart
No test result found
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:
Crash detected:
==34==    by 0x12CC4F: tester_run (tester.c:1085)
==34==    by 0x111CB3: main (bnep-tester.c:298)
==34==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
==34== 
==34== 
==34== Process terminating with default action of signal 11 (SIGSEGV)
==34==  Access not within mapped region at address 0x0
==34==    at 0x483FF54: __strcmp_sse2 (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==34==    by 0x112206: read_info_callback (bnep-tester.c:101)
==34==    by 0x1281B0: request_complete (mgmt.c:320)
==34==    by 0x128B65: can_read_data (mgmt.c:408)
==34==    by 0x12B5D8: watch_callback (io-glib.c:173)
==34==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x12D258: mainloop_run (mainloop-glib.c:65)
==34==    by 0x12D68F: mainloop_run_with_signal (mainloop-notify.c:196)
==34==    by 0x12CC4F: tester_run (tester.c:1085)
==34==    by 0x111CB3: main (bnep-tester.c:298)
==34==  If you believe this happened as a result of a stack
==34==  overflow in your program's main thread (unlikely but
==34==  possible), you can try to increase the size of the
==34==  main thread stack using the --main-stacksize= flag.
==34==  The main thread stack size used in this run was 8388608.
==34== 
Valgrind errors:
==34==    by 0x112206: read_info_callback (bnep-tester.c:101)
==34==    by 0x1281B0: request_complete (mgmt.c:320)
==34==    by 0x128B65: can_read_data (mgmt.c:408)
==34==    by 0x12B5D8: watch_callback (io-glib.c:173)
==34==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x12D258: mainloop_run (mainloop-glib.c:65)
==34==    by 0x12D68F: mainloop_run_with_signal (mainloop-notify.c:196)
==34==    by 0x12CC4F: tester_run (tester.c:1085)
==34==    by 0x111CB3: main (bnep-tester.c:298)
==34==  If you believe this happened as a result of a stack
==34==  overflow in your program's main thread (unlikely but
==34==  possible), you can try to increase the size of the
==34==  main thread stack using the --main-stacksize= flag.
==34==  The main thread stack size used in this run was 8388608.
==34== 
==34== HEAP SUMMARY:
==34==     in use at exit: 25,264 bytes in 82 blocks
==34==   total heap usage: 212 allocs, 130 frees, 38,256 bytes allocated
==34== 
==34== LEAK SUMMARY:
==34==    definitely lost: 0 bytes in 0 blocks
==34==    indirectly lost: 0 bytes in 0 blocks
==34==      possibly lost: 0 bytes in 0 blocks
==34==    still reachable: 25,264 bytes in 82 blocks
==34==         suppressed: 0 bytes in 0 blocks
==34== Rerun with --leak-check=full to see details of leaked memory
==34== 
==34== For lists of detected and suppressed errors, rerun with: -s
==34== ERROR SUMMARY: 51 errors from 3 contexts (suppressed: 0 from 0)
Crash detected:
==34==         suppressed: 0 bytes in 0 blocks
==34== Rerun with --leak-check=full to see details of leaked memory
==34== 
==34== For lists of detected and suppressed errors, rerun with: -s
==34== ERROR SUMMARY: 51 errors from 3 contexts (suppressed: 0 from 0)
Segmentation fault
Process 33 exited with status 139
reboot: Restarting system
reboot: machine restart
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Crash detected:
==34==    by 0x14F4FF: tester_run (tester.c:1085)
==34==    by 0x12B999: main (mgmt-tester.c:15134)
==34==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
==34== 
==34== 
==34== Process terminating with default action of signal 11 (SIGSEGV)
==34==  Access not within mapped region at address 0x0
==34==    at 0x483FF54: __strcmp_sse2 (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==34==    by 0x12F8E8: read_info_callback (mgmt-tester.c:181)
==34==    by 0x14A740: request_complete (mgmt.c:320)
==34==    by 0x14B2F5: can_read_data (mgmt.c:408)
==34==    by 0x14DD68: watch_callback (io-glib.c:173)
==34==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x14FB08: mainloop_run (mainloop-glib.c:65)
==34==    by 0x14FF3F: mainloop_run_with_signal (mainloop-notify.c:196)
==34==    by 0x14F4FF: tester_run (tester.c:1085)
==34==    by 0x12B999: main (mgmt-tester.c:15134)
==34==  If you believe this happened as a result of a stack
==34==  overflow in your program's main thread (unlikely but
==34==  possible), you can try to increase the size of the
==34==  main thread stack using the --main-stacksize= flag.
==34==  The main thread stack size used in this run was 8388608.
==34== 
Valgrind errors:
==34==    by 0x12F8E8: read_info_callback (mgmt-tester.c:181)
==34==    by 0x14A740: request_complete (mgmt.c:320)
==34==    by 0x14B2F5: can_read_data (mgmt.c:408)
==34==    by 0x14DD68: watch_callback (io-glib.c:173)
==34==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x14FB08: mainloop_run (mainloop-glib.c:65)
==34==    by 0x14FF3F: mainloop_run_with_signal (mainloop-notify.c:196)
==34==    by 0x14F4FF: tester_run (tester.c:1085)
==34==    by 0x12B999: main (mgmt-tester.c:15134)
==34==  If you believe this happened as a result of a stack
==34==  overflow in your program's main thread (unlikely but
==34==  possible), you can try to increase the size of the
==34==  main thread stack using the --main-stacksize= flag.
==34==  The main thread stack size used in this run was 8388608.
==34== 
==34== HEAP SUMMARY:
==34==     in use at exit: 182,263 bytes in 2,112 blocks
==34==   total heap usage: 2,389 allocs, 277 frees, 204,641 bytes allocated
==34== 
==34== LEAK SUMMARY:
==34==    definitely lost: 0 bytes in 0 blocks
==34==    indirectly lost: 0 bytes in 0 blocks
==34==      possibly lost: 0 bytes in 0 blocks
==34==    still reachable: 182,263 bytes in 2,112 blocks
==34==         suppressed: 0 bytes in 0 blocks
==34== Rerun with --leak-check=full to see details of leaked memory
==34== 
==34== For lists of detected and suppressed errors, rerun with: -s
==34== ERROR SUMMARY: 51 errors from 3 contexts (suppressed: 0 from 0)
Crash detected:
==34==         suppressed: 0 bytes in 0 blocks
==34== Rerun with --leak-check=full to see details of leaked memory
==34== 
==34== For lists of detected and suppressed errors, rerun with: -s
==34== ERROR SUMMARY: 51 errors from 3 contexts (suppressed: 0 from 0)
Segmentation fault
Process 33 exited with status 139
reboot: Restarting system
reboot: machine restart
No test result found
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 0 (0.0%), Failed: 11, Not Run: 17

Failed Test Cases
Device List                                          Timed out  -29.495 seconds
Device Info                                          Timed out   -6.742 seconds
Reset Stat                                           Timed out   -6.747 seconds
Set Link Mode - ACCEPT                               Timed out   -6.752 seconds
Set Pkt Type - DM                                    Timed out  -14.996 seconds
Set Pkt Type - DH                                    Timed out  -15.001 seconds
Set Pkt Type - HV                                    Timed out  -15.006 seconds
Set Pkt Type - 2-DH                                  Timed out  -15.012 seconds
Set Pkt Type - 2-DH                                  Timed out  -15.017 seconds
Set Pkt Type - ALL                                   Timed out  -15.022 seconds
Set ACL MTU - 1                                      Timed out  -15.026 seconds
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
Crash detected:
==33==    by 0x12D77F: tester_run (tester.c:1085)
==33==    by 0x111DFB: main (userchan-tester.c:392)
==33==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
==33== 
==33== 
==33== Process terminating with default action of signal 11 (SIGSEGV)
==33==  Access not within mapped region at address 0x0
==33==    at 0x483FF54: __strcmp_sse2 (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==33==    by 0x11250B: read_info_callback (userchan-tester.c:88)
==33==    by 0x128450: request_complete (mgmt.c:320)
==33==    by 0x128E95: can_read_data (mgmt.c:408)
==33==    by 0x12C108: watch_callback (io-glib.c:173)
==33==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x12DD88: mainloop_run (mainloop-glib.c:65)
==33==    by 0x12E1BF: mainloop_run_with_signal (mainloop-notify.c:196)
==33==    by 0x12D77F: tester_run (tester.c:1085)
==33==    by 0x111DFB: main (userchan-tester.c:392)
==33==  If you believe this happened as a result of a stack
==33==  overflow in your program's main thread (unlikely but
==33==  possible), you can try to increase the size of the
==33==  main thread stack using the --main-stacksize= flag.
==33==  The main thread stack size used in this run was 8388608.
==33== 
Valgrind errors:
==33==    by 0x11250B: read_info_callback (userchan-tester.c:88)
==33==    by 0x128450: request_complete (mgmt.c:320)
==33==    by 0x128E95: can_read_data (mgmt.c:408)
==33==    by 0x12C108: watch_callback (io-glib.c:173)
==33==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x12DD88: mainloop_run (mainloop-glib.c:65)
==33==    by 0x12E1BF: mainloop_run_with_signal (mainloop-notify.c:196)
==33==    by 0x12D77F: tester_run (tester.c:1085)
==33==    by 0x111DFB: main (userchan-tester.c:392)
==33==  If you believe this happened as a result of a stack
==33==  overflow in your program's main thread (unlikely but
==33==  possible), you can try to increase the size of the
==33==  main thread stack using the --main-stacksize= flag.
==33==  The main thread stack size used in this run was 8388608.
==33== 
==33== HEAP SUMMARY:
==33==     in use at exit: 26,001 bytes in 92 blocks
==33==   total heap usage: 222 allocs, 130 frees, 38,997 bytes allocated
==33== 
==33== LEAK SUMMARY:
==33==    definitely lost: 0 bytes in 0 blocks
==33==    indirectly lost: 0 bytes in 0 blocks
==33==      possibly lost: 0 bytes in 0 blocks
==33==    still reachable: 26,001 bytes in 92 blocks
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


https://github.com/bluez/bluetooth-next/pull/151

---
Regards,
Linux Bluetooth


--===============9136564273084137932==--
