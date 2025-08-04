Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADEE173
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Aug 2025 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300821; cv=none; b=AGJMNqweBkkOmLDYbj72vi1+xcaQWagxa2fra9hs4BqkrsxLC7ryauYASMBb1Az8bTncfLqnC/zJRbxjdtzb2vCS0bKAjRIoIOOWZcEsFR4NBzoa+SfX9z1Dy7++3IFwapVoJwu6YMi6iimZqZjSbtz3Ng5OK+ScLU1wwN7Pedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300821; c=relaxed/simple;
	bh=bMH8GS24fS0eAbP0+EOc7K13w29X/KofXCRAwq3djx8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D1L1Skd/kdSHpMM26xabWYHcUUA+J/BdhzvIga2ZgmoiK4lMaL+DrIOPUSOh6djJ8F1D1q1idKHRABM6aT6JILYxRxuMK/Fg0bdp3oeP5eT7PAy4dIF7307uQfsMZd4WGy05i+kHPYoDjAyhbDe92S8kyTATGkhjs/dWfFa/lv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhHFJSIr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhHFJSIr"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2400f746440so32311275ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Aug 2025 02:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754300819; x=1754905619; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bGHpXmelLmG47MjaZXE4rEy17WZsMPW/qU65Dq5mQa4=;
        b=BhHFJSIrG/jIfV9lBAr14gQ+K215uCxvRBuOyErgMiJtQFvLoGcKhFEugVbCyjSQVt
         Ad3q7bZFEO02flmk0DYGol99JxRLCKhWPQw1OXjsDsILrtsTzU/9MhMMRSxHjWVpOhZN
         NUdxI2cEnB26zHDfmamM3j5Grr/nlMuMJmjaUA+vXBB2xT0f2g4m0+BGH0ip1MV0E55r
         g+MhIrkA+BkS5yeNxRtY4S0IiwGxqa5fV4PRTFpRnuJKLTOxpn/6mPw3gPfEUCDPA9Mb
         AJQvWMsz8qT07w8KTtRUDIKUiLL0ejZjh0n9LiCJKfOBrDeQxvOM72p1MLngqkgYha5p
         tSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754300819; x=1754905619;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGHpXmelLmG47MjaZXE4rEy17WZsMPW/qU65Dq5mQa4=;
        b=jOvuS0uJlTTtA+jq02nq0+piu3NOSMjEtHQmUqY4t/w3qNClh/qDuTwVZx/uzRP6AX
         AO6awuvBg7OQ6o/BXyNP1IVXMdwi1U7YaizKIN0ujqDvWNkEGhD0EAYNtBTtt2yIbflh
         0KFHNOreVYvuFqzN6AhV3vt1gXOklV7U4bU1ows2shLRciAXLSyqLooEoWnuqJvxa2yw
         jlZzcfGfbf6etQOoOgF0IX3vWT6mhk7wrp0DfSL83rRIfN6z8Zp8kPLwl4uPbj1zVSy4
         n7CmmaNJoejplGyMTKCLToGU5PCSiz0TlUEH8Nf1rUV2xaMB6JcH9qUNREWpF91LJMo9
         5keQ==
X-Gm-Message-State: AOJu0YzMwmGnUsP12QLHsfM2lvw+v8X7pQP2oW741deN388n6YlrGhjC
	Z59qnNv1vT6lY5Pi6e7MS2KAIaFtvfSnjtAfrRpw5JdqYGhOe/xC1E9irBH+IQ==
X-Gm-Gg: ASbGncsyDyAW0S/ZNFfQLP0Z+n5KINPED1+lrIirYAhhO+b7T8j/Mv1n3SqB/oQ7onl
	XTFgQC1JqfNe2qfD/O8SbDErv5KPlJgQv5nB1TEvaRhhRLUCLD1r5tu28HdhSSyEfSC1tLIcQe8
	IiwJN61aKKcs0RW/lIIAl3D3hwyrWnXr/z2eVdIxgAueb/CPwpZKg9kGish9TIZeNLj0n6ICPgc
	guyj5o3FWSk1OLqmdcAFya3kwQpKjW6pDNOSqqSay69SONKhgcSuevAFEdiN8tlxpGcOYbQXHiH
	en7TlolOteMhNg83ejQNcso47AUFjQ6hrKn2IgiU6iR15mTl2aoDtj3D5S/3uPsWT4EDoTjsA75
	qbCTiSjPonrmFUqPwuwpb7kSz0e/zp6PaAM13zZzn
X-Google-Smtp-Source: AGHT+IESgjhBhLOVvucOLWeqx5NieM0uw6EQGvAql9zc0YZl7de/038wZuPXlbuESbfoAM73jk2hEg==
X-Received: by 2002:a17:902:dacb:b0:240:4fbf:cd29 with SMTP id d9443c01a7336-24246f6accemr121826225ad.18.1754300818669;
        Mon, 04 Aug 2025 02:46:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.123.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899acc5sm105135065ad.130.2025.08.04.02.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:46:58 -0700 (PDT)
Message-ID: <68908192.170a0220.366bf3.0f1f@mx.google.com>
Date: Mon, 04 Aug 2025 02:46:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0400780465425482008=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Uses threaded IRQ for host wakeup handling
In-Reply-To: <20250804085630.1082251-1-neeraj.sanjaykale@nxp.com>
References: <20250804085630.1082251-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0400780465425482008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=988058

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.46 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.08 seconds
CheckAllWarning               PASS      26.49 seconds
CheckSparse                   PASS      29.71 seconds
BuildKernel32                 PASS      23.79 seconds
TestRunnerSetup               PASS      471.58 seconds
TestRunner_l2cap-tester       PASS      24.99 seconds
TestRunner_iso-tester         PASS      37.57 seconds
TestRunner_bnep-tester        PASS      5.94 seconds
TestRunner_mgmt-tester        FAIL      126.28 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         PASS      14.97 seconds
TestRunner_ioctl-tester       PASS      9.97 seconds
TestRunner_mesh-tester        FAIL      11.43 seconds
TestRunner_smp-tester         PASS      10.17 seconds
TestRunner_userchan-tester    PASS      6.10 seconds
IncrementalBuild              PENDING   0.83 seconds

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
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.144 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.176 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.160 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.154 seconds
Mesh - Send cancel - 2                               Timed out    2.001 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0400780465425482008==--
