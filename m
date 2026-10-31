Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793461925;
	b=D6DWfkba+OelfYj3ahnVPbuFKwlFh422Q2MwkJc3Ai3ctnMReH6zqt4cL0bhN2j1rH2W
	 +hjuLtBsjO+PPjKhDuz8Ijj1trQd63Wwyk9OlSbLfqAepy6MAv8fzjYYvg1yz6CdZJEOi
	 4TncPDKanp1npnJN/flrwlc0StwghL2xuznAUUNM1PMbXuDSrsePYFMHsvfTkyPhsBIPX
	 i/d9zf0Ors9p0F3kNW/wiZ0rd/mWonoBqO/IMOuKqdFf/G9BYxD5Nd2NOnGyA48WyEnGw
	 5/xhHBZJ+vzHdBBSJPZq0kDqrLmUXheXJmQZdA5RNiVpsDlGsgnChjDu1fC/GoYxfdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793461925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=+ttRfg3xTu+iCJ0CMUJwYaY4QDjXwlN6M1EsVqECDls=;
	b=uhAJwuf+DieZPaS3Zhi+R1kIQ5+wfpW9f+PHuuo1tElsIJV7Nr5Y8BIRvpPAvDFizfva
	 vo3iKmAe3LLi568ZbwyJs8znu+ANmRslaZ6HBdUm21U+iT2QL6THT+Nzrp8JIEPzj+1d2
	 5Xrd2evLXlEGrMiQjToC3gVVzn0rxk0ek8We29goYxNP4qjFP6EAWMc8ihC3mY24E/ATP
	 hYMYguiJTdEeFZZsfpMPM/kiy1+kZmb3tZWfdDviuo3hthTVpwYsL3VzCNDaw6n7soP4c
	 PXwg6Vsxp6BWQJLsvJh9DWcADRHlxwBHnA4HlWZa+tbarKrkvYv/Lz2YvuqZGQ/ccwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GZ2AXJo5;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FBC606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 15:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30FBC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GZ2AXJo5
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91b55859245so25800286d6.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793461924; x=1794066724; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+ttRfg3xTu+iCJ0CMUJwYaY4QDjXwlN6M1EsVqECDls=;
        b=GZ2AXJo53Kx+8z9vTU9bgFuCDmAXhbzU5oaPA6pozlSJv6NrdfSzahgn1e0CUvY9zU
         4dn2He6yKI+T3/MUE9m00ocRG1xmFxtc4Vh1COKIoHeA5blU1McIxJEJhr/D5eNtcTb1
         KVS+Bg5tBYJZ6ndGZ/pK055uCs8/+2bdBEOifW9SNFEvnMWJDBhoUrXh+FOi2VKd72o8
         o7RnWvBjMIZuzz3EynoPg8dzowhv0il2REzoeeVjGiFvaWxJOE9/i9Ajwqnasb8v1RE7
         whFfU4SysBXvOmpEkXUiXhDM8mYH3chVgLA1SRSEs/BP1MsDsS6CF3JMTImSBu/V4/yR
         XrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793461924; x=1794066724;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+ttRfg3xTu+iCJ0CMUJwYaY4QDjXwlN6M1EsVqECDls=;
        b=Ms43H/+4faYn3GEvHXFJOycX5EifKLZStC275jZaTt3XFfVPfMBlOGaUMu/mwnc1Wn
         TIcRnlpE5m7ZA57vR6FaIM5lwh3mO4ZqsxDoDWts6uwAU557xcpJVRo7DLd1i069sa8x
         Xfw17hmD3HaxhHfnwxeIM5vCJfDneBvlSVEDuHnmUTB9PL8QojEAbtfb96RF4DmMoVS1
         yz01WU0kwFu+utZ3oYcmyvlrq007Cz3xn4MIXO+LctwpSFkIV80V4Pg/Ff/Tw95CYKJ7
         +/cBwB63zVO4s1itVMrVFme4AzGwIwq20pcNwDXelX5qJX7fLZTu2IBQvuDBw1Sh1TaV
         0SAQ==
X-Gm-Message-State: AFq9FYK5q6Zu2yIenHMN+d67t1sGNsfs3XRhPWzpsRTt2DHudoZ70w+G
	OIwJWGACDVaPFvA1vgFVWHG1jxfHBDguIeUWeqru9kWHKBQQDFB8M1lUcm/K2w==
X-Gm-Gg: AYBFou26oVIyx8L8U87q4gEvy4U9Y6ikPWwvahckh6YpUdZvrw13B+8+NmsW5McRrte
	VxaEyKYsHf168D4nPTwbEMpQiyFldmfnuYjmI7E3k4Vzsv1Knz9AEjdMQFzzU1kiTvayvKFNRdI
	f2+y3uM0wJ6RDSlAJWx1M1O0PHJ/S2X9IB4In1rFkj2Cs0TFAqExbkq8iksezlQY62azmEBZQWk
	6J9fzB3yNUnIz4bVx6jV31PGuNQXetPsApk9Qk3+d9ZjKxpM9P9XLLWQexCPOt214eRReGrxy7l
	7lpU/aWfqVX0h0NNkV6rQh+6kdIQgtCckhzSCzGM7k0ZYZOiDVwcGV+3Sxi5cCbQ0bGIwk1Z8d1
	b0HxdvQa/gjqMreRXBXKndvbcWup1WZi5ZmWq8flRsB/t67XnuFdmTNZy4Pw+lbpGSjKSrwFWNC
	oW5qHeJ2N7NEukfg5HYQoaqFfkz2yleljrsjphfSPRC47VkIt87UC3C8kXHkFVJ7QSZwo7CPQJz
	xA4UimLdkHVtnvzIRv3ECmZIgf9RH+qR0SkPlOT1hH+VqlEsYQalO4lcFwe9kM=
X-Received: by 2002:a05:6214:2461:b0:90c:4422:84d1 with SMTP id 6a1803df08f44-91ca4b7de11mr88044106d6.30.1793461924092;
        Sat, 31 Oct 2026 08:52:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.191.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f252ffsm44685476d6.14.2026.10.31.08.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 08:52:03 -0700 (PDT)
Message-ID: <6ae60ea3.e3b8206e.29152d.dcaa@mx.google.com>
Date: Sat, 31 Oct 2026 08:52:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2138222683080426897=="
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
To: linux-bluetooth@vger.kernel.org, ernesto.salvetti@tambosi.tn.it
Subject: RE: Bluetooth: Fix LE on Barrot 33fa:0010 controllers
In-Reply-To: <20261031-barrot-le-fixes-v1-v1-1-30e2089882bf@tambosi.tn.it>
References: <20261031-barrot-le-fixes-v1-v1-1-30e2089882bf@tambosi.tn.it>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2138222683080426897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1197748/

---Test result---

Test Summary:
CheckPatch                    PASS      2.73 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      1.09 seconds
SubjectPrefix                 PASS      0.37 seconds
BuildKernel                   PASS      32.02 seconds
CheckAllWarning               PASS      39.69 seconds
CheckSparse                   WARNING   39.28 seconds
BuildKernel32                 PASS      31.88 seconds
CheckKernelLLVM               PASS      36.79 seconds
TestRunnerSetup               PASS      747.97 seconds
TestRunner_l2cap-tester       FAIL      12.26 seconds
TestRunner_iso-tester         PASS      15.38 seconds
TestRunner_bnep-tester        PASS      3.17 seconds
TestRunner_mgmt-tester        PASS      88.29 seconds
TestRunner_rfcomm-tester      PASS      4.53 seconds
TestRunner_sco-tester         PASS      5.67 seconds
TestRunner_ioctl-tester       PASS      4.72 seconds
TestRunner_mesh-tester        PASS      5.57 seconds
TestRunner_smp-tester         PASS      4.39 seconds
TestRunner_userchan-tester    PASS      3.25 seconds
TestRunner_6lowpan-tester     PASS      4.45 seconds
IncrementalBuild              PASS      53.50 seconds

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
==36==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b4fc86e33d0 at pc 0x564063e1be8e bp 0x7ffebf4101f0 sp 0x7ffebf4101e0
READ of size 4 at 0x7b4fc86e33d0 thread T0
    #0 0x564063e1be8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x564063e1cb75 in timeout_callback src/shared/mainloop.c:270
    #2 0x564063e1daa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x564063e203fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x564063e2564b in tester_run src/shared/tester.c:1223
    #5 0x564063d4f17d in main tools/l2cap-tester.c:3918
    #6 0x7f0fc9685600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f0fc9685717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x564063d55c84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7b4fc86e33d0 is located 0 bytes inside of 40-byte region [0x7b4fc86e33d0,0x7b4fc86e33f8)
freed by thread T0 here:
    #0 0x7f0fc9fc33ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x564063e1c36a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7f0fc9fc460f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x564063e062d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1035

---
Regards,
Linux Bluetooth


--===============2138222683080426897==--
