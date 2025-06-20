Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262BF2264DD
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750403432; cv=none; b=Oq5bPbVtu/bizzNvpylONVMwpLWI36nJmMAGGGu5F6/TeDb0F4tcTJMYupL38PvO9flYqsTFBRD0UeTLKRiSXNbcib1s4aA3n4OgzKj9l0yUaVTlDaNa4/aC6q4xk2B0z3fDdbFDZ2cCzU7t/scNbtDzDTrsdC1v0FxNVTfriJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750403432; c=relaxed/simple;
	bh=AgsOhSMIrflZVs9ZZX5/hl1ws8E0WEy6LUvSW94sIAc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=u4E/G63mXMdvRhWD5r4kzzRuP4BdIvuH04hJNWbZmyE3JMapYhVYOvm9TVqzZMsUR1h4CT+YBmZUJMqWk0QqIvpYIJA22gxfHstK5oSR7UStlVpD1W1pDGkt4/+XAO8xD8QAX/yfXXKRMNGHGEmjZAR6EmS3jXxJjyWtJTfq4ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeDhI+mQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeDhI+mQ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234bfe37cccso19642695ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 00:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750403430; x=1751008230; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lycX0ICx6dcD7vbzS1mUfeWeg3x6nXLliXiBEu0+9MQ=;
        b=DeDhI+mQj4+s86WeKQzcqi/bU9ZAhKOX1cXBKvX5JfPnIBQbWXJgsh/p/Ne/X9VapD
         gubIw8UW7rTqubUo3wATKJqBDzmKPj9JlcsKzfGcPAiK93DL+2/PzvIb7Ns4KowuW8cW
         3vYHOuz7Kp1camvTPt5W/GOThULOibGspp7w9ZvNXuUr1eod16sQIjWEHXzo1/IrChz7
         LYqw/gZ6ZeGKJ7SH8AyHc1ko/O437xQAryy692HSUUntodH9SEFeHorRVNPY3X/WCy9T
         gfe64nxO5C3MrxqTw58D4Xy55OiTuKbQDGet9+gbMG6LuCyy5R7mxO0A0Wbw/76GpV6j
         VnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750403430; x=1751008230;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lycX0ICx6dcD7vbzS1mUfeWeg3x6nXLliXiBEu0+9MQ=;
        b=XXGJeMJI7kdzsrSEC0NfK8BNIFMK68o/8c3O3p+vkIK33VofEGnYywQRXZxkd79Nzt
         vCAwiI+5I3MqC9xyBzq8p+0HYPVITMJ935AmnJnurR70DfLcvhzwBsyKOF1dM7t3oC6Q
         c3scPTUKikF7rO9DR1YOdHRv3VdbRqpmnpr89tQE9pYCYhO5KkUcjfpGDgDMx0qKWhCQ
         xlFLttUcycxMuu6yVgQCcrIek5+XhENKB7PQTwPIX5jj0rQEXbfLwbZwhXba7QtLhETq
         DrfTWUiQEHGl5yiWXUreJPxX7wIjCu0zE8o+sFie4JQyF/q4zfYEGgPysWZlVY04uVjE
         CWhA==
X-Gm-Message-State: AOJu0YzobrmTvBY9xmF2+5STyi2IW3FjTZGgBCWsF0TMMq8sL/kwWf7y
	d6YhI6TA6bVJWQ9mMD0IEf1PXRw813wFKxRmDeq0f7rNA4abrg38kHxum00LDA==
X-Gm-Gg: ASbGncuUu44+MLNzuV1Z7gz1ufIe+86rVgRHLtXBDGj/NIxLqctNfBlk2WIiSjfaZIZ
	fxsf04iByUrMXep7uWctjJOEoCHMc8l711eqHrltbqo/3XSUbQGOmAFhQic5AyW6hRQCNVWT3I3
	gWrSPIoNi6QOhEOEdz/zNwWpsdc2VUCocRQr9Z/0Nl6dzPR/Qoo80+1b7cCjvzUaS2wKcO42sRJ
	gu8gfl+nFyNkx7m+c54UQXePis1nLSoLyN1+suagstMC1nh+cgG4fvNM+uBMzbWe8kWQCOW4uFU
	4E+KzazIFLowAXg/a6HxXhLe9bPeDf1kh3cKwXFSAz6RSGgI3RmYUPZjbhFJTiBvds3B
X-Google-Smtp-Source: AGHT+IFNiJf34k/XGF7Y9yvr/8vumEN8Tk6V5PS2JbRQLNiNP5qZF5UpBOcN8NxwzcGf3DNG+h06Xg==
X-Received: by 2002:a17:903:32c5:b0:235:2799:61d with SMTP id d9443c01a7336-237d991f9b4mr28316605ad.33.1750403429943;
        Fri, 20 Jun 2025 00:10:29 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.38.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8640dc6sm10768315ad.146.2025.06.20.00.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 00:10:29 -0700 (PDT)
Message-ID: <68550965.170a0220.36c809.23cb@mx.google.com>
Date: Fri, 20 Jun 2025 00:10:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3546068402041788680=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yuehaibing@huawei.com
Subject: RE: [net-next] Bluetooth: Remove hci_conn_hash_lookup_state()
In-Reply-To: <20250620070345.2166957-1-yuehaibing@huawei.com>
References: <20250620070345.2166957-1-yuehaibing@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3546068402041788680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974106

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.47 seconds
CheckAllWarning               PASS      28.75 seconds
CheckSparse                   PASS      30.74 seconds
BuildKernel32                 PASS      24.61 seconds
TestRunnerSetup               PASS      480.21 seconds
TestRunner_l2cap-tester       PASS      25.48 seconds
TestRunner_iso-tester         PASS      40.38 seconds
TestRunner_bnep-tester        PASS      5.94 seconds
TestRunner_mgmt-tester        FAIL      133.27 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         PASS      14.83 seconds
TestRunner_ioctl-tester       PASS      10.14 seconds
TestRunner_mesh-tester        PASS      7.56 seconds
TestRunner_smp-tester         PASS      8.69 seconds
TestRunner_userchan-tester    PASS      6.33 seconds
IncrementalBuild              PENDING   0.85 seconds

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
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.207 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.175 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3546068402041788680==--
