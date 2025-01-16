Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A824A7C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028475; cv=none; b=SGBndA4du5Gf+zdUtEAEGoBgKmMInOJSEkK3lZuAJBXC02SAZWgZ5aUADXcbfEYp2y72PPP7dKAdt58FS8FwbbSpRghS/rqTJXCLqTdON5n/9EgOnVMeI9+/QB8nTFv1FxAH/+4tHqvNWEcATErezpkAWyeRl8bQpj6vHND0aSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028475; c=relaxed/simple;
	bh=TJvPxnDB4UScj7w4qoB8CiCsKwWlrGbEzPLSddPDZtg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OJeO+XwXbx0Pcm6wu8WU0StZIm5B8NNf7624Uq3xceRQzP5d8DsjkyMuSROLIJVoSHkeaaVxV0iKrZpAtdFRr/cTDRFB4KstdZGF5selak1w/1OCRp8MyK4VI/Y+9qA82k+e51KRTLcCWWN6EH2bE+z1YSUT+Qxhz1ScYS7F4Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQjFEzNz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQjFEzNz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163bd70069so14359295ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 03:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737028473; x=1737633273; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PJAD0Fj3m9wnJRRcRGYrmJkl11ugy1/CpJEZgPs9g/g=;
        b=OQjFEzNzRhiYwO/HZSdng8sd48ko8J08VSPFohF/rPSBYQ23YZDLYjSF0LM4Z9qL0m
         NgMC+32VU08PvH3tJ+cfScKj4tKrPfPd+PGnRYWilP11h5NKja1XcXKdRm2nA7QQlq9L
         ibzWnEODi6RBkDHSdv2HHiiGAOeVkrIDOq4n5jSYqzPaU33xs0gBUZxdSsyXuhCQFEkd
         u3WkRdKJeWm5gjIpALxnEsF6m+G0J3RGlSyoAjcE2FDoNZUDwyfP6s5Pri22PA12AKfQ
         x3fE+HqAd4wwjMgDVarTeEcRMe7uCj/jZnLpB7dH4EfL3WfncHNFL2S/voWWeTzZs0uD
         RdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737028473; x=1737633273;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJAD0Fj3m9wnJRRcRGYrmJkl11ugy1/CpJEZgPs9g/g=;
        b=DznvByOg42sTYmTa+8h8KPQkGuNwzRP3Ujb05/lUuLMNAbEqYKHvALK3JelN4xDWGX
         9xVSoaPCTrdezW5Cka4ShCYuaF7Tn7eDd4LBAoHD7Rk2L24NV83gUqDZd9VxF9QbBKv5
         5nZaI4qZCSQCW38lxZY+qZf8e8d9ghStS297VbzjJeQBpJq3EN9kn7gY7L2kRvlRK3mN
         GTMCYh5zublKx5X0VMYgJFgbrLJa1WKXpntGvKi8AckonJZMCCUvvuxnEX3YNVr7D+aq
         KX34epxj8FACzs3XXodvnZgumZsO0ooRmF3APJ0/m6piB8+pWaPwwrIpXlXJk9klZxGk
         NNNA==
X-Gm-Message-State: AOJu0Yxu/n10770a9r3tCwtgSr0iX0Xh04CWoqyZa2YjwIZyR8EJEAw9
	dF8nazt46LEy3D7yG3ReR5jtbXZ0jvCTm0d+sSr+9q+RHjMZUrU5vDzxpA==
X-Gm-Gg: ASbGncsRG4Svy6Vfjgn7mptqQg/d+/dakrtJ0MG0DNAy62CffxA4HEZVC+i4+yqEPiG
	WXA/6UDSvdzVXhecufIrH4i60NYF8iWHBFbsYgdsm0Amxn7zprlYaejl2B0q+1GqB+saKhcTM8O
	f/kgM+/+lYUponE51fJ9fYPSyvYhaPJgDLnBkBNMQ7M+patORtrulfAKXWORiS+WWOarGiIQydB
	oUUrSTZlP8KZ++ZY3BdxDTOXhCjH6S4N8LmXV9vLyEZdKX39HNY47UY8RfwvXk=
X-Google-Smtp-Source: AGHT+IEhAVqbAmHkm79uxcQxOhbEX5J9GESBAiwGCY8FXJpvTVK3CxoYfeQxFislOMzXPttbBu0g2g==
X-Received: by 2002:a05:6a21:c94:b0:1e3:da8c:1e07 with SMTP id adf61e73a8af0-1e88cf63ffdmr50748393637.7.1737028472984;
        Thu, 16 Jan 2025 03:54:32 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4065c475sm10850492b3a.117.2025.01.16.03.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 03:54:32 -0800 (PST)
Message-ID: <6788f378.050a0220.27901a.e79e@mx.google.com>
Date: Thu, 16 Jan 2025 03:54:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6429247424503738985=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] Bluetooth: btintel: Add support for Intel Scorpius Peak
In-Reply-To: <20250116113709.566498-1-kiran.k@intel.com>
References: <20250116113709.566498-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6429247424503738985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=926034

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.66 seconds
CheckAllWarning               PASS      27.20 seconds
CheckSparse                   PASS      30.32 seconds
BuildKernel32                 PASS      23.98 seconds
TestRunnerSetup               PASS      429.56 seconds
TestRunner_l2cap-tester       PASS      20.50 seconds
TestRunner_iso-tester         PASS      29.71 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        FAIL      121.26 seconds
TestRunner_rfcomm-tester      PASS      7.60 seconds
TestRunner_sco-tester         PASS      9.36 seconds
TestRunner_ioctl-tester       PASS      9.86 seconds
TestRunner_mesh-tester        PASS      5.93 seconds
TestRunner_smp-tester         PASS      6.98 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PENDING   0.87 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.154 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.154 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.174 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6429247424503738985==--
