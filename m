Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5533375B1
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606283; cv=none; b=m27DM6BJVzwS51Re7qQ8wDW/umlwOsIkC0r4rYDmyROYSe42QarTvEzxkbSLXLC0hJ7OYKDgce+9LEmBPPzGE4KBW0eu6PIN0rOx4zJFsphFwfkcoX70V2RqH8eH2a57ms9QzH/8Si5rZ9aZhbdKEa1Bwa9Xs0bLcjZxGtlKUBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606283; c=relaxed/simple;
	bh=ouUVX0ZFWGUWAhC9EVjWkiC/VojGNtLbVpBzAejr+X0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o9fCQzcGs1ttXj6NSwciyuuG/PSRI40eA4/8pAX0uteR2PzYOOAsxdbmAYb6sVSWNTPzQhBPiLTXJSsCMdafc00DUznuq6eq41U1z+2BXgavYlitWsMCd+HlvjSIvgMQvdOhqN3nXL0cjpgqrSp66NhyweMvnDuAYrnD4ptlzd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7IdOFmW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7IdOFmW"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso875580b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757606281; x=1758211081; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe1otkUpy0qc7Wn3EzbQv2iy6jxR/h2NJ//kI6/qqc4=;
        b=b7IdOFmWSv5zLFGb5ivsCmRsw5bpRgvJAzS8fqzp09aG/bnJMPh0NaLzNv3V6e4zdl
         fjOt1SuqWk5FTehwOcQUNdReXumFtxfToaFmYNhoKMZNt5Dx+j7HWPo06+ZVAwKQNEuu
         5cfjhbMCLn7HIoQov7Qd6Hiod9jDSAbvoz3EKIhiAqMnVqV0eUSbwpXZt21Z4LBXkaEs
         I1yg6cpqeRTmdFyePI+Dy8xT3JVrCkyKxwZ1vSbc7UzaxpQu9pMh4GzQRuRI5ZJEf2VM
         dBaUk/6oT1VU0mBAqOsTpl/Ocx4zCzMFT8+fQ4Y3vAcncy1kuiiayQJjdyZWJLeuwdoQ
         4y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606281; x=1758211081;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qe1otkUpy0qc7Wn3EzbQv2iy6jxR/h2NJ//kI6/qqc4=;
        b=BlQb8JUSJQaS7unjyvTnLW9+o7HJuS/gulQDKqjgiw5qGg5mGoHkgJ208mUY/9RABl
         SwPfrKkHlhlleTZm6xdfKGjKA02lYFUImncsB4OB/G1+1X83H9TBGibLkm5O0MmMGZZD
         /R1TKoJQ9XMKfShMhYCjjhXnPBLznVZwA5FaIWgDl2xO1e0K+JNxHuGJbjz6525JStms
         tt2UQ0cZTAHTp1o5Kpm9vF6HIajxB3qaiK6dQfvYhFF+uZwdLLmVuK0j2AmUvszG4QTe
         ghQqPmMuwWx/lFI+/nD7bK0BJ02Na0RuRR7x8QILlZ5Qio5ibMjVLjqm3via2+gHFJJd
         Hvew==
X-Gm-Message-State: AOJu0YwGRrlKcE8qgVWkakRfzAwi286wc8FoJ/in2nlWFxQbg7mhIJSt
	GtAIJCwvgYg4YHXCqGEwYCRq0uB5RtS5GhUFwQCh+ZLoXADnYG5AZe6uMb147A==
X-Gm-Gg: ASbGncsIASbfzHT+O0OqX/yawNYKAJIAjmPydjFdeLi7xTd89T42MEiSxv4y2aeUk1L
	0Nd8PKr63fMi92YsqpnqUyAoe+o0JJ6DNP7sr6VF2ikvxnJ2YoSzb4OyzDqs1Pp4MudbaisWIZe
	INsuBf+YdCuSknIpMEtc9qv+XY366gzj79ymEmco39rOlwSgHYf/dBLYN2ru2lrMQxEJY3uLJl5
	G3BmNcd1nyrkt+vW+Pmuz0G4sjAN4mHYMXlI1misfLPNzqtc7YB+20y4zdozpeSK1bzAggkNwxi
	tkQDago/G/ZG73SWSzkUdT6y7VtRfSEc1WHszS0v1BfyhOZAuZL2rjJ8AOpHsk1tOaaKHtdu8cG
	xgLJyMlLXI7HmI4vkTd3BOiGLKOGoA3o=
X-Google-Smtp-Source: AGHT+IGTuRYWAjbvwr+KWZL28pOWGoUxC8ae1Te4DI3851LyHBCDlC0Rc6bglc8J97bpDDuTyam5DQ==
X-Received: by 2002:a17:902:ef4f:b0:24c:b3b5:303e with SMTP id d9443c01a7336-25170393d6fmr247919835ad.25.1757606280663;
        Thu, 11 Sep 2025 08:58:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.210.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc6aafsm22974215ad.18.2025.09.11.08.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 08:58:00 -0700 (PDT)
Message-ID: <68c2f188.170a0220.1fa238.8572@mx.google.com>
Date: Thu, 11 Sep 2025 08:58:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8576047378688648935=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ariel.dalessandro@collabora.com
Subject: RE: MediaTek dt-bindings sanitization (MT8173)
In-Reply-To: <20250911151001.108744-2-ariel.dalessandro@collabora.com>
References: <20250911151001.108744-2-ariel.dalessandro@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8576047378688648935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1001418

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.44 seconds
SubjectPrefix                 FAIL      1.05 seconds
BuildKernel                   PASS      24.06 seconds
CheckAllWarning               PASS      26.81 seconds
CheckSparse                   PASS      30.98 seconds
BuildKernel32                 PASS      24.36 seconds
TestRunnerSetup               PASS      486.70 seconds
TestRunner_l2cap-tester       PASS      25.24 seconds
TestRunner_iso-tester         PASS      37.28 seconds
TestRunner_bnep-tester        PASS      6.09 seconds
TestRunner_mgmt-tester        FAIL      132.27 seconds
TestRunner_rfcomm-tester      PASS      9.45 seconds
TestRunner_sco-tester         PASS      14.85 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        FAIL      11.87 seconds
TestRunner_smp-tester         PASS      8.65 seconds
TestRunner_userchan-tester    PASS      6.28 seconds
IncrementalBuild              PENDING   0.73 seconds

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
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.112 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.057 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8576047378688648935==--
