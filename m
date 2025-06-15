Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1695E1FB3
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jun 2025 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749951340; cv=none; b=Avmgo55g4sEcNtIuSv4AwXgWa59sd9pbiWgrkhpQwhSF93dIHN3oP3ZX59dafcbozIOBdJfAuilWCyNGGt+Rzx/gYoJsVehfiWyGI78/eTc8raNl2qL30EgwbcbA3vhnm0kcPzXCqz5hb8nNpgadswSrCVLSTaOMx+yMAp42nLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749951340; c=relaxed/simple;
	bh=tkVeAa8nwMTpUmYCO9ooTr9GnyH5BtysFh/IU2UP+3c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MH2Z0tZqfogtnMImzTopM+h4tyVPfsOFfXZz+WvOjXDen/4Pd6+AMgkf31V6LSJ7Uxu8wmYIdUGU8yXt0m2Z2qYXQCx1sKZfULJXBGE1xDPaOhYWh6i9/I95q7nuAzEAfj4U0DO6Sxc9X+Q3056oPp6ExDrNbGLdOZkzVUTI2pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djySt96J; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djySt96J"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2667708b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Jun 2025 18:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749951338; x=1750556138; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uDrpob2ImsiHlVXJpCf2ShV5UNrKd1CZKmFeIFygq+k=;
        b=djySt96JIumvCAUeDFuyGugUviUC7onpf8Y9pQ2rhBnVf6R0YSwk42P39/6/vARcmQ
         Om6VXwhTNiMs8unIZDeTw5DNKYDlLuEVHntTJNYVH4c44ltYmlKJPCLxHQQ1SAeKAPeP
         lrPovQb6LIJZbTMSWSYIK435qMIcTc/VTGncCkYuLXq43emDWNZd+F5olJhn3cGNoZo/
         8ZdXjiyGjmJpvZOOJAYAm16QHAXDt8AqWEu5ZzAqLbwuTGXCenmXKBQ8yu8/LifWdwqy
         eKzvwOgP7+PK2jdDlVMGI2Y3hFYm4scm5+j9m5ih1a1r4ryKQNGFnfq8TUYSx6xzSbV4
         qp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749951338; x=1750556138;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDrpob2ImsiHlVXJpCf2ShV5UNrKd1CZKmFeIFygq+k=;
        b=Gy5SfMJVk7BR3RtA9XX9ROcsqgwT7DaPxIIEnJBK129QNRDn6VJPX5zxbRFaU4vTwk
         Ik6HJ6kjLy4+h4lxQuOMoMooVVXWPuyRQXda9rUQ8vZ6DYCcjIpBTLxwB+DIZpmzD4MC
         h6Lbw/KpiU1bGz7w9VRvuFDiFvLFiOipWsn53ML/4owBnVK4MxFZ9FDDzDjFk+Os3IDM
         8vsmJWpLJRweasaoTIV0uloEMo28xT3FUaN5ZCd2qtcuFAdoZfmrQMj2htzBn2XpR+ef
         PibZtmT7G9IFYishrX6WAGyf2cQ+Kx0gZj9uAIZNoWohIPGX3BbkGqnHUV99XgmDAhGW
         dBOw==
X-Gm-Message-State: AOJu0YzqyY+JpRi24Pmdk8tPqk60khvzqdd8vxUrAjCZlV8d3KvMfAQ9
	zZSRcYtw5utMW5QYggRuADVmXFX5iay7kocdBjW2aAJ+sXBXsTVttV0i5H4NwQ==
X-Gm-Gg: ASbGnctAEYjJ6vNoH4pL+w4dUao2chCJyhcH/szs6sNiMpV96whhwuWQ9Sw1U2UEeEm
	ENsV+WlHeENvI5x+SFmVBZYNroQ78uf874LVYri4RbbcHxTWvGc8SKtEuJdIc2PSoo3DRNxMC7a
	U0UronkELoR0OIbyj3UMTlTB5+/j16+r/PzmKaUX/4NLI2NILljApCmYcQOL8rm4QPz9YjmGfN6
	eXjb1IV3jsb6kazPKJ0508cal6JKpD3ImPQqUf9W3gA+wj2wVz6m/NAWx8vA/qsXlEtbiRcrizE
	xwmnBDWASUuP7DnA1HVcj2eXNTgn8nkEmq5rsLJSPcTQXBF2kf08CYwMa8M6naYG0PCB1g==
X-Google-Smtp-Source: AGHT+IF2cq907NMky3lLMc8Wka70wI47Jk4nkhswKxvNhvGuo/c8OrGk7vEneTGb8OJnYQhHWFxnUQ==
X-Received: by 2002:a05:6a00:2e13:b0:746:246a:7909 with SMTP id d2e1a72fcca58-7489cfde72fmr7082464b3a.24.1749951337874;
        Sat, 14 Jun 2025 18:35:37 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.10.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d2897sm4157747b3a.173.2025.06.14.18.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 18:35:37 -0700 (PDT)
Message-ID: <684e2369.a70a0220.38edbd.69e2@mx.google.com>
Date: Sat, 14 Jun 2025 18:35:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4094907672189455716=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ipravdin.official@gmail.com
Subject: RE: Bluetooth: vhci: Prevent use-after-free by removing debugfs files early
In-Reply-To: <20250614235317.304705-1-ipravdin.official@gmail.com>
References: <20250614235317.304705-1-ipravdin.official@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4094907672189455716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=972172

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      25.09 seconds
CheckAllWarning               PASS      27.22 seconds
CheckSparse                   PASS      30.76 seconds
BuildKernel32                 PASS      24.16 seconds
TestRunnerSetup               PASS      457.94 seconds
TestRunner_l2cap-tester       PASS      24.93 seconds
TestRunner_iso-tester         FAIL      7.78 seconds
TestRunner_bnep-tester        PASS      5.83 seconds
TestRunner_mgmt-tester        FAIL      131.97 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         PASS      14.57 seconds
TestRunner_ioctl-tester       PASS      9.85 seconds
TestRunner_mesh-tester        PASS      7.27 seconds
TestRunner_smp-tester         PASS      8.36 seconds
TestRunner_userchan-tester    PASS      6.01 seconds
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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.156 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4094907672189455716==--
