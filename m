Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD8C19ABCB
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jan 2025 03:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735875951; cv=none; b=JzfSCDIKPRCQvZQ0ce5s2EPPNucjqRizc+Dp5nNcUub7RenF53zPv//fokfjPxI4NzLJARu/4SwUfjnGyC+i+0QcSfyeazFvkVdCH/GTkil1q+COuJDk3TOaTyJv1j8JDO/QOX9e3eUriqQqNU5bZJU4uRQYui46qhUs330eGqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735875951; c=relaxed/simple;
	bh=wZpvgKOcq+bjqQVDiFltUuUZtFiQRrVB/9JZcVZ602M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WXtOxHPeOBAx43YTw0lpv16QkdY/1gxQFNopYu4+6YHIOrLJ8k7yRLXqRQSE68cfEvw+9MbBtvowLX3JTX+9TXvLZwW8d4UwI/RvZIIM4tnapIOZWNkykCYpMGidnJczvJiiBAznWMEHjL6f2t4kXZHxLq2sutrSSdEndrQqaEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4XAOHTJ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4XAOHTJ"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6f7d7e128so1102807385a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2025 19:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735875947; x=1736480747; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lThtqdfc5PfenME6MG9AVPEObDWinWqpDSOhzYFcBew=;
        b=l4XAOHTJzOlajF9u60sjDOcWb20HvHi9y4HlBF6W3QEnZiajQSD+KRQ1VnGRk1nM5s
         ZhROsvjUVZViWoyLe/nOraeFcgTKIdvb6aRoz4GaAa2dRmuTjf+g0TBq7wAw06Bj6lnF
         WHc6k1tOLX0wa2z4HMeZ/DuDFGcFdop4/2OAT/61NZhVKCwvTtLNdxjSqK9pZ0gBOjmW
         vxsW6bufgBCxhaTXp3S4KC9kA9+baYVt0896hSuJ6VL3nkgTMJNfAqK449I/qVt8K5ak
         21io7pHWMtQGElDijIM1Yr8aHEMz5GzD9E1h4e1BoTshKR7wz7EMDanvKEsVOyZNJ7UJ
         rBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735875947; x=1736480747;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lThtqdfc5PfenME6MG9AVPEObDWinWqpDSOhzYFcBew=;
        b=fVq/nHCQ7shLFxegJ9+soH0UNcqKssPhW4c/9naRFsiJ76CT7DfTRcyeakZ4yz8wui
         2EBNRSUIgO8y9Yw6Ds88dEFr9qIWaSCtjR+nQjCiuE/ukb/I8yXTZ/NGipcHDbWNnGIe
         glrPTh5po//+cbl1VDSXxw9O6xRLAMYtgQLaN4KqEPCJUskRAbWHg7lG7I7nuNMQYzPg
         NZc3J8R5OCpLb1ZMjAexwEwjhx0usiOclLon9J1MpTxnW2bxGKSq0Fu+8n/sH+qcApLK
         6DpbHVQtX7gq+CfLMP/Aye1IqgeE700A1b+rMzSUMvcnQAfx+ksdcDu7RqDHYCKv0Hz3
         GC0Q==
X-Gm-Message-State: AOJu0YxgcLE/ds4fnQ5zWJpGK3F6NbnI7eOfr420CyIZFTHLFxZ2yaUV
	92VoURHX44YiSn3THIZtYZ2DGOyb0fcLytXWxwEk8mIJqnEhq5mJm0W7bA==
X-Gm-Gg: ASbGncukNMGJeqfhQb4vy2g3M6WZm2UOOUwhASHm57TJOVab0vLEFt7yE4AaRpVw2l6
	ma6wrnhIQvbUIz/r2OZjrEAlakZCewQdk2nEz0tDc7mDt0BZyaknV5TF79zUBKcvyILcW//5+Gb
	ZNaOiP5/9No8Sx8+dzwsVzgykU9vtb7WYS9rURl97APANxmJ0GpRBtms1KyTB6HmMyS2ydjggdu
	KSJOrAyo373OuU7TBjNEm/wPMZsfukEwOBfxJShV1TYoK+0VqBrYJnNYk01Og==
X-Google-Smtp-Source: AGHT+IEupXUwJ5lKYuYCxMBjvq97Zm7LXq0dTjGLj+Dgre8wHPwZnkts9YT6MtVyX/gnFIZHQ5rK5w==
X-Received: by 2002:a05:620a:4104:b0:7ac:bc66:5efb with SMTP id af79cd13be357-7b9aaad5e1fmr8038422985a.27.1735875947477;
        Thu, 02 Jan 2025 19:45:47 -0800 (PST)
Received: from [172.17.0.2] ([20.161.78.55])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d5638sm137218906d6.117.2025.01.02.19.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 19:45:47 -0800 (PST)
Message-ID: <67775d6b.d40a0220.600e1.a63e@mx.google.com>
Date: Thu, 02 Jan 2025 19:45:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5657391822182974639=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@chromium.org
Subject: RE: Bluetooth: Allow reset via sysfs
In-Reply-To: <20250103112019.1.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>
References: <20250103112019.1.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5657391822182974639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=921922

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.70 seconds
BuildKernel                   PASS      24.84 seconds
CheckAllWarning               PASS      27.05 seconds
CheckSparse                   PASS      30.62 seconds
BuildKernel32                 PASS      24.57 seconds
TestRunnerSetup               PASS      443.19 seconds
TestRunner_l2cap-tester       PASS      22.93 seconds
TestRunner_iso-tester         PASS      32.42 seconds
TestRunner_bnep-tester        PASS      4.97 seconds
TestRunner_mgmt-tester        PASS      118.65 seconds
TestRunner_rfcomm-tester      PASS      8.41 seconds
TestRunner_sco-tester         PASS      9.47 seconds
TestRunner_ioctl-tester       PASS      8.23 seconds
TestRunner_mesh-tester        FAIL      8.27 seconds
TestRunner_smp-tester         PASS      7.13 seconds
TestRunner_userchan-tester    PASS      5.10 seconds
IncrementalBuild              PENDING   0.61 seconds

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
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76c/0x7d0
WARNING: CPU: 0 PID: 64 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.110 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5657391822182974639==--
