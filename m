Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290C13774D
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 04:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765253638; cv=none; b=gE0M83U2eQoWs6NakTRqGBHRqVZYsM+fbXzdazRyhlsfRzXw0F/3GRw4y80xNA0UVGNwftgh76OF4fTHp2pHw5CH4O1sZc8aF3kjMPD+3Z5CSpFdZptsBeZF5LPqzPoj80LSPsYdW85uoEkUErwCHNQzP4R8fPW9b8CHKmZJ6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765253638; c=relaxed/simple;
	bh=lrEytjt+rx2kth0W7jhMOWS8EaTYjokiISqh9QA0RSs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OO19q0YwWyLF31jwo5o00oSYD0Bk+PSOvAuQ3I7m1ibxP6AtuWahe6fF6X/JrM119C6warMqV/VsOkwtlYL9T/Rr4lkNzdfrdPghNEmYR5s0LfWNSUVnkCKW/+/9hIvWccYs7cahtDak+0MA8IO2e+G8wTgJS7X6elEwKqfYk5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOMhzCsg; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOMhzCsg"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b1f2fbaed7so503497585a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 20:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765253635; x=1765858435; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzLmYD9LrjGlLwAM+FYdrrvqSFwxYvjyl80dtDOZFbQ=;
        b=NOMhzCsgpxsehJP/LlEwSja+NFOLhwcSqWh0pMx2Fny5MtZ6QH12kCIIRd4ajZf+Yq
         X6hDd5SItBXUWIGgjqeZL4IHWt68Vy6BtDQR5Nm7HNqWl7BX2nm2s8rX866W37m5hcc3
         iajnakCXNhq3s7VaiWEJzaDWilimhZbzzL/xbEpE/QSqWxC7D2WS1qopp14oDLRNC9dL
         wP1/xZnZLEHm/5Jb04uXVoHTCqiRz/IdZVDBKMUu+CH+0PXf6MCQPos0qtFF4lQ5gef4
         MXnSnDIyazz65zVPHReZ/fl5SOYBkAyhad5Bef2N0FBsi4bRgqA8gU7S5vpt7PF/hJ+d
         EKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765253635; x=1765858435;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzLmYD9LrjGlLwAM+FYdrrvqSFwxYvjyl80dtDOZFbQ=;
        b=jOvJEKd8+Z6k90uipiMaC/1JmFu7MRvFcLMdoazrxUo6Y8mqH8zacJpXxt4QLs460R
         Uf30dq+6Gem5Xe5bl8obHjlGMvnOGLn7B9DQ/NFbZdxjxN2VXpU7aQ7s/gm773ntDemo
         /UPun2G7Nj+cQALfUDSKqJ2sPslfYuzhAmCKPIrkPDksr3L0MSKnAO20P8tNUvFer26R
         OVmfuaEq2RkCF+RWztGCdfktNjHnLsjhG9mSS9GuLo+kNGXHZCzUCzlFlvE2MtDqXdg0
         kEm0zxloSiD2t2Qn92bDEbeyEluYcwPc1DhSP1TYXGbWKRESVfzQ7mj20rKbUJXUr3Wj
         cHQg==
X-Gm-Message-State: AOJu0YyjoflA06DQe8VR2EJjeMoJywHUScdwfvuVPiCNB4Q1Mn23227r
	FD0L8u515O9Ip5QlKp/SRv2upg9NYQIUCADA24Skk8FKz7+DKTofKTsFSycC9Q==
X-Gm-Gg: ASbGncvLsQocMYbaASw3WdriJbLfUmsBxUSI3GcsCxn7kCh5G2JWV/rKI77HU0bC56E
	vhNO5anjYXhzEYUFijZ3cZEtOK+G5YLrwzGh6a1Y8mED4WxNxcxA9rwOs6P4koyJ7zal2xz0tsB
	UXckynXElCBYlqcK76elDpDwRXYBVX5XEtcRG72k3pCJmvyPy2xxIK0CITLw0Vhqy3Y5lVN6zId
	SlET/xqP4U783S9eONyORKdiQ/jg5G4oD44Uoi+vRQkz5yxy1a/vwDFGK/41+qKSMco3YQ3LLMO
	ngASCEnfzASDVFt6qAjiMEg91QNImfeq/rVgpRyl9EMWvzkjYJbWW0hAAqCXh1hiFwF9UqBAmvB
	QZWOelxP2d7hERFkUVcw1Mxldeu3NWZCvcXhqXrSc2qTdeTjvNmITwvh+ZWsuGoiMdNGGCdJuPi
	YJmskinhIz5xXRUMM=
X-Google-Smtp-Source: AGHT+IETFRllIEAbSqArMEnKtxQFxczccuw3U5ZTu26fwet3Mm0BqBsXDCMsoOle8P8Yg+1+mjMwhQ==
X-Received: by 2002:a05:620a:4047:b0:892:526b:fa6f with SMTP id af79cd13be357-8b6a2589a88mr1304315885a.71.1765253635305;
        Mon, 08 Dec 2025 20:13:55 -0800 (PST)
Received: from [172.17.0.2] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b627a798desm1192091185a.33.2025.12.08.20.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 20:13:54 -0800 (PST)
Message-ID: <6937a202.050a0220.2a44bc.1d37@mx.google.com>
Date: Mon, 08 Dec 2025 20:13:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6704435241949813946=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: [RFC,v2] Bluetooth: sco: Serialize state check in sco_sock_connect to fix UAF
In-Reply-To: <20251209025945.3555605-1-zzzccc427@gmail.com>
References: <20251209025945.3555605-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6704435241949813946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1031538

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.71 seconds
CheckAllWarning               PASS      28.04 seconds
CheckSparse                   WARNING   31.53 seconds
BuildKernel32                 PASS      25.23 seconds
TestRunnerSetup               PASS      563.01 seconds
TestRunner_l2cap-tester       PASS      24.94 seconds
TestRunner_iso-tester         FAIL      47.35 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      128.14 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         FAIL      14.50 seconds
TestRunner_ioctl-tester       PASS      10.42 seconds
TestRunner_mesh-tester        FAIL      12.46 seconds
TestRunner_smp-tester         PASS      8.72 seconds
TestRunner_userchan-tester    PASS      6.76 seconds
IncrementalBuild              PENDING   0.66 seconds

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
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:153:35: warning: array of flexible structures
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
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
Mesh - Send cancel - 1                               Timed out    2.696 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6704435241949813946==--
