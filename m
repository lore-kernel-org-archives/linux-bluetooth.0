Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0731DE8A4
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400912; cv=none; b=axBTf1oHMZuq/09FdeEJN1uj9UAyFzZMo7Uc50XDRpVo8M54Z4mFZJrgN/7cLR1COlaT/RQIWoN/n32w8eqAhaVBDPVKGBe32SHezQbH2jKcJFhkmMb+5bqsGajtnIunVVoR6HdCjP7HAOqNy7l164SsB2Xt4vfy9np7PvykK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400912; c=relaxed/simple;
	bh=O4lIsPsS2Mh9lYEXbW5Xp3heDdxnf4UlJeap4iiWxzY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K6qJUslC2CVXGYCLIpt7Yy/seI4FTL3NPv2ckGjcmjjRACzZ2D9X3HlaORXedHHFedWNBDs3WBEw/xeeFsdTt+DHG6nK/u2dpbNLeUb/IpRtzwiro1kiLt9eBzw3+ZbCyMRD3H8Q/T4IimR+UBRWIZc59o8AynS4M85u+j7KLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXxVJaa7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXxVJaa7"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297f35be2ffso4053695ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 13:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765400910; x=1766005710; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pxQVrdbmi9mZgmKJB8FA1EWSVlZ6YZRLuQ9F9sSCl38=;
        b=HXxVJaa7omAW8mOnvBBKRQLpcpoaQCheJOHtCLxSX5zERu5tyyNE1OfGx44zPmpFhz
         zPU2aDzI3xvBU1dlVpgTSh8LchbJxCuXJvmkU8Hg3p/AUN85qPriG5jU1mxSGjZlQa31
         /6mZI3Yy7TiehtgSRAtlGXOJOld4qfjerFg+czbLUiEl8WyXO1FrAX87VSb7Ztg82Wjf
         BhtZqEy/XgE+Q+6OorlnZfYsc6Bo/2i2wfeeMbYG4pg4yTFOwFuvSzImk5otR/ReEkcT
         RJ5s9nuepEt0NPe+QeMU2aVV5YJ42FRgWFAf+6hH30bQ+BSsbR4pEryef03/o3DULYGw
         jsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765400910; x=1766005710;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxQVrdbmi9mZgmKJB8FA1EWSVlZ6YZRLuQ9F9sSCl38=;
        b=av0tkvRWsTc0R3BsH1fIg4X/iDZ4zxS1C3ZZpT+65KRe8dK0UIy29PJuCvheM1TbzA
         lNCbGJZ2kv11dIC1JeP/B+RZApjGfQEgu6F0+bgc9ayR5OloldK7jdYaa8h7oK//jRsm
         75B1NYTz5ETa2EZaK+x9fe23LYhdATQBFliGk8XmgdWWFbu8kl3yxLCznnPxZBJOKa6R
         RbObBG6F+TmuZClRfZHNqm/dQ9WiVRtyKUJh7+rH9AcabL6Wz20e5nOviBUDELKZWkUJ
         XVO6dWGdDcJ4SVv3fGrBySci9C39x+F52zsbt5zISq3ya/zb87o4VMC1n/2rNAGyMXC/
         2jgw==
X-Gm-Message-State: AOJu0Ywx+kVTlYJF1d/5C6YSe92tG772cFq1ggl7SPrFcrcs7o8YeMF+
	3mad+3rNykT8UT2v2rz7/02apJUlsDZyzqIwgij9COKkbmakGLi6RNcJn7MDEA==
X-Gm-Gg: ASbGncvXIL0fNtaR71tPS4BwIsqW+/kyby1emr6h/sSDD0W3vclzjgkNgBgRWtTgV89
	Ab3T0P/v5brQwguBNPye8teyIPecSH3vv4vjyULNzegPwlmlMN6IK6cqyf9xA05Fgt32aRYqRtm
	RXevHQPuwUjlezJmk0U4Snc0NgsXN22b1f5W4AYz3EcohxLWwph3X9C1P+//lgv8Zweda4MD1EM
	LJdaansqSSL4muLiKtF1f91WXa8SC5to3eVFsyGeRDYlGppWgS6l/AmQ4zcwJzf47x3a5MwoAdy
	VNEfHJ8HYbUIzIEPRbizNBmXv01QKp7WJcCm45cmbMWqswoF8Xw5JImhydBCMYRxklLRgj3I0UE
	oq1JExXmbkDi+bHGmlVee5x+epWp+MXS/o53jPqm1TH1oD9IR+XI9iwMreEKNtgDvTSIA2mVrPH
	VzDFSV4f3Kyb4nJt5bKig=
X-Google-Smtp-Source: AGHT+IHFPKg3BnOzd7+rbpu2aHHHXy+IEgBi0jvCGC2ORHAYgwX8vFGeu4OLSSEDQRv2STaz4UXlWw==
X-Received: by 2002:a05:7022:4429:b0:11f:2c9e:87f8 with SMTP id a92af1059eb24-11f2c9e8887mr1516139c88.34.1765400910013;
        Wed, 10 Dec 2025 13:08:30 -0800 (PST)
Received: from [172.17.0.2] ([172.184.211.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30497fsm1553512c88.15.2025.12.10.13.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 13:08:29 -0800 (PST)
Message-ID: <6939e14d.050a0220.2dd6a8.cee4@mx.google.com>
Date: Wed, 10 Dec 2025 13:08:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5049255519195162885=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, elantsew.andrew@gmail.com
Subject: RE: Bluetooth: btusb: Add support for MediaTek7920 0489:e158
In-Reply-To: <20251210202225.135637-1-elantsew.andrew@gmail.com>
References: <20251210202225.135637-1-elantsew.andrew@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5049255519195162885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1032097

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.38 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      25.70 seconds
CheckAllWarning               PASS      27.89 seconds
CheckSparse                   PASS      31.47 seconds
BuildKernel32                 PASS      25.15 seconds
TestRunnerSetup               PASS      550.75 seconds
TestRunner_l2cap-tester       PASS      23.93 seconds
TestRunner_iso-tester         PASS      71.62 seconds
TestRunner_bnep-tester        PASS      6.20 seconds
TestRunner_mgmt-tester        FAIL      126.72 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         FAIL      14.55 seconds
TestRunner_ioctl-tester       PASS      10.10 seconds
TestRunner_mesh-tester        FAIL      11.51 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.54 seconds
IncrementalBuild              PENDING   0.88 seconds

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
Total: 494, Passed: 487 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.173 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.202 seconds
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
Mesh - Send cancel - 1                               Timed out    1.858 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5049255519195162885==--
