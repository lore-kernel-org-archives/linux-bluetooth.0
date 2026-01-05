Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4059810FD
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767649102; cv=none; b=V9+9udsnG33ysS+xHDmY2qyF4WKqqNKpNGrw9MOhcYF6LkzZTnwNBiY4qtwV0zqGL/oeavXosVUhr7vO+NN+XiWO9FZEe3ZAl/eYYs6Bw0lSLHTa+HvkpKXXnvUpaIFfnuu5rfAIKWASRHlzr0vPWNIYhZKHNjn9kP3fpFV4I+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767649102; c=relaxed/simple;
	bh=zHqN/OmLIZEjSCaYtPF3ZUkJavSSZezCnLWvIurZd60=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=O2Q/c7SwQlt51EX5p0q0s9Vd9xzbS6i8+ftNEvZLd7kITjEbUO1lQcJidnkXp63c+amLQ5ItASe+jDLJqzZKyYxhuMCxes9ZGXRm8pSh03p0ALfuNNZM5k+27HOYn7IetOtapclT8rQzqtiRaevOh57H9N6LxL3cwuP34ahu3m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+ytSAF6; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+ytSAF6"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c13771b2cf9so266268a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 13:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767649100; x=1768253900; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YhAG0DHLf+GEVCzwu8beYJW2gXCzH2/LSM6iUwdKP00=;
        b=b+ytSAF6WfOaoHx56SxMtDGVqiJTbj6v9+1F5Jg/U5TAdszGTaFlqQ7rw+z1DyoMY1
         EBmeuHBPBi0cI9hG4Dq2CfU0TvLrYDq6hE8F4E77fCGoANXwsNzVqXNJWEpXxX+Elg+g
         7GkPJSzGYydrtRzi7fuWMtto5GpWLllMO1GwN/ftEN0mrwwLTuwj9rWZuBbMTUEyvS7l
         1ci0Sq1DEtTXqrMwRtsHiF/WtCgpsi3IpjqILHoTxUOKcEJgVci81F9F+m1epyxlNTQt
         RFB00CiRxk/oJF4mMWouZn8zuMpiZu4r3B6jF/kt9/sNm1PjzXybrvLR6tSlJ3br9cM1
         uGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767649100; x=1768253900;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhAG0DHLf+GEVCzwu8beYJW2gXCzH2/LSM6iUwdKP00=;
        b=dhAbBFpfZ1O0bbwvuWtVWb/DMEO/MXR5IeTRfln589q58QWq8o8PSVxxsIlU45bd20
         iCzJCFt9WSWs2Mi+8HaMUj2IKPmuHMxn9GSU+wFn0eNH/XEMOBmfP+86mYTlzZQUiom2
         +75iyP03+/AsHaTMSNm8F3FmnS/09oZUrcHOTtscUwWe6fQ55NlIHigxgJEj/cN8KeWm
         uJMa7rxDKZZWj9qvQvidbZg6rmqDKvaGu/3c2D4gP0FfWRMb+mSVtGNGkkKBlHuPFLj9
         9j6OtUGDNrYg7D6npvffqaGkqdzCNC81gd4UiJBuIcBdiCV3GwQ/3jrZnhlXEWqq3/ma
         WO6g==
X-Gm-Message-State: AOJu0YxlKUqug2QcAqvPAcis1Yk/x8X4RLvxPUJxNVBTNAm2dH8oC6HD
	RmW6MlOpua+/XB7s3d899W8YqO2y3xd+VEJB9jCpA71+mJn9je7TiByiPHRbB3zl
X-Gm-Gg: AY/fxX4/qS4eMYCKruyiAYt5DQsV5+5fqC0HY1+raKCVs//t+JcnblayMdZcct+m68c
	RtXWinZXuLtKwX0C5ALiGbiOA7jpAw4Rfym9SPrZFGKHWUQRGUYA0h4b9jBc/SD6ay4iCw3yrwX
	kge7rEwrsFtLviZAYHpOZV11RAS2PP/Y2cpa7oPaSFkJ6zV/lt0IuviT+vNCTVjXULK8zhQ3bti
	5ZysjnVSn+65xoBOdfTIcysmzfl3YL82pVvYG/Mdr5YaJgxZaCAokm/sbGTDO9++YEeT/DRLYz9
	Obt4AL02iKpeU0Exs52HfrCcE6atclPmu4Gil9Y1lj/5XLOQchQ7BHFyLSDa2fw479gDpLB4Mua
	71fvWPYH/IMOf4X1yxu4qTjaNXv2EzkFNmPQN3nlUxE/5pTKqrFZR0mX4g21Sq6ieVOoQuuq4Wl
	3vuGQH2rHY89G+Gjg=
X-Google-Smtp-Source: AGHT+IEMp9K43K7VnAZGHxuRY3pbufiMWjbEF42s8H0n0b4JzIz6DkJBSFIGM+87Ix+HGjGYNiiH0Q==
X-Received: by 2002:a05:7300:1696:b0:2ae:5e28:743a with SMTP id 5a478bee46e88-2b16f86c6ddmr464755eec.17.1767649100088;
        Mon, 05 Jan 2026 13:38:20 -0800 (PST)
Received: from [172.17.0.2] ([52.238.24.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673266sm562972eec.1.2026.01.05.13.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:38:19 -0800 (PST)
Message-ID: <695c2f4b.050a0220.3cdca8.2855@mx.google.com>
Date: Mon, 05 Jan 2026 13:38:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5470642941015260962=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: Fix using PHYs bitfields as PHY value
In-Reply-To: <20260105211019.3098952-1-luiz.dentz@gmail.com>
References: <20260105211019.3098952-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5470642941015260962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1038699

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.87 seconds
CheckAllWarning               PASS      27.62 seconds
CheckSparse                   WARNING   31.10 seconds
BuildKernel32                 PASS      24.68 seconds
TestRunnerSetup               PASS      547.93 seconds
TestRunner_l2cap-tester       PASS      27.60 seconds
TestRunner_iso-tester         PASS      77.35 seconds
TestRunner_bnep-tester        PASS      6.15 seconds
TestRunner_mgmt-tester        FAIL      126.56 seconds
TestRunner_rfcomm-tester      PASS      9.39 seconds
TestRunner_sco-tester         FAIL      14.42 seconds
TestRunner_ioctl-tester       PASS      10.05 seconds
TestRunner_mesh-tester        FAIL      12.45 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.93 seconds
IncrementalBuild              PENDING   0.79 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.109 seconds
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
Mesh - Send cancel - 1                               Timed out    2.745 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5470642941015260962==--
