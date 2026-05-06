Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A34BC02A
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090003; cv=none; b=cSlmSExMM+FfBLg5VXhOlVRVWp1OqYtjP1y0fDtCTDGdptOJw51UHbwGEkt6seTssJz2S2YAEZEc2JEY1qUR4+CiC1lN8wJ9ftFg825/4XewwfN2pdDj7TvabC7iivOXkPKTsnr0sR3UQ5i0RwkeevUn9OT8VXK2bXD111X81Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090003; c=relaxed/simple;
	bh=aBZf9anT1AOtE1OEiUeXMM09PERkEf2vlPDA9AgYdiQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uGmlzj/ys/AAi59+/au3J06yhE/STd9kDI+KWfinl1CoPvfZHVpVQTrs6b0PisIc2B6z/NIVCesy30hyPKEJq1r/+0dXQKiS15pcLAXfiBpOD1SlplDyc1ArjvcwUFUVgzdJeikJhLTpKKvpnPs+7hmydVe9In+gFLHbyHZfHtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at0k6WOr; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at0k6WOr"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so8716266eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778089994; x=1778694794; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VHPjDh0PCAlRJ6glrMeUxKK92VhPktDsAfdF1TXffJM=;
        b=at0k6WOrbj8uVGgVde+VKo+lT3KP/MpOvL9h97BHyKnUrLrqck6NXDXWRUKJAycr2K
         dS5+ndaj3ww1g8w+uI7t7odNQRuAOnFwdsb4mZGinLzyXv3G9oUTFKMlTZbT/l/mfR4t
         HMzmbqOBA8gLUeWwsnbb8vs9FR9zXM7RJRkFhgAodIi9NRuc/i6vx8zPZdSFuJ/TDp+s
         J2kY33LDfmZTQaBuUHfXfDewSJe/I/Qm7ZCyDq1lri+Ogxgv0pLptp8PYbmFuDl0uULC
         kptlIPCp3sp8+rHjaELrajc2Jb/2p3kpTLSAphYuYrNW3DvLLYtU3X3bnX8apIwOB8RY
         XdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778089994; x=1778694794;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHPjDh0PCAlRJ6glrMeUxKK92VhPktDsAfdF1TXffJM=;
        b=NK2R8EpL7YehZ3y92JSd5/+wFzrrNcmrzCAqNCtC5AX7FsQmI0CUgRz3jaxAn8lvLs
         /3+tD+AL0zHTw5VMFixyY5hGyk8DP8x0wGBILiFe1GKBU6TReAh6ejoig25AJ8Vf/nbb
         bV9NkzgCFm2yPCd42FUwJmg8qGh/m/8PZ+jV7MEIq+H9Sx3DQ3CxIZQYrV0GHzqLZrO1
         YSFjpS6mEHxIRILOM89q+CnZgwVDk0j2p9MCMn4BX54SO8ECps5wNlWvJQdTYbdIACLb
         950H7DUZTJCnnvPWZpOIHhAsuCMqY3kM/EKrCOSn26ZTRwnpq/MuHua96Uei10SWo2KP
         8tig==
X-Gm-Message-State: AOJu0Yzt+DkW5A8HG0CnFJmom/BBmQw+uIUYl71qnFAaddcxDlg6vESQ
	/CnlxL7V/vsQ3MTMEn9dYO4DDUv7kox4blIZyA9PuodoqkpEJR88k6u+LvdmNw==
X-Gm-Gg: AeBDiesnQWYw5ZRlujcPi02VEl5ZXtzb4hNq14T8DEwXVbX53VnZpg3YbZAlKTwdSSe
	G5crGRa2GNWyKx0r6CARB3ml6v4Z4xOme+EerBJeJtOKZ6EZRCk8hUt+R97kon8oPhVwc2flFDq
	9yi+eSBFRE/Hegn++dLXzDrtEP5efBMYrkYt9V1S+SyWn1y3uoznb1I+F7qACWPAq7zx9LSQmXq
	0WYznOYQ8+XiKbhscZ+bbSAChTcZMvxZITNLzfonzZC3SVV97bjd9Fr/SlKzVTi21QQZ5i6u9ri
	PHrSLIlTQb266O1gnTehOG5N5CZsfupS5dCYG/XzowNbwBEKOC0kt/ez7h+e2TqiPtqsAFO+YxT
	J20qGgxgjwqjk4z2mIM3Ujq8WZs4POWS79nm1G29o70PW0Qyzy4jrM+pinZfUqdn+sIpKqASqNP
	YuLrMunSHq2cH/T2kzZk1F2YgaWaKAO+Po3IhW37j4
X-Received: by 2002:a05:7300:a507:b0:2d9:db50:c6a5 with SMTP id 5a478bee46e88-2f544bea5c1mr2466723eec.0.1778089993658;
        Wed, 06 May 2026 10:53:13 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.61.209])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f569f89b3bsm5183446eec.0.2026.05.06.10.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:53:13 -0700 (PDT)
Message-ID: <69fb8009.050a0220.2faa47.1929@mx.google.com>
Date: Wed, 06 May 2026 10:53:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2853318262703610681=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature
In-Reply-To: <20260506160651.1585012-1-luiz.dentz@gmail.com>
References: <20260506160651.1585012-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2853318262703610681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1090572

---Test result---

Test Summary:
CheckPatch                    FAIL      2.47 seconds
GitLint                       FAIL      1.12 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      26.59 seconds
CheckAllWarning               PASS      28.99 seconds
CheckSparse                   PASS      27.43 seconds
BuildKernel32                 PASS      25.44 seconds
TestRunnerSetup               PASS      577.31 seconds
TestRunner_l2cap-tester       FAIL      18.84 seconds
TestRunner_iso-tester         PASS      311.35 seconds
TestRunner_bnep-tester        FAIL      18.23 seconds
TestRunner_mgmt-tester        FAIL      23.63 seconds
TestRunner_rfcomm-tester      PASS      40.63 seconds
TestRunner_sco-tester         PASS      79.85 seconds
TestRunner_ioctl-tester       FAIL      49.58 seconds
TestRunner_mesh-tester        PASS      38.97 seconds
TestRunner_smp-tester         PASS      17.68 seconds
TestRunner_userchan-tester    FAIL      18.28 seconds
TestRunner_6lowpan-tester     PASS      34.60 seconds
IncrementalBuild              PASS      42.57 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature
WARNING: Possible unnecessary 'out of memory' message
#317: FILE: net/bluetooth/hci_event.c:3989:
+		if (!sgrp) {
+			bt_dev_err(hdev, "can't allocate memory for SCI group");

total: 0 errors, 1 warnings, 0 checks, 335 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14557669.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v2,1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature"
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
Device List                                          Timed out  -31.728 seconds
Device Info                                          Timed out   -6.907 seconds
Reset Stat                                           Timed out   -6.913 seconds
Set Link Mode - ACCEPT                               Timed out   -6.919 seconds
Set Pkt Type - DM                                    Timed out  -15.160 seconds
Set Pkt Type - DH                                    Timed out  -15.166 seconds
Set Pkt Type - HV                                    Timed out  -15.172 seconds
Set Pkt Type - 2-DH                                  Timed out  -15.179 seconds
Set Pkt Type - 2-DH                                  Timed out  -15.185 seconds
Set Pkt Type - ALL                                   Timed out  -15.191 seconds
Set ACL MTU - 1                                      Timed out  -15.197 seconds
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
Crash detected:
==34==    by 0x12D77F: tester_run (tester.c:1085)
==34==    by 0x111DFB: main (userchan-tester.c:392)
==34==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
==34== 
==34== 
==34== Process terminating with default action of signal 11 (SIGSEGV)
==34==  Access not within mapped region at address 0x0
==34==    at 0x483FF54: __strcmp_sse2 (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==34==    by 0x11250B: read_info_callback (userchan-tester.c:88)
==34==    by 0x128450: request_complete (mgmt.c:320)
==34==    by 0x128E95: can_read_data (mgmt.c:408)
==34==    by 0x12C108: watch_callback (io-glib.c:173)
==34==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x12DD88: mainloop_run (mainloop-glib.c:65)
==34==    by 0x12E1BF: mainloop_run_with_signal (mainloop-notify.c:196)
==34==    by 0x12D77F: tester_run (tester.c:1085)
==34==    by 0x111DFB: main (userchan-tester.c:392)
==34==  If you believe this happened as a result of a stack
==34==  overflow in your program's main thread (unlikely but
==34==  possible), you can try to increase the size of the
==34==  main thread stack using the --main-stacksize= flag.
==34==  The main thread stack size used in this run was 8388608.
==34== 
Valgrind errors:
==34==    by 0x11250B: read_info_callback (userchan-tester.c:88)
==34==    by 0x128450: request_complete (mgmt.c:320)
==34==    by 0x128E95: can_read_data (mgmt.c:408)
==34==    by 0x12C108: watch_callback (io-glib.c:173)
==34==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x12DD88: mainloop_run (mainloop-glib.c:65)
==34==    by 0x12E1BF: mainloop_run_with_signal (mainloop-notify.c:196)
==34==    by 0x12D77F: tester_run (tester.c:1085)
==34==    by 0x111DFB: main (userchan-tester.c:392)
==34==  If you believe this happened as a result of a stack
==34==  overflow in your program's main thread (unlikely but
==34==  possible), you can try to increase the size of the
==34==  main thread stack using the --main-stacksize= flag.
==34==  The main thread stack size used in this run was 8388608.
==34== 
==34== HEAP SUMMARY:
==34==     in use at exit: 26,001 bytes in 92 blocks
==34==   total heap usage: 222 allocs, 130 frees, 38,997 bytes allocated
==34== 
==34== LEAK SUMMARY:
==34==    definitely lost: 0 bytes in 0 blocks
==34==    indirectly lost: 0 bytes in 0 blocks
==34==      possibly lost: 0 bytes in 0 blocks
==34==    still reachable: 26,001 bytes in 92 blocks
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


https://github.com/bluez/bluetooth-next/pull/150

---
Regards,
Linux Bluetooth


--===============2853318262703610681==--
