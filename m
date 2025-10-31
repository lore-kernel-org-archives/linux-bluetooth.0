Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2FD1E9B0D
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915017; cv=none; b=VfToo753giZmZLAGQCP98bkiNgdBnxH6eaba9NU1bE4FPj6x7nLMpJmhMnF3XLOUTXKy3uQicclatIAK0Qhi1NosSPAnreWiJ1YrGI3nnsnWM0gAdSeHCS2FVvvp1yJay6pjkMWiyk8tNVtybkQfV31vayGq5s4bsmM84BFuCrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915017; c=relaxed/simple;
	bh=0yJ0lPkIROw81sbJhbPi9MidTIyAndY8Qs3t1posHoo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=avgPsUF9GAsdgTv/ZQrjldACvmQ6TcKj0Blh4HoPrVREW6HRGNoaLCEfxkzjfk0YmRWX6Zm3glKG5MCPMKQJYnFQorJ5o7zKdN7t7nNreuGVSX1NfVRgVmBdtW9TilWZaiSD+J+R4TEdfRgQj5+sBQB4Efn0EemPvEJBex/G9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3bje4KV; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3bje4KV"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-93e8834d80aso92263339f.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761915015; x=1762519815; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M4OzpDSRuKueomkXUj8YuHjDur56ZZx44TFplEi/rF0=;
        b=j3bje4KVqQBdERojiQpenmQHFo+2RpNvtu5NthaSFHtmQNShdRuswQA+1uUK9wjkQh
         yFd14SSNMg9s0LiKf+8dXnfwiRRv6UHkDgPYkyR/h0paSAvbbXkN7hrle0GxF9fZs+xN
         3b7rattlfhu3+YrzN7iPaP/7JEDuj3sva0wx+puv7IZHI0MuGH9AUtzU3T6zf86CjZ/f
         ECEIXbAqQT2DH8Ua1XNrQtEtTGnRIxyVXj656MZki0DmUy5cU2tUpjRznkSZvHtjRaEW
         4Xc7lwPf99W8Ps90avI1VR5dMnyl4rTJmysAchyTDAMZndtkKCwsCjjlWjRQMAHcgbLa
         7b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915015; x=1762519815;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4OzpDSRuKueomkXUj8YuHjDur56ZZx44TFplEi/rF0=;
        b=u6Vge4p2FW3FWAmPtMz4ktFqaxDUrRBQiXk+qLhod8bT8V2bHb33SYVNv29wtDm44F
         t4XbpuYYNZcxFLG5VqAxMbG/Bq34tR1rRQumFycu3pdCqsjaiezDtKD92AWnT4FZ0XVY
         sQ5oLsum7U20SI3zg4aSDw6DAfV/fZX20Dn/3lb+/JXykaIUoY0F2fzyFC5XtFiFKCji
         3AaEF9Yus93bD0CmR2J8vu0x409Ix68YVp09yc3X0s33RiavJIq0IcfBirHM4UJ7MsT8
         bStP6x9UxnBshm9OnlQXQkMSrcVi8LzaxFTSmbyntrQgZPZiq3fMuzw/JoO9uhDvsAtx
         b7Mg==
X-Gm-Message-State: AOJu0YwUBjMxTvqCWAcEZJ7W38dTc6sCon2q9nAKPa9RcgDq4s3ODEKp
	nGiOp7WAa4b9D5UL8BZ68Tvqg85g7GHKtPKwkpn+iU/LYTpNP616CTPPSbSeTw==
X-Gm-Gg: ASbGnctGFKio1lL/HBS8nRIIt0vLLZbIZ2JqF6Py2PqOA4RNMe6uEnG7uNrhxneNPcF
	2GLZ5tqM8GWOzrYycFTQNXySH5Mnno+QxLXui3T9TRgukX/arvYb7SCn2sl8yO4sypOhhJyZty1
	5m/ArTtwS4C4KvPrPQ/u9jv69mcdnLyrM7Ij3dNJATlu5bp0u/0VdisNCt6lYb2FZ8WgTpsjyGu
	yabP1AsyZ/2vpCTJ6q5yDtlU7Gd2//F5awNoI1I6hfGX0WaMEOaSSrR5L7DBxbPnHvhrSkocJC3
	fp+0UKfxnC3KG/JMtnaSjAttSjnFeprsXz450kwUUSiTuxtxMIfToyBsYgfW8v/NYXzJUdi8+SP
	LYvWigshqkf1mhsjs85rmozDA/B1ZuUE44yAGXFDXjQPHrXf4jRoAEKxTfvUHqnTVTlZFv25iCO
	FGseF2VGeAhVRrZT6C
X-Google-Smtp-Source: AGHT+IF/tYRQkcVQ6fR52yJR6ZbI8els6aGEODvWXZfm5utJF1Kt8G0CqiadLdD6LGtJFzkvkQW68g==
X-Received: by 2002:a05:6e02:194d:b0:42d:8525:ac81 with SMTP id e9e14a558f8ab-4330d1d7af8mr50752265ab.17.1761915014794;
        Fri, 31 Oct 2025 05:50:14 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.143.37])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a55b0cd7sm671687173.35.2025.10.31.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:50:14 -0700 (PDT)
Message-ID: <6904b086.050a0220.262d3d.0ea6@mx.google.com>
Date: Fri, 31 Oct 2025 05:50:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2470459472616598926=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Markus.Elfring@web.de
Subject: RE: Bluetooth: btmrvl_sdio: Use pointer from memcpy() call for assignment in btmrvl_sdio_host_to_card()
In-Reply-To: <578671da-c290-422d-8f30-55448d024d55@web.de>
References: <578671da-c290-422d-8f30-55448d024d55@web.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2470459472616598926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1018196

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.10 seconds
CheckAllWarning               PASS      27.70 seconds
CheckSparse                   PASS      31.40 seconds
BuildKernel32                 PASS      25.11 seconds
TestRunnerSetup               PASS      497.33 seconds
TestRunner_l2cap-tester       PASS      23.75 seconds
TestRunner_iso-tester         PASS      49.25 seconds
TestRunner_bnep-tester        PASS      6.14 seconds
TestRunner_mgmt-tester        FAIL      113.36 seconds
TestRunner_rfcomm-tester      PASS      9.23 seconds
TestRunner_sco-tester         PASS      14.38 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        FAIL      11.43 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.50 seconds
IncrementalBuild              PENDING   0.96 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.169 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.867 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2470459472616598926==--
