Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673621946BC
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770762449; cv=none; b=NywJjPnyh3AJBpbkz6Su0dCQCErawlTTevH6pcUWxqVuu0jmaRne2Lpna4anCc3SHD+/4fbjZYaPmQfxv9Q5I0vICdzcm3VhlW2p/VfWdf8fSoULDOFG+8LOHCB8j62EAyJM4h/SZuMNA8eHETO4jpTxy43OAJzb1ejgV6HKUpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770762449; c=relaxed/simple;
	bh=9F7G8BwIEOPyks89gVVg6rinpESfE6My45evZSy2pw8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Q1cg1Nb4ROr5hrtzd38t9EYWIXZcd8mf9VtrQ2kS7kGEIO0eF1xqwI5yRsOD2dx7z4v1Cf04fCmns6R80lxDUREzsq1XuRVEzjPw/i5dHqCfCErQ0/GESk022d0u5FVKOg8cEatGivo222Y1kuxrTDTAAPhvu1QU86P7uMtJulw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6R8WMwJ; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6R8WMwJ"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-897023602b1so17620116d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 14:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770762447; x=1771367247; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V5+/Ej5q1ihP+3ilkZtNwW4NYBwRVTB5cg35VjMmx4w=;
        b=Z6R8WMwJI2yMI8TfeDNH2Bl1VTIsII+rU8pg3GfZtGzGqMvhlbRMq+7IEaP0XNwXUQ
         zU/0WFRHQFkmLe/Y652KmkAKCr7Kq+Lt2raDhvQNOqSk0ZJFEKnAnDsZKnl99c7fxEUP
         sxChruxpu6aubuXb87Jp+vwc2b2JTpKYy7hxO/qY0Wwo3EvC7ll4JEpGCwzGfFSItmqm
         jUcah/MuBBEPkGsg7kQKthJFHFROC2DihZLSyaZ/COf0Dc349Uo3JrpWA3pV9qBLqmmG
         FV+jP8WrGoL37Vb2lrIVpD6F7uQGSmCswGcCuZs00UiF6CSBsXvmtoiHNJnv1ZGUVkT9
         bdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770762447; x=1771367247;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5+/Ej5q1ihP+3ilkZtNwW4NYBwRVTB5cg35VjMmx4w=;
        b=qYyjw/ptlWVHpYsPF5dRQBeZYtsd1FqiTFb4UmdgmqV6ert21FcvtBRYEzsjUg/Fuo
         Fa8Vpiuk/5A4MVP+fn33dfZvlu5IrM3zyLrqozH3Edi09qSCDngAVLKyq/V1RDtmzfJe
         9cUPDDh+16P5m4ClwUYQi5en5JWNaWALW5mAvVTr/wXS1V5hABxDYGFKKnrAxFnlwuKn
         5RL5SeS880vRjhz0SvsYW0t0P1oomXhZU0yKSClGk7Gokg049fSfjm9mVS2YgeRQhXra
         wWsrZMUL4yZ1GXjImjhSkYGkyVfghSY/fInAHEyCP5y5IvhxkU6F7uymS1LPnfAfDAVl
         n05g==
X-Gm-Message-State: AOJu0YzkfTAW1qdh6EJ+ZPnsQMZAECEVrx3q2yGcN9JdXpykptanqBw4
	btBCSxX6/EIDcFRL2aWHaUe/PTuRZOMx2hxzbtIkULrKUWXEjv9Nqnt1I+ADasPf
X-Gm-Gg: AZuq6aIYOtmFG9sDJott+iNCdTRzXPccJH41qkc3u2Qf+K3nxrpPJuoVyPtK9LwFJa7
	osFZbT7vU5bI8jZb2F8mhO2rig5+y3OGCbV97rxWoBil6qUrG3EA38k+1yBhAvsU0dc43bO7Gpf
	s+bWL5bnKi6Ah7XxITyEcv6ehvE5EykpYgXlOFHyDuZEX/0SIpxt+1BBcDR/E1w6aELqw3kKSlQ
	joaumy4gjyGy7M3dY/ucITJ81N/+3BUIxIhJ3gy9uja5y6mFdxEdK/YqqbhPLGfzmqFxuV00pmc
	SkKU+0LdkYpcNC9cgQ935s+2ftsSPNqzytL1ALaAIG1l30ie5O/A+v+yUp/G0i9Kv3iaaIEqmJD
	Vguc4NdFntHXIGYssnvEfAEv5K/ucBLAnEimpdyzcWB73HctsS/QdN0AsByNSQWPkUZvzbCMoz3
	9noXUfzsi4cgHvdEamEhsZJ/oLe0HPkQs=
X-Received: by 2002:a05:6214:2123:b0:895:d652:e3a5 with SMTP id 6a1803df08f44-895d652e4c5mr181926756d6.23.1770762447051;
        Tue, 10 Feb 2026 14:27:27 -0800 (PST)
Received: from [172.17.0.2] ([145.132.102.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50682edecd8sm621631cf.5.2026.02.10.14.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 14:27:26 -0800 (PST)
Message-ID: <698bb0ce.c80a0220.33fe0f.e15f@mx.google.com>
Date: Tue, 10 Feb 2026 14:27:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7222303988389113786=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
In-Reply-To: <20260210212722.1250596-1-luiz.dentz@gmail.com>
References: <20260210212722.1250596-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7222303988389113786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1052898

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.58 seconds
CheckAllWarning               PASS      27.97 seconds
CheckSparse                   WARNING   31.73 seconds
BuildKernel32                 PASS      24.92 seconds
TestRunnerSetup               PASS      554.47 seconds
TestRunner_l2cap-tester       PASS      27.83 seconds
TestRunner_iso-tester         PASS      73.62 seconds
TestRunner_bnep-tester        PASS      6.46 seconds
TestRunner_mgmt-tester        FAIL      117.39 seconds
TestRunner_rfcomm-tester      PASS      9.64 seconds
TestRunner_sco-tester         FAIL      14.43 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.62 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.68 seconds

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
net/bluetooth/l2cap_core.c:7764:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7765:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7767:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7768:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.856 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7222303988389113786==--
