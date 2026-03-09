Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BB01DE4FB
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096349; cv=none; b=UUox5zROG/wm9xHVlCuh/pg6jsgK1aonmMjcgrB9XRzyKoVvKvqQnAQ+CIt1OBAI8CmvlvIcIq3KHqcNFOIyi/KJX7mkAixATFAyHn7H67g6BAA2G4+de2fy/c+2eYHR/1lLwVnf3NQ9Pfvh+hY1YxByRQxWz+zgk8wfz5yh15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096349; c=relaxed/simple;
	bh=iNmNinydZRh3xAoBuON1as4MzpILBQn+1jWrVODcmFE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hIVZN0jXdyYV+xV1n8ghryeI6Dq2Wh6BA3h5Ce8Oprff0ebI9hj4W8pzeXacai3QV2jQ9+MfkYAEDJ334StraGH6R9xDAbBoccueehDaWmYa2KSVx0nt7yWEpK4xJ9PZbK6zG+LZaQ9/YQ+/KzhPozcdXP5Py5AkrLWDLi/O1Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em8Pmj2R; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em8Pmj2R"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b4520f6b32so14630186eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Mar 2026 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773096347; x=1773701147; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9njJ439SLo7NJwNHbl4Snp9vE22Ix5yppkVK7s44grg=;
        b=Em8Pmj2R/j0GG7nGoH8i352eIsKGXn3SPUpIX5fbM4NijLc0/ZIgwlhQtcUuiicL6o
         Z04YuGTQrCXjCO04SiWXb5f8dDuDKrujR+O5/KEmTXgrKsf+Ou1EV6uRaLOJoUzzTmpe
         J/Sfm+c5rcH5RUpzwsEcbBjGhlkOmipiqffwFAxiM8VeXN7YNT+XX3BoTKK6aTWSHjLY
         ddt1d8sbKRb6Zs9kqwIakto38ycAW8/XNZ1Vc3+CD2bwk3vq8pgemX7ogZw9ifCvghVy
         H9aLW7gweggfB/wxxU7hN4kZchvGXxZAnBGMfcJ+stc0YucMf1vGzhedYNmtrk2Y1uWh
         HhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773096347; x=1773701147;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9njJ439SLo7NJwNHbl4Snp9vE22Ix5yppkVK7s44grg=;
        b=TK6Y2t+Lat3TI4n7PSlVVQE0tqnJwk3qFr0P56TL7dlkn79vSM0fuqJlv9ptMtLdk6
         m/vaGXRz4BWHt9HMAtUKvtU+N0XTQPqXgZrDgP0Xxj8rIu1kOHjgMEapTuQHlrnXpSvD
         QJ9Ssiog8RqiD/G6s4mnTGs3bTUe1uwpZXrcqD7IoXCmo/lGv/cmo7h+nHNy7GxZlmsW
         0AIrIkDJHFUHxpK/f93PxuilKo3zWONf1TA8HdPR6Xe8zDvXZ0hStQf1ZcfBsBuIGofY
         9LjTugke5DyTAoP/n+wYri0EfnQJudT1aHzsP+pIo5l/yXNt/dFMU6wl1lDYWm5nLwNb
         gYpQ==
X-Gm-Message-State: AOJu0Yw9nhGjFGkV6h/rfemTcv3P38Rz+DifgrlwSp/4acfH6eo86uv+
	IPEaKMv9nMFSjShiT4GdPlYafyQky1t/ihWD3Rq8usLTXi24gJpC6RZHsfjIlA==
X-Gm-Gg: ATEYQzxec3GYQaDVm6B2p2oXioEjH0tAuetzAbxbZlAJD0ccQPTn6zmqekZ5lAiIaOA
	4C5X64Q1RRpfHmVB2ooWrB8XAd9s5XQsqGLzTf5OR/BGZ1VWggSBmZlFWHNQJYinzl+b8wfcrtK
	4i/UkadHEwerkam9sIFmg1UxlGaCUVTSj2jzBIvlQqydQLHNj9yVRU+RU+RWtrjF9tgiKc3kSmC
	YcbPMeh1Dg4cJbMjt+Q7v1QPkDJYV3vd7CkPsDXPdKS7dIgmN0wnQLKwgpzztsaBvKjFlBmuwdG
	fULmhf15YUVMiOsasBbmh59rUbmizRFoAcOE6lfG3ogKt7XBKgsw5gpkWMAeOx8a5mZBkpLCHQd
	6nVe64YQLWewXjnTgmGQq0atYiZlmwM7MWMogcsLJiKBBFoxgpgssDLjm30UiXptw/Fm30ULOQ8
	81C4MiHq8Rr4pKqgtGEuyf6Dyd1eOhpg==
X-Received: by 2002:a05:7300:a187:b0:2ba:8961:e1a1 with SMTP id 5a478bee46e88-2be4e03ed63mr4922814eec.22.1773096346675;
        Mon, 09 Mar 2026 15:45:46 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.225.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f82b1d3sm10981346eec.11.2026.03.09.15.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 15:45:46 -0700 (PDT)
Message-ID: <69af4d9a.050a0220.114ab6.f754@mx.google.com>
Date: Mon, 09 Mar 2026 15:45:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4250090497898240750=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
In-Reply-To: <20260309220343.190372-1-luiz.dentz@gmail.com>
References: <20260309220343.190372-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4250090497898240750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1063953

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.70 seconds
CheckAllWarning               PASS      27.82 seconds
CheckSparse                   WARNING   31.67 seconds
BuildKernel32                 PASS      25.07 seconds
TestRunnerSetup               PASS      524.35 seconds
TestRunner_l2cap-tester       FAIL      28.99 seconds
TestRunner_iso-tester         PASS      93.14 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      116.07 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.60 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      12.49 seconds
TestRunner_smp-tester         PASS      8.87 seconds
TestRunner_userchan-tester    PASS      6.72 seconds
IncrementalBuild              PENDING   0.97 seconds

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
net/bluetooth/l2cap_core.c:7795:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7796:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7798:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7799:1: error: bad constant expression
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 91 (94.8%), Failed: 5, Not Run: 0

Failed Test Cases
L2CAP Ext-Flowctl Server - PHY 2M/Coded              Failed       0.139 seconds
L2CAP Ext-Flowctl Server - Set PHY 1M                Failed       0.143 seconds
L2CAP Ext-Flowctl Server - Set PHY Coded             Failed       0.134 seconds
L2CAP LE EATT Server - Success                       Failed       0.099 seconds
L2CAP LE EATT Server - Reject                        Failed       0.110 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.216 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.718 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4250090497898240750==--
