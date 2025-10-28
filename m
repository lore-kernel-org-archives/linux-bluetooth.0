Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256052AD32
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655827; cv=none; b=E8b3J9OvCagjBVPgMrA8MsenTBgp5U0agnRlkMmyvgW2ljufirJj9gBhaaAoRpIcIrvaHmF3B9W4Oib/UdXZ7iilZQPt/KVOarhN3VBqs0lAbVEXtS4EYotyfwGWgiQYuE5dHRotqSQjuNw6RrUhTkInxTNnjHCTtY2RJUt4gBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655827; c=relaxed/simple;
	bh=uJS3SOfOf+0QVNBmyKlmDYvvr5ZhaDS0JOEJaA60uB0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M0OZJsxPovXP4P/v1Je1Ojx/xC5krUSVmRwkMI7VU2eBhMRSsZpR5zlstVAzx/LQ1QQe5EXohVtpvxD3YscedjGdOEJVw1uS9CEbyUwZEgfcZE6L2LFrUAZaMQ8Q8QhWfbb8wbmHAMH5SCgTBEfSsQ/b7Gew/om6qrmdJASsfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQHdF9R1; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQHdF9R1"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-945a4218f19so111272539f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761655825; x=1762260625; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nylL/uzx3BZLpMcAYAQ62chFMdvwyQFr+MU1oYtdlVA=;
        b=YQHdF9R1jvZUTDEhFEKzBBKEYDPtZI56j2+qJWS2Sye/H4qL0lzWuVS6Hos6VOF1aN
         6bmYqNcrR/6I+wmC7cl12yXifTrRDKP9rPYNGTWjBX/eiCON5wA5/HAcGroQNRSpn/p/
         UivnZ3OYLREeczD+agSjDMsRgjrHvs1iu20aN+fmh5qUTddrFG+v8ZeeBrfnnP1Fpi/V
         qrP2YKR14pwYDvkuodiH60dWxZEwpy6mFizPT7yBIse3cg0hPupQBWM/m2Wj7Tzyqyn7
         mI0cOCjdz4Oewi4htalrtBnUDgY5PxPujYaITA/8kpY6pJ7PmXaeAf/zPQ59U1wfnBN/
         OpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761655825; x=1762260625;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nylL/uzx3BZLpMcAYAQ62chFMdvwyQFr+MU1oYtdlVA=;
        b=ss1dOdLkiGpxJcqjaTtwciuicSJ6j+fW1kWuwJhhOeSTF8di9cf18JsHpMXslzVq39
         gd2/BSHyruUeH28E0TSGGGnbx32v2ieJ9XVGp37KYR2Abn5GYVjBvzUwvBoSuBBgFKOL
         Yl69tRdogDgzTQ2kMZZydzjJvlYTYCQ8Nd/p4xGlo9za1l85W5jGuz+H5hT8BVUw7+N0
         F2hERzlDBIexGdsOZUWHeEknA4WFbCyfH+uMijA4ht3HJU6vo6EPwe+GiMqWsCwVHtuX
         Lr5o3Rj29hQ2XgKwdnCqkB+Uui7/zz0tKGJbhwV6hMR/EoEmoRNo+5sqF7VEC8SvQoy8
         lcKw==
X-Gm-Message-State: AOJu0YxdTBcvTZFZKnM3Nqix7wf5K/y80tMa9mbD1ZuBEA3Ce9x8ErHa
	zg7uY4xU0cDKX8aNuNSyc/ZHwRNnLf1CpbaH69/Fpqqaj8veezOEenyXpZd16w==
X-Gm-Gg: ASbGncvGKT4Uu9uApN59iLqhcwSWpNnluoj+WEnuSOxOs56ThscPH4JZPPXXl2enclZ
	79XxVVeS00T9hM1G14BKSf5cZigWSIoV3tLz45UyMhWOWJkSZAvon00V+nJf9vUksOrfMLgIib0
	/oCT1hybNRn/XIROkQytZeLvNesFEghYfc87zVF5DT2ejdqGLuFMS3KAXNtwRFh6+NPh3XQMQmP
	Rr39Ngy7c8PID21O3qrfaI8BeyZZ6zJLclZi5TyQVVw5WT7t0TQbLTZIXRGfbVf+xUsNo5hyJF5
	SN/k6CNe1pnkh35tbKAchenFJ/p9c0EJkBGQZyE/XG7yazRw6WNCZfdESwd/JDuCjG1K4BefBGi
	pAqDs+EwsxqX128E7yd4gnVfg7qna6/8mfSJ+yNfUzX4KL9bhFI13YclmpmnQmlZEWFUyY+2dHJ
	7FigyjkBI=
X-Google-Smtp-Source: AGHT+IHS6aWRRFG+nZI1iA/OSr35hQTLlZrh51/DWLii5Spi3S4ggIloT8aq6LtdO276JCwLkeHK3Q==
X-Received: by 2002:a05:6e02:221c:b0:430:b4e1:bcb8 with SMTP id e9e14a558f8ab-4321042b6bbmr43457695ab.13.1761655824879;
        Tue, 28 Oct 2025 05:50:24 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.176.228])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f688c090sm43290665ab.27.2025.10.28.05.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 05:50:24 -0700 (PDT)
Message-ID: <6900bc10.050a0220.253984.6b72@mx.google.com>
Date: Tue, 28 Oct 2025 05:50:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0554774078269027772=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: add default nvm file
In-Reply-To: <20251028120550.2225434-1-quic_shuaz@quicinc.com>
References: <20251028120550.2225434-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0554774078269027772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1016703

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.18 seconds
CheckAllWarning               PASS      27.70 seconds
CheckSparse                   PASS      31.04 seconds
BuildKernel32                 PASS      24.76 seconds
TestRunnerSetup               PASS      500.96 seconds
TestRunner_l2cap-tester       PASS      24.53 seconds
TestRunner_iso-tester         FAIL      54.49 seconds
TestRunner_bnep-tester        PASS      6.60 seconds
TestRunner_mgmt-tester        FAIL      124.21 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         PASS      14.37 seconds
TestRunner_ioctl-tester       PASS      9.94 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.36 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.87 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.098 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.099 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0554774078269027772==--
