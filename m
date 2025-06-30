Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9094B2905
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751257618; cv=none; b=ZEsG8oAQ0NBdKyNC1p2OV2cShdF4Wo6AY0WLp/8WgvvDdg012IcsXdTDYN2zznxhtvv0ZxHFygOKKHshe636RmVX9KJyR7CVtOsiX1fbAtXaozd+w1xocydvb2r+S1MdCCLXyASPW7gFYnsDoPEYLfPJ40EhkZJvyfBVOOQLmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751257618; c=relaxed/simple;
	bh=+HHCyNHVgLW1tpsSgV3CM6IYJTbwdlh5rfNVR3wAGk4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IMR7TAtJNfiyJZUAxuq9LYqmPweohL4V/eMaUmwIDOcsJ0ZX372LPbF2yKR5ShF4irL6uZBKgBte9YG+KN4Z7k+q9mpuqZ2L/bNmHWeqoj3W4uePj5Hkh8ZqPqQndF6NxH4NnAr7Sxy62QfNjgJLTelUoWBIQadpOyDIxe1rcQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6nijraS; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6nijraS"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a774209cf0so19882031cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Jun 2025 21:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751257615; x=1751862415; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dkzuWkR5+PZUZIPZ8jj3/+KHNdZgbfdwMBNnqa60Qgs=;
        b=K6nijraSW3M3KOOGj6GVYRGS+Otua5pHmdRj5WpKUO1UGgAwLaApiz59i9cIgtu3E9
         gLG3I/tcprs46TeSk40OaqY/95UoNyqZfv4R20noKb7vYYk2fiZYswtD2gR3wI1KXIOu
         MO2kEojUGPtXyD5c3aCHCug2z2K95bzRDYCUuhH55hLZQNA/+M1lUR7NBMr5h7PLGB+v
         QoJGd4XDuXZw2tEnrd2L5Wk/T9a9CRPc8dLdq20ENTpYQW5kHi+8DvMvgANUKfmfEU4I
         YGazpdGI/0gKmSUNkfMuS5OjaQRxvwE9CX1yqSiQRquL3gcY8M5dBrUAyEZgB4kh2bpf
         Urpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751257615; x=1751862415;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkzuWkR5+PZUZIPZ8jj3/+KHNdZgbfdwMBNnqa60Qgs=;
        b=CLYVSJb8GznBdbuGuckmUogedWH4SwB8Fve12jK6ROS5Cw8LMuZD7J4gTN3DSvi8sB
         RrrXCWGfzOm+7ZHKoh+rANYa5OCcGC5IEvDMfF/RMn3N4bXpNgad/umjjJlCpURcs/Sy
         3QY3MTNcujtJTjWooHb1A5FncGWRSXxbzCzEG8ULs5XOcmzVo1Lz1sesfKbxfGpkpBPJ
         Wy+Wtl+SedD/a5+B8fA3Bd18GVWKYbem9Th2QrU74/yELAAnsCcb5c41LLkE6jTjbVm6
         2c7M1/ekVeEswUAmka5yyTSHe/cNAlN3rn67dIu1eu5QfOBAzkQsn4rtP6FhI8HRusgY
         Ll7g==
X-Gm-Message-State: AOJu0Yy9dsV68NtnVpdhK3OedCZxHpBCZ64LLTL8TRf8L8hvCxX3qJBm
	Xl+YBwCOosmanK687g6boXCJVzivYqrCgDSbj+ilh4Bx15MACUFaB6sOGV0omw==
X-Gm-Gg: ASbGncsdDzExvhHTYzWDKNSkPuz8/8TLM9H7M642Lcl0nHGs3sYG21LC2s0vnpynvsr
	yMGKRgCdBm/pKMHzWwdnRHs7UftRLxI0/GVlDx6wTNmv+nFzZoQ+KDjnC1Rj1c+stYHKMNoNceN
	9pbGBXbl7NiS+V+yWF+4V82f7n3V7RR+XPw4glIpMbGU/KQb7v/WK9yqAI5BZXZvA/AdURpvTe/
	a08Hby1HSNVI1/aSblePUUlDqrYJut+gYgWr52uSWcKUM9cZTwxmTs7y55jRzz4Q89ArbfbqZ2R
	Qe5j7d5chu1x0KqVVMraliPwANMJSxw/LeXRtWUIRCdYXXljyoNJ7RvCcpjNuPShhBXh0Q==
X-Google-Smtp-Source: AGHT+IFKrfOPm358PJRuG5cEKQddt8gRz3Jl9avdy2yOxcvO5VuXOHE2CXT5C6phtA+nx8Rl1cP/SQ==
X-Received: by 2002:a05:622a:c2:b0:4a4:2e99:3a91 with SMTP id d75a77b69052e-4a7fca9928fmr222629641cf.11.1751257615176;
        Sun, 29 Jun 2025 21:26:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.223.133])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc13a311sm53567361cf.25.2025.06.29.21.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 21:26:54 -0700 (PDT)
Message-ID: <6862120e.050a0220.153050.d39c@mx.google.com>
Date: Sun, 29 Jun 2025 21:26:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8501331467449589646=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ipravdin.official@gmail.com
Subject: RE: Bluetooth: set bcsp to NULL after purging
In-Reply-To: <20250630032335.473671-1-ipravdin.official@gmail.com>
References: <20250630032335.473671-1-ipravdin.official@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8501331467449589646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=977142

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.10 seconds
CheckAllWarning               PASS      26.64 seconds
CheckSparse                   PASS      30.14 seconds
BuildKernel32                 PASS      23.91 seconds
TestRunnerSetup               PASS      468.10 seconds
TestRunner_l2cap-tester       PASS      27.10 seconds
TestRunner_iso-tester         PASS      37.95 seconds
TestRunner_bnep-tester        PASS      5.98 seconds
TestRunner_mgmt-tester        FAIL      131.50 seconds
TestRunner_rfcomm-tester      PASS      9.26 seconds
TestRunner_sco-tester         PASS      14.69 seconds
TestRunner_ioctl-tester       PASS      10.05 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.22 seconds
IncrementalBuild              PENDING   0.44 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.214 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.171 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.115 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8501331467449589646==--
