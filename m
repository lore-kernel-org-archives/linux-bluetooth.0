Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4062750EA
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718769; cv=none; b=qZN5yZtO4DrEoDrqNc4kSdP7LCCBnlGY6vKQy8tvsBQ+fxacxFSR3AHMGIkDVhJmHT5ToaHvToWwI/57kCzuWHm7V7vfARFIrEFIR5CPzfqy68iAyR15To0J1gtZuiFCAsvLZ9JMxQutHBR3PD5vbEqkErDq2/SXJT4KJgLdumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718769; c=relaxed/simple;
	bh=YxY5SvP3jfXoNPFtYQSGKsEXgEdJFVCIWe1s5Fk2C1g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=n6x/Fu9YUUc6X5SWs2TLrRvPpSZWbWAGSqpMNe7ZQQsJnnu/yCkgRRDhffI5u7Sm3IglxNeyWXm0961MTlJ36/LHFwUAzTso90qjMRTvEud0bewbGT24ISUOa6Zs9hUB7jjNRnnU1vbDV4v8YfYqI9h5tGfkW3UwVfXjepV6ZrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnXty0wG; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnXty0wG"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fada2dd785so42562486d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753718766; x=1754323566; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tQEf6cF6eiL79RcG77nbJYPYWqJ7690rwAzKhEyDT84=;
        b=SnXty0wGa6Ztmwsl/AmYCJ6rl/Py1Q46OR0RCt2W5SVtiaKvkfEw+ZjyDEXy8TMcmq
         oVa8sE6MzRHKMrTnNDXdb1oT8HtQ/978wg/aDoxDHftYU4fHAfXOMbQIdvHY9MpePLap
         fCIjC+RI9yjRd5m1C14yLXH5SmNqcvrSd+Ld4tdgYrtwZxwsaxgx43walUSAqdRCfaMN
         +tPGkZ758N0R80Jl16zde1/9afwM/5CdLGA5lsb2vp5YXx6cmYA/z5NOF3VEsw5OVpLR
         jYc9nOtFi+RAPhsfGkh7Ct0aIBZ3FdieER3mpVcOpsnBDxaQHY9DgrEnQtC0smPk4+34
         R86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753718766; x=1754323566;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQEf6cF6eiL79RcG77nbJYPYWqJ7690rwAzKhEyDT84=;
        b=gFDalRv7gUMzfQ6OkhtPDwz/1E9Payb7gc9JQ3uaWYoTOWLCWkySSS5aVKZUAt5/Ub
         WthWjSRztst01xDcoYHH59HkOKDCeYVwL5hmStA3C9ZiFH03Ge+nKNYXHtb2Di7kXIu/
         diQ7baKYjfQBlAgWXPl0nUdUaTRDdi0qduE1qQzD20s07XGwtLGnOh9F5FWCb6GeFUYQ
         iXKFW4ob8UDqEfrQcaXxrO8/PTT4hgBM7OX9aD32kMT+EE7ST91Htbvrm6jpECUrHxNv
         MmtMMqvR5DNVtX2cZlsrQB3XdN58DL/Dvw23jUGweiR0BDQm0bxIvghUpRYgiICrdFgk
         2opg==
X-Gm-Message-State: AOJu0YyIS76N+ESgVCEPjHpZ28Tr6wmm3gE2aAeb7msQ5r2xdmednoad
	oKenkG0+kp+ZD5TEWIjStwCIeZyurTx29B3H9sU0ARi1vHNvbbtwn9sfTDUDoeE+
X-Gm-Gg: ASbGncthz+Ai77tRct4e/2jtXb2j8LYXTht4Po05tQ/zYQXHTW4DSwGcYb2S2yOj16n
	CMwexoH+nckjgxH1rigtce0UDcgsBx+tPPcpkL/YIEqlYEiODWtaFAiSKWyO2bXKPs8Ff1kIcyq
	K1mcvRzmZ1OmHWM14a0q60TU3tcrbdLJpABWu1ekqxXCO4Q6sYBjx8UpNP0VhL9nOT+HpFq6bYP
	by+CDKP+bx7X1WrDbV+Z1Bkug0x9037l8OFH3hceWjJOWfar+4KvjI737o5GWBXokV2J1EL0hZV
	NTyj5De7UeHxcNgGV/d66xDRAcT+KMzr3sUhZpLXODsoirPNGjBWejEcVj6KrUkqWrsjvE1vrsc
	ZXJMcb3zDrl11xM+3cQ4esKy1J1CZXyrayMeSig==
X-Google-Smtp-Source: AGHT+IGs2CKdnwuZ0qSp1x5zbdy2aH2LbqASVF6g+7VyUtD6cYLRXm8S8Ve0nJfhGsOGkZUEaqg0hA==
X-Received: by 2002:ad4:5bcd:0:b0:6fb:5249:59fe with SMTP id 6a1803df08f44-707206b2269mr157508736d6.2.1753718765941;
        Mon, 28 Jul 2025 09:06:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.183.82])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729c4dabesm33414306d6.68.2025.07.28.09.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:06:05 -0700 (PDT)
Message-ID: <68879fed.d40a0220.94a85.f13d@mx.google.com>
Date: Mon, 28 Jul 2025 09:06:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4405334537922226773=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3,1/2] Bluetooth: btintel_pcie: Add Bluetooth core/platform as comments
In-Reply-To: <20250728154910.1428086-1-kiran.k@intel.com>
References: <20250728154910.1428086-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4405334537922226773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=986466

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      24.39 seconds
CheckAllWarning               PASS      27.17 seconds
CheckSparse                   PASS      30.26 seconds
BuildKernel32                 PASS      26.62 seconds
TestRunnerSetup               PASS      480.94 seconds
TestRunner_l2cap-tester       PASS      24.95 seconds
TestRunner_iso-tester         PASS      37.81 seconds
TestRunner_bnep-tester        PASS      6.01 seconds
TestRunner_mgmt-tester        PASS      129.30 seconds
TestRunner_rfcomm-tester      PASS      9.91 seconds
TestRunner_sco-tester         PASS      14.89 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.68 seconds
TestRunner_userchan-tester    PASS      6.32 seconds
IncrementalBuild              PENDING   0.65 seconds

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
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.082 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4405334537922226773==--
