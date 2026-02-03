Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F8D2F9D85
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770104914; cv=none; b=mIEW/+AzfxLDH7kWtFPbSRz+67CpG/Pt5jiq8eLV1YgWF7WSd8G2/UVC/n+uvQnDmP5Wa4e5tIQVLIKaisen1JhL1yNk+uuL7/9gkDEV345EAwYRsHZGkBy+tsoC+43zllWkkqTfnwGmWhJBD6mj73bkDxB0StNJTTrSN6aWt9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770104914; c=relaxed/simple;
	bh=P249j/pChDGJJS2JS62VikrwnYa7YggEOknny1IoTTA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IMaapVx1IOJUTvoxTrsckQyci2NHffnaDuqtuXhkiicZ0oWDmthyy6KjabmIwytqNCOg9AMG8qFkC77siLX7X1pynWlobwnMrIc5entACft+QTChlyR/Fp0emnv8GZspk/JGC+xoiS872KwBYCCG4gs3/zSbTdjSl2WfF0Vj2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQb8onrq; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQb8onrq"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-895071c5527so30117776d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Feb 2026 23:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770104912; x=1770709712; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=st7CgDXzFjC3ezPQos7YeRyqJ+xD8tUmGbJO6eJH1uE=;
        b=YQb8onrqbqVj9tnSqXA9B17IwqEXjU4jj0OsAildtlG4+ozJzru4SfvDMuNgoMNVYy
         WMNBlYemAu7HsdA1cUzTM00z/3de6tRAtoWpVUCRpwEsePNvi6b0QBLkSJywWObv6Vi1
         0kV2s3A3VK3q6XQTd4WGPLxq3pj7/r0N+mdXLDu+hTmbPIRKZwQOLv4fa0P4doNiM/YW
         sNVRtSHYWEcYxrQqh8bqzyVgi6EMMR85cRvt1I9ybSNcP0ENQWZSBYHpi4aUmRl3sWXF
         xaTy8ZVETfRrVjiBdyJ2O6vkwq3RruNEpgjHGdIf44QFol3raFlXcR1BxvLVpvySl8Oa
         tP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770104912; x=1770709712;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st7CgDXzFjC3ezPQos7YeRyqJ+xD8tUmGbJO6eJH1uE=;
        b=N2tTeqIFGR/8WKtFdNsh3Jkh0bgcKzlpcw/Ft1baATm7AyBCvJrArybGX+dLt/wcYB
         QbGIHNOTZsA28r00CSc4ZUsVDanhyMoY7HiIYK4tU9xgKT0F7qLJDBeA2qEym5HWTuAT
         Gken1ajXK523tpm2xowrg/1tcnbYULxPJ94qWpEo23tvSCJcH5SV8LmZVjVDsjlXnVST
         0s+zxKjUkdeZERnwZojrT4+Ex/8PLGo6rYffoYnW8j6PT6cBIt+TYjj2fxXu07X1QZ+L
         /QMVXI6VrykzKGxHuUDmIsNFs/WObQ1L4IyTu/yjZZEpRDDGAWBL8baLerkTZlI+pvia
         7YTw==
X-Gm-Message-State: AOJu0YzWS8nCjCZUiIxqiDeM5Axgfluo1C9H2BKwPUJCpFCDoRMz9crK
	BFyQ47vaF/ArK1WcBA5/Ktsck/SZxNtjF5563TVjlkCjhXyT3Hy4naushN9DDP8i
X-Gm-Gg: AZuq6aKM5k4N/ZJiFamUGebujbTph86lehiHM6+gaa9Uat8xuvIZDvLZRq6NSkoiFnY
	kYY/d6dJ0FKrmAXLtodVgqcERle1UfAFeJkCCQWjP9sjeww4Bm0Csqszf6wcKC/oHtYFokwCJfr
	TU3geWSaG0fBSfkpU5336oK6iS/36OU6V4eA+obsRjxApSSMN4gGlT9/UclMtANz4T3NoR/8gW/
	FAKRzDo0leuP3tzsWVYF0FBg55KwRoz4kjE9HgKwBk7EgpqG0HkwCr9fHQfWUNwHcUqlWazj450
	Zqymb54x/TCFuQ7pv3GLs5zRuHdTdimbebUzhKzqILg0Fdh4R5UaDcTnf5mQW08QK4YFywQBxut
	MMRiasBj9hm/kGsuC/pdP+NzzzQnuJ8MOLraFszdiCns6WaS7PcNyWDieQboSp8/h/YKZWFH6Ba
	kj0c+cPHQ5icDZKr8=
X-Received: by 2002:ad4:5fce:0:b0:882:4555:f164 with SMTP id 6a1803df08f44-894ea035570mr207295626d6.40.1770104911543;
        Mon, 02 Feb 2026 23:48:31 -0800 (PST)
Received: from [172.17.0.2] ([52.150.28.38])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c448esm131586066d6.14.2026.02.02.23.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 23:48:31 -0800 (PST)
Message-ID: <6981a84f.050a0220.168e4f.6c39@mx.google.com>
Date: Mon, 02 Feb 2026 23:48:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4605448608860796703=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Trigger reset if firmware status is abnormal when
In-Reply-To: <20260203062510.848761-2-chris.lu@mediatek.com>
References: <20260203062510.848761-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4605448608860796703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1050104

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      28.39 seconds
CheckAllWarning               PASS      29.50 seconds
CheckSparse                   WARNING   33.43 seconds
BuildKernel32                 PASS      26.24 seconds
TestRunnerSetup               PASS      569.51 seconds
TestRunner_l2cap-tester       PASS      29.22 seconds
TestRunner_iso-tester         FAIL      85.43 seconds
TestRunner_bnep-tester        PASS      6.51 seconds
TestRunner_mgmt-tester        FAIL      115.40 seconds
TestRunner_rfcomm-tester      PASS      9.87 seconds
TestRunner_sco-tester         FAIL      14.96 seconds
TestRunner_ioctl-tester       PASS      10.51 seconds
TestRunner_mesh-tester        FAIL      12.47 seconds
TestRunner_smp-tester         PASS      8.77 seconds
TestRunner_userchan-tester    PASS      6.84 seconds
IncrementalBuild              PENDING   0.76 seconds

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
drivers/bluetooth/btmtk.c:1507:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1508:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1509:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1510:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1511:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1511:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1512:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1513:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1514:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1515:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1516:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1517:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1507:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1508:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1509:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1510:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1511:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1511:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1512:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1513:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1514:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1515:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1516:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1517:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1507:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1508:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1509:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1510:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1511:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1511:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1512:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1513:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1514:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1515:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1516:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1517:1: error: bad constant expression
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    2.624 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4605448608860796703==--
