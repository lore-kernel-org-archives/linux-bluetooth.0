Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F571F4634
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Apr 2026 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775309114; cv=none; b=VF17m5LyBjptu933IW/3ObE6K/v+mn72spfFVV+GaW0OnrNugZNrsILLIYs6nahDfJlNCHB3Kma6br5mT2VZGHEiXQ9Hj48tolCF4LhSzxUSv5GzcrcrUN4ZN9f6yZ+Qm+pP/aEMuIWrO8iGZtIDdLnjePErvArrzSr+RnZ46EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775309114; c=relaxed/simple;
	bh=JerD/AqNXYqVItYiZh1P8AzwK3dVJ+oM5ksq3P2CzTo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HAXDtAbJBs9TBm2CSy6r5FYLWN3p/0w+aHRnT6HsFkfFoR2/vvkC6tbj28MmkvzqUJA0RtqrZx2NWGOG5s/xhlLqGLXQEtAcIniCI/hlKk1FeSd+Yx0WpV0D3H4bo6hpZRXaYSvAgAQnIg07GzfqsCsXXnO9EaBSk2raUEm8HIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqjckjIK; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqjckjIK"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12776bebe9fso6417848c88.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Apr 2026 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775309112; x=1775913912; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0uv1pghDN5gydfyskpXeRGZHaa7QJL2uZO8uHVl3O/0=;
        b=lqjckjIKAtZM8vtaJINyKdqACIExLQsjjZi/S7dYzTujU8qKvBd+QuwWhmvWny3COl
         72vlXMuXcIuHviEAeUjiF/0cws9NHWI8CeKlCy2cKG0Spk8VLTsX2Zv5AuQU1A9toQT8
         WBovyYkfLlzgrQVLf39Bj6vUbZX8LcXf1k9RDWr8LICRBjp093yGeQlHZTCfGvjLkukJ
         OLy0OalgrcctxulJZ50x5T3lYxG+IlUZFiuAKJnyeLt3QxIWhLsl0p2EneiCt97Pw7uq
         kBlQLWWSwIB6Fb+HHEoVG2xt/KkmZllkIjLd0HZXwUEWjcrZ1v5BbaoGaEv5+nsBL120
         ornw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775309112; x=1775913912;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uv1pghDN5gydfyskpXeRGZHaa7QJL2uZO8uHVl3O/0=;
        b=dTZ+BS8tRTfZ/EUxFvw1p8UbZeIchr4twh1RkTLusZYKFPWVywlY7VjSiIwW5GWcdk
         DexuLCLhNL4H4rUai49uvGtSUzLQeWs9DWEZCsJdmo+zeXtMUXWV0CnHQz5IID1au+Ja
         f8W6lrqQ5SLWuRMarR5T5g89L81H6rH1L/yjGGX60stxOqpENM2deG6ENFcO38JtQGOL
         2/lK1dYUiVeHz50mSae347K8ofawWVR17II2V+a9zbJTHslL3YYv9BrWboUjp46M4nw3
         cKgUfx4QatsM2aRBVrDTxEvVAbX8KYNkSDGU8UnrV7d1XKN5kXS4vMaPgi4OoHSbGHDy
         nzdg==
X-Gm-Message-State: AOJu0YwO8m7lPjMqRWy9vWWuD5PDnCXbrU1HSU1cekGrx3g0itQo/0nX
	eRMSKbTV0U5caipJtrEwwWh7f8EC3CN2D9HUqPkk9Hc6eIJrsiToV63FptBeGA==
X-Gm-Gg: AeBDietnKKLFMadg7HdNSJYOXjz5nytyFIG6yDAeqyCUYE0ZbMmSWUWe9ZKL3Y5GxTS
	F6Uf9mh34NfGzbATqNVi5guyKtEguxe+0dlrp/K17WwHBKJ7BeSI2SwVD0U29Y7/C4fIXngcF4M
	dTDgLj1TrrH9WTSVwtixdZORWMV2X7IIKyI30DYZxQ267FxOfynNJsoR4Omtp7IDOBaGbhFrnEY
	tfzhWdqeWbAi5HgnMUfKspNg+QcT5VOgB9V448we3GJNbI9buvNaD7gCicVXlVypfYX7gG+zaQj
	zowCsP0gQk6vHKBwco+zgDOjl8Y/up+NvUIrZDhxidqbeEC1/gWnQbkwtmkC9Fx9M8+a+RP8LkZ
	vUIM3FLNS93YZ5zj3S7Z/AUmQJgNTzLhpHlmRxMdv2MXUUwXWEE86h995M+Bzu+5l7940zlXjIG
	eFJt1//bWmMtY+cUruNKceXrvSIxLdyw==
X-Received: by 2002:a05:701b:270e:b0:12b:fc21:874d with SMTP id a92af1059eb24-12bfc218ac5mr1579512c88.19.1775309111735;
        Sat, 04 Apr 2026 06:25:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.109.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c05a7beffsm974800c88.15.2026.04.04.06.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 06:25:11 -0700 (PDT)
Message-ID: <69d11137.050a0220.3098d.62ef@mx.google.com>
Date: Sat, 04 Apr 2026 06:25:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3755937585543282453=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ma.czerski@gmail.com
Subject: RE: [BlueZ] sixaxis: DS4: use 0x12 cmd to get device bdaddr
In-Reply-To: <20260404123042.3049158-1-ma.czerski@gmail.com>
References: <20260404123042.3049158-1-ma.czerski@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3755937585543282453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077281

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      18.00 seconds
BluezMake                     PASS      649.51 seconds
MakeCheck                     PASS      18.00 seconds
MakeDistcheck                 PASS      224.08 seconds
CheckValgrind                 PASS      278.33 seconds
CheckSmatch                   PASS      312.65 seconds
bluezmakeextell               PASS      167.12 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      938.28 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/2015/checks

---
Regards,
Linux Bluetooth


--===============3755937585543282453==--
