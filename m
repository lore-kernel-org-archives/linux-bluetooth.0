Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961627;
	b=zrVVgGm15KWaZbRdldRIe53oKmsuy19k4lVLxRO77Ir6PH7IeKpw2hgEg7vXAbsjtNFU
	 a/x26CkvYbZjnFUjgVW1e916amz/zmZuM5Oqbh7G/Wm/99Ys0liV2VBXtMLZKk2TebVu7
	 rcnsVKajOwvPFch8+zZt3K6hldZcfgnHXxiCZU10HWzhEwCqRcUaovEB5wIoFrG8e/FqT
	 UXujD8kc42z2w/623jHJB8Y5shtqPhz2Es9Ce2hVuiPCjXHubX/HapMSfkdJbNi+aOnwy
	 p8+6BiSeAMIO6GSzNSRHSsDU5f6BMCQk5KfjF3y7k1arw5LqVTP6TTQ7Hz/8FYeIdHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=TrRfVULw3Wz9jP4yTz1mPW+Mmau+AYXLsRIEwsyl7+s=;
	b=j0dwC1ZVX7NX4QDZjSIrFFYBLzCEk4jwihnla5Z7fzu076TV/O6F+5/N2HR6pUKwo7WH
	 InkPkoWmI9kSQYVAe2lggQ+Dg5PBtBsWC4sGAdhAZxI+psEIwIJngs4Gvo98kmp4/rkar
	 jQj4ujBhwsCRNVyGRWwuk2CcW1q47MwXgP//Fc7W04CT0638K8XCwgf4MyPVxhhijmDpY
	 YC06LI+oqVJCKHO9bAJX2NbmY/Ia1c8re3aPZw/qroZpf3ZflVdWMPVhtae4+cfux5Ixv
	 Pv1rkpxWwYzlUVQE7X2/qZdmGCizkcU7kWbnCpMDf9KyTyMAHEVkXNyrdZBFaXzIntQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxElU7Mi;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D36606A32D
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 10:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70D36606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxElU7Mi
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3282db206d3so997139eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 02:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793961627; x=1794566427; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TrRfVULw3Wz9jP4yTz1mPW+Mmau+AYXLsRIEwsyl7+s=;
        b=jxElU7Mi7R4nLwFxSTWvElNuZFzRCZSx/Z0rncA6LHcTNmGj9wiYd+HeG+hnpH+3FT
         wcnCmWfOwb8DnTK2EmIpS+7gWH09ReTG+0yhFi5AbgsgUSoW3zzEFt+S8lFYRAJCz4mT
         c5KPutzeRpmLYKgmbHqmkI5bKBQl1Ccpa+mKsxFRophPhzUOfcUdw1v/8XjjItYJd1MA
         mr2KvXlMAlHm5QT7fur+BUeCvAoOdPRQjkvvmTL4oa7CVjRTNZZqf3hLk8/KXG3xHCfR
         x0rnm2DC7DmPFZEOHC+/lKmp8ZSu33m+XL6aunHS7Z+G/hwGbD/S/zqKsEReN3GqjGqc
         nj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793961627; x=1794566427;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TrRfVULw3Wz9jP4yTz1mPW+Mmau+AYXLsRIEwsyl7+s=;
        b=Ctv5XXEzee4qBNaVareelXYkZFFwFO88lqdiDwAhrd/I68iXnOF4ifB9yLWpxESpCe
         6euJ9BpSowK20KrwwUFxYaV5p71ck5XSYZGLiXq6Ssrxba5Fxiq0m1fusMzvnhhMRyYc
         VUVzA0K64ZHgsiBxUdlMmKuixSXKyHvIu/yn8gv4JQl5IW6GURpCMzjdbdMYXno37Bdx
         mZMoezA2JHMqxgB+nRrClqewNfYS+AZNDLG8aJjC+u+mX1ogcHA/DIJCRmYSMNwOR52Q
         XmYAkxdWfa1WZmVVa5JfSwBSJZK59I6uxEvwNP7ApvTCAqgi2t2Ommj7USC/UGaW0LfF
         JHXw==
X-Gm-Message-State: APuU4Z8h9GK+52ihMoHWWhLARXtGFlVZZdy2N2Z9hAzhPjGjL0uPfPXj
	96gvEsQVfqJaQGgigB7Ef3w4aGS44Djr+EK5sdlVjy0Q+Zs0e48GkApQHX7o5Q==
X-Gm-Gg: AYBFou3U4VJ71jIyaKIQiAOPxgEjuq2B75WLMvoxIbBwVuZFAqo0FzVzaghi+v5y8Me
	eTiF3s15fzknoYjSvMJA9XWCvGQ2g6xXfiSiD2x0sFL21eCNjBKN34ue6BC6GUNu/fTvlA4VfJp
	UZmCDcDOeF7XM0t3MM7QCgktlH6awFZmlHT759jRMfVhrYKefz/GEnQsj02fUVJ3JwQoApcF4we
	5ZTlERATUEai4JJmouneeJ4qn38FWaBvI2Bsaqi2XQUeP5Xdwv3S4+9WgQTlwLov+RJj5uyV7W1
	j5I7Fkwf1VGArswOwESru9JYRtSAOJbUF3sW1GJxutNbIRxe4jeDQi4o3HRrsuKwwtwO9r3LK40
	MyGkuLKlcz6vFQttwnUTwKTAJ4fKsJsdeWlriwHyuKE5Jk+RbcL0gAUT02nwCbbrepbbb/C9wzs
	JQ5hSD1uFDiaodAH6Yep5uuZ46dKmNDW4wXwnbvQhDo40Zd/siz6aBhLyvNcGkBIVkRkuJuKC5n
	k27PdoJRNJhj2tGo2In9dZsEWD+71+3jlnyfV1QOy1jCjLUXHNMZODyjJeGGrOj
X-Received: by 2002:a05:7301:7187:b0:36f:4569:7392 with SMTP id 5a478bee46e88-36f77103af4mr2744986eec.41.1793961626394;
        Fri, 06 Nov 2026 02:40:26 -0800 (PST)
Received: from [172.17.0.2] ([128.24.162.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fce02csm5815503eec.22.2026.11.06.02.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 02:40:25 -0800 (PST)
Message-ID: <6aedae99.d3462a00.a118f.1ad7@mx.google.com>
Date: Fri, 06 Nov 2026 02:40:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9098318283262489967=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,v5,1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
In-Reply-To: <20261106045515.853897-1-cochcoder@proton.me>
References: <20261106045515.853897-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9098318283262489967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1203754/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.57 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.54 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      32.32 seconds
CheckAllWarning               PASS      36.37 seconds
CheckSparse                   PASS      39.18 seconds
BuildKernel32                 PASS      31.46 seconds
CheckKernelLLVM               PASS      35.59 seconds
TestRunnerSetup               PASS      751.80 seconds
TestRunner_l2cap-tester       FAIL      10.71 seconds
IncrementalBuild              PASS      32.56 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,v5,1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
WARNING: Non-standard signature: Assisted-by:
#94: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#94: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 133 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14956133.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,v5,2/2] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
WARNING: Non-standard signature: Assisted-by:
#101: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#101: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14956134.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==37==ERROR: AddressSanitizer: heap-use-after-free on address 0x7bea177e33d0 at pc 0x5565a9c25eee bp 0x7ffee26491d0 sp 0x7ffee26491c0
READ of size 4 at 0x7bea177e33d0 thread T0
    #0 0x5565a9c25eed in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x5565a9c26ed5 in timeout_callback src/shared/mainloop.c:271
    #2 0x5565a9c28006 in mainloop_run src/shared/mainloop.c:125
    #3 0x5565a9c2a96a in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x5565a9c2fc4b in tester_run src/shared/tester.c:1297
    #5 0x5565a9b591dd in main tools/l2cap-tester.c:3918
    #6 0x7faa18726600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7faa18726717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x5565a9b5fce4 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16dce4) (BuildId: 0d2067a7ef8fe61fcf622598953c7d0f996221a0)

0x7bea177e33d0 is located 0 bytes inside of 40-byte region [0x7bea177e33d0,0x7bea177e33f8)
freed by thread T0 here:
    #0 0x7faa190643ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x5565a9c263ca in timeout_destroy src/shared/mainloop.c:252

previously allocated by thread T0 here:
    #0 0x7faa1906560f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x5565a9c10335 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1077

---
Regards,
Linux Bluetooth


--===============9098318283262489967==--
