Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4EE202F8C
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368382; cv=none; b=DI8iboPQKeqBpkRyorHOZoxFUEMXKXPF6eWSqdvmEqpsf5H7Sky/BPZTmftNxx938DFHVemyvvQ3UoSU96uD7XSIX2COXdonvFfyIAMIhz+R1Fghtwl2m03myfjTweYqghYgHimwsescLKZnuOcVF1IjueeUEyCs+9/OaXNo3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368382; c=relaxed/simple;
	bh=tOIn4G07AyDnzV1IoCC2J7egVgfukw/UDAjpqoTeMHM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hjUoknoox/OSzz5TPsx/bnG+6vS82Rfo6poMxU+sg00d/jfbfJkioX/3pBO9h+Xx7etvlBL6MJCxzv9sK1k6owspgU5Xq2rhhBQwqe/b7N6/0xV6EUOvpquufHloCta9YrF7ajdGex+Wa0D6K8lXRo23KlsYAZRVvPdzw9W22+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eB4xDq0K; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB4xDq0K"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6e5c74cb7so12536485a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2025 12:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736368379; x=1736973179; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cXxyKMx/XOBb2IEwEqFA6Sg49dSbJiISgcbHukAU2JU=;
        b=eB4xDq0KzeS0Zk6lQdEkANwwaSjVavWwTBQP8N0nvXqHcMFm1K5msOjsHrF7ZKN8+y
         rwnC3kcZf1iG+vhyvSaRox06Zd2++e4CX79gtMXv1SPVZ039whXdXvox+/MMueR47Da3
         eXygDBT90tlsPZ7G05WYgoKVasrQA6kkplpalJb8UpuMtsY0dObQrgHYASaveZlcQlgG
         uDHSKzRcuxjvETu8/Y0rgWRj7yRcs5Mht2H52jtVrwUOtjosxeT0TGRRviXStdLwFmPM
         e57qbvoqrlZ4Yy8zeqvR1x5hGqCS9YJ0ynR1xwd1T+CdjmuxdEYxU61zdLYssCS2UVjn
         rm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736368379; x=1736973179;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXxyKMx/XOBb2IEwEqFA6Sg49dSbJiISgcbHukAU2JU=;
        b=bkcb8FN4uGPeX8yotuQ/RXdEcB+6aY2KdRrzm7tXdXNFlii5gmNWfFe/ek/t3wRLyQ
         JyqIL8qQ4+U09HpD2blU7r7ul72uKh0enWlXEToUx5H/GO0m8/eJ7VDS4PYqWPlMl0Rj
         2ON2UY0XwG+9uW9cBcbMe0mzKSGtB3yPxfQyDzsFakhKXQEj7mJSLmB6smFiinHECEhZ
         D773pOEwm4KptzLLzRYwgRRWdaWpi4CN2zG9Jj4iQs7l942cLiLHROHcfMPjaRb4mhA9
         KuQW2YOyQkYWoybAJDT6KDZbVSu+l81T92iyOzFiF6xn7IXrc8Ns2hVpfncN9pPh2TXH
         c2MA==
X-Gm-Message-State: AOJu0Yzm3DlZwnSIBVX5CE0jBMCfyfwwmNd+MUXsYogPg+hwoNyYI8s8
	VzAWpE/JbG8iUFiyklk7O2Pb5iAddA5u/dB6x4SZ3dzhm5p4EIHdw7F4iQ==
X-Gm-Gg: ASbGncs3wRO+QoRIfoteyIA1aEUvOqqvOlzx13Pyl3kfTOv6mufOq3FfZeOE47QZMiQ
	NaBj/w3/xo/bXmFPhS7Xen0xJYMC663Z5fQUqunA+W5LEHcApY6DOxOjbHdfhwoQ3TugmbSkk2L
	BP+1jp1RTe78wAH+Rw2NMsgGhO8T6pKJuzYlQ7bkkuGO+r5+E4j8ooZwFFg6JXerMtgV6nDarTH
	ZiiqQaV2RJrKQTJgIdIKzGwWYH3SNWVMEW9vp7MMZCwV2WVQ3PIW2EznoAvxQ==
X-Google-Smtp-Source: AGHT+IEsLCBVmSonPWW5w8JLRXzwuWIq5JlEPMNOiRVVFs/n9QDSDw4cVyg4b04uT08MGb8B6U12Rg==
X-Received: by 2002:a05:620a:4014:b0:7b6:ce6e:2294 with SMTP id af79cd13be357-7bcd97d7ac1mr566801985a.56.1736368379091;
        Wed, 08 Jan 2025 12:32:59 -0800 (PST)
Received: from [172.17.0.2] ([20.55.126.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2df5a5sm1710706085a.43.2025.01.08.12.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 12:32:58 -0800 (PST)
Message-ID: <677ee0fa.050a0220.38c6a7.bcbc@mx.google.com>
Date: Wed, 08 Jan 2025 12:32:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3300156609341099586=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tcrawford@system76.com
Subject: RE: Bluetooth: btusb: Add MT7921e device 13d3:3576
In-Reply-To: <20250108200140.29719-1-tcrawford@system76.com>
References: <20250108200140.29719-1-tcrawford@system76.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3300156609341099586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=923499

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.10 seconds
CheckAllWarning               PASS      27.29 seconds
CheckSparse                   PASS      31.58 seconds
BuildKernel32                 PASS      24.58 seconds
TestRunnerSetup               PASS      434.92 seconds
TestRunner_l2cap-tester       PASS      22.46 seconds
TestRunner_iso-tester         PASS      31.54 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        FAIL      120.08 seconds
TestRunner_rfcomm-tester      PASS      7.66 seconds
TestRunner_sco-tester         PASS      9.35 seconds
TestRunner_ioctl-tester       PASS      8.10 seconds
TestRunner_mesh-tester        FAIL      6.17 seconds
TestRunner_smp-tester         PASS      6.92 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PENDING   0.80 seconds

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
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.146 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.195 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.107 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3300156609341099586==--
