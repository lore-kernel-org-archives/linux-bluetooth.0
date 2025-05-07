Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD2D1D9346
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646283; cv=none; b=DvqMHJIfVN9F27wcGDuRTD/i69CCSqnYht96BWAgsleNoc09/e2xeyqGo2Jbf1yeEP+ZBun41Xzh9fgL3W+5gdqbX0LafNDdy06srTf+VyzIESQifArKtmfPLcOgHFu/bXrHIij+6eE5bI5fVa+ifvXZHN4VRqpFQeZ2PGmozt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646283; c=relaxed/simple;
	bh=azN4hk0Me/39aHEH1/xw5kRyXeGBtoixxVNRdam3kCk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=naLOoh2mSiQkM6Qd5TL3h+qhRnwdkoGhpvrVs80/emjdETE7GLxkWzfXN5IeE5C/Njevgv7+aMKDfHzAsxdjoT4y1xRp0tTSafRbNjutlS715AdjP69VFRxizt67Yn6WKPrkES8fD3o2HwvhwyYPcZM3atRMLTm6NAhWb4IuLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R23wE09+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R23wE09+"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736c062b1f5so368487b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 May 2025 12:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746646280; x=1747251080; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IYlzNvFS8HU0HZBNZVznuak9DJTj12rS/FLWrTlYQnI=;
        b=R23wE09+wWCvDsj0CCDu1bRIyO4ti30Rn11LhuWftLZ8mcIz0NEnHyjMNm0eA7aCMj
         HamNQGl7Glp85AvOmqLCNZeTMtBFE6q5TylGDwHDMoRExUy0PJjvOzka+m3GimrkKFxY
         Pmg8zphDYXzYKAe2m3oiacc1K9iTQeoY2v7id85ZFaoGaHHarWaLatkmpg2C8EbsfSKn
         onjKadUqeOdn0q4qKlPud7Ngp0ECJ7XKvYJaLRwFJz7zuWFuwiZRZez7q4kPU1GHM8Gr
         S7eREryKpPp9J9QUhPNHTAedKN8mmjxolFhEM0VYpD7uX1tkS4aRb3YYp1v7LXUkh9ZZ
         YKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746646280; x=1747251080;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYlzNvFS8HU0HZBNZVznuak9DJTj12rS/FLWrTlYQnI=;
        b=V5yh1hcmoqB6TNHUuiIKq0ccVSEgj2p+pSZXV88xpPejn/8hLZQoYUbZ1/1QReu0xH
         E0iaX7PaVruhpcT8CjrxpT2cmC6t1cX36/AQnIDQweJ7YuasmD3Z6BGebC+0hkqH49/y
         vDzBSj6VddfLGUsexnZEBB/oP1cKBMmsJbhoEbun7HzT6ZBzklS4RjiC+E380OvAyUq1
         5Mu/P75wWZVuhft8XloQPGtyRv6hlsGHQ/WB1y2296fhDj9HP5H4ShquJxi6FFhPftm1
         Y0oTphyU6kZ00d2ooc3i7pLVMRO/e+sOhxJ0XIrQBFkxxD/Cq5S4LtZUVAhoEH/o39tl
         MpIw==
X-Gm-Message-State: AOJu0YyWbZMOlX+0RlLQ3K7iO+Vo88Vr0KGwuE76HYDAOXxH5c7aoiuC
	v2xjOyf24IA10w8ROsgEycTNu+dPTGBli8q6/2czxpl1nmRq5u/eHzb58Q==
X-Gm-Gg: ASbGnctV9wyEbdKnyxWrEs61Y3oGjnB5ATntJoyEfG6c2pzxeDuZcVq3u2LnOem++RT
	MSXXN2V9xfVZQSxvnUlr13JLoGy/pjwsH+Uo36lEngR53yi2xfZW5XB2ydKaYhdzXyW59o9CbUz
	wkEiutb7ADOoR/WO0V/9KELUQsozydyswmzjWSim4j0RVfHy5VWp6mCfKo6WWWhnNvw7ztXePjg
	ybV8byjb7WBxCERpPhDlldz2LhRJCrxPEV7SU5CNStMFvx1c3HkAQs1fehQ06mEsMNAe9lAxa9A
	+2U0MIpQuGDWO7MCgcmrujeRMfvPS2TaGPYeHwb9S8/sQQXG
X-Google-Smtp-Source: AGHT+IEjqujEQ4lPAhXNtjKYORb8oOeyicZpj+lUuphPB/u5zjMjUowf6QPzoI6vo5Mt8RsObPWhhQ==
X-Received: by 2002:a05:6a00:f8d:b0:736:4ebd:e5a with SMTP id d2e1a72fcca58-740a9a97ebfmr822126b3a.20.1746646279913;
        Wed, 07 May 2025 12:31:19 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.140.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405905d011sm11614906b3a.121.2025.05.07.12.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 12:31:19 -0700 (PDT)
Message-ID: <681bb507.050a0220.23c699.2c74@mx.google.com>
Date: Wed, 07 May 2025 12:31:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0676246554573150022=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix not checking l2cap_chan security level
In-Reply-To: <20250507190533.289009-1-luiz.dentz@gmail.com>
References: <20250507190533.289009-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0676246554573150022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=960627

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.54 seconds
CheckAllWarning               PASS      28.27 seconds
CheckSparse                   PASS      30.24 seconds
BuildKernel32                 PASS      24.13 seconds
TestRunnerSetup               PASS      461.95 seconds
TestRunner_l2cap-tester       PASS      22.44 seconds
TestRunner_iso-tester         PASS      33.85 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        FAIL      118.66 seconds
TestRunner_rfcomm-tester      PASS      8.13 seconds
TestRunner_sco-tester         PASS      13.05 seconds
TestRunner_ioctl-tester       PASS      8.28 seconds
TestRunner_mesh-tester        PASS      6.10 seconds
TestRunner_smp-tester         PASS      7.17 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PENDING   0.63 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.167 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.189 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0676246554573150022==--
