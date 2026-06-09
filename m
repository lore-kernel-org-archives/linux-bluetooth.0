Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04613B102F
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040600; cv=none; b=pcELDB4r/J8EYBujIH4ovqMDUNxz23KCw3rWZSEytK2BwOHWSSiEM7aEioi5RS9XJJKDmsbC+BcrsZGZXZikwHXTPHDbnqbwIQJnbDOhWAXDiI0sqvmVHXUoBjJWyADSKHnMOgXXLMnW/CqNL7jU3xWEPhezDSnQlD9cCvA3ZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040600; c=relaxed/simple;
	bh=e5EVgOhFO4AY9MzTOVFiaUdgjF47aJ7BcKlTbdGEdHo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Dbd5scZ1WISjFhWGoEYQUHCQ3W1a2109VSsASxBheWqolchCjnRT/3FfB/TA6By4Yf+EEK7Oyjj/aRRW17HDmbPmZZ39reaEdj4zj7j3FRlLZ27RV8yOMHQzn9buwLOAxSyRitmYVAwawAXMjE2yMyZMFrIRffZUSrmd2uvaKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQr+9jz+; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQr+9jz+"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-13817614cd3so644086c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781040597; x=1781645397; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z4gZhUhCS3ozPItooThk8hAg5wXzgc0Ub3UAqjETMfA=;
        b=dQr+9jz+dyZGhfIy8FWznhuSWFabgfPWj7KrQrg+kG6eZ+gtdNVBryjamuVb0rsFMP
         7paa+UEe5z8+bC03gl2d9aWslPsddwnC9ydazqXITmZh+qtzN/V+oAt+2bjkkBf/UmOw
         sSzA4fexFfFHzxSb/UgsbqjrRuHweKiyLfftA89gw/8lou2sEjEl2pHRMhlvgY45B0JD
         2q9ItgNkXQId9Vjv0+YdEhT3HCXbDzEVHuKKTYhLK98DNn6QSRmNfJyY0ovywTaYgzF7
         ZHOnGRbIsXAhgtHH8DOyJ2TbVxbnMLhYQkpwt5i0Turoh/pnVSP+AfmX66J7JuacDDLI
         y4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781040597; x=1781645397;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4gZhUhCS3ozPItooThk8hAg5wXzgc0Ub3UAqjETMfA=;
        b=NVcTldg+QmtkuYBgl09VXK4miLkCaxbu2PqEthBEtS2TYIHomhiKhLo6Rvt6Io5F7l
         sFTDwN5Mq/AFGtqabBfEDsVyD9BfngpeMCfRuznxQgOQiGDgAihUTaR3Tu2WP6GsgEa4
         jrKI+IviQNm6XqPCb4q30mzrDEupn7F/o8t7UMYp8bdFpMc7IbRlkFGhpdfX7v/uicuu
         Mudblqs89ash+smOmIXjod2CWARm6hx8xENrWijlAqB3MZni/OMunkYyqT/sBo03FoQ5
         kDxJOz1ckE+8mEfr8j48LbdPqmXt3UVeh47iu3s3rfzg8WHT5h/KrTuv7rQPXbROeee6
         R0gg==
X-Gm-Message-State: AOJu0YxWXGxMaHfA2BLChYACR7D0AoNAU0QFZ/DJlg8cgUjT5gela0Me
	hgxGOnzsn3nZzVEHzWgAUey3sgTRHToMfkeRwTGR7chYMWKu+aShV1j/Uy65Yw==
X-Gm-Gg: Acq92OFSfE08VaqtgmgELjDHyOjzMqmYSPg6tF5z5idNduB7EmADZ+kVez7evsS5hGz
	IS5PbqOzGwMUqmIwleNYNx1jZNc+K4EhQ4YXkiXaXY67L3gi5f751/gx97nbRPRcZO4ifc2L0xp
	NpB74FN3DnGNOXG1l6V0l6c8WqrkC6h7KXbfbmts7ompOZiCUmrvtY+T4Z2yCgwarnut8B1auRA
	0thNs8x2xkDckYqRcIt+zqgXS9K0DGOSTM7WypJHjK00bclLjR05jo7daWC3T0nNFeUCFw1hpLv
	HCmmXKPxI5aaoNHSaEPsUTr5TSay2bBUT5xV9xv34lVuAp14pftfXyg8o4UkKeq6uhpADCW3/L0
	TytD4aHefd2FG42eNRCWfJwVJFklBVvuKk+fm5p7qSU7WenoPaSKpZzO/DZdR703Ypvsvx+yMoo
	ABbWBuafwQpwfc4jy83kpKyho9nUZbLeKEnV5jDsc=
X-Received: by 2002:a05:7022:45a6:b0:12d:b66f:35d7 with SMTP id a92af1059eb24-138066d4eb2mr12220428c88.10.1781040596915;
        Tue, 09 Jun 2026 14:29:56 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.51.71])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f548ade9sm15961516c88.2.2026.06.09.14.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:29:55 -0700 (PDT)
Message-ID: <6a2885d3.8e75e0cb.220d5c.ccd2@mx.google.com>
Date: Tue, 09 Jun 2026 14:29:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3051787950661161261=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref
In-Reply-To: <20260609193222.192456-1-luiz.dentz@gmail.com>
References: <20260609193222.192456-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3051787950661161261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108797

---Test result---

Test Summary:
CheckPatch                    FAIL      0.71 seconds
VerifyFixes                   PASS      0.58 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      19.66 seconds
CheckAllWarning               PASS      22.22 seconds
CheckSparse                   PASS      22.50 seconds
BuildKernel32                 PASS      20.00 seconds
TestRunnerSetup               PASS      420.55 seconds
TestRunner_l2cap-tester       PASS      50.22 seconds
IncrementalBuild              PASS      18.98 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#103: 
| BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]

ERROR: Unrecognized email address: 'https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz'
#181: 
Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#181: 
Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz
Signed-off-by: Marco Elver <elver@google.com>

total: 1 errors, 2 warnings, 0 checks, 126 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14620630.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref

10: B1 Line exceeds max length (107>80): "| BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]"
11: B1 Line exceeds max length (125>80): "| BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]"
12: B1 Line exceeds max length (93>80): "| BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]"
13: B1 Line exceeds max length (84>80): "| BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318"
16: B1 Line exceeds max length (100>80): "| CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6-next-20260601-dirty #6 PREEMPT(full)"
17: B1 Line exceeds max length (95>80): "| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014"
22: B1 Line exceeds max length (91>80): "|  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]"


https://github.com/bluez/bluetooth-next/pull/300

---
Regards,
Linux Bluetooth


--===============3051787950661161261==--
