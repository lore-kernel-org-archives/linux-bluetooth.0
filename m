Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AA1FF7C5
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346978; cv=none; b=GXPxfgkeRVX5ICrmQit5tmRfCv9MHWuN4OwWul5qygYoJYd30En4jSCJG0RnpS8Xkb7tm5xBQ/93CTtcEeXCnK6sGlfEzURlS8beoB6eY3ltk1WXmZr6pAnn/cKOuYd5dWrTsHhF158f8TtAQiyVXjSCG06grYElBBx4kNZL5W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346978; c=relaxed/simple;
	bh=1UAu+xVlxDgaClqaaYQxGm+/hE18eYFx/hX+g/iUUH4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D0At8O8dp5I3LFUOQJmqHE2nO9Qt0XG6mUZpjUsS0toCeGGkC4BanhWkJNS7T/j1pYD5Vs5rzYysG4Q+bMTHMrBjpDo+bGqgrBnPQO36jvTQxVX3JFrD/tgWwcNlg4+1grXy5n0NSuY3pkFfoKiDDxnqz+ngP1dbA8T8dA0V71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b57nN+Cf; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b57nN+Cf"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30c713f37c2so365215eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 17:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782346976; x=1782951776; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/YaM92rXktsa3gUt3m6lw1dR1Hem546tKJRMFTkcWXs=;
        b=b57nN+Cf1jXI9MyjYccCRyOA1abx/UMpDNn9IC5ORIXVZbqFCCkou+IJ9yhW5NpPJm
         u5IzCibHRbmLCYemDyitf/OkdbDrm3QN1DmnbB66v59SNiOm9Vc5TJtdRFTGa6yMESAk
         O1Cv0kzkcJjAwa0cb3qiw0nIcN8stocfaah+smad5542R5vIbjwE1WR//wC05A2ZnIQa
         +M5/bARtMAvrmfK17RWX5spR8I3si+I+PtnlsGiNlT1Or/af7lsj0CbyMMbTI2Whpc9U
         hmXoWLq01EhPV/AeDmxy1pamvXweXRWoeeq7l2eTGgus6j9F2kzT5Yfrs/i5H2FwsikG
         ZuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782346976; x=1782951776;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YaM92rXktsa3gUt3m6lw1dR1Hem546tKJRMFTkcWXs=;
        b=D71hdAMeBm//dzjA0jdsChIyssAzxzB3MunjUQEKIJmIp4jivK7Xi4sln5/6gySJ9I
         TY/7jtYFDHiI0WENZMDqHPr+VbRyvmAJa9e7KgRVKzXe2i97ZqX8ArASsWtA73dOXLbx
         zjB4KUcRgTTCfutmo5r6OPSZ+Ik8V8Q7CvdWylorT8os/sxQUkxg/lcId4OYC7C48W4D
         wOzi6zaOPuWgH3a5I0T5BQwqtOg/W9NprrwUIY4wTeVEBOK9ytLD4BP7HhJpKTdujuRg
         f3SoafB4B2eoMfjCF3gMj72ONYqntMeTxBNdMRRQgB27uPHkgRSwV6L/SWRoxZUNX8xp
         vrjg==
X-Gm-Message-State: AOJu0Yxyqepu+TnKT7BmtSIZUUZJvT9vqJhe44XbLZnvkSVkC8Jwyn6R
	0vE2LRInTd6wvvW7cmS4VH0hZtSIvwh5svqAJi6oh1Pln0vxerFMCW1PKaZYSg==
X-Gm-Gg: AfdE7ckblPnCrXMR5I6NsTJcSnDv3Qcmdv/JEVOFt1Fdl/1TFbeIyF2mNOKCpvO7pcu
	U8jibiQsZdZ7md/cJaETEvhRYNBDmAiof6dRH/XJd07t4xR3KnT3WW+tjhTEP39LSe7KCSvlPeZ
	zSnvvgCcMSggyf7GNNlcplVsVPG8Evt9fqxj6BpKOvZstpgGvhSXrFN/Kct6fZkKnMJ/8lCMN2n
	gbacMBbThJHKd+8B6Gr7Ie5YW+JSiex5+KKqTSpIat8crWPMHGq2O93eErmZL3T/qHlhaqCriY1
	aZsdNGNxXGpGZ8DaUo9BduqyZZNNax0YfyxT2jWNyoMmbZ0Fmvy96QCdN3qW9NnNjvRoeOHL15b
	jFPqvCDiozgjP1RyWIewO3y6SJluPd0dAqem7Qi5HiLlyAk/hKHPHLFaKtOstgrCQIhTga0FwIl
	+yJLXApGtC0i71KoRlNIk=
X-Received: by 2002:a05:7301:28aa:b0:30c:4ac0:d0f8 with SMTP id 5a478bee46e88-30c5562a2f5mr6527340eec.14.1782346976137;
        Wed, 24 Jun 2026 17:22:56 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.235.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca5e601sm2439000eec.25.2026.06.24.17.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 17:22:55 -0700 (PDT)
Message-ID: <6a3c74df.6cfa33d2.ab308.b65e@mx.google.com>
Date: Wed, 24 Jun 2026 17:22:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5174020339500575796=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: sco: Fix a race condition in sco_sock_timeout()
In-Reply-To: <20260624213304.1460149-2-iam@sung-woo.kim>
References: <20260624213304.1460149-2-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5174020339500575796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1116158

---Test result---

Test Summary:
CheckPatch                    FAIL      1.08 seconds
VerifyFixes                   PASS      0.21 seconds
VerifySignedoff               PASS      0.20 seconds
GitLint                       FAIL      0.45 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      28.74 seconds
CheckAllWarning               PASS      29.24 seconds
CheckSparse                   PASS      28.03 seconds
BuildKernel32                 PASS      26.10 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      491.15 seconds
TestRunner_sco-tester         PASS      31.94 seconds
IncrementalBuild              PASS      26.32 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: sco: Fix a race condition in sco_sock_timeout()
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#109: 
ffff8881115d5070 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-{0:0}, at: rcu_lock_acquire sect/v6.13-rc4/./include/linux/rcupdate.h:337 [inline]

total: 0 errors, 1 warnings, 0 checks, 24 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14643876.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: sco: Fix a race condition in sco_sock_timeout()

15: B3 Line contains hard tab characters (\t): "	      sco_conn_free()"
16: B3 Line contains hard tab characters (\t): "	        disable_delayed_work_sync()"
17: B3 Line contains hard tab characters (\t): "	                           lock(sk) // <-- SAME LOCK"
28: B1 Line exceeds max length (155>80): "ffff8881115d5070 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-{0:0}, at: rcu_lock_acquire sect/v6.13-rc4/./include/linux/rcupdate.h:337 [inline]"
29: B1 Line exceeds max length (152>80): "ffff8881115d5070 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-{0:0}, at: rcu_read_lock sect/v6.13-rc4/./include/linux/rcupdate.h:849 [inline]"
30: B1 Line exceeds max length (148>80): "ffff8881115d5070 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-{0:0}, at: start_flush_work sect/v6.13-rc4/kernel/workqueue.c:4137 [inline]"
31: B1 Line exceeds max length (146>80): "ffff8881115d5070 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-{0:0}, at: __flush_work+0xd1/0xc40 sect/v6.13-rc4/kernel/workqueue.c:4195"
34: B1 Line exceeds max length (128>80): "ffff88807db3a258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: lock_sock sect/v6.13-rc4/./include/net/sock.h:1623 [inline]"
35: B1 Line exceeds max length (133>80): "ffff88807db3a258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_sock_close+0x25/0x100 sect/v6.13-rc4/net/bluetooth/sco.c:524"
47: B1 Line exceeds max length (82>80): "       process_scheduled_works+0xa99/0x18f0 sect/v6.13-rc4/kernel/workqueue.c:3310"
63: B1 Line exceeds max length (81>80): "       disable_delayed_work_sync+0xbb/0xf0 sect/v6.13-rc4/kernel/workqueue.c:4514"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/349

---
Regards,
Linux Bluetooth


--===============5174020339500575796==--
