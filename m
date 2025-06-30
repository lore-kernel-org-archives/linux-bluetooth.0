Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089F222568
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751315772; cv=none; b=QHtaIJPQIFx/DamQ01QjQodqou9i9Rd8RvoHiMng0gci2JEaX/mRkbI3Yey0NuB66ranQajFVg+4SpIEqJRg4MUH0digexG+D/zM6jIHb/1FRborsXSActq6Cr8rwNkx/F+13HBqChT6zoh1tsaLrQtS4nBTX7jyvU1VlVrZGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751315772; c=relaxed/simple;
	bh=LW/Dpo30BEPg4rS8o0X7bXMlKi8PQMkEq2Su3/l/diE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nNfpF3OD1wWW8MmA7QbvGr9HI0VrhePsDGceaom5hf0hvjGs5QpM1EVtR09Y5y+jt0PfHOJNk5U6Wa6mTxZp+jC8K3aufNhK6nKy7st9b6XZQg4oBNMBKNQAPWUnbd6cqKlWOtQb8ydJKVM10f2xTULOweoRgPOScypSTCF1kfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZe+pXK5; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZe+pXK5"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d402c901cbso448777985a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 13:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751315769; x=1751920569; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ALUPljEEzqy4GVElVdmM14Y6sv7H0mMk9f/exKG2Cbs=;
        b=XZe+pXK5q5X2GIgE7pRj57H3qtO2TgrZC95zYbLRRAMpn1DpV9vM7eO5q1bwFqQuEQ
         fsDvn2yMLT9pGJTyZ5c6MmOGGAXxIhsbl9NMo9lF+OhNQFz55+KLHPxsi2+ByFHEL2mJ
         rBRGUwfYGJVmahyot5QAGNxRrYsVjcNxilcF8k29dDMZo+DcADsDy7255yjee1Jj2cOc
         ZbpGJ5+TJ9Re/z6DKajRiCQjn3oMeGI4ez3Lx1MK7OllTL4udu+7pM3ZJdC4x4rtDx2V
         dhtTcFXnOpvgbP2xthuPdobF/tvPyl+gMkHEpiUMHcQS22w9xZcPBTtI0AGOGQTGEIdc
         kVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751315769; x=1751920569;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALUPljEEzqy4GVElVdmM14Y6sv7H0mMk9f/exKG2Cbs=;
        b=LO2cbEoJ3NMlXmpu8Jr3u/BHW1k8dhNcvtbozg/JIivm/TmQDb0mQeSG4j2zadAjE9
         3kWdxT3yVhlVSJ3jChwrCL60VhVpOW+QiTbgg6zv8kysE6kledWmqj851ireDZ1h/3+5
         g03kUtdyFyI+ZJtGaQOzI9MKFXh0ex0p1+SLO0K/eUl8C7YpvxlPUKv8K+uCWO2xqVpz
         cnUDb76geWB0sZP9YoaVYtRs8ihYuL06Dr0M58XpNWnAd16ufbzOACxr9lby7ybbc4v3
         Mr4HVLKS2rP3Y6LfqJ5WF/prz3ukNuqW32vFzA/mfnr0lHn75R6Pr+PKEM+V61gZ87KY
         kamw==
X-Gm-Message-State: AOJu0YwpUt9vctXoy4Bu3xh3NghCmAua3NT4xJB2dSmnlGD7kQOD1NYS
	3VmlE28RhzB7GivkayeTcZU1kPgGRwwMBbNvIakM41YjhxH7d9SKTDi9FVIsgA==
X-Gm-Gg: ASbGnctF/LZkEucAsgYZB517e4o9u22QPqc/ZMsILrfQqo682TQmM7xfqJZuqyVYwgw
	DBfJMdtcDMxn7aKC2eTIWWc0F6CxbJIZQOnkYqG+mpyx6Jah6GWvB2QI+WdiVfJHRp467fftiLG
	z8+g2pdHrgrH6i13SdvVbljjcT7wz+Pe3HOux45y11ighVg0Php271ZswuYQ6WmhMaMipdMpzZV
	vFe2hLjJoxGESTiac55eEVtRnwKAd48nkgwdDjs8Tewq4Pz6SJh/BIz5LLZp6aRDeFfI8TcLUKj
	fGIMkd21WX/7AmlnqKf5SGouOxRSTg0qRqntpiMHO+Kgk2CWkicpBdL4a0I98hNaYdpycA==
X-Google-Smtp-Source: AGHT+IFPLg+HJc8DY3u3bV/c0EJDQKAaxRcz9SqsqD+OTGUvhX/hX/xDymGn91+IMDyBpdz6TEbDZg==
X-Received: by 2002:a05:620a:40d4:b0:7d2:15f:f976 with SMTP id af79cd13be357-7d4439b735dmr2185216285a.52.1751315769429;
        Mon, 30 Jun 2025 13:36:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.76.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d442e8db3csm662916085a.0.2025.06.30.13.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 13:36:08 -0700 (PDT)
Message-ID: <6862f538.050a0220.35b121.49c4@mx.google.com>
Date: Mon, 30 Jun 2025 13:36:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8702625401801114661=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_core: Remove check of BDADDR_ANY in hci_conn_hash_lookup_big_state
In-Reply-To: <20250630193934.987691-1-luiz.dentz@gmail.com>
References: <20250630193934.987691-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8702625401801114661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=977465

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.45 seconds
CheckAllWarning               PASS      26.84 seconds
CheckSparse                   PASS      30.61 seconds
BuildKernel32                 PASS      24.56 seconds
TestRunnerSetup               PASS      472.53 seconds
TestRunner_l2cap-tester       PASS      25.12 seconds
TestRunner_iso-tester         PASS      42.30 seconds
TestRunner_bnep-tester        PASS      5.94 seconds
TestRunner_mgmt-tester        FAIL      131.19 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         PASS      14.85 seconds
TestRunner_ioctl-tester       PASS      10.05 seconds
TestRunner_mesh-tester        FAIL      9.58 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      6.25 seconds
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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.215 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.293 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.152 seconds
Mesh - Send cancel - 2                               Failed       0.144 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8702625401801114661==--
