Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2393A5444
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Apr 2026 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775296471; cv=none; b=fG8aZHA+S3CuDC9i01nTaSQIg1Oif7NdTD+PgrlZSjlTerWoqmDXU8RwBdRiIZc++kX2UVYGOO7dCe6BaxAaypeKn/X8qDaL7AkYBNQVg4U2tG7qXTwGKR120hV8Yg0ZqOsBOPKHU+gmidPdd7xF4EZyejtmsNrL2nC0lDu6LW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775296471; c=relaxed/simple;
	bh=piUtKQNla3bhWk5nQBRksKdi0PvSIRfCOOdpbuH6Kio=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nLuiyT7tsdieU4mCS75AgN/PqTu/yYunKW0uxyC7WNsQC0wDLAIr9xly9G6cPidKT6KrzgEfdwPsDJZTtdusn1d1PXioXBnXRcxmp0ekWm/oAcb0Ss0r/9lToklK5RIMHzUmQoY29qagEKaJIxGgRaUZW7jet0nPUvTPOPZ9r4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAMEftj6; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAMEftj6"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a032383008so35276706d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Apr 2026 02:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775296468; x=1775901268; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G9mdDIZRClPO9b7aM02+HBON4AGDxm7f466Q/UZfF6M=;
        b=EAMEftj6twjgVyZ0+kuAsXbFs8T4srsNOg/wXMYAnmKu8U+Kn8c1DvC0tnWar8RuAx
         3u9AgL1GsOd3Xf1geMhq/vEipxzkPevSfmvFssGlUVDPQrCbulcpVBgRZ86bqIGS4itl
         Y4zEX2ylsli0AFP8RV2jwD+cJ4qVB4fEAMtsIqGzRKdjIosWggDKfZ0KG6TJJKB07SdH
         +V+zJeULAQmidyVqcBE5c+us3wmi5OME9tmLT09HyI8XUAdXum9aeO1aMKy8zttzg9rR
         8N2+TTGRUC7myRpwmK1I/WdHAWjWs/RUDNAFrrLAUi+1UEuGQupz7TZWOBvoy9y6BYmf
         XFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775296468; x=1775901268;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9mdDIZRClPO9b7aM02+HBON4AGDxm7f466Q/UZfF6M=;
        b=A/pLGOUDhdG5NK5VSHZ/rL9357xiFMx6BHhm0JOIF2qCFzYvgcsl/xKVqMFPfCtJyt
         mC5+QuZofq1dw0kRpTAXgpSbqtO5DQkzfFsKviMnY0NxmAnyPAjYkp0dV3wXn0bQyf79
         r69f6tsoa7X7mUgy6zoFNMhgOjgwr001eFtKINbeaK4bvcezeTkCYyEdSyV79UzNaSFP
         0ivcSGUO4fttMdaKxrGPUjgGgGVrz+svE0cldp8qmxOdM5YSpQE44oXIE2IG72h3zB8i
         XxQNFAfTFhAbJvgx/HH15e5h8IA+UWgMtFK0xlQFoKZD9OLmsCJ8iGEdGp3eEq6jrn2p
         1vew==
X-Gm-Message-State: AOJu0Yym4y7B+A2p9nfbx4lh2Pb93S1w1sgzUaSMovymEV/0dE2yGDL3
	3vexNtuG4/WqPbPv9awcrT0nE98cEi/EvC+iQgKb/6sHp9y5tiZ9QIiHldCkrg==
X-Gm-Gg: AeBDiesFvV791DGGbL8/ahy0gzw9yUxxZ+oXjf6ET5E0g3ROZRNahcAjGmlFTfweP1l
	rrDRKTbEMOUWSceTTTh0fYB5Ck35Hte4bBD6U+JKvw6B7L0tGjJwrq2tCA14DyhMNiXrCm2ao6C
	7scdu6rXQED6zLAifrKrpc+RFbl8H0Sm3ExdKpawVgSbrM034VKpZcNtcZdKYjSvelJUDL83rfh
	jvyPp6hd+dVQ4880MpnZASD4w/5azeoaf36yYw4cLR3gDWga/J3niI5Oq2vcRXWTY8dSelYZeJ5
	dXKBtLvv9q1Oytf+drwl4G2fHTEVJQAQJ2GPsx/+AZisaVA2OYFbDKW05DCQKFslrpcPsjAlRZ+
	9l7ikx7CHebXV1qOFaNuy/mf/ZF4/5b8qTYWEIxyY+OLCqIVfkAmLDgcIe4olxTAyhm36MAAXOh
	psnJ68GBQatue2eXi3I9v1auoU54N6ilJg96g4tT+5wg==
X-Received: by 2002:a05:6214:4586:b0:89c:e5f0:8f26 with SMTP id 6a1803df08f44-8a7021c49cemr104100336d6.8.1775296468405;
        Sat, 04 Apr 2026 02:54:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.127.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5976e223dsm81013856d6.45.2026.04.04.02.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 02:54:27 -0700 (PDT)
Message-ID: <69d0dfd3.d40a0220.120df5.26ec@mx.google.com>
Date: Sat, 04 Apr 2026 02:54:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5837830770641741750=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: RE: Bluetooth: BNEP: validate control header bytes before reading them
In-Reply-To: <20260404101002.2-bnep-pengpeng@iscas.ac.cn>
References: <20260404101002.2-bnep-pengpeng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5837830770641741750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077246

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.39 seconds
CheckAllWarning               PASS      28.88 seconds
CheckSparse                   PASS      27.39 seconds
BuildKernel32                 PASS      25.34 seconds
TestRunnerSetup               PASS      574.28 seconds
TestRunner_l2cap-tester       PASS      27.80 seconds
TestRunner_iso-tester         PASS      38.08 seconds
TestRunner_bnep-tester        PASS      6.46 seconds
TestRunner_mgmt-tester        FAIL      114.80 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         FAIL      14.21 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        FAIL      12.42 seconds
TestRunner_smp-tester         PASS      8.93 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
IncrementalBuild              PENDING   0.40 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    2.784 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5837830770641741750==--
