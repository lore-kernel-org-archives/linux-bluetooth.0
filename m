Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9A42065
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Jun 2025 05:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749877456; cv=none; b=I6IeAcda4SxQNzQ3B9LXmFSYEPvKYHwzsSQkppLfRSl4v/pMediv2wDFcUCzMUd5Sx7m08OVog1rfEXvay3iZ8+R0phfNHacK3rabMFnGg7CqGPeJQTMT7EGxAU1cbuw6Vl0NyGQVBOVA5sAaCGAdsW4W9Bth8rO3DBX+N6fVr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749877456; c=relaxed/simple;
	bh=qH9yyyeclYvezRW7atf4eWEtSkxcCl/WD1GH2ljB2WQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cHtr/pgBja4WVmTdD2Glnq6FJMdxaimDSErGp0A7ughaWBPT0+oipIGV96p0PkKniYTHQ40jJOFSYsrx+jQy8QyLVdwsUYHDdKVrLAe12p7VbAAW91x3dPyr0cs9zit3qIVxV0ScRMAXyYiBsEGg5K1FBhnIy5hgcqk5K68EWpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ8Cw5e6; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ8Cw5e6"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fa980d05a8so26325926d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 22:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749877454; x=1750482254; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mMfoejeGHGfi2fbKTaE2OQnv/tbcDL2/92zejU4ID2c=;
        b=YQ8Cw5e6yrzPdEL7qcEzqszPEAziOy3hnAUz1hxj7pXNRQi+1m4nsLgXuZlS0yQkVM
         5ZpvU6rkVZDIKjwLBgsebs/JOAvlAJpA1pO62DcMPIEWBJZDXbG9eyraqCqjdmiAagzQ
         i3NsDj1JXbcrogNl+TiU7JdRa/XSdj0n5wku/vRWuLJgh1jSROKgvzwUZJliZh6x4I5j
         q9+2LlXpFHHI6Pi/MbYPnNFI6p+uI7D2cQSBrHDlIdC3ZTgSCW0BgmMY0t9HgbgB6oiN
         /lU+F2VW0DLYr01oFjSFYrzFZ0EVQ+CcOtm+88X096YuFSPHYStxEXyzqFlfd5BG5rSQ
         87/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749877454; x=1750482254;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMfoejeGHGfi2fbKTaE2OQnv/tbcDL2/92zejU4ID2c=;
        b=L2SkbW+lUgQdkeVEH3cvGcpuMes2PqNiEBkzniUaCJixIiu2uYvofm8kVzZ67TiDev
         F1Ct+T7YRk052Wtm1lbjgvy2fRGA5+n/WLxm6Tplp1wgL/uFiTXnGYPd9IVlpALxrFQ/
         4wdCFar9s/z8TSYramDhU/9hLyANaytbhYReQZD6MPokf3sJ+Btql2ryva1yeHXaawAI
         MjVQq3iWJgh6yjmwwXNOaOzI96T7+RFyNMH6IuK0SY2SfuoXF5m8MlwpZTridUykgUsn
         DbsA/FK8t1BUa+h5xWVs1ngUpeQlJZq1nZ/M1uooPdqqnBZfpVBJT7MssdkuNnzxs/95
         l1rg==
X-Gm-Message-State: AOJu0YyJOGEe+xNHwAGMRYptCizQBqCUgpFUICOHkvuda/LOkb7dJC9H
	4BmwODqmnF49NvmCT/9vQQrA7MSgJjXZYzU8eFMnfHgjN81YbuSG1L22/9Fqug==
X-Gm-Gg: ASbGnctb7ArkH4GIgArI0q+nuDVL6omQl4oOIRVnsuZELqGOTwGP5qJfQjKsC7w5jTN
	IpJdHCze5148QEukEYr71Fs7y0RwsgApHR0qQu1tUIYBvdkm6Bl8OL02LrMthC4CXE1ihMxbbMx
	5MDL/2d2tYb/ObEncl1w3FeVprg3b1Q7M+63fkAzqqA9+sf8GUxKNQMt0NskcOhiMTt1/36vilc
	G3LsRIv5jG0ogAR3J9v+jWJJ0wipKXfE0Fro5kEyojtDTMwnzV85sX5gWno/Mh+aBCQ8+ZtV0/3
	sq3cp8tAQy1cKqrWd2qNRdiImG0JtlDMYOo0rF87NgeyvKTgajJ/waQnRIq85s9dRmAY
X-Google-Smtp-Source: AGHT+IGjS4qrCTbEfqhQMs4yGmD/TAHCHlvp1ZQ92C86yi70xdSZPIlBpbq76iaadXxB+wCH4qaZ0g==
X-Received: by 2002:a05:6214:19c9:b0:6f2:c88a:50b2 with SMTP id 6a1803df08f44-6fb47629a5amr30049216d6.3.1749877453741;
        Fri, 13 Jun 2025 22:04:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.77.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c316e7sm28756896d6.60.2025.06.13.22.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 22:04:13 -0700 (PDT)
Message-ID: <684d02cd.050a0220.3bda0f.c019@mx.google.com>
Date: Fri, 13 Jun 2025 22:04:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3324883119885206123=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ipravdin.official@gmail.com
Subject: RE: HCI: coredump: Use tmp buffer with dev_coredumpv
In-Reply-To: <20250614041910.219584-1-ipravdin.official@gmail.com>
References: <20250614041910.219584-1-ipravdin.official@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3324883119885206123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=972075

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 FAIL      0.35 seconds
BuildKernel                   PASS      24.96 seconds
CheckAllWarning               PASS      27.07 seconds
CheckSparse                   PASS      30.18 seconds
BuildKernel32                 PASS      24.56 seconds
TestRunnerSetup               PASS      460.60 seconds
TestRunner_l2cap-tester       PASS      24.99 seconds
TestRunner_iso-tester         FAIL      7.88 seconds
TestRunner_bnep-tester        PASS      5.82 seconds
TestRunner_mgmt-tester        FAIL      136.75 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         PASS      14.61 seconds
TestRunner_ioctl-tester       PASS      9.95 seconds
TestRunner_mesh-tester        PASS      7.18 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      6.06 seconds
IncrementalBuild              PENDING   0.56 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.196 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.190 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3324883119885206123==--
