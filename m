Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648173;
	b=uKVXWLluBLyd5ZLmA+ySNB5yvUBGXkB2YtNX1b0+MjHIlWdQs3jr0C36EUD2/6b2cv89
	 9cFIQ+lc7u6cCUTNG1RUi7n3SZB9k3MjxOYMzARMQ7StnE+Fz1qMNbUwo7UFJvABMpm3y
	 ZrggE4rIAanpcU5TsmxDwnCcEf41YcWSQ9Kj6HrI/U2hCztS1N5K1P1aaVHWabbCpCaAB
	 EH9hZA5SHmz0zxTkAPGAh7SC5oxoPEEjx2TyOSeH3OAmC3gfakErTd1CcdJ+Ta3favKPE
	 Hl+8ytTp8xaJz2ed+9pGCDEsGgfMw5HUfEeAo2+9vqUt99YpdnyWOJyMha29JyFbkuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=9EVy+xrRMLs9rqs0nZXiej+MwQpzzwNCVQTFpd7Y61U=;
	b=zr8kBaafFpARsPTzlhlh4wpcv2KWU7sPxONs9mvBQVlSK/4B7o+dsOCzZZLmZ5UNMiZG
	 bYi1rpHVkzXWaObrp3EN4KR61HIZqJ5BHS3H8CWopsFkx8jdiQD2K2VOwxbkecT5KKrub
	 cXp+u7uHB1BXB9ZrwoW5LTO+ZYH/JUZ6tGzvwnF06BGI7pGDfQaqmzxsboYUHf9w5qVjC
	 30Lddy/Nxuyx4hWqye3QDERA8xkf9u1iPH26aiHXJYA2CaoH2/Eg+r4ZDJKtNHtYp+101
	 88hTTozG3yQqPrLzy+oNWokevzXhWZYgdPRfg9fg59pz3PtlTtTOyoDJbTkScIz4gQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="WKyU3Y/Y";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A7C606A326
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 19:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3A7C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WKyU3Y/Y
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35c76e9614aso4763149eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 11:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648172; x=1794252972; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9EVy+xrRMLs9rqs0nZXiej+MwQpzzwNCVQTFpd7Y61U=;
        b=WKyU3Y/YufjhnFuOSIxaTGqgHlYSpwCqisCfvKsIChJuxZ3/c3CSixUccyqEe6Zzzo
         OnPVKQAtCgqFy7hZAZAKXJqJ4LPOPuFkWXHX4vlexc8T8dn507VzG5RT70Jl7Im+j/T8
         g2EH+f3MshBjuZwl9vF7bZ/MehsW658sfqBfXPyDwsyvS82W4lGhdcNOYP0kWzokd26Z
         8xF0qMulNwc2JRdBiILsfqSHT+fc2GI5v+J6kt5nayWaTQloSMIaB8/WxhndoLkOSsuA
         877EAGfcS0OXRmX/OS1QFXK5TPmG2xyHGmrA6b4d/v6uQ5nLPSel2bTSKSszX0Mt9QFM
         v10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648172; x=1794252972;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9EVy+xrRMLs9rqs0nZXiej+MwQpzzwNCVQTFpd7Y61U=;
        b=mJaE946CHJdko8xYCA8yOelkd/f15EEQxBJDlbQw/rN6dCvS3iB9useeJvK/x5vA55
         9JkWD4ZccYIma4LwN7c6dpPaytGPq8zkRk5GlBgMxm1F9KUOXnQQNH7hrG+NVVjEB+wh
         18qYoaYwL0JyrJhY521wqgUpnZ4A4QNazUyVODg7zyRCN2rpcZiLu4XI3hOyFq10dsyh
         wNBf2JlnOyX9TfHoxT09seE9UqhLyjWxH9lN3rtD9UJNYAynOeXhSHGRLI59wId8u3Vl
         uEqVGqcq6okYp75cVivw7KB4lqabeqSTQqAlYlxaiAWYYpUke+qWfh30sm5QdPpIxgGB
         Ya6A==
X-Gm-Message-State: APuU4Z8bp9xrjLC6xuo1MUy2ujtcGbSv0PV7BjrKi97UUqyT17tQMuj5
	verVfvw2Mt7v7GcsrQlS307W0vN7mKdmVHtN42UF2mxF9AUw1cWJbWwXO4rd7w==
X-Gm-Gg: AYBFou2YqmNVZq8/7ROixIgZqtiImedPngWwXI3t2F50JSmEYYKxMgiUiBngIFljMeQ
	aoQjd8mApx+exSH+VKWmUr4otySHos3bbmAYOIKbV+l+8fNTRLbV2Lj7DPRCTSID8CpVY9O+X1m
	6XsolyYXOHbVeV0iowYAaOUTk/RFkfhS+lT/dpgoKysYuBwUyhOoSTqGsHAuSmmdMfd0oyR0itO
	K4NrA8XSD02jpxiRk2XIRZKDOmk2y5+l3fe+7OpyhhkE6wO2RZek+ZQnlcP/NBMk92AF2kLOoTv
	rmCEvHnLWni3DMyY9MwwCFGl6Hz2HPDQlqvpNHCRodNE3gPTgME8mzfnnIQY7KKPl5Fhh/kwRHT
	OKCv69s4elA/rQm68jWxUbwDPyvszyu7NVbkkBiV9npp1anvIu1Fn1gLgtTLzbSWgwBeiV4ZGav
	9QaDwWQwExcg8Q6sMQZssjVvUxGXSnckmMaDuzHaf7/AJV3BOLO2GdXEqlhFzC3pQII+e5Fj28A
	dc+M5gsXpfuoTUOU6TQXsI4asBLruqd+DZ4lExFdqiPSGEJLSf0pWpXFVzTP7MyEu9nPTlaeYuE
	SfJ2HjM=
X-Received: by 2002:a05:693c:639a:20b0:359:1b05:ed30 with SMTP id 5a478bee46e88-36a42203bc1mr16643029eec.4.1793648171638;
        Mon, 02 Nov 2026 11:36:11 -0800 (PST)
Received: from [172.17.0.2] ([52.161.50.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm38620586eec.6.2026.11.02.11.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:36:11 -0800 (PST)
Message-ID: <6ae8e62b.3e93d526.12f4c9.fea1@mx.google.com>
Date: Mon, 02 Nov 2026 11:36:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4891258455795771609=="
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
Subject: RE: [v5] Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery
In-Reply-To: <20261102170000.62469-1-kevin@simpleble.org>
References: <20261102170000.62469-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4891258455795771609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1199295/

---Test result---

Test Summary:
CheckPatch                    PASS      1.15 seconds
VerifyFixes                   PASS      0.43 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      30.64 seconds
CheckAllWarning               PASS      34.89 seconds
CheckSparse                   WARNING   39.31 seconds
BuildKernel32                 PASS      30.78 seconds
CheckKernelLLVM               PASS      31.92 seconds
TestRunnerSetup               PASS      700.26 seconds
TestRunner_l2cap-tester       FAIL      10.54 seconds
TestRunner_iso-tester         PASS      10.50 seconds
TestRunner_bnep-tester        PASS      3.15 seconds
TestRunner_mgmt-tester        PASS      87.46 seconds
TestRunner_rfcomm-tester      PASS      4.50 seconds
TestRunner_sco-tester         PASS      5.57 seconds
TestRunner_ioctl-tester       PASS      4.65 seconds
TestRunner_mesh-tester        PASS      5.52 seconds
TestRunner_smp-tester         PASS      4.35 seconds
TestRunner_userchan-tester    PASS      3.22 seconds
TestRunner_6lowpan-tester     PASS      4.40 seconds
IncrementalBuild              PASS      28.90 seconds

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
==35==ERROR: AddressSanitizer: heap-use-after-free on address 0x7c0351fe33d0 at pc 0x55973e00ee8e bp 0x7ffe21df4d40 sp 0x7ffe21df4d30
READ of size 4 at 0x7c0351fe33d0 thread T0
    #0 0x55973e00ee8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x55973e00fb75 in timeout_callback src/shared/mainloop.c:270
    #2 0x55973e010aa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x55973e0133fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x55973e01864b in tester_run src/shared/tester.c:1223
    #5 0x55973df4217d in main tools/l2cap-tester.c:3918
    #6 0x7fc352f45600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7fc352f45717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x55973df48c84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7c0351fe33d0 is located 0 bytes inside of 40-byte region [0x7c0351fe33d0,0x7c0351fe33f8)
freed by thread T0 here:
    #0 0x7fc3538833ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x55973e00f36a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7fc35388460f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55973dff92d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1046

---
Regards,
Linux Bluetooth


--===============4891258455795771609==--
