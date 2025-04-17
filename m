Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F379F2
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Apr 2025 04:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744864741; cv=none; b=K3tQ76h4b5RS3RRJ4c+l2/YEa7pyciEMxx6yn1EaSIEaMgMHovokqrfIR9o1mjTKUakjKDrxFZnnQpsFZKLHWC1mSklYlLJ64nBayiwT5ttwJ0XWedclKQfTywL1qhysBSQAT3fAxkFn8eJYcQMoCtJJ0Vipz2ACHvjdogDC360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744864741; c=relaxed/simple;
	bh=MsQOMD8WbO2D7zODhRxKJdr9HX56IR+yndaLw+GPFFM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E8gezZaCNIo3GFJ+Z0yQwfUCd5U5PMdk7M8cx6zh6IPKg14x7AjO6sCPQSpiFSB9KUzO5KU+WAHBHv0wj+c5pbQMqLr8SDDNDJ6nOaBWj1RNN5fdkhegrxdHnhLFoSjKt5DsyrwAkvw3NCG4LufpcKROlL873pSdXH+ONX5eZwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KH6NDmRW; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH6NDmRW"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so2923116d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 21:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744864739; x=1745469539; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PYGodvG0SqzwSjNY1SVyMOPYWruHcu05imrUFQiG0kw=;
        b=KH6NDmRWWUBVuqO6KplfoojR5MtjR/ArovmBBRcV+EGVBZky19Sc3pgX5rDcVTqErB
         2fJ1Q051N6y/olURhdGl4c4cTsKYuXvBwjCj13940ULM1xEQ/hHmGC15FpZ34LAE/BMm
         L6yWXzkzDQ7oaaLdSOz5L3FxYRC5oACiOEFYyUeRVuscQLoKz8d4HvkZKURGhWbgcOKv
         rem2tkHBzF79yLthwGbVZJ3IDSmtFap2C4pOVJus29qh5qmYQAgn5vi0Ji3WIXxhssMJ
         lLz+/j59EVM9yMl0IiU6exXPWYSeq/UMuvySXHlGBbCeWQS0t+YzP8ns66hWf9bv66Ej
         lDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744864739; x=1745469539;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYGodvG0SqzwSjNY1SVyMOPYWruHcu05imrUFQiG0kw=;
        b=VrrPWLl7Oam/tHTCy557GsBnRb6CaDzFvLu7e6cAQH5mqBiQI7OcShkZGot1Pzjflq
         eUqZkOvgHDKAdHh7pvjT6jUOuXn9huhWAguHV9NIzZxcXjHP0W2JuuTofvDUEiBmhocT
         0FjYpdOiZJ/W+UMzCrjXuItGF4nbYXWrqe9mFeYGdnFoZtv4tMd+iJG9mai/gwbiITzy
         nAe33xo0B8g4EHrX1sQb1hbp0W0tnvqMklo25haoEgjcwesLBk7sHnWqPkmpkPG4zYtL
         7fctGNg/XgJz+fhw4F4mcjxooMU46k9pBy1i7gIyH1UjHouVBKdY5yUEDrWoYZDiLiyZ
         CJHw==
X-Gm-Message-State: AOJu0YwCGgehxMHo0usEWv6E9+JJPI5rLLq7sbkqWH6Bi+JJ3MjvCKBK
	7SXDgWR3+18Xx+ExjTaiXC3tdI7VOmDqk7ut+mIsqE6eDB/PrwNOEccTaA==
X-Gm-Gg: ASbGncvpqRWuNiL0HFvqLjE195S+7SGpSvNsPyl3Lc/aTn3YY04mvW8ky1d1tJlAZNd
	WlYyT8/KFhXkM0zpO1cbjX05+I4z1bKrGUiRMxSyaN3bbcb7Y5ArIZTkX13FH3ML4ZA6/MOOxzV
	W6LwbeC+X6TlKHDmQ8DxzSVxZnYeaYb7AxpoLjYgTx3nPdLKNCqp/4XPIyNnq/mne4v67V+4cv/
	pQQezahzW2TN1oegS5U9nFhGXzkmx58boLoKXX/F6OpMRotTD0TnLSfSkSZCiMpyfgY1b2MtIDe
	xDe83vtj2vJWr/CK3JAK71PJCVQAg72eFPpLG8xeHdTeQvs=
X-Google-Smtp-Source: AGHT+IFchATcafhIyiCiFdIFji10wQgOQ/ZQaq5WBgJTQyykWRacZf8kbctq+lSpby6YwlOjfYcofQ==
X-Received: by 2002:ad4:5bc7:0:b0:6ed:126b:a15e with SMTP id 6a1803df08f44-6f2b301b8d2mr64230786d6.33.1744864738699;
        Wed, 16 Apr 2025 21:38:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.77.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea2160bsm124287326d6.122.2025.04.16.21.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 21:38:58 -0700 (PDT)
Message-ID: <680085e2.050a0220.20d0fe.1dcb@mx.google.com>
Date: Wed, 16 Apr 2025 21:38:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4304865878356543554=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Avoid redundant buffer allocation
In-Reply-To: <20250417034842.165796-1-kiran.k@intel.com>
References: <20250417034842.165796-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4304865878356543554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=954259

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.66 seconds
CheckAllWarning               PASS      26.92 seconds
CheckSparse                   PASS      37.45 seconds
BuildKernel32                 PASS      26.14 seconds
TestRunnerSetup               PASS      457.93 seconds
TestRunner_l2cap-tester       PASS      25.54 seconds
TestRunner_iso-tester         PASS      34.66 seconds
TestRunner_bnep-tester        PASS      6.88 seconds
TestRunner_mgmt-tester        PASS      136.85 seconds
TestRunner_rfcomm-tester      PASS      16.27 seconds
TestRunner_sco-tester         PASS      17.95 seconds
TestRunner_ioctl-tester       PASS      17.29 seconds
TestRunner_mesh-tester        FAIL      6.28 seconds
TestRunner_smp-tester         PASS      10.42 seconds
TestRunner_userchan-tester    PASS      9.44 seconds
IncrementalBuild              PENDING   0.72 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.119 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4304865878356543554==--
