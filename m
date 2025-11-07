Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E962F9C2A
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762485243; cv=none; b=mgo9Arn5taXylLkYNumPTcaiDwTGmbh44XymK8TEyqXTqydrXClpfl8r6ScgIEqy+OTmR+hF/EfwsRs02fVDd1eZarzrbFReQ+TMiAZCleFUAlco22W3EGEG756oylCqysE+n+IG5efrQYVMrSYgOKeQZ6gG1zuHq9HtYIuyL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762485243; c=relaxed/simple;
	bh=LY2aI7VMXQFYo6pGT1Bk8SDftu3kN29mlRR/eTkrLv0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gZDPuEcYGpvTSFYlvwgNdGHpJp9OZ6t4Q0RIw0fjjc2tikLiS27CDmfnlwJMTI9icQhMwAzIZNBH4UNCSOYKiCFjgpi50LHBfIet01ZrTlr3F+etfIHTCtIv4YrWlRIKDkT0Cfk7YTU5Pn3M2j6GE6+q0jfj5pcSYbLyx37tYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrVvQTDM; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrVvQTDM"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed75832448so5062311cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 19:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762485240; x=1763090040; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gFsYfIV4xXUNY6N1SPo5EHzhHFjdY5UWZiBW/+M4UdM=;
        b=FrVvQTDMu36BxcwyLhbP5kod6WaILK9/IPYLUgT/ENnVCL1XM87S7XDVURiUhvaCDM
         OvjhfEddrmGA1K7eqlklM2rxdIvaptlFpxrR/5g18kDUWtQ+Qg6ceoZ0jPVXVVA9Gvic
         k7THWcfEzHoJJeFU9zOMmJmb9D+K0GoKXz1I7lMp0cLnuYxzh/ju+8wEpJPQV9S270aH
         LRw3TKfWQFePtMq354GqwdvWCuKLriDBvbkcQsn1clRqdhMfvDts/VUgWICxlZB0Bglo
         4qxPJsSLvExxKAMDODzKONW0ENxtCyYFN4WIJGvUYoQsBPsxsRW8isY1FVxINpMtx9v3
         5xRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762485240; x=1763090040;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFsYfIV4xXUNY6N1SPo5EHzhHFjdY5UWZiBW/+M4UdM=;
        b=MHiPUiqQ8kiWY5DsbEyuehRrCoVXq5/sTm8lrkun2CbexSFPc3KaXBrAbuNJxWO1uW
         cos1IE1vXqsYOR5g3apOX87Z9fa8cLvy/u6JC6FczDtG9HP9ykDrcULb6jVRmRJzyMbs
         MOlWMqucUSEIYMZmNTYp2I/hYAc64S71jWSWoU0bSKuP9QEAFiVYOHHKTMDbghtnFQvu
         ZfoINLkYMyu2Jg8jo/Xf53JA99vBmenPJ1yLtNs3lGeEDcPZU3n4+RRegLHzxujvBepG
         cX+Tpyo/xL4EJPv/wmY5EKGB6I4l32SNY9DKjOpfXVgPeYYiza0FYXHK06IMEW95Vqly
         1XUQ==
X-Gm-Message-State: AOJu0YxhdwfCi2UfI9kL2NHoI2/gg2ckezx06b6l0iyiGNSWSGQKVZrf
	/O5nlxPmgjJulMHaikfzLlP1EGPTWsmsvdaGqYxySudNUl4DNqGz423uNi+z3Q==
X-Gm-Gg: ASbGncs7j9BKyp7ssttZ9k7L7r2weVGsLw7lbYF5XycE7X9BhJh3H+y351TMDUQKKbK
	1B1wbLdmhPVd9FlhMRODCdwraZpA1EnHDgREp6iWzCSUoSJ64I/CX4c1LYn94dPP+Nhi3oXtBcM
	nLn7HG7xmwIR5kfxN9aRH1OM1nwE7Rm5jvbi3FPef/2g185cfjpsBZzTgK4HgWAHU2pdFsq+IA7
	DfsVZsAbAwnjaq8tCDbgyXmXJarOyDBbwTKJKWHFPcSPyWnoTyanf70fsIQdVLuZkcZamMzeipg
	dYRQhBriqaCky5A3rIn9u8P/aP87luTVqjT5PsUWklYDzC3mz9amtHd5eUlWclfA6x++MW4q5+y
	TLEXzkMCVZEp6lhfPf6RY7x0WnNd/GVr7CJ17VOOwjB6SovS5Ia9V5l6N3cJH7Bn7F+/XrqVv2o
	bhv0MWiw==
X-Google-Smtp-Source: AGHT+IFWEbZVfxsXPrmoF1O5hRs4Ev8lmqW/npLABQTuwrOzwWrK22lccqfl2NqwY76K0BjSeqCDYQ==
X-Received: by 2002:a05:622a:242:b0:4ec:f030:fe46 with SMTP id d75a77b69052e-4ed94aa99femr20727441cf.83.1762485240049;
        Thu, 06 Nov 2025 19:14:00 -0800 (PST)
Received: from [172.17.0.2] ([40.76.119.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a37f10sm31114916d6.54.2025.11.06.19.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 19:13:59 -0800 (PST)
Message-ID: <690d63f7.050a0220.30f236.82a9@mx.google.com>
Date: Thu, 06 Nov 2025 19:13:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8243330114553442983=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: add new custom firmwares
In-Reply-To: <20251107021345.2759890-1-quic_shuaz@quicinc.com>
References: <20251107021345.2759890-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8243330114553442983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020712

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.18 seconds
CheckAllWarning               PASS      27.53 seconds
CheckSparse                   PASS      31.02 seconds
BuildKernel32                 PASS      24.83 seconds
TestRunnerSetup               PASS      497.26 seconds
TestRunner_l2cap-tester       PASS      27.35 seconds
TestRunner_iso-tester         PASS      72.46 seconds
TestRunner_bnep-tester        PASS      6.11 seconds
TestRunner_mgmt-tester        FAIL      114.70 seconds
TestRunner_rfcomm-tester      PASS      9.16 seconds
TestRunner_sco-tester         PASS      14.46 seconds
TestRunner_ioctl-tester       PASS      10.25 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.34 seconds
TestRunner_userchan-tester    PASS      6.47 seconds
IncrementalBuild              PENDING   0.90 seconds

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
Total: 492, Passed: 485 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.154 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.164 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.030 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8243330114553442983==--
