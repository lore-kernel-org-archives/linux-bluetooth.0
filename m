Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44821D587
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688442; cv=none; b=AkXeIaKbww0KhxzYWRXWADYUuVwOennuKk7V/+AFTBQbbptw+x0Sv20bhCDr/7v7snqfPFOZKQDrNd6nSSHMO2BzeXwTxT7mmowp3iQMF2U5kESLm6qa2MvQrjDutOu0OgYNtroMVaEb6+rCHNBbk7QDT8hjMvLvUMCLPR+SCB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688442; c=relaxed/simple;
	bh=iFOpjvW3OpvjpyIJCUEqMmTEV66IWNN3qye9wfOqJYM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FMwJXeLtMNZazPKkGYvWdmPOqfcYXAHwXiZKw/ykTWGl5b5R7aGS2dEUwKIM+dEhQF1P/GheqBFBji+QcXAHsCwOSSAL+wGXEfmwqC+xtFk9jy+0U1TAJXjxeax/3LKOL2QuDepOZLMfcMwcWBFXpX7Pe418fdmQgdRDqTQhRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAmVTDWy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAmVTDWy"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2234e4b079cso26646515ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 12:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740688440; x=1741293240; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yech4EkOOE1WbskPrD+t/3qKI356wvIM4FtVMpqvYYM=;
        b=fAmVTDWyuXkUHLCn+AL6dieP0qv5iLI5l4bVh6xJTE+EEdRSc1SFKuwDeHqZU04KYy
         jqItQV+NFeY0Dgl7Xs/TZw3QktRSVy/OGo2foluLoOSHTRzuuX8NEqpnEBY4rgfNKqIw
         Whzydqo67199lsSX50AvTZbL4VL7I8hr+N22Y29YjraVsm4UMJrVHwitPVFvXPgLxi/b
         LL1y++vuAlzft0m5ZgM+ODWwH281bW/5dWGOxebTGxj5hHtq+66sRR6VpoTzMhsUMhRU
         /acz+yifVrMnUvfNESP/XfEmX6pG03MeeUaOFI+mCKiQIx++X1QCdTqH6QOf6kCEfYxr
         /igQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740688440; x=1741293240;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yech4EkOOE1WbskPrD+t/3qKI356wvIM4FtVMpqvYYM=;
        b=WRE7DWm6n//JN+N2yymKh6EQbwfEokgH2bxc2gzDzvG9/LEFU96t6rXK7ZQSyp+GsP
         Td/XhwD0aVaEkKNsZ5DaGVL6ayzV6EmD1ce0eZy+Dj6mP+v0HjCrKma7O+mEdRZcr2oc
         t08Cnt9b7g91vDNz65vaNMlwuSN7UZfrluYWBie/aUqf5eJ6DEvMj/rY+Z8V5UsuuR5s
         iebz1lzYEFdYBVPasVS1Tl/NfAli3fIrYEotiNDI8R1CLRb4izk0zHunBfnDD0xOqGJJ
         pRnPqJZ2gysllQijw37j3GvwQsTljEpoGpce/F61oXLbJCCL4Ruenf+eKH/BM85Dvdyf
         eLxQ==
X-Gm-Message-State: AOJu0YxsyH9xvhHUVQ8r/T6x82NqVScftd62L80ZxYo9a1B24nFiWn4a
	d2dg+RGWFwyC20XslPd6VWZT9lUL1HNHlA1+rCCr6qimyFLMrJtgOpXFFA==
X-Gm-Gg: ASbGncsa8rpMItcdWxoTaQsJCUIItUK9D1ZrIE9mwiXSPWAj2xT8h9uGx52Ra9mBNd/
	HbZuzExitUXMqdEYqYKLIy+i4WshixwnJxYRwCwTHQt2kNXjoDUYQzQ124uXaILV3RRIWfOF5zO
	w9f1PCEgvEpR3HXiE0pIHdVwafzfkdDzsz+yVyR+2bzqZEFc/8p+PbLMxS4OtMGFgqO41xyYlj5
	Ln/MNSvFBJvepwIXdFOaNsvd2iOJElD8HsFGBIOqNqcKn5z8nrKrRdS+k815fNu1JNFkAoy8AK+
	CPIZcX2qzDX5tfeXypjOUruyTJPS6/OWHQ==
X-Google-Smtp-Source: AGHT+IHYQP0rpiwkX0p4FO/kMyLge1Cz/84caBeTC6teC1hKPs1fkcgcHAcal9M1rraHXn2MOJS4qQ==
X-Received: by 2002:a05:6a00:995:b0:734:9cc:a6e4 with SMTP id d2e1a72fcca58-734ac45bb10mr1055694b3a.21.1740688439308;
        Thu, 27 Feb 2025 12:33:59 -0800 (PST)
Received: from [172.17.0.2] ([20.171.103.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a005fe68sm2196743b3a.174.2025.02.27.12.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 12:33:58 -0800 (PST)
Message-ID: <67c0cc36.a70a0220.1c5bc9.437f@mx.google.com>
Date: Thu, 27 Feb 2025 12:33:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6866260109554098497=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: SCO: fix sco_conn refcounting on sco_conn_ready
In-Reply-To: <dd9eaa0aee1e2fbeeb2015b807a3a2701af3a1bf.1740686998.git.pav@iki.fi>
References: <dd9eaa0aee1e2fbeeb2015b807a3a2701af3a1bf.1740686998.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6866260109554098497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=938683

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.55 seconds
CheckAllWarning               PASS      26.91 seconds
CheckSparse                   WARNING   30.18 seconds
BuildKernel32                 PASS      24.02 seconds
TestRunnerSetup               PASS      431.58 seconds
TestRunner_l2cap-tester       PASS      25.21 seconds
TestRunner_iso-tester         PASS      32.05 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        FAIL      122.21 seconds
TestRunner_rfcomm-tester      PASS      7.90 seconds
TestRunner_sco-tester         PASS      11.65 seconds
TestRunner_ioctl-tester       PASS      8.46 seconds
TestRunner_mesh-tester        FAIL      6.27 seconds
TestRunner_smp-tester         PASS      7.25 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PENDING   0.65 seconds

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
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.170 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.146 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.198 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.112 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6866260109554098497==--
