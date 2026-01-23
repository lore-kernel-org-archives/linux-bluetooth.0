Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F661EA84
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 06:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769150858; cv=none; b=UG4wEfsWOSIuwwqA6kFGEcZ+lECeXrSB44V1NNqEjZKt6VIYQLfYOOGCAohu72p5EYWZzjYn8ZJrxi2igHSkxDvMAvdhZGJzT9UEYLLd9VnWKVzGk/K9pGwhRm+3vo7v9Yy6lYT8AGA5tkd83NBXkcZ2R4r1eT/9Q0zRW2NTHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769150858; c=relaxed/simple;
	bh=z5zxxcF/hewYScoBNH2QRq1r20FoKi5Bh++isyjLEPw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RYxY2ZxGj9Ay4m+ufgzL+Zl1qzJXtkZ+KUenPg5T8kBDXqCzOaETdf4lb+92HMn9N2AFg39ZvJfKVslK4ynVc17MUvJf1FYX536P94S4XkpfZgZlEH1/KlEUYayt7RmeSRUkEOh/GzxyivKmoKx6km7UojXKi5/6sgcOrLny6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqn3IDHQ; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqn3IDHQ"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b71557299dso2543949eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 22:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769150856; x=1769755656; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1tdIEOguHPpLDK0xsRWmvZIm4ETOVTky9llREWvyjTw=;
        b=iqn3IDHQaRnpQs6cX0YFciRp5oZNfWxLHJY9kd+J09uJwiY53vqeymm6/fbvK3jZy9
         2vFt7VyLR7A0U38nb6jUMb3QfdmEuUnmd8I4eWU0q+o9lgApdJg4MldjEe/tTJVYqaAL
         Ki2prnccyzY2FAWaxCtiwlmfEea7y8maPG4WhrzH86rD/auXpX23lS0X6/tmUIumvuFq
         3ENzYKYvQUjdBl0lIT9ExQTfqZnzE8H9DF6L01168ieNZ2so6Juf1Xhn7Or7sxHbmK/L
         HtaolcoY7AkvqtAg7aYJr6+LVLL1+kZTIwJb4YTwq7GQQdr5s1h5ZQ0raVsb7ituVLGR
         BwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769150856; x=1769755656;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tdIEOguHPpLDK0xsRWmvZIm4ETOVTky9llREWvyjTw=;
        b=TMHaP1WU74JFX9TAGM5T3oRGRuMFZWyaMAmUm/WRKIDa8jaORWHYGFtkIg1N71Bgqe
         sfTzFOfVpzKXg3KyXmb/A3Q72kW6HHlDTh+iRPMrzFujxaCOP5MbaLVhT4eGuO2i4bmX
         Rp50DcBpFohjMpjOhsUkpW9L0vrkaH8/UT1L0URnFM/4YOsFV+T6rdxErGsF4OQHl9Mk
         c4fPHi5UbMdW0CETQv0v38IUocblpwBLGxynP2R44Y7/7PyUKVtVtdPyxh7tAu5FS9WX
         jqfpGnrTNrfv44GeVz8wEbaayU1SEe3axpzCJZHYhgwO+xwMtSqx5FOnyJPWmGz9RJFD
         pUzg==
X-Gm-Message-State: AOJu0YxI2YQOg832jL3InvwgM99znz9732w2i6RTT7ao6dGeHwi+vFTY
	Hscc2LapwMY8NEB/m2x+JAnn1g/h43Vpr3lYG3ESXRQrRwmwQHc/73hx5x9jXs1T
X-Gm-Gg: AZuq6aJ9tdelltkIUy/MUuVV80WEU1TCrq+Jc8dNZMol5zIQ3k6aidCDTTWWOXFv7bD
	sbRJux07BRhduHfVLxm0MmDwCCKaj3Rzqde877cl0fm6BOok6uLo7HJHc21BNX+gk5/KWaVb5Nh
	WuVNraaNDQ2bIw9uzWyMqNF7e+yOX+Xdqk3loztKb18h6QoOKB0MG9+fV+MYFywndlJejhU1TVt
	5Uone+B805BDCiHkL46/pa7/Aqwkz3iyyflU42xdms0b7JTI2MQaljYAThxiGDLo/KBUzAeBnpy
	AGrt5h7kn5Cj8TUSPAgNe/FuPMBhpJB1YnHgfspXQuoLd7kf1lr+hZQfQOvdhiHeVC0q40K/mWt
	hAgtCWXFxROuBRrEkXf3WLgJxIg/Al37r1mEqBGWCiedqxJGn4/uVeETqHOEOJUIfMR01Bzmm3m
	g3K2dvzMkiginKXzLv
X-Received: by 2002:a05:7301:1910:b0:2b7:3782:fe60 with SMTP id 5a478bee46e88-2b7399eddabmr752243eec.14.1769150855800;
        Thu, 22 Jan 2026 22:47:35 -0800 (PST)
Received: from [172.17.0.2] ([20.163.82.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d9a4698sm2770976c88.16.2026.01.22.22.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 22:47:35 -0800 (PST)
Message-ID: <69731987.050a0220.285ea1.c896@mx.google.com>
Date: Thu, 22 Jan 2026 22:47:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8898470351697534024=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mengshi.wu@oss.qualcomm.com
Subject: RE: Bluetooth: hci_qca: Refactor HFP hardware offload capability handling
In-Reply-To: <20260123055243.2634107-2-mengshi.wu@oss.qualcomm.com>
References: <20260123055243.2634107-2-mengshi.wu@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8898470351697534024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1046029

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.39 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      22.62 seconds
CheckAllWarning               PASS      25.33 seconds
CheckSparse                   PASS      27.72 seconds
BuildKernel32                 PASS      22.33 seconds
TestRunnerSetup               PASS      500.06 seconds
TestRunner_l2cap-tester       FAIL      27.84 seconds
TestRunner_iso-tester         PASS      70.76 seconds
TestRunner_bnep-tester        PASS      6.26 seconds
TestRunner_mgmt-tester        FAIL      119.66 seconds
TestRunner_rfcomm-tester      PASS      9.36 seconds
TestRunner_sco-tester         FAIL      14.22 seconds
TestRunner_ioctl-tester       PASS      10.08 seconds
TestRunner_mesh-tester        FAIL      10.42 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.57 seconds
IncrementalBuild              PENDING   0.45 seconds

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
L2CAP BR/EDR Client - Set PHY 3M                     Failed       0.110 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
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
Mesh - Send cancel - 1                               Failed       0.129 seconds
Mesh - Send cancel - 2                               Timed out    2.694 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8898470351697534024==--
