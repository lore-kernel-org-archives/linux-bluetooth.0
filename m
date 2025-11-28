Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D6F3093BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764324131; cv=none; b=K6KmPeDK4rL51NId4gydcC6eGObBF4YS8Ib74PJFIyUhgzlBFyyh/6AopCIZSLn8hzTyIyh6es6qHtfPgrpGJ47isc2M8qSxTNb1VTwEFIne4vM4Xpj2Uhl3FrXw78F17lgoPS/KvIQL+6c2SDQPJz2focGS2oEE0H4HqowSke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764324131; c=relaxed/simple;
	bh=jP0gZqKwJRQ11d/d8cjEaqDClWlWxE0u8hNpfyMDk5E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ffI3gzL0DqmnZTxdu5tVX7bo2PBNmLsoecXQr33T3YXirQkoSPkWHoD7yxkvIEAsgdEwZcEgfT3BppsEYnpWeGg9MrTkzugBsx1rTWRUFPCbNonVfug76qXrNCKMBJG+DZg58/IkmLg63oH/cawwY2uDEkIIIkAAaMzDGVqxlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdZm/ETJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdZm/ETJ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ba92341f83so2694512b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 02:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764324125; x=1764928925; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WeVqvW71pMSWzsLiFybX2iqhkALxKSykTcFFCP4cAik=;
        b=HdZm/ETJvAFYmTm3fhpQCdSlpJnwBu9QSO3RBbxhCO9gPoR0ZybgG1UbZUeD5wXSIh
         x4ti4tmtwz33JybH8PD3aNm7OamYutokoA9Vgm+6Lt1Xd+k6uAFhTtN/ymA/5Khjj8y6
         yP6O6aptu78O+qYfiuQ0K0J7hwKM/r6XyWfx6R3ClqCdwORrzzrtNx8yLatnmOubgK0t
         VWhQzaYqDSzIeIIvL9rwQx4oItp4m/phogKElrpG7i8UnT+braPz3vSrgpp0zfxuCzRn
         feoc4sjEV9josYeXLkq03QV48TIszCVXoXZia6emLcuIpF1iAWUGrBqaVhndDkJhWEuk
         uzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764324125; x=1764928925;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeVqvW71pMSWzsLiFybX2iqhkALxKSykTcFFCP4cAik=;
        b=OorT5nnoE/KIdXKEVGLppGnikpSNUDP1CRxESIKAt7qW7XvPn7xAnXWgm7f+oU8QgZ
         lRBPHR/C3CSUJanP/e9sjnEPL2nULLpr/tu6zyJehbPCoLz0ZlSN7kmNh5qvtgZ65wm/
         /SrYykHu/52UVq5O6tvd6jLnoVtTjUxfC2tsOcW6IUCb1aI038XoaQenF9cOJGauI+ZJ
         21yzWWtEF4zbgkUEDQz7qTnpOImOdVbyp3xei+r+0whsEt6uk2d0M5JPPSS4PeX62uvR
         CrBr6QuuZ0QgbdXgtZ3DK/7UpikK1T0Ys/r0IFz43GSyB6+86YHVK1alqqjUDM4ujv5l
         yKkA==
X-Gm-Message-State: AOJu0Yxi566I68O+k4kxdjvQhc5RR5hhzYySc0HL5cwvahJFOAAsNz8g
	b/jV18Su+X7nJkfogzQNZKeS2SmddpjYjlsMvYEUZChds1QfPbO6BwZRaSmhbw==
X-Gm-Gg: ASbGncv54/o4QoKSwPLCHRK4UDbsfJnUX5SSjaHfhP1BeJbgTCxqbfTcBazG/fNAbPP
	N9XjHYUXZ8SA5OjZKWR4dHRWgQtVHSE+++XnLlO9ocApocq8+jFqK+BzaAqx6iou4pwygRYVRA+
	0L66aLInBwOr9u3288u32yJqhYfnLIGmAeN3/rzZWs2J6s+/xwXZSZm0gXsH/O3UqEcXnJeVDfx
	Y4JXpcEbuyWy8eiwqOFGa4+FWyW/AkNM3/lRVcgl0WdHWoPhEE74/IGqb7n2fVc0pokzAMgXAYC
	Xq86q8asHsT1T+fApXTiNPdbdBJcoIGsDgWqdfL9Pde/Ib2ily9p8eKgc/NKvlu7dDveI2iFZpd
	tPCy/emAjK2ly42cHwhSAQAG5AtgM4DVQ9O1i75/IUOau1LTcmP9nGCwZOUPb2TSfh2ZIWXcQSB
	N7imlqv2Ri2hpsWZFe
X-Google-Smtp-Source: AGHT+IGrjXsPhL9iOrgdOlIKPv0iT3f2+vHsyVzsQHcMJpuquJVzSHyLVkK/+YNZVkAz9MnjopiocA==
X-Received: by 2002:a05:7022:698f:b0:11a:4525:5361 with SMTP id a92af1059eb24-11cb3ec308bmr9310749c88.6.1764324124771;
        Fri, 28 Nov 2025 02:02:04 -0800 (PST)
Received: from [172.17.0.2] ([172.182.212.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee660asm20896301c88.3.2025.11.28.02.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 02:02:04 -0800 (PST)
Message-ID: <6929731c.050a0220.100f5a.8354@mx.google.com>
Date: Fri, 28 Nov 2025 02:02:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2141354103240796535=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Bluetooth: btnxpuart: Add secure interface support for NXP chipsets
In-Reply-To: <20251128091443.2797316-2-neeraj.sanjaykale@nxp.com>
References: <20251128091443.2797316-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2141354103240796535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1028593

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.43 seconds
SubjectPrefix                 PASS      0.80 seconds
BuildKernel                   PASS      25.26 seconds
CheckAllWarning               PASS      27.15 seconds
CheckSparse                   PASS      31.02 seconds
BuildKernel32                 PASS      24.50 seconds
TestRunnerSetup               PASS      545.19 seconds
TestRunner_l2cap-tester       PASS      23.24 seconds
TestRunner_iso-tester         PASS      76.46 seconds
TestRunner_bnep-tester        PASS      6.08 seconds
TestRunner_mgmt-tester        FAIL      113.15 seconds
TestRunner_rfcomm-tester      PASS      8.96 seconds
TestRunner_sco-tester         PASS      12.52 seconds
TestRunner_ioctl-tester       PASS      9.88 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.28 seconds
TestRunner_userchan-tester    PASS      6.39 seconds
IncrementalBuild              PENDING   0.71 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.096 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.121 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2141354103240796535==--
