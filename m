Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79814C6E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685487; cv=none; b=axqvEGa4Geah6BaBgq2JoZdZUD4pcZqDsgkGiIRhIsk6Edal0nGZS1GFAsZS0g1CUCqne4cSJi+JB3o0SNuUVSoXbgFTJ8wmMg2e14mMhX8ilzF3cMlABuojT0kFh2dQSpQEy24QzTaVUKvcjj0lNIit2IqbUc68L7TtGm2kwN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685487; c=relaxed/simple;
	bh=myin1JTVWzPV9UEvI6KezHmzzinMda0NCbphhcMTalg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qmEIzMvfqY4LNOHJ8TX3yHghX2xwhCfGod9diQ/+u1hqvt0jibMo8wlqzS1by2N06HNTL/aO5LOSPuH0snHuUUtp2GGV9lgtpO7x466SoZvtYDOFoGZ+ELEjyvjqjVN5Yiiu7oEZ3RgaR4vLi0AEQakBUpKbRFO0YMNLF4pjZl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8MRc2f5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8MRc2f5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234d366e5f2so54782095ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750685485; x=1751290285; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ChMRCWju8bVXoZYt5hXSm0mW1DP1SJKoLgTWXchsplI=;
        b=k8MRc2f5rbd29EuGq3kPwMr3yG8yBzJS9uxamlplKW/lbwByDZmI3UL4l9dM3u85jA
         KA/waTzxACBaCIrQDicCw++WXziCSFhHy/0E4JbmiUIMWa37P+gux6F131sMf76ywrON
         y0PW7Rb1Ci1Khup0jMRTibkuIwe2BAiqEjPBmpil3c/zFVSz7Jn51585Yvhz90EfRYp+
         Z/bZqTOOX2qD1c/9BG4CysSoUZGuApPZS4yiWVMWbA1C8+tglcFlO0Uv6rhUc7gMbEOu
         qOQtcNcfc56mW6jIkZp1Xb8BmMZtN/jzjRh2gP73xs9jUlC+ymD3/Dhy9YeduwkcZNRi
         mHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750685485; x=1751290285;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChMRCWju8bVXoZYt5hXSm0mW1DP1SJKoLgTWXchsplI=;
        b=a9FGGBYXUxmbIul43iGPAy7wKx5bqEbqIM1Gbzc0j0zT074ZnWKk3mlyb0LDOk6Qof
         YI3gNdLqlXw4I9rHYd9yHx4XAf9AwAuwzhxggMRE+7emHz2NHMoWLOzzEeEtIMM2UGME
         /tfMzFpIsz45HYfFaQbo5t5S3MYbI/qOdrxVE0BnEQDPl7yN8lO93w7FzBmzLhc14cYU
         kMbtpkZI+dHXIXFlgMUsHf00i2V4XDwkAwrsex289U9I/8PLgUEZg8Rhp9Yny+HcuaTm
         B/+ZAyK+7TiMiqiFHwapNO3svnFOtqMLh8Q+0R/8/sKRUdci4PzC4JRdbHrYMAGchI/F
         QDVA==
X-Gm-Message-State: AOJu0YwMYe16TDaKV20ftP0MvEgfnPZJHYHVaVo0ONS/K07nzKRxqoZM
	ofg7LpFiI4VJCQB5Jsfceqim90y7hdb4xlUIB+iBGKdR0V96ztt/2Cev+FuSbQ==
X-Gm-Gg: ASbGncs6OcxkD5y6sjYN1mDJThhcllUdtuOTEqM2+siLspkTs3Nh167mTpWd2W3BpUh
	sCssbHQYhvM7lmh9dHiZHZ7VCPF6NZw2hDQbSLagGOwigIXBd0bXbRC7WW3Q7RJ9kNXWrO+CNUZ
	UBVeL1+SM0uC+Tr5dLBLhDD1kS4Oc2iZGWD/mpVlBhct6l0O3wEs4+HfhJGRPdYHY0VF4q5Bv40
	HSbC8qmpCnE/1N3FjALjTaWP3jVlmZNUujqoS0BSkyAuZueGEsuGiA/F6oyB35RbTNA6alYAW8e
	4cPu8KrxJ0tXxyvQzMZ5gakOiyqmSsrHIGap4At3FFXEA9RfN7nlvheO/uOlOaFb/KZM
X-Google-Smtp-Source: AGHT+IFvP5aIwJ3z+/leoDpJ79jPlLqaFrL8zNuZfa7lAitg2nHs31CgXOUh2aQIPKngZ3J70IMgTg==
X-Received: by 2002:a17:902:da8e:b0:235:f078:473e with SMTP id d9443c01a7336-237d9a770cbmr198290435ad.43.1750685484659;
        Mon, 23 Jun 2025 06:31:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.43.247.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d839357csm85480565ad.6.2025.06.23.06.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 06:31:24 -0700 (PDT)
Message-ID: <6859572c.170a0220.2b1ea5.fe05@mx.google.com>
Date: Mon, 23 Jun 2025 06:31:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1089631210998281598=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun_hu@icloud.com
Subject: RE: Bluetooth: Trivial cleanup
In-Reply-To: <20250623-bt_cleanup-v1-1-5d3d171e3822@oss.qualcomm.com>
References: <20250623-bt_cleanup-v1-1-5d3d171e3822@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1089631210998281598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974827

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.39 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      24.16 seconds
CheckAllWarning               PASS      26.38 seconds
CheckSparse                   WARNING   29.93 seconds
BuildKernel32                 PASS      23.87 seconds
TestRunnerSetup               PASS      478.54 seconds
TestRunner_l2cap-tester       PASS      25.60 seconds
TestRunner_iso-tester         PASS      40.41 seconds
TestRunner_bnep-tester        PASS      5.91 seconds
TestRunner_mgmt-tester        FAIL      133.12 seconds
TestRunner_rfcomm-tester      PASS      9.44 seconds
TestRunner_sco-tester         PASS      14.52 seconds
TestRunner_ioctl-tester       PASS      10.00 seconds
TestRunner_mesh-tester        PASS      7.39 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.07 seconds
IncrementalBuild              PENDING   0.69 seconds

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
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.201 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1089631210998281598==--
