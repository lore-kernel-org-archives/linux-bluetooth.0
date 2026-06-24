Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9373264CB
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319186; cv=none; b=ETUXkJ+3pL33G4cI4UXSCaEum0RnBLEZX9Ss4HeTf3T/giGVPkoK1WxKiSmZRIkpeTcirBQVtymu9vDFS2a6PDt5lffrUwnDpfiXm90/lPWD4tTtTGrHbKXz61a00Ym3I3C+dd+VkeZiYiMt3RTz9naYJPm330GcYuwEMy9At1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319186; c=relaxed/simple;
	bh=gVwrMm/MGph0ZdJKxmqPrzC6gRPfDpVBYLyw0Rk8gRg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=A8N8weSW+w6qBfYuraWv3pGZjjwoNHhzkPd5rtgA+47oRJfwi6he4jEfdN9bNtnZ3oT5MYFvpEN2dz3RQI9XIA2I6XHoWqG8BtGk1VvCSzkQN+AQjpMMjmvHp44bDXExDQ6obukMlUSgEZE0NS1Yp7y0h7iqiHAhdPQ77RpJgJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfxFfrFx; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfxFfrFx"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9159f631656so5632585a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782319184; x=1782923984; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lt1VPVz0prkYVSBD3rC+aSrzYjnY7/TL8pD4nEpRlUY=;
        b=SfxFfrFxV/xQAtH2Wx9T50orGnsPX/OftlwDKP3vjlSrGbQVvHJAlarsJhHoQYd9yS
         NI3VkMed9C6dAyB8ddf8BgvixFjO3ac22VUtkSPlaf3CE5uSXXBDcLW4fKQ7Hx/22XfG
         YxmAk3afCRv8B8h2uVlGtWKas38jRRTQeBrmWiIVWkfDPftrjrjXloCTsnqbUADTIn3E
         KwbjzqXohYjgN3pETrPfPbg8UC/ymV5HBIcgf8Y6nD32vDzbXJHPSaaVNtmZH6LuI5/K
         iigRJyW4HaEiTxwd5zMgv+RNKuvVOC+CunANaYR05EiB0QBet24fIMSLO3AuAzQAhTVC
         DqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782319184; x=1782923984;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lt1VPVz0prkYVSBD3rC+aSrzYjnY7/TL8pD4nEpRlUY=;
        b=U1PPK/Iz4mr1i7GivIf6ukhNnd0et/fZdxZGE/Ti7LLRD4odwOUjw7d1c9bC9Ag1FJ
         cEmyMFqKdZ1z823kt71ap1ch55qLnorC8jpvvaMUe4yo4cZr1RC8qf5cziz+dZA7tzdQ
         rnb/tZj2EdGypZSSVQPUUf88Ydj6xjFx9SM8CDd5L0nKtTpMfL9mZYoY7Hm6Iip1+SfZ
         dRn9SfeC877qmNw1YPu1Y1aLM7NWbzm8L5vufwbd2LtHWTxaHFtE0iFjLWAVCQOVEhIC
         8X2vzTNyovqDJ39WmDBQVU22A8LfIF2bgm0ol6ll9igXEup+JA2T9VPR6jJH/5M7V8q6
         hx9g==
X-Gm-Message-State: AOJu0YyxB371bBOFquwvDtuxq6d8+M2xCZ3j1nW0GaWpKg5ENtAtwZEC
	k2h8kkPMQougGFnZiBuk/PF91IG5VizPoiG+bcQJCYpW88vJ6LTMVlIgK6beBQ==
X-Gm-Gg: AfdE7cnZN6G72RsRJWVAuvFMno6Zj6XEnsLz4yYiHLvJmWA/WlE8zLxzCmTj3Jfbm6s
	8zQZlTm88EbVmpaJMXB8mzcd6ZDUzugVN/8lR9Ewe7teMJTEotbal4Wio8lFa309VjpiU+SZXGi
	KpB0sZ8v6vFpzE4iJTGcLNVeemUSuSZ9geuPeQP25jB4bGGOkYzAr72T0c2jIeuudGgHEOw5fOZ
	dJZHhGt7WNQOu3OTsrhoDEed2FOznGNxeS0dAtp9GhQI0RwuhiD3TdkMWIiXIsZM4W0ZJJ0q2LJ
	Q8c9ehTTYO7zGNRMgDYxt81QnTlECVJsln36LHQfKkDB30grnBJPTIFy1hKT9fPiBDvhfUHL6pT
	gqo1ItrZaN4EMupcea1gpV8EtEQVVZaKOcrjUHlxlO6wAS1qjWNoKy58/XWkfU0Dq4Ae3VQQgOX
	EoxneS3mArVc10nQEVbhU6yMlVirk9vw==
X-Received: by 2002:a05:620a:4482:b0:914:d65e:4660 with SMTP id af79cd13be357-926039afcbfmr182107385a.42.1782319183685;
        Wed, 24 Jun 2026 09:39:43 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.145.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004abe29sm593437785a.33.2026.06.24.09.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 09:39:43 -0700 (PDT)
Message-ID: <6a3c084f.19aa4c8d.3973bc.478a@mx.google.com>
Date: Wed, 24 Jun 2026 09:39:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4440476910102772666=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sammiee5311@gmail.com
Subject: RE: [v2] Bluetooth: eir: Fix OOB read in eir_get_service_data()
In-Reply-To: <20260624143222.883120-1-sammiee5311@gmail.com>
References: <20260624143222.883120-1-sammiee5311@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4440476910102772666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1115967

---Test result---

Test Summary:
CheckPatch                    PASS      1.15 seconds
VerifyFixes                   PASS      0.34 seconds
VerifySignedoff               PASS      0.34 seconds
GitLint                       PASS      0.54 seconds
SubjectPrefix                 PASS      0.80 seconds
BuildKernel                   PASS      26.37 seconds
CheckAllWarning               PASS      28.90 seconds
CheckSparse                   PASS      28.03 seconds
BuildKernel32                 PASS      25.68 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      567.29 seconds
TestRunner_l2cap-tester       PASS      57.85 seconds
TestRunner_iso-tester         PASS      98.51 seconds
TestRunner_bnep-tester        PASS      18.83 seconds
TestRunner_mgmt-tester        FAIL      214.90 seconds
TestRunner_rfcomm-tester      PASS      25.00 seconds
TestRunner_sco-tester         PASS      32.03 seconds
TestRunner_ioctl-tester       PASS      25.36 seconds
TestRunner_mesh-tester        FAIL      25.01 seconds
TestRunner_smp-tester         PASS      23.05 seconds
TestRunner_userchan-tester    PASS      19.97 seconds
TestRunner_6lowpan-tester     PASS      22.74 seconds
IncrementalBuild              PASS      25.12 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.248 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.986 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/348

---
Regards,
Linux Bluetooth


--===============4440476910102772666==--
