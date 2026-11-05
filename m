Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920587;
	b=TB6YP4kH0+a3lscssz7fS/yAKhTVnMgXVkybaMRR3pVBYtQNO3NeDLpCVZ8vPQZ2VODR
	 9CxKhWWOVmVltSpJ08RmWZWETGcU1cfohF5mP3bnP2kKBClBjgo5i+C3gqH8+AaauBKgs
	 0VfxnVOPuSL4hF/zcqNzv62V3WOxxyQUvt04YAd1N4SCWgr8mLWLFN9UAhqxua6KqLyJ0
	 Vip95k9MOX0sGVSYajkO3uAoX7OTzBhCdimquJ9T2Ha9OAWlWlJO7Ro+fUl7Lan7WIWpV
	 Ejb+t/ibefEfBHZm9+mhvvs7QKcPBebwQG2uDraKV2NHymQTieas3ZvoXuk9Raqj6IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=KaRc2jYQ8xe6vLgRHkaK2sGj6Xw7KXNMAt52FcZWGIk=;
	b=iY1De6Ns10TBvu2wbsQnLQL6DrxDZWNGgbXFy9x061h2yGnfDK5cG3ZpJucOOvM8HSFl
	 bFqsERFX/qDdJcftOS/orQGVg5pBxXDGu9oXUjV6fP1ErpFMfeZuxasyRK2Tj2q+5eu5B
	 RtPArGheb5ejRYaDzm8hCORBdoObTH+xcO39RwHAdVD3g2fkTldhL5hWvnNt7Fma3itxM
	 9fBvjUH3WYyLZPguDIEl3d/qZeUGsIEiW1axKzY2UMBCNhpmpFLIx2jvZiAlqHGXvbnzp
	 gHksJ28aU7zxLLAzK8k8fdKoWrOLgexrAOVjm/mllHV4VMBnXcTJAQdKKw0Jv2KJecQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CBRCuSPp;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0998D606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 23:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0998D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CBRCuSPp
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso212675ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 15:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793920586; x=1794525386; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KaRc2jYQ8xe6vLgRHkaK2sGj6Xw7KXNMAt52FcZWGIk=;
        b=CBRCuSPpNMZyOJsipF6PMtBibWHflp0aLGEf5FTQ7kLTHN7gVfDjvC73yBUy5PV9W0
         HQ7Eg1U3M8r5cUR/7B6Ff3tyPaacamo/zX8VWr4j5bVqr1ZNs3N3wjvnnJexfdm8q1cI
         XvHHecq4uhrHTdPfT6VV627r6iUt0/qJa+qU3N2Rh6InW2C4KTItYwWgRttkXmqJsPkK
         LC0iML7Tjx0d0GwhiWtaWgdBtFZHkl3BmJSzexH3Ok8TF0gC1VRnj9kWd4CgQxdJopk3
         Y6ylUFnMQB70Yq17FrnA50i+lbsO9+WoTETdfq9Xvq9OYOesq36pKdRpOGBr045ZSTMN
         MPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920586; x=1794525386;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KaRc2jYQ8xe6vLgRHkaK2sGj6Xw7KXNMAt52FcZWGIk=;
        b=rNA7+D+3HMdPXNjIn/eIzZ7hnMnHq3faOnty643xoICIY7CiXKyKTTIkXISxh8qWUQ
         Zbe2HY6p9iF+RUdfQ4ZkJLSBQM9EtgrUvjrGbJ0wVC37qgmJPNVsSWEDwzg8DNz2tJfG
         RaSoD7nttjjcD++3F+2fIFrdckvhQHAwYStqyujVIhfiINqubzXz/rWQAMHdkj01N9Md
         CdurG1JN2QjOK4bkz5HmHeoc4LglFXjar3FH2Qcn6s4RB5ugxHMVb670FgEk3l0bWsZO
         oNTmhngBoT1JEVSUZVyXFh5OMHgY/+Rv229/A45GVjSeM11u54yor9ncJEf8xMVr4wnF
         J2Yg==
X-Gm-Message-State: APuU4Z8bLgEEjaLGr++59XArvWAqVf9bfduSE5EXIVpOf/x1sPYgQalh
	8EHGh/Nbyr8Uqfy6hANbg6EDSq9FfqZB4JUC71sIz9Udi6yJLNRvR5g51bmcpQ==
X-Gm-Gg: AYBFou0UubtpZn2Pyh0W6l/B5foOWiydMbKDG65Ani2GJLwOwa+wWud+pC3G4vSi3Ak
	NC43okfX1uFWO7CmxHwJb8uSJlNs8BqFwtjE/2yi/TRupcY2Ver3DhxLUCX6/K2/Y1d22EJn9k8
	AfvDKqv+/bEdVK3dLwlP3fdgn8QEb0QL9eeHpWB0jqy8ywX3E+HRwyvbm/ISp9O+3NFhYwKm1vs
	EXf4gG0RUeWb+GOMKj+2KSESwfMrrBJzztLb16mf6csxcSuxpW0PlAn0hfVdurDQa6oy5QfcoLd
	haHD4hBzmtJ2p2Y6bgXXubb5Rmns/yZvPvKRU7dwlRcantaQ6KSQ3mhWPpiP/Vs6ZfoOYqsRY8G
	VBnSOXKtVZpvTgWp2lI/SkLF9KuAuSUzWWHLYAiUBeL/3xJjYsZaecumhNRI/1YEO5A4Tb2BSan
	pGKFbLjg4J2podwvVPd/TDkRaH5+6GNGa2J6jNPfRwix2BlnMQE/SVdDzr7+FcZTvNjg9bvrlkI
	5hDGH51oE5Kliu38SNhNr5DvKeUjIoTUeIJAdFMKL42IpCsbNrFQxs/8IGy5SPV
X-Received: by 2002:a17:903:2ac4:b0:2e5:c563:c0dc with SMTP id d9443c01a7336-2ed41c0ae82mr11090405ad.42.1793920586124;
        Thu, 05 Nov 2026 15:16:26 -0800 (PST)
Received: from [172.17.0.2] ([20.115.146.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed477a92e8sm120095ad.25.2026.11.05.15.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 15:16:25 -0800 (PST)
Message-ID: <6aed0e49.a1b259eb.344405.2759@mx.google.com>
Date: Thu, 05 Nov 2026 15:16:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6962953511756348893=="
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
To: linux-bluetooth@vger.kernel.org, bence.csokas@arm.com
Subject: RE: Add offsetofp() and offsetofendp() for pointer arithmetic
In-Reply-To: <20261105-offsetof-v1-1-4153f5c10edc@arm.com>
References: <20261105-offsetof-v1-1-4153f5c10edc@arm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6962953511756348893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1203387/

---Test result---

Test Summary:
CheckPatch                    FAIL      11.80 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.62 seconds
SubjectPrefix                 FAIL      0.35 seconds
BuildKernel                   PASS      28.73 seconds
CheckAllWarning               PASS      32.78 seconds
CheckSparse                   PASS      35.19 seconds
BuildKernel32                 PASS      28.58 seconds
CheckKernelLLVM               PASS      30.98 seconds
TestRunnerSetup               PASS      695.81 seconds
TestRunner_l2cap-tester       FAIL      10.46 seconds
TestRunner_iso-tester         PASS      12.58 seconds
TestRunner_bnep-tester        PASS      2.96 seconds
TestRunner_mgmt-tester        PASS      87.04 seconds
TestRunner_rfcomm-tester      PASS      6.73 seconds
TestRunner_sco-tester         PASS      6.73 seconds
TestRunner_ioctl-tester       PASS      4.43 seconds
TestRunner_mesh-tester        PASS      5.55 seconds
TestRunner_smp-tester         PASS      9.02 seconds
TestRunner_userchan-tester    PASS      9.13 seconds
TestRunner_6lowpan-tester     PASS      5.75 seconds
IncrementalBuild              PASS      29.94 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[3/3] treewide: Use offsetofp()
WARNING: line length of 107 exceeds 100 columns
#483: FILE: drivers/gpu/drm/drm_edid.c:3254:
+	BUILD_BUG_ON(offsetofp(descriptor, data.other_data.data.range.formula.gtf2.hfreq_start_khz) != 12);

total: 0 errors, 1 warnings, 539 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14954507.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==36==ERROR: AddressSanitizer: heap-use-after-free on address 0x7c28be8e33d0 at pc 0x5648ef767eee bp 0x7ffcda785f60 sp 0x7ffcda785f50
READ of size 4 at 0x7c28be8e33d0 thread T0
    #0 0x5648ef767eed in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x5648ef768ed5 in timeout_callback src/shared/mainloop.c:271
    #2 0x5648ef76a006 in mainloop_run src/shared/mainloop.c:125
    #3 0x5648ef76c96a in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x5648ef771c4b in tester_run src/shared/tester.c:1297
    #5 0x5648ef69b1dd in main tools/l2cap-tester.c:3918
    #6 0x7fe8bf7e6600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7fe8bf7e6717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x5648ef6a1ce4 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16dce4) (BuildId: 0d2067a7ef8fe61fcf622598953c7d0f996221a0)

0x7c28be8e33d0 is located 0 bytes inside of 40-byte region [0x7c28be8e33d0,0x7c28be8e33f8)
freed by thread T0 here:
    #0 0x7fe8c01243ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x5648ef7683ca in timeout_destroy src/shared/mainloop.c:252

previously allocated by thread T0 here:
    #0 0x7fe8c012560f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x5648ef752335 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1072

---
Regards,
Linux Bluetooth


--===============6962953511756348893==--
