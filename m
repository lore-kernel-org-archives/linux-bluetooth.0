Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21FF45107D
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508244; cv=none; b=Kb+AmaYgKozmvic0aDiqTWeMbgBaqp6Pmd+IM5G7i9I3ALclo7N9NDKuSDgAE3Ib9QlL176756+GC+EidtREwjK9DJjhm7fTq3vw2Fh2984U+MIOle12hu4jgU1YF1Q4LJvsMepsabdybAcyT5g3LSVQxvfEHCmhZa5is7HST2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508244; c=relaxed/simple;
	bh=2v8+qDlF2tD76ped0ef2wnYLs/l6poqtjIQNjIvz+Ng=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qGbAGLw8//s66n7mOPeOrqHxtSIOStG6FRBmCOG1SvwXNzgo9utOIYWF3fmZ29MQrb8NrZ7oa8ZQluZbPrljRfQ/3HU0TRN0PJAwnDxMT1SytKuvjmjMrGUzdgmDmjY/uVuOgC+Zo3/4gK5KJHMKN2oKd8YcHr1F/FnHbzdVjGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUBJtU52; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUBJtU52"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so165867126d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780508238; x=1781113038; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V7H4fnrBr7PpA+e7bxTzI2iewd5hcaNPwNSx7kADtW4=;
        b=RUBJtU527DRSh/nbgivbFhDo7wv9ZMsxAyK254rfgFYhdZFl7Buz4a3AFVy1Oe8OfJ
         2IGsLTRcCAnXS/+GcuYGVs0du6AqkfSlEsTZ/uG7r06Ye/YpP3FqJ5IoBN7Dorv2OGNQ
         bUFVfNg7+ZQjNNaNlvv9yxEwo6fjTCfHQmzM9FXGiq42Jij9pa4mUX+Jl+3Z65xnHnY0
         U8VmygHHZBn5Yd4xmOwqWrrE0mJ252CbD+5wNFg709DNW4o/zcYK+A/qDv8nGeiG9bx5
         Yy3N9uqtC9Jt1aOhZ870OSrubtiKJvTZtXK/ndvE4W3hEojcMNOPAMtVLsDC90lLYIJs
         xvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780508238; x=1781113038;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7H4fnrBr7PpA+e7bxTzI2iewd5hcaNPwNSx7kADtW4=;
        b=Dv6zkBZyLaletV6Mo977V6EZu3zGp7fKQLWzG7CNQ5nXAAQHJ55k+WiIuoeXbwGhwR
         khsGXNowF/0GlAVOwGwzW0LmizrTkkEY+v4igKQDrr8SNQvVgx5zT7dcW+DTwGu/sPSF
         tEbpo4vjJ2yEakkZ4l/2BywoKp6dcTS/02j0vFFb7TgxM3IUQCdmVGAdT70Jn5OT4pQz
         U9+7S5dvbB7EQsyK+QYLQU0vB2G702zHCJUuoyWgKAFdmajryfJnqQ7QtkdEYvqdtn2q
         45AApI2d7aHKtKqUnaBs/4eM75tB39jsVgSQcWVMXzeBXjv+YQDl0W5KANc8Lhp52+6l
         7GPw==
X-Gm-Message-State: AOJu0YwTNpu5psTaafI35sFbf1N4c69d6LSMTCdbFbZMDqFPnd1ud7mk
	QShOwR7i9KGmxUsNH5ScYDgqlXSwzfXgFarWHVpYnmjrcC6J43XlQp5BnKrnrQ==
X-Gm-Gg: Acq92OGdjAY4ma30hH75tASCMUrdT1Bc5zFETpm6DwxoDt5jSYow4DRcpWSuCNBJ8t8
	zrgfwgB7fdfjYrMsC5cmEm6ckPlJlCE5FZZXE/XKk3PMdlreIDJy+o3DDDDY1PFH6QSXqZqi/+z
	GgU2qbrquj85bHqZGn7w0pnJlYnTy12oI0qrzBOm717YCzInRrMd1XfQPuWUxB2aN07YHIYmyoG
	phOFxgXaBT2BAAIb7uOFpIt0x159SHloIw3Nfam7D9Izn8RzXhMS7pmIOFY7MLby9QQW9gd3dyU
	TYUWBzhh1L2BOcZPJIRttcTO4yyrjBEHsRsHEKVmyg26AcSEa2rTbcspC0iapX0xZ/ntMHp+8Ux
	t47Ba4qS3QF2xIrtTkbVrU4r8tElM3Vskgkdt4FGGqya5IfmVdpCjOgf5QYJA/C03Tm2NxyQvLC
	9Ow9StJmz7DQZ+QWUo2H4GN3YiFw1xWS3Pbh8v8u+QYeEQX/FVCf9upg==
X-Received: by 2002:a05:6214:3d06:b0:8cc:cf1e:1fde with SMTP id 6a1803df08f44-8cecdca3c6amr73424946d6.26.1780508238351;
        Wed, 03 Jun 2026 10:37:18 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.239.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06f5eesm26187076d6.37.2026.06.03.10.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:37:18 -0700 (PDT)
Message-ID: <6a20664e.bdb7e8c4.37ad9f.7f6d@mx.google.com>
Date: Wed, 03 Jun 2026 10:37:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1266295336983058626=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, elver@google.com
Subject: RE: Bluetooth: L2CAP: Fix UAF in l2cap_chan_timeout
In-Reply-To: <20260603123111.2334409-1-elver@google.com>
References: <20260603123111.2334409-1-elver@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1266295336983058626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105291

---Test result---

Test Summary:
CheckPatch                    FAIL      0.97 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.11 seconds
CheckAllWarning               PASS      28.16 seconds
CheckSparse                   PASS      26.76 seconds
BuildKernel32                 PASS      24.42 seconds
TestRunnerSetup               PASS      524.47 seconds
TestRunner_l2cap-tester       PASS      58.55 seconds
IncrementalBuild              PASS      23.63 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: L2CAP: Fix UAF in l2cap_chan_timeout
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#98: 
| BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]

ERROR: Unrecognized email address: 'https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz'
#191: 
Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#191: 
Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz
Signed-off-by: Marco Elver <elver@google.com>

total: 1 errors, 2 warnings, 0 checks, 89 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14609364.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: L2CAP: Fix UAF in l2cap_chan_timeout

9: B1 Line exceeds max length (107>80): "| BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]"
10: B1 Line exceeds max length (125>80): "| BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]"
11: B1 Line exceeds max length (93>80): "| BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]"
12: B1 Line exceeds max length (84>80): "| BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318"
15: B1 Line exceeds max length (100>80): "| CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6-next-20260601-dirty #6 PREEMPT(full)"
16: B1 Line exceeds max length (95>80): "| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014"
21: B1 Line exceeds max length (91>80): "|  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]"
62: B1 Line exceeds max length (82>80): "|  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]"


https://github.com/bluez/bluetooth-next/pull/281

---
Regards,
Linux Bluetooth


--===============1266295336983058626==--
