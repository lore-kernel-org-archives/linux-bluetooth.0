Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353742FE584
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335511; cv=none; b=DZseBR4AIosAC0vD6lojD6GLMLloGGXzaBgo7TapsxP5vCc13TPi4N5ODSrReG4eoWdy9bscg8iadNOLUoarEtqiNmiiJClSwE1SkNSYI20+zUl8FwQ7xKL2CKbjcEvnidfOs/SCbI+f9X+e32HvyMWQsLFxDlXS+FRh2Ahs4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335511; c=relaxed/simple;
	bh=iopb/2HE6rxnbJhUiygi9wiPs+tTGT3uUrtacSGas8M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D3zXOsb2ktVNgHCUWRb+xzLWyRWpppI1EacfK9dtE4vEJZbEaAlK1shMvcgl8DU+aigD5gdH6I/grPZ+/zYDtNleV3IRz1x/kqRu9H0Tg/pTfqgfapuLwTX/6AszmQANCro+rwmGLrTKUzsCsmGP/VJYflZdcnPGP9v6p9Qw2qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRDEKLBe; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRDEKLBe"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b21fc25ae1so100428785a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 01:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762335509; x=1762940309; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F3JF66Dwbv6Le0KOGeNOb3p2YGxaJucy1HI7+4jr1/k=;
        b=GRDEKLBeB4xf3KpR4RF1l/pEikDSypPGBaGcOCWITIp1dHgJIyoxf9QCA7yNtob5Wi
         y8e64YB7rnxr34LhxJDr68wlY9smWNX8Ah6qgBgysPXz9k25jRbIxFunTe5hc+RAFhqB
         CZCzbKyxYmhpmFAyHVTuTcmbeGNO6+qlp6Snc1xRBFhU/x0dxiG+54jtCIh8RPez5NaV
         P6c5qh46BZG7Sz709wWvdYzzQTmXZpzOi4PJGlSTl54PokwDMOYo+TlXrEFLwdZ/c5y6
         wFDq4AXDCXV+8rm95q1+b6ilLLELnYEvyN6bigl8qIjtbGgrF2IymE5lGPtZrTaojcdc
         Rvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762335509; x=1762940309;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3JF66Dwbv6Le0KOGeNOb3p2YGxaJucy1HI7+4jr1/k=;
        b=BlbxAuc/N0Ww3J86RS2UWFU4GM8mpgXXHBA5s81wLnBPiseDOxwCMDKAaWaRPbHn3z
         /a2gXeLdGxFZ1Zr35mvdJ1RGnUlP2Yq8dakVYEjmu9VbS4NK54GgnaUKEOU6IFKhUSLx
         u3j4nnM3hkt8KUWiIMAAemlbLgUYCBya1qEb4EGIJ6HuQW0LA5M5YoPydT6zkKhvA/c8
         R/kJYH8k7ateOSpWovgy5H/eHVN9dTPr6x/lhArhUTpCxDgZQsj50SpcS7C+SNcLH3+v
         B3bGw5yV66hCcKwTosdgoR3g5ESQB+LtPlCv3flk+oLUzXcr+xue8BRXIXb2tR/aHyZG
         Ulvg==
X-Gm-Message-State: AOJu0YzEsETpCs7+lG+uYQ7+BbkVyJU836Vf1yaS7D4jyCv7E91R53hu
	fnlo0oGRCNO4vIR/9uEtMqV2LerLpVPMOx3/GoZkE+iDl2eiJDZ+TasD81vdUg==
X-Gm-Gg: ASbGncsyStqyL/C7QcIruuCbiXUeVMDV6fhtXw6t8rX/R5T2CkJpNIzHrGfph2WPUBW
	v5jP6+KpJiETFhJ1rFJ3fWKLU6O0BGVB53zBVQJawkXyke/S09TdZYOIPpPyIK61NegE5oJcsWP
	UUWzIMzINHm/D+pF0y3GKaCfp7DbASlkh8D3+D1t0UvRI5v0c+0Tg4lKm06A9jvwyxRd1Xl+ngf
	TCGUwjZTA8avwKVu773G4bqlIUFYvWi64b9qpIUqiwSyoYaevEgtj18SEcocKYIE5cC9gcShmPV
	9t5WC5uGIRxA/jz8eDTzDnGOER8HviJ7sQxFZPkeiGA5UEB2KN+DaK86CgHn9CA4oNLeFZMXQtk
	dsuyISLplhtE/dm4IJqaippCOK3Hl5OU9daV6Jb8O/mSvqIR8vfTeAbQPb/eDcg/NIkqJHVsGGU
	rBhNI/Yw==
X-Google-Smtp-Source: AGHT+IGWMU0ipKL8GLjDSvfpA3j/sm3h1rYjQTh8RNl5YRd/y+82H0J7SNEvGCaCGqcf7sOt4wDgfw==
X-Received: by 2002:a05:620a:4709:b0:8a9:b469:efc1 with SMTP id af79cd13be357-8b22083d951mr321616085a.24.1762335508580;
        Wed, 05 Nov 2025 01:38:28 -0800 (PST)
Received: from [172.17.0.2] ([48.214.53.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f548714fsm365787785a.23.2025.11.05.01.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:38:28 -0800 (PST)
Message-ID: <690b1b14.050a0220.26ae85.a6bb@mx.google.com>
Date: Wed, 05 Nov 2025 01:38:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0218071663665065791=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: Bluetooth: iso: Fix UAF on iso_sock_disconn
In-Reply-To: <20251105-kernel_panic-v1-1-88637054c6b9@amlogic.com>
References: <20251105-kernel_panic-v1-1-88637054c6b9@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0218071663665065791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1019783

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.47 seconds
CheckAllWarning               PASS      27.35 seconds
CheckSparse                   PASS      30.92 seconds
BuildKernel32                 PASS      24.80 seconds
TestRunnerSetup               PASS      496.53 seconds
TestRunner_l2cap-tester       PASS      23.75 seconds
TestRunner_iso-tester         PASS      78.33 seconds
TestRunner_bnep-tester        PASS      6.13 seconds
TestRunner_mgmt-tester        FAIL      120.19 seconds
TestRunner_rfcomm-tester      PASS      9.03 seconds
TestRunner_sco-tester         PASS      14.23 seconds
TestRunner_ioctl-tester       PASS      9.81 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.34 seconds
TestRunner_userchan-tester    PASS      6.43 seconds
IncrementalBuild              PENDING   1.05 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.135 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0218071663665065791==--
