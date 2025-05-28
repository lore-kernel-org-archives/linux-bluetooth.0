Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1131F461A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748459339; cv=none; b=eR9JO2ObrdTG6CIXqkAcNuO48imLHzh3oo985AfcDm8n1T9XYouoqkugDabQ/hreI4gCCCj/OA8DIuMHnquTpR9gAxcERZwlrCOdl4z/YuDQkg/5V7FgvC7VkpmkcTsk96y/9JRblnlBdj2ge3BHom2qxxhuFv0Ucic9MMVyOJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748459339; c=relaxed/simple;
	bh=Srk9+yyJ1Nnixi4odoaPr4DRoUPirCvui2XkXj9D9PQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SoFYtZW6NtHZF1XejtciCwN+I3ykhjbmjO9nmsjulNxHEmU0xdUB91BD+kqGWFoNac5xL+Nq7B2UXq+4VoVF2DzcZm1UuJvPzygBAXnolk/PRrGPUhy7ToxFGYcnUueHqhs8a8jHZP3IfAJoRklC6HbH1Qli8BHJmE9XJ+NA5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l60f3Gs2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l60f3Gs2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2347d505445so1898745ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748459336; x=1749064136; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hO/vCQ+GoP1RzbAl9QqyE74EeCwYZvM/1T+/BqesqGo=;
        b=l60f3Gs2OMMr8Ql+pdsgDukmfmYHafGxNd+65xYTZacHLUEG1RDUSByFt1dihAW4sp
         YI4QT6CO1MP2Tgaen/SzAnEnXp4XEwVpxENbrqVdDyvOY2VtT48Dxbc5/zJqLxmzEM2F
         0zXSEe3XI1L3eJ31CgbBHewBYCuZd9zkRTV8YUPWuYu0/lRmmqVKKBqNBH2DPgtP3nvQ
         NYEjpdXTyVmhaYMRvNv1Yb0shGl3/Z+eQ7xwXfdLEu7V3lQSs1pF74QH4GZlJUbejEdX
         JfU4kLjNKFuUL++MUmegd7O5LEHGStkvr2CB52nGbwEJOi4VAjKoOP/2nsc4sPz/9UNs
         IgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748459336; x=1749064136;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hO/vCQ+GoP1RzbAl9QqyE74EeCwYZvM/1T+/BqesqGo=;
        b=eMUOSquhqhsxwurU5xxJWUgkO4w47dLj/Nlq8Bpp34Lzpf2MNhoVGu99OaqjjttoMD
         PIkc3mb0ORc+WNbV2931YwDM4wQOpN+CANWrP4eQPntKpv+xYg1I5pnsJzygahEhGjzj
         Cff9+sVzuJlttiouIKLEWooouVduyOCD/rzn2fTLq2aMHB7ac9JgLJA/l4hdlpQwU0Gx
         iA9n8UiHSpmmfhV2cL+AhFjtUOijXduRXNLN0i0pvWx4/rhH3KIdhI0PeHDHeIpwOCx/
         cCj8XrjmHBDK2UummLkfBbhG2PwdGGWpcZ6dXQl90gfk2eHpI6MGXoDru1TSVVhdFGOm
         /+PQ==
X-Gm-Message-State: AOJu0YzDmnMleYYfVmg2NlRoAfOC/eskpaRPcPfAH3tbq1dOhvsxc5iG
	4v+G8QanWoSRtGAE2imVH9YEAsSnzNwihhf2DFoAJZhdWz/CMTx4TbKtmFVGeA==
X-Gm-Gg: ASbGnctsDfAT55DYmm4u150Z0fgZzvyF9gxV7sA3rvU58XRAEZbBgyIg+Njofu2SDD9
	PvbcgVe3e+vw/O5cfVF4W/ccBGckUaZOKqezZ0Alqw4VSufB6xtYpKQ5sigABdjJGT8AMkHMG1X
	/cSJC+R12OYydcBDABBXGcpzbJCEmAlcVofgnGMQQWNiVV/GHULq2mpoVihyygRR6xNJgl14d15
	GEERYRB+oyKf2to1TSBhHxIRgcFYtVCjpvVnnAxU0sbWeGxfN4gPU+ZXlTq/3QgYMcsMEgDts5c
	Pi1uzYftnYCLzdBvUUSG5cHr9YP15GCsFNKoGupovPnB7QFeUeY5Ahu5rA==
X-Google-Smtp-Source: AGHT+IHNq3ZM5DaL2NbtlWElyC9260G1QmsmY5jSROoaWklf85wUlYipXx0mz1XK4Ls5zLwEhldp3w==
X-Received: by 2002:a17:903:4405:b0:234:e8db:431d with SMTP id d9443c01a7336-234e8db43d4mr24209615ad.20.1748459335978;
        Wed, 28 May 2025 12:08:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.29.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d3590de0sm15133205ad.156.2025.05.28.12.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:08:55 -0700 (PDT)
Message-ID: <68375f47.170a0220.1276eb.ae2b@mx.google.com>
Date: Wed, 28 May 2025 12:08:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8484679580338175900=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: MGMT: Use RCU-protected in mgmt_pending list
In-Reply-To: <20250528184441.538069-1-luiz.dentz@gmail.com>
References: <20250528184441.538069-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8484679580338175900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=967103

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.39 seconds
CheckAllWarning               PASS      26.89 seconds
CheckSparse                   PASS      30.18 seconds
BuildKernel32                 PASS      24.17 seconds
TestRunnerSetup               PASS      458.19 seconds
TestRunner_l2cap-tester       PASS      25.53 seconds
TestRunner_iso-tester         PASS      55.87 seconds
TestRunner_bnep-tester        PASS      5.78 seconds
TestRunner_mgmt-tester        FAIL      156.18 seconds
TestRunner_rfcomm-tester      PASS      50.24 seconds
TestRunner_sco-tester         PASS      55.79 seconds
TestRunner_ioctl-tester       PASS      9.90 seconds
TestRunner_mesh-tester        FAIL      7.41 seconds
TestRunner_smp-tester         PASS      8.43 seconds
TestRunner_userchan-tester    PASS      6.00 seconds
IncrementalBuild              PENDING   0.94 seconds

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
Total: 490, Passed: 470 (95.9%), Failed: 17, Not Run: 3

Failed Test Cases
Stop Discovery - Success 1                           Failed       0.155 seconds
Pairing Acceptor - SMP over BR/EDR 2                 Timed out    2.503 seconds
Add Ext Advertising - Success 1 (Powered, Add Adv Inst) Failed       0.133 seconds
Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok) Failed       0.128 seconds
Add Ext Advertising - Success 9 (General Discov Flag) Failed       2.153 seconds
Add Ext Advertising - Success 10 (Limited Discov Flag) Failed       0.140 seconds
Stop Discovery - (Ext Scan Disable)                  Failed       0.154 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.202 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.235 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.184 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.177 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.209 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.268 seconds
LL Privacy - Remove Device 1 (Remove from AL)        Timed out    2.687 seconds
LL Privacy - Remove Device 2 (Remove from RL)        Timed out    1.992 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.748 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.165 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76b/0x7d0
WARNING: CPU: 0 PID: 66 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.135 seconds
Mesh - Send cancel - 2                               Failed       0.177 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8484679580338175900==--
