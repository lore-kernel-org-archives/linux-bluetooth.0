Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D674D653
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734321215; cv=none; b=Wd+SBppWFNugcfs9138M7rrGCBOZeBtPAhBNk2ExCwf8afLaapHVeeYEmYmTMr5AoJQv7Zt5b+lQ6DT9+WY1//VlPVfh9m5cuMpjJZH3zZeKXyXERGuLNFLzgk+2z8La/r23s6y+AAXuvsphX55JMjIy8B8BBwhIAb9qFga7HOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734321215; c=relaxed/simple;
	bh=luBFaDCCYTtt8GLtA17MV0SjwKyIK9tuGAD6Opz3vmc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BqYmFUbDdB6qP21sbRVZLMC+ufDgGYtqED6R1raSBHatUpHhd70acI4EgJWiPJReTDtKJolN1NHR5ilwMqeVYgpB5+2Afk3SR+XusPg74SXLWAXGGhDw6ZiuJSK0n4BgP0TcylP82+y0m34qwA9lWajsr94kWc1+2xtpPJiTErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfgRnARm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfgRnARm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21619108a6bso25986055ad.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Dec 2024 19:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734321213; x=1734926013; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=moa7IIguZhmSYHdaKUt1aYGZUnc1Ls5RSIqAn3A/EI8=;
        b=IfgRnARm4OoRo898IWvOz2qhNZZbN9bq8GcPWXS4qQpENgcYXyzj98cX3hKXK3hMcv
         aaSZWLg2aZmXkf9XzcjrMtcaayXObLFmpDG8Ub7cwWu4bsmeiRVdA+/tx3prPWj6BlKT
         vp70uPuRLD33/6yMkJh0K/bUEPHl8LVQoknr2DitSSzBy1kcWwmeAfg2A3OxXa1IG0gw
         34YQN/fDMeuZbcCJ4Dv+28IOt6yNRVAdiqo2iLv8bynODACID8k+07zQkD/CVSFCDQn4
         SUAV7StIOQNjM6KGII0C9ml74tpFIh5/ynevh9qv8sVpkn1KrXTbjaqKFvvOZbjhxL54
         oV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734321213; x=1734926013;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moa7IIguZhmSYHdaKUt1aYGZUnc1Ls5RSIqAn3A/EI8=;
        b=au/CXcCQQ/61GTTWlNoYMQw4V+k/ZHfO9lOz7mLvDB8uZluqiyUFhgsgob3wtEryAJ
         Ht+LvTrEF51dlxEICakBFk2c4lnbr8vPN/TIdutmmhcjQ+7Iy0GDgNfVF6GRjSq3yKHR
         xZqdva/a7Wm2c2Zg3q1ssxiMGM4Aj0YubS6O3M4aYVfJxL/OV6cfbhIkgAayTSdSsDXq
         P8Tr0/RmaI8qhh53NEZVB87f0EVWTJBJ1yphXn8jK2VimQPb1/S0e2ChMI7aY07D8Mov
         thdgSzfFuO8FtoftmFBcFpUXGmiuJSfXBEZ4aeDOYfwPM7J1r/em74ts0PjN5nNi8SzB
         HBKw==
X-Gm-Message-State: AOJu0Yw9NZh8f6wS0+to2SEXPCLYNm94hZb02ft6u2OE/U9qXLTuZxCE
	UHZxpewn5ZlPmUYdC8o/TFlNbC0vu/RKHQg5IyWoEQUU02l8D3m9dwittw==
X-Gm-Gg: ASbGncv+TqdMWoW7/nMYeDBqro9ZGkGsbwmSrb5WcdN8XKSmdw1WWkdrXB/xqM0nTy1
	a11KWmQXFECX7k0wXHhbULd5zG2ScJSSnBFLpQl9ml2bCI8CgC6I9tCnHILJ050kNJtHgnJ6nQZ
	ANi///kTH3MBZ/MvGxqcMeTuRSo7Fc/rAB6EKKSGLsXiQ7z5d5grh8WeLuxbJogSM4bs8rka6PZ
	cUUmOxgXrUuUy2Oxx6i2U6I9McIAYsI5J9bX4WE15h1EV+HyKpUMTTY+G3avOQ=
X-Google-Smtp-Source: AGHT+IGLSW/vNk8vlypFwEef1yv1CpMTv4BY2Rca1PfBy3/p6n44bxdt5P0cUQOwNzsSUCEuYkuyhg==
X-Received: by 2002:a17:902:f54b:b0:215:4394:40b5 with SMTP id d9443c01a7336-21892a2073cmr140694305ad.43.1734321212831;
        Sun, 15 Dec 2024 19:53:32 -0800 (PST)
Received: from [172.17.0.2] ([4.227.115.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db8793sm33378545ad.50.2024.12.15.19.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 19:53:32 -0800 (PST)
Message-ID: <675fa43c.170a0220.34676e.89fe@mx.google.com>
Date: Sun, 15 Dec 2024 19:53:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3238617382913480000=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v2] Bluetooth: btmtk: add quirk to support HCI_QUIRK_SIMULTANEOUS_DISCOVERY
In-Reply-To: <20241216031818.19284-1-chris.lu@mediatek.com>
References: <20241216031818.19284-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3238617382913480000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=918052

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.50 seconds
CheckAllWarning               PASS      28.01 seconds
CheckSparse                   PASS      31.31 seconds
BuildKernel32                 PASS      25.20 seconds
TestRunnerSetup               PASS      440.21 seconds
TestRunner_l2cap-tester       PASS      20.70 seconds
TestRunner_iso-tester         PASS      31.96 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        FAIL      121.62 seconds
TestRunner_rfcomm-tester      PASS      7.55 seconds
TestRunner_sco-tester         PASS      9.45 seconds
TestRunner_ioctl-tester       PASS      8.31 seconds
TestRunner_mesh-tester        PASS      6.16 seconds
TestRunner_smp-tester         PASS      7.01 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.97 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.162 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3238617382913480000==--
