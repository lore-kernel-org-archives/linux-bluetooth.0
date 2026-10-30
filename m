Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378767;
	b=TX2V+V3mHtgckU2xjGVWdgQcnW8d9KUUTXVY87wKisG8M5zvsJoEqRTfDueBvrFSuTAx
	 eeiBlanx6qoY8+/9Z1/e8mLTtEQGYZrJIJtE3n+Dly/ZiEaDmfU+clHcESBeRl8qbO+Ma
	 iBbWTqp5igzHuQ7SreTBX/VuhMWN4/zV8Q5Lolv409+Peyk0WuNP/hKLdghomo+TiIcV3
	 8qAPVIQ6bGByvVHaz9If95NLCzNpGgpBPgcvYk0PZdOpu6XsmRpw0TielVXI0sYegVW7g
	 mSVCpLFkVCn1zTiVkEhJ1wpIn9qrz7t26RZ8bVfNve/htaIn9KRVruEumHIyhzOQILQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ORYwZ4RCkCjV3QeSBFinuNM34FlkQ3vyRqcwjXj4GKY=;
	b=COteCGmXlzGX3m0rTRkIuul6+ZiD9xNMRx2zEgicACuQxbOZmAzDStEp8uvN+yKWysiM
	 lyWwBIzXMmBkdvhC9SC9ZWhi1kUGUiiqx6Wm7OhQ4RxZb63xGQEIQEL/xdOQi1pY8SJs/
	 0JaEzSkpMvmoBYv5UdKvqmyZCok6NCeCeArsvor7sne8Vuv7UWwUaUejcnVO6QtrEpQRA
	 7zrUx5PAxZZaVm+3BeGRuPRLfswT5NP2y9y6fu+ePzbY0e4qQf7dMxFJ0t9zwHDlbb7lv
	 L8+5PcBgQS6KoyRMr/sURKuzEKHgnKZ3ATP245bbWY4ChhDfrb37x/YLLzlCw+CH0jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Faz9zD5c;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3E2606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 16:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB3E2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Faz9zD5c
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso468247a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793378766; x=1793983566; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ORYwZ4RCkCjV3QeSBFinuNM34FlkQ3vyRqcwjXj4GKY=;
        b=Faz9zD5c8hq919Uks2yxOiahLXequwJ2HHwKUXP24oIYOEMbtIJv/jFSfFTg/NG22Q
         /aM/QQQhFCFccY326yc1yYzsU9ZCDQdmlmBbX05E6YvpbZVzhToI7hz0m2RY99DyXCc4
         pcL0Afpcu4LVNT8+HGH9s4dZoRq/Xm/bYz8GqQxjdI/G6JhmgsA0GekqK51wk95xXtuY
         akrw+H0xA9CQMtRJQ+nx2tfRjCNqEzcOyZ0svxpi6BlUyeQkrGPorVsgk0MdMgpBZhSe
         gyrQIro1qA7yiKDjnszOJ3ZT6W0AaBkAb/EAxAj9blymMFkO57GDXrLbr2YDL8+l4Tdt
         jYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793378766; x=1793983566;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ORYwZ4RCkCjV3QeSBFinuNM34FlkQ3vyRqcwjXj4GKY=;
        b=MJ+nPPQLJZ22XZQf+cdXrZ5dCCcdOZMGRXyQYoJCE7Q0lchTqp18k6CWbdhI1OUvep
         yW96UARRDPRbte4jckC374J4KzDR/3VHZtpQR+0XljhDbWaE4hifSYJP/7ytcB0nsaB7
         l/xt0mX1XDyJezb9DKxM42oE44XorhJaLVUlL3U9wweHyuAR17IsKV8J0V55hQ+Wzwsy
         OuJWTTNJ19pImJd0VsS71Ssz3hRUew/9opL2JXsBIeHqzeDv0oR4zeZ9rBZZ1Y26lX0u
         dNo0uCBXQx4KG8mF0S4K2/9EawcjLjY2sAiSuhX73s+zZANlOZTNTJLdK1VNz/xxT61j
         Sjag==
X-Gm-Message-State: AFq9FYIYHqFn4YdGyV84Jf1K5tGOwUs0YNPE2fngYcDXRadctaM7VkuK
	HRVs7Z4txnHA3uFKyX1Ua3yGqe6C+UI2PKSBAhq13fApVlyqCO02vQjeIoiMAQ==
X-Gm-Gg: AYBFou27L5L+pqeM6k2amrP+j0HCUo//Tx3z/8z4s+nQ84pKnfmjpAEcWGZdpA8Kf5q
	1z35rGruSFUGunS7Lduu1gRZRVKCnJGHl65+GkEirZABBLljxvLqIekG7/qWX+i/qb0InF7m3Pl
	4y32GJgDt4Lg+o5+EDfjPep9+uk6hAj8jdVbU5AWWPvgPD1zMFHG7XcM+uwgTfj/hmoizrqJMEq
	0118p56sLePQuGt8WRqhgZzDUwWsvY8pEGSLDglJZFji/BIFdeRUcLVOrqzmG5euFzRjRZ8yKoq
	WjK8MERa2y7KNazkcoyv1jUpHENHuXxxiET3z2L8hFox80B35o8MfQxUVgvoNA1OsiJuX67yvOG
	YRi1dt7selAJ8nSuAth7fLFH1cmDzqws6mfKy++kBR5yD7ZNfcr76UkImVj9ZQWjk2OuSl1/zbp
	DGEfybsDEst7yvUokQBsEqX2kVQuJhwRUS9wUlaz7kRrJzdZCkRHm2s2JJYNwlAh0s95j8vkaMB
	bc7P2lV1M4G6Rqms81+df7L9jY4MAbBVKr/xEd+mti4cusUHreif9GKI06OHi4=
X-Received: by 2002:a17:903:3205:b0:2e9:5714:608b with SMTP id d9443c01a7336-2eb364b11ffmr31230215ad.34.1793378766155;
        Fri, 30 Oct 2026 09:46:06 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.135.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392ae011sm10019125ad.69.2026.10.30.09.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:46:05 -0700 (PDT)
Message-ID: <6ae4c9cd.c45220f8.a8666.ccad@mx.google.com>
Date: Fri, 30 Oct 2026 09:46:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6771819746964417049=="
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
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Bluetooth: MGMT: Send Connection Subrate on LE connection and update
In-Reply-To: <20261030144106.75414-1-kevin@simpleble.org>
References: <20261030144106.75414-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6771819746964417049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1197220/

---Test result---

Test Summary:
CheckPatch                    PASS      1.17 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      31.31 seconds
CheckAllWarning               PASS      35.57 seconds
CheckSparse                   WARNING   38.55 seconds
BuildKernel32                 PASS      31.81 seconds
CheckKernelLLVM               PASS      44.42 seconds
TestRunnerSetup               PASS      748.20 seconds
TestRunner_l2cap-tester       FAIL      10.81 seconds
TestRunner_iso-tester         PASS      10.94 seconds
TestRunner_bnep-tester        PASS      3.22 seconds
TestRunner_mgmt-tester        PASS      88.64 seconds
TestRunner_rfcomm-tester      PASS      5.16 seconds
TestRunner_sco-tester         PASS      5.76 seconds
TestRunner_ioctl-tester       PASS      4.71 seconds
TestRunner_mesh-tester        PASS      5.57 seconds
TestRunner_smp-tester         PASS      4.37 seconds
TestRunner_userchan-tester    PASS      3.24 seconds
TestRunner_6lowpan-tester     PASS      4.49 seconds
IncrementalBuild              PASS      29.61 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==35==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b4eb88e33d0 at pc 0x561facb02e8e bp 0x7ffdc2595460 sp 0x7ffdc2595450
READ of size 4 at 0x7b4eb88e33d0 thread T0
    #0 0x561facb02e8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x561facb03b75 in timeout_callback src/shared/mainloop.c:270
    #2 0x561facb04aa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x561facb073fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x561facb0c64b in tester_run src/shared/tester.c:1223
    #5 0x561faca3617d in main tools/l2cap-tester.c:3918
    #6 0x7f0eb98a8600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f0eb98a8717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x561faca3cc84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7b4eb88e33d0 is located 0 bytes inside of 40-byte region [0x7b4eb88e33d0,0x7b4eb88e33f8)
freed by thread T0 here:
    #0 0x7f0eba1e63ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x561facb0336a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7f0eba1e760f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x561facaed2d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1032

---
Regards,
Linux Bluetooth


--===============6771819746964417049==--
