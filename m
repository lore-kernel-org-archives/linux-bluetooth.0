Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E872D9EF3
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073575; cv=none; b=UJfvyY08NIx9uXECRHFW7M+qAuw0amaWRHvCdcPX5Do4qS10k+31fN9yfQ9b/H9rUOYzttUrMBCYuncrcgg3+2PYUX6cL5LUb/+/VGYb10+VeKRt2GHbzhHQgmBoSTziZAH32y2PptfvvE07YZo2sFRAS2oiN3QiMyt/zlfsKm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073575; c=relaxed/simple;
	bh=uxNW7g15+YlPH2g7BJi0zDqUQnLwfCdC0jdUpXXu7VE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Av1ah8xMAgXRxfDlCybnQ8XCYI26hfOXfkcb5MYrk4OUk7a6xCT9T2nLiqOanXcsEcxQ2jyDGLDGK8sbE4F9vugv+P63o9jzA5o4npjyGt7gLomnGaF1NkeF3tWimCojb6phcmjKX3W0xPOhKgK6uwAVeTAKr9hjra80KYKRIyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQDwYe4A; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQDwYe4A"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d0a47f6692so490093585a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 04:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750073572; x=1750678372; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3UXLlY7l+zRLeMPjAxJXZIXcXGZ5orUwuWfSF0uG6y0=;
        b=jQDwYe4A0xoWhBVOvlS8ahir2S/zhArCVF+apmhusddCyVObnf6AKFP1/NOjkINaVh
         7yyMWN2FtAtASx67G/d0QEvvCb+pcBmgsUzkGHZhtbWXNyxAYpPok2Gsb4j7rLqOlDCo
         ACm45OiMyd3ajiPrv44tpxxqzPpQUCUFqeNSrt5bhabPJtQ9TsVH8aHiD0bL7F4yAw1Z
         0/zvvZpGwf06adI01nglN9K8qykUzWSvwnBkdWr7F8LGUBYfnGrhDWzE99IQ5wnRirZv
         OAifiwOP0yO1AuoXriRnHRqBCvM0tJ2sjLqYOEtO/aFr3aEkAQOQ382WBKzldslI20B0
         QrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750073572; x=1750678372;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UXLlY7l+zRLeMPjAxJXZIXcXGZ5orUwuWfSF0uG6y0=;
        b=Cg6hLMZA0c3+Dh9kdjofRSLmcv9+UxDX4s3yeWetxJpG8nrQai7S0ZO6YMKzBcAkUC
         X3kE6ce0uJHnBSBx+6DJF39cZ2g1YLpracMELNnokqQXX+cq3tU83KQhOtaVAkU1cXia
         sZmuxTZV9mdWHYWi0CTaV24fGnBy+/UsO/iivZCBtoLEjicZ+mANV0Q3PQMr8684J6aV
         +F4u//qHJeItuDlg+hpni5FLO5t7uVnpP34vD9EOI9+fbVP3wtY3MqfyonL3YO5jNZ57
         +Mp9ZY5GljHqM9rHkeYDLWSs+7db/jPY0EXKgzRlXqhdpag+BHeduR1cpLMOwqKLeApa
         YEEw==
X-Gm-Message-State: AOJu0Yx52Z1knhOdE8/MhIZX9Qc77DQn32i+EBwzLItApfibLsZRH4K8
	LvMVHA+BRQYAr0DWGXWpr2Xzvfo6MN97Va8rnpm1tPQjXcGMReO2/SovBjZAxQ==
X-Gm-Gg: ASbGncvsBRJ1RZnwHTzsRuETvqeakqkPtpwoH409f88VaIwd/KwAeO/Zv0dcCsK0bvg
	fNlvLhgg5Wfl19mjLwMZ6biEw6JV9QrsqsmhCDJyvCyEz/BUAP+qjQ8tMQJEkQ9sHIzUgcLmffk
	F99ZUkRdKdrXTwbOKPCq2HB5oHX0zSncyUULovy3ySrcx+EfXJFJhU6G0BKouu6p/9Kl+OfvWL1
	wsFTbucTlAExqYwZhPYMwN2FW8NhFkZ76SApcrkuZEdiWPN4UQ4GNRmYnJ4uo9f7bMFLI8gV9wb
	L3rMXz/P2cWLzDAtv3LxxTN5ohIuMbGHx1ksaUFXRDEchDYvd99EuxyWs2D2ahL0RQ==
X-Google-Smtp-Source: AGHT+IFUuVKZC6CqagzUOqwpfnXVcWFCbNFK6n5gnrnGpGcsL/ql5XU5aV+tu8FtL9kzTkNOp7qTEQ==
X-Received: by 2002:a05:620a:3946:b0:7c5:4b6a:d862 with SMTP id af79cd13be357-7d3c6cd9e70mr1251013785a.33.1750073571936;
        Mon, 16 Jun 2025 04:32:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8f20f08sm511113485a.112.2025.06.16.04.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 04:32:51 -0700 (PDT)
Message-ID: <685000e3.050a0220.2cab6c.2269@mx.google.com>
Date: Mon, 16 Jun 2025 04:32:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4169927880414320962=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: Bluetooth: Prevent unintended pause by checking if advertising is active
In-Reply-To: <20250616-bluetooth_adv-v1-1-6876bf4e85b4@amlogic.com>
References: <20250616-bluetooth_adv-v1-1-6876bf4e85b4@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4169927880414320962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=972465

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.99 seconds
CheckAllWarning               PASS      27.37 seconds
CheckSparse                   PASS      30.84 seconds
BuildKernel32                 PASS      25.07 seconds
TestRunnerSetup               PASS      471.95 seconds
TestRunner_l2cap-tester       PASS      25.80 seconds
TestRunner_iso-tester         FAIL      8.01 seconds
TestRunner_bnep-tester        PASS      6.00 seconds
TestRunner_mgmt-tester        FAIL      135.31 seconds
TestRunner_rfcomm-tester      PASS      9.67 seconds
TestRunner_sco-tester         PASS      15.09 seconds
TestRunner_ioctl-tester       PASS      10.30 seconds
TestRunner_mesh-tester        PASS      7.47 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      6.38 seconds
IncrementalBuild              PENDING   0.44 seconds

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
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 480 (98.0%), Failed: 6, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 4 (Disable Adv)              Timed out    1.882 seconds
LL Privacy - Set Flags 5 (Multi Adv)                 Timed out    2.149 seconds
LL Privacy - Set Flags 6 (Multi Dev and Multi Adv)   Timed out    2.006 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.231 seconds
LL Privacy - Remove Device 5 (Multi Adv)             Timed out    1.986 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.174 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4169927880414320962==--
