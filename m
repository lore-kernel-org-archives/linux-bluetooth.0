Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102E1217722
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733333500; cv=none; b=bqpR9R39MfK2cOhd9u6JavyAVRYBzOAkU1DN5ETzFJ7yh9yW0CDmV69UBgw28G4FNMXyNgMTWlY244k5liYG7KkjD8pKHsbVviiX9VVagJUyytRU/2uf4TTAzSchMEAOHRsB4VO2NScJneZzwje/PHKEn+Myf+z1YMZ/1uGBYNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733333500; c=relaxed/simple;
	bh=5yGVShn5Kf20TUD6wk3JIuA67zVlvCYr+Lz+3zWflmE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nylz5OA6jskrkGGOpLXJfeMcTH9n0DzAhYqfr7Bg7wpm6GtElKhqxUOdNE8gmDC7C5yjgO608ZXjy8jBhoE5WkYTOby94Yonhp4XDJ4SN5R2Gy6CZWQUE9ctmYlUo300jDonWbqrXqKznNiLyHl7r0xDyfCqpivDxqH5XonENvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VADq4MUU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VADq4MUU"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7250c199602so71543b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 09:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733333498; x=1733938298; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7ajAos36xQUAmZ/jTAcdbEwkXVdfHq7HzpQdVJy/hyE=;
        b=VADq4MUUd3y7bypO4lAMheaUersWIWwQpPDDKra+1U3JQM5itY4S0FGMqg7gCC5qFE
         i6Ww4aIdRNSNRVGLszTvET/tEaig2XUZk60ReAZvHNljAE9BckC3h0wwUVgvGBZoW+3K
         bp9K7Mq3sKq02GB+cAnkN7CWx8NFKm8IkeWoXg9AqTJKUYO8YTbjBpfkCZ4k8yDyOwNf
         B6p8GGGxcpxnjM+pnAVqEU4bQP5mOBbStUpcm6440Qo6jvaukFVY/KKNmnp2Tne4+evh
         Lkjb9XIM8qI+sKsJeKtKjTpRP4WARTQ/pGmIF4FmDhNkXqZnvANjJGIpQsLoHuT9cVuc
         9S/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733333498; x=1733938298;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ajAos36xQUAmZ/jTAcdbEwkXVdfHq7HzpQdVJy/hyE=;
        b=bbFmqw68GXZE/BkqT1C2tCWfbP7st4KtI6kULvx0Sy0Rj1rK6pKQXioD2y3O6FuiZb
         sRhfAV0Zy5Uz/6AgN2vFdscNPFhV/BJkEVk2AJpBcyO9v7tA6ovVTBe4VXEY+62t4a+i
         1Dar6Uf+/+iUTnob3AOdzK8aryNEdf0QIUfOsMslaGk/U7XwJ6JWIS42yFnLG29YnOZR
         9waEg+SYJA0VrCcaUb5NBQPXuWRsLOoYNCHX2eTM5vZ4QLnsVUsbUPeJHa9cvktV8/dz
         0L757wiZ10SJUYdtNPmQoOr3/S5FXOeFD4IoK7ZPqhcUN/TygKiathkpJ2SYLQECAr2a
         Cv/g==
X-Gm-Message-State: AOJu0YzFCWYLoP2HQvwMVmwECfEyMTNJJoUunNRP77eRqnbEKLTwtjNS
	6opHyxLoWz9I5GFDDluP3eRRj6+hME2anka8ffmoGhLOEaKzjGNc7OjNsQ==
X-Gm-Gg: ASbGnct2CHHnVq2fO9MAi4LxEQeEWplXNM6X4Vt+nlHwr3+tYatucppi1Qf7bUWxNOi
	YyFtavPK1Ij/AinPcAJacQCWhU/i6b79gOV4lPRIaOS4sn2Nx3hEFm6QzOkJ5wZoWzpFgv1p3r0
	64zB7QCZ/15/NNScBxPFXyamBGp/vbFnCe7EQM76vLGEiyKErP+FBloyRrDxgPEb4nZ52LYBLvJ
	4IYe+gSyvXxWvCQgDFIq6YqTzE74w6G5kNk0PjE9b/BlE4cuX7wVwQ=
X-Google-Smtp-Source: AGHT+IEcBN+gclh16Y+JHMwCROdB25KwXuE9NGecW0ERNmo2mdFxnBC/Zk/jS3E+e9GLUKqOIIHceA==
X-Received: by 2002:a05:6a00:4b12:b0:71e:5d1d:1aaf with SMTP id d2e1a72fcca58-7257fccdf45mr12783695b3a.23.1733333497780;
        Wed, 04 Dec 2024 09:31:37 -0800 (PST)
Received: from [172.17.0.2] ([52.234.40.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7259389141esm1361802b3a.8.2024.12.04.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:31:37 -0800 (PST)
Message-ID: <675091f9.050a0220.4a6b6.ab20@mx.google.com>
Date: Wed, 04 Dec 2024 09:31:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2210750663842276759=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_event: Fix using rcu_read_(un)lock while iterating
In-Reply-To: <20241204165849.392564-1-luiz.dentz@gmail.com>
References: <20241204165849.392564-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2210750663842276759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=914654

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.40 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.26 seconds
CheckAllWarning               PASS      27.87 seconds
CheckSparse                   WARNING   31.48 seconds
BuildKernel32                 PASS      25.05 seconds
TestRunnerSetup               PASS      443.48 seconds
TestRunner_l2cap-tester       PASS      20.63 seconds
TestRunner_iso-tester         FAIL      30.80 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      122.16 seconds
TestRunner_rfcomm-tester      PASS      7.61 seconds
TestRunner_sco-tester         PASS      9.38 seconds
TestRunner_ioctl-tester       PASS      8.17 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.09 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PENDING   0.93 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 125, Passed: 121 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.194 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2210750663842276759==--
