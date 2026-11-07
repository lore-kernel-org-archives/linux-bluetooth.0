Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794094837;
	b=5KZSx0kbPJS79r4uLdpTr/fdXJLmyyZhmshAGeK4W9SvJhI+oulVT0sVBHc1bpMUPT6o
	 aq5DyIM/4gy9hLrt22tHPL6tK0vcIHPTNuksR6IZ3Wcda3d5Gio9zbc4Xw4TuHaelrb0l
	 lIm2Iwt+jlqcBfo7/DUo4uvamD1/LVndV6UlKiQHX7nE742PXA3zb0u8qc+jnf6zvTTt7
	 mNHmAMmI0RxkiU0Hs4CJnZaCWokCOamLxsUuDHWpOWowGjsIf4ZuvF3BMK2nCokfLDLUV
	 71lriCH0zkd8tQfX09LJ4hGhOHdyvZJzvFsjSKWoT5jOon8iE9zJPVYjbFXU/3+sgPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794094837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=yWWze8F6KEdM1oNZAdPBr7kDV3NLCZuA8LNJVL/Xaag=;
	b=jDZXvIWb47bmmBuMfNK/nABkqekBAfFdCIM9FMQAor0wIqKKP+1KKgV4iAj0G0oHFr3a
	 +rISeQXm6QCLzjSFgAsMJ3S+fBAkR0MccZpnXiJ8m3Xhvkdd7SnpMayuRxomlMDkDda85
	 waX7PwZ11JfzYGMOTUJLlmDLnIGzFeCQJXkXJ9Yzz6OSwSFyV0ZLfO+MSDaT/NiiVfRPZ
	 XM1GUDdXFxxV+A1/ks1BVzyK4gIfNatpDnJoAE2WTHd2hFkzdJLV2E5eEQyMmnTE4MZWD
	 22ATiu1RLKvtFIAGSwqQElZeCk5D6E01DDxHeyPLoMqOfO6EM50/3WnKwUj8OGKit1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VT7+uuAT;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F44606A326
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 23:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6F44606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VT7+uuAT
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36fb88ea38cso938442eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2026 15:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794094836; x=1794699636; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yWWze8F6KEdM1oNZAdPBr7kDV3NLCZuA8LNJVL/Xaag=;
        b=VT7+uuATbzZb+t5104o013IymE04AKMqDCh8eg+tzMgHtto9WpcEpc3OxCYAztUKzV
         tZsPEdwgpziekJBVIXSnFFYA5dfr0DrQPSFCkF20MBX55CjGe+4oBM9hbinRnyE7sPWw
         HjRpmFjUli3K28zwYkrDBmG8m4dWJfZT9oTUcQksun5W7bt/gJPhRtJJnwklCXuLNvtL
         Vi6Cpz30NQxf7+prt/LsLCrNrMqM2Bu+spAvmng7iNmpo9lo4K7YpY/Bh0Tbfs5H7tkT
         WmdaxjBkicD5pH8PoTT2jiWwUi9TbJyeg6OTbzzzWgvh5BlLD/hGSj4BvkA+uW6wfVqt
         0dIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794094836; x=1794699636;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yWWze8F6KEdM1oNZAdPBr7kDV3NLCZuA8LNJVL/Xaag=;
        b=TM83rWn3+44euIsil2pStI2apidhO5eX93UqAiiiEFaR4wMaQ3HEazTikQdH2l6Ws4
         9XTSm+9TWQhh9pja5Ph0/R6haGtbrB4F3VfdGSot0h5K9SnLhWD2/X0geAWDgDjln1CE
         BgprztR/RmDcKaoqpr3F3VkIgLJ1DuzFupfzJ0HKo61En1tFsy/6+e+vzXxb+RMLP1cY
         iegTWbSGds17Hor2haJNJBB6HxZTx01GiOKcCl7oR88+Nc3LcPieasWuDfijF6v5wIyh
         CRuCKv453GiJD4iZsZXVnFCfooG5jyVVdWqlWvz1u5sj4O6eP3ztd86Xwv+BvXVCMkec
         +gYg==
X-Gm-Message-State: APuU4Z/8TP+VmsacDFTb/1MqNJFbMZ/IyvDtgEvolX/8gC3a3/TL7inE
	lElgF/IKDFhvaHRPLhMdkiiNrg16w9pNbtn9H4pZYDFn7w2gm8RYPqe5IfBnRw==
X-Gm-Gg: AYBFou1o/CI7y+f83viuph8mBR2AGgBsypffSwY6pCygyVAYpETNt8u6lZQTqpBsZpp
	2dRVg8GPGXFZhsEy2dJrlTSmlENdqZ2BrJx7HCSQ7YBnSylwbgOQG0hj1ygZzpd5MXwS+HdQ059
	dnkBS0EKJy3PgtpuXLvcH/VS0/ZBgz849jsBbJPDBNt0KGGsuUmwN8eQXvmRrr16XpRyjTEYRH+
	t/J/ZmWl+YlM9ZmyvHeg2b0FWHXluxzLaALWXhBEI4Tr4E5JY28NhDvl+CAC7rRFVR7xoAQyzSq
	F1zCXUCKilo4oexl8Eo5isQP0oTBVzddIeZ1fYAbafG+IlPWNiNPvMtd/GpN/1rbBRS34AQuCB7
	OzfKJgWMwUszGUYBnkzTOT29BmflHWWn7OlgaHKWxW1nOmVEo1zKwf8koe7Mg5FtZkMJuwVZrJL
	GTWtG6H5c3Eky3eOlxu79iKsu++GXiBFbfqlnGgd6m6EJ4xXDyzG+lhZkujJdv7OBHEYLcsHTGR
	j4nNYeQXX8u4V3OqJmPU8vOiH2DCJPRQRhyVYjRzIl9T2qrk9nNgjkioeRROA==
X-Received: by 2002:a05:693c:808f:b0:36e:ca05:8c3c with SMTP id 5a478bee46e88-370f418a6aemr5779129eec.2.1794094834939;
        Sat, 07 Nov 2026 15:40:34 -0800 (PST)
Received: from [172.17.0.2] ([20.169.62.136])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372660f385bsm1053044eec.20.2026.11.07.15.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 15:40:34 -0800 (PST)
Message-ID: <6aefb6f2.dec19f78.260287.c037@mx.google.com>
Date: Sat, 07 Nov 2026 15:40:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6529386950902476759=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add support for HDT and EKS
In-Reply-To: <20261107214611.388705-2-luiz.dentz@gmail.com>
References: <20261107214611.388705-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6529386950902476759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1205124/

---Test result---

Test Summary:
CheckPatch                    FAIL      7.37 seconds
GitLint                       PASS      2.77 seconds
BuildEll                      PASS      16.78 seconds
BluezMake                     PASS      232.20 seconds
MakeCheck                     PASS      13.56 seconds
MakeDistcheck                 PASS      119.78 seconds
CheckValgrind                 PASS      282.56 seconds
CheckSmatch                   WARNING   235.53 seconds
bluezmakeextell               PASS      77.74 seconds
TestFunctional                FAIL      992.24 seconds
IncrementalBuild              PASS      626.47 seconds
ScanBuild                     PASS      874.23 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v6,01/11] monitor: Use __packed in bt.h and its users
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#229: FILE: monitor/bt.h:16:
+#define __packed __attribute__((packed))

/home/runner/work/bluez/bluez/src/patch/14961324.patch total: 0 errors, 1 warnings, 4719 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14961324.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v6,10/11] l2cap-tester, iso-tester, mgmt-tester: Add HDT tests
WARNING:MACRO_ARG_UNUSED: Argument 'name' is not used in function-like macro
#417: FILE: tools/iso-tester.c:958:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

WARNING:MACRO_ARG_UNUSED: Argument 'setup' is not used in function-like macro
#417: FILE: tools/iso-tester.c:958:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

WARNING:MACRO_ARG_UNUSED: Argument 'func' is not used in function-like macro
#417: FILE: tools/iso-tester.c:958:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

/home/runner/work/bluez/bluez/src/patch/14961332.patch total: 0 errors, 3 warnings, 3018 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14961332.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:707:28: warning: Variable length array is used.emulator/bthost.c:708:32: warning: Variable length array is used.emulator/bthost.c:961:28: warning: Variable length array is used.emulator/bthost.c:995:28: warning: Variable length array is used.emulator/bthost.c:996:32: warning: Variable length array is used.monitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresemulator/bthost.c:707:28: warning: Variable length array is used.emulator/bthost.c:708:32: warning: Variable length array is used.emulator/bthost.c:961:28: warning: Variable length array is used.emulator/bthost.c:995:28: warning: Variable length array is used.emulator/bthost.c:996:32: warning: Variable length array is used.src/main.c: note: in included file (through src/device.h):
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bearer::test_bearer_le_conn_update[hosts14-vm2]: failed on teardown with "pytest_bluezenv.plugin.CoredumpWarning: Core dump: test-bluezenv-hosts14.1-bluetoothd-1794093090-189.core
        /usr/bin/gdb: warning: Couldn't determine a path for the index cache directory.
        [New LWP 189]
        [Thread debugging using libthread_db enabled]
        Using host libthread_db library "/usr/lib/x86_64-linux-gnu/libthread_db.so.1".
        Core was generated by `/home/runner/work/bluez/bluez/src/src/src/bluetoothd --nodetach -f /run/bluetoo'.
        Program terminated with signal SIGABRT, Aborted.
        #0  __pthread_kill_implementation (threadid=<optimized out>, signo=6, no_tid=0) at ./nptl/pthread_kill.c:44

        warning: 44	./nptl/pthread_kill.c: No such file or directory

        Thread 1 (Thread 0x7fc47412f900 (LWP 189)):
        #0  __pthread_kill_implementation (threadid=<optimized out>, signo=6, no_tid=0) at ./nptl/pthread_kill.c:44
                tid = <optimized out>
                ret = 0
                pd = <optimized out>
                old_mask = {__val = {0}}
                ret = <optimized out>
        #1  __pthread_kill_internal (threadid=<optimized out>, signo=6) at ./nptl/pthread_kill.c:89
        No locals.
        #2  __GI___pthread_kill (threadid=<optimized out>, signo=signo@entry=6) at ./nptl/pthread_kill.c:100
        No locals.
        #3  0x00007fc47488ab7e in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
                ret = <optimized out>
        #4  0x00007fc47486d8ec in __GI_abort () at ./stdlib/abort.c:77
                act = {__sigaction_handler = {sa_handler = 0x0, sa_sigaction = 0x0}, sa_mask = {__val = {0 <repeats 16 times>}}, sa_flags = 0, sa_restorer = 0x0}
        #5  0x00007fc475495a0f in __sanitizer::Abort () at ../../../../src/libsanitizer/sanitizer_common/sanitizer_posix_libcdep.cpp:165
        No locals.
        #6  0x00007fc4755bbc2d in __sanitizer::Die () at ../../../../src/libsanitizer/sanitizer_common/sanitizer_termination.cpp:58
        No locals.
        #7  0x00007fc47559093c in __asan::ScopedInErrorReport::~ScopedInErrorReport (this=0x7fff46d5c2e6) at ../../../../src/libsanitizer/asan/asan_report.cpp:221
                buffer_copy = {buffer_ = {<__sanitizer::InternalMmapVectorNoCtor<char, false>> = {data_ = 0x7bc46e3f3000 '=' <repeats 65 times>, "\n==189==ERROR: AddressSanitizer: heap-use-after-free on address 0x7cd4735e1720 at pc 0x555a065ee48d bp 0x7fff46d5cf60 sp 0x7fff46d5cf50"..., capacity_bytes_ = 8192, size_ = 4282}, <No data fields>}}
                buffer_copy = <optimized out>
                l = <optimized out>
        #8  0x00007fc47558fe02 in __asan::ReportGenericError (pc=93845142299789, bp=140734381805408, sp=sp@entry=140734381805392, addr=137251910457120, is_write=is_write@entry=false, access_size=8, fatal=true, exp=<optimized out>) at ../../../../src/libsanitizer/asan/asan_report.cpp:536
                in_report = {error_report_lock_ = {<No data fields>}, static current_error_ = {kind = __asan::kErrorKindGeneric, {Base = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, DeadlySignal = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, signal = {siginfo = 0x5b33df1d00000002, context = 0x7cd4735e1720, addr = 0, pc = 0, sp = 6137508266440, bp = 137251910457120, is_memory_access = 96, write_flag = __sanitizer::SignalContext::Unknown, is_true_faulting_addr = 192}}, DoubleFree = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, second_free_stack = 0x5b33df1d00000002, addr_description = {addr = 137251910457120, alloc_tid = 0, free_tid = 0, alloc_stack_id = 456, free_stack_id = 1429, chunk_access = {bad_addr = 137251910457120, offset = 96, chunk_begin = 137251910457024, chunk_size = 232, user_requested_alignment = 8, access_type = 2, alloc_type = 1}}}, NewDeleteTypeMismatch = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, free_stack = 0x5b33df1d00000002, addr_description = {addr = 137251910457120, alloc_tid = 0, free_tid = 0, alloc_stack_id = 456, free_stack_id = 1429, chunk_access = {bad_addr = 137251910457120, offset = 96, chunk_begin = 137251910457024, chunk_size = 232, user_requested_alignment = 8, access_type = 2, alloc_type = 1}}, delete_size = 140481731254640, delete_alignment = 140734381803504}, FreeNotMalloced = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, free_stack = 0x5b33df1d00000002, addr_description = {data = {kind = 1935546144, {shadow = {addr = 0, kind = __asan::kShadowKindLow, shadow_byte = 0 '\000'}, heap = {addr = 0, alloc_tid = 0, free_tid = 6137508266440, alloc_stack_id = 1935546144, free_stack_id = 31956, chunk_access = {bad_addr = 96, offset = 137251910457024, chunk_begin = 232, chunk_size = 140733193412616, user_requested_alignment = 2416, access_type = 1, alloc_type = 1}}, stack = {addr = 0, tid = 0, offset = 6137508266440, frame_pc = 137251910457120, access_size = 96, frame_descr = 0x7cd4735e16c0 "\225\005"}, global = {addr = 0, static kMaxGlobals = 4, globals = {{beg = 0, size = 6137508266440, size_with_redzone = 137251910457120, name = 0x60 <error: Cannot access memory at address 0x60>, module_name = 0x7cd4735e16c0 "\225\005", has_dynamic_init = 232, gcc_location = 0x7fff00006008, odr_indicator = 140481731254640}, {beg = 140734381803504, size = 2, size_with_redzone = 140481759748032, name = 0x7ca4735e0b90 "\003\021", module_name = 0x7fff46d5c7c0 "\020\320\325F\377\177", has_dynamic_init = 140481758099256, gcc_location = 0xa0, odr_indicator = 137045752023952}, {beg = 140481733808336, size = 140734381803488, size_with_redzone = 137045752023968, name = 0x555a06502a00 <device_free> "\363\017\036\372USH\211\373H\203\354\030H\205\377\017\204-\n", module_name = 0x7fff46d5d0f0 "", has_dynamic_init = 136083659412832, gcc_location = 0x7fff46d5d010, odr_indicator = 140481759028161}, {beg = 140734381803488, size = 130805806722, size_with_redzone = 140734381803504, name = 0x2 <error: Cannot access memory at address 0x2>, module_name = 0x7fc475582400 <___interceptor_free(void*)+176> "D\213\215\314\367\377\377E\205\311t4H\211m\330A\203\371\001tzE\017\276\3061\311H\211\352H\211\306H\215\275\320\367\377\377\3502\026\001", has_dynamic_init = 93845141246712, gcc_location = 0x7fff46d5cff0, odr_indicator = 140734381805312}}, reg_sites = {1956994528, 32708, 1955818339, 32708}, access_size = 1, size = 141 '\215'}, wild = {addr = 0, access_size = 0}}}}}, AllocTypeMismatch = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, dealloc_stack = 0x5b33df1d00000002, alloc_type = 1935546144, dealloc_type = 31956, addr_description = {data = {kind = __asan::kAddressKindWild, {shadow = {addr = 0, kind = (unknown: 0xc8), shadow_byte = 1 '\001'}, heap = {addr = 0, alloc_tid = 6137508266440, free_tid = 137251910457120, alloc_stack_id = 96, free_stack_id = 0, chunk_access = {bad_addr = 137251910457024, offset = 232, chunk_begin = 140733193412616, chunk_size = 140481731254640, user_requested_alignment = 2032, access_type = 0, alloc_type = 3}}, stack = {addr = 0, tid = 6137508266440, offset = 137251910457120, frame_pc = 96, access_size = 137251910457024, frame_descr = 0xe8 <error: Cannot access memory at address 0xe8>}, global = {addr = 0, static kMaxGlobals = 4, globals = {{beg = 6137508266440, size = 137251910457120, size_with_redzone = 96, name = 0x7cd4735e16c0 "\225\005", module_name = 0xe8 <error: Cannot access memory at address 0xe8>, has_dynamic_init = 140733193412616, gcc_location = 0x7fc473b05970, odr_indicator = 140734381803504}, {beg = 2, size = 140481759748032, size_with_redzone = 137045752023952, name = 0x7fff46d5c7c0 "\020\320\325F\377\177", module_name = 0x7fc47549f738 <__sanitizer::Quarantine<__asan::QuarantineCallback, __asan::AsanChunk>::Put(__sanitizer::QuarantineCache<__asan::QuarantineCallback>*, __asan::QuarantineCallback, __asan::AsanChunk*, unsigned long)+248> "H\203;", has_dynamic_init = 160, gcc_location = 0x7ca4735e0b90, odr_indicator = 140481733808336}, {beg = 140734381803488, size = 137045752023968, size_with_redzone = 93845141334528, name = 0x7fff46d5d0f0 "", module_name = 0x7bc4722dd560 "0W^s4|", has_dynamic_init = 140734381805584, gcc_location = 0x7fc4755823c1 <___interceptor_free(void*)+113>, odr_indicator = 140734381803488}, {beg = 130805806722, size = 140734381803504, size_with_redzone = 2, name = 0x7fc475582400 <___interceptor_free(void*)+176> "D\213\215\314\367\377\377E\205\311t4H\211m\330A\203\371\001tzE\017\276\3061\311H\211\352H\211\306H\215\275\320\367\377\377\3502\026\001", module_name = 0x555a064ed2f8 <gatt_server_cleanup+200> "H\205\333t{\366\303\auvH\211\350H\301\350\003\200\270", has_dynamic_init = 140734381805552, gcc_location = 0x7fff46d5cf00, odr_indicator = 140481747312096}}, reg_sites = {1955818339, 32708, 1, 0}, access_size = 93845142299789, size = 96 '`'}, wild = {addr = 0, access_size = 6137508266440}}}}}, MallocUsableSizeNotOwned = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, addr_description = {data = {kind = 1935546144, {shadow = {addr = 0, kind = __asan::kShadowKindLow, shadow_byte = 0 '\000'}, heap = {addr = 0, alloc_tid = 0, free_tid = 6137508266440, alloc_stack_id = 1935546144, free_stack_id = 31956, chunk_access = {bad_addr = 96, offset = 137251910457024, chunk_begin = 232, chunk_size = 140733193412616, user_requested_alignment = 2416, access_type = 1, alloc_type = 1}}, stack = {addr = 0, tid = 0, offset = 6137508266440, frame_pc = 137251910457120, access_size = 96, frame_descr = 0x7cd4735e16c0 "\225\005"}, global = {addr = 0, static kMaxGlobals = 4, globals = {{beg = 0, size = 6137508266440, size_with_redzone = 137251910457120, name = 0x60 <error: Cannot access memory at address 0x60>, module_name = 0x7cd4735e16c0 "\225\005", has_dynamic_init = 232, gcc_location = 0x7fff00006008, odr_indicator = 140481731254640}, {beg = 140734381803504, size = 2, size_with_redzone = 140481759748032, name = 0x7ca4735e0b90 "\003\021", module_name = 0x7fff46d5c7c0 "\020\320\325F\377\177", has_dynamic_init = 140481758099256, gcc_location = 0xa0, odr_indicator = 137045752023952}, {beg = 140481733808336, size = 140734381803488, size_with_redzone = 137045752023968, name = 0x555a06502a00 <device_free> "\363\017\036\372USH\211\373H\203\354\030H\205\377\017\204-\n", module_name = 0x7fff46d5d0f0 "", has_dynamic_init = 136083659412832, gcc_location = 0x7fff46d5d010, odr_indicator = 140481759028161}, {beg = 140734381803488, size = 130805806722, size_with_redzone = 140734381803504, name = 0x2 <error: Cannot access memory at address 0x2>, module_name = 0x7fc475582400 <___interceptor_free(void*)+176> "D\213\215\314\367\377\377E\205\311t4H\211m\330A\203\371\001tzE\017\276\3061\311H\211\352H\211\306H\215\275\320\367\377\377\3502\026\001", has_dynamic_init = 93845141246712, gcc_location = 0x7fff46d5cff0, odr_indicator = 140734381805312}}, reg_sites = {1956994528, 32708, 1955818339, 32708}, access_size = 1, size = 141 '\215'}, wild = {addr = 0, access_size = 0}}}}}, SanitizerGetAllocatedSizeNotOwned = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, addr_description = {data = {kind = 1935546144, {shadow = {addr = 0, kind = __asan::kShadowKindLow, shadow_byte = 0 '\000'}, heap = {addr = 0, alloc_tid = 0, free_tid = 6137508266440, alloc_stack_id = 1935546144, free_stack_id = 31956, chunk_access = {bad_addr = 96, offset = 137251910457024, chunk_begin = 232, chunk_size = 140733193412616, user_requested_alignment = 2416, access_type = 1, alloc_type = 1}}, stack = {addr = 0, tid = 0, offset = 6137508266440, frame_pc = 137251910457120, access_size = 96, frame_descr = 0x7cd4735e16c0 "\225\005"}, global = {addr = 0, static kMaxGlobals = 4, globals = {{beg = 0, size = 6137508266440, size_with_redzone = 137251910457120, name = 0x60 <error: Cannot access memory at address 0x60>, module_name = 0x7cd4735e16c0 "\225\005", has_dynamic_init = 232, gcc_location = 0x7fff00006008, odr_indicator = 140481731254640}, {beg = 140734381803504, size = 2, size_with_redzone = 140481759748032, name = 0x7ca4735e0b90 "\003\021", module_name = 0x7fff46d5c7c0 "\020\320\325F\377\177", has_dynamic_init = 140481758099256, gcc_location = 0xa0, odr_indicator = 137045752023952}, {beg = 140481733808336, size = 140734381803488, size_with_redzone = 137045752023968, name = 0x555a06502a00 <device_free> "\363\017\036\372USH\211\373H\203\354\030H\205\377\017\204-\n", module_name = 0x7fff46d5d0f0 "", has_dynamic_init = 136083659412832, gcc_location = 0x7fff46d5d010, odr_indicator = 140481759028161}, {beg = 140734381803488, size = 130805806722, size_with_redzone = 140734381803504, name = 0x2 <error: Cannot access memory at address 0x2>, module_name = 0x7fc475582400 <___interceptor_free(void*)+176> "D\213\215\314\367\377\377E\205\311t4H\211m\330A\203\371\001tzE\017\276\3061\311H\211\352H\211\306H\215\275\320\367\377\377\3502\026\001", has_dynamic_init = 93845141246712, gcc_location = 0x7fff46d5cff0, odr_indicator = 140734381805312}}, reg_sites = {1956994528, 32708, 1955818339, 32708}, access_size = 1, size = 141 '\215'}, wild = {addr = 0, access_size = 0}}}}}, CallocOverflow = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, count = 137251910457120, size = 0}, ReallocArrayOverflow = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, count = 137251910457120, size = 0}, PvallocOverflow = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, size = 137251910457120}, InvalidAllocationAlignment = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, alignment = 137251910457120}, InvalidAlignedAllocAlignment = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, size = 137251910457120, alignment = 0}, InvalidPosixMemalignAlignment = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, alignment = 137251910457120}, AllocationSizeTooBig = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, user_size = 137251910457120, total_size = 0, max_size = 0}, RssLimitExceeded = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002}, OutOfMemory = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, requested_size = 137251910457120}, StringFunctionMemoryRangesOverlap = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, length1 = 137251910457120, length2 = 0, addr1_description = {data = {kind = __asan::kAddressKindWild, {shadow = {addr = 6137508266440, kind = (unknown: 0x20), shadow_byte = 23 '\027'}, heap = {addr = 6137508266440, alloc_tid = 137251910457120, free_tid = 96, alloc_stack_id = 1935546048, free_stack_id = 31956, chunk_access = {bad_addr = 232, offset = 140733193412616, chunk_begin = 140481731254640, chunk_size = 140734381803504, user_requested_alignment = 2, access_type = 0, alloc_type = 0}}, stack = {addr = 6137508266440, tid = 137251910457120, offset = 96, frame_pc = 137251910457024, access_size = 232, frame_descr = 0x7fff00006008 <error: Cannot access memory at address 0x7fff00006008>}, global = {addr = 6137508266440, static kMaxGlobals = 4, globals = {{beg = 137251910457120, size = 96, size_with_redzone = 137251910457024, name = 0xe8 <error: Cannot access memory at address 0xe8>, module_name = 0x7fff00006008 <error: Cannot access memory at address 0x7fff00006008>, has_dynamic_init = 140481731254640, gcc_location = 0x7fff46d5c7f0, odr_indicator = 2}, {beg = 140481759748032, size = 137045752023952, size_with_redzone = 140734381803456, name = 0x7fc47549f738 <__sanitizer::Quarantine<__asan::QuarantineCallback, __asan::AsanChunk>::Put(__sanitizer::QuarantineCache<__asan::QuarantineCallback>*, __asan::QuarantineCallback, __asan::AsanChunk*, unsigned long)+248> "H\203;", module_name = 0xa0 <error: Cannot access memory at address 0xa0>, has_dynamic_init = 137045752023952, gcc_location = 0x7fc473d750d0, odr_indicator = 140734381803488}, {beg = 137045752023968, size = 93845141334528, size_with_redzone = 140734381805808, name = 0x7bc4722dd560 "0W^s4|", module_name = 0x7fff46d5d010 "", has_dynamic_init = 140481759028161, gcc_location = 0x7fff46d5c7e0, odr_indicator = 130805806722}, {beg = 140734381803504, size = 2, size_with_redzone = 140481759028224, name = 0x555a064ed2f8 <gatt_server_cleanup+200> "H\205\333t{\366\303\auvH\211\350H\301\350\003\200\270", module_name = 0x7fff46d5cff0 "`\325-r\304{", has_dynamic_init = 140734381805312, gcc_location = 0x7fc474a55de0 <_nl_C_locobj>, odr_indicator = 140481746135907}}, reg_sites = {1, 0, 106882189, 21850}, access_size = 140734381805408, size = 80 'P'}, wild = {addr = 6137508266440, access_size = 137251910457120}}}}, addr2_description = {data = {kind = 8, {shadow = {addr = 140481759459223, kind = __asan::kShadowKindLow, shadow_byte = 253 '\375'}, heap = {addr = 140481759459223, alloc_tid = 140734381817088, free_tid = 140734381805048, alloc_stack_id = 3714491648, free_stack_id = 1530126109, chunk_access = {bad_addr = 140734381805248, offset = 140481759289213, chunk_begin = 136564715706184, chunk_size = 140481759723384, user_requested_alignment = 4095, access_type = 3, alloc_type = 3}}, stack = {addr = 140481759459223, tid = 140734381817088, offset = 140734381805048, frame_pc = 6571841600625222912, access_size = 140734381805248, frame_descr = 0x7fc4755c1f7d <__sanitizer::DTLS_on_tls_get_addr(void*, void*, unsigned long, unsigned long)+125> "I\211\302H\205\300u\035\351\213"}, global = {addr = 140481759459223, static kMaxGlobals = 4, globals = {{beg = 140734381817088, size = 140734381805048, size_with_redzone = 6571841600625222912, name = 0x7fff46d5cec0 "H\024^s\304|", module_name = 0x7fc4755c1f7d <__sanitizer::DTLS_on_tls_get_addr(void*, void*, unsigned long, unsigned long)+125> "I\211\302H\205\300u\035\351\213", has_dynamic_init = 136564715706184, gcc_location = 0x7fc47562bf78, odr_indicator = 65535}, {beg = 6571841600625222912, size = 140481737717944, size_with_redzone = 140481759723384, name = 0x7c24735e7c70 "", module_name = 0x7fff46d5d0f0 "", has_dynamic_init = 136495996238912, gcc_location = 0x7c24735e7c68, odr_indicator = 136495996238960}, {beg = 93845142223156, size = 64, size_with_redzone = 17010457426604, name = 0x7c44735e1620 "@\024^s\304|", module_name = 0x7bc4722dd600 "\0166\340E", has_dynamic_init = 136221118382832, gcc_location = 0x555a065e58e2 <bt_att_chan_cancel+402>, odr_indicator = 11}, {beg = 136495996238960, size = 11, size_with_redzone = 93845142264744, name = 0x7cc4735e1440 "", module_name = 0x7bc4722dd660 "", has_dynamic_init = 17010457426624, gcc_location = 0x7fff46d5ced0, odr_indicator = 137183190979656}}, reg_sites = {1188417776, 32767, 1947400376, 32708}, access_size = 136908313071616, size = 0 '\000'}, wild = {addr = 140481759459223, access_size = 140734381817088}}}}, function = 0x7fc47555a359 <___interceptor___tls_get_addr(void*)+89> "L\211\360H\213]\360L\213u\370\311\303f.\017\037\204"}, StringFunctionSizeOverflow = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, addr_description = {data = {kind = 1935546144, {shadow = {addr = 0, kind = __asan::kShadowKindLow, shadow_byte = 0 '\000'}, heap = {addr = 0, alloc_tid = 0, free_tid = 6137508266440, alloc_stack_id = 1935546144, free_stack_id = 31956, chunk_access = {bad_addr = 96, offset = 137251910457024, chunk_begin = 232, chunk_size = 140733193412616, user_requested_alignment = 2416, access_type = 1, alloc_type = 1}}, stack = {addr = 0, tid = 0, offset = 6137508266440, frame_pc = 137251910457120, access_size = 96, frame_descr = 0x7cd4735e16c0 "\225\005"}, global = {addr = 0, static kMaxGlobals = 4, globals = {{beg = 0, size = 6137508266440, size_with_redzone = 137251910457120, name = 0x60 <error: Cannot access memory at address 0x60>, module_name = 0x7cd4735e16c0 "\225\005", has_dynamic_init = 232, gcc_location = 0x7fff00006008, odr_indicator = 140481731254640}, {beg = 140734381803504, size = 2, size_with_redzone = 140481759748032, name = 0x7ca4735e0b90 "\003\021", module_name = 0x7fff46d5c7c0 "\020\320\325F\377\177", has_dynamic_init = 140481758099256, gcc_location = 0xa0, odr_indicator = 137045752023952}, {beg = 140481733808336, size = 140734381803488, size_with_redzone = 137045752023968, name = 0x555a06502a00 <device_free> "\363\017\036\372USH\211\373H\203\354\030H\205\377\017\204-\n", module_name = 0x7fff46d5d0f0 "", has_dynamic_init = 136083659412832, gcc_location = 0x7fff46d5d010, odr_indicator = 140481759028161}, {beg = 140734381803488, size = 130805806722, size_with_redzone = 140734381803504, name = 0x2 <error: Cannot access memory at address 0x2>, module_name = 0x7fc475582400 <___interceptor_free(void*)+176> "D\213\215\314\367\377\377E\205\311t4H\211m\330A\203\371\001tzE\017\276\3061\311H\211\352H\211\306H\215\275\320\367\377\377\3502\026\001", has_dynamic_init = 93845141246712, gcc_location = 0x7fff46d5cff0, odr_indicator = 140734381805312}}, reg_sites = {1956994528, 32708, 1955818339, 32708}, access_size = 1, size = 141 '\215'}, wild = {addr = 0, access_size = 0}}}}, size = 140734381805408}, BadParamsToAnnotateContiguousContainer = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, beg = 137251910457120, end = 0, old_mid = 0, new_mid = 6137508266440}, BadParamsToAnnotateDoubleEndedContiguousContainer = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, storage_beg = 137251910457120, storage_end = 0, old_container_beg = 0, old_container_end = 6137508266440, new_container_beg = 137251910457120, new_container_end = 96}, BadParamsToCopyContiguousContainerAnnotations = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, stack = 0x5b33df1d00000002, old_storage_beg = 137251910457120, old_storage_end = 0, new_storage_beg = 0, new_storage_end = 6137508266440}, ODRViolation = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, global1 = {beg = 6571841596910731266, size = 137251910457120, size_with_redzone = 0, name = 0x0, module_name = 0x595000001c8 <error: Cannot access memory at address 0x595000001c8>, has_dynamic_init = 137251910457120, gcc_location = 0x60, odr_indicator = 137251910457024}, global2 = {beg = 232, size = 140733193412616, size_with_redzone = 140481731254640, name = 0x7fff46d5c7f0 "", module_name = 0x2 <error: Cannot access memory at address 0x2>, has_dynamic_init = 140481759748032, gcc_location = 0x7ca4735e0b90, odr_indicator = 140734381803456}, stack_id1 = 1967781688, stack_id2 = 32708}, InvalidPointerPair = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, pc = 6571841596910731266, bp = 137251910457120, sp = 0, addr1_description = {data = {kind = __asan::kAddressKindWild, {shadow = {addr = 6137508266440, kind = (unknown: 0x20), shadow_byte = 23 '\027'}, heap = {addr = 6137508266440, alloc_tid = 137251910457120, free_tid = 96, alloc_stack_id = 1935546048, free_stack_id = 31956, chunk_access = {bad_addr = 232, offset = 140733193412616, chunk_begin = 140481731254640, chunk_size = 140734381803504, user_requested_alignment = 2, access_type = 0, alloc_type = 0}}, stack = {addr = 6137508266440, tid = 137251910457120, offset = 96, frame_pc = 137251910457024, access_size = 232, frame_descr = 0x7fff00006008 <error: Cannot access memory at address 0x7fff00006008>}, global = {addr = 6137508266440, static kMaxGlobals = 4, globals = {{beg = 137251910457120, size = 96, size_with_redzone = 137251910457024, name = 0xe8 <error: Cannot access memory at address 0xe8>, module_name = 0x7fff00006008 <error: Cannot access memory at address 0x7fff00006008>, has_dynamic_init = 140481731254640, gcc_location = 0x7fff46d5c7f0, odr_indicator = 2}, {beg = 140481759748032, size = 137045752023952, size_with_redzone = 140734381803456, name = 0x7fc47549f738 <__sanitizer::Quarantine<__asan::QuarantineCallback, __asan::AsanChunk>::Put(__sanitizer::QuarantineCache<__asan::QuarantineCallback>*, __asan::QuarantineCallback, __asan::AsanChunk*, unsigned long)+248> "H\203;", module_name = 0xa0 <error: Cannot access memory at address 0xa0>, has_dynamic_init = 137045752023952, gcc_location = 0x7fc473d750d0, odr_indicator = 140734381803488}, {beg = 137045752023968, size = 93845141334528, size_with_redzone = 140734381805808, name = 0x7bc4722dd560 "0W^s4|", module_name = 0x7fff46d5d010 "", has_dynamic_init = 140481759028161, gcc_location = 0x7fff46d5c7e0, odr_indicator = 130805806722}, {beg = 140734381803504, size = 2, size_with_redzone = 140481759028224, name = 0x555a064ed2f8 <gatt_server_cleanup+200> "H\205\333t{\366\303\auvH\211\350H\301\350\003\200\270", module_name = 0x7fff46d5cff0 "`\325-r\304{", has_dynamic_init = 140734381805312, gcc_location = 0x7fc474a55de0 <_nl_C_locobj>, odr_indicator = 140481746135907}}, reg_sites = {1, 0, 106882189, 21850}, access_size = 140734381805408, size = 80 'P'}, wild = {addr = 6137508266440, access_size = 137251910457120}}}}, addr2_description = {data = {kind = 8, {shadow = {addr = 140481759459223, kind = __asan::kShadowKindLow, shadow_byte = 253 '\375'}, heap = {addr = 140481759459223, alloc_tid = 140734381817088, free_tid = 140734381805048, alloc_stack_id = 3714491648, free_stack_id = 1530126109, chunk_access = {bad_addr = 140734381805248, offset = 140481759289213, chunk_begin = 136564715706184, chunk_size = 140481759723384, user_requested_alignment = 4095, access_type = 3, alloc_type = 3}}, stack = {addr = 140481759459223, tid = 140734381817088, offset = 140734381805048, frame_pc = 6571841600625222912, access_size = 140734381805248, frame_descr = 0x7fc4755c1f7d <__sanitizer::DTLS_on_tls_get_addr(void*, void*, unsigned long, unsigned long)+125> "I\211\302H\205\300u\035\351\213"}, global = {addr = 140481759459223, static kMaxGlobals = 4, globals = {{beg = 140734381817088, size = 140734381805048, size_with_redzone = 6571841600625222912, name = 0x7fff46d5cec0 "H\024^s\304|", module_name = 0x7fc4755c1f7d <__sanitizer::DTLS_on_tls_get_addr(void*, void*, unsigned long, unsigned long)+125> "I\211\302H\205\300u\035\351\213", has_dynamic_init = 136564715706184, gcc_location = 0x7fc47562bf78, odr_indicator = 65535}, {beg = 6571841600625222912, size = 140481737717944, size_with_redzone = 140481759723384, name = 0x7c24735e7c70 "", module_name = 0x7fff46d5d0f0 "", has_dynamic_init = 136495996238912, gcc_location = 0x7c24735e7c68, odr_indicator = 136495996238960}, {beg = 93845142223156, size = 64, size_with_redzone = 17010457426604, name = 0x7c44735e1620 "@\024^s\304|", module_name = 0x7bc4722dd600 "\0166\340E", has_dynamic_init = 136221118382832, gcc_location = 0x555a065e58e2 <bt_att_chan_cancel+402>, odr_indicator = 11}, {beg = 136495996238960, size = 11, size_with_redzone = 93845142264744, name = 0x7cc4735e1440 "", module_name = 0x7bc4722dd660 "", has_dynamic_init = 17010457426624, gcc_location = 0x7fff46d5ced0, odr_indicator = 137183190979656}}, reg_sites = {1188417776, 32767, 1947400376, 32708}, access_size = 136908313071616, size = 0 '\000'}, wild = {addr = 140481759459223, access_size = 140734381817088}}}}}, Generic = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, addr_description = {data = {kind = __asan::kAddressKindHeap, {shadow = {addr = 137251910457120, kind = __asan::kShadowKindLow, shadow_byte = 0 '\000'}, heap = {addr = 137251910457120, alloc_tid = 0, free_tid = 0, alloc_stack_id = 456, free_stack_id = 1429, chunk_access = {bad_addr = 137251910457120, offset = 96, chunk_begin = 137251910457024, chunk_size = 232, user_requested_alignment = 8, access_type = 2, alloc_type = 1}}, stack = {addr = 137251910457120, tid = 0, offset = 0, frame_pc = 6137508266440, access_size = 137251910457120, frame_descr = 0x60 <error: Cannot access memory at address 0x60>}, global = {addr = 137251910457120, static kMaxGlobals = 4, globals = {{beg = 0, size = 0, size_with_redzone = 6137508266440, name = 0x7cd4735e1720 "\240\025^sD|", module_name = 0x60 <error: Cannot access memory at address 0x60>, has_dynamic_init = 137251910457024, gcc_location = 0xe8, odr_indicator = 140733193412616}, {beg = 140481731254640, size = 140734381803504, size_with_redzone = 2, name = 0x7fc475631fc0 <__asan::instance> "", module_name = 0x7ca4735e0b90 "\003\021", has_dynamic_init = 140734381803456, gcc_location = 0x7fc47549f738 <__sanitizer::Quarantine<__asan::QuarantineCallback, __asan::AsanChunk>::Put(__sanitizer::QuarantineCache<__asan::QuarantineCallback>*, __asan::QuarantineCallback, __asan::AsanChunk*, unsigned long)+248>, odr_indicator = 160}, {beg = 137045752023952, size = 140481733808336, size_with_redzone = 140734381803488, name = 0x7ca4735e0ba0 "\227\005", module_name = 0x555a06502a00 <device_free> "\363\017\036\372USH\211\373H\203\354\030H\205\377\017\204-\n", has_dynamic_init = 140734381805808, gcc_location = 0x7bc4722dd560, odr_indicator = 140734381805584}, {beg = 140481759028161, size = 140734381803488, size_with_redzone = 130805806722, name = 0x7fff46d5c7f0 "", module_name = 0x2 <error: Cannot access memory at address 0x2>, has_dynamic_init = 140481759028224, gcc_location = 0x555a064ed2f8 <gatt_server_cleanup+200>, odr_indicator = 140734381805552}}, reg_sites = {1188417280, 32767, 1956994528, 32708}, access_size = 140481746135907, size = 1 '\001'}, wild = {addr = 137251910457120, access_size = 0}}}}, pc = 93845142299789, bp = 140734381805408, sp = 140734381805392, access_size = 8, bug_descr = 0x7fc4755eb797 "heap-use-after-free", is_write = false, shadow_val = 253 '\375'}}}, halt_on_error_ = true}
                error = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\304\177\000\000\305\274Yu\304\177\000\000\300\200^s$|\000\000:\000\000\000\000\000\000\000\240\200^s$|\000\000\260\200^s$|\000\000\320\303\325F\377\177\000\000\005\034Nu\304\177\000\000 \304\325F\377\177\000\000\000P\327s\304\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000Z\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377\377\377\377\377\372\200^s$|\000\000\020\304\325F\377\177\000\000\001\000\000\000\000\000\000\000:\000\000\000\000\000\000\000\000\360UF\377\177\000\000:\000\000\000\000\000\000\000\240W?r\304{\000\0009\000\000\000"...}, tid = 0}, addr_description = {data = {kind = __asan::kAddressKindHeap, {shadow = {addr = 137251910457120, kind = __asan::kShadowKindLow, shadow_byte = 0 '\000'}, heap = {addr = 137251910457120, alloc_tid = 0, free_tid = 0, alloc_stack_id = 456, free_stack_id = 1429, chunk_access = {bad_addr = 137251910457120, offset = 96, chunk_begin = 137251910457024, chunk_size = 232, user_requested_alignment = 8, access_type = 2, alloc_type = 1}}, stack = {addr = 137251910457120, tid = 0, offset = 0, frame_pc = 6137508266440, access_size = 137251910457120, frame_descr = 0x60 <error: Cannot access memory at address 0x60>}, global = {addr = 137251910457120, static kMaxGlobals = 4, globals = {{beg = 0, size = 0, size_with_redzone = 6137508266440, name = 0x7cd4735e1720 "\240\025^sD|", module_name = 0x60 <error: Cannot access memory at address 0x60>, has_dynamic_init = 137251910457024, gcc_location = 0xe8, odr_indicator = 140733193412616}, {beg = 140481731254640, size = 140734381803504, size_with_redzone = 2, name = 0x7fc475631fc0 <__asan::instance> "", module_name = 0x7ca4735e0b90 "\003\021", has_dynamic_init = 140734381803456, gcc_location = 0x7fc47549f738 <__sanitizer::Quarantine<__asan::QuarantineCallback, __asan::AsanChunk>::Put(__sanitizer::QuarantineCache<__asan::QuarantineCallback>*, __asan::QuarantineCallback, __asan::AsanChunk*, unsigned long)+248>, odr_indicator = 160}, {beg = 137045752023952, size = 140481733808336, size_with_redzone = 140734381803488, name = 0x7ca4735e0ba0 "\227\005", module_name = 0x555a06502a00 <device_free> "\363\017\036\372USH\211\373H\203\354\030H\205\377\017\204-\n", has_dynamic_init = 140734381805808, gcc_location = 0x7bc4722dd560, odr_indicator = 140734381805584}, {beg = 140481759028161, size = 140734381803488, size_with_redzone = 130805806722, name = 0x7fff46d5c7f0 "", module_name = 0x2 <error: Cannot access memory at address 0x2>, has_dynamic_init = 140481759028224, gcc_location = 0x555a064ed2f8 <gatt_server_cleanup+200>, odr_indicator = 140734381805552}}, reg_sites = {1188417280, 32767, 1956994528, 32708}, access_size = 140481746135907, size = 1 '\001'}, wild = {addr = 137251910457120, access_size = 0}}}}, pc = 93845142299789, bp = 140734381805408, sp = 140734381805392, access_size = 8, bug_descr = 0x7fc4755eb797 "heap-use-after-free", is_write = false, shadow_val = 253 '\375'}
        #9  0x00007fc47558ff8d in __asan::ReportGenericError (pc=<optimized out>, bp=bp@entry=140734381805408, sp=sp@entry=140734381805392, addr=<optimized out>, is_write=is_write@entry=false, access_size=access_size@entry=8, exp=<optimized out>, fatal=true) at ../../../../src/libsanitizer/asan/asan_report.cpp:536
                in_report = <optimized out>
                error = <optimized out>
                enable_fp = <optimized out>
        #10 0x00007fc4755913f9 in __asan::__asan_report_load8 (addr=<optimized out>) at ../../../../src/libsanitizer/asan/asan_rtl.cpp:131
                bp = 140734381805408
                pc = <optimized out>
                local_stack = 140734381805808
                sp = 140734381805392
        #11 0x0000555a065ee48d in discovery_op_free (op=0x7c44735e16a0) at src/shared/gatt-client.c:407
        No locals.
        #12 0x0000555a0671b86a in bt_gatt_request_unref (req=0x7c44735e2020) at src/shared/gatt-helpers.c:577
        No locals.
        #13 bt_gatt_request_unref (req=0x7c44735e2020) at src/shared/gatt-helpers.c:566
        No locals.
        #14 0x0000555a065db934 in cancel_att_send_op (data=0x7c24735e7c40) at src/shared/att.c:230
                op = 0x7c24735e7c40
        #15 0x0000555a065e6669 in bt_att_cancel_all (att=<optimized out>) at src/shared/att.c:1955
                chan = 0x7c44735e1620
                entry = 0x7be4735f42f0
        #16 bt_att_cancel_all (att=<optimized out>) at src/shared/att.c:1936
                entry = <optimized out>
                chan = <optimized out>
        #17 0x0000555a065e7450 in bt_att_unref (att=0x7cc4735e1440) at src/shared/att.c:1354
        No locals.
        #18 bt_att_unref (att=0x7cc4735e1440) at src/shared/att.c:1345
        No locals.
        #19 0x0000555a0650266f in attio_cleanup (device=device@entry=0x7d34735e0b00) at src/device.c:873
        No locals.
        #20 0x0000555a06502ba7 in device_free (user_data=0x7d34735e0b00) at src/device.c:918
                device = 0x7d34735e0b00
                __func__ = "device_free"
        #21 0x0000555a0658396a in remove_interface (data=0x7c34735e5730, name=name@entry=0x555a067a9500 "org.bluez.Device1") at gdbus/object.c:742
                iface = 0x7c24735e6260
        #22 0x0000555a0658652c in g_dbus_unregister_interface (connection=<optimized out>, path=<optimized out>, name=<optimized out>) at gdbus/object.c:1499
                data = <optimized out>
        #23 0x0000555a064b87eb in remove_temporary_devices (adapter=adapter@entry=0x7cf4735e0200) at src/adapter.c:826
                dev = 0x7d34735e0b00
                l = <optimized out>
                next = 0x0
        #24 0x0000555a064b9b4a in adapter_shutdown () at src/adapter.c:11531
                adapter = 0x7cf4735e0200
                list = 0x7bf4735e3a00 = {0x7cf4735e0200}
                __func__ = "adapter_shutdown"
        #25 0x0000555a0655a99c in signal_callback (signum=<optimized out>, user_data=<optimized out>) at src/main.c:1565
                terminated = false
        #26 signal_callback (signum=<optimized out>, user_data=<optimized out>) at src/main.c:1552
                terminated = false
        #27 0x0000555a0670fdfe in signal_read (io=<optimized out>, user_data=0x7bf4735e35b0) at src/shared/mainloop-notify.c:145
                data = <optimized out>
                si = <optimized out>
                result = <optimized out>
                fd = <optimized out>
        #28 0x0000555a0670ccf5 in watch_callback (channel=<optimized out>, cond=<optimized out>, user_data=<optimized out>) at src/shared/io-glib.c:173
                watch = <optimized out>
                result = <optimized out>
                destroy = <optimized out>
        #29 0x00007fc47529bb9b in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #30 0x00007fc47529d1d7 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #31 0x00007fc47529d577 in g_main_loop_run () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #32 0x0000555a0670fc59 in mainloop_run () at src/shared/mainloop-glib.c:65
        No locals.
        #33 0x0000555a0671058b in mainloop_run_with_signal (func=func@entry=0x555a0655a920 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:196
                data = 0x7bf4735e35b0
                io = 0x7c04735f9690
                ret = <optimized out>
        #34 0x0000555a0628b36f in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:1793
                context = <optimized out>
                err = <optimized out>
                sdp_mtu = 0
                sdp_flags = <optimized out>
                gdbus_flags = <optimized out>
                __func__ = "main""


https://github.com/bluez/bluez/pull/2780

---
Regards,
Linux Bluetooth


--===============6529386950902476759==--
