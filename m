Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC03218E91
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 03:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790910874; cv=none; b=EjZU0wIrgHG9ffa8n93njbswGLr+w1xl7QMoYTd2Q6WZPPTcPGHDeM3WOmmfC5IQ/BpUFoALNczgsHDhJ4cDhb+B3JY207MlhOXhIsHPqtmkIxGYPaLZsPUpgcfKfQTVEgWqSVYlutiDR+/US9fVsNBbA+aF07bj20JaIa75tRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790910874; c=relaxed/simple;
	bh=ERaRJnHrVb0scTinncU0PE9C5h8DAFOAXKafY3Agh7w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ttUdo5GuRyukvJnHPHfnnNcA67LG5m3WHKET/9tOSL40ZnvzSjhXlXqlAUufOy7ifaxEyzf9ipc4PKCaS26E9b3Bt8cthnS6YQLd7BX1ncPZiNoMwr8jPBygwlJ9Z5s0cFjDhEejT0/2ytokfxye5ahKF96KRpWYxguSNmUjLEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho2SfmUI; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho2SfmUI"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso7108698eec.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 20:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790910872; x=1791515672; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=628qQiCQwp3JKk7DcWgYAnT99sKh3nKkF4D/4rtiXvg=;
        b=ho2SfmUIZYBzX50eB3TkLfH3+6FoWVIWHOj0nW1jxxVBNUf2ahC2+jDGzSM/nY9rDn
         hO9s/lo4+WlqqW6AxB+pJNXDrPCVJMXZlepRY54yfGRm6F1s3VQ3q4AY0IkDiAPrQRVk
         QR8ty0zDhwAEUV1zCc3bb6OyAsKedEqaRkI3pYGTSr/pNfBrrf/jmsZVqpQqIUqclNuN
         OvZs7cMhjYpjyIM0hcB4vqTuk+j5tdxwjQEXfPUdSd/5DLt8+gWal9JX+kaSiP++H16D
         0SQnK8QvvFmtUYvi0O9TJi0Y9IQbAp6WYSBs+BoNSpeNqyCzeMV2A9IjuR6FmXoo/rBx
         RKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790910872; x=1791515672;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=628qQiCQwp3JKk7DcWgYAnT99sKh3nKkF4D/4rtiXvg=;
        b=rI/aTTub4gOseGK0PO8oOjpSbm+xuvWdbsifeuFxPNfc2LFRHeMLmPxJ0Tr92bo95k
         33tQOwJzXmPOCkIevuRmojomiI6lgKq5QFtqKZ3GlQw6pd6TcR74i1DhmhRZ74oLy6uU
         RLC3yTY1QI/esh/OuU/rgSU9nL7cLc0G09/m9RNoxviyY5WJPF8XCayDGgSY6rksz20f
         GpT01YFiP/8o3isFOsYEYBRxtj/ZvlGBjpeMzAMD0tpFKZzmUacVozPJJ1Bv/inYEeh1
         EH36dDN0JGW0wPOfyjLG6qL+s+KQ1reY6kat9ablKOaIHx1Usq+eY7TZIXaBeM/8TaFB
         BeUw==
X-Gm-Message-State: AFuF++nATh6jGC0nVc1FG3m/pat9Sb16Oh05yKEXwrypnugD5Xnlafls
	KAGKNWYQibPl7Nm49urr80V9ibgz14l0W3z/ht4YFmOdODnJ1RipJm8InzhUFg==
X-Gm-Gg: AYBFou2y9OtY4xpuz/+P3odTg7waBHESME2tX7RB7DP3mHmzBadq23K+eTNrnp08TwJ
	fpA1lGHrWKZtx6Af3hSSj0YcPnEqIQXSuPZffpNGCKjk3NkoeF0/Lwmrpy8zrM3xNvlUF+B6fWG
	QKwsc4yeVTpba9VDc+IYeNBq3luXqMqpP68g/FqOCqw7JedWyyRqhuA9rJq8ei5AFh8DKdLbbel
	L9dGQJ8EXM5bluT0BVJBTWFRf34qzL6vchdmTq3BV8uJXsCU+Mxy0oNT4bzjeUafXeKPR4BWbdM
	OcF4Qcffu48dko/JUXFtk3ELikcYnbp22qNsk7ZhJ7bA58YeCp3Cgn7zfJ0iBwQATO0Rk1YYXKJ
	szGke6tRBCvELm3XLjBbwrXoBJSriTcRK3tjmDlc4WRKIiQjfmkN7g8ZLZOldv6aPgM3WEnYz5h
	d8nnR41Q095KYEgWqaWLJzpKAYtA7RQBB0Ks5OfvH4yjLcRqkqKMqfNkmVGeCfQ0pWBlmQADTf7
	o4DMfEM8Old5pk=
X-Received: by 2002:a05:7301:5408:b0:33c:e82:70c9 with SMTP id 5a478bee46e88-34f21985c14mr1456329eec.32.1790910871910;
        Thu, 01 Oct 2026 20:14:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.93.183])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14ffda2dsm2547006eec.26.2026.10.01.20.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 20:14:31 -0700 (PDT)
Message-ID: <6abf2197.ec46f90a.b79ba.26c7@mx.google.com>
Date: Thu, 01 Oct 2026 20:14:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6749424341099928390=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: Bluetooth: add hardware rfkill handling
In-Reply-To: <cec8b1c81c62ec805bdc4c32e59515d92e62cc65.1790905146.git.aluvala.sai.teja@intel.com>
References: <cec8b1c81c62ec805bdc4c32e59515d92e62cc65.1790905146.git.aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6749424341099928390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1178028/

---Test result---

Test Summary:
CheckPatch                    PASS      1.50 seconds
VerifyFixes                   PASS      0.86 seconds
VerifySignedoff               PASS      0.74 seconds
GitLint                       PASS      0.56 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      22.65 seconds
CheckAllWarning               PASS      26.26 seconds
CheckSparse                   PASS      27.89 seconds
BuildKernel32                 PASS      22.88 seconds
CheckKernelLLVM               PASS      25.29 seconds
TestRunnerSetup               PASS      566.67 seconds
TestRunner_l2cap-tester       PASS      13.50 seconds
TestRunner_iso-tester         PASS      9.48 seconds
TestRunner_bnep-tester        PASS      2.74 seconds
TestRunner_mgmt-tester        FAIL      56.99 seconds
TestRunner_rfcomm-tester      PASS      4.01 seconds
TestRunner_sco-tester         PASS      5.04 seconds
TestRunner_ioctl-tester       PASS      4.14 seconds
TestRunner_mesh-tester        FAIL      7.64 seconds
TestRunner_smp-tester         PASS      3.91 seconds
TestRunner_userchan-tester    PASS      7.88 seconds
TestRunner_6lowpan-tester     PASS      5.01 seconds
IncrementalBuild              PASS      23.03 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 503, Passed: 502 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Pairing Acceptor - LE Security Level Changed         Failed       0.020 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.668 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds


https://github.com/bluez/bluetooth-next/pull/849

---
Regards,
Linux Bluetooth


--===============6749424341099928390==--
