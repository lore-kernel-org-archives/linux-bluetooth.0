Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7F3033DE
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691598; cv=none; b=o4B+21N7ZRZmWGXO66ScLFNQwiOPxHJfoMiTo1j76PXBHQ+OBHcAI077h6a9axYj9f/Y+h+BsKYdFQSLHeHnLg+LcPbNWwhl90hXWhzswdVsk/U6mXLLsgzv36dXHSekaaZIzttHR43tlzin2mm25QepgLKKkDDXJvVqXzhRnLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691598; c=relaxed/simple;
	bh=D2K2ZxT6+QxgYdHgiosE4S26JC10493uB6v4XMF3q8A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DrVB7pNErcAK6/tvJGYBqwhqxu4xenOiLMXjeAFYgLRN3Y/cconOlKnDmmOwGHhQSH/sY6YvWSpGBsWgnltb7hEZWR2Ps/poyr4iSwKms8nnypHTld8a07bQZO+rXEKet7R3FmomXm6xmA0vBZc9/9ABW8kClR07OsM33ta3//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ1e7e4g; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ1e7e4g"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9156b74006aso174626085a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2026 13:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780691596; x=1781296396; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1VK45th8eTQwQy3vkaHUsa7lZgXj9scEEjJUkEn9zmg=;
        b=iQ1e7e4gHPxupQ261r2ptUnPPd45kq5Oi6TjUDETnqpKN2O2HZdfnZaR3dSSXnQxYy
         2+d8t1lfA11P0fAXPUXuwdH7wULbUuGKDIulY70u959O3igTag/9/49aMyaxBIif+qba
         imhco+wgb14x+OxHaTAPTgyJ28EkWP4iIma/h7goslStR4dYgp35ouakudD3mMEJNMCC
         fYnLszI/xtOZ2sk6s97W0dY3qNq0YpH+jC3kPUY7qgVJblkzfs00/s0NAmoKvRnHIz6o
         2w3gmPxPTWPQNOZy7y5EAabARIGBQMtbMTYlfl4FMTeRwFA9bymDK32IF2kmEzQ4Lst5
         iLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780691596; x=1781296396;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VK45th8eTQwQy3vkaHUsa7lZgXj9scEEjJUkEn9zmg=;
        b=W8ybiidJ94N4YvPGBQBA7OVY9HBZ9rGieCP7xy3u3QZmNz0m7OBQg9OHwU1zC4yohv
         q4oPeD5B0MtWlp4fT6bqOielecNJ2b//vIHlLvkY8DZEvRl7wfgJI3jwxgtkZzSXwF6F
         kZ5jMdBF+0vdl52yzbzRYjnXYnUCeXyqXYu/29hjmKGKWk0IbwmryfWH8bk048LXmVOH
         X0+ylHgh9btIRYkaQZFr9BYYjr5kDB0CENUaPmY0WNwllhWA/A4kfxR5gQGcm+pL7hF6
         fiQjOQ98lK0FAz2h0E6F+QRssjmWTUvAMx3C5bVCnqqXtDh5kzmUKONEgZylbQZ9qHNZ
         2N5w==
X-Gm-Message-State: AOJu0YzsKyXpcEjFWCgIPKXDSG9Tyfr7tukGQ2GfIGTXKBNOVwW40Vjh
	Kp5MHa4VVrZlUZEoZv3v6wJu1QsHvJr2cP5J+hv3kfLLe6BqCKw8yMQrSX9PxQ==
X-Gm-Gg: Acq92OFCef4WVQuOlQrw1cz+1QMEcpIVsOAhbVqDzqvH+A4i6HFPljyMTDBkJaYZ0rC
	knKIm7L3FTn2KzH6DjIio0p/y1/2blw79GeurrBNQ2jWFOJLieLomQ6paROC6OiTgpsAQCD8osn
	M7pfLlP0gYOf/d3rFDyZVeP2/y/W4lYcg3i1ivnWetUttWmXxINEnMsMzhJ31xc/pj0MVsd9w3F
	za3zUIDybi3uRpTxLmZFL73gtwAVwiWu4iP0nHFop8yRNndIVRv2Avg6/b271ec1cdDoYwA4D9/
	FteMa1D266K2M+/m3FTQjOxXN2zs7rn/NbhNOy0VKiEaNTYz5V3RiJjxhT+vmsY3K1laF6l7BTL
	6i+LC+ho0WUGDO7biDYTFYdgBFmDTNshL7GLTC6e1mL3zhrqdJD71bj8Eqpkh/F8KkdKPupMovQ
	VWHhDE2Cmj+61hbtL7h0KkdjpJ0L8ePcNsNYiXgJk=
X-Received: by 2002:a05:620a:6cc7:b0:915:8d82:b149 with SMTP id af79cd13be357-915a9ccb099mr955046185a.27.1780691595643;
        Fri, 05 Jun 2026 13:33:15 -0700 (PDT)
Received: from [172.17.0.2] ([51.8.121.165])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37cae4sm988560385a.29.2026.06.05.13.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:33:15 -0700 (PDT)
Message-ID: <6a23328b.42730a79.2a321b.379b@mx.google.com>
Date: Fri, 05 Jun 2026 13:33:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0280291637988939360=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, elver@google.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref
In-Reply-To: <20260605142351.2306664-1-elver@google.com>
References: <20260605142351.2306664-1-elver@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0280291637988939360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1106678

---Test result---

Test Summary:
CheckPatch                    FAIL      0.98 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.50 seconds
CheckAllWarning               PASS      28.24 seconds
CheckSparse                   PASS      26.60 seconds
BuildKernel32                 PASS      24.91 seconds
TestRunnerSetup               PASS      524.91 seconds
TestRunner_l2cap-tester       PASS      58.70 seconds
IncrementalBuild              PASS      23.81 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#98: 
| BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]

ERROR: Unrecognized email address: 'https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz'
#218: 
Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#218: 
Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz
Signed-off-by: Marco Elver <elver@google.com>

total: 1 errors, 2 warnings, 0 checks, 60 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14613573.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref

8: B1 Line exceeds max length (107>80): "| BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]"
9: B1 Line exceeds max length (125>80): "| BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]"
10: B1 Line exceeds max length (93>80): "| BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]"
11: B1 Line exceeds max length (84>80): "| BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318"
14: B1 Line exceeds max length (100>80): "| CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6-next-20260601-dirty #6 PREEMPT(full)"
15: B1 Line exceeds max length (95>80): "| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014"
20: B1 Line exceeds max length (91>80): "|  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]"


https://github.com/bluez/bluetooth-next/pull/289

---
Regards,
Linux Bluetooth


--===============0280291637988939360==--
