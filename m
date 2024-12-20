Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B241C6A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734701933; cv=none; b=Qxwi/Pv4MjGvp/WoL2qyXKSf++TzP3HOFFrKN2pYArUh1ImZgzLqT2PG07gS+od3IG09rLxpLizzk0B1Y+9XF/sBFpUywuoGBCXbARVPJf9rq5crW84ANWbY6wG+bjyC5a2kFxCbZq1OACptzs8dDQcToomHbuLrg9W9muxNjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734701933; c=relaxed/simple;
	bh=oxLUZHzbKuzaxWG1F70a/YY9O5a4NNodfszEzGkiYJQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=evtUJBFBuG0FWpKwQhf+eg7Abj4kLvGwZtlnOXSMp8x/GLqrbqDTPv/W7/7Wo8AR8k+Kc8xM2tDjp25Hmp12yqedmRYh4Tz7FFCtbwuZinV74qrCbA7Bup1RdzMLzgptwpthz05yMVxcqSaxyVNut/HxmxIGmJKyngCNGpFNyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NE03TF2s; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE03TF2s"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2161eb95317so18074755ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 05:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734701931; x=1735306731; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HNoie+4Rl0hFjhccIvMqm+DxStZ9MDHuUR+EtS++AR4=;
        b=NE03TF2szJH317G6g6XxAEL58psaf36QxQ5Zdzuh0ZuQDzpw2PNun0JvVH4ek8c3hL
         wg67Yat+WnXFIqS0cH8AEK3GNLbsOkmwIckieaqBmvwEemVe6ETxI4TjRXHwjd7qICSV
         H8K3TEUBuuityChGbWjSguJfyKh0K8OO0n4fi7GtCjEA45uN72SFHwrWetwZs343NBSE
         nTTmUug1VG7gEUNoAArCwZKLMz0JsLM7s+OjHxkWqpr1q4I4aujYuXCrCNAJkTy7arrZ
         mJMW4/fJ8iCif9kKAWmjLrDg0b23yMhVdSJBnRKHkQIfjCjKZi7C6WCr4nbp5g8Bm2zB
         aMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734701931; x=1735306731;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNoie+4Rl0hFjhccIvMqm+DxStZ9MDHuUR+EtS++AR4=;
        b=fychLi7tZ7hv0K3MO814FogZ95Zxva9Qzak5hVIyCyqGs65tSNozRoOPd6bslGZj6h
         nFgN6T4dWl3gIvdonTOm2MTsg7gf0ebJ/RfZT3m5z1TUxLEQuO7Owa+rvGJmKNxbOek2
         UQYSvxHPh7yExbXGIu4S1vgwZif0O09IjFVrubMxWYvnxMgq32E2RcYvx0FOWIXObR4E
         C704/qIa7wbI8qO/qkDcoew3Bg2iN48bXB3I0L8oWfndsPj0A6uiR6HlHD/oZbbTkupi
         t2DeDU2zkYqsr2NlAy55MjvdtnpYl7dSXONsWgomZKsyMCmuZMGB/ggkm8hs89Y5iVJt
         dErQ==
X-Gm-Message-State: AOJu0YwUwioJZcswtDxtX1Z3e12eAXJHlnjCBxdMtT6ttvaPe3U2/r9I
	o9xzdZigFedjxjv21n2S6Cj1CQDakdr+IuvRGxTVWZlBv923lbvJUyr5bw==
X-Gm-Gg: ASbGncsbFJTforQSQz8QeFGVvZGfIkZvJza0BzF0sZp9A0woPdLpvsx5tuorJaT1BLV
	pezBYQSebaqIP+kHRugcNqtrlqgdV6LgzqnumSIYs2Y4U9xpk0/HDQ0m1sTbqyjX7nmto1I5FpO
	mQ4+cR7tYAVm0cNXoOdo5XprfX3+SRdHzQTcD2HFiSmtxc4dWCAm8WXW4Qf+kfBxFP4KkVTY9+1
	3xdo6Y2oL7hnZ/X3Myk6EmvGKv5molZ8CC66oEDQWAtr8hwvcqRyjL9YpLZ3w==
X-Google-Smtp-Source: AGHT+IHNdVwb5h098YLfwltHW9pU0H0aA5ASPDRROLGHd9Wt1PBWjrVMEQZqJ8BhF4EnZ5cGfrpQaw==
X-Received: by 2002:a17:902:cece:b0:216:282d:c697 with SMTP id d9443c01a7336-219e6ebae8amr32490135ad.27.1734701931216;
        Fri, 20 Dec 2024 05:38:51 -0800 (PST)
Received: from [172.17.0.2] ([20.172.25.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f68a6sm28761815ad.212.2024.12.20.05.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 05:38:50 -0800 (PST)
Message-ID: <6765736a.170a0220.11ba90.fb1c@mx.google.com>
Date: Fri, 20 Dec 2024 05:38:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4129934733621714888=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Fix driver sending truncated data
In-Reply-To: <20241220130252.1903536-1-neeraj.sanjaykale@nxp.com>
References: <20241220130252.1903536-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4129934733621714888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=919895

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.43 seconds
CheckAllWarning               PASS      26.94 seconds
CheckSparse                   PASS      30.62 seconds
BuildKernel32                 PASS      24.63 seconds
TestRunnerSetup               PASS      435.86 seconds
TestRunner_l2cap-tester       PASS      20.55 seconds
TestRunner_iso-tester         PASS      30.13 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        FAIL      122.19 seconds
TestRunner_rfcomm-tester      PASS      7.57 seconds
TestRunner_sco-tester         PASS      9.22 seconds
TestRunner_ioctl-tester       PASS      8.05 seconds
TestRunner_mesh-tester        PASS      5.95 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PENDING   0.46 seconds

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
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.161 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.194 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.170 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.157 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4129934733621714888==--
