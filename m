Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9D517993
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170786; cv=none; b=pVkf9/7c9UYb+2gBV1E9Mv5XmmXs0Viqnzw00YR3SiJJvCK0wS2Lv3pOvQg03a8jm2dVCYeez/fL0IYvylHAsJyIFGnqM9OUFR1EreWZEZWGO566uS6IZoVNuOp0cNTdPlBIu6uwzHfN5h6zg7IQSUrHdzqccQahd7aYYoEFZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170786; c=relaxed/simple;
	bh=ES1b7ou7s05Vs0Z/uTTmRsay80q+62UDtrpO4b2ffrA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CLmuhisDcwghvHXibJn+RldkPt4gr6pxGgfvRYSn8mw+8moiFi6olhLFb5wAm9RaWntULNaejkIDD3BjcujZhIzzF7eVVs3bRlp+43Ca+PunDKT6hhiYATH92bcf4layJqKkfdB0edTJcjqGWBnieEEEBAqwWfnMtBxlrn4ZDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtmjihX9; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtmjihX9"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d933da14f0so109255085a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778170783; x=1778775583; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NoEuTeo9Jj24i8dxcMYMX+vLlm3Uv+YBPBcBc5Hi9DY=;
        b=NtmjihX9EJONDet7OramgZMsA66d2QTVPXJjScWyF3hqX8SkoFPQ+y24vt0PFyglgE
         g3a8taAYH5yjGA0YJ/gUYN/oyo1zh3XrkUmVZQg+DWYjoabhWU5j1DnFEFQDq9vUrhwB
         Se8KhFHvs1vyTSKxcpHwx8WPnbrMKmrvthddZvollNFchbah8oWD/6jhsGI3ubBACvVV
         0136XcfXnTB1pNSLFjrViCWuUZGHxOt4IH0DficBwPjrPAi9oa8XqOpx+lVXFYGK9rIf
         Ifr9czam7FI7HxtCirhyeMB6fwFGIHTr7z4YTuYxSNZlD+mqP9ueD2jeuQrQaaYSNeZh
         hCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778170783; x=1778775583;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoEuTeo9Jj24i8dxcMYMX+vLlm3Uv+YBPBcBc5Hi9DY=;
        b=SGXCyZkP3RkiDY20NdO97oUv1HS1QhXeQNKPd4K8Q/cZHW+4afMHm/TMDbKz86vcLu
         T7KzGKtw+CqwSi6QR+hEjem7GehqIZNepywQbSazr0flUPSshf8MIO3kJTzhHwN8FMhw
         jDArg8rVP5cr4IIQ8+kh+lr77cvqgdsbOgAVw1J8PcU1NEOm4hGP0ltzK4WwoyeoYnOW
         SawWIX/A1X6Bkg0QVOMdJNDMAZNlpIqjn5DGXUIqxgEi7If2n8YqiGgMuhttriv7TdPu
         fX0fIpfFU8/1OPklY1abdGtx5HOom2hU1Ahv4HGa+VElRPM6EZX7I4EWBrAVQCUP+ApA
         I0qA==
X-Gm-Message-State: AOJu0Yx8moJaRGOSuNWjINYTLdd/E/Y04b6eqq8ZkH/9eBtBgM+2Z30C
	nQ9lT9vpMUxGXErRZZf1+2+k2C67oy+RPjz2eNr/dqgkn7zfuYv0KZALYTbmmQ==
X-Gm-Gg: AeBDiev5/93D+2HfdAFT49KLsj+rn2QXgt+eMlH4a/7Kl5d/WO4Rijr7umThPGzxAgq
	vGm4n5hsP6j9rD6fCdQF4shlbrQLJc4Xb0ch1J4VnosUXFywmbJ1YeOAb7OkCpWfD8wRiU2XakH
	l4WbXM88P2aXnhtBWOBzHg1uNGcZDuLpqJmPpUpJRvoQ5InHPd01ipL/A2UclaQ18WVyHY0/xMw
	iLZt/l0wQidmI02kaPlr0qv6i6ciO/6LdBmBeNwQgbkge4ckStveCnRt/12oOXSkqhEdEteLhOW
	AZTyDvZ2k54aae9Vsdj+3TCJthWOnss7JkxfjnX7fHb6llcNJTgr/65OBWVE0dMQxh+VHb36Hc1
	YuiRkIW+CKbnJHEoQc5i98FIdY2kceI0k6n0+GCHhPssCPVvODLhqVP/tgYJNPcXtb0nVDlVR+e
	4uqTqiy+vUgl5bm/Z5tb7marrVTMoBEv+V
X-Received: by 2002:a05:620a:2586:b0:8eb:605f:6ccf with SMTP id af79cd13be357-904d4b58d72mr1253203485a.17.1778170782565;
        Thu, 07 May 2026 09:19:42 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.184.217])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29a80784sm1969787485a.12.2026.05.07.09.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:19:42 -0700 (PDT)
Message-ID: <69fcbb9e.050a0220.376a5e.6216@mx.google.com>
Date: Thu, 07 May 2026 09:19:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3806542287699436031=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: Support for block device NVMEM providers
In-Reply-To: <20260507-block-as-nvmem-v2-1-bf17edd5134e@oss.qualcomm.com>
References: <20260507-block-as-nvmem-v2-1-bf17edd5134e@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3806542287699436031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1091131

---Test result---

Test Summary:
CheckPatch                    FAIL      6.79 seconds
GitLint                       FAIL      7.79 seconds
SubjectPrefix                 FAIL      0.88 seconds
BuildKernel                   PASS      26.57 seconds
CheckAllWarning               PASS      29.41 seconds
CheckSparse                   PASS      28.88 seconds
BuildKernel32                 PASS      26.60 seconds
TestRunnerSetup               PASS      578.47 seconds
TestRunner_l2cap-tester       FAIL      18.90 seconds
TestRunner_iso-tester         PASS      311.40 seconds
TestRunner_bnep-tester        FAIL      18.63 seconds
TestRunner_mgmt-tester        FAIL      23.51 seconds
TestRunner_rfcomm-tester      PASS      41.48 seconds
TestRunner_sco-tester         PASS      80.61 seconds
TestRunner_ioctl-tester       FAIL      50.25 seconds
TestRunner_mesh-tester        PASS      39.48 seconds
TestRunner_smp-tester         PASS      18.56 seconds
TestRunner_userchan-tester    FAIL      18.58 seconds
TestRunner_6lowpan-tester     PASS      35.03 seconds
IncrementalBuild              PASS      54.54 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,4/8] block: implement NVMEM provider
WARNING: please write a help paragraph that fully describes the config symbol with at least 4 lines
#207: FILE: block/Kconfig:212:
+config BLK_NVMEM
+	bool "Block device NVMEM provider"
+	depends on OF
+	depends on NVMEM
+	help
+	  Allow block devices (or partitions) to act as NVMEM providers,
+	  typically used with eMMC to store MAC addresses or Wi-Fi
+	  calibration data on embedded devices.
+

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#229: 
new file mode 100644

total: 0 errors, 2 warnings, 244 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14559647.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,8/8] arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[v2,8/8] arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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
Device List                                          Timed out  -31.790 seconds
Device Info                                          Timed out   -6.931 seconds
Reset Stat                                           Timed out   -6.938 seconds
Set Link Mode - ACCEPT                               Timed out   -6.945 seconds
Set Pkt Type - DM                                    Timed out  -15.213 seconds
Set Pkt Type - DH                                    Timed out  -15.219 seconds
Set Pkt Type - HV                                    Timed out  -15.225 seconds
Set Pkt Type - 2-DH                                  Timed out  -15.234 seconds
Set Pkt Type - 2-DH                                  Timed out  -15.241 seconds
Set Pkt Type - ALL                                   Timed out  -15.247 seconds
Set ACL MTU - 1                                      Timed out  -15.253 seconds
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


https://github.com/bluez/bluetooth-next/pull/152

---
Regards,
Linux Bluetooth


--===============3806542287699436031==--
