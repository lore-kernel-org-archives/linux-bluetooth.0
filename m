Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BABF36404D
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774793473; cv=none; b=gOxEpoKsQMAw5uJadj9UgduqvdbUOey9g/UZ2RRMYgOHoEUBIjmyaGBn4aETdxgqsPkIS2UCKoXb//igr8wLx/g7i8clPrhM38zrasy1qqpxwACk1eYOjVffyIXM6inDOTGfkCeym7D8iy1fsK6NRjC2KriPb5ag83DracpqwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774793473; c=relaxed/simple;
	bh=yfOTyHqU3hcPjGpBkL8oBCi++AYa26zmTtmvSWQ3I/o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mc6GU/pd3GlW1bGRinmxfBYF3wOk3pmF7spaUrxeEfPYi+xMAkeKvio6Lqfq2IuIpQk24m5FVHbBuEQZ5XPJ9e6JdWKMDPssTFlc/oIqg44F43NY8AdN/01q/okpRijcIe0zUjwuvOdqJQRVWbGhXKGoifPyBBnZrEcQWRxJ94A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBzGeyei; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBzGeyei"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12732e6a123so1167655c88.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774793471; x=1775398271; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NTrO1zz6SUFXo0NygqJlKhiPnHWFCXzgxHiZXHSL6xw=;
        b=hBzGeyeiYFU+4X9jmyEYPeM13xBOow+5qcfSMJhPbWRFeTARxsH7O9WmKA1AHmCRZP
         L9ps1OD0kg3WnDpdIxOBMsjNkKEl40cPoEsRw7Z4Qo3joWkdE4djJwUsg0SnXXnkn4H4
         mgklclab5XR7MOWEwieVj8ghY5GPSMkx3cegkxjiNR81njeTnX+Fpb/iud3PID5VPIFe
         41QevfkvX6y65JgGEffCO2zp/F5y7o3b4TI2lIi2kv8Y+SKjEI0oZcakOgdNuUNVr0Mb
         KYNTadEGKnN8hVRsLP1ZWlUDeeqTs9//74VNKueHkLaL0txDqQZOTwvvw9Y7hUER4sJw
         pKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774793471; x=1775398271;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTrO1zz6SUFXo0NygqJlKhiPnHWFCXzgxHiZXHSL6xw=;
        b=c5oeUaX+SNM92eK8R/prEPMALTrPioegdEilJlXtjhpH1X9gVlMsO1lOLC16JL8tI7
         5jtr5U5Cc8B5TpPZnsJU8sBR1LFVZj1fX2tfrgymdcA+tmBbPHFKACiUOJoXCI98ss2n
         EgFwBLNvUcTu32V7CSrsf42H0AXzyREe0eUcZ2Sa04il/qvwoamprc0B7HZpR6HWzph2
         WxKIdC30WXTJ8RKdE4/Dr8zQHQFLx558JoqPqrOsXI7rR4xsxuV7YxY/UdDs8Z8ry/VU
         e8rXUFzkUGWUXrGlirLbMacjvHiwPv+K4YZ2+B5sehxeP357eJeKS3QyU1xkXA2dcXtP
         uc0A==
X-Gm-Message-State: AOJu0Yyt6pA7pXYIm4c/zSSWqQKhjLPQM0TJzp9TuiGt6XiMCF3Dyb4+
	vdPClvarrCz5+Il52EB3I09sD29qIMPxhFiaEyTUM/dSktCJPwSFkOL+wHFLVA==
X-Gm-Gg: ATEYQzyjMwkju7XxxFcFImzHlVfQI9R1//Fj2hleKHrhZ0S1Px5Lkj5SQj5OPd51Egf
	mIq3VDu6dj1Rp16v2PobZ+HlDfxWcglp8u2vSRUOX2YhVFq4bLtoOuiu4FRiSvYjXW36vn4/q7F
	LU/hrzz6u6+PdFrKKlIrTAh98uhCLMfcfRjbeLpFs+uCAI1TBlIbIzrUre8X7Vnhr2gtHoXz1J+
	g+WOnHmhNJ5eaFFerQC0gfUQyWfbZxoST9z60e33sZcsLUJIx9vRr4OT+GKZx0fPUvbTKdRER7y
	RkyhT5q8IEs/C247wwSLYBUwmn2/5GVfLKAL5uH78PbSosAMGtePqrxkjSZNDxHoCu0jx0TXRIA
	scd1CJ9RT+AxQSqbMpk2fknA+lX9GAOOv8FCQP3aIzKduxes66GvKJ8AFbKycHZ2iLuHj6XNZPt
	ZVAPwCYOFdM5NCnBwBUWduqdeq7O0Z7Q==
X-Received: by 2002:a05:7022:6085:b0:128:d2b3:5df with SMTP id a92af1059eb24-12ab291358dmr5236263c88.23.1774793471178;
        Sun, 29 Mar 2026 07:11:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.225.0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97d88c0sm6967546c88.5.2026.03.29.07.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 07:11:10 -0700 (PDT)
Message-ID: <69c932fe.050a0220.204240.c4b5@mx.google.com>
Date: Sun, 29 Mar 2026 07:11:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6851223762768986035=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v3] Bluetooth: hci_event: fix potential UAF in hci_le_remote_conn_param_req_evt
In-Reply-To: <17828eea9008f1b9e03c7e234fbf6be4ca9f8f91.1774787574.git.pav@iki.fi>
References: <17828eea9008f1b9e03c7e234fbf6be4ca9f8f91.1774787574.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6851223762768986035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074199

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.07 seconds
CheckAllWarning               PASS      28.14 seconds
CheckSparse                   PASS      27.19 seconds
BuildKernel32                 PASS      25.18 seconds
TestRunnerSetup               PASS      560.10 seconds
TestRunner_l2cap-tester       PASS      27.54 seconds
TestRunner_iso-tester         PASS      41.89 seconds
TestRunner_bnep-tester        PASS      6.20 seconds
TestRunner_mgmt-tester        FAIL      112.00 seconds
TestRunner_rfcomm-tester      PASS      9.32 seconds
TestRunner_sco-tester         FAIL      14.10 seconds
TestRunner_ioctl-tester       PASS      10.00 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.49 seconds
IncrementalBuild              PENDING   1.07 seconds

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
Total: 494, Passed: 485 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Adv. connectable & connected (central) - Success     Failed       0.131 seconds
Adv. non-connectable & connected (central) - Success Failed       0.117 seconds
Ext Adv. connectable & connected (central)           Failed       0.178 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.174 seconds
Read Exp Feature - Success                           Failed       0.102 seconds
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
Mesh - Send cancel - 1                               Timed out    1.873 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6851223762768986035==--
