Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A71BD9F0
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312746; cv=none; b=PLySyJUL569HVUlV3K1z2NMOblLv+TBPIQ2KZ8+pmGGKu2C/fIewaHEb/H9US4HCRnoL0+9OZTOXuclr8Gp/xFr2fnR70xhlQFs5gP/ssQ+YgEacybDok+y7d3kHGg1GVcSb+qgR3rvOIThw//Y1tp5++frlX9lMjbYeuYHw2Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312746; c=relaxed/simple;
	bh=AfYS2xQo+GSHdVX73VEL43hONa8Xk8sX8Zve+P3gfG8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aHLJF7UWuSTR8H67jyDUpRCq16aZ8HsIOfXWK+FZFMG1G/QJpLeu5oXsuUdVjwEmOxLp/uULgZwxR7O9ch206HXrwddFbL28Wj9HIwa5tq2lNdVbL/7gEy/v5PmfgmVWtXXf0KT/8eXuuJ06gd17bthbx3jDGNDkpfx24tL4yD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmdZms2Q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmdZms2Q"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445805aa2eso234805ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756312743; x=1756917543; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qjofBNPKZK1JBvAQ2uSVoVR+8WmNIOqw4jAdJyOrLfc=;
        b=CmdZms2QxZxG+8br24zRkU2HmCPEl50fU5WuFPkKbZLFnWWuK5BZs2z9T1v/47kDKK
         KiMZ+VGk/05NJUApUtTRwwMHnu2j6HzdtFrnUKejVL4v4rI6LissWhBHQpfLSnYcHjz/
         tGQppT7TY5dhGpzV4NgWEZjlkh0Y83hMaAprNFwWbBeYlR4kZ89itEkFyEGnDNgerNpL
         y4O6L+FtWuWe5XbIUI4Ixj3AJ2MZbhegkpR96Q5STPY1nRhHB+DJmmhTX9Rl0k6OMUqM
         SzroL4jHhShewbxefYPJ9CjLKkjRxXX/23oXQi+QSKuDIUwN6Xuoy35t9t2RJmBJGtWa
         QS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756312743; x=1756917543;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjofBNPKZK1JBvAQ2uSVoVR+8WmNIOqw4jAdJyOrLfc=;
        b=SC8lhQ89IYVk5V8csZQwCmsQ4V7udaDHuMzG8MhohYSuQxUF0VGGtmMXcyC6PdmvVJ
         moGmUafX+QmYj8y0/MfCsvANTZIo+8loGzfdotiNJsF5N6YiyLtZjfefOYVPnHmiJPbp
         gLBc2Y57BREydugukX+GqtzfeAvAj9niE2+ICEFtT0RLLiL1RcMmfg5COGHERuhyt3D6
         S6+oaJnkTz4JEqSeGCaPYxGdUE0ROa1oVZy+qzDRNJ8iptKKsWKxZ+37Craw4734aOUB
         YyhJg1I6TkrqI6hCxSBJObFe1khkIrAr2Rmp7KRGJ1nxYYX3okvhdybiexoCC7I5GGU/
         2zlg==
X-Gm-Message-State: AOJu0YwHZ/g5HFAPihFMhAs+PwSKnSyV1nY+gqibC4t+J01kvCKf5Gwn
	Da1I886Vq0/QvaqWq5zaPHxyX1g2ByoKVSdCOMQEbJLPuwNELjLRBhorjFOMeQ==
X-Gm-Gg: ASbGnctrLo1sTxiLBTmIZPyzP0mORuVjf/isUu1B20Mg0u5RbyKUjIBNnfrs79bV029
	ZpRr9CDaPyIyQYAkVyuSLVn14gmQenCJwECp+vxeoUP+b+Cf1ErzfRK8Qx0RAORIxT0KpRuueeO
	ASrRr2ILaclAwZZpUvc4WBRq5Bv0IygR9PrOc/u8eL2F51S6G8hMWOjSnS6TPh9AB0z5XmZ661i
	97dXEwVWbIqlx4qgfP4xWh4gpg6nNcDi4lID1hD/SBxaNTypkmCUHocmj1LJ8yIHrW5tit7tevc
	90U1zOQ7l4Lmk12F8GpKpKDaOyTgExsEz3CgjEozOulAonNdB4XOxKkAiJ3NU/lvEKVUCp/1lxy
	0GktbC3Fyo3FoimmsP3oIEQMtpWuV
X-Google-Smtp-Source: AGHT+IF5WOBw6IrBGV129XxO4Q8iG6dOU4vixVvdsN1VYr9TxE8Fe1M/0zWStIM3QLg2Q21VojXp+g==
X-Received: by 2002:a17:903:1a8e:b0:246:620:a0b9 with SMTP id d9443c01a7336-2462efcaaa3mr235655235ad.61.1756312742635;
        Wed, 27 Aug 2025 09:39:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.229.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466886456csm125264315ad.72.2025.08.27.09.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:39:02 -0700 (PDT)
Message-ID: <68af34a6.170a0220.321cdd.0935@mx.google.com>
Date: Wed, 27 Aug 2025 09:39:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5723562595692645831=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/3] Bluetooth: Add function and line information to bt_dbg
In-Reply-To: <20250827160555.1446966-1-luiz.dentz@gmail.com>
References: <20250827160555.1446966-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5723562595692645831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=996139

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.50 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      24.36 seconds
CheckAllWarning               PASS      26.65 seconds
CheckSparse                   WARNING   30.33 seconds
BuildKernel32                 PASS      24.07 seconds
TestRunnerSetup               PASS      477.79 seconds
TestRunner_l2cap-tester       PASS      24.88 seconds
TestRunner_iso-tester         PASS      41.15 seconds
TestRunner_bnep-tester        PASS      5.98 seconds
TestRunner_mgmt-tester        FAIL      126.58 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         PASS      14.55 seconds
TestRunner_ioctl-tester       PASS      10.10 seconds
TestRunner_mesh-tester        FAIL      9.57 seconds
TestRunner_smp-tester         PASS      8.48 seconds
TestRunner_userchan-tester    PASS      6.15 seconds
IncrementalBuild              PENDING   0.70 seconds

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
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.101 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.076 seconds
Mesh - Send cancel - 2                               Failed       0.135 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5723562595692645831==--
