Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720AC1AED2E
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642751; cv=none; b=hjmmaYmOerWluJY3mr5cmn9u2QmGR4vgUySI17OwPDlpUqK/4odpRSKcKTVU6dtzeEjuzOk+SPz51v/tPgYNaKFg3hGpsefu1MKwZPFY5fIPAlvcmNPldHuUZF7/OH+2vY2haBsozsgCNZOE1oF9kF16x5OmyDC9OZyEI6WEl3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642751; c=relaxed/simple;
	bh=JS4nQC3KiQPrBaQrzIviUBiYDq0h45X44QF4qs11sdk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I9rorxrjAkDsykQSx02pk2df1hjj1YBTB85qgmVkoYH6HQaQvwva0ppV4DvXTammUOsMHpDjlwZwZqtHsocVQMIs2mmldVFhzGV7iZDRyybAl7io1vhicVQOSz063HnvCpvlH6MWXyLL0ZZcCaztLgjCXElaNyM5NF6YKN+aNhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWSwhWUP; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWSwhWUP"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1d5f6c56fso379546385a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 06:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723642749; x=1724247549; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fwMk6DVKijtlAqCwmcv49CmB/WYgCLuFeytpqjm/vsM=;
        b=CWSwhWUP8fx7wfKewGIxbhewlMnGGusSa8R1zBS1n+xgmSrzndqo3mQ35PhajHqXEU
         y9fobX9F/wJoj5FjIL3qUaNfXkxi+yih2ix9t0ywvARQsce+jWSbQ7FbCPW5SFbrkgni
         IWD586OmbnmB9YHaIxCJfsHZjpjeqcg1wfmav0qNts+FehVom4Begihd+2kbxxseL2+G
         yDu2ZQkXLnU4yM73axFUEIEUGC65uD48Yuu0kYvj5iCpG+KEuaqGbNwTwcdVCWYiTNGg
         AlqJfQgOUj2tAC7EVVaFLE/fQxajtBJpSZac/GKD3p+JL00eu0fU7nV+HiQYLIiMR3yt
         x/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723642749; x=1724247549;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwMk6DVKijtlAqCwmcv49CmB/WYgCLuFeytpqjm/vsM=;
        b=iWL6ideJc7WGSh21NuCBMSrFB0yEsAHGlD6bPYBDUbolbILUnNzNY4l7ynZiTWBVlI
         6PfzxGOgqZivZzzyU0gnh3LfmYBMGplOn++XHP/Gmmm/42sONpi9AyJdEpm7jPZkiYwR
         KEPVBm0rIdzqP4Lxy7TVR5PkBUQvtwLZXWjClrZeF8BuNiLRLPSyilXrzHbbeiD+EPCS
         Na6xxpCA9p08HXbRng91nYW2OnwJj8o0/iSiK564MDVeE6Dqr/FIJ9mGCqG71RO3BY2y
         PsIO+mSHUFpXcPWgpwxCbrWZraQO8ZUt76LMMB4G09gsYLvsPYLXrkd99ZYbH5ApcGvp
         mtVg==
X-Gm-Message-State: AOJu0YwVS8lLcXiVhaG01oyBNJBr+Q7QVkikon4n86a5gKcMyHyx35i9
	QnJRIDacgb3G+YNJd7Mxv4GTgUXs77KRKcgixz28SypZM3I2ETPzIAVU2Q==
X-Google-Smtp-Source: AGHT+IER+sdE/Qe8dy979rynLaRYncYpiGW5567sAhiXT32WrePl52Z7vlQbAzQlqFNHUqIOjYqw5g==
X-Received: by 2002:a05:620a:3904:b0:79f:4b5:3696 with SMTP id af79cd13be357-7a4ee3ac21dmr319708485a.56.1723642748977;
        Wed, 14 Aug 2024 06:39:08 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.181.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d62630sm436128185a.9.2024.08.14.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 06:39:08 -0700 (PDT)
Message-ID: <66bcb37c.050a0220.10b18b.efba@mx.google.com>
Date: Wed, 14 Aug 2024 06:39:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6438804249456192259=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Bluetooth: hci_bcm: Use speed set by btattach as oper_speed
In-Reply-To: <20240814130018.263129-1-frederic.danis@collabora.com>
References: <20240814130018.263129-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6438804249456192259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=879637

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.35 seconds
CheckAllWarning               PASS      32.31 seconds
CheckSparse                   PASS      38.30 seconds
CheckSmatch                   PASS      102.76 seconds
BuildKernel32                 PASS      28.76 seconds
TestRunnerSetup               PASS      529.47 seconds
TestRunner_l2cap-tester       PASS      20.16 seconds
TestRunner_iso-tester         PASS      31.34 seconds
TestRunner_bnep-tester        PASS      4.88 seconds
TestRunner_mgmt-tester        FAIL      111.84 seconds
TestRunner_rfcomm-tester      PASS      7.50 seconds
TestRunner_sco-tester         PASS      15.04 seconds
TestRunner_ioctl-tester       PASS      8.06 seconds
TestRunner_mesh-tester        PASS      5.93 seconds
TestRunner_smp-tester         PASS      7.02 seconds
TestRunner_userchan-tester    PASS      5.11 seconds
IncrementalBuild              PASS      27.83 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 6 (RL is full)               Failed       0.198 seconds


---
Regards,
Linux Bluetooth


--===============6438804249456192259==--
