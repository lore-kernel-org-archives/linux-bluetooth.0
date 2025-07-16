Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13A25393C
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629654; cv=none; b=bxU//8oNBXT9AAlyIBIdKEjw/0ryIomFsm/tzqOU/iTJkPVsuBsecWF435t6rai/XR0mgFkcrMJUBly0MEQ9sTa+xMJfqJ9wK/9huVRIc6jHCvo8Voe6ZtIBISXpTQJfC6XDxpg3W2HwiAk5/rpDwFUn9HxfDcPQ9BcpWGT2Xac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629654; c=relaxed/simple;
	bh=3qmDt9GcoN3tO7790PJeAmOseIlhKF2pz132ouqjRiQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E/DQgDvXDWAoIAge8CwgFz5OtuE54l55H14Bq7kT89sDEAPJR7GvwbZUOlARW6Y7EfWnvmRn70ohub1e8S0NxbnUkuvGwgPmbZEjNt7+umlpNcUDPQprx46GmAd0eeCzjXczjJ2U04+OT6/oLSXiZ4Kkng9NCjK+cQ2NB8chF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+G2Lzwm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+G2Lzwm"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74b52bf417cso3877121b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 18:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752629651; x=1753234451; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8l5ke5cW6jyaNGiONMLYsuDa8BI5TGlC3S6R1wHbaaY=;
        b=B+G2LzwmH+O68cwGrvzNzlfiJNPVtoODzJ/jVqEBjLimK8gGZQV16VYXjrFoIh39hX
         dl0SGBp4Le9KmsTBYMGCpTxyyXlLg5mUckT2dfKWzrhyzeMHy9joBK/OlFXYjV2hwmUe
         IsSleGJ9VoVdJoNzo1s3rA6t/b63wuhxfsp5PDU1d89ogEpaTkSPZr0qcBRppcntYZbY
         QWXVfwhrCGzuq9GDqSWpaBfefkxpQa4U0kGEwKJK1+PMfx1Z4OQM07v2f42MBv7qXKaW
         tTnNiYhddlcyti/Uo+hDeXrIVSp6HIlHvJWBoN+cL23UObCtXdnGIIqK4wqJfUg/U83B
         gUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752629651; x=1753234451;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8l5ke5cW6jyaNGiONMLYsuDa8BI5TGlC3S6R1wHbaaY=;
        b=Uz3hBMKM4oxQ97vroMML8U8tclPgfKhehnqNyqsCN4EppCJy38Pq09pZv2pZQjcpjo
         zEG2cDRX+xyD9IvKPEsMxHr5dghp8mQIt6m2KLZEMSCzelHaS9t1K5FBvO19KPMvVFbJ
         jL7iz9mHuWX28w4usnacY3M+NVoGv+nnlqixTR2UskMcQAbY94UEMC4f9+F8cOfNvSg1
         ib4RuXewNnNOIIl7amRMZYo7ToBObzj0BGWuw6Mhni+yvCDlm1kynKqcm3ieA0+ztf+x
         PAEHOuJAK5LSTwZC9MVVilEXpKTo/KYYvd1ABnoG+4cLiuMxl0LyBhIgD+rXJzP203o/
         b2kw==
X-Gm-Message-State: AOJu0YwKrFoK/fR6jfvi7XigGejRVT2N3wNyLF200v6GIk3YCFXiAhkJ
	PTY89JlnKI+7YG9eW2vxOFIHRSozeZFQl/F/s0Z9CFETvBU9SskyP5f9xWua0Pp3
X-Gm-Gg: ASbGncs5QD3qARep6wph3Cb2HCMTXjBXhLUEzHHEXcBuj5b5Tn2LUD75lWnTgef8g77
	FW+/t+qtulS7n0mOaz82r3umHTK5RNw2+oHWMSJrd44xAbm4rWEPfVZ5kqV0oYhZ7eh4dhlHrEh
	j+NjLp9+5A9WXTdPes9B70YL+h1iNAL9DQZjg7RqUDGTN1g7T2zmmje3LzZ0FFQ2RmgTXObvECL
	6yxe0yl2BktLsmDv6kHoXCys16YU94m/Ls9vQNysNZhrIiq4iHQoDsgn6Os6syCUu1qD+YBkTaq
	qepbMjuvAxC5UfOxvzw9ALGaDmFkSVsdSMVu74u2g++u6IKgxltKPjXNRWOE1QMXU24Attu6lsH
	HBxV8wPQPlDfjVMbkn1P5YzRsYtB5Bw==
X-Google-Smtp-Source: AGHT+IHR+uZVbcVDss2DcFwy7bg9OxdQMnq3L4pUSnOPwBAxQVpn6NHgYDRdXeNFvKD2uIjhKcIzmA==
X-Received: by 2002:a05:6a00:22d0:b0:748:e0ee:dcff with SMTP id d2e1a72fcca58-75723d7d2c8mr1126271b3a.11.1752629651407;
        Tue, 15 Jul 2025 18:34:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.196.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06a04sm12058917b3a.44.2025.07.15.18.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 18:34:10 -0700 (PDT)
Message-ID: <68770192.050a0220.346842.7cd3@mx.google.com>
Date: Tue, 15 Jul 2025 18:34:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6195540799257023679=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ipravdin.official@gmail.com
Subject: RE: [RESEND] Bluetooth: vhci: Prevent use-after-free by removing debugfs files early
In-Reply-To: <20250716004252.125466-2-ipravdin.official@gmail.com>
References: <20250716004252.125466-2-ipravdin.official@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6195540799257023679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982756

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.91 seconds
CheckAllWarning               PASS      27.48 seconds
CheckSparse                   PASS      31.47 seconds
BuildKernel32                 PASS      25.09 seconds
TestRunnerSetup               PASS      485.88 seconds
TestRunner_l2cap-tester       PASS      26.03 seconds
TestRunner_iso-tester         PASS      38.66 seconds
TestRunner_bnep-tester        PASS      6.12 seconds
TestRunner_mgmt-tester        FAIL      134.57 seconds
TestRunner_rfcomm-tester      PASS      9.58 seconds
TestRunner_sco-tester         PASS      15.05 seconds
TestRunner_ioctl-tester       PASS      10.53 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.80 seconds
TestRunner_userchan-tester    PASS      6.52 seconds
IncrementalBuild              PENDING   0.62 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.181 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.184 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.186 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.962 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6195540799257023679==--
