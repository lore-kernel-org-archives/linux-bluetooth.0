Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793563059;
	b=RysTEHDiN9InoJd9S8qvN/ECYQqNWT7v8GMHsvuqDabOdxqNNyG6hf5OOWc23L2fKfy1
	 wQNN5GMkAVIor85cnjBjpSJ5WHJaPWoQUNAagwtI8L9bTruu4LMbkq4x0RtC83p63O/Pt
	 Yjk8R6E9pbG2KHv5n06QHKZS2IRkwtSiPdHXnd8sL4/3lYZ++wbIz25DYhENGU+yosum7
	 XnIVVxBRwRm7uJBw/Cxcsk5visRTYApOI+O0e65jjIxfkxH3uXpx5clBUWth/I155NTM5
	 9eiLyQiX0fm3W+6nhMOqVGYsgyHCZfrv0xzhF9mHMGBP/GnM88/ZP3XlNMmgpc82EJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=7itIl+UKK7HQHLPGPCF0KfaxNzgXPIHAGcNIEUCYWPE=;
	b=ITuTCW02tBjiGUTiyC4PvX5GlJMsf3o8LW6h8hLo9BHpNUs5c5hrfLfPnQDLOQeaW5qO
	 UEIU8yRQJ0ls39zEycduiNIwuP0llpJ/urCjxR5I+JS3PkbLOpc3zS2ZwtC59gHEtgg/r
	 1R5AXIHw1U8YW4uKuBK8oSajBks3ppe2PTfBVXOTlLKnYy8VVl4OcIpEASapLDNg38Ak0
	 T6P0dl71qolw2OEQaPqHVy9GwwVA6WnBQ5uI0A3O8+pkBKw3CBhmdzjB3KZWXv2e/UVF5
	 w1CzkHCIkpOOVIP6v1IU9q2M9H5pplda0mmwUMsd9C4dsM3SoDSzHP8MxhW45UZGlVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N0y9+Qnt;
	arc=none smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A8D606A324
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Nov 2026 19:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0A8D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N0y9+Qnt
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4af81963f35so1757878b6e.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Nov 2026 11:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793563057; x=1794167857; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7itIl+UKK7HQHLPGPCF0KfaxNzgXPIHAGcNIEUCYWPE=;
        b=N0y9+QntRCa7WhZqyyiwHoi+4M+J4Ua8M2xmadRYBS7+0oC9r0Mhg+tzXHhijMYN7D
         61Dr72RCNz+hfcc2DbAn+iM8UHaOjlJA5oB5B4vxBRa6db88N/N3GKeI962zrroC+x/D
         Wh7vkancuEkhL+mD6zf8ns3YLwke/w5Lx5l5VUdRvyf4sCPjY3CTgD+t4XXQH3h1J99T
         TshUsckma1UuMfKatke8EWEjz5dosI2Lhvao52taSUgE0/rxwl1WiVgoHLEJz+IWFvit
         Un2fhINzqQgJAlEFswJ/kZzbgVLr4/s/QCoCuovEU+fL6lXgGDONewH6PuWre9b+yIde
         kLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793563057; x=1794167857;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7itIl+UKK7HQHLPGPCF0KfaxNzgXPIHAGcNIEUCYWPE=;
        b=U9nbp5tHV7pb/+rUK7RP68fBk76uovcrj3YLUWdM9vnooFJgDsfUD29uQTdr26CQ6R
         4yd92aQhsfJQEwCMn4cP6gUROchLOZofrfQNEoMP2es8qyeIKpLzifegk40oIvnrJxSR
         H8YTAVLsI6j2ETavU9UxjG/MK48T9Kf5Y9C3WrOltYc2mgFuVVerVrBQI06HcTsrw+Ud
         EhAuxCAA3OYsNuY77katfYZrUZYQO/peaP/NsRqH4A41pVHFKXSg2/FR02na9CqrWnjX
         ujzlyUXhfvv1ZZbtc8YsSl6/4IoIb/VWH18qATLDTGwXpp/ZZSQI2+b4VklXRDVOMSA9
         wKow==
X-Gm-Message-State: AFq9FYJjU7nWNfoz6CLopo5tiTV0ViAHBZRWbYR9j+h9F0Ht+NlCoJcH
	sXAO2fYOPc2qt9KU1lAPJ/Eatokeab0h3iMpw+lnQF/kgQF8pcGndzxtRrAo6A==
X-Gm-Gg: AYBFou1YTCvFTv8PcmXYaEtRXlVYr2l1y0Kc5fATAqOxL+zysnKBXzCxW5Sa9oNXzY3
	CW9zfMrjhOEkLLqhRyVSaCK2aM18JwH1XE7fB7GhX3orQK9fHO8Tw+XjftQAh2k6qM6xD1vmHq0
	185rnqrR4du+t702HFVn59t3TcuYfRSVbrUsT8Y6yEC3j/qXvd6Mp6GNZ6j7Xa4w2fRa+mt7s94
	VwXUmmq4eGSVL4dRSM3+4FyqdfSv0zHVG1XNA7uKGloRnWN43cUqqV9+y1oc4zX9VMbdr0FX9hz
	WsIru8dYDZZ6cvyUD6jrLaj0Ef8rgVhwcVtqHUKB1LFczgdv+3bhsaCY5Dj1J823IBBi5PAB9Ym
	o7rNglndrnt+m5viZaSBfG5lD0B4ilxG19koubQySNkOXP0o2RMqyprd1MmNaXhEpMdKpGRzWSH
	g0yzNAqLea6f4Zn9aJDuxg/TjloFkXM5jKf4SPV1/5TFC/wDqWBibEFfPwcavQ5oWQzc2/8Dy9L
	8jep5Qb1YS+/kUZx/I/L5DIgpLhBZraKpqtyMNWEFJPSsbIDWK1qhFjtoGufEy9rF33x32zUGhV
	MMnnslgZyZQt
X-Received: by 2002:a05:6808:6508:b0:4f5:4780:582 with SMTP id 5614622812f47-5640dfeff32mr4836453b6e.50.1793563057364;
        Sun, 01 Nov 2026 11:57:37 -0800 (PST)
Received: from [172.17.0.2] ([172.183.135.150])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe45587sm6254931b6e.15.2026.11.01.11.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:57:36 -0800 (PST)
Message-ID: <6ae799b0.184146ba.4160.b8f1@mx.google.com>
Date: Sun, 01 Nov 2026 11:57:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5306949575726125600=="
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
Subject: RE: Bluetooth: find an RPA peer's connection parameters by its identity
In-Reply-To: <20261101-for-upstream-le-conn-params-rpa-v1-1-988629a09bc9@podgorny.cz>
References: <20261101-for-upstream-le-conn-params-rpa-v1-1-988629a09bc9@podgorny.cz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5306949575726125600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1198202/

---Test result---

Test Summary:
CheckPatch                    PASS      3.92 seconds
VerifyFixes                   PASS      1.28 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      28.99 seconds
CheckAllWarning               PASS      33.23 seconds
CheckSparse                   PASS      35.53 seconds
BuildKernel32                 PASS      29.33 seconds
CheckKernelLLVM               PASS      31.75 seconds
TestRunnerSetup               PASS      678.99 seconds
TestRunner_l2cap-tester       FAIL      12.14 seconds
TestRunner_iso-tester         PASS      10.45 seconds
TestRunner_bnep-tester        PASS      2.99 seconds
TestRunner_mgmt-tester        PASS      86.50 seconds
TestRunner_rfcomm-tester      PASS      4.29 seconds
TestRunner_sco-tester         PASS      5.38 seconds
TestRunner_ioctl-tester       PASS      4.50 seconds
TestRunner_mesh-tester        PASS      5.32 seconds
TestRunner_smp-tester         PASS      4.17 seconds
TestRunner_userchan-tester    PASS      3.06 seconds
TestRunner_6lowpan-tester     PASS      4.24 seconds
IncrementalBuild              PASS      27.60 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==36==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b926a3e33d0 at pc 0x556ffff58e8e bp 0x7ffc6f1889b0 sp 0x7ffc6f1889a0
READ of size 4 at 0x7b926a3e33d0 thread T0
    #0 0x556ffff58e8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x556ffff59b75 in timeout_callback src/shared/mainloop.c:270
    #2 0x556ffff5aaa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x556ffff5d3fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x556ffff6264b in tester_run src/shared/tester.c:1223
    #5 0x556fffe8c17d in main tools/l2cap-tester.c:3918
    #6 0x7f526b350600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f526b350717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x556fffe92c84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7b926a3e33d0 is located 0 bytes inside of 40-byte region [0x7b926a3e33d0,0x7b926a3e33f8)
freed by thread T0 here:
    #0 0x7f526bc8e3ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x556ffff5936a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7f526bc8f60f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x556ffff432d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1037

---
Regards,
Linux Bluetooth


--===============5306949575726125600==--
