Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846152;
	b=YMOhpKZS0KktxnZ29SDIf6LY0vfxiJao04HpYJT/qpsVRozC/vae/Xeb02ui3d1kNm+c
	 YMPYiYim/0cxz3v3zxzBT7WQQk9DbdIgQVvyrJPiueU5WdG6vA1RtraYVerSDZASwlTfK
	 h7QUuPKyYwwnYL8GL2xjhHCbM/bhsH4YLr6CMXFr3uCcDfU2XLL35Oz1eSlaDj5+xxqM9
	 ytfRi0DpctJeKnfDMWeIYBOwxEfZ56Npsh4bGb9M6rURgN7kt8/F8eBBQoHR9YJDbm0lG
	 4xsao1DB3+K1/WICOpKjv4mAsDPcm+nOPds7OJv2YILK58Z/5aGlvT5Brwfx7mDfxuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=PCOPLJnU2ul2NlVHGlhkT1hdxNT4YT2j34FmtNZ7pKI=;
	b=amUY4sWRD81wKcuGqWYQ/aaAfoLoDNU5o5tC+P592ZY6AJ+t+wQYil8YwYN6iMbNuTpE
	 Sn9QdhhGdPIFpl51gbRkDCEBp87KVqUhS0htT3IsDi7ord1RTaqYP7YEOS+qYtUbF8NGu
	 QSSGL3lvAhHyzAGP6NwAkca3yAW/7A4DRB4UzBwWGX9Ana/pD+kLAQnJYfYu3mJHwBEeb
	 ZiFYb3Miulg99bkCjGooKtAkQftmqUXry443dpbyfuNrIK6f44u0hN97KMezO3sP15Szd
	 jTUBSCK58x6+IRdVK3PYRjGlfeSQSMiGcFK/BZV3RG3mKD+r9CrUtCnKd0LW4w6dRaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WZCrbWDu;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2164606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 02:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2164606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WZCrbWDu
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4a77761ff8aso894302fac.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 18:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793846151; x=1794450951; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PCOPLJnU2ul2NlVHGlhkT1hdxNT4YT2j34FmtNZ7pKI=;
        b=WZCrbWDurGyFuDTZ9aZPMN5I4E4crki/6Vw4Odsu54LFE3QpLLZaQGs97VR8n39zS8
         xsMlvqdIJaNY6ZF7B6aKW1PHxmcYSrYz7HEu86q+bqAaDO4wpobUFof2Fxd/AIYLKnrR
         71qB9jZiVpcUnWjJznzRsbA7FRan5Z2rZ0D8quuMZCPnaV3juFKbXV8qlqZom13UvEFV
         J60eKdh1wCX9ocRyqqsistQdV7PR+CLzynZpBbQSVB04WFkM5e09lzKypavyi717Sh8i
         c/qEXm2Ggl8v+dOyHxmadJhr0eiM20hbju+3UHLu3KanfmTfFiGboAWVysVxTGMoA9dt
         9+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793846151; x=1794450951;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PCOPLJnU2ul2NlVHGlhkT1hdxNT4YT2j34FmtNZ7pKI=;
        b=NsfBQ8hsVGzhI0hLsr6rAU0d5HWEuWA+1U5EsC39ZkfquxA/NdudDYAjkpUhu/qMQB
         Xb+LfFLixDvylf7JC6D7XGRiecNRKmYXZNWPCAG5/+1WZEz52ym3RihSDToYLJlD3hcm
         O7+6eFW2f4VGDCQ9QSBkfNQN9CKBNcFLZQOlZCVCqbIhLeECTyLxq8JajozORjDN52JX
         Cnyp1vtbfhlif3n3BsP15KWwWmi3M8Hz+4f9q8ydGaXPtPqtEx9bt/UCs2SItdZ0Muxk
         ewc/6LRbROgaNCNnPFmpnkgJ2q3CAlv0wI/i8a0NHfAks4HN4cwnKgypo6ObWGlY5+9x
         7y1g==
X-Gm-Message-State: APuU4Z8QD9hifKCfxOufSDeC1PY7JICpiLQKtpialmQvqHz5FjIWxQz5
	IoewrHT37fYrhgLia4JGIpgCMykvC/EeX/d20yzZ71GVHO5cy9/uK2+j9Rd01g==
X-Gm-Gg: AYBFou2JazGJRDprvNh87X/LbsaaMht/1npTt4b95ZaNuU6t1XQKsQNar9BcCkjdRTL
	0/yCa3zyEKSN+Z/MtyeihXZAPrd+8PBKdjFaGPmgU5nwj+icCG1olFwARDNnCyNNzMZpJuQdLS1
	FF4ei9tNVPyqdGTV7vJXvKfH6SnSHvJ+OVQj5PfJc7myhemb7UtClrxGWwDEU1V/1a/aJGcMCrx
	PzuaO2A7sdNK5LngY0VXqiHgshc9ciMJ58qDAxy7WrEC6d7GXkgef8Ckb/BHtk4n+q9DdLDAr04
	84a9qig4pp108cxMzlChW9VjXazK5jL2tGOirDzYyh0z+CxnUCX4za2p7BjNwENEDb1b1/sLJiK
	IsPV2otNPvlrkIrat9cuptv6QXr7Cso7UJbrS+j0rAdShv4e+4PI1qfpFLYfh6FUc9tdvyMVq9j
	mC2NhkJP8764pxVVWBkKNT3ko5LCXf4c/5CRu7e7QHZSOn7kpxkSA3ThfTKctzpp1LYSbMU6nHj
	/adnMZ4I+AlhzxABWxcDJ0UGH/YTIoD6qU4TFyp9n1GYztHMzawvXAAWe1ExbcchQnaRPGWjB2l
	DbOjUBpAXg==
X-Received: by 2002:a05:6870:41cc:b0:4a7:455a:b186 with SMTP id 586e51a60fabf-4a9076f5d40mr11770102fac.26.1793846150564;
        Wed, 04 Nov 2026 18:35:50 -0800 (PST)
Received: from [172.17.0.2] ([52.165.213.229])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm3521143fac.3.2026.11.04.18.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 18:35:49 -0800 (PST)
Message-ID: <6aebeb85.efea58c9.a2a61.db3e@mx.google.com>
Date: Wed, 04 Nov 2026 18:35:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4250705685578501541=="
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
Subject: RE: Bluetooth: Add support for HDT and EKS
In-Reply-To: <20261104221321.1200529-2-luiz.dentz@gmail.com>
References: <20261104221321.1200529-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4250705685578501541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1202517/

---Test result---

Test Summary:
CheckPatch                    PASS      10.90 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      1.64 seconds
SubjectPrefix                 PASS      0.60 seconds
BuildKernel                   PASS      21.17 seconds
CheckAllWarning               PASS      30.39 seconds
CheckSparse                   WARNING   26.06 seconds
BuildKernel32                 PASS      20.59 seconds
CheckKernelLLVM               FAIL      17.92 seconds
TestRunnerSetup               PASS      457.10 seconds
TestRunner_l2cap-tester       FAIL      11.74 seconds
TestRunner_iso-tester         PASS      12.87 seconds
TestRunner_bnep-tester        PASS      7.01 seconds
TestRunner_mgmt-tester        PASS      82.65 seconds
TestRunner_rfcomm-tester      PASS      4.04 seconds
TestRunner_sco-tester         PASS      5.04 seconds
TestRunner_ioctl-tester       PASS      4.30 seconds
TestRunner_mesh-tester        PASS      5.12 seconds
TestRunner_smp-tester         PASS      4.12 seconds
TestRunner_userchan-tester    PASS      2.94 seconds
TestRunner_6lowpan-tester     PASS      8.30 seconds
IncrementalBuild              PASS      84.33 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckKernelLLVM - FAIL
Desc: Build kernel with LLVM + context analysis
Output:

net/bluetooth/hci_sync.c:8779:6: error: calling function 'smp_pairing_in_progress' requires holding mutex 'hci_conn_hash_lookup_handle(hdev, data->handle).hdev->lock' exclusively [-Werror,-Wthread-safety-precise]
 8779 |         if (smp_pairing_in_progress(conn)) {
      |             ^
net/bluetooth/hci_sync.c:8779:6: note: found near match 'hdev->lock'
1 error generated.
make[4]: *** [scripts/Makefile.build:290: net/bluetooth/hci_sync.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:572: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:572: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/home/runner/work/bluetooth-next/bluetooth-next/src/src/Makefile:2243: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==35==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b5248ae33d0 at pc 0x562a65d71eee bp 0x7ffc09474db0 sp 0x7ffc09474da0
READ of size 4 at 0x7b5248ae33d0 thread T0
    #0 0x562a65d71eed in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x562a65d72ed5 in timeout_callback src/shared/mainloop.c:271
    #2 0x562a65d74006 in mainloop_run src/shared/mainloop.c:125
    #3 0x562a65d7696a in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x562a65d7bc4b in tester_run src/shared/tester.c:1297
    #5 0x562a65ca51dd in main tools/l2cap-tester.c:3918
    #6 0x7f12499d7600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f12499d7717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x562a65cabce4 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16dce4) (BuildId: 4b6cbb2e2c80ac13520eedc70b7cea5c676c63f3)

0x7b5248ae33d0 is located 0 bytes inside of 40-byte region [0x7b5248ae33d0,0x7b5248ae33f8)
freed by thread T0 here:
    #0 0x7f124a3153ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x562a65d723ca in timeout_destroy src/shared/mainloop.c:252

previously allocated by thread T0 here:
    #0 0x7f124a31660f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x562a65d5c335 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1067

---
Regards,
Linux Bluetooth


--===============4250705685578501541==--
