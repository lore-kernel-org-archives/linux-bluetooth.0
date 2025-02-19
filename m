Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB41C3C00
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957588; cv=none; b=aGvsgTeq1+4TeuuoCyxCg6qt14Yv7fQc+8WJs34ehpeENRSUXuw/TeuU5FYr1vo76YtGfPuKAnqymsFNZIHlyocTDMmab7OyyEUwhiF3PTR2g24N83QTz8BfGe5ZuHBqqDHRK9m0P2VhhULB1eF11wGdvUnDZSTIJ2Uxb5194gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957588; c=relaxed/simple;
	bh=5NeilJmQEC/Lijll2uKWDIn4qPpL1+UBHmurvsCjNEs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tbDTunLR2QPGNzQbk8MxT1PgYB5ywEl0H7QGdXXhZWHHvn2Edj4u0GrXbI2Yljz/wfJOfPKDOMOh03efQybveujEsTZLxILppN9ebjIN1wkd8DmAaCF7q8R3+3BQkBMl+0ARfQ12W/JgCdkqwAgqFyI4o1H07LB89s+4tS1vR+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OssWZf5a; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OssWZf5a"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e65be7d86fso6064576d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 01:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739957585; x=1740562385; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/X0Pc63d/4mFra73wt2NLv5S/2+DiYbQK0o5vXHwZOE=;
        b=OssWZf5a2/H4+FP+Vdl8Dp9W3b0dnYZMi1fwdYdLkaLjmMaCjZmWUdPE9cPweNJ2VZ
         6X8nevaBieIbUX5vj/qjnALq85dQZPPR+84V+TeP4W/ahKwTcM0SSIYRBmeszL1/ABmD
         nz8LfZvSp5OUz1foIZ8ge5Ss8m7qoe8GDk4ESomeEYXpPMEs7wblH1AOYdFdTYaTyn5G
         72xDrB3jsx/fy8BbgWpjUEb6T3TFUtLAlMqOekb6wKM02oRYVTYq5P319yhGvnRcqBfj
         wpT3k4jnbn7trZ8HN7aI2WfWt/zn1IWMu2GVO07f5tsUYRaKA1zzLb7ajhOpSXEy97xK
         pG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739957585; x=1740562385;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/X0Pc63d/4mFra73wt2NLv5S/2+DiYbQK0o5vXHwZOE=;
        b=WCw/8hzXNMzzbCdwlO5xFVdhadozgJsOlwk7vYjwqtGGZlJUkaIgpOZb6JwPHIHv/d
         2FUYdC4RPA5PpYdzcvDjFbzDd8iTobckg0sfHoIeWZdHx//KnTiuPxl2UGnMnctjJiOl
         voCHiCj9jLj2bsblv4bMbVibbYnB8clqrTUXOE/1O5lPCO4uiko7RuJIw7djYIEVjjgX
         ceMBaGYLCCjZxgU5SdNsduqxeAQjl8ijOwR3yrAMsMMSfS9KBhypVW7ezRgUEEWQPrA4
         SN7d81asxf5wSKwB/KOAF1iaqj0CVAbFFFBNmIKxFkPdC3utN0HnmX5L2+njVL9cpqYf
         50Dw==
X-Gm-Message-State: AOJu0YwFl+KWO+8YRvi/1YGfYXT6y5MdbawLFBUzLSFORP+WQULO5Rkg
	xMqSpLsVuJfBND4B8KxIAcWnaLclH2khsNk18l2YbVR3wbAGc6pFLaIrrw==
X-Gm-Gg: ASbGncucZnu6q8z33M2GvQFHXWsXO49LNPAcVtHJLvFqULKXl+lQ4gkVrqghvUtdqky
	sKmEHr8GFPz9QEyDnO2x+cNZDw79i4E1v/V+UUoAGyOx0GGasYEgBZWUYH5kkmQm7+CKxmrdLgz
	azt/ogwy/CZNs8ZV0zVKRTzBA9r6xndlQRlelvbxhjf/60522R2TddnSHNUDoUvfDYoixGA3Foa
	mxRgcNhqdPhog92lY4jBF6IdA5e29J64EeiYqfll2CYty4PVDHT7nd8ZH3cF0b2giYK9U5b46TN
	5BjFHQLMiRAhSpj2M5XxugRa
X-Google-Smtp-Source: AGHT+IF2iTQZGsIh0OmsuxS6PnKBRLkeCKdkbINF3uLZRpfGKQkoctHLyuxI7EMZ6qCwUfsq3cZqCw==
X-Received: by 2002:a05:6214:5292:b0:6e4:2561:48a7 with SMTP id 6a1803df08f44-6e6971d64f3mr33368816d6.17.1739957585383;
        Wed, 19 Feb 2025 01:33:05 -0800 (PST)
Received: from [172.17.0.2] ([172.200.199.205])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a3f9dsm73099156d6.56.2025.02.19.01.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 01:33:04 -0800 (PST)
Message-ID: <67b5a550.050a0220.177af0.c3fb@mx.google.com>
Date: Wed, 19 Feb 2025 01:33:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8135346127043358191=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@linaro.org
Subject: RE: [v2,1/2] bluetooth: btnxpuart: Support for controller wakeup gpio config
In-Reply-To: <20250219091512.290231-1-loic.poulain@linaro.org>
References: <20250219091512.290231-1-loic.poulain@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8135346127043358191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935490

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 FAIL      0.51 seconds
BuildKernel                   PASS      24.73 seconds
CheckAllWarning               PASS      27.25 seconds
CheckSparse                   PASS      32.32 seconds
BuildKernel32                 PASS      24.62 seconds
TestRunnerSetup               PASS      446.05 seconds
TestRunner_l2cap-tester       PASS      21.27 seconds
TestRunner_iso-tester         PASS      39.86 seconds
TestRunner_bnep-tester        PASS      5.01 seconds
TestRunner_mgmt-tester        FAIL      121.96 seconds
TestRunner_rfcomm-tester      PASS      8.03 seconds
TestRunner_sco-tester         PASS      9.73 seconds
TestRunner_ioctl-tester       PASS      8.62 seconds
TestRunner_mesh-tester        PASS      6.23 seconds
TestRunner_smp-tester         PASS      7.46 seconds
TestRunner_userchan-tester    PASS      5.24 seconds
IncrementalBuild              PENDING   0.41 seconds

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
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.210 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.182 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8135346127043358191==--
