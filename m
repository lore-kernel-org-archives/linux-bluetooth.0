Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02880192D6B
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655972; cv=none; b=nYNljeM31P++l/P2wDtkiw7Bh2+r+t8E8Z7nnwsVcsnrotK61HbGEd6XQh6oUus903OvR9ahmcLZ/2kgOnAhIw0wEmB7S4w/5JU1prZtxthbJxThcBW60iUriADW3iRr5ESF81A5zheAyQnY4sy+Sh7KNjOMPsGQHNcBms6HqO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655972; c=relaxed/simple;
	bh=QWHCjPCfN4p0LvuS9nLxO6wmArqZMKxKzhVdf0UJ1Vc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bse/7JYSnJ94kcD66w48/g31IOGSajZqx+icPxroNopYKW+uObpQY1cvRP0GZoij9phKFy8ibjua87X9By8Z9v4N3yukBx/PCY/OevPC40ofyw4wuHaCE+zxBLYMH+4oSLRY4km5fUfaccDeFwa2/w9KAG9pIVYaw8mCn6FKQ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUYMSOJ5; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUYMSOJ5"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2b8e2606a58so2267361fac.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744655970; x=1745260770; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ju9fKM96POMamK3UrIMSsQuEdLW24PfsyMZ4kVrF1NM=;
        b=SUYMSOJ5s9XYNVQrObTMbY2i8uKXr2Y2pZJnUQMLpq3KP3ZONyTPIGvX7dk3/YNeQA
         gaZL1xa5rW6ug31JmF8eGwg/nDXiPKDZuCY6L7W00MXyRhAikz2jXdfPWkSi2H+mYKjT
         7ZpRNGmJuO53j19RQZag9lzAOx7CgMpcm4vncb24GkelRaKv0urYPqLBjYeRN2pXaFVF
         nyHPAy0JMIVXQf63NT5187vqwuuHUlkLQ4I0bPVqmX96ekTlYmFqaLZOoD3iM0yGsrRW
         CLCxBHDIqYtXk6FTH+ogjMXTJ99k/JDlYpWLlORo/ElJtYZZLvQIkATuk5K+p4cyuFrM
         xK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744655970; x=1745260770;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ju9fKM96POMamK3UrIMSsQuEdLW24PfsyMZ4kVrF1NM=;
        b=J9MZmAoJqcq1UpgRahJOdym4/QchvWYBjYzW47J4deEpdNaDuMgH/7f/N6a86nu2oi
         nHonFQ+xGdYDZN1VV3KX84y2eEWfk4rQxzXCBuYAtW5k3HuM6wW5nlzzLpdMZp9pYFu1
         pcpTUW1+zMWJTb2VkZd71JDmJ5G/pZ0o5f+w7j1l/JymXPzW+keCuSJbrHOBHwqVw3jL
         fIMmjnBS77YR2DyHCRjMRu/Oe3S7PQFJI9N/juvzOFanH7YKods6PAM7m7YQ36FX1X5d
         fL7RDEVaPTPOhid7pxc2uGxTp+X6WFVLu7MBG9lfNiT5OX5Nmlv1ov3a1OxHzpKVN8rg
         +fnQ==
X-Gm-Message-State: AOJu0YyxTT8z7/TEXboNKAW0C3WJljHymoY3qWLw49yiME8kxFFVMo9U
	Jvh/XUBI4kbmv/xohEHqSPU3Vyuju27JA84PlQZwqdjJYOPWfdhM0muh4w==
X-Gm-Gg: ASbGnctPVlBh0CdFBzMYxSF07gXn7uuC+SsjB8opQd3MBzfxdHPP1RubGf89GyacibJ
	uCL9qK6ySTFktcOkJtcaqIJ/2kIR+tpXE108tOcVnQQAWqVism9QYdMYt0EVVegl0BnIJc52hBY
	aljdKPmqffazJvEmlKzZneDNRdxgu/qRsgziAlERGY8B4r4kMgrRcEYOePiRIdCpFdpGYLfN/Ry
	DV5hHb3A+acUpkz9HpSjghohziu9rjTMq/YvOBSkMsocOBEibLvFfK6qiJ+y2k5GQZHJveHB1Kn
	EUQ9BqD1QcGLExoVifCqSv2NGgm74wNi31en3ma8ceP5Qg==
X-Google-Smtp-Source: AGHT+IF7GFNcnIQQrvtt1oxmmMcef6sZeA2EPwmJXQVdgsYONAO26sLg+OBxgYcRhRq30U9jtwxnIw==
X-Received: by 2002:a05:6871:39c7:b0:2c8:5831:8d4 with SMTP id 586e51a60fabf-2d0d5f835ddmr8177156fac.39.1744655969400;
        Mon, 14 Apr 2025 11:39:29 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.188.67])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d0969b53dfsm2487028fac.22.2025.04.14.11.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:39:29 -0700 (PDT)
Message-ID: <67fd5661.050a0220.14175c.f57f@mx.google.com>
Date: Mon, 14 Apr 2025 11:39:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8345495238060749083=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v3,1/2] dt-bindings: net: bluetooth: nxp: Add support for host-wakeup
In-Reply-To: <20250414175952.403002-1-neeraj.sanjaykale@nxp.com>
References: <20250414175952.403002-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8345495238060749083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=953200

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 FAIL      25.72 seconds
BuildKernel                   PASS      24.28 seconds
CheckAllWarning               PASS      28.08 seconds
CheckSparse                   PASS      32.03 seconds
BuildKernel32                 PASS      24.05 seconds
TestRunnerSetup               PASS      459.47 seconds
TestRunner_l2cap-tester       PASS      21.10 seconds
TestRunner_iso-tester         PASS      33.42 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        FAIL      119.96 seconds
TestRunner_rfcomm-tester      PASS      7.78 seconds
TestRunner_sco-tester         PASS      12.48 seconds
TestRunner_ioctl-tester       PASS      8.22 seconds
TestRunner_mesh-tester        PASS      6.15 seconds
TestRunner_smp-tester         PASS      10.22 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PENDING   0.53 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.158 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8345495238060749083==--
