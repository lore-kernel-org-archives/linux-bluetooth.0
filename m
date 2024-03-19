Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFBBF9FF
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866141; cv=none; b=Gm3mRovDBccRxWlyZ9gShpzE5yH5vTnOlXvapAQzeJm5H8V17wwyFWP8W7MQfZI0pd8Jvce/biVoAnvBVNuRZ2V8HYTw78VlCm9Cnz4DPinXSHYYrmcuG01UsxTbRF2iTElOVXO4nqUyy40KugphE4UJ1pSheIOJ9DFQ0dZ32Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866141; c=relaxed/simple;
	bh=v2u1Qkew2g6O7OxfoOPpZ+WZyFkaJ/IvZtu04Og6awY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ppc2GI9hvP3xciZodqp5UCYveJAybYOGjDwuK+BdXbBywsLcRnBXtKUDgHabgXvMEVxrSrc8uG5VQI57MXfYCs1SgE89njlSp/q43BtfB/WSe4EfrjJWBJCzgb2UhKutp3ldnj8ch57vtrS18rNtnYoUm+K9Jt5F7LPnG3NjYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njGll/Bj; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njGll/Bj"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-690fed6816fso38347696d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710866139; x=1711470939; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jrhm2mahM5/boUBm/NzUHVftT7ZLwFl/o5aFGA8qqeM=;
        b=njGll/BjzzO+IgOU+3FkEHyueD7hmKx+d6sjT5JGSQ3Kt3e9qaRTHZ4ABc9lTNnX9G
         oRVLV6Bz4wvgt+58cYDDgR4Eq+kMBFFO/ZulJjoNXqvoKj1byglTOuj4RmFnsgmEbqeA
         EQ2CdGPN1jS5ki797fnOK1UpTmF5WaB1o3sLRd/jI0Em97Jc/h7HjJawtNuQIzu75fc2
         x6wdzwo6NvQ6Uc+XJcFeSRK/jedLiEk3HKl1fTtaavJT4b8XeI1JtwCiBB1fe9+s7C5w
         QenrtwPZNIiuonFIX8AwiHb11cqFm4bklKSVJpOeplbNhFnGJ8ZxT34lGWjGMtKlgQHD
         LLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866139; x=1711470939;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrhm2mahM5/boUBm/NzUHVftT7ZLwFl/o5aFGA8qqeM=;
        b=cKBULZI3eaQN735yxyhdbZal7ftABW3KzGR9r7XLHXfqqlIaVtuhnuVYZ6hXBMS5/0
         NGzpSFL++KlV1Y4YkiFjYrAg4dyoSF4ouo0+iG2APBW6wPedk4qq5ovnL69/39S1dulb
         XFdbgqSARyzkm597CG0sKRw+HroVxw0Z+bL58y+N+2AqhLrb1nEHfPCkyy5H4V2QWWqm
         olSxD4Y3UPoAmzryu+74jB6GZ51vTq1rb0IoVA2FD80bF+lbFJJ73D/pWppxN52lvnI9
         sOQWR56WVLKctf70jIs0/S0O1qOiSDD8tIDX7qW9VvEIxAuDg3/9ZqdRgHYXUCYUY4MY
         Gx2w==
X-Gm-Message-State: AOJu0Yy4KvFK62E+egEeE/kXqn6VN1VwzGgJqu5EIThvhRLRhG3pDKQL
	pcFaB23KlqjxDq5oillx9ve2gNwxuILE1dEvuzi+dS0lS/pTfLGSs+M+zl3n/VQ=
X-Google-Smtp-Source: AGHT+IH2rf+d0fzrKVMJU3GEAhqQtJtHoGyV2ryaugqg0X80dyOgGWsc6K5Dzgu4o/jl5TTRSOT0GQ==
X-Received: by 2002:a0c:e14a:0:b0:696:1ed8:4672 with SMTP id c10-20020a0ce14a000000b006961ed84672mr6025556qvl.13.1710866138651;
        Tue, 19 Mar 2024 09:35:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.159.35])
        by smtp.gmail.com with ESMTPSA id r3-20020a0562140c8300b0069612ee6742sm2995654qvr.14.2024.03.19.09.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:35:38 -0700 (PDT)
Message-ID: <65f9beda.050a0220.b12e4.df35@mx.google.com>
Date: Tue, 19 Mar 2024 09:35:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6616238374105979427=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: qca: fix NULL-deref on non-serdev setup
In-Reply-To: <20240319154611.2492-2-johan+linaro@kernel.org>
References: <20240319154611.2492-2-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6616238374105979427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=836459

---Test result---

Test Summary:
CheckPatch                    PASS      1.37 seconds
GitLint                       PASS      0.68 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      28.52 seconds
CheckAllWarning               PASS      31.44 seconds
CheckSparse                   PASS      37.17 seconds
CheckSmatch                   PASS      100.28 seconds
BuildKernel32                 PASS      28.14 seconds
TestRunnerSetup               PASS      519.52 seconds
TestRunner_l2cap-tester       PASS      20.20 seconds
TestRunner_iso-tester         PASS      30.52 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      108.33 seconds
TestRunner_rfcomm-tester      PASS      7.41 seconds
TestRunner_sco-tester         PASS      15.08 seconds
TestRunner_ioctl-tester       PASS      7.89 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PASS      32.26 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.202 seconds


---
Regards,
Linux Bluetooth


--===============6616238374105979427==--
