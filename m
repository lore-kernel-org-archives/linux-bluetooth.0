Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF23C2E2DC1
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761994812; cv=none; b=D5BXMS16Kak/7FiKyOnp+NvLIZXm1H+GcNqlxeJo6AD3g+dKZMKFzJjeUCfZkCfVmHJmm6Q/ks48JIurx/o7fdYbP+LxBWVEf6eXqWSr/7dCH1vxUlVeOCJH0ve5toajxyBJaHZ78Jj/CcscGWPhCsG2EOqiYZeyWAGX7/vtpTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761994812; c=relaxed/simple;
	bh=mMJkuHVpsAsItlbpLj1eXDfB2/MTx2V4sGbVglaJr/g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LWGgYE7Kx1m0Mhdg0Z8b9mCKH3e3gfaHBXqtQM2/UtjGrO0nrzPDQZsOfwtLRHifhZc0/5MyDliUPnayr/EthGBI7Pg1PUc5tTAb99wLky2bXg4wxcnoOTTkVJ+671bUi/MGknV8H99uQ27liTBvBFdaxuYs2+lHI71AaZqOS6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeH2EZ7v; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeH2EZ7v"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed3d00c359so12956061cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Nov 2025 04:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761994809; x=1762599609; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pMvxuLFa+UO1X8GpjTAaz6Gk9yaVSUao5O3TDjsWnro=;
        b=jeH2EZ7vJgsRIhrDjqYKLyLvsu3QQXbc7PVojm4D8rsr2eZB52REst/uYqSdW6k272
         gHr9xx2yvix9OWP7Yg2eoz0cAG3bKrt4VBRWYB5HU+8ARpyHftUFyQ3AyJVtoB5u0k50
         HZPNQB7GeKFMtIWblz473z2ch2KmLQRYoK3+nIaqL4rKqwNUKrfv2JGWckYaZ8NWZPQT
         T9lKS6lh3nZpV5tx3sE+BtLsSu94m9Ss1anngb5LKYHjhprm40Qu77cocw0pRbDH9O3d
         M10mG6i8RTIF1t5M/3mhxY5kL+0NPTvo80DxI0jI0oBoPrJ3OIVg5wrMMHoGs16U9hWv
         X9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761994809; x=1762599609;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMvxuLFa+UO1X8GpjTAaz6Gk9yaVSUao5O3TDjsWnro=;
        b=LIckuhReS7TOEEoYqCHLV8IEWz1H96PFJBXlY88amNenJ84QfWiVoHM5kfo48NWdF2
         qZu/fW8jJ6Hr1KKoVA2+g+Yo5dNynp8/KysXJF4VkpT+5/3u1QjfMSVYjftsHv4hXSMz
         7rtitvWrqDLzvwue1pbDfvtheXlOXk7VTi03T0TNkVP3klMCwNQ4T2npZeKw/8kYz1Ji
         9wCxCjk7UxtHT3GUwrohTT4cAQfvHYGPpfd72AzvSPFD81r7oaBpyKf1rPbGhGR6OmWe
         5sYfE0y5qwQBrfV0dUERrvxoex+8jtNJM6Vvg9UcLr2MPXbikVeGzrOAV1IWgydDVUvY
         mkMA==
X-Gm-Message-State: AOJu0YyaDiYcwXv5aYmBUGbQdYXLZNKeqQ6aS2t6YcELQ+SA6jFrQXUQ
	MG6l/PgaDrFLihMJe7/VUL19yYFWvRx/8U5Its7ap2W5JZKJNq888B5gSBYn2g==
X-Gm-Gg: ASbGncsIzgoS2DNpcGQzRYYogJ1CdEQ0Y1cxRhcemwb7b4odnYlRb7GysTn7oyX9iDt
	GkmZJAZCaHC55ZvQwlYpNQ+qrlWdsJbmp+5WbgTPDSCagzwt2eIbDxa1j2dFrRChzT7tinvLMY+
	TvmdAJXN/7N6ItJYLhw3OAtPhOdeDbF9zLAn2QcIbv+zkd9ABTAtX6GZfJpOBWoOiKGfR/5d0j3
	H8oJLqTn3PGvwcdA0h6crMOmT1yeK6bSYT9zfpLPcm3eYhvfC9DYsVG5uNOJEFg2UrY84vqx5tN
	O3Xq7309uw0viXwi68EMmOKeS6ggX4Q1aMIFpDkF2S0Ulcvv5GWxibSSMzxQShVoUdcp0ARBEuA
	uv8j14erSrWQyCfwnrowZC9+ieZoYtMUnBFK0r1GwpUvxDQfLVJDMULcUuEUhpvaPtV6aTKwvVc
	b7qhzTYUKmJADLLtH3
X-Google-Smtp-Source: AGHT+IGe5y/1DK2uDJlTsGNs4FhyR/Rf239ah1s/clyTM9qKclQx0h1g/iSS2ZKBrFHs9YVlHyxUJg==
X-Received: by 2002:a05:622a:d4:b0:4e8:9596:ee7d with SMTP id d75a77b69052e-4ed30384165mr86148941cf.42.1761994809265;
        Sat, 01 Nov 2025 04:00:09 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.135.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed35312187sm25575331cf.30.2025.11.01.04.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:00:08 -0700 (PDT)
Message-ID: <6905e838.050a0220.2a9efe.75f3@mx.google.com>
Date: Sat, 01 Nov 2025 04:00:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8501399158649968719=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@163.com
Subject: RE: bluetooth: sco: Serialize state check in sco_sock_connect to fix UAF
In-Reply-To: <20251101102825.173610-1-zzzccc427@163.com>
References: <20251101102825.173610-1-zzzccc427@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8501399158649968719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1018478

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 FAIL      0.37 seconds
BuildKernel                   PASS      25.29 seconds
CheckAllWarning               PASS      27.12 seconds
CheckSparse                   WARNING   30.68 seconds
BuildKernel32                 PASS      24.58 seconds
TestRunnerSetup               PASS      494.03 seconds
TestRunner_l2cap-tester       PASS      23.47 seconds
TestRunner_iso-tester         PASS      72.18 seconds
TestRunner_bnep-tester        PASS      6.07 seconds
TestRunner_mgmt-tester        FAIL      115.55 seconds
TestRunner_rfcomm-tester      PASS      9.24 seconds
TestRunner_sco-tester         PASS      14.20 seconds
TestRunner_ioctl-tester       PASS      9.85 seconds
TestRunner_mesh-tester        FAIL      11.38 seconds
TestRunner_smp-tester         PASS      8.47 seconds
TestRunner_userchan-tester    PASS      6.46 seconds
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
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:153:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.179 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.069 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8501399158649968719==--
