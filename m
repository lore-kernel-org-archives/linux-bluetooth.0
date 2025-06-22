Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB12772622
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Jun 2025 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750577655; cv=none; b=vEf841EPHrw5hrBXokkj6gZ8HgqxNgwJuUtx/l34YTx38AehwxVRqCfRhgWnFl7hIap31btUvO58eC3a4vEf3uT1+J6eMPVP/2Zkdlzzhh4xDUZZXOO7OrgNvYqdPAyOTOw1tCE/5G1w6sPoXhHrhzG3lXrJLOWrV33KTYswodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750577655; c=relaxed/simple;
	bh=LVI1kZVQLDeGB8zGht5dCPVGOfz8A1a4Ml7286HOvDs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RcDKpRb8xCqlchYu4hKrg55NQavtqdKGQ0na+eKhV+F4zTOZDEk9aQy/ki3r6XXa+ZeWpD/KIihM6NU4MNz4H18x/TkwCuusJFb061DvgSZTwK9QF28N9OY9/tJLKKpiz7zmq+lSn/+bzWtSJxUoiavYlPD+U8nhnDjX5Np4vm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFMcnwjH; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFMcnwjH"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b31f0ef5f7aso1460034a12.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Jun 2025 00:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750577653; x=1751182453; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OKy5yW8AUBu5M72FMVB5tGGqeeEXEPEZNG0WUlxqssQ=;
        b=gFMcnwjHU5LbiREeKLadV4y771rWY/GVgz7CElUF0vtUVXjA9teOUdqUEqdFbV4dXw
         wZkrO6jAz4DBMSJJSFYDHEuvzGV2Fgb+HqaIMzjMpKMxoq3FtSL/pwkxdZNxm6YlBZFp
         vO6L8TJDZGoLq8Eemu3LQyOgxJtCHGJGUNpACQhwsxH24RaLJk5qmP7gB0Y93MAEJ00X
         Rk2ltTy6t/u4tjK/QKilrLM3bmT2Ku/BKf1wqoKSEeTPnjT2SrH4GmWa3N6vvU55qevF
         hs6sRQHnEYGOAGfIC5OeQZ3HmR7HoMFn0EHtt/wDFDXrXsOS3unxiuefI1s6obLQdJkK
         w6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750577653; x=1751182453;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKy5yW8AUBu5M72FMVB5tGGqeeEXEPEZNG0WUlxqssQ=;
        b=fwU1TNix8/QSdwYIQ5fYrwUDPDMytB7F//m9K6r+ZFd63hecWw3Ef9ujkgEIEtVC0e
         xQ/jJ4pThHDho3LTmlZj6IsqKJkaZUbh9KD51HV2cE2Qv/Ao8cbgifNZfvBdVfLm0lod
         yImB89EKc7FLhBI0OpOtKcbQM4TZHOSPuvw49XEM9A1PN/kVRPEeNTt5ZOXUuBcf7S1s
         biRhQv/HZrSt9eyEkdewm5KyTTEV3tVbxlIUfgZw2jfTqtzuTfwJislDxdzqsK3PtViD
         FlyFhGVEKBhdbc0Y8TPu6Uv/8G719qtufCpiH9GHYbTCe1hfSplANdSfDkOhq0TPR1XU
         VvAA==
X-Gm-Message-State: AOJu0Yzw4FKSh1wa/GfE5B77bSqyb//L+mq5T47js6doB+pd1Qjjqboq
	BfmYXaYuHDYldejRVxlSt0Y6BfzmCmmetvkm7ja7nX2f7n/SXhY/bra9ZuclBw==
X-Gm-Gg: ASbGncuJHRf11JMXpIQgUwjUscq+38k/90v6p2AJAXSevV99t4KSBort4gcd3XwW0n9
	x/yNE26TLYjcv4cBRw0n9c1oMM7tpSd0su8o3TG2FBngTvlFWY//HUol4AoXqFpBNyKOzjAmHJ/
	0jwEMxQ4dj7OJb+LZNE6nT4ygEyQkeFiZ0QeScPHizUzB1fYQoH+HfaOViLBIGgGvvOEVraYkfG
	PazW9ZlZRUShTJcb1s5ckTupbnE29v9y2CIbsdXezhyB2fKA6L1cFkYuItVnOrOgzHPF7GOYjhe
	MG/QXlax3vOvKS5q3ymrzILPe6FjYkLxh9HBmq2c4I3/PyDY9wz6upxLe9D2kCUTFQ==
X-Google-Smtp-Source: AGHT+IGQSq+ksK3NVVLFZrPnqleB1jDj2nwTxwX4PBV/R45teDMpIcSHGmJlWiWnYUoltWD7EYnHIg==
X-Received: by 2002:a17:90b:2e87:b0:313:1769:eb49 with SMTP id 98e67ed59e1d1-3159d63cf11mr14230213a91.8.1750577652717;
        Sun, 22 Jun 2025 00:34:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.7.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a318749sm7745533a91.39.2025.06.22.00.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 00:34:12 -0700 (PDT)
Message-ID: <6857b1f4.170a0220.209d4f.f4e4@mx.google.com>
Date: Sun, 22 Jun 2025 00:34:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6928178385070157155=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, linuxsumedh@gmail.com
Subject: RE: btusb.c: Add pr_info() for logging purposes
In-Reply-To: <20250622070951.56291-1-linuxsumedh@gmail.com>
References: <20250622070951.56291-1-linuxsumedh@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6928178385070157155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974574

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 FAIL      0.35 seconds
BuildKernel                   PASS      24.31 seconds
CheckAllWarning               PASS      26.57 seconds
CheckSparse                   PASS      29.79 seconds
BuildKernel32                 PASS      23.78 seconds
TestRunnerSetup               PASS      468.74 seconds
TestRunner_l2cap-tester       PASS      25.28 seconds
TestRunner_iso-tester         PASS      40.00 seconds
TestRunner_bnep-tester        PASS      5.91 seconds
TestRunner_mgmt-tester        FAIL      131.58 seconds
TestRunner_rfcomm-tester      PASS      9.26 seconds
TestRunner_sco-tester         PASS      14.70 seconds
TestRunner_ioctl-tester       PASS      9.92 seconds
TestRunner_mesh-tester        PASS      7.32 seconds
TestRunner_smp-tester         PASS      8.50 seconds
TestRunner_userchan-tester    PASS      6.19 seconds
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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.213 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.171 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6928178385070157155==--
