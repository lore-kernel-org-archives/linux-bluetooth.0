Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D13101CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765529081; cv=none; b=m/oLCI+dk8ftKoH5vkvR5xqVfRZyY5K85gDqCoeBnHdCCZSTsn4lIuaHx/KsZX74sgxK5pn5DQkOMMn/DVGpv7PQXJDxvvVWN0iv2I7dT9yF3RBnue8LrXdW6mqyhioSrIFOjbwR4GqCLMFGFrCnVfazRlHh0Vb0MQ70v4993pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765529081; c=relaxed/simple;
	bh=oUXTnxQUBUEZgCXrQLIhByj0EV27wnQHaXS6m/7JCgU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b+F8C9vINJcv1niHz0bC4ClHUqosYCfprww6SX4EX+hvuyJOKeMq830/ImKx3OfU0O3Vop5NqVuCkbWRao/utY9NLPR87JToJieMmYUXMepySLtXJvD4KAwaUeSmbPPnup9qj/2SXrGjeGjCwXIp63N/pJ01QB88qY00qYPAZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSd+AgZY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSd+AgZY"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34aa62f9e74so1156685a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 00:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765529079; x=1766133879; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4yUlAodkjC1fGQp/Q8UAuZgN099g+PMW03RT8J+xi7U=;
        b=KSd+AgZYV1r5RR89bCpWhzmxu/+cIHL/orEXnLrkk16CdaE/fOfyGHjo05xlaqcksd
         YAXolLVKhUyHiWhlxRaFy/UaFrOaOoPAxw7+EB+txNzcWXbn4iUcoJjhaC9ohegqcWWl
         zJikhxZtREaoK27kJRd+ymz3Up2Q1slp9y0V8+7l4XydiY6icrghEGZgcDgHZbbPoBsa
         ESpW7B2nIe5Pz3YJhAHPGTyzYwTKxdEHSm0B3v9r2kQV63SEaUasESWdvGZthmt+Vkhp
         lZAp5higoGP/VlsB8nMBRGpmzzYQFasdlJjCDf9gmBuwUqzOuJHkwdD/lCcf5sbRlv5u
         9Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765529079; x=1766133879;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yUlAodkjC1fGQp/Q8UAuZgN099g+PMW03RT8J+xi7U=;
        b=nKihEzAO0ewqyX5lC7MZ75tCIvKZp8Rn8Kpbz+FuxEFOkN5cSzaauw5N8Ebh54P1yP
         hRlfknYHa79OeFZ1m/Vm703ErSndMbVmRKnWsO3vhhl0tLR5O/gVlmsmFKNg26i2WXQ/
         +UZTWsRUW5AFBlW06FhdBvpqY0+lcIqHB5hzEUPEFAMSWvhBptgaMDnonZ7mSae/fjS4
         G6jPD1Ny0QlsWg7CrtHatDQ8ZSvrHQYtSG8HkeGv1s7CJaQlF7LtnXnncam9EqFnJCdK
         JvH3lrjQg0v3dRgTUX0DbX91Jb45WObYjWZfDXb16RJqvK178L7rBrUOfiLaVmExS6ot
         QQuA==
X-Gm-Message-State: AOJu0YwCA33ABL6oqheTDEVZ3rTj4Wz/S3MzEtyX7w5Cy4xvmW6FOEoS
	yE84tNKsxpjj20YPXFkPk84RFzi3FhPnIhm81yfLh9k72LNb8+ZnNredwGgr4Q==
X-Gm-Gg: AY/fxX4/BpdHKMkCWwK8FB1EJLJT/ngorS8tsaYxoQo5vIqx0LOt6Tbk9jBdGUsswuB
	OKGHXK7mbL5ZuqDxf7bBm86z4VRDm2kncUIA0ueiDNp9X8kexKG+YF4pMIlOTkQICfozx6z+m4r
	B0hTVkanPGCAWHvWmnu4HyCqAXo8Zt2VR7rE95BtrFiXHg2lLKqhgBPObvbwSGanFHR0ZkSZIo8
	5oKmNIFP/k4ZuKPCMc0VDidzueNXrIv718K99LXKNyr/jBH/0nCV3m6rSPj203TXTtwxzlZd+5S
	mlfnugBsS877nteTGM+9yywmdPku/rCJFsuCArJ7VWxaOIQS6leGb1V7SKvNOFZWHSwZELYV/hR
	CMb0KEL6nvVLHj3BPqHSzvwvJpfS/iBjLPbaWRuuEWdXEfl4rf4r28BDCSJA18mM9OtzMMmcdcA
	WU/jaWbJDJFX44FTw=
X-Google-Smtp-Source: AGHT+IGAWBHwtVW84d65q8tEL8P6+6YBzC/diuGya6LA6yrvB08nR+Xtg+Ba0Jkbt41qOe63sbe0fQ==
X-Received: by 2002:a05:7022:7e85:b0:11b:9386:7ed3 with SMTP id a92af1059eb24-11f34c5085dmr1104300c88.48.1765529078544;
        Fri, 12 Dec 2025 00:44:38 -0800 (PST)
Received: from [172.17.0.2] ([52.159.246.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb3b4sm15268999c88.4.2025.12.12.00.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 00:44:38 -0800 (PST)
Message-ID: <693bd5f6.050a0220.195695.189c@mx.google.com>
Date: Fri, 12 Dec 2025 00:44:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0669000945207821166=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, u.kleine-koenig@baylibre.com
Subject: RE: serdev: Stop using device_driver callbacks
In-Reply-To: <ab518883e3ed0976a19cb5b5b5faf42bd3a655b7.1765526117.git.u.kleine-koenig@baylibre.com>
References: <ab518883e3ed0976a19cb5b5b5faf42bd3a655b7.1765526117.git.u.kleine-koenig@baylibre.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0669000945207821166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1032563

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.39 seconds
SubjectPrefix                 FAIL      0.51 seconds
BuildKernel                   PASS      25.57 seconds
CheckAllWarning               PASS      28.10 seconds
CheckSparse                   PASS      31.71 seconds
BuildKernel32                 PASS      25.01 seconds
TestRunnerSetup               PASS      555.29 seconds
TestRunner_l2cap-tester       PASS      25.16 seconds
TestRunner_iso-tester         PASS      67.42 seconds
TestRunner_bnep-tester        PASS      6.21 seconds
TestRunner_mgmt-tester        FAIL      116.37 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         FAIL      14.80 seconds
TestRunner_ioctl-tester       PASS      10.13 seconds
TestRunner_mesh-tester        FAIL      11.61 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      7.38 seconds
IncrementalBuild              PENDING   1.01 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
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
Mesh - Send cancel - 1                               Timed out    1.994 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0669000945207821166==--
