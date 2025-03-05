Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCAF14A09A
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Mar 2025 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185148; cv=none; b=u0TOJguSK5ZU1863i2AYyy1DPcr+mxtnxcGyjTN5jwqPGvn0Mi4P//ca9qQcnunXZ6DGDaRsCdhdjoSvICwfNCyPqp7RMKLwRUkxrmq1IQH4dwnm6yqUEGZbLwr9gJYqPCCo5euETgThuCXAxF0HVkL9yNhf01Wxflb0wsRl3Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185148; c=relaxed/simple;
	bh=iObRUH/ErImbwKzLtGNfTIjKN65uk6Eo3S+8MXs1DQ4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jaZQgoWlRcNl6Vmur7ZBG1T0rVms85yTZ63a8QXyAidePK6QMOSbTZuFN2oAvPB7ybm+P9/XeNv9NrwxSlb50kAgKVQp6xtHz2K9gPTKqmwOFebtiKK1LjiMLcJg9WtbNsgdSNjTLklh8k1FxUyx8aRhiMSdoHlG55KUzKslSVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXFIeJUW; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXFIeJUW"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7be6fdeee35so1214132585a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Mar 2025 06:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741185146; x=1741789946; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2xYZ3ZgsThht9lzv27LYcwyowsXp8PiTD5A9AIQ64Io=;
        b=kXFIeJUWu9TfE9wWeCuvRfKn97t4c49+WUYn74i67mprYE15hRKwjpKG6mehgx4PTT
         wr0iZliHGL8MIGmtNwBwKJlyTqrWM4zA9Hs3UEiSxSyzQpK5sHcQhIFnbwHkwGBIZZZK
         FbBN7/dZNCSB4s0EF90XPt6Ge08HIpPFahIYCXBR1oxKePsNnurAZJHPPXhuKdrojBIN
         GFv2biIxWw9Vtsq1WFhLSomtRGUH9v/4IYZG7WPsiV/b34zD/QvfSHkuDFXuc4q/FowQ
         tsO1xtPGLP0pUhNaHNTfiSgsDYgaspJNHzybQG5XdWcIsHfl4jYG5Ra5wJKICc22tY4g
         UdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185146; x=1741789946;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xYZ3ZgsThht9lzv27LYcwyowsXp8PiTD5A9AIQ64Io=;
        b=UBKopgAgdbwoAxG3mbPXUZtvbAOQeln36DQmvXAHOi0MHsWH+z26utbbMMMIgt4OGS
         yrsPkIyHDrkMSFNgwSoKQ7ePkSBh4UrwOYLu9b4eyzKIu7wlP1eSm92dFU0DRqz4v6AN
         85ksKH233djz6dPBQ5Kbs+KZR4FsPqduXT9agxcArfz6WuF4RlVyIuR54ujyFHC2jD2c
         vGqLW+thoXpUgnRQJE2K5KymkCogXrhxo03mK04r2236AlnBxapHBnkHij8rOyZU95g2
         pPyVugL3JIaPAgcCHSWIDAqSaD394bZ8J1t7HAB4zenq6k6pVZirBpdgnVQ8EHVACmUK
         i5bA==
X-Gm-Message-State: AOJu0YyF7J3R236wo8ZhPbt0++Bk2PNf4q7MZP4pBahP0VGCgL/Bfjk2
	W0rlZWGQl/mGEsiE5UpVBwchIhi/sJhdHs+OnVRjTFBT89PiVzmx9UcYXQ==
X-Gm-Gg: ASbGncsR0Afep2Vx1vxAqxJKNGst4IE2UzyKqPtZGw/mkiZ9r+dL3sE2U/72EyrQfAf
	OptEi27g6ejYa0oK4litiFDSaN66o1m3GmimiEhBhNELMDJ/liFRr/+Z3D7uhlK/WKtZnYmBLQ1
	bNiWwJsqSnhgstaUuboLun6GtX8DCcaKqIqJjldBPvtIvXug1uxc2sQxcENsHuYu93Hob4QRs5a
	dApNQ++Ws6TFA6R9B4BLjZCGvS5owOPJeYD/r1oGdWZEzZDhcRpoq7t0HI5H/1qVpoeqp0PlmTe
	6g1bzYKBbEgkCqtCIrJ0wCVBAOSxIz+O04SGYP6KoZNXwhPBPaM0
X-Google-Smtp-Source: AGHT+IHXJgDiC61JqwQFV7/Qpgye3kC476JPsXaJ5HzJDgveiSlmkRcskdjVYXr5lyGsQI+9Rj+jog==
X-Received: by 2002:a05:6214:c6c:b0:6dd:13b0:1008 with SMTP id 6a1803df08f44-6e8e6d186d6mr47382676d6.30.1741185145727;
        Wed, 05 Mar 2025 06:32:25 -0800 (PST)
Received: from [172.17.0.2] ([172.206.108.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8ccdcf625sm37039956d6.103.2025.03.05.06.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:32:25 -0800 (PST)
Message-ID: <67c86079.0c0a0220.2e705d.c439@mx.google.com>
Date: Wed, 05 Mar 2025 06:32:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2767689263055861214=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1,1/3] Bluetooth: btnxpuart: Add correct bootloader error codes
In-Reply-To: <20250305134523.40111-1-neeraj.sanjaykale@nxp.com>
References: <20250305134523.40111-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2767689263055861214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=940577

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.37 seconds
BuildKernel                   PASS      24.33 seconds
CheckAllWarning               PASS      27.34 seconds
CheckSparse                   PASS      31.42 seconds
BuildKernel32                 PASS      25.00 seconds
TestRunnerSetup               PASS      439.62 seconds
TestRunner_l2cap-tester       PASS      24.90 seconds
TestRunner_iso-tester         PASS      31.96 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        FAIL      120.83 seconds
TestRunner_rfcomm-tester      PASS      7.88 seconds
TestRunner_sco-tester         PASS      11.66 seconds
TestRunner_ioctl-tester       PASS      10.71 seconds
TestRunner_mesh-tester        PASS      6.13 seconds
TestRunner_smp-tester         PASS      7.20 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PENDING   0.94 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.197 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2767689263055861214==--
