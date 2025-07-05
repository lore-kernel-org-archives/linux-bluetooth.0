Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE99BE5E
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Jul 2025 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751715111; cv=none; b=nBy7SOQG9IZVXYMBGF1QKO1jE9DzZ1N3DYHKAuaPtG7YA9Mdk1pBUdRM5aEzcPp3b25MJ5N6KyduxOQySlo5LQlQUdmmpkR9Cjrm0xhnPCGx8VPpUyppNBWY0frb4FO6NmWxcCKM2dv+sUVU/z1o8TY1QlWW24z13cuUtVsf5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751715111; c=relaxed/simple;
	bh=LW8iEHyw/J3mMx/f1hWRo104gC/0QuzuBdeATMgAeXk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b/mn/Yscy/+R48fKhzGXnAVbDEP4BPHF4akgxbtZk0QY0b58xqXsOGBJCrxKQMNNou6k6mla3hxJ5ysKB4RimBWJSM+lMJ2/l7Z591XbXDBl45NUhiKt+5bLIYLzMvoqT0WmtYU6HuN13nwzlfU7pdzpNiro8PEAI1S6stQIiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB4Il0lr; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB4Il0lr"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a7f46f9bb6so22267831cf.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Jul 2025 04:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751715109; x=1752319909; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2dfsKscMWDMqBsrk5j1YP5Ya2d/cPSM7dSmd3o3+bPo=;
        b=YB4Il0lraqqUV9Ucl47ey2Wl93Nd6NlfY4xJLhe3Y0I3h4V52Z0Mmy08teXHGvk3vF
         CSDl3zFd87T1n8rQI/H9ojjRYbwxZLYtN5pYR9a6gZnJAbrhR2TajwzE1QxcPl5prkdq
         7wGnL+coMpXRAFQ1IIS67CyfbUIt8Befzf2xBu+IoM7qmgPv+bQeCAzjXBoZXPtPhzll
         shVCKNhdXTx5F5DOexEDloqxGEHePa3DOd+bOgeKLKnfFPxQ3xzNA8BScw6OO6nBO8gc
         1NSIbieeVgcbsmPFFl3FxCU+wHfoUpi3CulRgEsuY3SCV2/g0hChEy18Q2Dz1BbxE3Xw
         mM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751715109; x=1752319909;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dfsKscMWDMqBsrk5j1YP5Ya2d/cPSM7dSmd3o3+bPo=;
        b=UjV7hGjCacnomhGF3qnjPowJtV72yPrVD3h9vITBAK9IrCwlEoXgrLG7QbN2CC4bqk
         Av9U4g0HHBc9YX/fitTrcne8+9km0smB6ruIiwXL4HB+ZeZQPA3QuKFNqmQYhYdqpB0K
         ezTkQ/SJUxuLZ2QvO/4N2+EVI2zuuJPNImEl9By3EIWuh84MNyOl7SQq5FLbMwBQWGzx
         uflH6RqcdWt6XYrljqei+xooTtp6kf1Pcd9ZvMGB9PVQ9NXwLmdEKg2tHGoydIHN7gcm
         60BJw34OI8/NkmBYORb4UGUDC+j/N8R0x8+mjnaYdW4OC0GrC+jOfJWgeLJiBJCkR+bw
         BORA==
X-Gm-Message-State: AOJu0Yy1q2wXyWKAsQMNqa/+WUym/eW2tuWUaOjCjo9j5XVZqdohfbCA
	q14r3KJ5mghC2cMKPxnXCh2ueC/ggfuxXxzVZPUqq1fVuwdu0cIlR8dO1Flilv0F
X-Gm-Gg: ASbGncueXe5gsDR3NIKQAKD59ydT3f8aGGxK6xtDobKCY2IPwsUmc+1fZOtaXkSTXHZ
	lmf2vKMw7zpW4mDFJ+HDiIpi0KZTSELGRqIRzE7BMGpvQnefPK5jhxVa+C9TX4ztdISxRqurwWY
	Pqy7k8bpb1Dm9jiSlOB2IxHk/gy9l8hZK6Zmwy4VB6u9uR9so/TDqBsCkiZ3mDDgxke760pitwE
	3MejXakQYSODEVasFQ8I7cm48byybavcK8c3zuS9wsRg7jtClfORLS9mN9Frr3m8FN+xp1VVrjJ
	SC43TWCJHF5y8xsi3YkXu1LvwQz2uf1AiyUPY6RZIUZwG4qxugtqHHajVF01vZ4ifzrnVD03mLi
	/Qt5C
X-Google-Smtp-Source: AGHT+IFOp0qicO4sRcMeez6dWigTDO7gu1df6zwzsQOSW44mqeIsQsfjK2tNEusyeRzXMtPK/7Sl1Q==
X-Received: by 2002:a05:622a:788f:b0:4a9:a2b1:9ab9 with SMTP id d75a77b69052e-4a9a2b19c04mr38098761cf.39.1751715108597;
        Sat, 05 Jul 2025 04:31:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.183.223])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9af335726sm1665621cf.1.2025.07.05.04.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 04:31:48 -0700 (PDT)
Message-ID: <68690d24.050a0220.170253.0bc8@mx.google.com>
Date: Sat, 05 Jul 2025 04:31:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6325071500571116687=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zhonhan@quicinc.com
Subject: RE: Bluetooth: btusb: Fix potential NULL dereference on kmalloc failure
In-Reply-To: <20250705105246.1383084-1-quic_zhonhan@quicinc.com>
References: <20250705105246.1383084-1-quic_zhonhan@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6325071500571116687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979318

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.24 seconds
CheckAllWarning               PASS      26.69 seconds
CheckSparse                   PASS      30.11 seconds
BuildKernel32                 PASS      24.23 seconds
TestRunnerSetup               PASS      468.93 seconds
TestRunner_l2cap-tester       PASS      25.27 seconds
TestRunner_iso-tester         PASS      36.10 seconds
TestRunner_bnep-tester        PASS      5.92 seconds
TestRunner_mgmt-tester        PASS      131.77 seconds
TestRunner_rfcomm-tester      PASS      9.43 seconds
TestRunner_sco-tester         PASS      14.67 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        FAIL      11.37 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.24 seconds
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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.207 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6325071500571116687==--
