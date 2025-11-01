Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5385213AA2F
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762029347; cv=none; b=OCyh1yACB9r98o20JO05rNHpMFxlCmiyuQrQV3Wi9PMUnIZad9Dz8+n7Jq4ipImmtrvpXJrXGRSwf+e94XJ843q6LR3dshrCbA10Btb8tck4eCUlnwdR/CIFs9b3aBCsOlSsqBeNMDOV4Ugu37gZwRX8sCOB+KSRwaFEVMqQh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762029347; c=relaxed/simple;
	bh=BMxvXb85T2WteagFl/kR/woKaO5cMnuQ5lbwxUBy4ok=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YyHvHejr+qVJEUIWfMuHVW2qWRhZ8Euj1/iTioGrBbCohVH+REoS300T3tXF/52UAhN11fbCqu2aNpE26JqjK+7CfCn6cVZOBnKx9f/ovPgENlSArBlNgFW9iz82zVjaOfvEG74xibSUWkEbxwBR72QHpnzAR49HrsugTdq6VeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLyG7T+v; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLyG7T+v"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso2493576a12.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Nov 2025 13:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762029345; x=1762634145; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/6O1BvRLd8SyOnQTZ3YwZO3HUy7Wxvpa5h4mWNYXFZ4=;
        b=iLyG7T+vgeBHNsrCy5ejZ5VLWy9R1QxEJX97Hky00xZrcUw5P4z+xQvRxvHC4zvP7j
         kmvsCt7hI70S0DJtB+BHL++63ni+NxFpKr8TKv92wfwT9yTZ/VOTqGpAp3sIsFnTWF5F
         TQ1Z/aHEsEZySKMqrzASnMzPy3yt40NuU0wHaKHoeqDfbgWjrK/eYWP2Dot9w7NqDlUP
         nEaxHKwVqEof7xbo2uXZWybN5RzeigFmZjnLEU5bS9VRq35Q2VRcNd0MwE3uj43ya0vl
         f/vcG/YXB//HZEZnyUZvohh/9uGASPUAcVdBlr3GuZoW0AIr5hfkW1CocUDcm/0pm6mI
         tT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762029345; x=1762634145;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6O1BvRLd8SyOnQTZ3YwZO3HUy7Wxvpa5h4mWNYXFZ4=;
        b=BuD6fZDEDKG+fXV2qkhcu/aYP2xPC+XZ3coss5jU9t79IG+bfIQ2pPCmK/X/MdrLYW
         A4ZArxTfIKUuM/c+2EzsUiOsrmhnleTdnXxHiJPxgtcSJPiw/qgnKQkQmTdi6podWjX1
         WMTsdlJoYxI1p3Roj6jeMg8d0ZTG8hEODPcSpL6u4U2yxA6v570P5W73qcaT31Ohtpbq
         o0YonsqDbhwtlTTK7GqSx+QM5tifMZ3oKBqOZJgJdvUwmGtLpzT4NE7eLRZCJb6BaXDw
         b7Jqf+mr57SsOzVMa0Vh/SZ5xZFwxn96PGXdTs7FiOiB6SMYs2yrvdARRJx/KS9fpjZE
         MqVw==
X-Gm-Message-State: AOJu0YwO9Lptq0qd7/ebHQadBgKymdTPdfqXzxIqMfkoPiImU/F6t7C4
	KPbRPDLbRh0+Hpx97gZS7MltbReH10Xq2SFE9PlMLZ47P40YtJGo7tGexnTN7w==
X-Gm-Gg: ASbGncuQtxyU1iRDOtuwpqeA0kVSnDhuj3P8x3lP8rQuWcAKXV6kWbvwD6RkE7iydAJ
	JyN7mCfsCkkxo/Z35wB9U222z6jecrieJ30vDdVv4oUoViPBZuwoiSLFiPd81mR7EFMtjLCMR9Y
	NBpky2dqeam0dfQJ7h2VPN6cj/4RrmNmpmlWo3euhusikH+MuCCqU4028I9uNEEBMv6ERe/SePD
	3ulz7VjFm9YHPgv6RpVvMDP6TbdxE0z743JMvVIeSG9reb6boUTVebCm9zmyA7nNt5zxfrIuiSN
	VlTiYra/5GudymvQsjTAKV2Q8OyWmMEACh9h6TdOg+rWM4YnLSUtAdbZ96YRY86732XuNjxK4vH
	yMCJC0t4iJU57Hk33LXjE26HaEEbRlx9BVjnnvEltTqc2IUwplpUBFxKyNg1SaMRwV+dpSA+A/3
	FuOdGHjTZtQzP22UesHg==
X-Google-Smtp-Source: AGHT+IHKPbJed7u8KnugEvDKqFqxzYZLes7YfvYlpqsOsZlhR8ABYZRQswuJlCqtrOg/shX9KpoW8Q==
X-Received: by 2002:a17:903:1207:b0:294:a827:851 with SMTP id d9443c01a7336-2951a37a48dmr107157315ad.17.1762029345154;
        Sat, 01 Nov 2025 13:35:45 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.245.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699c9fbsm66244755ad.82.2025.11.01.13.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 13:35:44 -0700 (PDT)
Message-ID: <69066f20.170a0220.377e7f.aff6@mx.google.com>
Date: Sat, 01 Nov 2025 13:35:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7204621640503079015=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RFC] Bluetooth: SCO: make locking more systematic and fix missing locks
In-Reply-To: <9ca502845fc793f3f76c02aef316a273d3b6929c.1762026583.git.pav@iki.fi>
References: <9ca502845fc793f3f76c02aef316a273d3b6929c.1762026583.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7204621640503079015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1018568

---Test result---

Test Summary:
CheckPatch                    PENDING   0.75 seconds
GitLint                       PENDING   0.38 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      26.12 seconds
CheckAllWarning               PASS      27.95 seconds
CheckSparse                   WARNING   31.68 seconds
BuildKernel32                 PASS      25.40 seconds
TestRunnerSetup               PASS      508.67 seconds
TestRunner_l2cap-tester       PASS      24.11 seconds
TestRunner_iso-tester         PASS      78.50 seconds
TestRunner_bnep-tester        PASS      6.12 seconds
TestRunner_mgmt-tester        FAIL      115.61 seconds
TestRunner_rfcomm-tester      PASS      9.34 seconds
TestRunner_sco-tester         PASS      14.35 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        FAIL      11.43 seconds
TestRunner_smp-tester         PASS      8.48 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
IncrementalBuild              PENDING   0.79 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:153:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.198 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.874 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7204621640503079015==--
