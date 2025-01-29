Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA7D166F1A
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 03:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738120485; cv=none; b=u6DD6p91aB/wq8vrZ1F0zymlo4URtLghRMmNnq8PDWAteepDCFgFsn0/mOOSmnHogaiwWKoaWp5TnOQklpDbffEuRDD6Vfo4AlVPERoMQmRCelOl0DdtvEjwF8IP2eYXBc87/26yYnDE9jA3VNWDotfXDZXhe2vRXYhROWEB2l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738120485; c=relaxed/simple;
	bh=Tc+kBTXcVr7ZLoPFwyahfboJZ6JQP3CQ4cJ3/MIRqdo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FS5I8kx0B+1lUXBQyPdShbXnuoWnt813Z6of4aobxp29ofFdAdDNvjbJOZwjEYwPQLMI6OKTPwQm3e0I0U6MzoCSheDdvIagoue78mapFDLqN8ttorjbm2vjZhMzMGOe8ryKoQRlfVRuLMCxrtdyqKz7SH99Pc80Yn4F/hFmLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8BlTlgd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8BlTlgd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-218c8aca5f1so152840185ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 19:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738120483; x=1738725283; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zG9gwETBNQV+8eVGpzNZ+YeTYRZnuJ61i4iohjUw7tw=;
        b=e8BlTlgdMr0yTNkcOjMdjLO0RfxjrLRuKbng371XdPpEQ2tHXE9NsnZxgF15Anpav5
         3XWwQoZR2kOq2Q7U8w9dAdburr0pnH59mrCBeVxmgV0ApJ3QfjGzS55+FIGCHaa+klv2
         LEau6+ckm/JmR7r43Y+93qVkwszHKJUnhI8Knukd4yiF08np9q7pvgABd7yAJpxThDIg
         JkbE+1HzdNHk0f5YiM2yLDmSTubk5HK2792FPuLJYe9A25Dohzn4EodGHGta1gtUP9oD
         wcJzrq6luCxlwB+3K29FZBHlmUN4PD7nLdhCmlbZ9QJdzh1egjUvjkzjRM5VG4267jrr
         //PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738120483; x=1738725283;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zG9gwETBNQV+8eVGpzNZ+YeTYRZnuJ61i4iohjUw7tw=;
        b=YEYVruvazNRAuuM9JbLCOtqLKl0nlIooXnWWyDHJhc6jul6hOH6nCmaU5MnbMIrItw
         WwmvDleM7PfWc3bylHSPQIk0IlZmG6EsaVuakPzIyz2jBYQKqFcmlww808wtsN5wvzXw
         tL+8cdNZmbc927GqnDhqSfld4d1QTmDYX4I2TnnqTiAM0yoDgBmcNojCzYIX5xF2xOiV
         eg62J/Bbv4FveeTJPYtgfTCPpvURrm2oViEcbRnLReaZq/jmUODpAhJlIZFBmnqCqaFA
         1Nz+M9MS5wm2JrgoyasqGMLqJ9ILA4Q/QuwqQh22SR42uizOnme3XXeAUE1IOA0K89Xn
         jWuw==
X-Gm-Message-State: AOJu0Yz0Iqs7t9Gg8edMYHYqURGUwqOdQ4AyfVx7Igqd1svj3dMNMUTn
	trVoAAk6s2YqFsUmxwV5h92TK0aF+2Lyg3AJN83fmfXHGlcTzA7rNUBJvA==
X-Gm-Gg: ASbGnctPEFcDo8yjO2oCKr7dqTX4qkQdmk03R9/Y3zTWdTSb6/w0HhIPf1JKygG7Ztg
	heLBSAmuHIezKbtiKwv3KAECQrPiYlX43OOXWrcMGgGxLyltvl6lHR5TvEMSSdoCTjAilavp6mo
	ncAOB0UKr26PJyqUzTzf+E3Y6GisnMQQzFATOXrb7vxZ6NPaiUQd7/s/Q3QOkBMyxiAHT6oxqNl
	Mjo7fCVgHcwV5d3mDgG+idNOzQb1bgCNlDQaZn17aPpJHHTFGmuVJeu3/wt1lKcQGXGwFZqSWiF
	rV9L6W+p0Atii7tK2r4=
X-Google-Smtp-Source: AGHT+IEiWJwnSbGekrj+fwMLguccWf1RKtD6r4+3V39vP0OXKNRag8vfRvg0uPx0f8Uiq5LpmL2coA==
X-Received: by 2002:a17:903:2406:b0:216:4122:925f with SMTP id d9443c01a7336-21dd7c66928mr26473205ad.14.1738120482782;
        Tue, 28 Jan 2025 19:14:42 -0800 (PST)
Received: from [172.17.0.2] ([4.227.2.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac48f897f33sm9247256a12.23.2025.01.28.19.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 19:14:42 -0800 (PST)
Message-ID: <67999d22.630a0220.0250.6a07@mx.google.com>
Date: Tue, 28 Jan 2025 19:14:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3414583593419964320=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel: Add DSBR support for ScP
In-Reply-To: <20250129025817.65224-1-kiran.k@intel.com>
References: <20250129025817.65224-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3414583593419964320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928979

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.25 seconds
CheckAllWarning               PASS      26.23 seconds
CheckSparse                   PASS      29.84 seconds
BuildKernel32                 PASS      24.23 seconds
TestRunnerSetup               PASS      427.51 seconds
TestRunner_l2cap-tester       PASS      20.23 seconds
TestRunner_iso-tester         PASS      31.37 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        FAIL      122.93 seconds
TestRunner_rfcomm-tester      PASS      7.50 seconds
TestRunner_sco-tester         PASS      11.18 seconds
TestRunner_ioctl-tester       PASS      8.03 seconds
TestRunner_mesh-tester        PASS      5.96 seconds
TestRunner_smp-tester         PASS      6.86 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PENDING   0.46 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.194 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.194 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3414583593419964320==--
