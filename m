Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81E518FDD8
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922463; cv=none; b=sTh8yaGf6MA+YSCJlsicV1KWJj5dkYg1e6iQ0sucM+jppSTDg2HunReUG5+Vgypzx7/Hm+qIXfGlzqFfSg1SDi2Iu1DimF0Zy7gIueiD5BZFsE58Y+820l8FJFYNxS4mSaSFxYdd/f2xE4NOrBE9j4Y2HTVK4rR6RmCaFnSGykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922463; c=relaxed/simple;
	bh=O8fXG+503NeCXZCX9do2dTbABrMAHA2208s2UZdathc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Nqo+xC+8w6C8dChFGsBpbDhirZ4+EFRFNPxyAFHgf1K7jnKtblRLuUoi1FrrszdN++xYs0gojJB2zSRFR8TluRJsZu3yOs1mVCfPMovmO7RIC04QcmcmjRmiFXTvFHbCAP30fe6MLKTY84SKonS2PhzLSnVuBPFLbQb5JSIu6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbS9rJKJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbS9rJKJ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so2963680a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 01:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731922461; x=1732527261; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OuKpJxmRu5yibMg3DL1juabdT7k3u49N23HpUkhihrs=;
        b=PbS9rJKJu1bgTODyoGddFaAwUZCN6EezUwMI89U/Lrcr5gq+T/euEbrvNGDFsJSiSF
         ULfx2B4xqIJvO/Ovp8YHA97IrZfto8SFbYaVj08+aX8aILLvbK72uR0f5uyOa5hYn4Rg
         7SmG4YHYffGOauR9TDAFpi2uKadO3zgisUrUghKvWJFHzvOsTFnjJl4ZrhN0NIbjd54K
         syyB62+Cfn339Zn2PQzdSsF+ZD1mLZxgpuJ/uwLuV/RrdJcpkiL/bPa0yl+nHFWBVsbT
         mNyWywY5SQsOeZDAqFfkcCDD3ShszGRSzjZbU6TCRfgjhs3Ro/FIqdTRh6s5xAZ5JiPn
         YRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731922461; x=1732527261;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuKpJxmRu5yibMg3DL1juabdT7k3u49N23HpUkhihrs=;
        b=IZA0HdRFYPOd5mgY8iIorw+MR426XECHrUH+D6X6FF2whIgZpiqtxCNKJ9eOuRopet
         jmRRMS6sxEaD9hqWSg4Pl3uTplCGDUlvPJP4W0ePULm8ukZE5dqLpaZkBAFAAp8S9Ogw
         SBQtPu1TGUXnUnjy6A66l9ByYkoJ4S3Lhs862eo6mvPZu1OYMIrkmfsr+SwchNP8mBcd
         ebeOyiXO9TZfcfn4GnZj+FQRoSpeDQjxx3Ajdlr0Z79F8DvPzlZNG37qu25gt2+8vZr6
         t3MTylqzcaavQrLTcl8xmz3WUqMUnOmmenrcLA1SdcxEkXoxK3CkifIrVzDa4nuD8JKJ
         lH0g==
X-Gm-Message-State: AOJu0YxgRisU9u6+XGYwMCj9Yj3CFYo6Ambu7bjIiARKN+c3ob3igo08
	iBJTYV8eNdwk9N1toKDyKgVwr/aDYATbUFfaQggiMMvR2GWdoblvSd5IDA==
X-Google-Smtp-Source: AGHT+IHN87BBisrIxnq3mh83TPoyjvYNXPpdy4uybd71prrbUGYS1gjbDPwVHCSdiPzGKtGtmqyUfA==
X-Received: by 2002:a17:90b:4a85:b0:2e2:af0b:7169 with SMTP id 98e67ed59e1d1-2ea154fbd88mr18016305a91.12.1731922460854;
        Mon, 18 Nov 2024 01:34:20 -0800 (PST)
Received: from [172.17.0.2] ([52.238.27.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea6d9c8dd0sm1795184a91.28.2024.11.18.01.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:34:20 -0800 (PST)
Message-ID: <673b0a1c.170a0220.3415f.3e83@mx.google.com>
Date: Mon, 18 Nov 2024 01:34:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9203920299087769788=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v2] bluetooth: add quirk using packet size 60
In-Reply-To: <20241118085757.3678244-1-hildawu@realtek.com>
References: <20241118085757.3678244-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9203920299087769788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=910549

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 FAIL      0.41 seconds
BuildKernel                   PASS      25.02 seconds
CheckAllWarning               PASS      27.21 seconds
CheckSparse                   PASS      30.28 seconds
BuildKernel32                 PASS      24.40 seconds
TestRunnerSetup               PASS      433.30 seconds
TestRunner_l2cap-tester       PASS      20.02 seconds
TestRunner_iso-tester         FAIL      31.38 seconds
TestRunner_bnep-tester        PASS      5.53 seconds
TestRunner_mgmt-tester        FAIL      121.15 seconds
TestRunner_rfcomm-tester      PASS      7.71 seconds
TestRunner_sco-tester         PASS      11.32 seconds
TestRunner_ioctl-tester       PASS      8.00 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PENDING   0.90 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.191 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9203920299087769788==--
