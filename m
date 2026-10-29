Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285458;
	b=qaRxJk2GWklg6Z2zoxSJDUixRE3VYMGcnkGl+sSLSzzIyy/KTySkPxyYPsIxbK3412MN
	 MkGp6WA/zqZNRZRPIuCIKnAqdMxSsC9b0QDsq+7KZEP1z3m42pYAtgLplMt3xpgEY0oO9
	 +770ntBeeGuEIvKt/NHQDBNE5o9JvBYzoJx3Ryz7u3ZAwEhfhJUq7U3eeVFmrpIdZfUP8
	 aH4tK2d3dK9ldjIM9ArvBI/No3IC0jQW5PaJWUD42V1kjSr5aDW8OqK4uX4+3aVaHABfW
	 BslK/o/VwQYz31rTTem5/U1qeynfp5pqnuXxnVTT5P/z60NPv4iBLhknfisWd2AxdYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Zp5ZZGTHGrtHzuB/Mjh6lWICgHwL8AEMzSc6GHCpcmQ=;
	b=Q+Gm1OlqmKqpvGvfVwZcvU9g+UXUZmdfL7TcxFg6g9E1+H4PIMq1oBcmVMm/+ErRRPGC
	 i2/9Yf/C7Y/yA8ibM7eDH6+iiF/+30MZAfexIdwGCUtlwz/w/q5DTDn3a4o2f0PIR0CYe
	 jYiWkffvwjnyDWVingdSM2t/er/uNdu5uzp/xgj+92KqfeIxXv6Qa007PMzfSy6XeUjF/
	 L6keXZh2XDN9q4LIEOLyr5QBrp56+Mn1KfadTxXyohwPhZPu2KQITis/k34qEtBFYCdJd
	 oA2ZxiFWfYCWFnK4ONgCd0iIyvUY6PervgANqaHRPZc7T9Emyu7xVxdKF0ar8iUoOSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="f/Lm/9eU";
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C93606A31F
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 14:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0C93606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f/Lm/9eU
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c5e31bea9so28830346d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 07:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793285457; x=1793890257; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zp5ZZGTHGrtHzuB/Mjh6lWICgHwL8AEMzSc6GHCpcmQ=;
        b=f/Lm/9eUzXy4dWG6IWT0g8ELGr6LsB7WzJSOfttLuvfcUKAgn1Hxr2wgePOKnfMqW5
         weG6EmKVepYieTg21gECnm4lJulTpzPTscCMfLkTpCFhnTLvdxDP6MTy9DmjZWhn7Pz6
         KP4A9jIBsC5ok/F3hpnSmvTvbfN6LZgR22u/rifDOIXPUl+wcUCcS64uhJbZ/aw/hNXS
         ZHFv35ayn/+ZkHTYHri9E1XV4BV7nmsympSRQGFCDf/ohn86QlIOakD8HBAFo4jbeaoA
         acIrRkbtUM5ZBv4QwcIOtiq0uztMyuFheIbe4WdaDXQ0pkxdUM4rg/1WK/UOGAgcBvUZ
         s3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285457; x=1793890257;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zp5ZZGTHGrtHzuB/Mjh6lWICgHwL8AEMzSc6GHCpcmQ=;
        b=wlWgEAcrjF8J40wzg3EMHmIoDHEXDYD8H5xedk48kAP3hu63Og6S69Cm/jPSxog9Xv
         GkZXlsX6VZ0Ex9X8Aj+zc/Y2P/zMRcHH3XY6RCO99wvcXkjj2OIDo4FKNgnaiyBazmDW
         B7T4coBqcrNLpYBFGf35S/79cipNflvvLEsLym7QEI4SD2SKRiS8TKJ+qSn+TOWYTxVt
         H40vsT1JMu7q25eTzF4sD1tUrGUjQ2eCCvUE+h0LWWvDyNSB27G3z1KdNLYNDJ5SG7UM
         zKIMQV60fB7lS8ulLYTcZqJfWrZlp1POhSggXKvVY+qATNuuEjLGU4omR0TGYX7T86LD
         wzcQ==
X-Gm-Message-State: AFq9FYITtK4BpaXOoctLdIYLsTvLIN/SjZIlHlpNZJT5hrF1zmzrrsvW
	wqW2pL2KnNTWfiOlTVhI1UolFIbsPAbqtPEkXZUlpp/bYqlKiHL3Qavfr+ALmA==
X-Gm-Gg: AYBFou0pOi0ZOiTtkhMZHXnYg7HsIbqeGm3chOeIgKdLdRlvHeoOm2AI/oFYA5NJJyq
	7qJ5FE99eul29XVhb4HxTbyuxrlDHcYatTse8hcXzr0/DUekmCQ6ByXMFdkt2wI9NUUcoWEM2Uj
	R7k/pOKgFQKMTMJ/RfNrskD0NKOXjOh7LsfqO0Dpzf5EeXuhdRYYrBQFPaJKdOuDc8W6uS0LC2K
	SQDRC7Yf7ysUogHFmM8wOVSkbJ6y9W6gjQT0OZlsmKONdr3FHveFdCMvv8Jb0/PEEJBfRwVVX5U
	tp0XuUSqKsYmTyc3kBpzFHM9+/oXL4vj3mGGrD7YVm6rr+uu6vL9vSryhegHpqOmVHRKq8UtyLO
	NewUoFAecaK6MTwp0oZfj28xMvtR7np/DLi4oqJ7wjCOD+UlB56RVmxSCVNxVdfFWcicxnoIdB9
	4irOX5WraeZXwWNIaGquP8veNPj0nZrAe7v8pbHc+ssRGyoiOF1NvSm2yg7XP0lRZvRhFV/lCzX
	Z6MGKKxF3DSjuv1b+QSVzWVVbBHGh+am8g7Ol3gcEUc+uxf51LcibRmMejvHiTPhA==
X-Received: by 2002:a05:620a:4010:b0:93f:24d4:ecf0 with SMTP id af79cd13be357-94408d81278mr822505685a.47.1793285456845;
        Thu, 29 Oct 2026 07:50:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.212.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0669a0fsm1545836185a.8.2026.10.29.07.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:50:56 -0700 (PDT)
Message-ID: <6ae35d50.ba263b4e.364d69.34b0@mx.google.com>
Date: Thu, 29 Oct 2026 07:50:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4479001285692957280=="
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
Subject: RE: Bluetooth: Keep borrowed keys inside RCU sections
In-Reply-To: <pm-bluetooth-objects-candidate-0122-v8-952ad9eb0ef59367ba6a-1@gmail.com>
References: <pm-bluetooth-objects-candidate-0122-v8-952ad9eb0ef59367ba6a-1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4479001285692957280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1196273/

---Test result---

Test Summary:
CheckPatch                    FAIL      5.59 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      1.37 seconds
SubjectPrefix                 PASS      0.48 seconds
BuildKernel                   PASS      32.31 seconds
CheckAllWarning               PASS      36.86 seconds
CheckSparse                   PASS      40.06 seconds
BuildKernel32                 PASS      32.70 seconds
CheckKernelLLVM               PASS      37.40 seconds
TestRunnerSetup               PASS      759.22 seconds
TestRunner_l2cap-tester       PASS      12.84 seconds
TestRunner_iso-tester         PASS      13.00 seconds
TestRunner_bnep-tester        PASS      3.22 seconds
TestRunner_mgmt-tester        PASS      88.44 seconds
TestRunner_rfcomm-tester      PASS      4.58 seconds
TestRunner_sco-tester         PASS      5.73 seconds
TestRunner_ioctl-tester       PASS      4.74 seconds
TestRunner_mesh-tester        PASS      5.61 seconds
TestRunner_smp-tester         PASS      4.43 seconds
TestRunner_userchan-tester    PASS      3.28 seconds
TestRunner_6lowpan-tester     PASS      4.47 seconds
IncrementalBuild              PASS      40.49 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/4] Bluetooth: hci_core: Keep link-key filtering inside RCU
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#289: 
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10b5f8

total: 0 errors, 1 warnings, 0 checks, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14924412.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[2/4] Bluetooth: SMP: Protect link keys during LTK derivation
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#272: 
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10618e

total: 0 errors, 1 warnings, 0 checks, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14924414.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[3/4] Bluetooth: SMP: Protect LTK encryption with RCU
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#171: 
    kfence-#128: 0x00000000d45af9b0-0x0000000053c1365e, size=72, cache=kmalloc-96

total: 0 errors, 1 warnings, 0 checks, 33 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14924413.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[4/4] Bluetooth: hci_sync: Copy the resolving-list IRK under RCU
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#248: 
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10d214

total: 0 errors, 1 warnings, 0 checks, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14924415.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/4] Bluetooth: hci_core: Keep link-key filtering inside RCU

44: B1 Line exceeds max length (107>80): "    CPU: 1 UID: 0 PID: 502 Comm: kworker/u17:0 Not tainted 7.2.0-rc6-pmb-bt-functional-v1+ #5 PREEMPT(lazy)"
45: B1 Line exceeds max length (119>80): "    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014"
[2/4] Bluetooth: SMP: Protect link keys during LTK derivation

39: B1 Line exceeds max length (107>80): "    CPU: 0 UID: 0 PID: 500 Comm: kworker/u17:0 Not tainted 7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy)"
40: B1 Line exceeds max length (119>80): "    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014"
[3/4] Bluetooth: SMP: Protect LTK encryption with RCU

48: B1 Line exceeds max length (81>80): "    kfence-#128: 0x00000000d45af9b0-0x0000000053c1365e, size=72, cache=kmalloc-96"
80: B1 Line exceeds max length (109>80): "    CPU: 2 UID: 0 PID: 534 Comm: l2cap-ltk-actor Not tainted 7.2.0-rc6-pmb-bt-functional-v1+ #5 PREEMPT(lazy)"
81: B1 Line exceeds max length (119>80): "    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014"
[4/4] Bluetooth: hci_sync: Copy the resolving-list IRK under RCU

41: B1 Line exceeds max length (107>80): "    CPU: 2 UID: 0 PID: 504 Comm: kworker/u17:0 Not tainted 7.2.0-rc6-pmb-bt-functional-v1+ #2 PREEMPT(lazy)"
42: B1 Line exceeds max length (119>80): "    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014"


https://github.com/bluez/bluetooth-next/pull/1023

---
Regards,
Linux Bluetooth


--===============4479001285692957280==--
