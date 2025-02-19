Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3359117CA12
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004280; cv=none; b=Q87sb/GYuND2yAZNdOwLvpy4pc/1jMIlX0Ts39Y+NlXT2O9ZoXhTZR7jZdgsvaYVAHU1wZhliG2BNhUrHyenSgtTxpN5itjtH5/ZtBSGQdITIJqfL+iNd7HHEnjTfLHOPr7nhptgzyNpI5GOmRAtpJVJ+fcUWwTNrLpmEXs53AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004280; c=relaxed/simple;
	bh=LO6J8HDfqofuHo+61krMex4/H/OLnhcJ/aAVMQsyyNU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XAjSO5S3gYLj9SfYm92n7AlNxp7WCUfCo9h5tuSYMBvD9TarHCb5ykvNanM27KfWSxW0WN7F2zB5a7vEHEhLlofMxo96Z9b7i3ZwYV8j86JlJXEbdBKYfgZ/j2n6s6FyGYUXclMpPfRWGMtWPRhNYiya+y9qOHCZBaa6CV2pRnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2GJ63AC; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2GJ63AC"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0a5aa0f84so33055985a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 14:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740004278; x=1740609078; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Red0/sr9tekjSjaH5e7cQ2ojh/D5dB3Smj4/CMiuoiA=;
        b=m2GJ63ACv2eN8kyBNdlA6KSbVS84T/c+ojD1EozFQvcrIATnihBtV70khMgI0uQ8w1
         FpdnfFhNGcKddMR0PWoTXfKxZb4b1eE7UrdQGKGyoa8XxeufX23qA++Nc1spnoembWzE
         pDrU61Gd8KrB9Z0GrnTpSSFQ6wv6xbnPwEqG85iakKn1MEdfUZKaExSCY4w9+B5QWvow
         CW0Ib2qCc4MqQD59f0+xJQfHV0tSNLq9+92LPL33YTfhjYoETb8JhMTLmFqm2PjIl0u+
         CkpGyyU1C/u7Ho60SCvyP42p263bUYYYQK/r9RZ7ljkhqxs4FW3r0GuVal20poSOmVYH
         +Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740004278; x=1740609078;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Red0/sr9tekjSjaH5e7cQ2ojh/D5dB3Smj4/CMiuoiA=;
        b=ZwH3N0077SG/N8ALkv9WoSci5xYnKoLhD1sVcv0BdFByMr+8LpG8pY837Yn5U375pd
         swhbFUnSELhbwaYn3RZ62bD3cUuBICNj76FAQKcgEEzTm8e4p7Pd4RYjHbiEMuMs/nZC
         xS1c1oPtacpmotNPFahVsQVTkRnAN8cK8czj1mkJvdaAqjQhQ8mgJMidDDTraaCmY467
         nScDOoE15GqqbjbVfjIue3QL3Hf7mAGRlg+wYci3amnu9MAtjCY8Ih1nfinB5xBjPaGY
         siltChv9/EFAiAP8QBnC+HVz1pGgsN577yQbqCR6LUZsS7Cvyk2WncLMs+priL5As9gN
         oYUQ==
X-Gm-Message-State: AOJu0YzqsiwT1+AXmurAgOk+qubRmuwT4gpUCumNZtAdOIFdnWAfdDdF
	pdekcAAiroLO4W1ylN2oE1dssi37TX+//UsYUBicfFvMkT1DZLezWt4LtA==
X-Gm-Gg: ASbGncsxrL/pWPfBjvO5F5mcwTquW2pOE50YzrQOnORWYyYDOCzXP0TXbhgZQA+Jtj0
	TvSIVsyNIpyDYWye1GNmmfAh3KT56vgG6eB7IilU/CTfN5amhlyT9LGXTQ+g35VCl+fkHezSihg
	HLqn2ZfCMwVxPXPJqZiY595gQ8Og9V3/C6p5MjGuwnceVxv8tWGpNJARlBNeCbaAtzSYM4Xfkdv
	uufTNe+81tAZZSubWUHu0geHzMy8E/KdEeCCoqsKPCXMiiqpGYn1kHdPMXrMyumzHjt/vY9nDqO
	qKq63KGGYkz8VJzXYK4=
X-Google-Smtp-Source: AGHT+IHL5HvMtFeaSpqjCGC1diDXXPzV4Qfnhx40TbanA+24djc6HwRPeCjffwLWQgPywuQMsysI5w==
X-Received: by 2002:a05:620a:4687:b0:7c0:729c:6487 with SMTP id af79cd13be357-7c0c226a31emr130548985a.23.1740004277808;
        Wed, 19 Feb 2025 14:31:17 -0800 (PST)
Received: from [172.17.0.2] ([20.42.14.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a45585f3sm344338185a.93.2025.02.19.14.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 14:31:17 -0800 (PST)
Message-ID: <67b65bb5.050a0220.17f488.1bfb@mx.google.com>
Date: Wed, 19 Feb 2025 14:31:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2363593945434253921=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nishiyama.pedro@gmail.com
Subject: RE: bluetooth: btusb: Fix regression in the initialization of fake Bluetooth controllers
In-Reply-To: <20250219215352.15605-1-nishiyama.pedro@gmail.com>
References: <20250219215352.15605-1-nishiyama.pedro@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2363593945434253921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935756

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 FAIL      4.19 seconds
BuildKernel                   PASS      24.41 seconds
CheckAllWarning               PASS      26.56 seconds
CheckSparse                   PASS      30.47 seconds
BuildKernel32                 PASS      23.82 seconds
TestRunnerSetup               PASS      427.42 seconds
TestRunner_l2cap-tester       PASS      24.18 seconds
TestRunner_iso-tester         PASS      34.97 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        FAIL      119.57 seconds
TestRunner_rfcomm-tester      PASS      7.78 seconds
TestRunner_sco-tester         PASS      9.62 seconds
TestRunner_ioctl-tester       PASS      8.36 seconds
TestRunner_mesh-tester        PASS      5.82 seconds
TestRunner_smp-tester         PASS      7.23 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PENDING   0.68 seconds

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
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.167 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2363593945434253921==--
