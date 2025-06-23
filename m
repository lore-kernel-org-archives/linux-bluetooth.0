Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0123027C
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668083; cv=none; b=iGCEZfg6SEKmsLSn1AxqybYTiEdYltjNjGnPpErxgvT+wFt47LyS8pHxmXdwbDo4vWrtmBQqD+r9Z/SLYxfLpyR8W6ef4UskewaaiLcOVyu6KZIqjukSRIPeHyhrNQJcSE+vkIjydUpFDjZVzxhHqc5J335Bmt3QfV0AnGBxW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668083; c=relaxed/simple;
	bh=k8L6YPyYH2G1GhbKAFsbIkZa3bJRshsCEpbsU4/E2hM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uJ9eqej1gerHk79OQZoCojZ620iDq/ZEKzI+QU60ycN9JsEZZ91VTQ9Lihfx5gG7wEycHQYUsEkF5ioi+9WsD7/O4YSQR72hwIH8LJ0PUMDd9GSeovy+lPU6dU7hCM7pZgcDoOhcVoh8uSAlApVOi28UtC7aRMbjyaMXBXqCXUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt1I+gcf; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt1I+gcf"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d09f11657cso331332285a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750668081; x=1751272881; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=areXkMtenf5DSticsAj2InpeVExpKQixMYcJKyoGVus=;
        b=Zt1I+gcfs+O810afm+aEGNyf2+kcANgwavaKaVP7obr6GWGBWbyrItZPYjc4ssDiur
         8AyY0s7ZtJRLXvLLC6JexCrcoqREsuC8oBMVzbakkhIZRq3PgImoF9vIEAn3asQ7K+Eo
         EJ247YE8aWSUo0LVB1ljLFIEJ1Jl97cRsRcIm8+5fUdNIzi+aR6/43U3i5a2VgmIg4uS
         3uKMCkX/dt3N4slO6/S6LNm/ZvvWLZ4W2Kh5LAeNTnhoDS4XWK6HJX0Oxf35SU70czRN
         4kvWFvwQzdi/gLp6rTlewEc7HpCx1XxPdjyQKkLPU7Y558QwZ/UK1LhnWtrlWHcpZMVu
         7kbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750668081; x=1751272881;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=areXkMtenf5DSticsAj2InpeVExpKQixMYcJKyoGVus=;
        b=aInKXWrvZzpBkV8HdB8LRztmhH1FOz8PIYlj9G58b+U6+YsJ//XPpTKo90YmRcMdks
         JUKLv7ER5JtoMHJ5PBvYGuIvNbe9K4QYSVYZ+Ri1I9XX/GzbwpRLJq1BPywUxIt/dU70
         o2N72CUtfQB3zV8fB/y1+o60uBOMaDY2kiPR9jY5WuPzD0tU7r/6W2DpCuJHMZc6XfVt
         u/m7dOXYOrOAy1SovM43OElEpl9Vm6hAvCQGnPNOyq22CMbew7P7s+kICu22NH5HnAkI
         KPKiAa2GXSu8D58RGWVwh/SbVlM9hs7P5PdpRt0z5XeNm2vZSxzuNEF0+spyBT4lvojZ
         wyaQ==
X-Gm-Message-State: AOJu0YzF5o39Oiuef0zE6/dMEDtNLUHpkrFk736L/2OiMRk53q5911ce
	vOS5GIdPFFGh9FlrqUSTFN8bXDj6jN7LdmUC9jvmcDGm98nQi2nz3RLbIrTSWQ==
X-Gm-Gg: ASbGncvQ3GFJiAEYgzbBS354JyGk3yWjPe2olk54r59plq3hatbIzZE7Xenf8217gxT
	hQfMCw8XstgN+hSBM7ngb8iHbUupD+2iUAYtki2RBopCMWQPNNEpsH2HUN/DEIbk7y17dyMMdpe
	+dC87kExiC37m+usn1bayDHZjfOtTu9SlQbwJi6NWRDcfAh3lb5nMqEA02mWoC+iXhfo61r0RjO
	EiDjSyBeDzYDqd+Zvlgy8pIwuCxC02hL7LQjxachL3e40kfC3pbcPLsE5Er4DPXDXYszp4Fu50n
	RcE+ixCaekWTqnnC7cv8TJdgDW5pdpYd5FusERHXkhLhH649uewGztHyrpxawnro930=
X-Google-Smtp-Source: AGHT+IEl4Y9kepP5wOiT1eZvDalWzmsbudiPA7fCvllujplQQHae0NsOgoPoZBQjsAoWhdyFbDZ9vg==
X-Received: by 2002:a05:620a:8083:b0:7c5:4b18:c4c3 with SMTP id af79cd13be357-7d3f9915e82mr2067815185a.30.1750668081022;
        Mon, 23 Jun 2025 01:41:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.78.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f9a0708fsm362005385a.111.2025.06.23.01.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 01:41:20 -0700 (PDT)
Message-ID: <68591330.050a0220.25143a.b08f@mx.google.com>
Date: Mon, 23 Jun 2025 01:41:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7727024492462743011=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v5,1/2] dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
In-Reply-To: <20250623072744.130594-1-neeraj.sanjaykale@nxp.com>
References: <20250623072744.130594-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7727024492462743011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974707

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 FAIL      0.59 seconds
BuildKernel                   PASS      24.02 seconds
CheckAllWarning               PASS      27.53 seconds
CheckSparse                   PASS      30.96 seconds
BuildKernel32                 PASS      24.28 seconds
TestRunnerSetup               PASS      473.06 seconds
TestRunner_l2cap-tester       PASS      25.30 seconds
TestRunner_iso-tester         PASS      38.20 seconds
TestRunner_bnep-tester        PASS      5.86 seconds
TestRunner_mgmt-tester        FAIL      132.52 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         PASS      14.85 seconds
TestRunner_ioctl-tester       PASS      10.05 seconds
TestRunner_mesh-tester        PASS      7.47 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.21 seconds
IncrementalBuild              PENDING   0.52 seconds

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
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.189 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7727024492462743011==--
