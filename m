Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD0A225A34
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512680; cv=none; b=vDswiiJiOxHX9YXIxnaHtzp6fnU7dW5J0ovKCeIsxu6Jv4RKYxqiM4oFO147laB/78ofZFKAGt4UCKYV1lQaw96itxWn5GZ6GSYcFGpuqHJCub5To35oUm5lnHIqg5lme4qPSbQqt35uBcd7HMJm0PUfoyQpdTnZ5e1TNS8mvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512680; c=relaxed/simple;
	bh=y94lMWJcIZDJwON9ARsoDZy4lulOeEh/sxwfl1+JICs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Cfu2whgbp55xzeiapD2drGitiNPEl0y+DSueKOcLH2JiULgrnDaygA1NujHtgOr7pTr3WTkPBmVVPHl9lbWUntfrq1awYQt2g8LJaoHp9Dx66a8SVaygpVaxTTK08hASwOSiRIi9rLRrZoBVkoqFvajc/BR9Bo9LxeZpTRpGBPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5WCq97n; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5WCq97n"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70748a0e13dso3224626d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Aug 2025 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754512677; x=1755117477; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GGQcbnJXO/59LJh0+HnSn+7t0iswkReF/KyuKOcnXVY=;
        b=Y5WCq97nHzCzMf2KfKCSNrE8bFYfNCujwTiCOGOK4ctvjAJiPhfMbSegSwLb7Dvh29
         eMwPny/dW0LmDdWZSmH88h+dE9e3lvjODSc7lSOfpFxdna6Tv98ma8b4AxBxKcfk0iis
         MdRlNE2Dhbp8hqh3RCm1pZmzqcTH+9IHrPQ6ELASWuU/3UHkZT/jaOZEb2KI2vL2KBlr
         eGYX61Dzkg7tLrQWdApj01jYFj5hDcfm6MuP/BKAd1CUf98d+8xllkpLQce3lb+0xp2A
         Zd6/QdQ0zAB/14mCIVRYCf6lDt5O2XMYNs9NKS6L5b/VT2bjAWV+hycE1fPtPV4gyImb
         LYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754512677; x=1755117477;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGQcbnJXO/59LJh0+HnSn+7t0iswkReF/KyuKOcnXVY=;
        b=WR8o2h8TmoBWfAlA5y5ZwvwE+5iXaVVpeu82MLBkYQ1UqQO/lESlSIsJ7xO0qI704g
         W+bTWowZLYYHsjR62G3P8tOiYBSCBCkpOjWwJMg5Qa/3yiuGEEUxypPpPmNaSeee1nxl
         BdZfcTa9puBw4kJjuCtAaZkSQaLOZ/Bk6Fuo++NkSWGCjr7Kv7JQHm+Q1pyqDxcZxMiH
         QA6Uq0s21Yf6HF5WCyxcJGOmnDeqAhRMRHJQ5FeexwWpsmLWw4GYsAIMvd94cq0Oy4VX
         AVBlkR7oPk14gWw/NP2TLqcip2Zh8Z7iIRUhvewVhPfYQcbeon6UIKONxikw/c5/9QT4
         Rp0g==
X-Gm-Message-State: AOJu0Yxs+B0LQGHv2PKxftbpmQcWmwsHGBYSxOvmU71/uPHWMWKcvFce
	/qi+NrCX5yhszPiuFJ/9g33nY1X35O2ptlU5Qb21pYen3W6VJQz4cO8WNvvPEejB
X-Gm-Gg: ASbGncu5DAv5uwud0RAbrJAcryELcF6YxbKA8oLJE6MCOZhEiUj2yzKg4POzm5X3Q4E
	YKhupl4n+M4l4qXr3FvEj1JN/knPMmMIstAaQdSWwWn/qSzrKjM6FNQ2veNYEV3xj+q6ZgkOPqY
	hsum2COP0Z45/kya876iR0AtDC6vNQ7k8D+49S2BDsRgKCdGQ9UiGhQHPYITfLGWdBRPc5UFFZ8
	OUNJhk/0qeiQroWOJ0Y7AwBC0AOUFgqmPFGy/BaVCwEuQqnZ/L3/5oNcVKIg2h+3ePbyeg90l4J
	G6smGxuIAwLTF1CO55mTCkuGnkowbHzPpabLAJjH5ruov+kSWI6L/p/jNK8khRxu1CfK3ry+/AY
	hUwcEzHyHJ0FoAr+4yI+N0UwDKwlD
X-Google-Smtp-Source: AGHT+IEkA2wdFDeoBypyp83JJTopAqWJwoPRp9tDaShJBEQsMNiraCIrVN+KHz2/0/2zR+QhJsybfg==
X-Received: by 2002:a05:6214:21a1:b0:6fb:25f:ac8c with SMTP id 6a1803df08f44-709795fccf5mr69557976d6.31.1754512676821;
        Wed, 06 Aug 2025 13:37:56 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.159.229])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7097e15f33asm11569336d6.50.2025.08.06.13.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:37:56 -0700 (PDT)
Message-ID: <6893bd24.050a0220.26770a.45b4@mx.google.com>
Date: Wed, 06 Aug 2025 13:37:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5566741532140824214=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/2] Bluetooth: hci_core: Fix using {cis,bis}_capable for current settings
In-Reply-To: <20250806194836.291949-1-luiz.dentz@gmail.com>
References: <20250806194836.291949-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5566741532140824214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=988875

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      24.78 seconds
CheckAllWarning               PASS      27.12 seconds
CheckSparse                   PASS      30.89 seconds
BuildKernel32                 PASS      24.62 seconds
TestRunnerSetup               PASS      484.24 seconds
TestRunner_l2cap-tester       PASS      25.14 seconds
TestRunner_iso-tester         PASS      38.15 seconds
TestRunner_bnep-tester        PASS      6.05 seconds
TestRunner_mgmt-tester        FAIL      128.82 seconds
TestRunner_rfcomm-tester      PASS      9.59 seconds
TestRunner_sco-tester         PASS      14.87 seconds
TestRunner_ioctl-tester       PASS      10.17 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.33 seconds
IncrementalBuild              PENDING   0.91 seconds

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
Total: 490, Passed: 481 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Add Ext Advertising - Success 22 (LE -> off, Remove) Failed       0.136 seconds
Set Device ID - Power off and Power on               Failed       0.125 seconds
Set Device ID - SSP off and Power on                 Failed       0.124 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.213 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.145 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.028 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5566741532140824214==--
