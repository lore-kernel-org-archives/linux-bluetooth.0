Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0CB3ECBFD
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938226; cv=none; b=KuZwIEjUJdYFfWe7i+KgLH+WmWc62pLy9Jq7Op4I/jY5Y06l4MtB3QZI5iWA9oK2PHZgY5gOtq5SvI0i/LXgldbAGpMiJOHsLEZj8Q5FhPbRt2iHOww355hKQew+vzZnOlniACahbNQ2Mhv+bUTcC9mJHqE0lY8UnH/qz/eW0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938226; c=relaxed/simple;
	bh=pm9D5nO6l8kPFW2R/DCVaiFlkslGPsEU2gOp77BF5gs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tJhr9ubZWC1OQ5NmOUMsn2pnr5vn3vS4m0RLzExk7s9w+g0NkVhEByWmjcRfTe5fU4CqK4Peab+XNqewY+PlHlVuIGjMdwpG0Ufa++TMtOyOK6eSoyhWNprN6m3+Q6pgi51Di4RDc6pZA5xf1OcVRDl0Z6OeJMM2nMIiqGPn0h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWMuulyU; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWMuulyU"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-46704fbf62dso817564b6e.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773938218; x=1774543018; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FtzUeLy4bleHQoODifr97HPSLgUJxBiJ901fr5Jiq7s=;
        b=jWMuulyUH4mszy4Ed6ByY2LWmhXlRkrZdrtFDuTRVitBZkmMKqcJuW61duWwEZBjTz
         OLwYr69pfGMEdMiPkHJBNk/UskyMm0CO3hH82fFCe6DhlZCDEiYy8jiBg83Imtw11KDY
         Psi0pnQQSNo0NbK/YN4b7qkxIFhZ9wRHmK1KJOpx2R3PeOE94yJDpGw1Akx8ixxYssIn
         gYZR4FmqYCpH9ya8n5NEt+9Z8Zqldh6ZBooT0d6nAUq3SQjTuKmo3NpxoV0xCPTLy4WA
         1RyQqxUwmU0g1sRh+X1Z6Z+gJR3IkamWDqFp32A/0H7M24yOqk2ziSeRofsEwaMW4rnm
         wHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773938218; x=1774543018;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtzUeLy4bleHQoODifr97HPSLgUJxBiJ901fr5Jiq7s=;
        b=rZDJ66KSpoWeNNz3lQ98rNEqkK/No/KpgYjl1wiChqfFcwNE5X1SHlURhqwsqfWB5p
         Jb7g6+f2cN6p/pMeyFQjUB7VA/7K6AvGeMw9OaDa452PkS6H0bro1uwvsFNvwcnksD8c
         tXxerVpHq510b/YW3Z1nqmF2Fwi40Pw5Pg3tiXH/GxZbyA9609tbmpwX5wiJ3vSHHimj
         AFlGL6HFrDpNROBErs/B2flfEKn8GtLs/x3pXxNrJx1/2X7Xrit2YrajfojQSqV0tcii
         oAAUUyXPAVOdUxcTq/C5tFXC2mHknHzPGOHjoMCDeKNXsr0QrlyPN1qhYBgj8tICsfLq
         5L9g==
X-Gm-Message-State: AOJu0Yw5l84EL5T+OIfiJNpcXlJgP3JtfddXonByoPiTBQ/bHdCkO3J4
	EWTOZfYIgrieB68CZDl+GwkPmlEPTiDzJ2Jc+eS5kHGJebAHGDDNiU5hJpYVrQ==
X-Gm-Gg: ATEYQzzFF0mzHdB35fLRvkVsD9gj5nXK3HnuHHh+uVSRszenxJKxX4LsoVgGR3bgsdq
	9FjqTSYcEFzCZwdA2rdgEwzFIuLJtX0Sdfn9O1aHi98pAZwIIngwsOZOZuu30EuM/kr/sLPpe5I
	8QM6/JtndQNLwJw+M+/xgoGIIaOcYlQfk/HxA2EHhSr9f15A48tuupowGSuFyODz898gSDNT53i
	9xaj9TYnZ/GlVxik+13CgM9P3X6J3UaXwdM2PARVyKTzZ6H9CeRF2jaE6eQtY84oty/s1CzVIkw
	Za/8gqibZW09lt1LtbJhY0IJ8vj3TF07ICBNZKTyvpL1dHApVFsQHsrVwvoOHCPCqDIIT4My3pc
	Jwj1Fkb/p+0UJuhJQrQwgyaFmdkiwk5ruxd6ZW8bDSwCidsDQ1LqPg9FHQLmkInmBnTzx48oCvH
	8sR7zuCKUbQ8gwu21x05YvWjf14g2+iQ==
X-Received: by 2002:a05:6808:f8f:b0:467:91:fb32 with SMTP id 5614622812f47-467ba3069cemr4905075b6e.39.1773938218098;
        Thu, 19 Mar 2026 09:36:58 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.82.138])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd288c59esm5665381fac.5.2026.03.19.09.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:36:57 -0700 (PDT)
Message-ID: <69bc2629.050a0220.274eff.14c6@mx.google.com>
Date: Thu, 19 Mar 2026 09:36:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3474256948901904226=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: RE: Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() to prevent infinite loop
In-Reply-To: <abwS8q6yvVAGI-ci@v4bel>
References: <abwS8q6yvVAGI-ci@v4bel>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3474256948901904226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069345

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.83 seconds
CheckAllWarning               PASS      29.62 seconds
CheckSparse                   PASS      28.26 seconds
BuildKernel32                 PASS      26.29 seconds
TestRunnerSetup               PASS      577.55 seconds
TestRunner_l2cap-tester       PASS      28.22 seconds
TestRunner_iso-tester         FAIL      31.50 seconds
TestRunner_bnep-tester        PASS      6.50 seconds
TestRunner_mgmt-tester        FAIL      116.17 seconds
TestRunner_rfcomm-tester      PASS      9.57 seconds
TestRunner_sco-tester         FAIL      14.52 seconds
TestRunner_ioctl-tester       PASS      10.52 seconds
TestRunner_mesh-tester        FAIL      12.56 seconds
TestRunner_smp-tester         PASS      8.64 seconds
TestRunner_userchan-tester    PASS      6.93 seconds
IncrementalBuild              PENDING   0.95 seconds

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
Mesh - Send cancel - 1                               Timed out    2.614 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3474256948901904226==--
