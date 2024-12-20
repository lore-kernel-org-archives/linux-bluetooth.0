Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D41A83FE
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685201; cv=none; b=M6B14UV/MhrojwpGw9FeAJ0Uv9hV8AjF7d1P5zstn+uZWyrFNxdRXmZk/uvT7YRizpLprs33vqrQ7vq+doNQ10fHWtlr7Xf02rDHA/J59KAYFnNEK9kntuab7K9EzWivgeFf4NDSTtwT242nawd9wGYw/6Ly0aEW/GgjUFdM8vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685201; c=relaxed/simple;
	bh=zXN+0LdZx5tLpp8kapBz/OoDZgMBJiY1z0dQ0BKMPLI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NInJ65r6hAyHkeFASVHrfjfCckMhlgnDO+IaxEyMHmDjpxW9Eg1H0i8DPOrIgQWLqZbTXvhJ7+Kx8QLL6mHSaWJpfwzvdeDC1fea2pU2yGcxKt1FfAN+gw2b+m5GZiTsfGruTY3WELESyH0gUp0dGVJlfjXMtlFy3AoTdCA71cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uzvgol0S; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzvgol0S"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6ea711805so168802285a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 00:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734685198; x=1735289998; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8SBNwVrl3/pldwFtLLw5ATyunnEqaf5YckUCN79hESQ=;
        b=Uzvgol0SIWYjyPR7NZ016ho9Z3U9fi4z9O0ElCHL6d/+oB7fOcY5xyMaTap3j2WCQ1
         gckwByu4nPwn0zDmlMmSAXcn5JhPFyb63WOORwklvJwMeGziP45bigKCr+HqCYG6LIkZ
         3rJ8JwpM5LzTOT8hxNJhzuWgFXDcFVZP8RtNIX5S8D1RLEVO58Dv3sd4xGhTBTUPQBXH
         7DGX75CuzRBObyC0/o17ZZ9p4dzPvCaS1UOPrFQFWcO69nbvioq6JrklQ6gNI+fJPGrc
         LhM2Fv3tbu8reQtIAdrhssj+r2VUzE8NRatOBMTfDsVQMk9WY5jf0ab3zfBMXhLaWDuf
         OuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734685198; x=1735289998;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SBNwVrl3/pldwFtLLw5ATyunnEqaf5YckUCN79hESQ=;
        b=kdurnx0iuCSOVrsxKcHlKlVBhZhohKcr8hqlSeAK4PWUplGCc/WPVBNm+ZJO6snEvz
         OJsuHcfGKAKLgS5JlAT7kaS6WsTBTRg+7lbFa4qnTGEAEXNPqR89VUL5OGRgFuRZB58I
         xp+ZdsWk1DzTqV9/8hos9ytfJS7Y3XP2CPQEJ4elItnC2NdZFmgSYIWv5UMTxvI/5j7M
         zrMHTCBD20r0mlCgHMUe2CC1D9EFrzdkeJjdxdPfwHgpMEPoV545PaF4vuhwBbRaapp3
         SA5YS4wmTvuKC4x8adllO3dBM6mwHLmJ3/MDK5+y+R7NIHOnLv+EjaYUwSKD/BRpcvUk
         qtcw==
X-Gm-Message-State: AOJu0YxewHwAP/HEwnzlcYOo+b+S6GgYz4n6tip0TZqjB0XIaZGD1eUJ
	vwQL0JY0Z5T3GorXapU9Uu/XNSbLoQlxwuE6rFYW/gNHwBEN2vfVqUwFlg==
X-Gm-Gg: ASbGncuX9TXB8nGYXevZdOW9x++Wc4YmqLcCubd9gPCCUZWKooxRZqIk0KWedmi8fkV
	ahEJCLUhOjif7Pns3G7kA8ZwDSUxy4tQj5StYWpylnFqndGW0CmAPz/2KI1HfcI0hV8SeVo2kuD
	srOoukwoobHASTIPuwKwt6tqpWvZrpUaq1CTRlsvUE3+bMsLpTaObT+G437FRJZQ0J/U0r5Dmi2
	WoD12KFurO4TqZX5Ij6PB/EfZz4JKyc1KlFABlVOWshZezf8IaP5L2an6JmNA==
X-Google-Smtp-Source: AGHT+IHDK4VrRrsgQxFQ4y7A650n5VybUg2e3m0b0kmSCb+jPpbO+hf1ojIKJORZ3yV95/aPqDxPoA==
X-Received: by 2002:a05:620a:2447:b0:7b6:da21:7531 with SMTP id af79cd13be357-7b9ba717e7amr320399085a.4.1734685197939;
        Fri, 20 Dec 2024 00:59:57 -0800 (PST)
Received: from [172.17.0.2] ([20.84.127.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bc85fsm117877685a.7.2024.12.20.00.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 00:59:57 -0800 (PST)
Message-ID: <6765320d.050a0220.37a044.47ab@mx.google.com>
Date: Fri, 20 Dec 2024 00:59:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3422644251000780421=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, en-wei.wu@canonical.com
Subject: RE: Bluetooth: btusb: Add NULL check for data in btusb_suspend
In-Reply-To: <20241220082225.1064236-1-en-wei.wu@canonical.com>
References: <20241220082225.1064236-1-en-wei.wu@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3422644251000780421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=919766

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.74 seconds
CheckAllWarning               PASS      27.16 seconds
CheckSparse                   PASS      30.42 seconds
BuildKernel32                 PASS      24.28 seconds
TestRunnerSetup               PASS      431.76 seconds
TestRunner_l2cap-tester       PASS      20.16 seconds
TestRunner_iso-tester         PASS      27.65 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        FAIL      117.86 seconds
TestRunner_rfcomm-tester      PASS      7.58 seconds
TestRunner_sco-tester         PASS      9.62 seconds
TestRunner_ioctl-tester       PASS      7.95 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      7.02 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PENDING   0.66 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.210 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.142 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3422644251000780421==--
