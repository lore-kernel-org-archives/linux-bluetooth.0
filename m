Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828F12116E0
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854912; cv=none; b=NTHXKD8Dk2uI6nzdW1mzC9F4r3Fd7xExcUQSB4Yh+ZM2VIkVyyVqTR2JtPiKghlOXB0CJBQPbFIH3R6VHMqhq6phUR0iCCdcK0qc/lJxH3RhqxC69+XTKIQ+eNQZpZTRKixo9DFX2e5OFqGMqK6awrWyEA0Zz7xOrkxkEpWpGzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854912; c=relaxed/simple;
	bh=G0MfZmPh4/HK3NdCy59GgxTStVF7rV+NTOSdpBYipYc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Vu5J/hDmA19EnC8BWHhs6VNuRSZ8Bs2KIQFDbzi04bpOJ7UIg65ldDs1+KdLn0Wm0B5YxhBUVdL+1eHC7glYV63jDohfyhJ/SiPcPD2srfkoLb3oEDKq9tQNtBQq12WvPaAARlTiUqF7dTOo98dD3Ok+xKtxvHgXcN50rrIKxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blQuwPai; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blQuwPai"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b04fcfc0daso2519745eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jan 2026 22:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767854909; x=1768459709; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BwUNg3gwUi3GyzizQgBTES1tnOn4lW97I4kfes/dKyw=;
        b=blQuwPaii4dswIEaadfVIwbX8z6zUgfKuPyCTUmHlf5HzLa4kFfL3pwc2MkbjJ8921
         +SXzRZ9ZvBDKib1cYvJReW4L4JJ7jSIp76tlny4X03MraoETwDnPsiCtFC4uVcO1dGKM
         e9obVWdgnqV8pdnadR/XwJMICZpOut/QKaLLeetGsvFwOxYK4WP/L3b4Y1UX8zuWDvHI
         kme1jv8XKUPAwu5ZGHiQThLJ1jkvFv64n/FMSatISOEAQWfU+awTM4fPbhsnnYHChyFk
         houebDogH4HN0T7zlWA6O21p39Uk7oHob0I0eIOGVQHaBlhrQ6GU15EaAIJXanKW7b26
         Q8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767854909; x=1768459709;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwUNg3gwUi3GyzizQgBTES1tnOn4lW97I4kfes/dKyw=;
        b=N4moUv0hee0F3vyHV+J6IqMS3WMDpCYBcD8ZAX77+X2usiTSvBWgeBQ3LsDycTAm67
         U41mId4AIjsHMpRfQ49aGV1LNpqUcTfbxhHVVrxBMgfCj940bPDw708ETB1K8e4kRJa+
         vACU1Ic5mYf9zrEKp4FO3QsJ30H+1hBdJAGiic1m+33y9z7iQq2ZbWMDIqccQVZRrFuv
         v4nJ6t1LwFzTeSfuY9giCiVzlo7+KlNmWu22kEtr1w0RsQ4gAmInI1sw7opJuZ0a6Ujb
         0ziB2xCzI7I1q/uHFQNZZsMfUa0op3RoD+lX0r7o5hjoTv0BsfaG7lk3IMQoz7FEYlyN
         wsHg==
X-Gm-Message-State: AOJu0YzfIVdofBssp4RWq7cQfRDwVkEaPGqwo3BgQq4/bkyB4qtmO7Oa
	lfxJ5tBVNfC8ZiIlnjgxkD/lD1gHT+E1ASHaIKW+m6ZBp3UIEoBLkzWVrw+mMOpM
X-Gm-Gg: AY/fxX7jOVbsoB711sp0c7IgNxKHLzaaK6sCA0dM+8FLE+FqXYe9PSBn8Q+tXR2EnPC
	b36HQDgeWjtbZtuOjvWZfbXQKXt8M9aYannn5Sa5PtXZ8eZH99/w+KAvGPdNk0Zrmh20NzgnoPs
	9Lm8xViCWIKQM+M3yfDom/k4O9HB+AHUjG5fYipRvR6JDV0czGgumIAoyOw4+Gu/NXB8CIjqoC9
	2+KqjlMe6few2QTzNI5Amyrv5gXEGfQe73+wI2kKr9L0L7EtH8QeGp76RYQErUhJ1s836CCu0RM
	5BkB6TlsawRGw5OfbZHEPB0xXH9Tzbom9fUp/HflY2jqFWX8+w4g6f+KAIrJ105ZUibXJ1OvsJg
	mv5WEfaC5ujTnSEXuVi/TywtHPOHBDETslOPxIKKsC7/NMsp+4Dpk33/WFNKIrtEU+ggesaCR6L
	MOuQZ6PP9oIvh9CT8pBD4=
X-Google-Smtp-Source: AGHT+IGrfK/8c4H9s+/kMKrHR5XvJrzPc7xvW9r0NTKiNnvYruw/6sgi4MV0tBbEYhjv+CPaoy175g==
X-Received: by 2002:a05:7300:220e:b0:2ae:5a13:9e3a with SMTP id 5a478bee46e88-2b17d34441emr4022374eec.40.1767854909208;
        Wed, 07 Jan 2026 22:48:29 -0800 (PST)
Received: from [172.17.0.2] ([172.184.211.166])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078cddasm8256189eec.22.2026.01.07.22.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 22:48:28 -0800 (PST)
Message-ID: <695f533c.050a0220.1b192.7fb0@mx.google.com>
Date: Wed, 07 Jan 2026 22:48:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1832198167998703263=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: Bluetooth: hci_sync: use HCI_CMD_TIMEOUT for PA sync commands
In-Reply-To: <20260108-pa_sync_cmd_timeout-v1-1-cd35538a9e12@amlogic.com>
References: <20260108-pa_sync_cmd_timeout-v1-1-cd35538a9e12@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1832198167998703263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1039696

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.24 seconds
CheckAllWarning               PASS      28.65 seconds
CheckSparse                   PASS      32.23 seconds
BuildKernel32                 PASS      25.81 seconds
TestRunnerSetup               PASS      558.09 seconds
TestRunner_l2cap-tester       FAIL      28.40 seconds
TestRunner_iso-tester         PASS      57.14 seconds
TestRunner_bnep-tester        PASS      6.28 seconds
TestRunner_mgmt-tester        FAIL      124.49 seconds
TestRunner_rfcomm-tester      PASS      9.56 seconds
TestRunner_sco-tester         FAIL      14.93 seconds
TestRunner_ioctl-tester       PASS      10.08 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.50 seconds
TestRunner_userchan-tester    PASS      6.68 seconds
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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 94 (97.9%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.120 seconds
L2CAP LE Client - Set PHY Coded                      Failed       0.156 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.110 seconds
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
Mesh - Send cancel - 1                               Timed out    1.903 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1832198167998703263==--
