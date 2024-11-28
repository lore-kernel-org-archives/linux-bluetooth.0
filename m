Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFAE2563
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 03:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732765678; cv=none; b=HLTdSMFD4HrS3MXnkap3sh/kYka+GF1E2SmNYgpmMYxEgF2/3NjdYpRO3BD3e+bdfiq3aLNBc3FZ6UHn5vXOu7I+m8nNupdBHBfrerLU/jii7cWjU6kfi8eKX3NqnC2qTBfjyvFiIRiQFt2AUfJ+iawt1UPOnkjJZOegkhnVqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732765678; c=relaxed/simple;
	bh=bnJslEpmRYhHSDtEgKSarg8CzjRbksw40kYK67JzjVs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rAiSX2GWoX+1Rq3CshqAs6b/H4KI5vfO4xSsRizk3Ou2OngMrDXE66pFzNrkSuRISaPbjZoGNHK6yK7edSaet58FaqSryblnDuw7LXkYXav50cvdTVyf/PgAu+WYVSwN+LQuNiaQO6+zmgUrSSZd580a1tLfAa3qFr8unZZUKsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCJo5aon; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCJo5aon"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fc93152edcso325826a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 19:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732765676; x=1733370476; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GCkSj9TB63VU/x+2+VzjjC8xS5FMYDbg8qPm3LVqsNo=;
        b=OCJo5aoni0ST9q0G+NSpGB7ErwlE3ewGJIxW9KKMzINMDImlbY5ryF7JbrC2JHxU/m
         r0Ga1Rp+XNn1GD14s//MTm2DTbpBTz477Qfqd8Sk/wX9mqwATKdJrOiuMfiXL+Qv12ZD
         WfkQ+fzEI3wgSdNU65YF5LeKup46QffC9JtE3ZslTp+aIZOmGWHcya5M0O0wPm0x4nhY
         funEw5oNCCN3iUM3BZRoNX/cwd+I00Y0LLLSE438W2ZMYhkZVaeetEC8HtIGGp4nUTZM
         123uy+4yTOFSwHeEFBOT+D1NDH37BC84Diozar08xCKAg2+03kI/BL+dx8nB2cvb3/F5
         Lqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732765676; x=1733370476;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCkSj9TB63VU/x+2+VzjjC8xS5FMYDbg8qPm3LVqsNo=;
        b=HBrXkl61oP3HcEeSRzlaxFjNxIcPcbo0ztbxfNyFqoaSSNe5u51ZeMOoQpo1ok/MDK
         U7OUYSkAd+H27ekwaAk06u04dJi6FXvTGSzBC3qUOjzx2YBPd70DBk07qTediHwBdFvx
         hKzDL4NDfhg3dSKcLoUAeoz3GMxNParm91OBUkczEUGY7NF8KP70l5cZeMFSUjahD5p5
         ARNO7DsHb1iz5YtG62DckXW6QYt+BTKbUETv5ynrVB/AzqaJ6v9+aZ+rtF3i1XP0W10p
         t0lcIB0C6NACwD4XyArnISN00T3yYZzSzdLA89hV3D+TinaHQCFuHWsI4PdU9r3taKRr
         56MQ==
X-Gm-Message-State: AOJu0Yz1uHEZ8RA3lrsWHkun9a5Lqe5PIOlY0ORCfK+JA6SBMcuhLhNx
	4/GzzoahMWteN8lhtPwIH/aECiYsXIXGZBB6e/F8a7RScQJTjE+paXnwOw==
X-Gm-Gg: ASbGnctclj5kD9xgCFrQ/qFX7y4X8zIyFMewtFWUQ8Gq+IyKoKTcAQ/7HGGOqmmPHsV
	LS76bGJ5QbunRXfDQIHz12wu/ZwZvUhBU/Wg9xObE7znBP4nP/7kj0LzpGSxWOeCVroS/9yzRAK
	2fNHtY3ZfiLkWd0FucgXixoRAOQ/w19EYKIsOLICGXvWddNGmXNkB+tKS9fQ4TyoB9o3442/zpO
	9rBlUKTD3meacKGwYHNpa97gdO+6kBwCi80FIM1//HaE9OKNdTdNf+n
X-Google-Smtp-Source: AGHT+IH8jPWv4LPiUGKJytunNFSQjHe3dbSTxm/RwnOfVUQWE5KgL7jHT0vDUIduYXNbgsl0ltKuUA==
X-Received: by 2002:a17:902:e5c1:b0:212:35f5:b564 with SMTP id d9443c01a7336-2151d2fe0edmr20780285ad.7.1732765674971;
        Wed, 27 Nov 2024 19:47:54 -0800 (PST)
Received: from [172.17.0.2] ([4.227.114.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521904f7asm3440405ad.81.2024.11.27.19.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 19:47:54 -0800 (PST)
Message-ID: <6747e7ea.170a0220.15b025.12c4@mx.google.com>
Date: Wed, 27 Nov 2024 19:47:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0312126452999020526=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, en-wei.wu@canonical.com
Subject: RE: Bluetooth: btusb: avoid NULL pointer defereference in skb_dequeue()
In-Reply-To: <20241128030807.270581-1-en-wei.wu@canonical.com>
References: <20241128030807.270581-1-en-wei.wu@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0312126452999020526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=912974

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.79 seconds
CheckAllWarning               PASS      27.28 seconds
CheckSparse                   PASS      30.84 seconds
BuildKernel32                 PASS      24.73 seconds
TestRunnerSetup               PASS      436.57 seconds
TestRunner_l2cap-tester       PASS      20.37 seconds
TestRunner_iso-tester         FAIL      26.54 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        PASS      119.84 seconds
TestRunner_rfcomm-tester      PASS      7.59 seconds
TestRunner_sco-tester         PASS      9.31 seconds
TestRunner_ioctl-tester       PASS      8.07 seconds
TestRunner_mesh-tester        FAIL      6.12 seconds
TestRunner_smp-tester         PASS      6.98 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PENDING   0.96 seconds

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
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.116 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0312126452999020526==--
