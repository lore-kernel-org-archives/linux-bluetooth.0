Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C819F286297
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 22:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919421; cv=none; b=dLsQAWddDAS50ANoR5jmD+qTH/qc6MFZVhl+sr7lElhf4kDQxAVZeeT9zSMUgrJFZBPJYkSM4e3EEYFdbKZ1fqFJFqq2SlBb39LrOjxmGH3x4ZZmbW+XWGYPFH3VSrz8h1svVIuarExIbYVqXs30oqvuVTW9mQHxXpaOwuA4Kg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919421; c=relaxed/simple;
	bh=nFvUHbjg/gXhfKOLNzYnG4MI8+DbCmA8dfn0RsF/aO8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a1TKvBpsoo4QH3OKLpuPYblqyU3oRluoUfGX8/up4T1zo9QfVBfvCBIl1N7OS6k3CVMqxR6zyopWmbPy0nCgtzULuST0OR1wT1LXurCVdMSQY3AfwFC72B68kKZtHqHlA7DK+f5la6OsaPOFvWgA55Y7Kt6cCVfQ9BiKxQ+jMAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNX/ps+E; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNX/ps+E"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f44353649aso8545072a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 14:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739919419; x=1740524219; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cl5EDuCmjaugUhg2xSY0camHvZSCvqG7ZJjZIqv25Dg=;
        b=QNX/ps+EXiG/6oVEwgv+DGdWVCgbrSUhLHZ3yAMq4LxfPp/yid01i5TSZXmLfeQA6h
         HXXJOphPBOsuzDwj8bdKOKI4vL+JTYiV1MYcW4GjeUBXT11d6x0OGCYLXOXq6KzUKy35
         iK9kcYk8ZOJekK9Vm3YMawZ8Q0sF5MX8cg83pj1mUES3/74AxktPAxMPR7uHHWjCoFIT
         YCWE51dLB1uUdD7ZXsQr5bYNz0X4dUjC8dj5lqyOyGbsWxFjrrDcUsyfbiNrURCzw8fU
         ATXNuoZFZbA7ec4UNMJhPA3W68KqZwArO+IHaZZF41Ei8tMGjZ0arI4sLlTRcn+UzDwI
         YfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739919419; x=1740524219;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cl5EDuCmjaugUhg2xSY0camHvZSCvqG7ZJjZIqv25Dg=;
        b=ACne38ToWxcopScbNQxcpvM6u7Dyzu1/m3p3JJJneuLpRGQmXV0xA3aGu4z7YNcvud
         irNqiS4MBsP8eDtKX3z7kUGxweVBmkYKFLMr8frYkr4Iwv1shXb8HzvcIxoz+Q4L6hFA
         JDCt7JCgeSODb/l8Oz9VPOPXWEQ/Kz4H9gXa/Lc5f7HsfaYYisBxGhU+07fVef87KHFX
         6d4360cuIIXdOKG9FP20Y57yKeOwdqW62aDKIrt0dprQg0s746xSaPtQVXsGlI9yLg3H
         u7dji16Z4BttRM0DwbItBqB8TC31FDukDHL+3wVs6NJ9OpDLQtU645uHWgl9fwysrGQI
         JEsA==
X-Gm-Message-State: AOJu0YywULVgvCfBx20zaczW+Z3I56LXQbn162WbPAzEQAyhAbKbgBHW
	qFVnZ5/DMdgZkljCUWR0k6J5nHf3UXThFdumd3kUBian6eEFU03a7LCRtQ==
X-Gm-Gg: ASbGncs6/WmrFVyZofjzZeoHLJu6253OCZsuciHI7OmN47cyGYKo519pg6hxHpMO1Jg
	j85UpJ3o+pbMw3EYE7JLUhc174WX6CZufE6fLRInbztyw2BN2O91zikttl1XfkyrCXLdEvVWGWZ
	AdRqKiq63nr/mQK4EUjFDTE+Aj8SerEbHvKWiw/962rBoPubGRsfWzQQYEg6+YCrY9owO//8HGp
	Mt5lA4prKqeymyGEA1D5DDE+zD1UNiLz/ZA06mKfSAKT9u+rn2mz+PC+yXT4schMMp2dUy71PME
	P8SP62kcF/tc4w4xXBFh
X-Google-Smtp-Source: AGHT+IGLLcZfFDcvXSZFs+l3fu19fl+v+puVftizMzLizDoHdZPkrRG7RrgwbXJ+F3LBfdFggk7Xgw==
X-Received: by 2002:a17:90b:3902:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-2fc40f22c72mr26588991a91.17.1739919418765;
        Tue, 18 Feb 2025 14:56:58 -0800 (PST)
Received: from [172.17.0.2] ([52.155.59.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fcb8351600sm45981a91.0.2025.02.18.14.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:56:58 -0800 (PST)
Message-ID: <67b5103a.170a0220.3bed88.0278@mx.google.com>
Date: Tue, 18 Feb 2025 14:56:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1593870822791660052=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
In-Reply-To: <20250218222801.1526620-1-luiz.dentz@gmail.com>
References: <20250218222801.1526620-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1593870822791660052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935310

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.41 seconds
CheckAllWarning               PASS      27.87 seconds
CheckSparse                   PASS      31.08 seconds
BuildKernel32                 PASS      24.72 seconds
TestRunnerSetup               PASS      436.39 seconds
TestRunner_l2cap-tester       PASS      20.98 seconds
TestRunner_iso-tester         PASS      36.39 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      120.31 seconds
TestRunner_rfcomm-tester      PASS      11.69 seconds
TestRunner_sco-tester         PASS      9.70 seconds
TestRunner_ioctl-tester       PASS      8.55 seconds
TestRunner_mesh-tester        PASS      6.18 seconds
TestRunner_smp-tester         PASS      7.45 seconds
TestRunner_userchan-tester    PASS      5.13 seconds
IncrementalBuild              PENDING   0.99 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.199 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.186 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.166 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.194 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1593870822791660052==--
