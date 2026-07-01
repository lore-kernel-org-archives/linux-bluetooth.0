Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9356A3793B3
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924633; cv=none; b=YvfF88i4O4EKAfJ7FS/tXi/sEMYqR4vNXERx7wuO4Sr310GCcg+ii8Kw66XHMBnTsUXd9kjEmxvPLOdCrp9sp8llOcCWOO0JCKyXsflz+b6UxuLHOgYmZM0eDEM9mOEIZzNoDfgupPANXiQNcvyEHTyHS8U24UmMaFLV7LNoYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924633; c=relaxed/simple;
	bh=yF+at+z+JU19tXSkQ3TTzvOwjF2OkuNHUMvH6HjjBpg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jPX6v7DfJEwzLT384crdNvLpHvKXHmRIwlEIFa9Swlsh594UvOHQx1iU1SKEarFW6Jn2PG1H9pNl8bBGWBZvV0kETUqy2Zi8s1pdrCxAbyxBySVPtTP+kCuQbomVDyGD8AN2t5itO0q4RcWCt3ifiXG9wlfiFU1K77VO7eUOiwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izqTepH9; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izqTepH9"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-44aeefa1c00so641616fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782924631; x=1783529431; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gJSKHfsoP4/O0rwyEXCnkqM9gN7MwKsGWJRIz+qJ8uw=;
        b=izqTepH9Ql57gSo+MF8+O6r6r6z5DUvXVXeWcEuJiA99CGjtzVh2ovrR3Yk1hlegcn
         XpGrRVXRb3M/Ds9ag+alBJgnPfS5jQp2gU/cuPwQrOJBMXbfbwG3diC1W5jes0pGfLAt
         PJTHC81mjD1TOlIGHsS4vt1xAj48/JI5Zj+23sGnKStcSz8pKW6afqlLmfwHogxf3ZZ1
         HBL8wc3nlOYZPbbf83kn7GmZ5CJ0SsLDfwnidq2pU811lZKrzvu1frOFUP7eNCRQMrkP
         JZCX7kO5+4pmYRx5jqgLsuqhhKyj/GqLgc/zWczT3j5euj9LS9QIKIJVW+mMRaIIFXQm
         mA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782924631; x=1783529431;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJSKHfsoP4/O0rwyEXCnkqM9gN7MwKsGWJRIz+qJ8uw=;
        b=MYP+JQj8U+GY9uZc9kvLPQkoQXII44yzob5jxfiSVnlgSTODCLBL7g+KaNg6xyDN4L
         i6yOR9k4OEDxTO3cJP8cFBS/ho0MO9Z9VxKCqzAVrCXguf1WMK3/dE8x+bylLF2SYSEp
         JpL8REharsQKFH4typk5s8I2zDO7YK+dAWABg1Ogw5r9bHa3ND6UJFXqrVfG04KIr4gP
         GDa/DQ428SeY5tuEAwE2HdUMZxlTQyDRiTeXuDJTCqSnEsGs872qay1G7bN0T+Ba3Fua
         EQe2LI7Qp1mD9SjHkOcrGjPLkFC5FdbKyCvGlmq552sfKGRQtCoDuo3bSiHyWGi0xJHv
         ikKg==
X-Gm-Message-State: AOJu0YzADM9012AaaGKeeM7fakqIUo1xnBJIVbYOXlqa4jTwVwYvVDNJ
	BvdaAgkoaVRrCde7M1eITYgEYiZN7DLCLqm0HOVBPV1IK3PHiFVaibfcfLOoUA==
X-Gm-Gg: AfdE7ckgVrG9EDgiucKZCEcw9wFuFsN38HysNC88GVQFxi5Vngk58azGUXt5eCMJhxk
	li8/TsCYBE9NXNwiTtkqs9XM3cStqQl7IFDHKqYdhP/POtcKkRX02EovKvF19j/qx3fZ3xkVEI3
	dPL6LOQ6NvoTLLjHc8aXxzfFbDF0UJZmNwewuOyCXsvAoNB4ydVd7SCdOrhVa6Zcz4xcnF88sZy
	HpT7z1SiBFpDfv+39x8I1vk7nv5kIHup+TUG90bwVcHuziS25vrlhPrTDsG17MIhA5/54Qw3OzS
	16Slxpx5pznjj4GGq5rtld0LevoTfQfl5RhTKWE2TfuEyE23zaI52/3Om/N2FPl7ScLOQ0q4Ntg
	7s6jKV4mYvtaRbykZ+z2Vx3hNwmQKuqCGaRsFkXFmblx6oe+KfuUqtmbuTZ3xVws+9i+22GP81S
	kdih6Tu4u9jHjRo/FYIw==
X-Received: by 2002:a05:6870:332a:b0:430:16b5:909 with SMTP id 586e51a60fabf-44ca81c5a76mr1192914fac.15.1782924631368;
        Wed, 01 Jul 2026 09:50:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.52.240])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbe841750sm248068fac.3.2026.07.01.09.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:50:30 -0700 (PDT)
Message-ID: <6a454556.eb7060da.6edbd.777a@mx.google.com>
Date: Wed, 01 Jul 2026 09:50:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6897667872247676360=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, i@rong.moe
Subject: RE: [v2] Bluetooth: Properly disable remote wakeup for MT7922/MT7925 on Ryzen platform
In-Reply-To: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe>
References: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6897667872247676360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1119953

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.28 seconds
CheckAllWarning               PASS      27.26 seconds
CheckSparse                   PASS      26.08 seconds
BuildKernel32                 PASS      24.13 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      462.10 seconds
IncrementalBuild              PASS      22.84 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: Properly disable remote wakeup for MT7922/MT7925 on Ryzen platform

1: T1 Title exceeds max length (82>80): "[v2] Bluetooth: Properly disable remote wakeup for MT7922/MT7925 on Ryzen platform"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/380

---
Regards,
Linux Bluetooth


--===============6897667872247676360==--
