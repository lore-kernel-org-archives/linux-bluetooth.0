Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137705B21A
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 04:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550680; cv=none; b=C4lw53eIWfv46A+7qMD2z6xVqD4KJmSLfx68nEF8RIJVQOB6m4x8ZtiMYAZaE63UWshxA10vvEylv6fYBug8iItiM3IJgKM5OUXFl/bC0Yw5AYLx9yqYSxsh1caiZrYcGei2qSvzdrEYbIMBxVZsN8XnU3gO0GxpXYJ6fI5N8B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550680; c=relaxed/simple;
	bh=MmDxRyIngOY38JRpGnhFIcUUvQdpnv26muMbzFOETJM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hiDW3dg+NxWqQhFYDiWaKHEg6CKDzwdX09mLt82anTLv9XZBVIyj8EcmmooZKw24mdESQvdceZQTn0VxZQAmZnIcDPOigltr3dK1GUhcB/UbgplX8Nx/Yocf+i4avmGuLjJw4qIkzr0QDGaLJ8vuG817HAi9Vx7xe4wEnH6a6Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCxmzKgi; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCxmzKgi"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-88a2f2e5445so68301856d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 20:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766550678; x=1767155478; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLPj6IKVjhiHnjNVHu/cXedls6StOdYknxDbDZ80mCQ=;
        b=OCxmzKgi9zgdeGKJ2RksgjYlqgwcejZ74YWoayIOuNhA+WTRi/ROvL9F0UCrNBjMgn
         JcKNo2WrReVl6t9SgwuQwbXO0kjKJRDS96k4ZjmHEx4Clkre85SD8EZeNtNCETOpaeyP
         nY2gmNoMOWZEZGNX2ltOchWx/enR0UbBnaeTyuQrD9/vfBzB67aKtkSLkgm21SRYqRIs
         4upff621PY6Nb8nQXpz9ZSojLc0L6KxD+Sw9Z0SSW+3pO8JNaKdbJuDZwBxh0wUIS/p0
         lF+GBjgqy+Enp/RKDHqwA7Dawnu/W+/HFKNC+Gxn3TTpcAaHGaawBDdjOX4eJzdaD+1+
         JsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766550678; x=1767155478;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLPj6IKVjhiHnjNVHu/cXedls6StOdYknxDbDZ80mCQ=;
        b=ib0Fr5E4xoSAxXtRopMZcAixITJujC1SdYdtLYbNqE/kbnCmjEHTQl5xOr36gS1lzi
         jYRRtKr4r+XQ0X40Npq0Sy3YYtMMvWy8dtJCakw1e4wn02B7wf2PepETS7jDXCwnNEpu
         YI/gyXXEEP6f4/pDUQViwAVksQIXHtucdBA3exypOgG8O3YuItpItc1DEl047Zksgbl+
         /wW46ytpF6DnEvCkiKDUCdao+pY539eFP0XuCdTkBjyRMRmrVt6P8NOIpJWF76q81LHb
         xlav5mEi5uzOEDlrBC8K1di0KOA/9+cgB/TTuFURKTt3MMPI93MtzNDbl8m5btdsEJLi
         hmgw==
X-Gm-Message-State: AOJu0Yz8wxucNNFzikgQM3EY6xeTHcGHCfpKlIzozhE+Oeu8G35sCfgB
	suisCfaX+BxknvkfnKj99nR7S36co8NZmuuwPMXwgwsfRcvyqF+ZqLDab6jVVPfj
X-Gm-Gg: AY/fxX5xjo+JPvuTumJ6xsjUADtUzvrpYBZkXpD2cuvEdaZnKCG6ohTVNxl/MAoFq6k
	tIjMQzsAC+t68hDzmGR9pgd82vOjn0rWozYojm9t2dO41gsxKesSNQhBEoOaQQMmwZTAUXkH+1c
	s0zr8WrM8SyJT/U+UfUsFwE2oX5oTr8CBKA/rzVKpuec9XPzWsUo3RLGrYoCHANiNA9VszUJGQx
	lJx5YRK3/05JsqaN1rR2b7ZmK0iZQwg/4gDurkaT2JZRMxPyEHPyAM1KU3GLYZLgrV/8bJUkd9I
	29ubCPbaAKu/YJ2AYgMWDZF8iMtzr1UQB5QHb6c/hrqb8UQVbhP70WC5Irm3YwWfRIiMgPuxCQA
	+U8ko4MkpcBj9uc4gwd78C+rNrIMnwWkThMTG/gEpRY0H/jiPXMgLYxNM1wfvfTsW42s5OaS090
	htZieUMLk2xFjWQ7xL
X-Google-Smtp-Source: AGHT+IEO3AUXEKQkm13t7WJmqDLRZoZECSik6y/JJpu9t8IzFtRpChsWTkt3dC84tHXKyJTmgbDPrQ==
X-Received: by 2002:a05:6214:23ce:b0:880:9151:2dfe with SMTP id 6a1803df08f44-88d8369e74bmr229120726d6.44.1766550677737;
        Tue, 23 Dec 2025 20:31:17 -0800 (PST)
Received: from [172.17.0.2] ([64.236.200.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fe52sm117146346d6.11.2025.12.23.20.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 20:31:17 -0800 (PST)
Message-ID: <694b6c95.050a0220.24d8da.a8a0@mx.google.com>
Date: Tue, 23 Dec 2025 20:31:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8751219578032390154=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, techieernie@gmail.com
Subject: RE: [v3,1/1] Bluetooth: btusb: Add USB ID 0489:e112 for Realtek 8851BE
In-Reply-To: <20251224033129.62262-1-techieernie@gmail.com>
References: <20251224033129.62262-1-techieernie@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8751219578032390154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1036260

---Test result---

Test Summary:
CheckPatch                    PENDING   1.01 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.83 seconds
CheckAllWarning               PASS      27.22 seconds
CheckSparse                   PASS      30.64 seconds
BuildKernel32                 PASS      24.64 seconds
TestRunnerSetup               PASS      546.17 seconds
TestRunner_l2cap-tester       PASS      29.59 seconds
TestRunner_iso-tester         PASS      81.21 seconds
TestRunner_bnep-tester        PASS      6.19 seconds
TestRunner_mgmt-tester        FAIL      118.15 seconds
TestRunner_rfcomm-tester      PASS      9.19 seconds
TestRunner_sco-tester         FAIL      14.40 seconds
TestRunner_ioctl-tester       PASS      9.83 seconds
TestRunner_mesh-tester        FAIL      11.38 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.57 seconds
IncrementalBuild              PENDING   0.57 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.191 seconds
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
Mesh - Send cancel - 1                               Timed out    1.948 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8751219578032390154==--
