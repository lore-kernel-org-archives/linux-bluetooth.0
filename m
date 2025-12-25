Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B008460
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766657103; cv=none; b=pdzs0DEaxJRsG6tXYCND6m8+KOYhf6HhhOZm0nJYs+z9i2YGd/+Nl5Dy0p2talhT3ahsSXb+JifAqgkAEboSgmr0KLCn9ng387nD9sEwxQG7G6IlDj2C6/8WS7WbiDhRu03HZccyxZ0SmHAsWfnjLymOjXrg8jk41kNDfiUxYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766657103; c=relaxed/simple;
	bh=Ibx7NkYTLBNW7PrSnqLP5o9IIrBNHe5/3tjxwLAE8Nw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EsA07F8nGjjGRvj88VIcC70rKhwxo8dgQlC3SK/YVQpy80DLAWLEWqT6KHHJBb21+exiL3z3YMMcF91rb1yOnLSNT4V3nggF2cuW9KnxCHwaCYpgRQKQkSqxfs2oMuQZbPJllihffWxP2yqHUV7LJf2rwALJtds3Bks7jvXoRFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HysbjlGl; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HysbjlGl"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-88a3bba9fd4so72369086d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 02:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766657100; x=1767261900; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZSs357xFMXUzk8F0qgLjxni8Po06yNPyhVWi7AufI4=;
        b=HysbjlGldNMFhLRLe04zMwawuX1yjwkpDcZitBptGGBktcTD8m1Ef9jtL3ss9OzUjn
         ckeORSufD0O860fEE1HukpQ8bytfdMFjy6jopgWqIOZlF4vaenBW5PsN/MwP32jXZdUT
         eB8J6Ek5qwobtmyo2OaVzAmLHDS1Z9La1BscraGm2mg4czTbkCWnnC86KDhWpj527fEI
         84i7COdBnXnRdWp0hMpKvLqJcXI5HBMsao8O+3TMHfSBt8LgHD26bzPOGjqv0sv5+Kni
         B09duGnN6YmTvIREz77C/c/tkq53HU9WWyd8ezZnBU2y3Hljly4hrbQ9R4cwzSY9r5lt
         brlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766657100; x=1767261900;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZSs357xFMXUzk8F0qgLjxni8Po06yNPyhVWi7AufI4=;
        b=lHt51AJPbtCPSAZ7J5+AcdQiaQB9kyzm0n6K1rHESHAbccZzfpoIrT+tBm6awFJync
         7eCx0dxe4B/NmUJZZ9qWsWxCsZxBn9r9pMtg+sTWy7G3K9W8U8jMllCoxf90ZQBkjT/V
         yoJCS4VmSUCDy2ZwyTmwndN1eRSgdCTp2ncpzDzRyfYDqk1u3YJefSaFQ68FKJtCMFGc
         og8blELRzQrAiBEALn5H97lS+1nW8JIfhnQcMVMY9niQlLBLyxw37xpoMsoUG0jvrnD2
         iRTE2wAO0eOUMWIZWOw6Mhj6kYMQiUUKQG+AQf/gE0l5TY3KzieCtgP4ZoF6gXUFS6a1
         cUcw==
X-Gm-Message-State: AOJu0YwnvtV2zonnxje17CqSus0f8TeacM7CUY/jf3kB4WyCQttKENlM
	G13H+ya/2nCFDVkCC7pJu3/XqgwYWMdTXqR1LVdfu7Hb1uVaHI8TfvvMILUrlQNZYOA=
X-Gm-Gg: AY/fxX5gJxfjKRS3nBtMMxz/XhWTguwXyMRzau6jLAAV2wmAw7wkPn2caJ7oJeJ2j0Y
	ZG0wrnPEExwcb8I0E7JTPyq7D57ScUmSqIQXl5uEJ2C/2UfVPVY2mrd2SNpND2kqi50zll2OqYS
	BhX5swQbusYMV3UQx9hyETftHWAOcuSCFqHI5nOhoK6YkRqQbq/ZLSaqOjc7mKBEJR/liBQ/8vy
	a7iFcer9CPvFvbY7NH9m/lcrOXRiFjIDXSNyL4R1HVC9j+e5NYNpmMMA6aUvlP7V9ONsm8nwi5Q
	0I+ydrkYHDxxpLOVpo3Yx3z+nJuOVgL9hahdDiTtslwG7NGKXBtNG2la9sM4s3Jz85prIYcMmqx
	K+K7ea761otx+IU2GboIqrhDYcGeGG3sA0o3MFWfld7aqLtpiSfb9MbNzXuakLjGKAZqo33S9ge
	BGaWupA8P45CqgnAU=
X-Google-Smtp-Source: AGHT+IGSzNxERrkWG+s7dEokJlyLpT9aJcMM9BLxTQ0ArfrWH+hyHElddATHSN1K0lNAOEeXxBsG+Q==
X-Received: by 2002:a05:622a:5983:b0:4ee:280:2e49 with SMTP id d75a77b69052e-4f4abdc9b4emr291554591cf.66.1766657100076;
        Thu, 25 Dec 2025 02:05:00 -0800 (PST)
Received: from [172.17.0.2] ([20.161.71.57])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac64c011sm136913101cf.25.2025.12.25.02.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 02:04:59 -0800 (PST)
Message-ID: <694d0c4b.c80a0220.25a82d.3b3d@mx.google.com>
Date: Thu, 25 Dec 2025 02:04:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9206506465622536398=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, swilczek.lx@gmail.com
Subject: RE: [v2] Bluetooth: vhci: Fix slab-use-after-free by cloning skb
In-Reply-To: <20251225091921.14860-1-swilczek.lx@gmail.com>
References: <20251225091921.14860-1-swilczek.lx@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9206506465622536398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1036540

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.11 seconds
CheckAllWarning               PASS      27.54 seconds
CheckSparse                   PASS      30.84 seconds
BuildKernel32                 PASS      24.56 seconds
TestRunnerSetup               PASS      543.65 seconds
TestRunner_l2cap-tester       FAIL      28.02 seconds
TestRunner_iso-tester         PASS      76.34 seconds
TestRunner_bnep-tester        PASS      6.21 seconds
TestRunner_mgmt-tester        FAIL      124.10 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         FAIL      14.46 seconds
TestRunner_ioctl-tester       PASS      10.21 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.58 seconds
IncrementalBuild              PENDING   0.62 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Client - Set PHY 3M                     Failed       0.112 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 486 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.110 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.178 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.155 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.158 seconds
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
Mesh - Send cancel - 1                               Timed out    1.927 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9206506465622536398==--
