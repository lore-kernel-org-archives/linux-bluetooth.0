Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F8117A2F3
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 03:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745291273; cv=none; b=WKQZSOyg1Y+vyiO5CXZD24KS5sRy8lxyKxJV1eRVjsnjQtfQDH4mgw8qI5ZWVpBg/uFTtPW7s9WgJq+NVh1d6tdskINzANdofTlEnCS2q7TCmGvOb+RnMMxKA9JzSVDkJru9emTnajrHAVp5VQM84AXQbh9uLf1yVRz8RGgJWv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745291273; c=relaxed/simple;
	bh=pqFxmtchXnaLj+x7Tkolq7FbXJLrXw9Nk3YH73ZhHbk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LLbYpoXcW4lupB+VhoOIsydymieVS4c1ilKbJe2sDHJZxUQWsPtc8yLePvdMPKoTDb8x0CUNdjVTq2Tsq3SQKleyEuizV3V8WykL9YHojRDEQB7YlADMSbNPs+Z//Rp5dd7A75291QVC7wfaO0z+N1TWnP56SR7BZgg42u6ipNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xyz4fzES; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xyz4fzES"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223fb0f619dso52113885ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 20:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745291271; x=1745896071; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qakL2V8/j4fKZ0cWZjTE/F8RJywsa9y3bUXqZvl9Hx0=;
        b=Xyz4fzEStx/gAvnl2YRPkxCi6BmANNbYPalkLLwVVDK7ZHwmidBrysUCwc89k4uaEP
         CQ74xlYAqa+wVWUBVlWZKJqT8nCoPdBOyWAHnm3RjhdSNAf/idnWwwYFa0CgF3qTe/dc
         6ywhlWjfLfPREzAc3NYle2lGIb3sZ60f9kIqWZ5CqC+JJt9XSkMYUfSfxUiX/OyUE3SR
         rRgW++IzeyJxcy14bHJ8ulbukMoMxleOB9hvF6r3HKS8x8/YmroVvcVpw23K3BQWs4GI
         H7++8gfZXNqMq/WbQch39VpbOw9mWaW84qZLuAcNn6oEjPBiSvJQAT/QgZYQEeJOsNAP
         FLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745291271; x=1745896071;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qakL2V8/j4fKZ0cWZjTE/F8RJywsa9y3bUXqZvl9Hx0=;
        b=hFG/6mwI7IY6loKrQZFXEapeaPtShFPh/ZgmC6UEld+u/hcztssy1HLCkcZaXzCdOK
         Pxhwxh4d/haB0eNHHWJXyjSsRuf1StFaxlFMHfiXAQbKXTP5B4lpM254rMtDghTOXsXQ
         +p13ZC21TljyzpkWxn+/q33FBguHf1ofX2XhJbJU20EA4xmsTLLXbukXCb5+MrgwvWwv
         WY0ykQc1T2Z9FFYEe30l6ER0YHmtxhs6dRQWZ60KGBSqsCFodJfU+YGbmZmb5MGhETys
         sdypYujfsbKNokxpm3qdqAeCpnKfW2/jv4bcLuvoNi45ChKGwCNtqpQbI0vlC9jlubr8
         No9Q==
X-Gm-Message-State: AOJu0Yz7GdkqyF27t6USUTHffRFrus5zaExzWvsA0FzriZRk84H8smSS
	IdizPL1X2giW+0mjk6+KOOJwNHbrdxYfuE95LfxU6tNtDgHxdChn+nf5bQ==
X-Gm-Gg: ASbGnct9eSqi/89UwdVN5IWU9c/57iWjnA7ciXt+KkF1+BiA7tFwcqHDxQCT+8WuJ2R
	vwN3vayaZrqbjDSI3D0o2gfDUb3pf1Y8p+MSwQjYzK1xj8cEe2oxm7/BRnT0si9c4IZZZxAsj8o
	btrZiBkBvlwHpoprQvWkTaV2DM1Sowvyd+WwA5f8MlQqCV8qwJ34YHAELKndLyuEswDzAFNzUc2
	CPFgk5znIIbo2Tb0vPLg7/AmWJZ9RtU9LR5XVbKKvVQZqrDiAKfWMxLMqsAzMnJcz3ErCXYZSmI
	GzmZnDdX/nh2S1RPYthrfAI43V4ifmoeqQnlxDRtBhkpVw==
X-Google-Smtp-Source: AGHT+IEUlzVMGOsGGSkIt0vic7uwoTsn/S4dExoLT63i0Fku5M+jD4KZly39q6K2XsW8YivFLOFCRg==
X-Received: by 2002:a17:902:e80f:b0:220:eade:d77e with SMTP id d9443c01a7336-22c5360c1a1mr217709775ad.40.1745291270947;
        Mon, 21 Apr 2025 20:07:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.43.245.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb48c8sm73047115ad.145.2025.04.21.20.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 20:07:50 -0700 (PDT)
Message-ID: <68070806.170a0220.2dc04e.5251@mx.google.com>
Date: Mon, 21 Apr 2025 20:07:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6536825857477293522=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtksdio: ensure btmtksdio_close is executed before btmtksdio_remove
In-Reply-To: <20250422012156.586600-2-chris.lu@mediatek.com>
References: <20250422012156.586600-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6536825857477293522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=955503

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.68 seconds
CheckAllWarning               PASS      28.15 seconds
CheckSparse                   PASS      31.70 seconds
BuildKernel32                 PASS      25.29 seconds
TestRunnerSetup               PASS      478.26 seconds
TestRunner_l2cap-tester       PASS      21.72 seconds
TestRunner_iso-tester         PASS      35.78 seconds
TestRunner_bnep-tester        PASS      4.90 seconds
TestRunner_mgmt-tester        FAIL      126.75 seconds
TestRunner_rfcomm-tester      PASS      8.05 seconds
TestRunner_sco-tester         PASS      12.70 seconds
TestRunner_ioctl-tester       PASS      8.47 seconds
TestRunner_mesh-tester        PASS      6.17 seconds
TestRunner_smp-tester         PASS      7.40 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PENDING   0.95 seconds

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
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.151 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6536825857477293522==--
