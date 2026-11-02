Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648002;
	b=JyjZ2QebmTavxLkLmcwnu7wRE29UxrEa3puTV//pSDCRWHY5PyrYvAhzK55Ir0hsGgXm
	 MIcCT6MZGBXrKjhk0I2WBIaCkmBcvdPJg0qedPL/Vj45hke0/QAfXEdiALto87ZxG3CvF
	 DnhvFzkBTcNZ5irzw/KgxcDYJ2qObFOh/Mmnf1RrSLrOrFodoP3NE22hM/tiGAoAJ8Jyr
	 wZJXqAsgbFsivZxRgLRW8w58WXAcfJVucpbFmYP0NMXOYnW0lL79ISeoYNY3AMcL4aLfA
	 BSXaOqysRAulWP0uNvGQL5/ZQGCDxV0crawrEHw1NQFmL4rfdi0nhRvoiz9yj+pkALQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=RDuORXqhKGf2aKQJb6+GCuwgjCwecfwvES6rcDl24k8=;
	b=GG3+2Q/s5lvKC9zHtAV0tzyH4AiIUcJ+follMAj080YuA95WjTK0yQdUmHr2XX1zF00C
	 s+Hs3RQa4/GCxRGV9zF2R+HTaaJx9x3kCEjztS8JBV3T5STnLJm65PF2frlRc+w5kD7Vm
	 rladm3tusij48PJ+NUWvX17mwbe2r729LjmsISfrnlDtpby5lxD+rRL/SjQqOUJEPQS6s
	 ppiRvWJiQWTclWdAZu+0Z2isTeTUc7ryWteIx8ypBw1eKRM7OwzlO0CoYwyBc655m71la
	 Yb1ffqTwTi3KAtBL8WMwk1Gx6b6VVN3o9B58zCwc+8dFIERw7rPfJsYoLEkJhBOCq5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBgVWESb;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA61606A327
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 19:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CA61606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBgVWESb
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc147d86bebso2342588a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 11:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648001; x=1794252801; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RDuORXqhKGf2aKQJb6+GCuwgjCwecfwvES6rcDl24k8=;
        b=ZBgVWESbPT6K+OLEWPtTXhWVPSotgDCsFUBdiCMr1E2CVyJglGh7/vRE+IbD9vJ97T
         mPFdZxDTUl8xzPa3o6Dctpdv5W7RVgeYYiC0O5bCLjtJ52DPCOQyJ/lMT9eT4yDTRFIy
         80TRyNntXaBRBMFUQT8eimwBLTDo8ePEzTwZKOULBFcTKsUcYk4GvxUPz2RnE5NSKonx
         /K9NN/Ap3Pc20DR4bfa57xDFZUpxgJ0lA4VfLU5i1hOWIuoPVMK0omPaeSnhxs6cQWQZ
         u6Gm561UOWvVz6R3J/zu0arz+DVRCKx0zShlTLTZUekNXkR52BZIb/+SRjCi8ZtopCnk
         if3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648001; x=1794252801;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RDuORXqhKGf2aKQJb6+GCuwgjCwecfwvES6rcDl24k8=;
        b=KLdS8vd8SaeNkSeighGKBzJuP37U7KNhv7DYF1HgQXBd5O4pHS8C0yzkhygEwtbllc
         M60SGY4auKP0ojdz2dAQbf533mRPyInlG3OLa0XxuSHYJsxRlKmLr7vTYG1+Fts4fRHq
         QuCyilbN5bkwEB89QprvMGU5aItXFPQ106i3CJc8u7IggNq8sxm4vbpKIFVD+0Eubvma
         Nz1yCmftfIcyryPvPTYgi5ldWcbTFJr/UA5LGYgv/2x6+6vcn033i71cI8+4aVGusGhw
         0p3pcDeI4yz+uZ7jjbfVeFGuUmIcI7aOQRg/ZWdj/HJCYVyrLOc3clyvTuxauugvGa/B
         gj5w==
X-Gm-Message-State: APuU4Z9EtSEBHMmLc+TtxivSPMK/RnPzuloqqmkiQnEjolRKOhThlZUv
	OCs3X36Hdk25OeM1//+bs4fgW2z98fA8cAlUupcVImIASkTw1it77fAPMJjm5Q==
X-Gm-Gg: AYBFou2KtoZZ9DZruIBCL0siOj/ZlkpFPxfC1gin85nyIEEZmaVQc2+/i8dsGOyoOyU
	gWrGV95XYy+uGnRixJKQ3xnETgb07UqRGOkiRapbdEd1i5SI6yUkVgtB3Rkmj8Odw14vnkDfoQb
	o12yjIVCO2jQs3CduTdu1oG8Ie6zV6MllTLQ8yGCBdY6eo19eV30V2Sv8rulBIMEPiDhKBEbpc+
	2b1YMgGkK7psUpuHoEBUAhJ4Cjbwuux+QkkuRJ2g9qo2MM9nc/vFkN7HRC0/Qi+bH3hKHITB71C
	5g2jpIl8gLzlYLZFmGibk2h9/rL5t/lZSkp8uoVZHeofas0Wr3ZhyIn4ZbfUHjwNAjWIgDvo2Hb
	Z46o0WiEcmJcmPu7bFkRKhAFe/AYRNhWFhiHpNvZDAe9zb7bJvwfFFwdqcce5AESuliOnFCrICR
	vN6S9VSIYllZ6+GCdNVaDol/5HBTfDiJoahPZLIHzgC4AuCdg/cTuhciSVJiM5raaMmAHNdS3Ds
	vzNhMmajHPQI7Sznm8jVcKNBv+HivnDpDEtn8dKN8PQRISqwzh7af9Nqyw8YA==
X-Received: by 2002:a17:90b:2ecd:b0:3ab:b39f:41ca with SMTP id 98e67ed59e1d1-3ae8979834cmr5650716a91.31.1793648001322;
        Mon, 02 Nov 2026 11:33:21 -0800 (PST)
Received: from [172.17.0.2] ([4.242.44.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5aa69fsm585583a91.2.2026.11.02.11.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:33:20 -0800 (PST)
Message-ID: <6ae8e580.bf2cc4d9.3307ea.367c@mx.google.com>
Date: Mon, 02 Nov 2026 11:33:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4790993481372517292=="
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
To: linux-bluetooth@vger.kernel.org, enderaoelyther@gmail.com
Subject: RE: Bluetooth: L2CAP: Match LE responses to outstanding requests
In-Reply-To: <20261102124735.23199-2-enderaoelyther@gmail.com>
References: <20261102124735.23199-2-enderaoelyther@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4790993481372517292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1198836/

---Test result---

Test Summary:
CheckPatch                    PASS      1.44 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.69 seconds
GitLint                       FAIL      0.42 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      31.81 seconds
CheckAllWarning               PASS      35.83 seconds
CheckSparse                   PASS      38.75 seconds
BuildKernel32                 PASS      31.71 seconds
CheckKernelLLVM               PASS      35.49 seconds
TestRunnerSetup               PASS      754.40 seconds
TestRunner_l2cap-tester       FAIL      10.77 seconds
IncrementalBuild              PASS      33.12 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] Bluetooth: L2CAP: Only accept LE responses to outstanding requests

24: B1 Line exceeds max length (126>80): "Cc: <stable@vger.kernel.org> # 5.7.x: a518b9a9ef6e: Bluetooth: L2CAP: Only accept connection responses to outstanding requests"
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==37==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b79aa5e33d0 at pc 0x55a2e85dce8e bp 0x7fff8162f020 sp 0x7fff8162f010
READ of size 4 at 0x7b79aa5e33d0 thread T0
    #0 0x55a2e85dce8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x55a2e85ddb75 in timeout_callback src/shared/mainloop.c:270
    #2 0x55a2e85deaa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x55a2e85e13fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x55a2e85e664b in tester_run src/shared/tester.c:1223
    #5 0x55a2e851017d in main tools/l2cap-tester.c:3918
    #6 0x7f39ab51c600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f39ab51c717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x55a2e8516c84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7b79aa5e33d0 is located 0 bytes inside of 40-byte region [0x7b79aa5e33d0,0x7b79aa5e33f8)
freed by thread T0 here:
    #0 0x7f39abe5a3ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x55a2e85dd36a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7f39abe5b60f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55a2e85c72d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1043

---
Regards,
Linux Bluetooth


--===============4790993481372517292==--
