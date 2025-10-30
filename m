Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E913027B357
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834959; cv=none; b=B/MAcjkkkeT5WO31NPyEkHy4OrkUzP76hZCVhtiTEAchj6YErqnVhg8TLrroAkWcTLCKYw5V7BZOhrAHjvYhpHfqxzZbXCmpBmYH3VP5ku+HBaJE9JmpkaOZ0dxvKmwWZfvFpdeXHbnqWrPpbg7eCuKD7laWaW093TVgf+oIKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834959; c=relaxed/simple;
	bh=mgawtdgGhApLTercwO8pMhj4TIgxWSohTuhWkEzi+kg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=geLfKBecpvF8dZVknAIjKhbFIELMxUaARmoJWLFl3hpZvn7BC6JxQig40mDLZep2tUCkIgkIvbDeqXH/ogF6WpFyZdjEHjmljHUE5Xm6w1NU7Vmz3ZRa7f/mtBUPLD3FUP/66s2rUBOXYFTSxhyJcoeHv24rDFaGNuVgCbHcdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0lkNFAO; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0lkNFAO"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-93ba2eb817aso109817439f.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761834957; x=1762439757; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L8DVpynUiHBy4t+uA4UAuy8qz8KVAc0+WnCVtuZomCs=;
        b=c0lkNFAO4GhEVH2Mon10vuanrLLqfu/AUeeyxuvVqJFj0wnLT0UqMazr+LHxIrIpCp
         SAT4czn8kS98w8TNSr0v5Ag2e8gpfvtncxayStSKp9GR+6UW4hHckoF+7agYWfj2D0r6
         dOz8XgGiC5iMmYtpC8UYLhqXm5yyyZyA5Th/PC6Ox2PIfU7mxFOFO+GDdPk8rA8DmnUV
         QUSeVNLIM4QEtkYh80LfuyVeTFzSIyuzcrSS4MamrZs86Ur3c0RjSWzXJN4T0CRDKccg
         VYJoyNGzvNQvs7ePNyw1+5SeP6NGoZASxbhAHclfHWDmqE5/HYuPTUUia1xrjIQoL6zN
         Bcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761834957; x=1762439757;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8DVpynUiHBy4t+uA4UAuy8qz8KVAc0+WnCVtuZomCs=;
        b=hWqu6ccjpv83BsmmhRPu8mVXEyPqQdslZ8hiUyi28jxmGtflAQq1l0iwHdytmudTSf
         zenGFsllkXieQLOQ08T12uJTZxk+J0SmmkHJf31AUT6ASQMdyif+Inqj+h5JFbPFqUXi
         pBFGppXU0e01izuRhPWpJAUR/VT9f4TkFAYeGJV2XPHYclXZFC28yFGduwvlPNc80KWl
         t+jEPwi5YO+9blYjnIN6MAujthd0g87jBIwpW1jNFrdSI0stQ5g3VOw0FU2ecpKyUCVu
         7txzgupQTMRjd2Zv6wY6RhwIL7pml+gRbE8lCU9KUAdycWpq43SRUoU+m9Bj+RaotqOW
         bTnQ==
X-Gm-Message-State: AOJu0YzdIq+pR0+d+fmXsUz7t9DGVJs1k7/Wern9HxV+Bfqj49f9uh/C
	lvk94AZbvvuAGsqnIyyphnvqs+UecC+XGDH+200AzWCpojtTlS3hDLEVSw2J2A==
X-Gm-Gg: ASbGnct7MZ9Yn9LQC/bPYwbvfcVv9BOA7xfbqx1uNW1rA3+eVYcCNjTdErjOXZG8j2D
	8hfgK4DSupjd4PB0CtETBa6OMCuRVr+/V1Tw9m2zbnyloabS//NPoIt4iSaA5HiFQ21RmXv0CVg
	6PRUQk24QTKOVr3nAkSmiiEhdTXJKf8bCfqX0w4G7Xvspq8WJUFM79Jgk92ts7PepcXUHugVK5u
	urSE9wlxmK0z4f2Irzueu6kETOBG7CTHJnXLE8uUGG2urqn5Ydj4sI9lmM0aHOuvmv0UC2cIWei
	ME3Vh5fhqxS/EeQuM4UiCXoc3v7X22wo9V+FwUq3c44rEu4rJKfOhwsIJs8bfim579Coa/+bGR7
	QJTp+ZvBnWfmhrpD39XKmizykwzksshguQZKBVqxHzG1HtjpJmT7akVcg6t7ud5R7TT5JPzK3S5
	o/FrwSMBpm
X-Google-Smtp-Source: AGHT+IHVeTLEDQhRPAPNrOAqPSIk8O/BJCU2L28eiS92zyYo34vCG0W2m31G7n8zSV1BmKxSH92lzA==
X-Received: by 2002:a05:6e02:1886:b0:430:e9e7:8660 with SMTP id e9e14a558f8ab-432f8f870fcmr87100775ab.5.1761834956628;
        Thu, 30 Oct 2025 07:35:56 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.177.196])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea995d412sm6762047173.46.2025.10.30.07.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:35:56 -0700 (PDT)
Message-ID: <690377cc.050a0220.3b08f.b78c@mx.google.com>
Date: Thu, 30 Oct 2025 07:35:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1574502208208882226=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mahesh.talewad@nxp.com
Subject: RE: Enhanced or Legacy Accept Synchronous Connection Request command'
In-Reply-To: <20251030134856.2726882-2-mahesh.talewad@nxp.com>
References: <20251030134856.2726882-2-mahesh.talewad@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1574502208208882226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1017750

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 FAIL      0.37 seconds
BuildKernel                   PASS      25.87 seconds
CheckAllWarning               PASS      28.87 seconds
CheckSparse                   WARNING   32.58 seconds
BuildKernel32                 PASS      25.58 seconds
TestRunnerSetup               PASS      513.18 seconds
TestRunner_l2cap-tester       PASS      24.58 seconds
TestRunner_iso-tester         FAIL      46.16 seconds
TestRunner_bnep-tester        PASS      9.27 seconds
TestRunner_mgmt-tester        FAIL      124.58 seconds
TestRunner_rfcomm-tester      PASS      9.43 seconds
TestRunner_sco-tester         PASS      14.56 seconds
TestRunner_ioctl-tester       PASS      10.24 seconds
TestRunner_mesh-tester        FAIL      11.69 seconds
TestRunner_smp-tester         PASS      8.77 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.57 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:153:35: warning: array of flexible structures
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
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.184 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.926 seconds
Mesh - Send cancel - 2                               Timed out    2.001 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1574502208208882226==--
