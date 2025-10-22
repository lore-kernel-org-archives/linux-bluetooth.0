Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A272378F5D
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166879; cv=none; b=LUDKOBdE5jgps5xhHn8Rdp/w8PSZ4p3FKjp2OhReyen8xf+GBZh3i3V9rRqIeMH4ofXnNd90A+DpQFS+fB7cM513Lp84RNHrLlOWi1nzh4R7R8+F9izMQfaMOuD+S5XQ9qSLzZH9WQkDHOhd8Q4RbWcCnslSHZ2albSq5d4ZzCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166879; c=relaxed/simple;
	bh=/TVekbSIPY8df99q+BYRBP1/S6eFCYCC1stM5kBb08E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D62wfQJCS+13q0l51RJme3ykQBFfUJuergCxt3MqJYYHLS4nY/E/b0dGdDQh98AGqcMkAEcS+fosQ0pm+CPIPG0HQezuyN8ScG6/Sk/klkm+n7IQVDM8T4AtCDPC5SxsNO2PdxLIeGEe7Agq6eXXhjoGuddV1EfuvdugwInSRtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2iESAep; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2iESAep"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3307de086d8so79828a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 14:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761166877; x=1761771677; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gAVoI4XW19pFGCcdqt9Za52Azn6IVozgthx2kKU/jeg=;
        b=U2iESAepDoQV55YFtidfa68HJnBLiZjggylpk/fOWlOrsr+8Q//909+Ypu08uCtVZo
         WaKR1yATg983BYYbCMBwKFZ3ypGPIjT67KDM5aJmoZcrc6FZZDpB8Q7IqGXGnhIqv1+3
         W3+hVzGbGmkV+1aaQTZH6GfCgb2Q16n8QOFRDn02dS5+7ID8wv3F1X0k7ZcvJpT8CHU9
         ippQXtjfmBbPaNWp6oSJ6OxC3pCXWdgCFsCi6OTM1vV8yvkkwiUmvx8+KA6NnXsHmxs4
         uB9lR/JuLHyud304N9roIfNPYjDbK+hVgi+u0gjjBRGT1voSn/2W8PIsPnPSWORiPEaD
         j+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761166877; x=1761771677;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAVoI4XW19pFGCcdqt9Za52Azn6IVozgthx2kKU/jeg=;
        b=PzKaGT/QVvx9r5op5n9XdwTgwChzceHdAqhGPQxPIDf/95WCfWBiD2hK1x9jMQE+aP
         7v+LFmtXECrEVdPYtW1fXzp+w1y50drqjKjBDb2vx8LENYB61Hmf6IN4JRa9vN4jONHd
         WwarM4JRwBaKvf2VeNqCKcZY9mgq8n9SFxEEF0Qf6++SxTHkyVLON//fmnuB/VXHFvO7
         +9N/u6aHHMMq3QrEMeK7toBV8x7+H0aDamvuKD2T4by+mcnIWAman50qE94h+eN0wTiH
         hP/jQKhYZxz7VKJ8P9HucZgF696N7prpQndfi0fme+O5pBmkt2DgiSFO0BKLkpkFXcZD
         g/sQ==
X-Gm-Message-State: AOJu0YxYK3QU7BgiqH5FH0pZYNkpHW6GrAkDW3+KJ7BpgiP24FXXZzu0
	hDRwRt9pWt0HiPDOcBw+jveIaRO0ShbYJ29l3BWFCBFpjiYz64Di79M2Wt27jw==
X-Gm-Gg: ASbGncuK8RydqpKDQyxSJg65NvpOGz2PFIUPxjbCKouUNCSDDgOO/NnkO8/CWnnNciq
	OrLJZt3sMRNqwX77G9cXAdyO98N7W27cRg7r7/3mYRAzzEoGOH7NbILflHv880JW9oFaXP+DS1/
	xkoOX1CnIAaUmGJUXbMvXkCLPt6kjNTrmV0XS8w6vkHq5epRuDJdEw8K3mUpRwofyi7/wSrlv2o
	nEIUykXOoTMB50qYvEQuOTznviY4f5NJpJu2picuoTtJSVxqdg9WyXrieU6VkPqHs/tCL+XRpw1
	wjFkgDPwdCaqiOF/uGsd7RBig2Clrx7b9/4VusvQyHD8xSCvJ9t+mks0nQUqVXUYtQ/7cQFGYiQ
	uPh8ilDBp3DwEQBQ0lKIEUggl8fCULce4om9uPcq1/XOd06lLKTSZR4jt6iP8tEoYErSa4diAHA
	xYvZpM2Zg=
X-Google-Smtp-Source: AGHT+IHvAnQFz+9WNqSi5AF6tQqetVh9WOS6GlOdxENZMjik7goH8/59iTwNs7rAjwbyIGz2/knJDQ==
X-Received: by 2002:a17:90b:28c4:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-33bcf87b055mr31362111a91.16.1761166876281;
        Wed, 22 Oct 2025 14:01:16 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.160.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff3f6c2esm3008511a91.6.2025.10.22.14.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 14:01:15 -0700 (PDT)
Message-ID: <68f9461b.170a0220.8263e.20a9@mx.google.com>
Date: Wed, 22 Oct 2025 14:01:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5076097724369014156=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_conn: Fix connection cleanup with BIG with 2 or more BIS
In-Reply-To: <20251022202941.1537413-1-luiz.dentz@gmail.com>
References: <20251022202941.1537413-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5076097724369014156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1014692

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.38 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.32 seconds
CheckAllWarning               PASS      27.05 seconds
CheckSparse                   PASS      30.04 seconds
BuildKernel32                 PASS      24.40 seconds
TestRunnerSetup               PASS      489.89 seconds
TestRunner_l2cap-tester       PASS      23.74 seconds
TestRunner_iso-tester         PASS      82.67 seconds
TestRunner_bnep-tester        PASS      6.06 seconds
TestRunner_mgmt-tester        FAIL      114.28 seconds
TestRunner_rfcomm-tester      PASS      9.24 seconds
TestRunner_sco-tester         PASS      14.35 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.36 seconds
IncrementalBuild              PENDING   1.04 seconds

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
Read Exp Feature - Success                           Failed       0.103 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.162 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.883 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5076097724369014156==--
