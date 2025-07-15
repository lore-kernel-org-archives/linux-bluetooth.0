Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B952C376B
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550534; cv=none; b=NKc9Pwt0o7kHBUamZCgdByNfJmGAkmrpa+dy6/5k4X5dbqD9Ly2VRdb5RH9XlmiDGGGF7PPKTPYPUQnO0E0MdFYiR/TniaeGWSXhbY5HIdXPvokhZYtBTkz3434jCzWkdtbKd6t99eaF1W3XUAf0vRFR5j6fbIY0s0fxIaYYGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550534; c=relaxed/simple;
	bh=A/ejrgYOFDaObNPU/kyCxAihN/sT9atF16OUq8xmvL4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZlGryp8JP4P1ruj6kVcgcEEgHeP3vLBeqpQAm09oCQhplUREi2IzZmtUte+CYooBeO6M3BXh3h6UgTJhmkTDGevAInnuAH2TI316NaFDCVoDbh6TV80MVXkifGIjnkSpJ+96NHIZPRM38TzHCZKkvSa3NAluwnjvqcdM0/Gf9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNxACc0w; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNxACc0w"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748d982e92cso3256842b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 20:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752550533; x=1753155333; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zLzHHfv+bbnc7mL7zYdpm6//I+tc26RbLjl5EbcwU/I=;
        b=CNxACc0wpncjdPlygr8apDr6g0FRSe/uoagtpnIc342ElRamMrSM7y+ZZ0K2h6JjMq
         gXaYeC7w1x/AkaZPQAe6lXdC0dgitNsadHen3f5RiVL1NXN03ukuZHTKCyb+s6Pmv3Bt
         xNNqzXVCSqktcgGGzzQghDX7f2ehWlWJ35avuTFBJkwaTAABYErV7L5ghZeh1hi1YeW7
         RQg6wocVCB33axLwAb137ebQ2uX71PWw2xMXRfotUwFKSxjqR8orBVjnbR7smQJq7kgM
         /Zr++NCZan9RZBSlDCqs74uVCAJ93v72A1c7Tf6W9BxRZRayD0pafXTOoUwVkbMn69G/
         xyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752550533; x=1753155333;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLzHHfv+bbnc7mL7zYdpm6//I+tc26RbLjl5EbcwU/I=;
        b=EF94WVqqf9XjvCz4hvWgV4Z8ilNPIb16a9mYEo34MgcFw0+EHQLuYsUAMcdJgoBK7x
         MyThx76Yudorhv+Q/bjoK6VbJAJmcb5zzXlL5mgS1kr4yxVwED3Dz8YQuowsQtpEBZvb
         ugluf7p091d5zA18BlfWcyzw90CYyXasNWRIET/JOjNdueaFhd7YTClvAJpw+o1mKloc
         uJ8XoW3oeN9ZlxgKbVt54SCnO5hPfvJcNX2+4fMLQl5L58vQcBwZWzjgblqdfppFwdJx
         aZKyhqedFS8P/gZ+dtrinoievqKwwBJjyTsXOl2KlPWGaIqgHQBqlzhN8REtvuYLECXH
         0o0A==
X-Gm-Message-State: AOJu0YzhD4mpnmCRYbYs63Vewsvyifixv+eyWcRpmo7e2dWyB3XJd7D3
	bvplP5ECvPNZOWhS5EVByu5BUMwX2WRZtuzf536y+PFOsll0UKyMOnRkCRVIKg==
X-Gm-Gg: ASbGncvOI5nmwfnkJS0T8rEUvDTWdDB9i2LyPGGFAYz0Spxo3L/qdtWECzPd+T7YcmL
	DJb0O4KQd094mGKbW0kW7/N8a2bXx21GjJSK7vsnJ8KjoaDw4hLBicyDmBRloRUFC0GW7IZ3svj
	goLidgi8x64YX7biBJl1Xv1RoNpHjBvIU73cUjNuDGs/1Z3b802lX7IxcXRJGZJ0TIGMeHiYq/T
	T0IF3Pa1NSCfRkqXGmnnhjNXAmY83q7+mToZ5H08dEbIT9ogP7h9vLkzWCYMKUuw4gK1LV0haI+
	U/rMABXp0CUpixAKEjDrxsqqi781ZZcsi2c1ophgBDYJ2YQ6KVZAibgg8+YWJwig8geu82rFUI3
	+WtkxLjdC/LjUHm5YtBW1GaignI+6tv7NsNL/3OFEEA==
X-Google-Smtp-Source: AGHT+IEalLca9OpGJpUeDd43wJzFs9Xm0g68ECAOThag3Vlwz+KCbdcxsGF2HBr8OZXMqpiVBYAWeA==
X-Received: by 2002:a05:6a00:22d0:b0:73e:2d7a:8fc0 with SMTP id d2e1a72fcca58-755b24dad18mr1964792b3a.1.1752550532486;
        Mon, 14 Jul 2025 20:35:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.224.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06973sm11680636b3a.57.2025.07.14.20.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 20:35:32 -0700 (PDT)
Message-ID: <6875cc84.050a0220.3d96c9.e625@mx.google.com>
Date: Mon, 14 Jul 2025 20:35:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2163733800279594984=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: hci_ll: Fix compilation issue
In-Reply-To: <20250715030318.1007009-1-kiran.k@intel.com>
References: <20250715030318.1007009-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2163733800279594984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982292

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.55 seconds
CheckAllWarning               PASS      26.92 seconds
CheckSparse                   PASS      30.52 seconds
BuildKernel32                 PASS      24.55 seconds
TestRunnerSetup               PASS      468.24 seconds
TestRunner_l2cap-tester       PASS      25.06 seconds
TestRunner_iso-tester         PASS      38.01 seconds
TestRunner_bnep-tester        PASS      5.95 seconds
TestRunner_mgmt-tester        FAIL      135.29 seconds
TestRunner_rfcomm-tester      PASS      9.32 seconds
TestRunner_sco-tester         PASS      14.64 seconds
TestRunner_ioctl-tester       PASS      9.91 seconds
TestRunner_mesh-tester        FAIL      11.41 seconds
TestRunner_smp-tester         PASS      8.45 seconds
TestRunner_userchan-tester    PASS      6.14 seconds
IncrementalBuild              PENDING   0.88 seconds

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
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.168 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.233 seconds
Mesh - Send cancel - 2                               Timed out    2.005 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2163733800279594984==--
