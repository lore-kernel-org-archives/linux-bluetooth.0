Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97A194124
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746110637; cv=none; b=I39E8buIWrZRihLB540zL/adNErnPT7riYph7Cx4WV8L1rur+Qa4xahcVTTbpvlaV02LrgkUasyERnZ4GZH+yzC+gArmf7A3lWhmZ99dKOu+w5JL9XRrj3GwYbxIh9iyxqdEWpFkdp/CMFPTIa9GBNl4Jdp8YgSxmEeH2B9FPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746110637; c=relaxed/simple;
	bh=OK2fO8q/3Ms0wn/Ubm6gogOjghhKDK1z04IJEPYk2no=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Lo7X7O0Hf2LYH5OAwuBitFwTSNu5uMpU6mCLWxbNWbPra00mQRpeH2GtOWJsKz4MZfkg4YbOZ7sn/0UoVtl4nR+BdI3LaZgo4Nt+otEI4QOnMl4g3kW7THr4pra+waSYBmZc1JD3Xu5YY8b9gra/OM3MbNm2nyL4nZNs5VYN+mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXpKpEJt; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXpKpEJt"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-afc857702d1so1091139a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 May 2025 07:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746110635; x=1746715435; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NfxX8KdDyhsGcrwOk6nacPk4J1rjaxrBKjnA8xEHipk=;
        b=aXpKpEJtri5jUevvmGq6xrcapHWO2rcIWxqghi4KIArrPMANOpCHE6kSPWGWw0wM9M
         kEu8RCswulao8iNMwyWeVAKTo+yOjWCK8UsgEKi/omOQdljpMgSSaQD3vUizmgxshk8m
         RPUaN0QfSsCKz1jh73L4TQy/ox4kDhs4sIn01MjQ/qYx2MepqvV4UFCLI03LRfuXMR2t
         b4FYUGNKYWO7paeVjaS8IG3jsfSqTgiQdHJm8EQBCifsGO/wh/ayAYHxApHKxb/wJEi6
         e+vpFsgpKOKIP+3To5mtV8YK3c+3XV6HF2fTW+A/cFeup7UGdui2vQ4VLU+7gn586Scw
         iQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746110635; x=1746715435;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfxX8KdDyhsGcrwOk6nacPk4J1rjaxrBKjnA8xEHipk=;
        b=VObYzfyjXHrhdMxhUIutV5IfOfBpBT6hA4A4e49HwOGMZYGIQC4fucDWHLjoOEaEmL
         0MSxVtnhSfHDE5ZD1nUHYwc9WmKBMJd8QQJbkKgfboZ7AlZdZG0scIlzEtDoTstSL53/
         RBfiIBWQxwxt7Ko1ORUm4pR4wBmw/ohI93MkCgooWQ4kbZGxOe8vkTZjvBJdT7QK+SaP
         FxZtOemTYxKDbJ/NV8lrbIP/bMysmVPSs3wmSSyD1M0yEnn2rqf1XJq2Ne4w4CEsYC73
         oVpSyLeqC9bkf9GlJ7B0nYfdNhlWRk/JIugEd2Z/Qf8+G1TuenE9z14w/6WxB1ptTf71
         HZxA==
X-Gm-Message-State: AOJu0YwvT9E+nO8cjmKNEfDkUssUt8pjYPoltxwglP6sDLsrr5p6MCMT
	ZNnIgZh64wDt2A+0yTIVY+tevSoIAIMWd8fkM1kLOYF7gwNK82ZW2KMjyw==
X-Gm-Gg: ASbGnctuCmFSjYwfgnx/FBIq3Gr6APA/gCW2FVjAZWWwu3a+Af8UdEG5BqWKW3lIxhG
	T83zoU4Qw10y18YP6a7+w7z+H4fbQNm6V26i67aUrJIN8FGsG54iHeo4nKTV9wBTLXu9KwCbiUi
	Z8ve07kyIbjuK4cd18XOoG9t0h0ANk4x63MmG8NgTrThoTFzYL5zSBhjxBAbmVkfgtUnUBxoGhp
	6kea0mm+jEQe854XuYioO5SGq1mX4/CcHfK+hamvjYYq5HuootSgi9ek+2QcIJpItuslF428ihF
	yzWz8Vvrk0pznP+8OE4FQEX2kF/0i7qPSWoxBzMFkdwHU1GTqHf1fdax
X-Google-Smtp-Source: AGHT+IEb7A1Ogq/jw9hSWrcHktPkslDooREJFtymCsz3Nfwjphszv6xxcnigZVWmzT3k4jEr7pQXAw==
X-Received: by 2002:a05:6a21:3292:b0:1f5:8eec:e517 with SMTP id adf61e73a8af0-20ba6a18158mr4461397637.9.1746110635240;
        Thu, 01 May 2025 07:43:55 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.33.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1f9d4b5ad2sm796011a12.28.2025.05.01.07.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 07:43:54 -0700 (PDT)
Message-ID: <681388aa.630a0220.15abdc.d371@mx.google.com>
Date: Thu, 01 May 2025 07:43:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7199219819277997590=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_event: Fix not using key encryption size when its known
In-Reply-To: <20250501141222.2498357-1-luiz.dentz@gmail.com>
References: <20250501141222.2498357-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7199219819277997590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=958807

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.75 seconds
CheckAllWarning               PASS      27.51 seconds
CheckSparse                   WARNING   30.98 seconds
BuildKernel32                 PASS      24.26 seconds
TestRunnerSetup               PASS      461.50 seconds
TestRunner_l2cap-tester       PASS      22.37 seconds
TestRunner_iso-tester         PASS      33.47 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      123.59 seconds
TestRunner_rfcomm-tester      PASS      7.88 seconds
TestRunner_sco-tester         PASS      13.03 seconds
TestRunner_ioctl-tester       PASS      8.23 seconds
TestRunner_mesh-tester        PASS      6.05 seconds
TestRunner_smp-tester         PASS      7.35 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PENDING   1.03 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.171 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7199219819277997590==--
