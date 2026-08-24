Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36FB40D576
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572155; cv=none; b=J4p61AkltNYYPvv++oh028O/svRYZbXYp5LBJzsaGYtKdMVZY0Ep2GpT1ad8B5YXwCmuE3KFiTl3KFrcziygaVcSMQQOgzJ43F6Ep+q4rAwB6iegl5dyaEkH3KlWJu5e68e3x0p8YS/u9p76mzr8xIVuQhGydnxbyxlehYzY9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572155; c=relaxed/simple;
	bh=GCmUz1H0CLAzNINaaMEw4ktu9MwYQG3tSB1QOtw5pu4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Qzn3HmJTaqAK7Scct7I5p0459qfk1P9+r2u7W0vFm4O5MWBTPFIFsAOiXJKfoWqybDzAIWckwHUNyOPG3iEdrHD1q4XtM/a+RHXPmDA9Ba60BYlWWyaxqh/keJrepNe4VojzrnZjBLvbYOBj1xy5jBPq67BghrP31aRAvVcCe7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5PHYgHA; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5PHYgHA"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f0167e59a3so2363227a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 04:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787572153; x=1788176953; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PBnc0l0zF8aJGPpR5IzeNXXHnsWUE0gQMe2KwJU02bE=;
        b=e5PHYgHANwMP/nmWPNiI3gO9try6NrSpJn9iI7UM6D5Agdig8ViqfqKCiKMoBFD4EM
         dz2SaGs/qsLACZbBKh6hrcMuv00QGHoQJkJ7CiT8Zix2Fed8aGxsCqnR3e7WUycfbtuQ
         gBO6GDmd79j2g50zUhCD5L6cxDtHCOWJyGuf12FvSZgdB9+k43dqbdnXmmtRq1Cpmnhh
         NSZj4c735meJHm2rTY5UB4Pueb0P4scGmUV86PDJqFG2phi3Liya2loQf8gSfkMLE9kj
         eyYnqrcp1PX+Txiu58hwhY5SmaFOoVIwyEfPf8KHq+aHlHrjL+Bip8sGCZqBSRChBXUB
         LIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787572153; x=1788176953;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PBnc0l0zF8aJGPpR5IzeNXXHnsWUE0gQMe2KwJU02bE=;
        b=oO2ZPHi+mgk5CddAwGEXqtdN2yotW3N26maRc1B1dGkrEevYm7xwEyTHoSvnMh8IZD
         NZfzFn8+SxIu2U1sJXULweiH24LmEt4VYKkdbs+rhmTxDyo1VUK2DvYQvZueIB9a3bQA
         CVJPASGM3y5EWX3nlwnW6eYoHd6ohOs6kO/ZwuuB17ilgcIFWYYo5XDTnzI+AkkUC0Qx
         h+Uy96mf2k0UMorotPpUwFYSaV/TOPjCfxFqNHKGBDdkvrJCGtONXuIBMqhX160xe15P
         oSVPbJm6B9DpmHgzaiDl5JpHyv4V5iNtBPjHGqiv2AWtAVe1Mnm7M4DZ2z0djYbkkK0U
         wFlA==
X-Gm-Message-State: AFuF++nVRD2jSU+boBE/xC6bdSoaD5uRwtuON8WbQcvZ7NCpYdy64Oip
	dWioe10f8OKi6GO19wFYSx8WnC9kbUx9Y2uVoY6g0/5euAKv3h/Dl0C7UQ9zyQ==
X-Gm-Gg: AR+sD10Fy3wd4+p3I7VPQClHLTNHY4brBg8B0TxtcQ5ZfjoMfJcvDcwEPTB+GnpXt7v
	KhNn0+XEsSzgvblJ9vx3PF9ou0Im+3ZKw2DxZwm5Dbh0F8KFI3ylS8Q+nO5lNNQa5sYSXcbPQYn
	Enc7N0HBqapGzJRBr+CvBYSRl0HXENmt5zkN4rKFNUBI4Ikl6ezbRT8vFdVmrK14tYkRfI2hLnW
	c+HtbTO8LkWoFuDGNjoH+V4qEGFjVcmner/Li3u73lCwJqqxa+F5XyxA3riozBMY3T1hFzo4myF
	gNXmKXtGJ//NkEEaFZBDID2dL6QFzQWBRkLIXj+lQECm1nVyfIDuImpqD7XhWcsGPxQ8f+BM1GA
	JwJ6At65ZvGRZr6jvZBoh8TLqKdDC/WZMZcH+T7/p9KWHpeuLp5/85k9MMmivc03RTBwUUJEe+m
	9M3l21UPxJAmjA7FZj65XlhxnA3w6Jb22dQzU6QPzTd1GINp81SiYN+nqipRBWcSGN9ls=
X-Received: by 2002:a05:6830:6af8:b0:7e9:df1f:6a19 with SMTP id 46e09a7af769-7f47644e037mr20550503a34.7.1787572152762;
        Mon, 24 Aug 2026 04:49:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.32.169])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fc4e6e8sm3898215a34.18.2026.08.24.04.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:49:12 -0700 (PDT)
Message-ID: <6a8c2fb8.a5ccebaf.1b2f1a.b1cf@mx.google.com>
Date: Mon, 24 Aug 2026 04:49:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6643333293770851017=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, radek@podgorny.cz
Subject: RE: [v2] Bluetooth: do not leak an hci_conn when a second LE connect is rejected
In-Reply-To: <20260824110020.5423-1-radek@podgorny.cz>
References: <20260824110020.5423-1-radek@podgorny.cz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6643333293770851017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1150809

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.16 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      5.56 seconds
BuildKernel                   PASS      20.96 seconds
CheckAllWarning               PASS      23.54 seconds
CheckSparse                   PASS      22.26 seconds
BuildKernel32                 PASS      20.13 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      369.28 seconds
TestRunner_l2cap-tester       PASS      56.83 seconds
TestRunner_iso-tester         PASS      71.09 seconds
TestRunner_bnep-tester        PASS      15.61 seconds
TestRunner_mgmt-tester        FAIL      198.21 seconds
TestRunner_rfcomm-tester      PASS      21.10 seconds
TestRunner_sco-tester         PASS      27.74 seconds
TestRunner_ioctl-tester       PASS      22.17 seconds
TestRunner_mesh-tester        FAIL      22.58 seconds
TestRunner_smp-tester         PASS      19.29 seconds
TestRunner_userchan-tester    PASS      16.47 seconds
TestRunner_6lowpan-tester     PASS      18.98 seconds
IncrementalBuild              PASS      20.07 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.217 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.497 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds


https://github.com/bluez/bluetooth-next/pull/643

---
Regards,
Linux Bluetooth


--===============6643333293770851017==--
