Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F9171A7
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887152; cv=none; b=Co+YYEA27D9tSx21/oKbdraajbt/6wLn/LDXhgkv0HsASf0d4qDRdAWqzYFWVrxN7lcRxgN7+9VfHKcjnqPDRHlB51DnJS/eqHKUSOBCxnXzMMZmy0lE5N3mJPzxkJfVJaP2UfO/wkAWLFgGwMHXIHIWxQvfLUhMdw9d2MWr+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887152; c=relaxed/simple;
	bh=IvMftt8HLc6twI3fJohocnnNYVcwZHOsjjzTs4gkU9Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nMrRC5hoW0SzG6XlT3iDLUvw70KTv0qnb/ECPtxSwq/9RJTNiNworlQLz2kHPUsclm1r4BhvkwC2ubPcHIzB6HtPSD/+Ypc5SGQ2jBUl7PHRVo3jpZ8C/FSanib6KTJVc4UcGlVYL0RpHxxcrRz83RVJXEyQmNH3x3neM/tH9oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XURGxwHy; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XURGxwHy"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0a159ded2so152263585a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 05:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739887150; x=1740491950; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7fFjZZl0GyRHfDRDNy0yuuB+z5dPGudkieu0WUlF8CE=;
        b=XURGxwHyEJfust0LTqbRspqO3EitnSip3fsQiKRIKjpn82a/heMKDXD62KLJFcQYLF
         D865dU1baUJJxm1uV0qbn9JmPPmYrH3p/mQe/hFBv0iYC7uOgQ3jzEpUtQwzi0OdrgPg
         2gvY907FTVRiSvrTh8fACfFdgwiwYwiwsrMZT2EOBlDh8lc2jJBunohlT2e/aUvFBNr9
         bO+FRa8FYrCb+cMy3VI5+qqoOfi0s7ucO02/QwJReZD5vDQwah7QHv+q2gC2ci/O5p1b
         56MuJkkq3ZzIfnFtbaoMbMwYCStj7ugfPZaVsMDJsdKwlVM5L60qRFqzMo92f3klK1za
         szoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887150; x=1740491950;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fFjZZl0GyRHfDRDNy0yuuB+z5dPGudkieu0WUlF8CE=;
        b=sTHUqdhBXh1+G8tx4vObIBv4C3Vdamlc/1fS7hX2BFy486Nyqke1sdGL3SRrcMn7SE
         1yTZeQl+hJDFwyqceH3dVPkasjfndiBMwAalmQMyK29b7ySbZOFbQ94SsFl3Ai7Zf8zt
         Pgy/rvF2z3kgQUyzkdJ+FVyWLkv/2sHfRAOKqjwQ/1gOyHRFULabfdS7h0QzmCP66rao
         GRLWlYj100PpIZrQhMZ8XzrLIm4vuVml6AO2va+IaA8gkYkOM9oiT7D1kQ0SXOUJp65q
         3M48ekcSPSN5Cw+pjORuJJHkmbUZxSyrhWOgvPYUR4mlzbUARy7AQH7JqoLO3XD0fHlX
         sHRg==
X-Gm-Message-State: AOJu0YxCZegR7/P3cvOtXixNSQdDtfVlIVZ1YZSHMWDwvW2KB5z8/Mjq
	3jElid/yfuiiDie/S7iQLiLdSHTanUkyPvIIQZrX9u3H1Dssd6i0CkDJ4BDY
X-Gm-Gg: ASbGncsT3FPiMMbze0az0N5JizK4JiIO1cfQbkij9FGbfAfLiSQSIkBMNA7uLUgzma3
	3hOKQ7+ZxZmWYHA7QrrvRwzrXFmIjCT8vHC+g09kQLBy6PsGDNVCMto1GZTRLoZw1EVHg3zBcY0
	L7egxTnikySwi65NGrydPF8vCOTdq4GmBdQZow8JHblHPokPGwcc8xv4ss9VQbBo7xLvZe7O00/
	fGgUyLetCo9JQHZurzR9YyLHu/3bZ1+Yd/Wixd4VqomvVLZ2KEaklEXvIq3hu5JsmhvU8wFF2YJ
	2C3KzBnyAzi/vaxTELvM
X-Google-Smtp-Source: AGHT+IFETbYLDk+dufEpHcMG8FzoKvKoRPIGknFh0026xW2G/sTpXUS7Jiz0bxKs6icWACoUWZdu4Q==
X-Received: by 2002:a05:620a:3903:b0:7c0:b1f3:b4a6 with SMTP id af79cd13be357-7c0b1f3b6e0mr172326485a.57.1739887150050;
        Tue, 18 Feb 2025 05:59:10 -0800 (PST)
Received: from [172.17.0.2] ([20.42.16.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65daff735sm63918676d6.105.2025.02.18.05.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:59:09 -0800 (PST)
Message-ID: <67b4922d.050a0220.34c828.7ca1@mx.google.com>
Date: Tue, 18 Feb 2025 05:59:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3924691315290596244=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, haoxiang_li2024@163.com
Subject: RE: bluetooth: Add check for mgmt_alloc_skb()
In-Reply-To: <20250218132648.2561862-1-haoxiang_li2024@163.com>
References: <20250218132648.2561862-1-haoxiang_li2024@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3924691315290596244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935106

---Test result---

Test Summary:
CheckPatch                    PENDING   0.60 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 FAIL      0.33 seconds
BuildKernel                   PASS      24.29 seconds
CheckAllWarning               PASS      29.46 seconds
CheckSparse                   PASS      30.19 seconds
BuildKernel32                 PASS      23.65 seconds
TestRunnerSetup               PASS      430.69 seconds
TestRunner_l2cap-tester       PASS      20.96 seconds
TestRunner_iso-tester         FAIL      141.39 seconds
TestRunner_bnep-tester        PASS      4.98 seconds
TestRunner_mgmt-tester        FAIL      137.52 seconds
TestRunner_rfcomm-tester      PASS      7.91 seconds
TestRunner_sco-tester         PASS      9.95 seconds
TestRunner_ioctl-tester       PASS      8.24 seconds
TestRunner_mesh-tester        PASS      5.93 seconds
TestRunner_smp-tester         PASS      7.26 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PENDING   0.42 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 125, Passed: 109 (87.2%), Failed: 12, Not Run: 4

Failed Test Cases
ISO Defer Connect2 CIG 0x01 - Success                Timed out    2.338 seconds
ISO Connected2 Suspend - Success                     Timed out    2.741 seconds
ISO AC 6(ii) - Success                               Timed out    1.918 seconds
ISO AC 7(ii) - Success                               Timed out    2.512 seconds
ISO AC 8(ii) - Success                               Timed out    2.511 seconds
ISO AC 9(ii) - Success                               Timed out    2.540 seconds
ISO AC 11(ii) - Success                              Timed out    2.506 seconds
ISO AC 1 + 2 - Success                               Timed out    1.968 seconds
ISO AC 1 + 2 CIG 0x01/0x02 - Success                 Timed out    2.001 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.024 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    2.000 seconds
ISO AC 6(ii) CIS 0xEF/auto - Success                 Timed out    2.000 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.170 seconds
LL Privacy - Unpair 1                                Timed out    2.131 seconds
LL Privacy - Unpair 2 (Remove from AL)               Failed       2.548 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.147 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3924691315290596244==--
