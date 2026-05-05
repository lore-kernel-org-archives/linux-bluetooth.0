Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74053644C1
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016489; cv=none; b=pGlKhv6nEwAeBJSsHrRnxvT30xmyxEDfokEOOyMY8Zjif3jMHDymxFZ/ibSH5hK+xFS3YClsYGMgO0lq6BEyNh1NIOVwjUy8Oq1NdJgHsBiBHUa9BaL/NScfMbRt4XAtvUnShrO0NZU2wHMpie1InRd/s+q+DievruCQ9sdLXDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016489; c=relaxed/simple;
	bh=3IEKgV/2KQMmJ45pYEqe51fAEYeBEtS4QeTFLATM2yw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cDj2EQI09Z1uvN+NYPCpyRROodVc9NBgopSKfHK2GoLV8iB624G8wE4I32jFfSsbHwfhaulo4eS03KleeOXq5laVfhnbFmbkB7nP1I3xB1xKZR18VTE1e0y1j/PnYhRAsYssM9EY2N6lPMnea/9AGyaPhAntnlAvSdGPBjh+2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/RVtlKC; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/RVtlKC"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7de431da8fbso5015716a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778016486; x=1778621286; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fp77Io01fKrHIDCsXlBjgr5ylC4htKzjKjGfpFv7amo=;
        b=O/RVtlKCcbZmSAe5e/HNoE2YQLHiinF4xdRWrwS0pXDAlS9+9EnMCVe+y5dgeKCbVr
         KigwEChJoMQ17qX4Pw4O3kLUhiSAzCmqT75C4QWFjKQcAsQC+Q6dBpDWBYyQz3vm9gc5
         5+5Q9m5cZORh0LNq7NfOvHJfFhY2i2dFvMmRHYm0NYAjSXmSegAX0jr262dSSF6kvNsl
         PnHHQ1uC44x29fiyH70A7soAgpMfkr6BnLJ9qz+Kac1vzkoTe/09+f/KTlaIiuK9Pfy2
         M5+T1sKjcu5jMOVRrMauDwxwjIux9PtehcxyYC/RHFDrnh3qI4kJUg7FgTwCUXzBGwFv
         ZRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016486; x=1778621286;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp77Io01fKrHIDCsXlBjgr5ylC4htKzjKjGfpFv7amo=;
        b=ey5Mc910LYYjWthEu5rFbAc2SgVfkg1QWStaHSDZRf1E/w0KJ8UNT/vy4DwAqjJTnk
         DhpAXbZGyU3vGChoinxJ2zEYDIxmcJ16diD3SyH9U5aPyxv5BHbz8yZzrxLqO/TJ4Xns
         tXeveu2oAHpx3wzNy4OZYN/ygceBCTTF04H59w7VwekFT/OMZYh9sekHPOHXEFVimoqW
         bbrHxFyXcWoqpwS8Si/zGn5MQT+s1YfBrWlEauyKiTtv6wO2EjP91d1xuqyyzx0wifao
         mL4VZpeGDUOfTrH0J94PBkQ2CA3T1XZkYhB+EjoGvmA61Uuob6n7K1izM5FArFpXGN3r
         hMNA==
X-Gm-Message-State: AOJu0YzpRuNkMsVW3B9jkuLC5JQEfNGgPsimbQveHIFXf3qQ0MKYrRtN
	svSAthy+X969Ix5ilpF60a1NOQb6G21xxBLFvE3u4N1inY4M+gXiukH2pMkTXwWC
X-Gm-Gg: AeBDietzmY0G0sxx1pdTF9mQy7cgaICXWlf5OnuN9djo1EX3I/ARaEFM+X8tHezoxm1
	Ry6AaYXPEiYj13JZ5I2Ywr+ac3trxLLvxDgvXaftJ60Ll4OcxnEWYcTOzLazR3l3g3tPPFxldNZ
	DlLHnSy8CLb/jHkofqqpm0v4h7lJvZ4v+QK/3BzbsMBh25QWvNdLLmWySIusEw6z1Fh5I0BjdY+
	psvKtZjsR34x5WeejOcAnpKeCdTlXFUitNBybj+/aScoFxlUwhTl32VXU6x6Pm5S+vCRs9prtAs
	grOIfifsBJXErQODRlDaX04oJz2jke05c5BFHBTpaUnmV18+KJCnIKB3P9fbvM/AGCkWXqN+oYh
	m+QIiIyFgB8BMt/SyGs4CeIC+LGGS3E5+Aa5XB5hBHWIGRNF+Wg5XFsgpsHkbwyseOgn6XsvjRz
	AKkvU81VcJ4ajmwlpyhBD2Uh/OtZ+sBixd7aTa7G/WPwU=
X-Received: by 2002:a05:6830:378e:b0:7dc:e53a:638 with SMTP id 46e09a7af769-7e1def3d7b1mr374794a34.8.1778016486499;
        Tue, 05 May 2026 14:28:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.171.146])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deca278d0bsm10697961a34.0.2026.05.05.14.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 14:28:06 -0700 (PDT)
Message-ID: <69fa60e6.9d0a0220.ce262.2364@mx.google.com>
Date: Tue, 05 May 2026 14:28:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5024252628977228153=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature
In-Reply-To: <20260505200147.1325903-1-luiz.dentz@gmail.com>
References: <20260505200147.1325903-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5024252628977228153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1090104

---Test result---

Test Summary:
CheckPatch                    PASS      2.70 seconds
GitLint                       FAIL      0.56 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      26.91 seconds
CheckAllWarning               PASS      29.32 seconds
CheckSparse                   PASS      28.03 seconds
BuildKernel32                 PASS      25.85 seconds
TestRunnerSetup               PASS      563.34 seconds
TestRunner_l2cap-tester       FAIL      18.59 seconds
TestRunner_iso-tester         PASS      309.82 seconds
TestRunner_bnep-tester        FAIL      18.21 seconds
TestRunner_mgmt-tester        FAIL      22.89 seconds
TestRunner_rfcomm-tester      PASS      40.92 seconds
TestRunner_sco-tester         PASS      80.08 seconds
TestRunner_ioctl-tester       FAIL      49.57 seconds
TestRunner_mesh-tester        PASS      39.00 seconds
TestRunner_smp-tester         PASS      17.90 seconds
TestRunner_userchan-tester    PASS      19.79 seconds
TestRunner_6lowpan-tester     PASS      34.53 seconds
IncrementalBuild              PASS      42.47 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v1,1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature"
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Crash detected:
==34==    by 0x13325F: tester_run (tester.c:1085)
==34==    by 0x1142AD: main (l2cap-tester.c:3295)
==34==  Address 0x50 is not stack'd, malloc'd or (recently) free'd
==34== 
==34== 
==34== Process terminating with default action of signal 11 (SIGSEGV)
==34==  Access not within mapped region at address 0x50
==34==    at 0x12BE24: bthost_set_cmd_complete_cb (bthost.c:3487)
==34==    by 0x11596D: setup_powered_client_callback (l2cap-tester.c:1317)
==34==    by 0x12E5B0: request_complete (mgmt.c:320)
==34==    by 0x12F045: can_read_data (mgmt.c:408)
==34==    by 0x131AB8: watch_callback (io-glib.c:173)
==34==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x133868: mainloop_run (mainloop-glib.c:65)
==34==    by 0x133C9F: mainloop_run_with_signal (mainloop-notify.c:196)
==34==    by 0x13325F: tester_run (tester.c:1085)
==34==    by 0x1142AD: main (l2cap-tester.c:3295)
==34==  If you believe this happened as a result of a stack
==34==  overflow in your program's main thread (unlikely but
==34==  possible), you can try to increase the size of the
==34==  main thread stack using the --main-stacksize= flag.
==34==  The main thread stack size used in this run was 8388608.
==34== 
Valgrind errors:
==34==    by 0x11596D: setup_powered_client_callback (l2cap-tester.c:1317)
==34==    by 0x12E5B0: request_complete (mgmt.c:320)
==34==    by 0x12F045: can_read_data (mgmt.c:408)
==34==    by 0x131AB8: watch_callback (io-glib.c:173)
==34==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x133868: mainloop_run (mainloop-glib.c:65)
==34==    by 0x133C9F: mainloop_run_with_signal (mainloop-notify.c:196)
==34==    by 0x13325F: tester_run (tester.c:1085)
==34==    by 0x1142AD: main (l2cap-tester.c:3295)
==34==  If you believe this happened as a result of a stack
==34==  overflow in your program's main thread (unlikely but
==34==  possible), you can try to increase the size of the
==34==  main thread stack using the --main-stacksize= flag.
==34==  The main thread stack size used in this run was 8388608.
==34== 
==34== HEAP SUMMARY:
==34==     in use at exit: 66,134 bytes in 464 blocks
==34==   total heap usage: 632 allocs, 168 frees, 80,436 bytes allocated
==34== 
==34== LEAK SUMMARY:
==34==    definitely lost: 0 bytes in 0 blocks
==34==    indirectly lost: 0 bytes in 0 blocks
==34==      possibly lost: 0 bytes in 0 blocks
==34==    still reachable: 66,134 bytes in 464 blocks
==34==         suppressed: 0 bytes in 0 blocks
==34== Rerun with --leak-check=full to see details of leaked memory
==34== 
==34== For lists of detected and suppressed errors, rerun with: -s
==34== ERROR SUMMARY: 3 errors from 3 contexts (suppressed: 0 from 0)
Crash detected:
==34==         suppressed: 0 bytes in 0 blocks
==34== Rerun with --leak-check=full to see details of leaked memory
==34== 
==34== For lists of detected and suppressed errors, rerun with: -s
==34== ERROR SUMMARY: 3 errors from 3 contexts (suppressed: 0 from 0)
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
==34==    by 0x12C99F: tester_run (tester.c:1085)
==34==    by 0x111CB3: main (bnep-tester.c:298)
==34==  Address 0x50 is not stack'd, malloc'd or (recently) free'd
==34== 
==34== 
==34== Process terminating with default action of signal 11 (SIGSEGV)
==34==  Access not within mapped region at address 0x50
==34==    at 0x125C44: bthost_set_cmd_complete_cb (bthost.c:3487)
==34==    by 0x111F42: setup_powered_client_callback (bnep-tester.c:244)
==34==    by 0x127F00: request_complete (mgmt.c:320)
==34==    by 0x1288B5: can_read_data (mgmt.c:408)
==34==    by 0x12B328: watch_callback (io-glib.c:173)
==34==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x12CFA8: mainloop_run (mainloop-glib.c:65)
==34==    by 0x12D3DF: mainloop_run_with_signal (mainloop-notify.c:196)
==34==    by 0x12C99F: tester_run (tester.c:1085)
==34==    by 0x111CB3: main (bnep-tester.c:298)
==34==  If you believe this happened as a result of a stack
==34==  overflow in your program's main thread (unlikely but
==34==  possible), you can try to increase the size of the
==34==  main thread stack using the --main-stacksize= flag.
==34==  The main thread stack size used in this run was 8388608.
==34== 
Valgrind errors:
==34==    by 0x111F42: setup_powered_client_callback (bnep-tester.c:244)
==34==    by 0x127F00: request_complete (mgmt.c:320)
==34==    by 0x1288B5: can_read_data (mgmt.c:408)
==34==    by 0x12B328: watch_callback (io-glib.c:173)
==34==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x12CFA8: mainloop_run (mainloop-glib.c:65)
==34==    by 0x12D3DF: mainloop_run_with_signal (mainloop-notify.c:196)
==34==    by 0x12C99F: tester_run (tester.c:1085)
==34==    by 0x111CB3: main (bnep-tester.c:298)
==34==  If you believe this happened as a result of a stack
==34==  overflow in your program's main thread (unlikely but
==34==  possible), you can try to increase the size of the
==34==  main thread stack using the --main-stacksize= flag.
==34==  The main thread stack size used in this run was 8388608.
==34== 
==34== HEAP SUMMARY:
==34==     in use at exit: 25,333 bytes in 82 blocks
==34==   total heap usage: 237 allocs, 155 frees, 39,167 bytes allocated
==34== 
==34== LEAK SUMMARY:
==34==    definitely lost: 0 bytes in 0 blocks
==34==    indirectly lost: 0 bytes in 0 blocks
==34==      possibly lost: 0 bytes in 0 blocks
==34==    still reachable: 25,333 bytes in 82 blocks
==34==         suppressed: 0 bytes in 0 blocks
==34== Rerun with --leak-check=full to see details of leaked memory
==34== 
==34== For lists of detected and suppressed errors, rerun with: -s
==34== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)
Crash detected:
==34==         suppressed: 0 bytes in 0 blocks
==34== Rerun with --leak-check=full to see details of leaked memory
==34== 
==34== For lists of detected and suppressed errors, rerun with: -s
==34== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)
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
==34==    by 0x14F1DF: tester_run (tester.c:1085)
==34==    by 0x12B999: main (mgmt-tester.c:15134)
==34==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
==34== 
==34== 
==34== Process terminating with default action of signal 11 (SIGSEGV)
==34==  Access not within mapped region at address 0x0
==34==    at 0x145134: bthost_notify_ready (bthost.c:1190)
==34==    by 0x12FA10: read_info_callback (mgmt-tester.c:223)
==34==    by 0x14A420: request_complete (mgmt.c:320)
==34==    by 0x14AFD5: can_read_data (mgmt.c:408)
==34==    by 0x14DA48: watch_callback (io-glib.c:173)
==34==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x14F7E8: mainloop_run (mainloop-glib.c:65)
==34==    by 0x14FC1F: mainloop_run_with_signal (mainloop-notify.c:196)
==34==    by 0x14F1DF: tester_run (tester.c:1085)
==34==    by 0x12B999: main (mgmt-tester.c:15134)
==34==  If you believe this happened as a result of a stack
==34==  overflow in your program's main thread (unlikely but
==34==  possible), you can try to increase the size of the
==34==  main thread stack using the --main-stacksize= flag.
==34==  The main thread stack size used in this run was 8388608.
==34== 
Valgrind errors:
==34==    by 0x12FA10: read_info_callback (mgmt-tester.c:223)
==34==    by 0x14A420: request_complete (mgmt.c:320)
==34==    by 0x14AFD5: can_read_data (mgmt.c:408)
==34==    by 0x14DA48: watch_callback (io-glib.c:173)
==34==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==34==    by 0x14F7E8: mainloop_run (mainloop-glib.c:65)
==34==    by 0x14FC1F: mainloop_run_with_signal (mainloop-notify.c:196)
==34==    by 0x14F1DF: tester_run (tester.c:1085)
==34==    by 0x12B999: main (mgmt-tester.c:15134)
==34==  If you believe this happened as a result of a stack
==34==  overflow in your program's main thread (unlikely but
==34==  possible), you can try to increase the size of the
==34==  main thread stack using the --main-stacksize= flag.
==34==  The main thread stack size used in this run was 8388608.
==34== 
==34== HEAP SUMMARY:
==34==     in use at exit: 182,331 bytes in 2,112 blocks
==34==   total heap usage: 2,379 allocs, 267 frees, 204,063 bytes allocated
==34== 
==34== LEAK SUMMARY:
==34==    definitely lost: 0 bytes in 0 blocks
==34==    indirectly lost: 0 bytes in 0 blocks
==34==      possibly lost: 0 bytes in 0 blocks
==34==    still reachable: 182,331 bytes in 2,112 blocks
==34==         suppressed: 0 bytes in 0 blocks
==34== Rerun with --leak-check=full to see details of leaked memory
==34== 
==34== For lists of detected and suppressed errors, rerun with: -s
==34== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)
Crash detected:
==34==         suppressed: 0 bytes in 0 blocks
==34== Rerun with --leak-check=full to see details of leaked memory
==34== 
==34== For lists of detected and suppressed errors, rerun with: -s
==34== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)
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
Device List                                          Timed out  -31.727 seconds
Device Info                                          Timed out   -6.903 seconds
Reset Stat                                           Timed out   -6.909 seconds
Set Link Mode - ACCEPT                               Timed out   -6.915 seconds
Set Pkt Type - DM                                    Timed out  -15.155 seconds
Set Pkt Type - DH                                    Timed out  -15.162 seconds
Set Pkt Type - HV                                    Timed out  -15.167 seconds
Set Pkt Type - 2-DH                                  Timed out  -15.174 seconds
Set Pkt Type - 2-DH                                  Timed out  -15.181 seconds
Set Pkt Type - ALL                                   Timed out  -15.187 seconds
Set ACL MTU - 1                                      Timed out  -15.192 seconds


https://github.com/bluez/bluetooth-next/pull/147

---
Regards,
Linux Bluetooth


--===============5024252628977228153==--
