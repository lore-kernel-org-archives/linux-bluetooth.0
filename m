Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8E3A6402
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845012; cv=none; b=VtIPoZFGmyui6o0F+u+moU51HGTcQy0DDHZLqFHGhHuWyNsUEH+q/rFrP5OBex17qYoSa7x/WjKdhYoB2vTbi3wejNN01LUpN+xnQpy5yCUTMr3xLJcK7huXRTIZ06IFFwWsX+87CcbGP8QPX1onwPAQmooW4eQxndu0YlfCuNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845012; c=relaxed/simple;
	bh=IfZ7Tgw6Fvn2J8Y0C8UttdLWaEE85Dv7qkOLwfuuyLs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h/kglZK2gCJyc6vztbKriUMOxbixpjFt527xgLtTglVITjDayXtptwkxx0zfF6udi6/sjlHjvZY8412M704wLdtr1ZsWZhoo+1anBCj7qxevdU26BJ/bsCjzp8Y4wDB7l6A71GXHn8WyrStiJPaZ3We6TGyRbBJCxETd4t0SGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0ZZqDQQ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0ZZqDQQ"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d74aa6bcdbso4249941a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 07:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773845009; x=1774449809; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iMDbcWN/l/itBJEjktknge47vrlvsISRkjQgdP6QzGI=;
        b=a0ZZqDQQCOcOTMMqwiYXCAHb6tm7G8jaIhdP8Dx3utWZjqx3C9p2aIhi2XEoBHOrb0
         nwoGKiO1Me6apYGzvqWdXnwJH+n95HSdGiS8frpXpHGmoVbHoetqh2kQnq9x+OJ5+aq2
         KnYOz8i3vMBUiRYx6WKhKp4en+RQR2kZZYikRh5Bs05c/rrW1iU0LP7QqWdvdLRP5THb
         62Ul7kKqpet1uHYfLH+VOk0BBqalBmsS8tD3d+L1HPWjITnAa0VYpLUPYH4DaPzZcNZz
         +anaDs+vfygj8MLS1rEN+XmcejdXMZ0hF2lL0Hvf7BfV1fgRvUWMvgQmhlS9zeTXtwaO
         iTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845009; x=1774449809;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMDbcWN/l/itBJEjktknge47vrlvsISRkjQgdP6QzGI=;
        b=PsZPs4D5Eufgd20Tt372ZFHRcOGbYm5CxdhNGWk70MU8M8qyPjYLHY3e7cl1VcABM/
         568g6mm/s5ZDyQy3UQdz9Tjh0ppDHsKquq3gAmvoSy/0n3+v063tZvXkT82WLwNFCk8+
         GCvMH59RhhBi3HQFufT1W+wawLe3xj0ImauNCpgpLTA8Oati57Go/W7BdWFk3qi0jjiE
         3+QEX0iOFopfhnun97a2CcQAo3Y1N3qlSagnayEI2L7CR8lz5WtgfzQGCw15qe+eMUkS
         gKtIxZN9RRLgjmFmUmrefHt09il9zZRrC2AoP4VkGvv+gUsUVZ/tGF6UkTbRNJcbyhCp
         0vxw==
X-Gm-Message-State: AOJu0YyvjHQbdhJQXfI2i52myAICtzuzczEcYhyBzfb/pgMC1KSw+t7z
	lFh3KAbvv+qwS1eT0sL7TdSiFiuHq3N0+zPwgn2M3JsCIVdFJG062WcA4+HJXA==
X-Gm-Gg: ATEYQzz62GuE1nv4rp3W8Gd/ESVbn6Uw8E2iXBijhlXXs73zzaZolsjKg/2MXWzzkOL
	GZLgjPxgX7YkqI8f2WooDOqCJmj0Yi76mW13D5OXCUuU3xz1lgvJ8sPq5DaZfP9N+PaCstRfQjm
	rGrDQfS4X+gygEg2WeJz7K8jLyezqAE/xEXqXY8FVUBV+l6xYrZaFyCCGJkrsUJk6rM06ikk6FT
	zoPPRvsSmx/L2Flsh2x7yQrtGxltFT71cOepL2fi0pzwQwEnzAZ2LmINPgnNp6KrIaBjfgC8Nkb
	bFk0g3eTMXkblNg/BxOP+0d0GsF6Nb2ebWOAXDvOiDn+FvMX3fRjyUlo+3Va0TJKzeWeLt6jxkS
	+BF3G6HBHfIT4OwvdkLG/nbf9nPq455U6Y7SP2SmFvMHpf2gpvqCvJbGyhxWrB7Qh6HNtxavZ5y
	pHGtqY7tlNqLRk8gNgb7VWzPHUj4JTtg==
X-Received: by 2002:a05:6830:4886:b0:7d7:d524:a558 with SMTP id 46e09a7af769-7d7d524a69fmr599166a34.11.1773845009117;
        Wed, 18 Mar 2026 07:43:29 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.131.101])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9b38fbbsm2161458a34.13.2026.03.18.07.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:43:28 -0700 (PDT)
Message-ID: <69baba10.9d0a0220.165cdc.6956@mx.google.com>
Date: Wed, 18 Mar 2026 07:43:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3695938856790105956=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: [v2] Bluetooth: btintel: serialize btintel_hw_error() with hci_req_sync_lock
In-Reply-To: <20260318125403.3135972-1-zzzccc427@gmail.com>
References: <20260318125403.3135972-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3695938856790105956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1068649

---Test result---

Test Summary:
CheckPatch                    PENDING   0.58 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      27.17 seconds
CheckAllWarning               PASS      29.65 seconds
CheckSparse                   PASS      28.44 seconds
BuildKernel32                 PASS      26.84 seconds
TestRunnerSetup               PASS      584.05 seconds
TestRunner_l2cap-tester       PASS      28.26 seconds
TestRunner_iso-tester         FAIL      32.95 seconds
TestRunner_bnep-tester        PASS      6.39 seconds
TestRunner_mgmt-tester        FAIL      117.46 seconds
TestRunner_rfcomm-tester      PASS      9.95 seconds
TestRunner_sco-tester         FAIL      14.94 seconds
TestRunner_ioctl-tester       PASS      10.54 seconds
TestRunner_mesh-tester        FAIL      12.49 seconds
TestRunner_smp-tester         PASS      8.79 seconds
TestRunner_userchan-tester    PASS      6.97 seconds
IncrementalBuild              PENDING   0.88 seconds

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
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.109 seconds
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
Mesh - Send cancel - 1                               Timed out    2.600 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3695938856790105956==--
