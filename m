Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419BFA47
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236678; cv=none; b=YDEk2D6+ga2LmeD8XsoKcTjcw3Kbp3IONlgCIG1Q6DVM3MuJz4itN/Cjtzb8LRFy3YS7dfqPa7dSXE2X0DAA7Tljhe+Rfc/2l5p5At7GnG/t2dMABLCmbGYGY1N3Qr/jgYoA/GFbwwN5knzVY6To+rVkCMhlvRFr4QO7ne4TGcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236678; c=relaxed/simple;
	bh=zxj2of243bv1RnGM8XwnSJ4nopQ2C670I313IP/S7kc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RvDvAdk1tP1ezeBkv+6YR8a40pfjynioHI9Dw/HztCNeQhGU/FNfIVDgaTXisoDy6jeFEV93Q4QPVfO0M4P+qVCy0rfQT04ZyGuQxESU5D+0EMIvneHDIOxvx7Uc7kAoBl8IZYfUD7gX+1ZWfyt9ugGY4Q8Ujw/9uHsa2SqFy6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qluqgje8; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qluqgje8"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c56321b22cso490083085a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742236676; x=1742841476; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xjG02uRiU0nvQX/jumTAiKO1lffrr6EWjI52oudBneo=;
        b=Qluqgje8MaoNSmcgz25b3F5qQoVXkuoFJyX5+8a+qwdooTVFMRYKdIdeIaH1tNtEzi
         9BdD/R70EwNl5qwxhrLpTpXvNGjpzGtVH5+p4XFXoPATYFumiIriqxW3eoNibHvjSM+O
         3z0e5KccRkMkshXfNLMSU2bLjHOMQVrNlVnMp5nNuT8Ptz/O9f4L02hppOcxT4+5Tf/z
         0xF+1s1PuzU++KiaKsPvS4uoFeGZ7gMsmD2VS5DV460pF2kjLciGy2r+BG/e1zedvtcX
         XCTcoDrTZaZI/XsEJo49PEgXCHG6WquN8o85Rr32niNaJdVDAMDjqP7aBWjUsxNnA7HC
         r4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742236676; x=1742841476;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjG02uRiU0nvQX/jumTAiKO1lffrr6EWjI52oudBneo=;
        b=QPZH9ckAb/qHB89H+RZOYkZb/yao0hpLFpgvb1/BxBhlrgP8FdC0/WoWnd+gXgBo3i
         4UewaxpfVkWYxAZtMCwkhRrdbkuemK9fD70bwMi69oyrmDao0kU8BDdhMZ9maolPAYZz
         ddEtyJlNT+QWLs45ryH7CT4lUKd79DU/Aqze7utrza/uUOPkDRPoQMssfZ5NK2ETnXQT
         Bu+tpWVzkD5KWk948SJtUfE44J6MKMxKSBU6VvAUlhBnl3RD8W61APQj4DxT+VoKuGKS
         0dUQ0LCFNtx170lpvJwHyThBBbJK8qMxhbzpmsw2ci2dNfL2l0YC2EziEhcVb9URZzYd
         UarA==
X-Gm-Message-State: AOJu0Yw/XsR2LcCXo8269qytiBJCty7aqDELehYBjssMiyIvoOs4LgeB
	qhmcfEza7fNHfIzZe/XXyKzw//6yWfrr03NETFkkAZIy5Vom9sE1dIzfbA==
X-Gm-Gg: ASbGncs15DMpw8uoZUfAAv6jtZJwNozE6x52Tx06E5aRH2tTug5Z6xXkFOOieQ5tLir
	BMT54rIcysTk7OMgRNpSIuS8KNJzuxPDdwVPSORXVbTi4rEziBVuhPGzrN4u0FtyF7IhpXIbeQn
	cjpMpUiClSoQhqtb07SL6PCvdnqBczm/7YdYns3uINlA2vzBG5f/Av3kZ4aPpMo2OHHec0BzKCR
	kdKG4W+5il8KTgS4G2xn1/aq8BooIbFWRJXNS5TicWNKzVP5dLVIKmz221C39IBrso5KHdpg16G
	8UnKoq8lJPsOC4x6HPzCmYWpYnCNZMRfIi3nNuS9QP+iShIjFB6fuUbFqQ==
X-Google-Smtp-Source: AGHT+IGhBGD/w9aPP+od1qCn5vpvoP3s2D8J0bAGydyh837dii33YilPIt2zm4dKmVaZYekJj1ULjA==
X-Received: by 2002:a05:620a:d81:b0:7c5:93bd:fbf2 with SMTP id af79cd13be357-7c59b8aa8ffmr85894485a.19.1742236675805;
        Mon, 17 Mar 2025 11:37:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.15.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d6fb61sm619069485a.73.2025.03.17.11.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:37:55 -0700 (PDT)
Message-ID: <67d86c03.050a0220.38e2cd.625c@mx.google.com>
Date: Mon, 17 Mar 2025 11:37:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8584339708236190073=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix missing options not using most recent value
In-Reply-To: <20250317174143.530997-1-luiz.dentz@gmail.com>
References: <20250317174143.530997-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8584339708236190073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=944804

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.64 seconds
CheckAllWarning               PASS      27.31 seconds
CheckSparse                   PASS      30.69 seconds
BuildKernel32                 PASS      24.30 seconds
TestRunnerSetup               PASS      436.96 seconds
TestRunner_l2cap-tester       PASS      21.63 seconds
TestRunner_iso-tester         PASS      37.29 seconds
TestRunner_bnep-tester        PASS      5.10 seconds
TestRunner_mgmt-tester        FAIL      135.73 seconds
TestRunner_rfcomm-tester      PASS      8.08 seconds
TestRunner_sco-tester         PASS      12.30 seconds
TestRunner_ioctl-tester       PASS      8.48 seconds
TestRunner_mesh-tester        PASS      8.82 seconds
TestRunner_smp-tester         PASS      7.55 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PENDING   0.76 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.144 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.170 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8584339708236190073==--
