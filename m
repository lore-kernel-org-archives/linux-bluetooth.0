Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4D53365
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553321; cv=none; b=Q1Y8NDKgxZ8sbQfXTbRwt5wjU59+vEgpSgeSwNsDY7nuTTEcXqi/sYIJ/q7PvfudildR3g+q47bo5kwP92h1LiVguZm+kiuu0LQX/lqpm2LMCra7vbTOwlanOArWMtJNdD1kqTpdAlSEyKsB99IcxyBZxl8vE2hkoRYGYzp14d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553321; c=relaxed/simple;
	bh=msHlEshiHVgC/LpM3Bs6Ne+PVgn7eJUU160wYOqAhjs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NWpG4rsl0coKoHsiFU0Sj0D3qWZOA0VA6oA7GXi8Og3sj9/2vJbHG2UxXU4/gt9575hVBGHAOmDvRgggu2Qcjan27SDLpvh0HWuN9EGw8PaOidUDqk9yGSogdwjltYjCf1xjgp17DiDTOgrW0Q1cetw/v0wnAAmihfV3Ty+SW04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LP/34jGK; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LP/34jGK"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-86d0bd7ebb5so75729439f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751553319; x=1752158119; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5JyC63Y0ElcBBjudfqmPrdw3NRAC3NylH5SVcU6sX1U=;
        b=LP/34jGKAsoeym2zznZMv5JO4PHablD59CPbsr+NhAIaF4chzBEwNwWJ957jllu4+B
         gRnBmrDXq9RXkdqc5S8uzYpKjy2gjxcSrbBVMmSXAQlrX4SpObf6J/6jTon9LBQTogxL
         vegUvgss9JmAUc7MmZHKyV2w3OT1TJ8Af3w31DdNnFo5IVVyrTvRNFQeFMiA+8eRZcd0
         XUW1evpAbmlxn2QeDUmM8QJ5IzE9m6L+sCTrrzVpqYg4tJ8JBIllaAPfU57ERAZk87oW
         HvsW42ZytIQiXzkJqRcG40IImhmlKmlsFEn0hzTB4Qgv2kniDqeLbk/i7TsKxxwiZmJi
         bc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751553319; x=1752158119;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JyC63Y0ElcBBjudfqmPrdw3NRAC3NylH5SVcU6sX1U=;
        b=FEpr+Iruj5T1nHbfEdVPCIWioF+wrZ1haDfMbwB9QivgwMVmcmUagsRq3cpbzkxVey
         FCjjVg49iYSytPJxSnl1YjJKnyPEPsFXhnbdhBUVAlffM/UcZTapCVO+Dnu9BvpT/F5C
         07laALKZtsPmDm4shlvQc/e5fY3DXpRHjfKDFlxX4kSA1sMZYftNjW8wmeVB9rw6129Q
         72Br3IiRmNHg1zbhM4su1i+NheQFdvpC1DeW9W9iwEoQTAMNwPU9yRFEKYf64rzu0Q1a
         EeyLAinINxCamugyvHxXDkqHoW3ipRfolgzh4NVDgXz7/PS8QV+8sM8tgQW6vNnOQjEU
         A7QA==
X-Gm-Message-State: AOJu0YyvvOoMNb/4ezYp+AZBGWhg3t9ydgL0xcI36h/HCS7mVw6yAnD+
	f4RYcqfxt6UvH5EdvQdsMrGMa1QcCC0EG5ugETsEaPziLi8mK7Up3FkNhfiAKg==
X-Gm-Gg: ASbGncvXXYdUUJ0IcryTC76Y5hU4yKpLBjCFecwbjILoQNA9folh6rpatFgyY/VUpf2
	+amITda47FdEqpaY2iP1ynw2GS7qoML/kXgd8ZlCbzh16Y0RnSS/YjGSWPTsFTzaw9CHRqeBCa3
	oArws+FmgJkljqP3lf9qDSo1cAKXy4uRJUEtdB3rXWVqR74I1aT34oMP246V5up99v0GzcvpHwn
	1jHC4SkM/hk+pvUpiUQPIYi1YjiszVkmpmiNbGNXaKduwG0Uvx7c/S8kkfYi0xr1T1rvpYzONWj
	bOnZoui1QpCk1HQVaBPll2SmyZ1AFycllqd8LYjW927SSO9BsWfCCq6VUSCNcYH9OX4=
X-Google-Smtp-Source: AGHT+IGLXo8tVBTBo8/WQmyLNJ5r8zsZs+otFXNGtrC9O4uvTCKTF92VRPtcdmUX712w9GJbe3mjIA==
X-Received: by 2002:a05:6602:6d11:b0:862:fe54:df4e with SMTP id ca18e2360f4ac-876c6a2d1ccmr998382439f.7.1751553318664;
        Thu, 03 Jul 2025 07:35:18 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.5.205])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-876879f35basm306856839f.3.2025.07.03.07.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:35:18 -0700 (PDT)
Message-ID: <68669526.5e0a0220.9fb11.6ce1@mx.google.com>
Date: Thu, 03 Jul 2025 07:35:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7911464007458057737=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix attempting to send HCI_Disconnect to BIS handle
In-Reply-To: <20250703141543.1726566-1-luiz.dentz@gmail.com>
References: <20250703141543.1726566-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7911464007458057737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=978664

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.34 seconds
CheckAllWarning               PASS      27.13 seconds
CheckSparse                   PASS      31.62 seconds
BuildKernel32                 PASS      24.31 seconds
TestRunnerSetup               PASS      472.32 seconds
TestRunner_l2cap-tester       PASS      25.26 seconds
TestRunner_iso-tester         PASS      36.09 seconds
TestRunner_bnep-tester        PASS      6.01 seconds
TestRunner_mgmt-tester        FAIL      134.29 seconds
TestRunner_rfcomm-tester      PASS      9.34 seconds
TestRunner_sco-tester         PASS      14.68 seconds
TestRunner_ioctl-tester       PASS      10.05 seconds
TestRunner_mesh-tester        FAIL      11.66 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.29 seconds
IncrementalBuild              PENDING   0.58 seconds

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
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.231 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.163 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.202 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.207 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.496 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7911464007458057737==--
