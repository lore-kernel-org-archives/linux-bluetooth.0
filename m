Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254AE4409
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 04:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745901322; cv=none; b=Ecl3Ictm1d923aVYL8GV7ZeYP9hlyZJvnaeoGVYuzcZDGZx1akm5QgtDdlGclzNN8yIiHekpXJih3SFdrDI//rSKDnx82D/NZ/GlLBLVJYHTz6oN3AJedyZgpB+fxt3yLXJccE4zghXH+Wx4A7i1XqovDHD88UaDlm818zniodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745901322; c=relaxed/simple;
	bh=tYBjS7jsw9OJt0vjvXpU5nZnN5khl4+tTqJmc4t6Jzs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=go5JeXBX0In5+pxNnZAnj+xA+cAu0KhCY6EHABVygVa61qi8BGHQS4CxQ7VR2/v1NVB9blTyj98LwCEkhmLpDXuM15fPF/d+dlPWXdsV8/GXf1OpKUrg4jN9qMUikA0z88wOsL/UWjeoYTIAPf7yyU7eXSvjsbgBM3IEszI3Hvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiEuRPRN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiEuRPRN"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7369ce5d323so4593896b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 21:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745901320; x=1746506120; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U1pgJF6fu15F60Nivuzaq1dvPUIwuAB1Mt7ciPRfR9E=;
        b=FiEuRPRNYikaWh99q+ZtBhXzxNsEwomfmwKPt8Y/xO+PtPdwE2gYJ0dlv/jdHv6mHc
         jI78gCcZ0FVW9CKG5JTT0dslC7YWuknHFJFTYSooIzWA5hpB6QyuEnb6bzzWQoGw7DVa
         62YtXas86/LHNzAponuTom3CK+LSIiSUJYG7fl9n0efVKp17Gq+3msLPCMGYDoTJIKUv
         MNIcOoUxdA9hVGHCUm3zDnwmVqNokv2xsIfGQfofn4rQHvkDYFopIUgzKmREmmRI0I0N
         GhEA6gFX+Acprf/8Zy+nqOSukNS0E0T2qI2pfClX2kGFCgDhJQnN0MmMd4uk8ZQla8Dd
         ovDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745901320; x=1746506120;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1pgJF6fu15F60Nivuzaq1dvPUIwuAB1Mt7ciPRfR9E=;
        b=TsSMVoyeHpCaZAsMmLGpv4UPLQwpMizeO5/TTjPQ/Sqr7GQeRrWFx/UMIlmj+twJ7o
         zUc3Ske14wmV9oukaQycXtUHzbxkxKyRjugs6dhuAtE14JnYpfz1XVePWNxoHDpI7IIy
         zzfglI1NOny+jfN7K1HipHTiI3rKgKAUfat7yP/7OjF/L3FloRWITFpifUxGTEUTjKjG
         PWVC6PTWfIXLfJbhPC5g0chcewbGDpvtbIFX15mDrGs3wND2r/ZhlIgDugBcVXptSe/J
         xYaTukB/b06XtPwWzWhIPJ0BjHIiL3f/sbvJDsASW3MdtGz53/rPckBG5w5H0SAq+wNq
         x1JQ==
X-Gm-Message-State: AOJu0YybKMOYZ6gjAbVunvETvMKvm2GXoT4h40hH4XkVLWHAJ6oqN/Oc
	WvAS93jg8PAVv+AG3YpKY99wq1DEgRrRXTm/Hyav9zegxQbg/liDlvN9+Q==
X-Gm-Gg: ASbGnct3uj8sU2Npl8APGnVGvkgZg6SsUAi9SGdOn3R4erFsDGVNoRyrmtKu7y/qOhf
	JHS6UfgBeh+Zg2DNaa7at51gyjJnF3aT0f8AgY7fqZAtxcr5hzw+WQrpHhbJsgmF6M6hoaZl1rp
	MgrUmYmCxMSrwaImGlrTiiDUb7wKLo+RVyn0ZnQiUQuqXaomJQ/TPnz0R/mrzXDqbOWdVtBFsAY
	4rHsNuO1KycM5AjH+188jkZh7zmmfVoohY6DLbrPs/dgEkYYGWKbDfQpaKOryGg1ENBINh2rGC0
	BOH9H9/19ukwVVWWZduDJDMeI0GbjhAELWuDNbEuTrIv+n0=
X-Google-Smtp-Source: AGHT+IHeXX0SfoS1MPoT+Nw8T0xigSDU13PtAsxzzteID/sEriZ2DAhzPZZSNDYCg8gXrtVoSItJqQ==
X-Received: by 2002:a05:6a20:d70f:b0:1f5:60fb:8d9 with SMTP id adf61e73a8af0-2093e1236f3mr2863807637.33.1745901320070;
        Mon, 28 Apr 2025 21:35:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.43.247.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15fa80fb9fsm8045140a12.57.2025.04.28.21.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 21:35:19 -0700 (PDT)
Message-ID: <68105707.630a0220.1ee2d8.2c02@mx.google.com>
Date: Mon, 28 Apr 2025 21:35:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0062856146544117045=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: iso: add BT_ISO_TS optional to enable ISO timestamp
In-Reply-To: <20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com>
References: <20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0062856146544117045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957927

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 FAIL      0.41 seconds
BuildKernel                   PASS      24.31 seconds
CheckAllWarning               PASS      26.61 seconds
CheckSparse                   WARNING   30.08 seconds
BuildKernel32                 PASS      24.09 seconds
TestRunnerSetup               PASS      456.46 seconds
TestRunner_l2cap-tester       PASS      22.11 seconds
TestRunner_iso-tester         FAIL      35.46 seconds
TestRunner_bnep-tester        PASS      4.65 seconds
TestRunner_mgmt-tester        PASS      118.65 seconds
TestRunner_rfcomm-tester      PASS      7.84 seconds
TestRunner_sco-tester         PASS      12.86 seconds
TestRunner_ioctl-tester       PASS      8.19 seconds
TestRunner_mesh-tester        FAIL      6.07 seconds
TestRunner_smp-tester         PASS      7.27 seconds
TestRunner_userchan-tester    PASS      4.90 seconds
IncrementalBuild              PENDING   0.55 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/iso.c:2330:42: warning: restricted __le16 degrades to integer
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 127, Passed: 124 (97.6%), Failed: 2, Not Run: 1

Failed Test Cases
ISO Send - TX Timestamping                           Failed       0.192 seconds
ISO Send - TX CMSG Timestamping                      Failed       0.185 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 36 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.120 seconds
Mesh - Send cancel - 2                               Failed       0.141 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0062856146544117045==--
