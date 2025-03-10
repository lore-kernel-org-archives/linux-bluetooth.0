Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05741C07D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610701; cv=none; b=KUsqa1HMMTYWSHE+HddN+HCYFh8H0ezl2NGDCnsSLEjrUsbCnYtF8J6sI9m/GHyxScobES3O+mlM+5ju6Ih4YaHycd89IM2as1bgbEr8saoHmOFO8ovGg4kCdiXcFpXmPn0xZvyb6YtP+ERPqD72fcXpYWeuN8EwumBBrNSVT2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610701; c=relaxed/simple;
	bh=uALFHkZBh6mr+U8Eax9mJ7F4FcKL9cfKB4hJ+UPDhPA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Zndy5Ibz+khR9whK6ZPTKTM5hHp1Whq3No9Jk1A6Lo0KR1ZxGvkd3uqKa6c+SX+FWIdggMQ5yIlmGWgJkprF2i26+qu2II+SR2YKLF8xnLRGklq6yTDk+WX8PFnnoQb3ayGUWzQwlsON3fg6HJ0J6oHUXRbsjL5i0sPj81QraTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUzi/GFc; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUzi/GFc"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e41e17645dso38367096d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 05:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741610698; x=1742215498; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qYK/a0FirV+xmbZwA/nbNxlQ5T3peyARA6GG+dY4Rdo=;
        b=lUzi/GFcHBcSs4KJDxvXCTXE3p1IGSgxFeo1X3u8F0WU2uTLPFupJUD30F+RG8rCMS
         T8tjMyANvYnst0Q3BqXJLNnYjLCC6S2cDrHBkgenv1NR5cIf26UAmxxJ7W1SiG7sMTgI
         YSv3xocD7fO1B1Sgkf+vLRn+Zhazjj9XMHkZ7abzSbM07hLMvAVAVjjZJ+68g1gVBaYA
         kpFx4aMb1jkE5kulEUmvQBfZ+DZJr90nA4MTA+Xjy2+jJ6L73klBHQL9cCvsgGNrg2Es
         daTjkwnd+8/WGbBJfMDYxfimc54UekCrV2kYU7RB84HwY6rdVY48eA/mbsrGreWwzzm4
         c3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741610698; x=1742215498;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYK/a0FirV+xmbZwA/nbNxlQ5T3peyARA6GG+dY4Rdo=;
        b=vVAPUkTVrmad8aD6r1PShTD16xpSxgfjBCD77Eq3MatsYxHn4bAtbMhpPZdAk21zb0
         S1Ye/mREjMyBu6lLQKLc0qXdJb9moRLiH0TJCXk5aViX4F9bRsapBEOE1oKARSmS/ZHE
         oMTjIBmwkfcnjIHGsRUWlO/VnVZ1HoLGZ3T/jdsxI98IGYVt/6NvOC6iBIRu4+sNy/x1
         KhutdII9a6OMXvxxx/glCJhcOjpcGJyLJxM+sYxdAdpH4cLvyiTCPIifZyV01wd4g/oN
         6Of3pODDOVS33cKzftmn77UBCTtTKzSGmuSe0c+vr5IcqgPgeQKNLA2G4BbfAKRBnyho
         K3ag==
X-Gm-Message-State: AOJu0Yz/A9k0fG9/MHiG4caRjwnmkJPozu/gqdCIE+h73gDNXFlws7yB
	PUSlRb4jPiYkK1NLKUTyEQQYmQZ72G+VFDnno/9ljmhDjZ8zk8eVrmLU6qUj
X-Gm-Gg: ASbGncv/VhkRdrpDVNh5kuAigFEDQBBuvI8SvwJKW2YLmzMg+JrmNtt0jOpvMPRHA02
	WD/g7+RrXS8uZCmxEbaVCERn5f0KKFGo+EDuTZerAPjz5YRuE1b7gs1G7ubzUVunK/GkB9zofAp
	i7zeZ0ICdGUJWNu+SBfpwk6pjiqB9nfJMbHir/YrBBYfrLUiGreaujP50gKwED1fV3x2NWnbhfo
	EitknWsF5t/sx8ot3s6KL9/HnRNOiUzAYyHU8cb3FeryuOaWF0dMcFOGmRaU9JHU72DzAcCkbYm
	Q83+wfikD00Q4wVPDFEykIw9ybgdKP+BhAVZwbZ/dqyIhZakEtwoatbCJMZv+Gjq
X-Google-Smtp-Source: AGHT+IGWsz+lJ3rjweNXgdFqTSZ4tLwJbF5Hh1DLM9VYvH9TqjnCEZF90EJ6VqIsxOXHxp8veh2zmw==
X-Received: by 2002:a05:6214:29ef:b0:6e6:6b99:cd1e with SMTP id 6a1803df08f44-6e900641555mr134988386d6.26.1741610698481;
        Mon, 10 Mar 2025 05:44:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.206.111.192])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707bf47sm57837496d6.25.2025.03.10.05.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:44:58 -0700 (PDT)
Message-ID: <67cedeca.d40a0220.3c5a1.17c6@mx.google.com>
Date: Mon, 10 Mar 2025 05:44:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6762836371271749790=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v3,1/3] Bluetooth: btnxpuart: Add correct bootloader error codes
In-Reply-To: <20250310120231.263174-1-neeraj.sanjaykale@nxp.com>
References: <20250310120231.263174-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6762836371271749790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=942225

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.34 seconds
BuildKernel                   PASS      24.91 seconds
CheckAllWarning               PASS      27.03 seconds
CheckSparse                   PASS      30.92 seconds
BuildKernel32                 PASS      24.54 seconds
TestRunnerSetup               PASS      436.19 seconds
TestRunner_l2cap-tester       PASS      21.27 seconds
TestRunner_iso-tester         PASS      35.38 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      124.48 seconds
TestRunner_rfcomm-tester      PASS      8.04 seconds
TestRunner_sco-tester         PASS      11.96 seconds
TestRunner_ioctl-tester       PASS      8.54 seconds
TestRunner_mesh-tester        FAIL      6.32 seconds
TestRunner_smp-tester         PASS      7.30 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PENDING   0.85 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.202 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.143 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.150 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 65 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.112 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6762836371271749790==--
