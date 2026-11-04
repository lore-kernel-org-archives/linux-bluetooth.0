Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810763;
	b=hCviYOQa+MXZQKX2JhVxzKX0+zUU9/CiF34FaqoI6zW1j951/kAeF9P374RB5yZUifxJ
	 fVIPa0vDgsmyumF1rkKL/dTUoJhA5sCTm3/epuYniUFEiXdeD/rhufX/JUSEB08OK5J/z
	 CLcFP9BbgLQJpzQ25N+Iiwj1adRw5YZK3Bqvo8ur1AfvLABcrmq1zjybLUPACgqDcbWBn
	 RA12cha+NT8gLfHissPuQyyxsGrWbpSGlgfbseBoDgSq1pb10j5rT1RP1c2eDNSpn6u4q
	 gAcOaTUcMr7LmhHzA84gO1lqjiBqLOAavfjTZQn4gTJ2yvCUwBvP1kMUrCmgHiXPX4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=7V3gXbyfQM36xLBb8BJXaSpWtlCMy9mLBUcKPKOsnm4=;
	b=w3nFsUcyq793zwBxJ6o20Z8uSTyQTq1kIgjVapQvxMjJT6PgTad9oHHpLIGngMQlPcnc
	 ejlSa+Qz1/uOlCe0EQiGqGl6vCkWsQGWL2VKEXSezsQiDb/r8fXomTa0wEsXbteXpI8WL
	 Cf+jKxYvlLit741l4vbdNLKw3uiFyJtCrOOCv8uk+Q2FbHQrbq+K3HdyhJ2lK3DnDuKhA
	 HIpEeCRrdHoQBzuTFrp7E9PJ485NzB2RV68F+Y2wfQnhjft4y89tloNPs0zYEVnLSgzKD
	 3v0LOHIkrESqckkX8GskXGRcD3aWd4II3tPTAA6P7K01kHWyJSbQUQtdO/mxWovrqOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vUtBcO/N";
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB4606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 16:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10AB4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vUtBcO/N
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f3c616c84so83639585a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810762; x=1794415562; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7V3gXbyfQM36xLBb8BJXaSpWtlCMy9mLBUcKPKOsnm4=;
        b=vUtBcO/NdBV8fX95srebHbY9fFe9xLok0ramaPZCqA8Ziz1epr1ncJ6VHvziRXhZYF
         opXSeEePz82ZJ1eGtiZAeTCwrmcevcR+2CPEzKd6+33FRbVuEgigA/++scA4pzsop76p
         7XpYBFWvyF04TfPspLkcnbwxZbr8k1EoQjduk5OtvDwfX5FSLyjqHfZWOCNOEPt2suX6
         FtWyqDE3oKd1kiyjMVulW21PXx0XDQV80AvDBIWbOfcgR/kpuIrNS+XF0r1MhhQYRhlw
         X/t9GNbWmHY+qQw8jWHq5EKOJvY3psumLbtm36kuOjfroMOq3TfyyMWdkOKMXwUGunJs
         vDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810762; x=1794415562;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7V3gXbyfQM36xLBb8BJXaSpWtlCMy9mLBUcKPKOsnm4=;
        b=DjW0VpUrK9L+ndIBPwTHAFxXkeFOefSdxy+QIrIajs5F9fFCixEusUQElazQAHVcGC
         sClHJFeFWX0TeLzz/XoQBoiHhzmsp0PYxY+RzSJqdvHtIOXZBK0bdp/jKY5xQvxAQRY0
         64mKPK4JTuy8SPMqT0QlKLqhTqTeFqbFhdoG8clK9lpRXCNUTKvtOGi8EwbOcJpAWGcH
         VdwAbkMzs+l67sEhecqUaBgp9kmKws03gL6eMDHpGuJr/FoHCVBL/Dz+inH0+QRfS8Z0
         hJ3kPqmV1HGs+mXTwTgX5q7lFvWQCVLzATvM46tRPtxqD95b0slXY8H5TW49qxBTxik9
         0aTw==
X-Gm-Message-State: APuU4Z+8BSZ76JXxPBTys68zL9NLXhT7DjbhLgMxxe2cXSF2dHCdIoS1
	wrmc+TEIXufVOeGoserxN5AeQ3fSU9UPB6yEo1bZv1+mmxgHW0FtickwzhFjug==
X-Gm-Gg: AYBFou2IUP15XZwG3XYb2TZlZEgbuFNEsvHiGgDwVT7hAkr76fZ7/ApeevcphRhVSQF
	m7geUqppU1L3O2b337NnenQkVgvdDD3V/Mxzm9gCBuTmkHbTynOK6fXS2LxykNUCPkEujYdl8Lw
	R2BQPQiBTlNr+E/YvMGQqkR5WK8Z5yX1x6DSNfC8lNTuSrgvJukhJuQgXePRwAkjglh6k6u8Xzi
	DwEUs95Cv4HSC+70Qivcx0gcxQWmBVUsreMK0wPi+iAZxjFAeURqVrCPkUBhhx6P5yjCiGOUbWJ
	lolbHnLIlxb4BcT/HvRq0gKKaklMR85BmzoZWjRQEE6RkaG+jarV8xsVkX1FYsIRvzl4U0wUPmT
	yWn9fagm74Ys8REq3MifPotJan/Jvd2b+0ZCYyTQ+3umBNsuLXcJoO9R5MjD6CU8yCvE45PffES
	68pb6AJih+faZaJIhUEk8a5I+JG+WyrjmsaBRu3Q2HlMnbMJ48Bv2ZM52tnDpE3a6vyDc3nQGJt
	5m2fqtYAcN41HxgARLEu9N+dRKWTp7veBvT78pS1Tg7PjiKWYP1ofcD3oW8rA==
X-Received: by 2002:a05:620a:2a03:b0:93e:c12c:9dd2 with SMTP id af79cd13be357-9442178fc95mr2506115585a.82.1793810761534;
        Wed, 04 Nov 2026 08:46:01 -0800 (PST)
Received: from [172.17.0.2] ([68.154.54.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d48556c7sm241987185a.30.2026.11.04.08.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:46:00 -0800 (PST)
Message-ID: <6aeb6148.e20a777d.27508a.28f5@mx.google.com>
Date: Wed, 04 Nov 2026 08:46:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5972199367054624382=="
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
To: linux-bluetooth@vger.kernel.org, dev@deq.rocks
Subject: RE: Bluetooth: Broadcom controllers of the Apple T2 Macs
In-Reply-To: <20261104151601.70493-2-dev@deq.rocks>
References: <20261104151601.70493-2-dev@deq.rocks>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5972199367054624382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1201944/

---Test result---

Test Summary:
CheckPatch                    PASS      17.29 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      5.05 seconds
SubjectPrefix                 PASS      0.54 seconds
BuildKernel                   PASS      31.31 seconds
CheckAllWarning               PASS      35.69 seconds
CheckSparse                   WARNING   38.56 seconds
BuildKernel32                 PASS      33.61 seconds
CheckKernelLLVM               PASS      35.67 seconds
TestRunnerSetup               PASS      734.75 seconds
TestRunner_l2cap-tester       FAIL      10.66 seconds
TestRunner_iso-tester         PASS      10.73 seconds
TestRunner_bnep-tester        PASS      3.20 seconds
TestRunner_mgmt-tester        PASS      89.37 seconds
TestRunner_rfcomm-tester      PASS      4.51 seconds
TestRunner_sco-tester         PASS      5.75 seconds
TestRunner_ioctl-tester       PASS      4.71 seconds
TestRunner_mesh-tester        PASS      5.59 seconds
TestRunner_smp-tester         PASS      4.41 seconds
TestRunner_userchan-tester    PASS      3.26 seconds
TestRunner_6lowpan-tester     PASS      4.57 seconds
IncrementalBuild              PASS      36.66 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[3/4] Revert "Bluetooth: hci_event: strip Broadcom vendor bits from legacy adv report type"

1: T1 Title exceeds max length (91>80): "[3/4] Revert "Bluetooth: hci_event: strip Broadcom vendor bits from legacy adv report type""
[4/4] Bluetooth: set the strict duplicate filter quirk on Apple Broadcom controllers

1: T1 Title exceeds max length (84>80): "[4/4] Bluetooth: set the strict duplicate filter quirk on Apple Broadcom controllers"
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
==37==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b96372e33d0 at pc 0x562d946f9e8e bp 0x7fffafeca460 sp 0x7fffafeca450
READ of size 4 at 0x7b96372e33d0 thread T0
    #0 0x562d946f9e8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x562d946fab75 in timeout_callback src/shared/mainloop.c:270
    #2 0x562d946fbaa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x562d946fe3fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x562d9470364b in tester_run src/shared/tester.c:1223
    #5 0x562d9462d17d in main tools/l2cap-tester.c:3918
    #6 0x7f56381c3600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f56381c3717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x562d94633c84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7b96372e33d0 is located 0 bytes inside of 40-byte region [0x7b96372e33d0,0x7b96372e33f8)
freed by thread T0 here:
    #0 0x7f5638b013ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x562d946fa36a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7f5638b0260f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x562d946e42d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1065

---
Regards,
Linux Bluetooth


--===============5972199367054624382==--
