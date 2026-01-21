Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C0423147
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 21:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031906; cv=none; b=U6O1k0jbKDAd120OY7VF+KhxOGU5R5WZjJ70G0G1jww8MTIYn8b3PpFgnLkuzaG81W+jqLGFoqp6UJUEJlJWCqnRvJ02jGhd3pfE5kKhUFaJXBt8d84G60RraM7WqrLfvGHG9vmwFzNPmcSSFS5NGiatmkcA3GLR9eElFPr/73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031906; c=relaxed/simple;
	bh=RRAFWkAqx3+USebB/wOk2ApEh8VSS2CHjspcp6YkqFI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GzHhgH33PXumwxaJoYz2EkuYgdcXnJ0Nb0r9nghSakiqXv85h4ur0S0bIC4jm0wtkNBGah/OoFc88k8Ny0c3zzMl6TGuGbaYZjPKmwIZdXBCc4uoRXjn5Uk/j81r5xMbP4tqRQ/isS06Xpj1YtqTPZNHS9qeNtybGgBa3jQykUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehzJL6py; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehzJL6py"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-502a2370e4fso2099621cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 13:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769031903; x=1769636703; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mZOTFhsGefSwsP7XrUIz/wb4PN97TQW48VRb5/a2ZME=;
        b=ehzJL6pyr3MxRKTwq7vbT8Dg0Awbox1rOenYYXi8q6jm8h3pdGJEv7X19sFDYfBJrB
         UtQpPmgn9BiCV7Ad5vzxQczlUFEwaO/wIUL89PYRgbj2WJdwXyai/SuZfsAgf/l2nxMa
         8BMThgAiX+aQFdRFNmFEyjEZrjj18VzPTCxH/9y4w02Fr4c8gN1qEgdKL/oymxuH9R3I
         ATSXFYtgCQxzFY9KOS+fsqMtna90sfonAg1v3wNd9/iHikuheG6VQseDHIYCp+0u3tp+
         nbfMCiIEfqSj+3kQGlPGuI6VAVrkk5pbCMWTNE0n1Ci/CGFQa9g/eO3nj52ezVkIvwR6
         wx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769031903; x=1769636703;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZOTFhsGefSwsP7XrUIz/wb4PN97TQW48VRb5/a2ZME=;
        b=MpiOqsOXiV3421kaT28cFtECW1HESdy6erYgx9liToG6RK6bGb4BtMlZafkV2dhTVd
         a0UpxDDLwfquFQcoJScUvVhhzDKz3bwFLD62kLcKyVG0/6KDm6qjevRXsCJgoFI9KsFA
         VLN5l1ribwv5jF7+IerGovota6KhU6nGyRZqDjGECV7n0ESP2sYtA2ltu/0wzZPOAtL1
         jYBg7fX7PZttbnhnDqrZp8ERuoMmJ0yu1/UAKWg+4Z52Twb2N5W9o5QsXz7tXeh9e1p5
         Qdisjfu5GJ3MToMiOKN1Lxt410yh7OU4ESuksXkBjycIOwxKztXrKeb9uuEBCFiHFyWP
         d2sg==
X-Gm-Message-State: AOJu0YwCrZhTXQV6EVh1no2jFFhUyzmlnwKAhd7QZ1TJu0sBcgJ7X9qm
	xZ60Aj6A7CYv75qXPqV0jxX4xZKIgJFzUXJyNF5QK14x07Plxmm1c26OX9MeG+1d
X-Gm-Gg: AZuq6aK6a6J+jNZB7JtlUEXYhxsglT1cUzHosFFnP1yfYd5JaK0CtS0XRYH2lFwfkMi
	7P96fmKDP+FGxW8Wmtd3JbXIBCakK23JRuy/reO0KgVILqe7XZZCoMrHFic58h/deCGfuTyjYQM
	CjUU2YUUPWSdAh4erPJ9nkelQ1USofjMSoLHKygoUdtr0IvfC8CBKsxTxIwZdTbfs45A7h/9HnC
	uKebeK4Mk8Tg96O1oCYY8qfEWFBskZ//zLT0x+SlkOuKc2FHZ7WVVV2Tclvs9hGL4wWcsEMwPRV
	tzKET33USb1rPEQzBMQvbXRSjVTdye8oUHMOw8ZGDbCWXdgP3qwfGmBEZxVnVf9FlocpB02Yepl
	KdhVmwu/q5UGz4LWiIZsb9ek1VWA7JtRfs+Ziq+gxAzADuqzrWaNueeUi9khInLCLgh+YZp9rec
	mNw686mOILBJS2vzxK
X-Received: by 2002:a05:622a:3d2:b0:4f4:c7c0:bd15 with SMTP id d75a77b69052e-502a164df76mr268568781cf.12.1769031902871;
        Wed, 21 Jan 2026 13:45:02 -0800 (PST)
Received: from [172.17.0.2] ([40.76.191.132])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8947704e8c5sm14457466d6.16.2026.01.21.13.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:45:02 -0800 (PST)
Message-ID: <697148de.d40a0220.1d0044.ad48@mx.google.com>
Date: Wed, 21 Jan 2026 13:45:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5415988239463917427=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix not tracking outstanding TX ident
In-Reply-To: <20260121211856.2658795-1-luiz.dentz@gmail.com>
References: <20260121211856.2658795-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5415988239463917427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1045341

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      24.83 seconds
CheckAllWarning               PASS      27.34 seconds
CheckSparse                   PASS      30.95 seconds
BuildKernel32                 PASS      24.69 seconds
TestRunnerSetup               PASS      542.47 seconds
TestRunner_l2cap-tester       PASS      27.40 seconds
TestRunner_iso-tester         FAIL      42.97 seconds
TestRunner_bnep-tester        PASS      6.18 seconds
TestRunner_mgmt-tester        FAIL      112.99 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         FAIL      14.19 seconds
TestRunner_ioctl-tester       PASS      9.94 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.32 seconds
TestRunner_userchan-tester    PASS      6.51 seconds
IncrementalBuild              PENDING   0.91 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero+0x76/0x1c0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 487 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.209 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.186 seconds
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
Mesh - Send cancel - 1                               Timed out    2.046 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5415988239463917427==--
