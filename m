Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810289;
	b=DTbtsrZJtIbdz5E8Ii07TwCnz6+PePa9RisU8Ady3tvuI5mNyey5ypeF+JqZZ8T+H2tf
	 NkIzTbhK347LJJWqT8vneYRTSwAdMxG37W3S7wdwfgxFb+baIP23TQCazw9J4q+qpMGHN
	 JRU/YRpsmtpy0IetXjgc2nhGipuLYwlspA1IHr6Gn1gtEBXlIaMgDN2IMNkf7W6PCtApa
	 +7/zDVbRYNXFxkLpwWY+unc62pCErF8zXJTBwIEGGb42diGALrAp5/rGU3Zf0yae3lG6K
	 n+t69vhpoBPnDrHviMHgH5P78eFay5LQvSS4SDsDJ+WfHNxUjQZ1w1m1lEEB3OQH2tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=4HAGg3bPMNhYOAFy4IDttgB8vpgpy2DrHJPKJmyNIHA=;
	b=tdNf66CslSDdxnIwwbC8qgIWFkJPoc6VR6csFS/Sz0Jgc8LmJOXgcuetbBvcJ9UuJMx0
	 6v7SQ/4pOGXDXk48NzijAH/OZew/Ehy/HQkI/lLIFGoQPRcFAlmZw/WmyhGwBgWJ0Otzq
	 5/vXtHJCOKJnk0lYd3uUnjl3WYhDNk2bM7fJ+GQCe5Sm+kGBTBJrXoGK7m6rV5Igm9cy6
	 xOaHd0iQ9kR67K1Zy+ssO3UeI61zN4O8VPhQKkN6rkSA0AcbH1ID81g/eES90n9txV9zP
	 BID5ephN3a6rFJB26j518eXKG2DPdxTA7WkXyCWhxI9gxBc+g2lUSXG3RQ89cKStIug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lohb7PXw;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48AD606A33F
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 16:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B48AD606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lohb7PXw
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4932b13c4ccso517421fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810287; x=1794415087; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4HAGg3bPMNhYOAFy4IDttgB8vpgpy2DrHJPKJmyNIHA=;
        b=Lohb7PXwwPlfd5C6Tt9ECXXWYoLkh+jANsvTbfhexKCWy4YpA0axhFjHAHIV+PesuS
         G+rJxxYZ260SqH4RXiB84HcgXtSen2Bf4dA9u7B13bOKufvc9+g3zLkZoS05L3hBXi7+
         UwJy5Ig/bK4oRY0s/Tf6phJ/cxcutdiGSzry4XYhzz39IF2X8TJmebZuX34PyJKEEGNM
         ZVnqueitFJNVU/Ppj8pspHmJgNKAG4SNcKVW8HoieIXKcQd69OFoEQynWFC0ul6oE2uR
         0wfDBzqaQiH7CItrHtcyW+aH0SbVO+ThmZOGV18dgBR708ruUgjTQ7fsWkVxkAHaqGLc
         /UkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810287; x=1794415087;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4HAGg3bPMNhYOAFy4IDttgB8vpgpy2DrHJPKJmyNIHA=;
        b=XvRHn/KgbCj21GRBS04NsW3VgIUphDMu/miAsKEivoPEBi2ww7fWbtTGkHEdW/j45v
         EaJGwyBeQWbO34HbkqwMMcz9rKmGQZ+hFhVtQWm1pSxJMTawZI9LSr9zbE0YSHJpPjsR
         idRoJq9Xl9b2jLfMaK1y+ZWplMDMuNffkNlF1TBtfS7R6LFcLy6VcsjO05BAlvv8xWS5
         07DLCZ5i5NaRaDjyVho3qd1BApzzex297La1iGd30HgeTbtHBoPfEhxlduxpz/XxRdJx
         6slRDs4/DrmgRySwPQlOa3mjCZUMml0zxL/cnHe/QNUeg7/DgYIPVHnU75jqOADGIvVP
         sypg==
X-Gm-Message-State: APuU4Z8J5szFeiE8JTx1vdH3agV+9N9MQl5Sw/IsCQs/Azay70SWaNhK
	L+5wn9l2ELhctt2lXpIDWQKxURUIe3BGi/C5JwrjHVir8Fpv44F83YhJTNUJew==
X-Gm-Gg: AYBFou1Lyi5ByH5VNYfkZxDflUCbvE/MzJyUR/ZlsRhnJw/NpymqJ031CTc6AE/a+cr
	n77qpG//wVTm6GzhqjH98ZLbHhgnk9q4y5OgzxZ2Gsp9z+kHBIHESOa3W0s0mfv7QvbJ1IkV/nF
	WqvBiyAORHwiwfMXnKox0ETEaT9BOjr6W4NOzB9bAuol9WOp8QDPoghdEPX6HaIoTuupd4UvrVP
	BLpoymqc4rVt7rYplEetlPK2XcL9s9GacBHpoZANwmzqnM4aa5aPlRgta+oT5iy1C6rmjRsXE44
	mFWL+koLfIoR7bXqS9jplyhmAN3l3G6au8Egy5EmciVY8lmV4hJadU7BFIfN6Z1ODhZHfKhKsi0
	bnD0urkIMbBIcdlD0Qa6ajo+JLEftAYDKuStezJIacmfdpNQl/IbomlXXT2tuLgZeyelMBGP+sR
	1IJblgWoUNOTCVGGclppP9//E3U36STzZsrjN9qdU/GKadt9RrqaZ9V/lJvPdmfLRY1VuMVH25b
	1i8n7x2fXmqzHYaVrtbd9vnIGhBI7Kq7NkCa0XYF/oI3vcPGOFP2VNrTEKWuw/a
X-Received: by 2002:a05:6870:242:b0:4a7:5497:e59f with SMTP id 586e51a60fabf-4a9077e7cddmr10778204fac.59.1793810287365;
        Wed, 04 Nov 2026 08:38:07 -0800 (PST)
Received: from [172.17.0.2] ([74.249.180.174])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4a360asm2291827fac.5.2026.11.04.08.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:38:06 -0800 (PST)
Message-ID: <6aeb5f6e.e782ec0c.2b3981.c107@mx.google.com>
Date: Wed, 04 Nov 2026 08:38:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4525053448962697962=="
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
To: linux-bluetooth@vger.kernel.org, radek@podgorny.cz
Subject: RE: [v2] Bluetooth: find an RPA peer's connection parameters by its identity
In-Reply-To: <20261104120138.1165715-1-radek@podgorny.cz>
References: <20261104120138.1165715-1-radek@podgorny.cz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4525053448962697962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1201734/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.03 seconds
VerifyFixes                   PASS      10.78 seconds
VerifySignedoff               PASS      0.87 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      21.93 seconds
CheckAllWarning               PASS      24.10 seconds
CheckSparse                   PASS      39.62 seconds
BuildKernel32                 PASS      26.36 seconds
CheckKernelLLVM               PASS      21.52 seconds
TestRunnerSetup               PASS      480.51 seconds
TestRunner_l2cap-tester       FAIL      11.88 seconds
TestRunner_iso-tester         PASS      13.53 seconds
TestRunner_bnep-tester        PASS      2.97 seconds
TestRunner_mgmt-tester        PASS      83.68 seconds
TestRunner_rfcomm-tester      PASS      4.10 seconds
TestRunner_sco-tester         PASS      5.26 seconds
TestRunner_ioctl-tester       PASS      9.60 seconds
TestRunner_mesh-tester        PASS      12.86 seconds
TestRunner_smp-tester         PASS      7.67 seconds
TestRunner_userchan-tester    PASS      4.06 seconds
TestRunner_6lowpan-tester     PASS      4.51 seconds
IncrementalBuild              PASS      20.54 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: find an RPA peer's connection parameters by its identity
WARNING: Non-standard signature: Assisted-by:
#82: 
Assisted-by: Claude:claude-opus-5-5

ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
#82: 
Assisted-by: Claude:claude-opus-5-5

total: 1 errors, 1 warnings, 0 checks, 38 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14943961.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==37==ERROR: AddressSanitizer: heap-use-after-free on address 0x7c0d93ce33d0 at pc 0x564f5dac9e8e bp 0x7ffe8f53d490 sp 0x7ffe8f53d480
READ of size 4 at 0x7c0d93ce33d0 thread T0
    #0 0x564f5dac9e8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x564f5dacab75 in timeout_callback src/shared/mainloop.c:270
    #2 0x564f5dacbaa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x564f5dace3fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x564f5dad364b in tester_run src/shared/tester.c:1223
    #5 0x564f5d9fd17d in main tools/l2cap-tester.c:3918
    #6 0x7fcd94c80600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7fcd94c80717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x564f5da03c84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7c0d93ce33d0 is located 0 bytes inside of 40-byte region [0x7c0d93ce33d0,0x7c0d93ce33f8)
freed by thread T0 here:
    #0 0x7fcd955be3ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x564f5daca36a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7fcd955bf60f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x564f5dab42d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1063

---
Regards,
Linux Bluetooth


--===============4525053448962697962==--
