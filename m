Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935A392836
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471526; cv=none; b=WdpGRtm5aL0RVlHJOyW2PBCKHCDWCFnZeKyBad9BzQHTyxDk3uDLkw5nBOJbTWuHvUK2WRcl6vnEwiWJ4pHS0OZMz9d0c5rsBte50VfRkCuS9B5c3bZXeO4OZUG+nnlKvzaWa11N9Aunl8it2uG4aAr6awSdxX0FKCBMNggnLRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471526; c=relaxed/simple;
	bh=adeEPVRxPkxQDRpgX8HvRPvkBCbPtHIvz7jeiLtKcVg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OwgQEKya/EgH9ASHR2mNuSRfRpee9/u9s49q4kYEeN/wFcifmSXgNWi5idjBSsXzrAs5EWuL1tLN9+43KZosgI6AONQgUv+yFQfPHrQmBV4qo07XtfwvvV1D/VJWKE3fnkRHylNpG+jydAG1zSMaGntByVTLz1P6hJZlnhbSTX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Byy9imil; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byy9imil"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso2254589a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789471522; x=1790076322; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IkB2PvTtoDoJbcvtIJTamKWs4SSqjQV4c4Xq5PDdmxw=;
        b=Byy9imiluCDiMBhboAB+c2H2NLqHDOnQq//kUMdO1WAs8sZDUsHkxIF7i+b6EWetwV
         60vb2RyfCoLc7uRgoarrkm3tFnxRNfs5QiCy5gfMh0B7wegpjC2+9yoyGT5SoGcJFiYS
         ffRAn7UOiveRsC4l0A9MhyWvFOL69ttxXzwDEfayeLvOtZ5qmFYKLEmxPYvpAstL0Ofa
         R/KbOgPJgxp9L6Pb4QGikY9DNgMh6X+IHbEFxyeWPQNz5xqUap7KDBZgZTQ6DyKY24WG
         ccAUzxTAHxceDIn+bEQbHiCGkXXHQEBZLnKaD5pGJacmjSNdSwTygxKlx6QV8e1mFdhS
         IFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789471522; x=1790076322;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IkB2PvTtoDoJbcvtIJTamKWs4SSqjQV4c4Xq5PDdmxw=;
        b=Wwu+XJyxZDaO1OlKparOoaX5NwY4PqEiomnsBE/E+VH0U/PqCGqLAWxk6cZfgLlXDk
         EpebdrkaXZDl9wKKOOiI40ebqZ2n/bC1/xXZccm3Cx+AXLA95d52sHV22f1BO+buSaM3
         NIrvrPcfjYtW7ei+FmZq9JlveVqLFFY94wXVBU9HzyvavPeTBGR5w6fkC+HDdrbJg65z
         2sN8U4Wu8+Kw7i45HL54AygGIzvHjHsKBHy9TIxoiCt6OuJdAa1bH0/zZnleS1VeJYI+
         dR1y2MgWt92RKdopjvDuqTqbZPpZ53X69o8OGuPvVMwY310PN7O9U0mNEwFbgR8h+YZP
         b3RA==
X-Gm-Message-State: AFuF++kcJlex1mLjL36PedpkxaSBCMjnAdAzgYmzmNMKD28fYTKol7ih
	CT3207jnoagv1dsMCz6xtz2QkA+LLjCM0SIS2MWHY+Yfi4lGPVzzGtbIwMSk/Q==
X-Gm-Gg: AYBFou0G+X4nN/wrXkfrlYE6k9lp8T2hrrxxxC19iII89uMCAMGXYTsQWDIh5kEHpgk
	+0PMOFno61YG52RoPae5CoT8tbs/fCPRI+vh1di3HTlw8TyUW4B/CGvl7/9PclxMNNv+vvSKyXj
	dd4qKdpIR7qjOnonUIVC8cXBVfRJnjIWIout7ncF4LlFNDsmpHvIyTgsdGAKePSwXjizX87fxny
	bZKZQWOdFH4i5c+LQOPebqtXLTQzst1atd3hMAOYg5YHg7VYevectyPhUJsmgcCILKHJyukt9jA
	OUaRzNy4VHUn5fbGYiOk9jwkt7VZOW5TcJ+jpsOZXC8tuElcCGZ7eymwkyJSWsLblMCRp8BRC67
	THwOn4rb6pQlJS2HZolh/QiOqqBW5FAMzvolMoaqU+tzUoMtXQ7bZeXLHgKGQlmAPHWxFv62enQ
	xOgWoAK1ljL356mWPj5UyTLDweVIanrnhDLd7PXOG8VLeX4d/OH/TF/OaRUN1XbxVPkiZW+Tc0r
	/V4ow==
X-Received: by 2002:a17:90b:5247:b0:39e:b15:7950 with SMTP id 98e67ed59e1d1-39e0b157b06mr2536198a91.23.1789471521875;
        Tue, 15 Sep 2026 04:25:21 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.129.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a3casm32510034eec.12.2026.09.15.04.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:25:21 -0700 (PDT)
Message-ID: <6aa92b21.496fef5b.20c939.2257@mx.google.com>
Date: Tue, 15 Sep 2026 04:25:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5405349406724716385=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: monitor: Fix heap-buffer-overflows triggered by HCI devcoredump
In-Reply-To: <20260915-fix_heap_overflow-v1-1-8fc39dbcb303@oss.qualcomm.com>
References: <20260915-fix_heap_overflow-v1-1-8fc39dbcb303@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5405349406724716385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1165307/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.69 seconds
GitLint                       FAIL      0.49 seconds
BuildEll                      PASS      19.19 seconds
BluezMake                     PASS      373.53 seconds
MakeCheck                     PASS      0.85 seconds
MakeDistcheck                 PASS      138.00 seconds
CheckValgrind                 PASS      144.17 seconds
CheckSmatch                   PASS      291.46 seconds
bluezmakeextell               PASS      92.06 seconds
TestFunctional                FAIL      1075.56 seconds
IncrementalBuild              PASS      380.35 seconds
ScanBuild                     PASS      1107.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/2] monitor: Fix btmon heap-buffer-overflow triggered by HCI devcoredump
WARNING:COMMIT_COMMENT_SYMBOL: Commit log lines starting with '#' are dropped by git as comments
#172: 
#define BTSNOOP_MAX_PACKET_SIZE            (1486 + 4)

WARNING:COMMIT_LOG_LONG_LINE: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#182: 
ERROR: AddressSanitizer: heap-buffer-overflow on address 0x51b00000065c at pc 0x7f50b987a029 bp 0x7ffde88dc8d0 sp 0x7ffde88dc088

/github/workspace/src/patch/14817038.patch total: 0 errors, 2 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14817038.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,2/2] tools: Fix btmon-logger heap-buffer-overflow triggered by HCI devcoredump
WARNING:COMMIT_LOG_LONG_LINE: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#160: 
btmon-logger uses @len to access the payload in @buf without validating that

WARNING:COMMIT_COMMENT_SYMBOL: Commit log lines starting with '#' are dropped by git as comments
#173: 
#define BTSNOOP_MAX_PACKET_SIZE            (1486 + 4)

/github/workspace/src/patch/14817037.patch total: 0 errors, 2 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14817037.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/2] monitor: Fix btmon heap-buffer-overflow triggered by HCI devcoredump

12: B3 Line contains hard tab characters (\t): "	__le16  opcode;"
13: B3 Line contains hard tab characters (\t): "	__le16  index;"
14: B3 Line contains hard tab characters (\t): "	__le16  len;"
21: B3 Line contains hard tab characters (\t): "	uint16_t channel;"
22: B3 Line contains hard tab characters (\t): "	int fd;"
23: B3 Line contains hard tab characters (\t): "	unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];"
24: B3 Line contains hard tab characters (\t): "	uint16_t offset;"
28: B1 Line exceeds max length (128>80): "ERROR: AddressSanitizer: heap-buffer-overflow on address 0x51b00000065c at pc 0x7f50b987a029 bp 0x7ffde88dc8d0 sp 0x7ffde88dc088"
30: B1 Line exceeds max length (115>80): "    #0 0x7f50b987a028 in write ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:1096"
34: B1 Line exceeds max length (85>80): "    #4 0x5b4f34451da6 in mainloop_run_with_signal ../src/shared/mainloop-notify.c:196"
36: B1 Line exceeds max length (89>80): "    #6 0x7f50b8c2a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58"
38: B1 Line exceeds max length (109>80): "    #8 0x5b4f34295ed4 in _start (/usr/bin/btmon+0x29fed4) (BuildId: b41caafb24db693946c283eaea48112186863d2d)"
[BlueZ,2/2] tools: Fix btmon-logger heap-buffer-overflow triggered by HCI devcoredump

1: T1 Title exceeds max length (85>80): "[BlueZ,2/2] tools: Fix btmon-logger heap-buffer-overflow triggered by HCI devcoredump"
12: B3 Line contains hard tab characters (\t): "	__le16  opcode;"
13: B3 Line contains hard tab characters (\t): "	__le16  index;"
14: B3 Line contains hard tab characters (\t): "	__le16  len;"
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_kernel_testers::test_kernel_selftest[hosts11-vm1-noc]: failed on setup with "ConnectionResetError: [Errno 104] Connection reset by peer"
FAIL functional.test_adv_monitor::test_adv_monitor_GHSA_hhgc_hfgf_8m4x[hosts1-vm1]: failed on setup with "ConnectionResetError: [Errno 104] Connection reset by peer"
FAIL functional.test_btmgmt::test_btmgmt_info[hosts10-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteTimeoutError: Failed to establish connection"
FAIL functional.test_bluetoothctl::test_bluetoothctl_show[hosts7-vm1]: failed on setup with "ConnectionResetError: [Errno 104] Connection reset by peer"
FAIL functional.test_bluetoothctl::test_bluetoothctl_list[hosts7-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteTimeoutError: Failed to establish connection"
FAIL functional.test_bluetoothctl::test_bluetoothctl_script_show[hosts7-vm1]: failed on setup with "ConnectionResetError: [Errno 104] Connection reset by peer"
FAIL functional.test_bluetoothctl::test_bluetoothctl_script_list[hosts7-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteTimeoutError: Failed to establish connection"
FAIL functional.test_a2dp::test_a2dp_transport_created[hosts0-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_a2dp::test_a2dp_transport_acquire[hosts0-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_obex::test_obex_ftp_list[hosts12-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_obex::test_obex_ftp_get[hosts12-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_obex::test_obexctl_list[hosts12-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_agent::test_agent_pair_bredr[accept-hosts2-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_agent::test_agent_pair_bredr[reject-hosts2-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_avrcp::test_avrcp_GHSA_m2vx_pw5f_rc8v[hosts3-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bap::test_bap_unicast_transport_created[hosts4-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bap::test_bap_unicast_transport_acquire[hosts4-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bap::test_bap_broadcast_transport_created[lc3-hosts5-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bap::test_bap_broadcast_transport_created[pbp-hosts5-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bap::test_bap_broadcast_transport_acquire[lc3-hosts5-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bap::test_bap_broadcast_transport_acquire[pbp-hosts5-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bap::test_bass_past_transport_acquire[hosts6-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts8-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_le[hosts9-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"


https://github.com/bluez/bluez/pull/2530

---
Regards,
Linux Bluetooth


--===============5405349406724716385==--
