Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B700C34252D
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075786; cv=none; b=j2wjzrj+3Ps0tTd5nK8Pidbi4sO+wNq+bznCDTxh7sz6l+e0ziXWtvjIiqy6hQCu3jskB2MdTiz58ZxXAa/0PZZHOn9T7RBV99zBH0+LGjNWMI3pFFwukpRchVcvSElN0ODc1EpwgtedBiZ/yEE0WAPTHNjYjzamGVbHd3T0dS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075786; c=relaxed/simple;
	bh=z/j2b2ifMsRoXTamtjjwPxowHyX9JGVtdiiIjEXw5e0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a+oynH/RBShu1TCD+1QruPirCAhXXFoCo0oZDJ1S3ks0oyE6GyjSxSL4ZIFitDLhA1kOzFzupIIHKQADXYI5bpFM78lpKnV5okCcYGN8hnVOLcNCKVSpho+XrFa3j/7NsqAaOoDyP7Nzob2FN93ppTctCP/arlstH9wHi4kf+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe1T0O0t; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe1T0O0t"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b74b460d77so42536786d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778075783; x=1778680583; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QlgWrSLqP33TfTwy3Z3QtGModPcreqLn2CrX97MfTUQ=;
        b=Pe1T0O0tryuSXhvuopKiXOGqYeXdAJKSnYMRhqcfsp95JR/ot+Rx0/4qWnAwU6yMVb
         8oQtdh2WvuAoo2y1EffciI+8ZFTrgvG5AZRVinL9bM7Ilkp4mfra1HTjWXHcKuxQPNXx
         RIonW0/ofh2vbRz2SUWEK56JtVmNXFpMi2R/RHZdxRHbOM4mlz1GHE3zulNC/qLMcROQ
         DlhCeDS1sFuj7Ly4fvsG+2GuI4i4BD21LWtibU/LYcTv8m1RU14ahs/0T9H4vldkHjSY
         w/kAeI0hrNEONXc5muIdZkyCGGYmSVccghSbYXi9Vfm3cQiqiEpUy9uV0FYAbAPk73+t
         a+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778075783; x=1778680583;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlgWrSLqP33TfTwy3Z3QtGModPcreqLn2CrX97MfTUQ=;
        b=g/bk9asB/prLY3hVoZQP+MyTOGNs4k6nL1kMskA0P7IEQluHXYPzaltpKdsZ98MY5Z
         LU6GiJT+FG3TfuQSChD9g9CRrx/vodlpsHNQEW+RS09ni2U2kiAb6k2bT4sgdodysj0k
         Rx0Fu+F9PBdEeDZPxxyaT9eZ8mbu7XGPnjWwAK9vDGQk/MUBQikRuGMrxxa/fGrgDC4x
         2RurKZjbcqu0yNkFK5utXBExkaYFFrWOPk5B/+yTa/yyEwKxlTS5ZXPThxzVglWaCXvP
         qgay+xpL/dSMRKFXAdMBHILgsG+Ok8kjTnJBDh1cAKjphiR6Zkdc1Kt1pIvyboz/zpEA
         6n4A==
X-Gm-Message-State: AOJu0Yw9w2Eng8efh+I7tqqGA4439/MzSvdxNELaQLcY8XdSmI8wVT0s
	ukkcFZVY7vlNBRiXk5K6jzYVvk3RkS+lOAvaxJatrN6G9tDa+uljOrBHxafK9w==
X-Gm-Gg: AeBDies1tiEonACAKw49T45CZ6HnPVmirCaKHS9A6f+yJXU/12WgUR8naXLqDqVmX1Z
	3Ta0IJQe4A+4s4qmOzJRTv8NOL+ga+e5IzFuEspOhqYakbFdiV1Q8dpjig6OdAP5OfTzXN4c/rR
	o8KmmyeDY+X7UUml3F3KYJPOUgFfghtdGzovOc2LtMWU2EDCxjRFb0I/UaJYMtae/9oCjp89Sko
	zCp9xzx1ZTa0piKPkjgKujuhEQU70x2cCOR0SrIuh75ZpyhahlbeMo9o6AzLww46riDlHMiWNqD
	9eWYfMy44s0bSDl5R2OLXbg3WNE1XCRtUCXg1VABWjkDX0wJT0USRz3RqaYyODwRA4Be5fNkLUd
	P7636mnmH47KfLlwuGKJzmButhccLgHFr/s08m1X7EbsGaQDFbzPHrdcerDrAA2EoXYpOok5z8I
	DxiXRdrxbeUxqjj+bugvmquKNuGmbBPRHHLLpGhRKwVw==
X-Received: by 2002:a05:6214:252d:b0:8bd:59a6:41be with SMTP id 6a1803df08f44-8bd59a644f6mr711156d6.40.1778075783180;
        Wed, 06 May 2026 06:56:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.152.180.195])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d831651sm176335606d6.47.2026.05.06.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:56:22 -0700 (PDT)
Message-ID: <69fb4886.0c0a0220.187bf.3e14@mx.google.com>
Date: Wed, 06 May 2026 06:56:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2053234842820335089=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, n05ec@lzu.edu.cn
Subject: RE: [v4] Bluetooth: serialize accept_q access
In-Reply-To: <20260506114338.2873496-1-n05ec@lzu.edu.cn>
References: <20260506114338.2873496-1-n05ec@lzu.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2053234842820335089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1090423

---Test result---

Test Summary:
CheckPatch                    FAIL      1.02 seconds
GitLint                       FAIL      0.36 seconds
SubjectPrefix                 PASS      2.06 seconds
BuildKernel                   PASS      27.34 seconds
CheckAllWarning               PASS      30.36 seconds
CheckSparse                   PASS      30.05 seconds
BuildKernel32                 PASS      26.21 seconds
TestRunnerSetup               PASS      579.19 seconds
TestRunner_l2cap-tester       FAIL      19.18 seconds
TestRunner_iso-tester         PASS      311.73 seconds
TestRunner_bnep-tester        FAIL      18.56 seconds
TestRunner_mgmt-tester        FAIL      23.55 seconds
TestRunner_rfcomm-tester      PASS      41.44 seconds
TestRunner_sco-tester         PASS      80.71 seconds
TestRunner_ioctl-tester       FAIL      50.29 seconds
TestRunner_mesh-tester        PASS      39.76 seconds
TestRunner_smp-tester         PASS      18.82 seconds
TestRunner_userchan-tester    PASS      20.32 seconds
TestRunner_6lowpan-tester     PASS      35.31 seconds
IncrementalBuild              PASS      25.46 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4] Bluetooth: serialize accept_q access
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#91: 
Reported-by: Jann Horn <jannh@google.com>
Reported-by: Yuan Tan <yuantan098@gmail.com>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#92: 
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#93: 
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#94: 
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#95: 
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>

total: 0 errors, 5 warnings, 0 checks, 170 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14557166.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: serialize accept_q access

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
28: B1 Line exceeds max length (119>80): "  https://patchwork.kernel.org/project/bluetooth/patch/20260504-bluetooth-accept-uaf-fix-v1-1-1ca63c0efadd@google.com/,"
31: B1 Line exceeds max length (81>80): "- v3 Link: https://lore.kernel.org/all/20260404162324.2789862-1-n05ec@lzu.edu.cn/"
37: B1 Line exceeds max length (120>80): "- v2 Link: https://lore.kernel.org/all/06a6b4549acba207847ce532dedbf1c95ab22d13.1774925231.git.wangjiexun2025@gmail.com/"
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
==33==    by 0x12C99F: tester_run (tester.c:1085)
==33==    by 0x111CB3: main (bnep-tester.c:298)
==33==  Address 0x50 is not stack'd, malloc'd or (recently) free'd
==33== 
==33== 
==33== Process terminating with default action of signal 11 (SIGSEGV)
==33==  Access not within mapped region at address 0x50
==33==    at 0x125C44: bthost_set_cmd_complete_cb (bthost.c:3487)
==33==    by 0x111F42: setup_powered_client_callback (bnep-tester.c:244)
==33==    by 0x127F00: request_complete (mgmt.c:320)
==33==    by 0x1288B5: can_read_data (mgmt.c:408)
==33==    by 0x12B328: watch_callback (io-glib.c:173)
==33==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x12CFA8: mainloop_run (mainloop-glib.c:65)
==33==    by 0x12D3DF: mainloop_run_with_signal (mainloop-notify.c:196)
==33==    by 0x12C99F: tester_run (tester.c:1085)
==33==    by 0x111CB3: main (bnep-tester.c:298)
==33==  If you believe this happened as a result of a stack
==33==  overflow in your program's main thread (unlikely but
==33==  possible), you can try to increase the size of the
==33==  main thread stack using the --main-stacksize= flag.
==33==  The main thread stack size used in this run was 8388608.
==33== 
Valgrind errors:
==33==    by 0x111F42: setup_powered_client_callback (bnep-tester.c:244)
==33==    by 0x127F00: request_complete (mgmt.c:320)
==33==    by 0x1288B5: can_read_data (mgmt.c:408)
==33==    by 0x12B328: watch_callback (io-glib.c:173)
==33==    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
==33==    by 0x12CFA8: mainloop_run (mainloop-glib.c:65)
==33==    by 0x12D3DF: mainloop_run_with_signal (mainloop-notify.c:196)
==33==    by 0x12C99F: tester_run (tester.c:1085)
==33==    by 0x111CB3: main (bnep-tester.c:298)
==33==  If you believe this happened as a result of a stack
==33==  overflow in your program's main thread (unlikely but
==33==  possible), you can try to increase the size of the
==33==  main thread stack using the --main-stacksize= flag.
==33==  The main thread stack size used in this run was 8388608.
==33== 
==33== HEAP SUMMARY:
==33==     in use at exit: 25,333 bytes in 82 blocks
==33==   total heap usage: 237 allocs, 155 frees, 39,167 bytes allocated
==33== 
==33== LEAK SUMMARY:
==33==    definitely lost: 0 bytes in 0 blocks
==33==    indirectly lost: 0 bytes in 0 blocks
==33==      possibly lost: 0 bytes in 0 blocks
==33==    still reachable: 25,333 bytes in 82 blocks
==33==         suppressed: 0 bytes in 0 blocks
==33== Rerun with --leak-check=full to see details of leaked memory
==33== 
==33== For lists of detected and suppressed errors, rerun with: -s
==33== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)
Crash detected:
==33==         suppressed: 0 bytes in 0 blocks
==33== Rerun with --leak-check=full to see details of leaked memory
==33== 
==33== For lists of detected and suppressed errors, rerun with: -s
==33== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)
Segmentation fault
Process 32 exited with status 139
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
Device List                                          Timed out  -31.835 seconds
Device Info                                          Timed out   -6.933 seconds
Reset Stat                                           Timed out   -6.940 seconds
Set Link Mode - ACCEPT                               Timed out   -6.946 seconds
Set Pkt Type - DM                                    Timed out  -15.222 seconds
Set Pkt Type - DH                                    Timed out  -15.230 seconds
Set Pkt Type - HV                                    Timed out  -15.236 seconds
Set Pkt Type - 2-DH                                  Timed out  -15.245 seconds
Set Pkt Type - 2-DH                                  Timed out  -15.253 seconds
Set Pkt Type - ALL                                   Timed out  -15.260 seconds
Set ACL MTU - 1                                      Timed out  -15.267 seconds


https://github.com/bluez/bluetooth-next/pull/148

---
Regards,
Linux Bluetooth


--===============2053234842820335089==--
