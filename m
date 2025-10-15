Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A231C5496
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 04:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501338; cv=none; b=aIY0+q4TKQAvFo1e3gGInrDtz0mflnCMXBIlh2TaTbpZMF4Dt2a7Ne8TQ1AikiVdrNXlcz7mKUcJ1Agq49oSdvBNHzKOdS/JPXXsD7SixKb244+2Le20c2YqxqLtWzFBrCyY/eTP1G7K8OnK5gBB0eEoNyGEkeXqMQn9H9iVhyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501338; c=relaxed/simple;
	bh=3qW5sV6OZaNEMAmkL1kqmXP1ufkpMnsvHJAxro5voaM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iDlZ66LxNFrIRmcnhlgycTJ+7soAlUoYtth9Y8D6ErgQvGR/Xpbe1pC/+9XUs0D2m2IRR2CHf268guMuzHUGVSrsHiJDSPSN/JPwXtsgF4WATMpzub7TkE27j0xuLdWgiBoHLczuZdzjSGNji9fATMEDJDBrIlyWp6PRb3U/PiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Paefr9MD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Paefr9MD"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781206cce18so527635b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 21:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760501336; x=1761106136; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U+Occ7lrMLmeNyVaVzc0cqBYReu+rfhe2aZq5dsLIrQ=;
        b=Paefr9MDAYMyyc6eIChsGYTl3Jk9gEr903yQL7lr0z27C6jWuSmZ9AK5DcBSJbnA4g
         dbWiOOmd9BOmIWdm/pNaNr5HBxXEAISYisSj3UuMRJBpZTXSXIb96tqxmSCDG+4acAyv
         aCYY5TCnvIRRpOj18onKgh1x/meJpoGS1aJ5x8rm/bXZI2tejIipi0uDYwl0hVLyHwTo
         VT+IAVvMvfQQ6qaSX73KBA41P+lFgRY/1uwhCPbQMB6g68jn7iF+WLQSkg6gafNUO68Z
         IfPBNP9jwIkK+8+zgNjnSwr9/tPeV4zJe1HZrOVVci9c3nY/MXKjxzTrJIEuunJEREab
         S1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760501336; x=1761106136;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+Occ7lrMLmeNyVaVzc0cqBYReu+rfhe2aZq5dsLIrQ=;
        b=d2dxQoRYQzbE8h5M3aXFnjSmH34aIBNo/Vz/7fNccbgbKoPbOngGMWWeVUOxssAHR8
         frxsGnvMFEWgD55KChQ/H23i2VYws9AWzzirm/V92i1iXvsA7GMcvDbls4lj5Cij9UUR
         geO8f3oYOxlXNmvH54vy2KP7Orva+3wy8CshvLXi/tW0pDjAvoJKlkYFJLYw8XyemqbL
         rl21pf4ALgst6lsrS1RFQNjg/7kAq+ka4gxpmb9Vje7C9IB77GWSPrbKx72VjO0PY+kl
         umd0IQ8Poq9UN3Vtn1HCFgK9ck1APK4jLGhqguKwsXowIwkNtssEfBXkdXKwh1CX0y6G
         1HLg==
X-Gm-Message-State: AOJu0YwMCHQ7UyDsVg3PzK+z0/wQYsiWGL2npM+orQNQRtcPUdH4wGiU
	sfXedhDcazy6n0qKJZNqOkAzyEC8rMKiYPZ6Jk6MlduMVV6TVgMROk19cWEf+Q==
X-Gm-Gg: ASbGncstfSo5oP5GgeR89iVZXvmn/aTkRum7UILFO7oeScuXcjDTGRswuVDWbsFv0Qc
	fu/e1uJcB16K8By0JuiKM/43k50bGoWWcbbmm9MzOswdgDiEV1st/gy/v9TXSl4ZZ5PpslmMBts
	bpVHirlOBldexW/Sp/A0jEeariO4jQ8ds3VOVtOtwvSgNW0/L+Mf+MbIxmM89ZNPAO8VZnla5MM
	daM9MrxBmCgbqk6gyJNt5b+mEre+eh6TpohGC7mNQddFQESLwlgrnE2PTIZQ7fBLIsm8jQl+arP
	fIbbOWRY1LHrbrXYdQK4PU34Me4jAH9VsVY5iBJ10rBxMheiPNBbt5oIR04E2sbs3hsvYsXvB4x
	07kXllxyFvvCoU4qTIlH/knLUtvaECYT9EpgIniCxUisMejrLLRcEu9x5CA==
X-Google-Smtp-Source: AGHT+IHqGNceihHwWYymDoSVC3qD0a9eUj/H0Ywi0X4MNBN6ILsO6EfmVJq/cZ0yneiEhgU6ASLxog==
X-Received: by 2002:aa7:90d3:0:b0:784:27cb:a2c6 with SMTP id d2e1a72fcca58-7922fab2444mr29212152b3a.2.1760501336221;
        Tue, 14 Oct 2025 21:08:56 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.244.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb1e50dsm16945660b3a.33.2025.10.14.21.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:08:55 -0700 (PDT)
Message-ID: <68ef1e57.050a0220.2fcba7.91ac@mx.google.com>
Date: Tue, 14 Oct 2025 21:08:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9098693175115254236=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Add two new ID for MediaTek's Bluetooth
In-Reply-To: <20251015033150.498866-2-chris.lu@mediatek.com>
References: <20251015033150.498866-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9098693175115254236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1011622

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.61 seconds
CheckAllWarning               PASS      27.10 seconds
CheckSparse                   PASS      30.67 seconds
BuildKernel32                 PASS      24.58 seconds
TestRunnerSetup               PASS      493.08 seconds
TestRunner_l2cap-tester       PASS      24.07 seconds
TestRunner_iso-tester         FAIL      40.44 seconds
TestRunner_bnep-tester        PASS      6.14 seconds
TestRunner_mgmt-tester        FAIL      113.57 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         PASS      14.48 seconds
TestRunner_ioctl-tester       FAIL      10.35 seconds
TestRunner_mesh-tester        FAIL      11.35 seconds
TestRunner_smp-tester         PASS      8.47 seconds
TestRunner_userchan-tester    PASS      6.49 seconds
IncrementalBuild              PENDING   0.67 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Pair Device - Legacy Success 1                       Failed       0.195 seconds
Pair Device - Sec Mode 3 Success 1                   Failed       0.176 seconds
Pair Device - Legacy Reject 2                        Failed       0.152 seconds
Read Exp Feature - Success                           Failed       0.112 seconds
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 26 (92.9%), Failed: 2, Not Run: 0

Failed Test Cases
Connection List                                      Failed       1.055 seconds
Connection Info                                      Failed       0.139 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.800 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9098693175115254236==--
