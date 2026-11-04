Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759123;
	b=sr6weVDxa9bd3Nfk/lvyhZ86OqNQWndP47phS8nG/7nH3+5PiIewaTDvHaFTyFHPA1zv
	 lFMsKTQfaFlq4OMa2Gr/GuYwq30BDhPLkytwEVSmUyuCPWZWIJGJHP4CgxX0QbyCnLNqQ
	 m4nAEEuyOi7YjZgCMMpgskhQ5/FIuvSHANuGPO5Sju0gySzrQfPVlqEaUH22h4J275PF3
	 OGn1bdCKdAXiiGMXwfdXbeKi1VUPyJQB7h/BFnWAEXPJB3uYzNbVufN8O9vjeHOTGI/EI
	 vXs7xr2lgWb/1hfzBIZdhZjaf8tsWM+PIDUZBXb1j207vhRvlcjz0+vsYnxtukoAA0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=LJHSjvae5PaQ1ygGTF3VLLP3gTh1HnhndXiPf+XdXQo=;
	b=LTAdg4ggM+jq8nA8+W/75OaCn9k+zF0gBsiaIKKuI2zrCxnLmjV++TQP0KCYTb4irPHF
	 Mb7LHxfW6f/WqY0FzDYfrWZw9eiQHhxk4Uh5+K8LAK/MkbMzNNTRS5sDyst/HaS06vNtJ
	 C1x/JsTAllFFsq3aRhr9fUrEyHBCoStVVcFiaN0XXL+yEv10anay62TB2BCKTb2GbkK6i
	 mRb89JF/1OCmuco4K8u7hL4ui52+4kxS2vPMMDDbLIYLbA/zve0w9ti2hk96bE1Ndqe2u
	 eBYTah4Vvy5d7EVKF4ZCUbRva8TF574K5j8BkJ0DgVppMsugch1xrdGOLbCZR/vlYWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0koaOMz0;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78F606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 02:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F78F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0koaOMz0
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so291505eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 18:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793759122; x=1794363922; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LJHSjvae5PaQ1ygGTF3VLLP3gTh1HnhndXiPf+XdXQo=;
        b=0koaOMz0TLdsDc3jAPHjiRwKeT4vMo12XUE7GHIzSHVtk0m9ucJBPBB7cj5MK9qpRI
         FI4T01Hx5cQTukq7trKaEupdcwAK+Y0BLkoVbZ5Gc5tqvZP5SbbY+AW5qgf1S6Don2zY
         jSTkQKdu6BW1WjlsPM3Ccvb6wKH3xWRsrB+BqB7NmFUfoIgWcFvq2c44sd0AYk35z4Vt
         lXXhtSfMeIC6s8hZvOldhLEkRSpKXZsuKWOozV2qTxxw8yo1qJvQdIU47fdywa6PDZ8d
         L66fKBOezGnDWpjGdvCY8N+NwmzV6bSC/xlKniiQRVnkuUGfeF88nW3anUFadIwU5Bm4
         pr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793759122; x=1794363922;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LJHSjvae5PaQ1ygGTF3VLLP3gTh1HnhndXiPf+XdXQo=;
        b=Hd/XiX5RwrX5a6glpLUlynCKrncigYx/OQ2gKV1zzvTSCkA7CIYCkgamSrYebey7fv
         63HOwAsMJgAf7Tb/ZhCtCDR3CdCrLBZWyARrdzadckvij9qIBjYlfuZR6J0dIhNVG+ze
         WSkBONFtpLbMvp7J/pirZBgXeLUn9MFngL9pXNnTdWX/HEBM4Qb9oPNqHG3AEQk7Cwy3
         iTRM0KHSvLa/uYekZlpcT9DNlhdH6DKkfpY39kJDfumyLILC968SZaD65HCTrw7cXi67
         8rBozo2vLVqKgJiFdUlleWiHbqrXAEYFHoCqZMLHh4kgsoS97DERK6YvUZ05HrbUSMvA
         Zkrw==
X-Gm-Message-State: APuU4Z8aR1WJlXtDwInnoiepDLFxfhZv6L4V5Uh/MHM8r0iQZgqgMClt
	cEYTEAwBVsedZ942XXu02oMSoEBYPehuTjC/jA9jnp4vf/nCczIgtMmOwU62ZxB0
X-Gm-Gg: AYBFou2jT59b92il4A5huSZISToD9Tgh2CZCXNzenQGDqVKoaNC6GbpVEFrDVMz+Q5/
	ot1XjgOba/Z1smXEn8sjI2XCrb1cJ7fLPS33RgWG0WOuU/pzs5Q+hXqa0CeymH1gfgvgmUO/LHt
	GOdv1hKe+ZjYS72Y9yxvAPIbu5ZERRU5/yqBXV7aBTPWOZiLr4Iwn10K6sir2LyMeYHC3LPL7g2
	Wh9fWnGNXnTDzgjfURPOjp2u2xg/OI3wyklk5tPhSwpYjZUiq62J+kwIzbcY7+o/gAZemQ4CzYE
	0tN2x6z2dsXwLUSUstr4b3hZW3dGszs0PhT45Ngr1lnHl19FIP7R4fkqwPdEK1r6f26JwKDnnOk
	nxzuin11THL8XlvoLw2Cs22swMZpULjT/E9vXfk/rvyttg1IbIdXPjpR/TiKa34xasRCg9jxG8v
	lFTHi7CAueM29KaTNFXojrL8fUK9u5dBa5U7G9q3j3kLqxKgSNKUCt80Ca8h80AG0jGfV9ZnOg2
	24ai9virc5B5TpOzfhrOvks+QBErsg/1qyEf9N4MdLJ/srQ3YgpcF2TGN0b489l
X-Received: by 2002:a05:693c:4159:20b0:351:29c8:643 with SMTP id 5a478bee46e88-36a423a8b7fmr24408557eec.18.1793759122360;
        Tue, 03 Nov 2026 18:25:22 -0800 (PST)
Received: from [172.17.0.2] ([52.160.165.215])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca390df28sm2739671eec.18.2026.11.03.18.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:25:21 -0800 (PST)
Message-ID: <6aea9791.dd4e4b81.157ef9.5ddd@mx.google.com>
Date: Tue, 03 Nov 2026 18:25:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2900443727613788560=="
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
Subject: RE: [v1,1/6] Bluetooth: Add initial support for HDT PHY
In-Reply-To: <20261103221921.4071765-3-luiz.dentz@gmail.com>
References: <20261103221921.4071765-3-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2900443727613788560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1200957/

---Test result---

Test Summary:
CheckPatch                    PASS      3.53 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      32.35 seconds
CheckAllWarning               PASS      38.39 seconds
CheckSparse                   WARNING   40.71 seconds
BuildKernel32                 PASS      32.46 seconds
CheckKernelLLVM               PASS      34.66 seconds
TestRunnerSetup               PASS      765.96 seconds
TestRunner_l2cap-tester       FAIL      10.79 seconds
TestRunner_iso-tester         PASS      11.13 seconds
TestRunner_bnep-tester        PASS      3.17 seconds
TestRunner_mgmt-tester        PASS      89.20 seconds
TestRunner_rfcomm-tester      PASS      4.58 seconds
TestRunner_sco-tester         PASS      5.75 seconds
TestRunner_ioctl-tester       PASS      7.83 seconds
TestRunner_mesh-tester        PASS      5.57 seconds
TestRunner_smp-tester         PASS      4.48 seconds
TestRunner_userchan-tester    PASS      3.29 seconds
TestRunner_6lowpan-tester     PASS      5.09 seconds
IncrementalBuild              PASS      30.61 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_sync.c:8425:42: warning: invalid assignment: |=net/bluetooth/hci_sync.c:8425:42:    left side has type restricted __le16net/bluetooth/hci_sync.c:8425:42:    right side has type unsigned longnet/bluetooth/hci_sync.c:8426:42: warning: invalid assignment: |=net/bluetooth/hci_sync.c:8426:42:    left side has type restricted __le16net/bluetooth/hci_sync.c:8426:42:    right side has type unsigned longnet/bluetooth/hci_sync.c:8427:42: warning: invalid assignment: |=net/bluetooth/hci_sync.c:8427:42:    left side has type restricted __le16net/bluetooth/hci_sync.c:8427:42:    right side has type unsigned longnet/bluetooth/hci_sync.c:8430:50: warning: invalid assignment: |=net/bluetooth/hci_sync.c:8430:50:    left side has type restricted __le16net/bluetooth/hci_sync.c:8430:50:    right side has type unsigned longnet/bluetooth/hci_sync.c:8433:50: warning: invalid assignment: |=net/bluetooth/hci_sync.c:8433:50:    left side has type restricted __le16net/bluetooth/hci_sync.c:8433:50:    right side has type unsigned longnet/bluetooth/hci_sync.c:8437:42: warning: invalid assignment: |=net/bluetooth/hci_sync.c:8437:42:    left side has type restricted __le16net/bluetooth/hci_sync.c:8437:42:    right side has type unsigned longnet/bluetooth/hci_sync.c:8438:42: warning: invalid assignment: |=net/bluetooth/hci_sync.c:8438:42:    left side has type restricted __le16net/bluetooth/hci_sync.c:8438:42:    right side has type unsigned longnet/bluetooth/hci_sync.c:8439:42: warning: invalid assignment: |=net/bluetooth/hci_sync.c:8439:42:    left side has type restricted __le16net/bluetooth/hci_sync.c:8439:42:    right side has type unsigned longnet/bluetooth/hci_sync.c:8442:50: warning: invalid assignment: |=net/bluetooth/hci_sync.c:8442:50:    left side has type restricted __le16net/bluetooth/hci_sync.c:8442:50:    right side has type unsigned longnet/bluetooth/hci_sync.c:8445:50: warning: invalid assignment: |=net/bluetooth/hci_sync.c:8445:50:    left side has type restricted __le16net/bluetooth/hci_sync.c:8445:50:    right side has type unsigned longnet/bluetooth/hci_sync.c:8538:20: warning: incorrect type in assignment (different base types)net/bluetooth/hci_sync.c:8538:20:    expected unsigned short [addressable] [assigned] [usertype] sdunet/bluetooth/hci_sync.c:8538:20:    got restricted __le16 [usertype]net/bluetooth/hci_sync.c:8539:24: warning: incorrect type in assignment (different base types)net/bluetooth/hci_sync.c:8539:24:    expected unsigned short [addressable] [assigned] [usertype] latencynet/bluetooth/hci_sync.c:8539:24:    got restricted __le16 [usertype]
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==35==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b60767e33d0 at pc 0x55c1c3d0de8e bp 0x7ffe51b1f950 sp 0x7ffe51b1f940
READ of size 4 at 0x7b60767e33d0 thread T0
    #0 0x55c1c3d0de8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x55c1c3d0eb75 in timeout_callback src/shared/mainloop.c:270
    #2 0x55c1c3d0faa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x55c1c3d123fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x55c1c3d1764b in tester_run src/shared/tester.c:1223
    #5 0x55c1c3c4117d in main tools/l2cap-tester.c:3918
    #6 0x7f207777f600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f207777f717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x55c1c3c47c84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7b60767e33d0 is located 0 bytes inside of 40-byte region [0x7b60767e33d0,0x7b60767e33f8)
freed by thread T0 here:
    #0 0x7f20780bd3ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x55c1c3d0e36a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7f20780be60f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55c1c3cf82d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1055

---
Regards,
Linux Bluetooth


--===============2900443727613788560==--
