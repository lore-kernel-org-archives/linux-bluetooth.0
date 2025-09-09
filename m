Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267792566D3
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757457135; cv=none; b=T+dccPHE3k3aerGx8cnvQVtFm46wkL5bEDCqii6NLstxsqs9zuF4FLKxkm6qiZ7Dgx0PPA/VZYqDMvg/Ozg+ZMH3lQPJVHz8dQyFnoXnggcKE0OzwVqhGvEyV9+wou92EPP7tgg7tGmDv2NxmulrfKh9cG69SCN/YXMUs0XZZ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757457135; c=relaxed/simple;
	bh=r1lyNZnKtmNLqTcgbSQezQpApg9BGp1jfrFzdFNAbVo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J8NPqaHs6znFegAsczZmyJkrD0T3kscEPf9SXDzfdW5Lpg1F6x6lJ6gSrLTvGP45X0Ngf15mOrGmkXzaExZGi+YAeTqwaATc/btpLnrQ75oF2+cCcn0f87wML7mKkeqI+R0dHMYqCPEUbeMmDexuV2fZg0aUqw7bltXxgXl4iSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQOThUbO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQOThUbO"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so4913266b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Sep 2025 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757457132; x=1758061932; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnnn1e/puKVo5+3msZXBnAc/y5Xe5wunaB9A72Njy4A=;
        b=UQOThUbOZLpDbYb/iiW4xrke1XkSlpEykqttc7b+sJmOe7RUB373S4dr9dKhDzgGx7
         0dceyUiG2nkvYxB/bp/JtrRPF4JbJGs8W+qf5nl6ab1exp9KfEzGTM4VlV7bOp+aRX0C
         YTfjB54FhyFitnwXspDYAjBdcD6oRFHDLNKxnne3MSFroJ5hqPZUS7vyjgh9tB5xAJP5
         LcYu/zyuBcfQrO8VkR+RjVavXAzDRqyexDuH9WZPiETgfLqjeqT3PVpQjcjW11O3eWCw
         dH+ayPYU4tmd+ck/Gbdz+9mVR6PEgomZ0Eh+NMKjVBHwqYP+PoK9rULVPVf6yBUMZddR
         zTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757457132; x=1758061932;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qnnn1e/puKVo5+3msZXBnAc/y5Xe5wunaB9A72Njy4A=;
        b=k8Le1FzKgrjkqXXVvBdCkUv0/pl6ARyw/ChggPbA5P30TzhL7U20p7RUD9ZAJ8knaX
         9kAaxftHMKX1O46yaR5st7b2it+8LPpR6CFMpLKrSYduOjQc982Rc4KkAcH5nTRf2nFv
         4GSZbCDDyCiGe3moeWg6ALSV+BEZEwBOelzsbtKvC88HfKgSAxCPNML+3Jn53crUwb+a
         mNOTqjr8M3TauFVe3Dz7dPGOjvgqoLsMcxfENex1/OzbxgUZUN3NpSWRayqjFQTQXqXq
         8hMO9s/dnDveNPrITsKWgSpr698/Sh6FP2/zcer77GOYCqy5QM0FwShubRvSeAqZlY7V
         dI5A==
X-Gm-Message-State: AOJu0YwbO5a/SYpg7MMetKfRWNNjWsvCwk2shEXKhBzjrSOd/5Gfu9OW
	r/USGOm/cK0UAzbr9ZhB9gpGULivlsGk+Z9uPbBsbs25UWaawWodYBdw7efjqg==
X-Gm-Gg: ASbGnctyoadubRZcYevX0dwsQK78gyNZlcE9Oyx1knRh49wfhbcmjm1dJKy1KyHEos9
	U7gmPl0MFDAonFZKrUtYi488ww28VoO5eCugBDwLIXQZFti7GA5D+0LLe7EFc+JOVH441vHN+bO
	ajW2EweUj0Wcjh6W7mCe5vgaUO4IZR+2T06RPow/sYdS1l+FRROncrmCEIWHIQe2sQ3DFKQyf3Q
	9kR3XSD/lPbhUUHWss2mJT4q0sJXFIBIYGVK/SKo1W68wrDrTwaiyRNIvIn20xyn5uUSdS6nX/L
	IDy7Y7EiNI5QxgGkO3dX3tgUYkNhBLtQ/xCTPtyXLgZIvKg37fahOtff/OMeLzh9cisP8ASHomp
	dyX/pEuoixBlxdFD9mJaUZwaJXJH2kb8QfPUL3Rr8
X-Google-Smtp-Source: AGHT+IFgNPyzzqI5UFxqoirC+px0VE5fHYOBhsVLXfuBwoPUxwnWq5Zi9oo2HEFz/LrOj4MJwIwIlA==
X-Received: by 2002:a05:6a00:2d07:b0:772:3d30:7555 with SMTP id d2e1a72fcca58-7742de92234mr16575386b3a.23.1757457132098;
        Tue, 09 Sep 2025 15:32:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.126.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c3d55sm3062510b3a.70.2025.09.09.15.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 15:32:11 -0700 (PDT)
Message-ID: <68c0aaeb.a70a0220.2d596e.ca96@mx.google.com>
Date: Tue, 09 Sep 2025 15:32:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1170293371256869745=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/3] Bluetooth: MGMT: Fix possible UAF on mgmt_add_adv_patterns_monitor_sync
In-Reply-To: <20250909220327.1771815-1-luiz.dentz@gmail.com>
References: <20250909220327.1771815-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1170293371256869745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1000737

---Test result---

Test Summary:
CheckPatch                    PENDING   0.50 seconds
GitLint                       PENDING   0.38 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      24.47 seconds
CheckAllWarning               PASS      26.91 seconds
CheckSparse                   WARNING   30.29 seconds
BuildKernel32                 PASS      24.33 seconds
TestRunnerSetup               PASS      475.71 seconds
TestRunner_l2cap-tester       PASS      24.62 seconds
TestRunner_iso-tester         PASS      44.84 seconds
TestRunner_bnep-tester        PASS      5.95 seconds
TestRunner_mgmt-tester        FAIL      125.58 seconds
TestRunner_rfcomm-tester      PASS      9.31 seconds
TestRunner_sco-tester         PASS      15.03 seconds
TestRunner_ioctl-tester       PASS      10.04 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      6.20 seconds
IncrementalBuild              PENDING   0.95 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.117 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1170293371256869745==--
