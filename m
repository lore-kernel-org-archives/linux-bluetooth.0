Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA110953
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467570; cv=none; b=SztvAPbFEMXmx+66y3Sljuvt4j0uuWaAjp0lCSBWDcab8uh6CPUAO8Memr1Kf5pc/wsbfnsjZWVWM+MkmDgQURDkJuOca7VC6sm+qhRTiCe7GuJGg6V7yIzlcoILXeQuVANmz8HR057OgCcMUAuRKAyLSQ5jD2a/BrfCjI7W/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467570; c=relaxed/simple;
	bh=s26I/6bzUkVbN4ME1vWnuVAlh65VjA7/UXs3akW7JCQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oIJZ3TVzRoLP5d2Mnbepi01wAAfo83zh4shteH+oL6FFgB7LxOJBjzBEhRiGdMbWtyMdBSP8UiUiZutfk30T35o0tpjLyMeqV7iHUKR7QuXtBaz4ailr3a5Uppc8+wn2kBIsEUxNI7626vRoRDLK3JWMVDe7oz0KGDS48yy8AHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Alw0jguQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Alw0jguQ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c9a1ea8cc3so2718641a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 12:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720467568; x=1721072368; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r3zxie7juMQ1ulr0g9XDgO/As9vTTJ4vaZGQGN++/kI=;
        b=Alw0jguQIVOC0NV15bUD+Sok/WBOSGTyhJ1PsSLFmmiKpDsEo3U2t1wJyeRRgGPzrA
         VWa9rrd1Q83fvcsaBvFcKPppnm5tluMHiU8bCbcCoXqJDdo+ckcd2UJuM+cqWewohXY2
         ybx8ZmEo3auGhlTJTdAB/5ncWiMXaWCahuaCys/KxnkCXH9jhzxOwHqDk+EedObdcAd2
         HZFVSGpd0G/Ic9DsNb/jZbBLRXa3PWdoz/rA/odm/NkAjTaG0zT38YSu1YqSmg4DAmuI
         jUIDGKqLbA8juq8BPvosE6vUi2EbnrKBcCYFqvr8Yn0r8cxdg4zdVXlrZVLmqKPm7p4v
         1+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720467568; x=1721072368;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3zxie7juMQ1ulr0g9XDgO/As9vTTJ4vaZGQGN++/kI=;
        b=ODX5o/UEiNzMA5KZELABYDoly8WCKYZ7VKkJYPZTSw7cHjwa5c5O1TzBYuY6hMpaZu
         vdpKH84cduQy/ey/45XPh35MgUv5O0vuabSJ08fOdG0AdF9WCTj9jHBYYJmrLQgI/3gd
         ZYy7UZBPFBgb7gNz54a+QwZULaLMf+JTXE0krnjAuh68FnUIFdPKwKvNwUjgnixJ+z8I
         B+lF5ZIWwphanacSwQSPU6S+VB7d3ZVdnQiaNxt19whTjjabt3UgCxHi8an1WYpLFwOI
         4Ea7B6AI5Ge1vwYsL/oVLIc1FipSv1CS5ff1bdZPHVT9miJMASj975RAjMATsOb4UQLi
         Ujqg==
X-Gm-Message-State: AOJu0YxTN/H2Ma2zv9FkMyFO1RLdl9dJhAkrysQKySgD0DIBZiD/RDIE
	Q1jVOgJ2L8ZT2EYqEZpYq0f4uwTnDZiG5KbcYnjly2SGOQzCG9RZQ8Ea6w==
X-Google-Smtp-Source: AGHT+IHSmOOUc2DuTsdvBOXgHWoPaHrEcIHkRTUI4UJIFnthjPIke9sC4nh/gn//4CUQzjALFf+CLg==
X-Received: by 2002:a17:90a:fa0a:b0:2c9:6d1d:3990 with SMTP id 98e67ed59e1d1-2ca3a7ab6c8mr318901a91.5.1720467568094;
        Mon, 08 Jul 2024 12:39:28 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.241.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a980b37sm8582146a91.24.2024.07.08.12.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 12:39:27 -0700 (PDT)
Message-ID: <668c406f.170a0220.89018.b9a4@mx.google.com>
Date: Mon, 08 Jul 2024 12:39:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0661628545507190717=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: btusb: Don't fail external suspend requests
In-Reply-To: <20240708172650.2752501-1-luiz.dentz@gmail.com>
References: <20240708172650.2752501-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0661628545507190717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=869381

---Test result---

Test Summary:
CheckPatch                    PENDING   63.99 seconds
GitLint                       PENDING   33.69 seconds
SubjectPrefix                 PENDING   31.67 seconds
BuildKernel                   PASS      30.07 seconds
CheckAllWarning               PASS      32.94 seconds
CheckSparse                   PASS      38.81 seconds
CheckSmatch                   PENDING   141.37 seconds
BuildKernel32                 PASS      57.05 seconds
TestRunnerSetup               PENDING   574.70 seconds
TestRunner_l2cap-tester       PENDING   53.99 seconds
TestRunner_iso-tester         PENDING   70.02 seconds
TestRunner_bnep-tester        PENDING   13.29 seconds
TestRunner_mgmt-tester        FAIL      115.09 seconds
TestRunner_rfcomm-tester      PASS      10.63 seconds
TestRunner_sco-tester         PASS      16.49 seconds
TestRunner_ioctl-tester       PASS      8.25 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.05 seconds
TestRunner_userchan-tester    PASS      5.14 seconds
IncrementalBuild              PASS      28.49 seconds

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
Test: SubjectPrefix - PENDING
Desc: Check subject contains "Bluetooth" prefix
Output:

##############################
Test: CheckSmatch - PENDING
Desc: Run smatch tool with source
Output:

##############################
Test: TestRunnerSetup - PENDING
Desc: Setup kernel and bluez for test-runner
Output:

##############################
Test: TestRunner_l2cap-tester - PENDING
Desc: Run l2cap-tester with test-runner
Output:

##############################
Test: TestRunner_iso-tester - PENDING
Desc: Run iso-tester with test-runner
Output:

##############################
Test: TestRunner_bnep-tester - PENDING
Desc: Run bnep-tester with test-runner
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 3, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.162 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.198 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.199 seconds


---
Regards,
Linux Bluetooth


--===============0661628545507190717==--
