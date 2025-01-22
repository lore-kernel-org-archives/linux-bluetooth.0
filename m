Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8923156C6A
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525414; cv=none; b=KzwEQvLhAMWhJWVzP+QSPG9BcNo8/dHb/+9tQqziJTQgIc4dHznAuptApEFFyTfXTlkazs8YkevEjb8RSJyFHht10aeOdmBG72pXJkctJ7sNyErH5RxcdiIsKUr+TJ8yLLzcp78+CQQrF8eG6OleYZ9oRSEHyncSsx0BQFOtJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525414; c=relaxed/simple;
	bh=U+xRyJFiINfDf5z4Fpx0EfXVnpbhPmT8VmMQTG35qfk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SnPSAONODLqKdUpIRMIGyMCYxVbRSvEuCxd4zZm48ERH6o1qHW5zaPlhOE05OFiMrZA1L2pNLOp6OygghAdjsWpb1rpoyIE7yYV1IIQCHwZQXir1dZk7xD2Y2aqjCDLShga8RuX7KLv+iWH005iY8xWgjV/uMxxJLxjxatd6/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHPopeK2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHPopeK2"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21a7ed0155cso104662585ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 21:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737525412; x=1738130212; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pYA8DiZBmqp0c7aGFB8sedoqRfdbMwnMYhuVOzOXE5I=;
        b=KHPopeK2eHTMxSURJWGgleYG1UejMm38WaQgs31V95s8CBPUaJUAcswXashSa+2fF+
         IvXXEkbwPtT6xI1JQPxfkRjiF+Bd+JMitqiyLKQuSNyk5Wr+SOBJzKKkExL5lujgoN88
         h5ivnVemTcnzqMJyso5W9+047IYHH6CFK26EgcDFpRyDb5cP9OnF7iGTcjiSOh3zycv+
         3Fc35AL1DZ63SbzaV/K1zHeIsLD1zAaEW+RiqyN2FxCTJ/Oj1oNNzYI+/u9u9W4+BrlB
         N3xCz07W7xsN93lunur6FTT+87t514gYQZAP4HS/d/7Vxt92SOaRc+lLcX7tPBzaU1ld
         dC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737525412; x=1738130212;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYA8DiZBmqp0c7aGFB8sedoqRfdbMwnMYhuVOzOXE5I=;
        b=U6AY+ZtUQpa5sZSM4E6eBxMTZIurMTdB+oD546WYLkC5gCfawezAnY5S04k3xm7mu+
         /NS9gOn9y4Vl8+eYr2Ci+T1dJEGhtDcIqfIwRfz8IIttfxcL0e1hodUlm36WnozKaL+A
         raovLTtiQH7ihphW8OETUUju2/rHd5FVt+MESXxH44w4a0A/juFHmaPcvq7ZvYW6DQ0F
         tJpToy1mGNezgv2QXYYJGsIX+PtoCXHtI/kE7PwtDf+vuE7Jvi09L9B4n4Y7SDuuCEir
         zdkKdmm8rPi1zbjBypwC1c8jv4tJxJ33eMn8AHx0lIvntT4hFO5DOcwdT9Z8NZHUHiTB
         ALlg==
X-Gm-Message-State: AOJu0YxOfzzD2ETIHY56Mc/zLXk/RxURQP72Ew01lCd4MsxUIGo35EPD
	1nZ6uPsUTxrDp6FQVNQkM6ku/9yQN8KraznONYHHc3Zdft2cLRF53eVJrA==
X-Gm-Gg: ASbGncsJmIRHSGFJGi32vxmiONujKNPjPXvkLrJSHvAHWcQY4BH/hyFpjKe87hAIGDa
	RvZ8+vB2QMsRfK3et3FSyW7KqXA/6wHcpbLy8BmmljN/u+8OfHKWTH9It1kb2tk4+5iRIK3+HKV
	msGjCmB0ES9aYNQoJtlsijGPfTCs7bxTH/N8A1Sn8xQON4RN+XZaj8lZbJp4uDshKsrITz+MEW1
	wpHh6U+3GzoDqlfyWWAS+L/IukkdsLNjDl3kEuRLUJzWDzTIoWiur2htlAkGWDp63QZJOKeZI0=
X-Google-Smtp-Source: AGHT+IFW8utwEoytl9ul09kXoJu5L6yEiL6B6D7GUUUUb1VYa8ZqR9MHrW7Xtk2uIPCR/PgBcBVmOg==
X-Received: by 2002:a05:6a21:329b:b0:1e0:d380:fe71 with SMTP id adf61e73a8af0-1eb2116d8aamr33975596637.0.1737525411614;
        Tue, 21 Jan 2025 21:56:51 -0800 (PST)
Received: from [172.17.0.2] ([20.169.15.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab812f03sm10169815b3a.39.2025.01.21.21.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 21:56:51 -0800 (PST)
Message-ID: <679088a3.050a0220.2abce4.8927@mx.google.com>
Date: Tue, 21 Jan 2025 21:56:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4207439436373026698=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: [v2,1/3] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
In-Reply-To: <20250122131925.v2.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
References: <20250122131925.v2.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4207439436373026698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=927394

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      24.01 seconds
CheckAllWarning               PASS      26.31 seconds
CheckSparse                   PASS      29.89 seconds
BuildKernel32                 PASS      23.61 seconds
TestRunnerSetup               PASS      424.15 seconds
TestRunner_l2cap-tester       PASS      20.28 seconds
TestRunner_iso-tester         PASS      29.46 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        FAIL      122.54 seconds
TestRunner_rfcomm-tester      PASS      7.51 seconds
TestRunner_sco-tester         PASS      9.28 seconds
TestRunner_ioctl-tester       PASS      8.02 seconds
TestRunner_mesh-tester        PASS      5.87 seconds
TestRunner_smp-tester         PASS      6.86 seconds
TestRunner_userchan-tester    PASS      7.03 seconds
IncrementalBuild              PENDING   0.46 seconds

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
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.138 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4207439436373026698==--
