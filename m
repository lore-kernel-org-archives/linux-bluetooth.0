Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B132E7BBE
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553308; cv=none; b=try6rYIrUY7frV+vK8wBwDRDMzhN3TKo5S7zIk/M1nGHRoey9DS1FPeHFA0uAQcZch+YKymqF3X/T0f1sbiQp8CnGC5KAsV9F8wpzobZ0+W+8n34AzXUaULAqbVSPloEnE0v3ZTHviYEsO7MbpVXiYN10eJ0d0wJbS+G8Pq/Pxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553308; c=relaxed/simple;
	bh=qBuAfKOgYTg29WAxTOo6yFaA9qM5nIcvW0Q+xKS30wQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LKLkdu3v0s6NNvmaa8f09vxn546j2zoYNBLCuqUM8W/x6pP2RSKy8pnsejBEFhVJHGlPZfm8L5o2SPt3mI0rfz041UroZpDmtMcMNrryU0lx0O8LMsbxjVtDG7Bp6S4DoM7SoGiamoZHtXt4CoBZe/d3hn5LYVTe50LbmoL5tZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERmQCMKI; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERmQCMKI"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6faf66905baso69133386d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751553306; x=1752158106; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=noA0P0yjzPL9c1wcFbvc23qX6/bxIen973Dq9KqRz3U=;
        b=ERmQCMKIDZ+D4whXIHKFPwL6vCqUnCg5xBYPxiRrY/nafXMdRiP4Px/oHrex5481YZ
         0mwUDllJb18ymC64RuhLXaoAYf5zpUrdlBFpaZjtw04BESWNL2IEQiGDAJJfbLkOjXSv
         OmDqkcwwOpHR+dk4ogsPddByipZg++dfFZGolAdeZ0th+RCgJ+5LkpsKF1CnlMaOKHH+
         5PKN1mmJOLO3y2ofR6QPGsfKf/okniPQNMVmApQQCpk6+Z29DybZyg82fetSBKOBmT4t
         kMTvM49Y2PSoCLt0PACcsg7I3iAt98fxkwThYUl1OJpn63J8FpW2anykxgoU73idE11w
         50gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751553306; x=1752158106;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noA0P0yjzPL9c1wcFbvc23qX6/bxIen973Dq9KqRz3U=;
        b=kmrrnf9rF6Bwlw66P/20NqTRU4UVleNcLlw4YbjmUf8RN29fg1dYSujliIjgQYNvyr
         wmcazVx9dHXszFwN8JN2XjUhz2G1T6u43IM//1HvcyszXVbHzh4uKaGXG2tqJ8nPURjg
         D3WHrgdGo2/vy5/ofVfow2pOlSQtaLkFujRgFsAmV1DkDwNDbpLZDl6BjutjpMXEJOzJ
         aGrWsmefvtggOcgzLpYpTHaijuDtVekMDIZunQ8X1T06mbZshtcmAWtJqIxW0NYDtZ0T
         5QcXyxxBVeljBVlOI/f9InDOMQYv16un6naYKvZXkJQU/eQ8OyaUcUvUWx4cJyRUDcDs
         o4ag==
X-Gm-Message-State: AOJu0Yx73mrIiHGGHS7pXv8pRabN5Q+tNny/WMOAWywaoYPFpuLUx2LI
	HEjeJ5gXPyFpKFrptm8xie2+mpqtMZq8IvNBdbLuj5O0cRyPPuImdOZJHCk0KA==
X-Gm-Gg: ASbGnctQDkHOHezMNFhaRPWSEZDOozVgcD8WseeCsE3P34oBZxXesGwhlbMi6U7ka+r
	bv+RdLe89XXzk5iMTy6XqoTtQoIN/ONUOzjAMfXtT6xEhxHmYfUy9iq00S1GL8NgtqhtrDPBt6S
	VdyAQWsTOHeje/gEc6+zHF+Spy7sfaJp3lhOlcsGZRdxdioZX7DRRShVj2HFGTr2jMg482hBiLf
	bSOX4OrcXW/O6Q9fSSaEW71iGlBxe/1PdXbYRiJe2K2QA2yrZ7YFIzlxfTsV0RGLz07r5a+A39R
	SEqGOk5spDLrL9EpB4VTP3NlDIqwoi4F3UKQ2HgIC2TUOM6uR9iEYoQuWUfNB/9xPEQhre2Bfty
	qEATuJg==
X-Google-Smtp-Source: AGHT+IG+q2loZGmtuHyUzkZ9bSRwaw3JaQZvxUr9xnZtgVAVEV0bMbdFYKhQ9x7pMoYEUBBqQNLcWQ==
X-Received: by 2002:a05:6214:519e:b0:6fb:f19:66f2 with SMTP id 6a1803df08f44-702b1a3e750mr113537396d6.8.1751553305553;
        Thu, 03 Jul 2025 07:35:05 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.147.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772fcb9dsm118836906d6.88.2025.07.03.07.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:35:05 -0700 (PDT)
Message-ID: <68669519.050a0220.24b07b.b3c8@mx.google.com>
Date: Thu, 03 Jul 2025 07:35:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8185284927956915562=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix attempting to send HCI_Disconnect to BIS handle
In-Reply-To: <20250703135418.1693699-1-luiz.dentz@gmail.com>
References: <20250703135418.1693699-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8185284927956915562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=978657

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      23.97 seconds
CheckAllWarning               PASS      26.70 seconds
CheckSparse                   PASS      29.98 seconds
BuildKernel32                 PASS      23.98 seconds
TestRunnerSetup               PASS      467.98 seconds
TestRunner_l2cap-tester       PASS      25.24 seconds
TestRunner_iso-tester         PASS      36.33 seconds
TestRunner_bnep-tester        PASS      6.34 seconds
TestRunner_mgmt-tester        FAIL      132.26 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         PASS      14.87 seconds
TestRunner_ioctl-tester       PASS      10.14 seconds
TestRunner_mesh-tester        FAIL      11.49 seconds
TestRunner_smp-tester         PASS      8.70 seconds
TestRunner_userchan-tester    PASS      6.24 seconds
IncrementalBuild              PENDING   0.50 seconds

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
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.190 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.223 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.065 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8185284927956915562==--
