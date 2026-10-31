Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439884;
	b=cWJo/MD08/TC76vzMo72qJ6JK3bldtDbHjdeIiJDDK0akYv9bFJgHPSZ45IOiYsuaJRk
	 AXhPwvFFOD7/xkCzktpnemEqhTVe97101K8LQ0uBG6ypzDlMt7PYKQp4DQb1Qrpv9JWiB
	 u5vjepQuh+GJ4csomeEIZBrNtgyB5KNYf0xnFVkLMty4zsuWI7M+meBNTYOdgLLmPBPII
	 4mi8ug43QoakQj0YCM6SdTx7VVb217mi+pAg1buPl0jSVYmwN9rImCe2bOt8U5VPJlqFu
	 vBRmncCWaWZbMOJBXfqG4Pvd1Q08nijEHnR6Iy0alFAKJW7Tr4K797Ds6AeYd4wTUjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=wah1C+AemO23rcWKtBPC9YlIp4pZRf/KFz0Z1VZ99I4=;
	b=qQE9mIzB50AxLkZBkDabazgUWMumpWJtUj8Up7MUPPAUlMETCeKWj5IrVGkWj0Q3d3hO
	 R00DObkUn/GTpO9rssqVu41f5LAfqci3srFS7k+ASOd2F1ANtVsVobne4btQSa0HrDWRW
	 u5MLJsX3w2J6CO+C4ev5Zb+pdmw0VBkNiq+rgpr0+qwlZXlKAgOBEM70YPx0yrzDVoaQc
	 Tdj0/oi+K+tPS26mixqGUv/16p9AJQV1De7IiZlf6N14XJponUWL4jcPvpiZBhRljX8Kd
	 qLkwGOm43Ht1+8ecAh6M8HiGix81jph9YDJ6Jmh/YZeOIVQaEp++rBsk7U/iDqxPZXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PGx/zJaZ";
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912D606A31C
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 09:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4912D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PGx/zJaZ
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1311213c88.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 02:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793439883; x=1794044683; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wah1C+AemO23rcWKtBPC9YlIp4pZRf/KFz0Z1VZ99I4=;
        b=PGx/zJaZTIncpv3j9e5vRDqo6wmScwXATlZmqorpxC7zls73IJPaAWxjCheuBGxpt/
         EPAZKfc4Ou3QVnAZYVlQzlBL8i/yUmvfzpk+BEfQw+Hjy09Ma/hDMFHFgRWNnLfZYDjq
         t2C30BI+rMxy5vNPC32IOrKnrMhBUk5AQ7prtJxhsJPq9jgytoG714xRtHE+51gZVsUr
         VpZWGKA8FXWREVNqlvErRZ4f979+OcFQpuJLEzku4SBj53Rh9EZvyYpFVr+GQNzhi9AI
         LGJlXIWoSwD6wy4hYRQo02ot9L9RL1izjtEVEzMSxphRgE0k1AxllG2uzl7e7TQNzeSm
         Zo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793439883; x=1794044683;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wah1C+AemO23rcWKtBPC9YlIp4pZRf/KFz0Z1VZ99I4=;
        b=ImGYe0S3/TXx2ec2Omtnhwc88VSF42fXOzYoMJxfHEIDe2DHy5CEc4lSkRswOaO+9z
         DQtoYR9dZ2ms7tuRt277aJ0DVo9nV1J06ZDa5Uur0+iPtlNgsKicyCQepDODrg3xsyqy
         6mLlHeIXz+YoV+SJmPnwexIG707zurq/Q3dtqvLaNVdrD/3EBJyDiD2ai44YH1+7Sdu0
         qxEXlx3wHby+8FO2/fsQaDqe3ZZugRTuQJW7kBmeoKnMQJm0ECEmmEQBhj97u5odlzdT
         XAVLOADXYOyEd61wZ62dlQJfuTlCWc4dtDVLq0eQtKSiAPCYm5/wuQUVvXek2WCAXD2h
         nCrw==
X-Gm-Message-State: AFq9FYJZ4TrMT45989mbuIuKSb0CdxhD5ydH8lrSPft5cJp4psnKNM24
	O4fwlU8FYW7Bz0pOQLB/5m0hRbHY5Zf6ReaEJCTZvavZLR0CYhAWwh9HX+cy1g==
X-Gm-Gg: AYBFou1NnomZ7o0CVeDb4KbfucvC39se1imeET2rJkTiaKfA+uhlkUO4SmQyF+gwhQv
	lEAnrxpxC3l0P6jnexTTrvQ3fAxae7DkVGiMKuExF9i0CqYtf0RLuY25fvJ81C+DtSGbg3zxB9s
	jQolxNE/j7HN0MM62xATiSOR8OCX9UWeXsmWQ6uSEIVA+epRJvUPwp9UzWuhZKmhmeyM2AeGm96
	2MrILAqk3HxZtePSqeO/C68TaLCJhs4eAdG1oft1g73X8fsxURm85hrZ3Pm7f8uHu/fVA1EHt2v
	EN1j0TEKaKDfg1/ZRrBb0RTVJF+P4qGbWMYh1pndo9z0X3tpbm+/9BQRNK+ILMch3NIlMdMGi2s
	h2or8qpZWyv10yTmuvRDpy84giLnNDPIDpWQMSLRTfrq4XYbs1kRT+jCa12eHcK8gXSer9vanon
	q7zzKUPoTSuYhgtST9MHCRhjdq6E4sru6KebjGb4FSc2wUx2DLIJQTQxKeYjR2aRbkFhnrfOaE9
	3+pi8/szYRY73n1x87jKGULPjQ+EVQtKgBUyTJGHO06UHNmw6sBL6+8DH3vXRGzNF8uvOwx7P/p
	at+s9CiLoA==
X-Received: by 2002:a05:701b:454d:20b0:1ae:6a48:8458 with SMTP id a92af1059eb24-1ae6a488472mr3343136c88.22.1793439883287;
        Sat, 31 Oct 2026 02:44:43 -0700 (PDT)
Received: from [172.17.0.2] ([52.153.130.120])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac192c27cdsm24101843c88.10.2026.10.31.02.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 02:44:42 -0700 (PDT)
Message-ID: <6ae5b88a.b97a138d.f69dd.b2e8@mx.google.com>
Date: Sat, 31 Oct 2026 02:44:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5574508769284647142=="
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
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: SMP: Serialize root channel updates
In-Reply-To: <pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-1@gmail.com>
References: <pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5574508769284647142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1197650/

---Test result---

Test Summary:
CheckPatch                    PASS      2.45 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.90 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      31.20 seconds
CheckAllWarning               PASS      36.35 seconds
CheckSparse                   PASS      39.24 seconds
BuildKernel32                 PASS      31.90 seconds
CheckKernelLLVM               PASS      34.91 seconds
TestRunnerSetup               PASS      724.30 seconds
TestRunner_l2cap-tester       FAIL      10.55 seconds
TestRunner_iso-tester         PASS      10.79 seconds
TestRunner_bnep-tester        PASS      3.16 seconds
TestRunner_mgmt-tester        PASS      87.61 seconds
TestRunner_rfcomm-tester      PASS      11.94 seconds
TestRunner_sco-tester         PASS      5.60 seconds
TestRunner_ioctl-tester       PASS      4.63 seconds
TestRunner_mesh-tester        PASS      5.53 seconds
TestRunner_smp-tester         PASS      10.36 seconds
TestRunner_userchan-tester    PASS      3.21 seconds
TestRunner_6lowpan-tester     PASS      4.44 seconds
IncrementalBuild              PASS      35.53 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==37==ERROR: AddressSanitizer: heap-use-after-free on address 0x7c21733e33d0 at pc 0x559ed80ece8e bp 0x7ffed3ea2520 sp 0x7ffed3ea2510
READ of size 4 at 0x7c21733e33d0 thread T0
    #0 0x559ed80ece8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x559ed80edb75 in timeout_callback src/shared/mainloop.c:270
    #2 0x559ed80eeaa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x559ed80f13fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x559ed80f664b in tester_run src/shared/tester.c:1223
    #5 0x559ed802017d in main tools/l2cap-tester.c:3918
    #6 0x7fe17438b600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7fe17438b717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x559ed8026c84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7c21733e33d0 is located 0 bytes inside of 40-byte region [0x7c21733e33d0,0x7c21733e33f8)
freed by thread T0 here:
    #0 0x7fe174cc93ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x559ed80ed36a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7fe174cca60f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x559ed80d72d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1034

---
Regards,
Linux Bluetooth


--===============5574508769284647142==--
