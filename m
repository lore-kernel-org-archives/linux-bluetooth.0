Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C40C13790B
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748468076; cv=none; b=JgCwYVPH/sxTxy9iFNIdRWNA7kxnhwWp43R9eCfmCcZ6CAOdZi3RqmX6Zhxy0fibawdBlRor12J8H6q+UX53VHrL1IYMdUbXo1SI9vagrVlnmZi03osFNwZrZC9kCsz4bs4fZDhRmPy2/oftWRS9BjMIl7Bl7NPvk4aS4xxb8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748468076; c=relaxed/simple;
	bh=aWEJJmDsEm1+IkrIz9HuzcbKSVEUIa8/fU25sjGLwoM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Dci77mKg+WC3MHZtOpbiGkwjwL3pyZ0TkWgw5Rr31ZIz96eRorXF3MtBzfiNyY5GI3DGwx3vM3CBB26sv9W+y84DMx963S8GEzdG+drbzETQvj5KS/mIVQcoPy6HSg8kONHhK1ECHo7I+wiKZfkMpGEPicnOrizkKSzIDYpQKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3d95xb6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3d95xb6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234488c2ea6so3072335ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748468074; x=1749072874; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6tcNoCzYjiHWf8+32+Y2I0+5CJgNb0BfTPUrjRfgu10=;
        b=T3d95xb6nigHWAFrsw40jYweij061B/4+/pS9EJxUPeDCPVLnyLIM44hMqOVEpKT7U
         wbe/YLmhmAxaLvIJsu1pIJkn13/gmq+aMItZ+/GfWIyxKfehGo64CMS4DZUxEXOul/vk
         SQym2cCXX9VNYr0oHXYNKnFBCa7XhVnF3v9QzVb+B+37Z9Wp5WwQIaxA0uLzyYTmAv9M
         PNixWJP69Y8AJjikvx7c0H5vN2tEz4xCF9w6xK2aoT1ClttABTWnwvdf7jHshEAnqyzZ
         eYHvgalmeuDKqVhSU7G/iMbN+g+PpuJQTaZBf/gM2JxDQ0eblK48DavE8eOxsAvSSXRR
         qw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748468074; x=1749072874;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6tcNoCzYjiHWf8+32+Y2I0+5CJgNb0BfTPUrjRfgu10=;
        b=CkbXnlhB9CKd6I0x/rU5cLdBlQO3JY7NcnbbJWEHVkKH1fes/tSra/NPcUR5UhFOb5
         regfbwAltnpFqScSWW2RJV0Ouu2uVsGRP2unMWrVU6AAMb0kUDKUWQvc4dZmvwDbpwVn
         +c5Q5aQeitKov3Sy8m/WSJJQt7UR7kXvLWUXiwd+esjpDFEHOFzPzd2kjd3PO4780dEL
         8Pbhl7m/3R+sDakN33wtpKR3ed1qTBwfKVGhkyIvd82Z/+wnbjxX+7UMFJxci59QxZ6k
         5KyclNYVLKXGzmn7NYd5VMfHqVwe1alQXB1wzSZ944COfRuFyQUhlQWTlgfLFCjMQ52d
         wrwQ==
X-Gm-Message-State: AOJu0YyUH8x6kiFvJnCQo2BtpPKWrDfSTQMFdVju1OMtaozmi6KR1DlO
	ItMdM/2AD3qVy7RjcPrinauZNeO2Xz7BrwucfxJtiLYr8+iyJ84h36ToZ+emag==
X-Gm-Gg: ASbGncv/QE3fHGnT7/ubzQ3kAoywPtAfn3crwAWcUPBatnAti45ZC6EkP9QfliTLSQp
	nEyd6zr7TU4qq24Rfl3ja4L2xGpUR4C6kIwZ4OySVMJRxOTdRSvQDN5OFE5fm5A0GcemNcNWA4f
	9vpwkrMjb/aVP71sR8gck/n1CHOzBVEvi8S1PmQJjz9pmdhWTD3KA+J7IrbZ1qbrg2dB/7xSxsR
	o09ArP93t/chWzpJVuvmUWzG8NGLx+CehVOjDHwrVrGW0LaDi6AM63Mbb7ml0nekzowq01wVb9C
	9+4GbU9/WplFLGHKT9RfCuD2DQmEOQWQpPKNtO5hO7plG93wR0jJrLRpT1bEnyy94xC2Qw==
X-Google-Smtp-Source: AGHT+IEfHAGNEdrFzkE5R4bHcoM3a3XmRNxwLZT2vdh3k0nEpumUEK5Z4JXC/TiuEl4vNczl6ANkZg==
X-Received: by 2002:a17:902:e5cc:b0:234:c549:da0f with SMTP id d9443c01a7336-234c549dc1dmr72669085ad.17.1748468074031;
        Wed, 28 May 2025 14:34:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.160.165.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc861dsm514785ad.4.2025.05.28.14.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 14:34:33 -0700 (PDT)
Message-ID: <68378169.170a0220.279e37.033b@mx.google.com>
Date: Wed, 28 May 2025 14:34:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7380039713377069323=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: MGMT: Use RCU-protected in mgmt_pending list
In-Reply-To: <20250528210718.100679-1-luiz.dentz@gmail.com>
References: <20250528210718.100679-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7380039713377069323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=967137

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.39 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.71 seconds
CheckAllWarning               PASS      26.96 seconds
CheckSparse                   PASS      30.34 seconds
BuildKernel32                 PASS      24.25 seconds
TestRunnerSetup               PASS      458.62 seconds
TestRunner_l2cap-tester       PASS      25.28 seconds
TestRunner_iso-tester         PASS      51.89 seconds
TestRunner_bnep-tester        PASS      5.80 seconds
TestRunner_mgmt-tester        FAIL      156.30 seconds
TestRunner_rfcomm-tester      PASS      11.38 seconds
TestRunner_sco-tester         PASS      55.78 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        FAIL      7.52 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.15 seconds
IncrementalBuild              PENDING   0.50 seconds

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
Total: 490, Passed: 470 (95.9%), Failed: 17, Not Run: 3

Failed Test Cases
Stop Discovery - Success 1                           Failed       0.162 seconds
Pairing Acceptor - SMP over BR/EDR 2                 Timed out    2.227 seconds
Add Ext Advertising - Success 1 (Powered, Add Adv Inst) Failed       0.150 seconds
Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok) Failed       0.125 seconds
Add Ext Advertising - Success 9 (General Discov Flag) Failed       2.157 seconds
Add Ext Advertising - Success 10 (Limited Discov Flag) Failed       2.167 seconds
Stop Discovery - (Ext Scan Disable)                  Failed       0.165 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.192 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.236 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.180 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.189 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.208 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.271 seconds
LL Privacy - Remove Device 1 (Remove from AL)        Timed out    1.971 seconds
LL Privacy - Remove Device 2 (Remove from RL)        Timed out    1.997 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.762 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.184 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76b/0x7d0
WARNING: CPU: 0 PID: 67 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.140 seconds
Mesh - Send cancel - 2                               Failed       0.156 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7380039713377069323==--
