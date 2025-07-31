Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800D13A258
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753994279; cv=none; b=HPMSQ4eBtTQwVXctfo2Szh6P4JnsOFdIawE2WozJZ65NlvYHKRI8FcGK2qbqAHJMY5C3ptCK8PWOnoJw9yguv5DQPEcwgB1QhZGx/Q2Q1M+wDbv6b9XXfU8QORjFj0LHsITY/kvGeo+6n8bwLEbRp+IyGcDlAB0KKSK7UWLN/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753994279; c=relaxed/simple;
	bh=hGQG6skXAXgL5i5zc/aiDM2f1d/P8Iofx9a9lwEF4o4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jx6BEjlJvx3EU+7vtr5Xxvd1kcM0ohJwGSuOdFCL0V475Ti+u0NGW0ri8oldbY2/zf4kTFG0PEFgTK3mVK2jE0wI/93O/z7Ht3GYd9ztZjiC84ayA9/jDoTP6YNVsQCfaYqhgLjl10qksDbr5xrVSLox5o3K+54c16yYL6xnVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb0wLhHB; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb0wLhHB"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4239091facso129598a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753994277; x=1754599077; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cwhhZAAyKtop8w8ex+R3x2kfbZZE+3ha4ugqOUcuziE=;
        b=Qb0wLhHBy4deu1hCugdmNSZR9XSSLi0gLWcwxwo/1hNylaWDQzrxfOlw0ROcdWZDWZ
         M23+16NexvK1wNSXbs+bRbAw1Ry6yQFwPDbZbflilDnKA79Se73xvcXkvtlHxeSqr6JD
         E3xi+koeyW2Q04DprCLvL7YCCf+Y4KXoQ793wbcD5RTu78lr+VI+arWUP5akfRkJEh23
         8ZB4Te5JsputX8/cujuOgjWc/Yurk86z8Jb3/URxdfL4ALhwoj0Dbt2N07kBcEDsbao7
         f6YC8355LL7xapbUEl9fmIh34KMRpNNk7PdFwqZSqkwzLxiAbfpisfkV48RBUCfH/QZu
         dyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753994277; x=1754599077;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwhhZAAyKtop8w8ex+R3x2kfbZZE+3ha4ugqOUcuziE=;
        b=Y1uCb+c90DumjavkswPq+Y1g/eEtHiNjRDcIxGS3xtUJt5Xud9WUBoKyhL+UDPd4IY
         JRNbs2tjr9pZIj1d09VP0gDMPQxrwGGIPFpc6qvsMbWrC9Y4gZPqpDgiviI+wLpt8XGq
         tnUc3jtzVNonZ1hI8ykBlGuAvRlicl+shkycpg1DOhMtstdPJXnac9BjDbpidO4eNXy9
         QGkZ+Ss4iBFm1BJFdynBCssIWUPAEfLfKcjGHezBCeJDyTJlFohgwtJ72H9ROduSyr3v
         kuB619JpEN/U+v6HqAbSuHTVDJmKKRla2E+oXrvKgYoYjYP4So4gkKRXBKlT5KiufwvJ
         k8uA==
X-Gm-Message-State: AOJu0YxholoVwWKvXbxCOZ3etCy0/u+BbjntfXIS2yBrSGJx3yBP5zw+
	eITUpEgD87xLbNKFbVsNY5xIUxrpcBtr5/HzG22nkVy4jbAVpOfrBfJzKkar5aZT
X-Gm-Gg: ASbGncvEJ0N63hs13amJVNNmy4V9JLSEiI/mYsOPhl99Qek6ugU/64Gpzwnp9dz6+CB
	F80AvQqKSuAtpimmbeghlt4Q+oyeJX255+7kFJVFoyUKRvmBdpXWpa/rBnlr25NANQNmPYZTfjx
	6Qk+uFRc8KLlENFUcyShT+9TMNeshmyaDrfRQHLeCcawxhptSVIeMurLZuJf53K4xiiZTTUY89p
	Em43P0G6S66iiw1+zcYuBMytOIiLwWWaOREaJuNAuaHrQHQTjHsd1YVb3ET8Cj5X4J4ScFbr2WS
	KJ8Hab2TZO6MDsQ08gglvttuwHXfbi/2ha7Sopg8bO9xlbcVeDssZWa/Ftq4Xgb+ifLky8zyE2C
	vMgvFj6SwuqJJZ3g8XL0YSfhyIpw=
X-Google-Smtp-Source: AGHT+IHhKmRUSnKafGBN7YNBXv1XWaAKBVqD9GdC+KTsovHsDUBlgFKUuYhg1n+TRsrla9O4TwB1Ng==
X-Received: by 2002:a17:90b:2fcc:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-31f5ddd0566mr13846305a91.15.1753994276971;
        Thu, 31 Jul 2025 13:37:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.153.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eba6bb8sm2792194a91.4.2025.07.31.13.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 13:37:56 -0700 (PDT)
Message-ID: <688bd424.170a0220.11a31f.2daf@mx.google.com>
Date: Thu, 31 Jul 2025 13:37:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5083554142642320740=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,v1] Bluetooth: Add support for logging host packets into monitor
In-Reply-To: <20250731195328.684121-1-luiz.dentz@gmail.com>
References: <20250731195328.684121-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5083554142642320740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=987468

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.08 seconds
CheckAllWarning               PASS      26.91 seconds
CheckSparse                   WARNING   33.09 seconds
BuildKernel32                 PASS      24.21 seconds
TestRunnerSetup               PASS      475.02 seconds
TestRunner_l2cap-tester       PASS      24.83 seconds
TestRunner_iso-tester         PASS      36.19 seconds
TestRunner_bnep-tester        PASS      6.02 seconds
TestRunner_mgmt-tester        FAIL      126.50 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         PASS      14.62 seconds
TestRunner_ioctl-tester       PASS      10.00 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.20 seconds
IncrementalBuild              PENDING   0.67 seconds

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
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:151:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.179 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.217 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.076 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5083554142642320740==--
