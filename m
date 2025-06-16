Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FAF2CA9
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089716; cv=none; b=H8E/HbuuoBpnjyrXDp3bChQH19ThnczppMQvrB5/o1mNRjGrEzGMOLyWxEs61oS1cbXmUUUKXWwwkb9gip+qNNFnZz6Ycvkx19cdzWYDHXaTfgE8JrDwkSr8vVQYFopygc+qyYHH9tcHgB0EmsiWIuewFClbCUZ7W7F93XqcTr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089716; c=relaxed/simple;
	bh=676h5gKkHkFaTXxdW4M8tJ6EmbKdt4sHI05IfRzIpMo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hkZrxo0KXekinO3tFFHSJanOOvoe2L4ytcTbPK3rcvkn63gpDQY7CbRAThoi353u7SKRsGwyETxqb+i4NpwgOPLrlEz25UqlvFgzykYGcls55H/8qOT1FscrM01PMHvcSfv9WCja2IFxD3BjMyk2J18lyXmw55Cng0/MLRSz1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/6qk3YE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/6qk3YE"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74264d1832eso5268379b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750089714; x=1750694514; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q9cjB6k8xyrn8ypqodT0InCy6eoNp9Peziss//K4Q0M=;
        b=d/6qk3YEWN2OuN1nrcpJMNj9sNalVvUKSp2/5P3S7WLZXGMM8Zhb5n2pkOThQW0hgP
         RnPr8LBqxLx+5Rw66HkdAqW3dBgTNii1jQmhtZoxFSWR0hnq9DDx3boiEm748ivWJWx9
         r9vjT9SPgVHOo8MwcJRtI8jpShzGsd9lX52uK9yelcAKurnatqUkA6i+i30effyJLfvE
         1HwtjUpQb5CDIm6j3EIVejq0rQ12drtCO7/EZk+p8byh489zvFoRMO6jM8mVZ9hrvD3m
         FqMA9ZWRdc7w9Awa2LPM5YeLxEPU29noxIZTOWPsxr5R/5xnDBd1PT3+5Ada6hV84ZSp
         ebDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750089714; x=1750694514;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9cjB6k8xyrn8ypqodT0InCy6eoNp9Peziss//K4Q0M=;
        b=AIbvfl8qPFpsMg2ijcRTMUmtcNPOTl0kR1ejYeg/1B9vg3YrM2Kj2gF3jyklml+CWI
         YzMzM0yrlicHnQfvBDhW/HT7DvApBPsSNPodyPSVCNwDLeCAhIDCvfpNol8nfSjGLRWr
         vCv18gAINNxshamV0sTwnFKOjxW7FIYqRFqYnDRlrRXEiMDXOR6kf9QhrvwcCyAh+uVV
         w2dBJO7th+T+estuGVKkEOtkO88SOusE2T4YpCKXcq3gyra2iYeKlMU2byasNESiH/CO
         pW75zIuObV5kiqij1sZbYN0Uh5FH5k7l0hPTMoztP7h7c7bp1epe7NnE+B2R9KbtrDTD
         Xhxw==
X-Gm-Message-State: AOJu0Yxy/IqLOvR1IxaZt1HsLFfu4+Vfhk5x1FoJ00vetnGvzaImyR66
	FLIEuLQLvT7+qk4KVjF0HO3ylEGttWNDQfA56AZXqaCTDrZYkFteC4vVMbcqew==
X-Gm-Gg: ASbGncu/8kzLmBz8AZYymKUr+axX6TfSEKeDj7yiLQ0yrxkebRmJWyDa1M+Wd+t3SWg
	WuZ/BZtTnrdq9HSbWDqwl3bx5hHcrvY12NEX+qALEUgHOP9c5vW/xLtpz5MPm4thj1HyZIa0LZ0
	C9riaMcWKM9/7mecKUw3/cNNhtbRhOwcmEj81jGxNUNneBB/8MUUyiY/bep7c3z2LpmzP7+prs0
	bU0CED4RKCiszCFXjbf5eBeiC5WoodFtw8APcgU/u6Xrr/Yq5/VhdFSNKygT5YzREgSQAbyOQ44
	LCG6rcj/qnVTaoDRjHCp9rstCIkcWSTHBNnp9mESoybMdhEV7OIqf0M9WKi7SnKDt1vh
X-Google-Smtp-Source: AGHT+IEUEHyYwI7kNH76KcB5HfZJdBMpYyT1uU2vSx9ATmQTUzcMef1fBqacXQgTZ7wRZ8ilM6BEBg==
X-Received: by 2002:a05:6a20:9f99:b0:217:ff4b:cc57 with SMTP id adf61e73a8af0-21fbd7b6602mr13140518637.39.1750089713971;
        Mon, 16 Jun 2025 09:01:53 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.41.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7489008301dsm6997717b3a.78.2025.06.16.09.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:01:53 -0700 (PDT)
Message-ID: <68503ff1.050a0220.2318a6.3f11@mx.google.com>
Date: Mon, 16 Jun 2025 09:01:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2014001987156826862=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1,1/2] dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
In-Reply-To: <20250616150919.8821-1-neeraj.sanjaykale@nxp.com>
References: <20250616150919.8821-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2014001987156826862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=972577

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 FAIL      0.60 seconds
BuildKernel                   PASS      24.06 seconds
CheckAllWarning               PASS      26.52 seconds
CheckSparse                   PASS      30.03 seconds
BuildKernel32                 PASS      23.77 seconds
TestRunnerSetup               PASS      453.93 seconds
TestRunner_l2cap-tester       PASS      25.20 seconds
TestRunner_iso-tester         FAIL      7.91 seconds
TestRunner_bnep-tester        PASS      5.87 seconds
TestRunner_mgmt-tester        FAIL      129.62 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         PASS      14.89 seconds
TestRunner_ioctl-tester       PASS      9.73 seconds
TestRunner_mesh-tester        PASS      7.30 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.16 seconds
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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.224 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.197 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.211 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2014001987156826862==--
