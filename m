Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E81D45F2
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688536; cv=none; b=iiaMqDqww8J27wm6SfrPUEqd0jehQZJC0y1b+HODWsgg8VBCLvPns1n0zrJVSySCZAzkkqw9q9Vn8rCSmYm9TUY8JKCjyNSmOWrahb77HkKYwDSvd9CitrSXg1apjeIdLE4WAlvMZcWzow0q9bWQSHNzV9+CezCTRjLr7w8QUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688536; c=relaxed/simple;
	bh=fN7sKgiiKWh9e9IVMnitu2PFFq5hgaXdrHeG9iEUTn4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oQC/62Vo80XRpYLdw/5c1ghMqWWCqueFNOcmTivAyp8hkgSk4y4tQOZJnstZ5CeC9s31z0/7UBY1WxBamuhBm4MBtRQuOsmriyeq512KTj74wEsXtUAJjMIelyCaM6sF5mVL3BdGuaN9eFUee85HIHAJD27zZKuH7gWdd8MAcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIRPcTd7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIRPcTd7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cf6eea3c0so22133525ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 08:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731688530; x=1732293330; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0KW6vlPkq1YEoz9Fjec1Q3fW9dZFypE7U0FzM+ViRLo=;
        b=BIRPcTd7aVkGcwz7oY5JojNBGAIGZmpLauG177iEFFh2VHpkiWv5lG053GuwiIIG8n
         bU5gGG8NoOgQOknsxw7D2KbXh/gg8uoqs682fMNIXwouuhQGvxaMCtMDBmGqMUJjMbR+
         XUWvfPzRMavA33O4S+UNN6vp3zeXqu3v5N9jV5xMNBqT54fEDc3dKGSdGAHUgxRFZZhk
         lULL81FLI0d4eW+GSwszOV1sZ5QQCfAZzfnMUSPxHlhAoE2pJWPTheGRHC+DpV3yeswF
         oN/iuLsArDisvdhdwVIoavLLHE0edDnICxL/mA005Y5MECsp29Qa1IER4YiAOxWaTwgf
         LDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731688530; x=1732293330;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KW6vlPkq1YEoz9Fjec1Q3fW9dZFypE7U0FzM+ViRLo=;
        b=kZl3DC4elhjxpWJ7jrUjg1YLeG3GJDi/M5iK2pHzAd4q9rjMdldnpqe9Qm7FScsw9u
         9ontWdCQd+jMoONrikWaM6/mKYCxqmId0uwwBaNHzdGSmnTkPLQlYiGQQPL6C8/jAOVq
         uFBWWnjOKhz7wSStk6Lj8kAQIvgpiYKmTd0ha6RDUwjS/pVtDVgon+5Vm/DYqHiZSxrW
         tkRCQxgXoWbJpKn6Xbe92Cg5NkY1S9f80VdLOq8RY4CITw+Kj+O0bWoEpYTu/DWguJcB
         zBgeNNtuDxrTOmBCKJJ8neY2hmtjs8kbuqLbUYZakSmOqxDpNBkhZudKDEugOJz8ajtU
         UaPg==
X-Gm-Message-State: AOJu0YxhkvcH79OMTSHrgu27lp+hZxJL8Q4iAhiajM8DOnCLJul0ph5b
	rqTJXqglWXjFc9qfTL1X3UrjMCbVcWQ6j8FCkD5DfTxcryZvA1AIHRroGw==
X-Google-Smtp-Source: AGHT+IGbllcRNDX6Nr6taRCrv35RhTrsctqdBdQf7CwbZb+wHh581g8SYYUMfN8WCXmvBIyZjaoapw==
X-Received: by 2002:a17:902:6acc:b0:211:6b21:73d9 with SMTP id d9443c01a7336-211d0ebf447mr32249845ad.37.1731688529858;
        Fri, 15 Nov 2024 08:35:29 -0800 (PST)
Received: from [172.17.0.2] ([4.227.114.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc5c94sm14315875ad.17.2024.11.15.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:35:29 -0800 (PST)
Message-ID: <67377851.170a0220.34a7d6.9468@mx.google.com>
Date: Fri, 15 Nov 2024 08:35:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2995186767259218065=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
In-Reply-To: <20241115155941.2118683-1-luiz.dentz@gmail.com>
References: <20241115155941.2118683-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2995186767259218065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=910054

---Test result---

Test Summary:
CheckPatch                    PENDING   0.55 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.06 seconds
CheckAllWarning               PASS      27.99 seconds
CheckSparse                   PASS      31.45 seconds
BuildKernel32                 PASS      25.42 seconds
TestRunnerSetup               PASS      447.59 seconds
TestRunner_l2cap-tester       PASS      20.79 seconds
TestRunner_iso-tester         FAIL      32.84 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        PASS      121.93 seconds
TestRunner_rfcomm-tester      PASS      7.70 seconds
TestRunner_sco-tester         PASS      11.49 seconds
TestRunner_ioctl-tester       PASS      8.23 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.25 seconds
TestRunner_userchan-tester    PASS      5.13 seconds
IncrementalBuild              PENDING   0.89 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2995186767259218065==--
