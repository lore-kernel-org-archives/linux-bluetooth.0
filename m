Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF01A9FAF
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 03:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843281; cv=none; b=eKkLCsNlNPCMWu7CyAjWXvfjYv+sVZiVpOgfXSbKJ7v20ZqA3e/ZHwD805hJEiZV5kmSw7/DGZmjUH3ryOu6bnJXEeu9NmhRMnH2wySnEx6+cJtJniS7TU5QOjpNxt9ygA286m4PMT4SBqjCrxTfZfX09RbCPH3OdFnV+bZtu7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843281; c=relaxed/simple;
	bh=vYuWH+YBguD97bJGClQEZnE336n6EuzTTeYfrP6GWtQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Bp9a/rV8tfz4kwAys5sAJ79ZX/oDQWsdeLtuknBBXi+g5DN2phZZgtvJhG89saMIQKplD2niVV78b74k7o2mTETbrQaYFFy516pF5IUCNGTmtuBEXEuZHlQiWFNTrdumB4/xPeO0UyX5qpTQm4gHdiAHk+CTkgOyKSyQ1zosHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD2NR4JU; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD2NR4JU"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ae57f34e22so3251060eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jan 2026 19:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767843279; x=1768448079; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JOPQGzpPUm0dU9yl6euLyHOs08TYYR3y4dsNybJ+ni4=;
        b=YD2NR4JUjyyTzjZgghZMbQxBVVnfUqjmcR6mZ7h7yxLAejxLb5GYnWYLRcXl3Vt5mM
         y76TYkxTDEAjngl/SQMbFCy/hMvWz5HMpFUx6/mk3HzmFHjBh4R9QodquEYCjAJqT6D0
         Wx8kAhUisgzNVmXGjAqU0o0sAnn5dhkOxLti/gmuzm8Wxm2VrLcewORP1iPMHaoTBMEb
         2fE9AiaHDTaaLZAYPTezTS73juB9YvNU+Btql/J8YXAaKGx9T9GmqLnmUaErGTdIMgNd
         MzDI6yrE7vnLQNPtATMmyHTmo+PyHNQdJxSzLIM5mI2tz3vLCt0pPayRM28NULT1rktz
         eKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767843279; x=1768448079;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOPQGzpPUm0dU9yl6euLyHOs08TYYR3y4dsNybJ+ni4=;
        b=jpfV56LztsHOOOOymq3VKhKukRtS/qDU2PNrLMf3ke1pvXQCRzJFm45fodwF37KbHl
         Mfu34OXC48Cy248Ci3jh/TKGq0LVwj/iM7MWVFLwS+3H2xJsYGQJ0mOg1VLbvJeIsPlm
         mxplW2+7ffZ8hyKm2hl84I+LZJDFpnM1N8CNq/92PmHpZvgLf/LoWKAKUMKY46eYRtnP
         OwKD3RErfFZAQto9Hd20pJjlY8nylIP0Q+Gh0ENp/ULZ+HQaIOcIEtbq5LhAHsluVh3Y
         ipUnkfB1Gh1WjRXDuxgPUZvRiRqyIag1Rguce6WnUhpondw3ig8jQYeMLlGNOq/3nBfr
         OU9g==
X-Gm-Message-State: AOJu0YypnthI5bdWSwa/I/bUbuuLthEVGQ/+UXvcaGmxGPJRWs+t9vwe
	JonfiNp0d+7Yaew4CTgcy4Xu1Q5mAKCaohSmUhfiuxhFuFvAyPcnoNVRSqakegeM
X-Gm-Gg: AY/fxX6aXbZbVsO71BS8wV3LqzGrh1JenhsFzNwK97riZU6JhZ7/JlsfnXPeuD7t/81
	kZ+zJGLj3+ad1osEa+3hIfwBiMfjzLoCZvynXn3xgajA3c2lzlQV2DRHcVceOKaJj4jniZbHHeq
	ByEiakDls9cuJ7r6IIBaObAX/LtXLX/FRADE0vQ84BeGdVRDcGRjT+9xWn4nK3cd8V5qcr/azHf
	dpIGXnTMBnUXNU4nxr8K8QeVAxVm1hVOk0r/18vZERqpDGWZ6tE6LtXRQqmo7tyLqjOThtA7uLD
	Hn6dAMpmW+QlelA5pLIg5Xa7iSrD86DhS36i2NWvos/dOWcLxOysaO8Bm/IsC5copWRNEqXq3lB
	SxTa/pYwGmqax7uuKOBmApwslXUBMDxcvTxH4hUYyT7A6iDIUXvwxmoEILZyuVV1TNlJETDE8sM
	FIp6QlrJ9hm4U+VQHOUZo=
X-Google-Smtp-Source: AGHT+IGqg0NQOFV8HMRuaVmDqBUxnPzzid6Ky5XbNML7MlY7WMUunpvSjG1pP3aX+RZKH5OJooWwkA==
X-Received: by 2002:a05:7301:6f0e:b0:2ac:2d7:6a6b with SMTP id 5a478bee46e88-2b17d207b38mr2608387eec.11.1767843278909;
        Wed, 07 Jan 2026 19:34:38 -0800 (PST)
Received: from [172.17.0.2] ([172.184.210.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a6386sm8221422eec.14.2026.01.07.19.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:34:38 -0800 (PST)
Message-ID: <695f25ce.050a0220.15652d.f9df@mx.google.com>
Date: Wed, 07 Jan 2026 19:34:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8850917124990689198=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lilinmao@kylinos.cn
Subject: RE: [v2] Bluetooth: btusb: Reject autosuspend if discovery is active
In-Reply-To: <20260108020633.1729637-1-lilinmao@kylinos.cn>
References: <20260108020633.1729637-1-lilinmao@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8850917124990689198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1039647

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.43 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.83 seconds
CheckAllWarning               PASS      28.24 seconds
CheckSparse                   PASS      31.79 seconds
BuildKernel32                 PASS      25.46 seconds
TestRunnerSetup               PASS      560.05 seconds
TestRunner_l2cap-tester       PASS      28.28 seconds
TestRunner_iso-tester         FAIL      46.78 seconds
TestRunner_bnep-tester        PASS      6.28 seconds
TestRunner_mgmt-tester        FAIL      127.36 seconds
TestRunner_rfcomm-tester      PASS      9.45 seconds
TestRunner_sco-tester         FAIL      14.68 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        FAIL      15.26 seconds
TestRunner_smp-tester         PASS      8.78 seconds
TestRunner_userchan-tester    PASS      6.68 seconds
IncrementalBuild              PENDING   1.05 seconds

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
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
LL Privacy - Remove Device 3 (Disable RL)            Failed       0.210 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.734 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8850917124990689198==--
