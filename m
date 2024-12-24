Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2062B18AE2
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Dec 2024 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735022218; cv=none; b=DvfuO8PP2m12YLIeTYoWxW1Pc9cBgTbUNuQS63aE9GtYJrmJW1Uxyr68U0MG8dZpdw5Ha3lfT/4E4g2veXl8RklHQnuKdFen6TD9/verfjS/wOzH35F08yo+3MPHafOS9W1088X8uqAA1JT23tOxWk6WvMBa9Fv4Cw4T/Mx71HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735022218; c=relaxed/simple;
	bh=SByVEyLgoGJvnxb+oMQnFjC5Ur/O+lsu4NUhNrd7q+Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pnCn7FXrQhaq5yr/wlrQkfDcMqlFIN3PhqBwilmVq9JZwf4WeNi+bO3Gq4mSwQ9m18mN+u3cGCYIOmdHivozNHUkZ8oQkKbWQ1r7N179dv2AnqkcuEGS/CcpTu2bKaScp0OD3mVmvwh2TX2Ln/onauogVIpAmYL+wYnn/WTY0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBxovB4I; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBxovB4I"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4678cce3d60so47690841cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 22:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735022216; x=1735627016; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hVv1hcQak99+qsXPhmjmnpTiwfh/pDVcnTefalqeOZg=;
        b=aBxovB4I/KFqDlrzWglk94EYxgFviXFm+t3EGTtew0JhVtbGg44jYIrfbuakBmvzIw
         AOl3/Ofud00pDmY0XV54EF6/H/7ZVMkJ+mH6ZP4QQgyjHruYxErtlCMck/ccXMUN7H1H
         wBSwCbIWFZj29Ux0G/4Vw+6q8XraaC49UCFiwhVAMXyQKfI6p7JR+xZy+dziCRY5nJsU
         y1JMA0q0uHNG/l9UNrhnegWN35Fg4bdBlu482/uJq+43g3o0Zx4n1FPuY4zWLnbrUiyk
         nNoNdQZVZsHn3olXkZngN2vYCp/btlXmUpq6y0pa9qHdNCNsk2uZ/PDzKrvompVrjpRf
         IThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735022216; x=1735627016;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVv1hcQak99+qsXPhmjmnpTiwfh/pDVcnTefalqeOZg=;
        b=GfGUj40idEThXRnx8l9Hq35RHT5oJ1oyCu0g23ZdKrDF9RtPF7XrVYNaDakC+ee+tZ
         Ek4og7uk/9Y9yjPy7jRfECvdPxyHdlYTP6sQSWhiK7oGnmlGLQAuU1th7bEfyu20ygMx
         mJjyr43x7C2KrH4/wg5QpiDWTZgG+alyvok8ozPpPCBuWq+J2hKqulEkublbky2SNR6q
         PaVwv2XumTodVj6E8bRwodFzrN4DHgW/VWobQ8A6I2SE0j+7H4kaRUYwJT8yAwd9JC3z
         qlawMVGRLkpWLKMfEP2WR5ykBo66cKSTpH5ETbTfAwPm4nJEIVwZxsvY0E0HzNvF3fCQ
         PGXw==
X-Gm-Message-State: AOJu0YwaXUbHyrnORHf70CvvXsC4BJEGRuMTi81Y1GJVEK8B2RcyqU48
	ImQRhNAcUMH5eNfly/eYy2ZKATZVvsCfx7rtdkt0VcuZd7WSaoEU0hwzcg==
X-Gm-Gg: ASbGncvSj7yBpiRtTzNsiL2wUlV8vwd90U+NvKNKfbCdp8pW8656ORrNT7fHb1zmPBp
	hj1lFvNVOBMwb2o/dIVKv8IQ7gDqhpLNzdiPjxp+Q6N0OzTQytfUUeV8f0w+Dgmu9MPUIS0BzC3
	8R3J7/h5Odql9z83yqHcAap7yEAfqqqrV7JJfU+9R5Kf8fiHX7dsgpv7iGvi6FO6aH1bL1NwhBA
	MFyfbVaa4slHMcH9LcL7FPo1Xd47xgrqxiyiaB6Hk94Ox1WWIsNN2Rf2YGbtCg=
X-Google-Smtp-Source: AGHT+IF9CxzYvFdqivbmYfaywoVIE1vsTlAmJSKsbympNLo+/l5NmRebosmVSZ073+b3DNjFsBtWeQ==
X-Received: by 2002:a05:622a:347:b0:467:84df:92ee with SMTP id d75a77b69052e-46a4a9a69f8mr232743621cf.40.1735022215615;
        Mon, 23 Dec 2024 22:36:55 -0800 (PST)
Received: from [172.17.0.2] ([40.67.133.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e64cfacsm51070481cf.14.2024.12.23.22.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 22:36:55 -0800 (PST)
Message-ID: <676a5687.c80a0220.2d79db.0edb@mx.google.com>
Date: Mon, 23 Dec 2024 22:36:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1905276946501272434=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangheng@kylinos.cn
Subject: RE: [v2] tty: rfcomm: use sysfs_emit() instead of sprintf()
In-Reply-To: <20241224060730.3231502-1-zhangheng@kylinos.cn>
References: <20241224060730.3231502-1-zhangheng@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1905276946501272434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=920623

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 FAIL      0.39 seconds
BuildKernel                   PASS      25.99 seconds
CheckAllWarning               PASS      27.92 seconds
CheckSparse                   PASS      31.62 seconds
BuildKernel32                 PASS      25.30 seconds
TestRunnerSetup               PASS      447.90 seconds
TestRunner_l2cap-tester       PASS      21.19 seconds
TestRunner_iso-tester         PASS      36.65 seconds
TestRunner_bnep-tester        PASS      4.93 seconds
TestRunner_mgmt-tester        FAIL      121.28 seconds
TestRunner_rfcomm-tester      PASS      8.04 seconds
TestRunner_sco-tester         PASS      9.53 seconds
TestRunner_ioctl-tester       PASS      8.30 seconds
TestRunner_mesh-tester        PASS      6.15 seconds
TestRunner_smp-tester         PASS      7.17 seconds
TestRunner_userchan-tester    PASS      5.11 seconds
IncrementalBuild              PENDING   0.86 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.151 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1905276946501272434==--
