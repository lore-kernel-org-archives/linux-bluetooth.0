Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A878F36829B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770153983; cv=none; b=k1G766TqqcpSdgKD9Z/TjsUmibKveD9Xfxvqy/m/ruD2PEOV3VXR24fiv09/mhkRykgHRi1WIoaZ1mzJCiIreuyk24h8wjEjBL2Jo/TqimZxdbZZXb9j2FWohTvGzm1PLAthUTWGe4fFA3xuYLn7eC/AlQUQjWvNCFXzo6aF0/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770153983; c=relaxed/simple;
	bh=uAT6fnICmlw5ed+W1qguC3oIYerRmUYx1zLs94aUasw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CP8DtgkJLT1P++jWobGIk2KIxlPobaRJkZXs9eceBYJ+1KjubEoGANi7dgxJYoGUog4p/UH+DFPnX2iroXbR55hTV/R+rSK7q+G0eLOckuId1fBQTc/Hh+by9UeyLZYb7ZFc8Lm1q6QkqNEahMo3TPjoxoWKO2Wgp++Yh7UjBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htxRYYkU; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htxRYYkU"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d196a2334fso244969a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Feb 2026 13:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770153980; x=1770758780; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg3ctGa18WRcH+rCP+WEVXPPYFAwWZQG1eJrJDnWWH0=;
        b=htxRYYkUps2j/yMwA3q4J2FICuuTn2kGOqlpuyDtVaAq9YQ7xg3zZLfaJCixrsRSrm
         VKDOlI7jp4bp46/zeLBq1j8N4kIhoy44ZhlVab7opDhq3Kv+DkIsorl76cH5P8rPvu8v
         gBJP610Dc74z/IdSvwy0ShZWryDYZuSvEy8luo9mD60U9qk2TwkXx1hiP+B1BvceR4Fn
         ST3csrINoL9X0HF2g/lYg6OIir7uy/Lu6aTEvOKdObnM4Y1MRKNJugwJfjl5XoG9MK4L
         9yCMB4po1q8TmNCsjFJl3urEGK1vKYFFEPo2NZADjK9vTvkvZGctEEP+UV8rfsHTV7IP
         gSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770153980; x=1770758780;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg3ctGa18WRcH+rCP+WEVXPPYFAwWZQG1eJrJDnWWH0=;
        b=qJb4Bxo02xsBcz149bMS0PZb/GbntpIA0WW9tDDCydRJj/L2ZdXXsAJHxyvRZ3eX5q
         b8Ldq/dWaI441cbtmstR/W05zQrbdENGAeWVYYVLfX0CHddE8Yf1rwItk+yJvkEN01PZ
         d9baT6JCQ65TL6WniYyc8QaT9iv9e12R/HoAc3a82UavPa77uwl35AINBmFc930ReSIK
         LtBkjW/qxaYYn3NXDh+aeChwpsLmGF3yVadTn08nXjneFDFp4MvLpXxVPM+fXKhPGD2r
         e8j3ZSHhGifb1UpWD4O3tad5cezGXcHjnHPIBodO6OK5aukrfmTY6uShobNswpT7RWA0
         7H0w==
X-Gm-Message-State: AOJu0YyAg4SjGY1itnFQE4ImaFWmKB1rlqJyr7qkXQFaz/vAO0oyIhaC
	BGkL9txWj2Bzq7JsnFrLLIcLO7CrhW8wGCVg5QU44UyDcOFdANHCvQiCmzP7IFhL
X-Gm-Gg: AZuq6aJEec/APFDkrqED6I/Jb48gdaRbepvW7b+WVgIjHZiyBLltvpFOP8SdjdLQquD
	MmIjDAbr+MzS0Ejbs4d84Lm+DfoAZaz3/Rb/xny5nJsSa6d/6AuNVRoxP7WEhWP8ZKJHEJSjK2A
	3ZdDua+T03YowA6xIaOxqXbSVyBF+D0jmKd3TuwTS1OcFYZWgENeDpkZ++osLKI+fg5PXANGJOc
	sHuY6APdhj63H0NA1R+75lr17nqfpgyzT91/AKPk/Uz/8PCDiGpWavAZJsPAbhlOHsvtfNe5S6q
	Ybo97J7AsFSxyXwiu3YQUTrqMoHUP8FAJK0zPY/pYgLwY/ZP5/R2XicQ/pUPvNvBibHqygPnyy/
	Xo4pDW6xrmkEdj5nkqdAMtJz7YpZi3pUHZEDUwAt2pwhFikVZzcgyP7xufuOSw/ICCRYU5sOnDr
	uDCvzuPQpIfPZiWQ==
X-Received: by 2002:a05:6830:2043:b0:7d1:85c7:a6a9 with SMTP id 46e09a7af769-7d439e31baemr1508333a34.4.1770153980179;
        Tue, 03 Feb 2026 13:26:20 -0800 (PST)
Received: from [172.17.0.2] ([52.165.59.3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d44925352bsm441980a34.30.2026.02.03.13.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 13:26:19 -0800 (PST)
Message-ID: <698267fb.050a0220.36c3f2.3d5b@mx.google.com>
Date: Tue, 03 Feb 2026 13:26:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4956315686836946851=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
In-Reply-To: <20260203203003.2110409-1-luiz.dentz@gmail.com>
References: <20260203203003.2110409-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4956315686836946851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1050471

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.20 seconds
CheckAllWarning               PASS      28.24 seconds
CheckSparse                   WARNING   31.35 seconds
BuildKernel32                 PASS      24.85 seconds
TestRunnerSetup               PASS      552.94 seconds
TestRunner_l2cap-tester       PASS      28.05 seconds
TestRunner_iso-tester         PASS      87.28 seconds
TestRunner_bnep-tester        PASS      6.20 seconds
TestRunner_mgmt-tester        FAIL      112.23 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         FAIL      14.59 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.65 seconds
TestRunner_userchan-tester    PASS      6.74 seconds
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
net/bluetooth/l2cap_core.c:7735:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7736:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7738:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7739:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    1.896 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4956315686836946851==--
