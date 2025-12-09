Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905CE27A442
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765291244; cv=none; b=JKXQ/+9wf9MrWX77GEpyLz9t+0hRhKw9S4wAh8mkujh8vZEDzBBN5hmpuXmjOwQOMt6rek0829wZnV+fny6dZ4U+PqmDQhdS1k6BZ1JSBZU71NdKEOhb9npriwfAZvFIVQOv4EtXsB3x69oSiCIR9BLiG/IvrnLjVfANjooJQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765291244; c=relaxed/simple;
	bh=lmzluPEWTzMCFZ1lAa3jWY69oGm3nCtMSYE6q9qlU8U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cUfCwJnFoTLUxwf0JsZ4a7Pu2tdPhmvbo/mWNazkVegn58UhRhwWF6unKOiTlNQw2XFveMqxBb4b0BSzDFNQyfjiYu6yod8F1Vv2MQ5PB3zvgvPqm/Q59Esgzd2YbtFKYf4JFweCz8Af6TOp5DCdnF8mBukG6VM+EU99+HlGSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSz2jn5k; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSz2jn5k"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8824ce98111so82822516d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Dec 2025 06:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765291241; x=1765896041; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1wNNLndkSw93gCKDVHlzevz9i188Z5mCYDX23st3HJ8=;
        b=QSz2jn5kYVbyvE5ejpvujohxx154ObN5PCSL84UEI4WF/zm1QXXHBemlAAX+qOwp+s
         1HcTcxru3sAa1JG1Q1k6RL9VhJdaTt6+tXLCpva4bBRsxwYQhNFv8yd7R3XNgG1ZzdKH
         RzIwPsCe7obQnoaHd3QHJcJRhIY/9Gmjc+fg4JapEGEMYebBp6gWkQjaVEvvB/IYE6z1
         p23R9HozSOuREYm3tDDd5v79VI6GgAjY26r5taKzhhXBFMHvglm1wHzUDAUoQslKETbd
         sGmGl2RmZTyX5RPF6LWVHTWK3CJt3VqsEJ8oFRBG/0s1HDtxZLflm9vh53T4/9OBSn7S
         O2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765291241; x=1765896041;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wNNLndkSw93gCKDVHlzevz9i188Z5mCYDX23st3HJ8=;
        b=MYgJoTzRtBQ8LcZGdnGqJcMoEZeumONroPIvL+f8RA3YEfXl3zVtF8rDQBftQCcqux
         U1tThz1uvWi8phoNbf/gnzfHgYjIey9FvSB3wKjSoSyHW8mC8sRtg5mBYuri4BvDJx11
         1IpanKsZFDn1EFQSwP6CFa3TIQJMHkWSncZ61up0hJIUcpPJB4YfE3ahr2NRddT90LRz
         JVe8To7yUMitXmEhp8yh0tEdhjC2hVPnAYJRNTf0sAfNUZcICFsJ5NYfHUl3MCMSn/u4
         ekeorFHPmkIYcE8Kkwguxaglynu1Zz//EBy6z32TI4GYX6VUNPujxO7Yxsv1khz6Jl83
         SAxQ==
X-Gm-Message-State: AOJu0YyyoPIjux4qorZEBHfhk2RSpATym1PqqxTv9KqIHj817D2yTIgW
	RSw3tqDgEtvUZh19f4bAYTGabd0WIOJc0qdD3mjIucV78efjVkG01NcNIlT/Nw==
X-Gm-Gg: AY/fxX7lXKhdETK0KnOakGXiHxoFQJfJ4q8z3X7ksFsY9+FY48wQJhnBbdvkdE82Y0y
	iIEt+DCu2yKEpjtCaIAbq8gvErfdJ9lnR9GU6U/YkVcteXQA6yGb+tXXpBrFT96N7k6RGo0MvxR
	zKsvS9c6tr1sZ+d9ua3KDCWsE7CZX281tFCyi793NUB/X7g8UEbUG8uqkZGYwi/iZEdTYzO7NIP
	9NsyQc4YyBcOs41D9hXtiBAW1yH+wkcgJ59L/Kv0uySGeEvFZ0SKzYPPlA0IPNImqn0DTRtq88K
	oxxZl0HLymzaEi4IXgQbVUEYoDHmMisYD0vnDJlpl8CjVwlHduB+1Bkp+ZB/S3zM8kw/selQo0k
	89/CcsWSbAGU6JhFX+osy3boUGZziSvDpcpJhixA8qSP7CnccmG1BY8h/6NBFdKOJ47ZgGQ4MoH
	A7ZnPiD+ErQLim6aw=
X-Google-Smtp-Source: AGHT+IGAdkaoGCvpBwMS2MIOTYi2cmsa+/Lk+jm16Y/MQ7/LEl8SdoY/mWX64ewZ6FsKYo5UwidaJA==
X-Received: by 2002:a05:6214:c4f:b0:880:4790:e61b with SMTP id 6a1803df08f44-8883db618f9mr191879566d6.26.1765291241066;
        Tue, 09 Dec 2025 06:40:41 -0800 (PST)
Received: from [172.17.0.2] ([20.109.39.57])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b627a88115sm1308166185a.41.2025.12.09.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 06:40:40 -0800 (PST)
Message-ID: <693834e8.370a0220.668a3.4fb4@mx.google.com>
Date: Tue, 09 Dec 2025 06:40:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6681518953776817187=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix not clearing cmd_sync_work_list on power off
In-Reply-To: <20251209140347.2816326-1-shuai.zhang@oss.qualcomm.com>
References: <20251209140347.2816326-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6681518953776817187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1031732

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   1.04 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.36 seconds
CheckAllWarning               PASS      28.41 seconds
CheckSparse                   PASS      31.51 seconds
BuildKernel32                 PASS      25.07 seconds
TestRunnerSetup               PASS      551.16 seconds
TestRunner_l2cap-tester       PASS      23.72 seconds
TestRunner_iso-tester         PASS      87.69 seconds
TestRunner_bnep-tester        PASS      6.22 seconds
TestRunner_mgmt-tester        FAIL      130.79 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         FAIL      14.54 seconds
TestRunner_ioctl-tester       PASS      10.19 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      9.26 seconds
IncrementalBuild              PENDING   0.90 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.113 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.171 seconds
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
Mesh - Send cancel - 1                               Timed out    1.961 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6681518953776817187==--
