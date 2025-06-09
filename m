Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A03D544
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749468806; cv=none; b=Mkmw2CO4IF72gpV1ukIjeedHqksw36KI5kZ/veqYHh790hQPurSqUwetMLzLMrqz/Jx4FXj+DHBcaNxEz5OOOuXGhOCRaxruIF6R2lulVN1RD/D9UXdECvNTvnmFE86RdHtGNWwRKNt7dhXXkQP5PBZv3w8368TdXx0c+lnjAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749468806; c=relaxed/simple;
	bh=2Db42QGncFCIdghtotQ3fwgaOko9csRnArOYLW1uBFM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YgiAne2+GFQobVFNQfSZ76JHnGNkpbTl88Ff85FF0GEW1sicwS2Ejl3RzIOgmOkeI2N2NwngBLemhdhwcCWN8dMy51BGEDBU1Mt3HqPr9ngRYUXagTU5lD3PX5+WOehunpXX1O8mbXMZ9Gcm4AuAJ4ul0ht1ZN0OfwtYYh2qFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw1qbKXU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw1qbKXU"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso3526176b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 04:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749468804; x=1750073604; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vCLJ4SU4Oq0U1LROsI7CvWRH1EhU4TEXNDOuq7Jrp84=;
        b=Qw1qbKXU5izpjDlM85CeeciBcJqvPxAKSmlVPlPSdAEJKD239nZ8x8CC8lGwAF/SzF
         0+mD4gbI4OpuZMqWdSI3gTXSl2b+znVcohICKGVA5WiKddwRCVNNrtf+a0RcNdmcrpqf
         hgsLcrsVunrARLgdNI4vIHcoSrBwt1atK0rzYslTyqEB9o1/R+RO7MIny/OnseS7RM8g
         SbVQsYhY2vi7J3XhxRe6jKk6PnJRyQoTnbcqsJLbNa3I0B5flndGHChUnKubfK9iF+4V
         AWhLw/kR5bMNuQ6Pcd581wiWvlVmVM/JhARkliijUurABl4qBpHwbOiSCIpWBEFN5HjM
         Ndlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749468804; x=1750073604;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCLJ4SU4Oq0U1LROsI7CvWRH1EhU4TEXNDOuq7Jrp84=;
        b=q30HgKBKsPYHuaCGIy9wnHkJSNtMu0k8mbmMPCchIrJSUlZJd62cX92miwf8HpxMyn
         Qvr6CPmII5O985ta5MtivtLAjSkTwnKYUvSalt45iWUmI1VMDB0ZLgJdpvEyQGbz6jec
         XgszEkbCbt+3tUqfxfxzlJU5mYZWVKkYD0bvXobv3BjK02Cy5p6AC1jPYg1MKLmCQom/
         slKwuTuXaYfC95xffMc6jZjFy36FFGBxCCvRSHDKuaCOMoRSK0m6ylYG3W3ELTXPwE0y
         wuVmFjpzYt1TNZvnB8mpXCugoKY/DBiKiuAVoUky/TZdXxq/+a9NmQ2wYGd+K7GFHH2t
         Ptqw==
X-Gm-Message-State: AOJu0YxXUyS3ET1WxWXRKJ+JaOCs3ZfGjLtHmhqup3kHKb3oqMSEiMcv
	IIxGaF2KqWkCadiGZEzcDVgIk/Mhv7uJg4skhOTVWRYevJ1iZvezGFQ0fT4rwg==
X-Gm-Gg: ASbGnctz5ilFLFXxPqCOpQdpcGtSSt+VhKCu8OYSaohy4/VGBSoksyan3Gfyl6AHUZG
	Fd06lJIg2yCagC8Fd2m9dlGqZVb5HTNPcys6zL6VuJxmblunPVT9C/ACqU3WekKoXEL2lad8qU/
	pWcSMq7m9ED0GRN4MGthrhjaBHSTvP4ZRo0pU1tpAvzyEG6ETquxYVuo8o3bcRuJRq8XkNfXN/N
	DR3QtH0/BK4tY1LPDU87rpd7b8Ocm3szA1z/soL4dWeoQIv7VaSiKVTq6RaqAKwWXKNadbAd4ZT
	qmb1M4UbOMlkPdce40qZof4cnTsFq/oaRmvMGGAEeIXE7X5GLjfx1ebA4A==
X-Google-Smtp-Source: AGHT+IE0nMyTOoqEPkq0q75sWsZ1NnntcHmk3tWUOTf++ce5/8Y42EnEfidqfm9aeKeyiBw1H81lVA==
X-Received: by 2002:a05:6a21:7a44:b0:1f3:194b:30ae with SMTP id adf61e73a8af0-21ee250cb7fmr15654075637.1.1749468804350;
        Mon, 09 Jun 2025 04:33:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.28.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af7ac8fsm5518617b3a.39.2025.06.09.04.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 04:33:23 -0700 (PDT)
Message-ID: <6846c683.050a0220.10105.13e7@mx.google.com>
Date: Mon, 09 Jun 2025 04:33:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5244897821661631124=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v1] driver: bluetooth: hci_qca: Disable auto_off when BT_EN is pulled up by hw
In-Reply-To: <20250609105538.4090716-1-quic_shuaz@quicinc.com>
References: <20250609105538.4090716-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5244897821661631124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=969791

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 FAIL      0.37 seconds
BuildKernel                   PASS      25.00 seconds
CheckAllWarning               PASS      27.07 seconds
CheckSparse                   PASS      30.82 seconds
BuildKernel32                 PASS      24.33 seconds
TestRunnerSetup               PASS      463.98 seconds
TestRunner_l2cap-tester       PASS      25.26 seconds
TestRunner_iso-tester         PASS      38.25 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        FAIL      135.62 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         PASS      15.39 seconds
TestRunner_ioctl-tester       PASS      9.89 seconds
TestRunner_mesh-tester        PASS      7.39 seconds
TestRunner_smp-tester         PASS      8.52 seconds
TestRunner_userchan-tester    PASS      6.16 seconds
IncrementalBuild              PENDING   0.52 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.250 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5244897821661631124==--
