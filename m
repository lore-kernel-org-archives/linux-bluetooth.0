Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B3C28030A
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042918; cv=none; b=dSOJPpY23Q37qdIteOH67flfYaxErWzhhHMwRIbJcVLh056lGw3LdTHSDURR2JHmDTVMnOOvpaVaG5yb8LizaMC/DAA8GmnmyD0cZ0K5KxIXsOoAYtO66nqcbc7WlfUx5t+raieORne3VbSp6IMUhTwUbXypHRAqCw4AZcK9W/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042918; c=relaxed/simple;
	bh=/AK188q04TCVsCWxSymG5crOJQLYaaiCI+1jdqiaCp4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iUvwanP6VHzjuyXZ4EouRO4aWrHpwPZo3mcckG6PIF71fRVifigVXVGaRyOQUnbW/9Wap/mOSfsuhYlBVTOBq0t5arkORBS6OOAjTB9lehsqFR6ra79ixD4Jl9rY7y34s/4VoqX/g6NY9BhOKtQ8tk5d+TAqkdRs7T3t+GLLbI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABk2N9Fg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABk2N9Fg"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22423adf751so2987915ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 12:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746042915; x=1746647715; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n+/6tR8qTxeOEqz4mkc3CMey7utcb+IKNUHiMzHEG+4=;
        b=ABk2N9FgX/m3x6mP7nMQl40lRarzrikEEWsgGeakC5OGccOZ0e+fx7aOaNyhKpUACU
         6iscVYLfV/xylSzI0FgJoBLM3B4RDurXhn5i1Pc9ap1U0v5s+JhGK+rbpEASnmy5nWhY
         6btOck+jMadReEcF/1EOj+y1XwjEkh60xmmcniFfMGOtpYKh3+yF9/xlhQqZgKxh1e8i
         XeYS3Ng6ZlPJe+KMKW/JuXRvBybQ1AqseIgrAKs9+NBIli8NI5ZZwBAbVnJu3HApeDD8
         /Iv+EOxdc8wQoTa+p/x7LI6V6HFDvBO6mpF/3Uq7TNDjONam8/0BpWwo+84gtt0xHpDh
         efNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746042915; x=1746647715;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+/6tR8qTxeOEqz4mkc3CMey7utcb+IKNUHiMzHEG+4=;
        b=DrRd/sFe9JSVmVkUnrIWTbleYT1xFRZbsGnLRIZJbNIAyqm4fj8RwYylccgL6kTMx5
         HOMgS9ic8ailyzRF2BDRBz1MLsbq42WYY5c4A3pFOZhF1nBIy858QJhaPycud5S5pA4i
         2qtXz4SzEM91fTp81uhnxq0ORgc5vI8RtIcbDncFqlAT6yYTbS65H/HFfJb2NfwEGH4A
         YfGFBX8VS/VinEywm5CbgsmwXqxO5TMtCpLcFKGchmYBpFvf6XsfHxVeBHBmEwW/Yb3b
         f+hCwM1zN72z4A9cnZ8rdE3H8b9qTqXaOfzAIpqG8t2teeG7DI/gAfGwBbZ4niSXi6br
         rIPg==
X-Gm-Message-State: AOJu0YyaYUsW1AwKU01Tldq6PJRX7gZnV8lxmfsgdEqsJNYFd7ponYeZ
	rRNDVu3SGicgcFpuqZi1jbLTP9mrkjOsLhyF4mByDaF33w4wOyjSMm4Dxw==
X-Gm-Gg: ASbGncvrbJ1ZxHd2QwmxrsB08P4oxA5uTmgwVRjSqMx3jamjdVkkByYlK5MA4lFuRka
	e20F9m3Qx8DXatjLLmSJoT3EsLeaF6LiJznazoO+s/qXaKfiMkUe9ZNCUV6a64UsCO2q8NpvWeA
	lNj2Ggx6X+x2a4hWHdH9PM7jwFXM/xpodi3G6tlxitvEkiYS1Ws33suL428Eoaz6EfSIZbRr0wx
	rsy/+JoGOWXzgz7E1B79d1evio+ECuUJHgjLEDR5hB3zJVdbR+xhVXuIq4cfk2LbqT9q2jYORCZ
	XDLnxy/Emj2ShMheFtigi48iF5P0O7hQDMWBtqvbp3+Xb2Y=
X-Google-Smtp-Source: AGHT+IGx5Qrk7q4XXA3UCnlEEOHXaEYNN3AS09vVO4wcYzxd0v2eKX3XUwKKAlTHImjetdPYo4Vlvw==
X-Received: by 2002:a17:903:2f8b:b0:223:4537:65b1 with SMTP id d9443c01a7336-22df358fdc4mr72416295ad.36.1746042915376;
        Wed, 30 Apr 2025 12:55:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.12.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22de49dccd3sm45959885ad.123.2025.04.30.12.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 12:55:14 -0700 (PDT)
Message-ID: <68128022.170a0220.f31d7.bd1f@mx.google.com>
Date: Wed, 30 Apr 2025 12:55:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0828609276296469748=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_event: Fix not using key encryption size when its known
In-Reply-To: <20250430192448.2386611-1-luiz.dentz@gmail.com>
References: <20250430192448.2386611-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0828609276296469748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=958631

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.64 seconds
CheckAllWarning               PASS      27.08 seconds
CheckSparse                   WARNING   30.35 seconds
BuildKernel32                 PASS      24.21 seconds
TestRunnerSetup               PASS      459.85 seconds
TestRunner_l2cap-tester       PASS      22.59 seconds
TestRunner_iso-tester         PASS      33.28 seconds
TestRunner_bnep-tester        PASS      4.95 seconds
TestRunner_mgmt-tester        FAIL      120.63 seconds
TestRunner_rfcomm-tester      PASS      7.83 seconds
TestRunner_sco-tester         PASS      13.14 seconds
TestRunner_ioctl-tester       PASS      8.27 seconds
TestRunner_mesh-tester        FAIL      7.15 seconds
TestRunner_smp-tester         PASS      7.21 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PENDING   0.71 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.169 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.193 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.154 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 36 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.115 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0828609276296469748==--
