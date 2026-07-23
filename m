Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29D3909B3
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782717; cv=none; b=OoeFPmS5zTfXlrZWeM/1luD54pogb9dfYf+gccY4X/ky8zxJylKgsMQgjUyhkAtDlSEx0j8CrdvZHUDP1CXJ8Gtqf/O+EfnB1uQCqO00uqwmfSm9zLulrjktqak9rTZS9Sxg+XU7OqqYgOxIgeis5W/FC/XqycxIZlKxxb4lI2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782717; c=relaxed/simple;
	bh=aNc6MQOonkDBcv+QZ++l8RbcyIGzwIXbFRCQ8H+ctpg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KWfTt55mIp6SNo8NJiozNrv8NDVRP+gGYBxAvfA5mxaAyFEdRRs5HhNJ7TWnYmrfEW9MYa1u+sxSFg/8HyAuPXIot3/60pZQHyxWwa0/YuULxZy0grgw1FZ/13NqYvBykoa0OLLZ5L4YL2l/fC+5+t4CTgnLuxx55aWQeuyr4SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ge4gC7Kx; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge4gC7Kx"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e6128bd9b3so98623a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 21:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784782706; x=1785387506; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iOs+GYizcd/rtAVPH7uSzVVD/nQt8UTXRpLkRPdsiqA=;
        b=ge4gC7Kx4CXtlN5pnKjQOkRz0guNcNAhgz03K6M37YaPK68wnTxsmBEI/57V5aIohp
         6Lb76CTYuBg16n8E+lZipEagwrKZtG0cqZUzOoJMga7skwC05aKo14JVChj2ZOUgTfha
         sWKG8ZRgHh/1XQsPzdA1BRnc1nXlV92dB23y+VpsgqdmEiTHoPI3ISNIOlpQ2odQEpaW
         AL/GUdPcFtJQCorUfWty8Dgd3mqj40OHI8x7mQJbGWOdcgnKCNR9Iqe86ve/Jx/6617X
         77HN8WOW3nnUf3UjPzCGhoK+6NFi/krUztrbgkeNShfx7205mzvkQEDIlGV5zRLYcogz
         bG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784782707; x=1785387507;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iOs+GYizcd/rtAVPH7uSzVVD/nQt8UTXRpLkRPdsiqA=;
        b=R0TxGez4YjBUlE8Y7YvNhfRS9P/hidMqYdbgcx+Ag0bCyXmEU7kKUSJUsdI8XZujXi
         IqLWB9iMHsPFvjFeSFDP3sHQFGis5pDuho46TpwJpVJDME4RWorBAJtKR1wZhN5m8ojj
         Q0rC6vNYtC2kmkrAMRwMQ/QF2JlVut3qtIIz4+CicihViSZPvuto7RcpUEgAtW101lr9
         QXAf8lluEWoICGroGDY++T2Znvbexs3ni7zDVZiVmlBWyHVO9nTHGJyTfo8YxKBpz3vi
         IQaWUxsxB5Mi4pevxyTfrVR5mjCQaC2LXWvKRExpNo/wMQVucUwOvFoC9zuUZOIDg7op
         WhAw==
X-Gm-Message-State: AOJu0YxqGQj1tZavhA2RwN+T385DpJ1UiebcCve8FjzKsK/h5RXI1AzB
	bdB0ZHY+1+Bk5uWRZc9l3WONqxBLkzcRpZVZuLAf1QAmdoC3y5pho+lGVkU00g==
X-Gm-Gg: AR+sD1110wxNTwzQ2YMn+k8Srou5mj32lgjnwU1g59vW7/1RGTn34M2+jNfbkbfeVIW
	qgfnV4ElhgfCL9HMUPUD8yik3AnKoz8Hr1MI/7ZXSg4y3p/0CeHJExGoI6son5tBSmuJp07AovA
	QaGOGdKPzqeGfcZKV0MqqonvJ3dYOPBiC/4yE/G4qmbsneElWrJ2+5AxNMZpVLJ4IAsI0/Pw/m6
	4jgEj3pF4vlgSt7SovnAC98NCPETYpEyRWu3k2wRdUChSJfTrOQCB2GU69NgCHKOzGBchDR+SUS
	axWrQeaWtquOMt1r95o4eKub3EcXQnAYhsnFFcEs1cXwfBlHjA/o83+2ywjvMmujQWqWgnKf9zv
	7eyNAQF35rLkgCplxMBe6n7edJHMQaI+ZITQJC2cPN6Q3vWTV4kwmwZDvW80ZQS+tmCX8RA8qSZ
	RDqLnAVTw=
X-Received: by 2002:a05:6830:3c8e:b0:7e9:b4d0:5398 with SMTP id 46e09a7af769-7ee44212bcfmr912241a34.25.1784782706564;
        Wed, 22 Jul 2026 21:58:26 -0700 (PDT)
Received: from [172.17.0.2] ([40.78.177.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a102120sm2775894a34.26.2026.07.22.21.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 21:58:26 -0700 (PDT)
Message-ID: <6a619f72.6b931ad5.2fc95c.8c1e@mx.google.com>
Date: Wed, 22 Jul 2026 21:58:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6447675028888655231=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kudo3228@gmail.com
Subject: RE: Bluetooth: HIDP: validate short receive frames
In-Reply-To: <20260723032807.1616487-2-kudo3228@gmail.com>
References: <20260723032807.1616487-2-kudo3228@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6447675028888655231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1132870

---Test result---

Test Summary:
CheckPatch                    PASS      1.15 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.52 seconds
SubjectPrefix                 PASS      0.33 seconds
BuildKernel                   PASS      21.22 seconds
CheckAllWarning               PASS      23.42 seconds
CheckSparse                   PASS      22.62 seconds
BuildKernel32                 PASS      20.69 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      378.79 seconds
TestRunner_l2cap-tester       PASS      54.95 seconds
TestRunner_iso-tester         PASS      78.97 seconds
TestRunner_bnep-tester        PASS      15.98 seconds
TestRunner_mgmt-tester        FAIL      205.83 seconds
TestRunner_rfcomm-tester      PASS      22.50 seconds
TestRunner_sco-tester         PASS      28.89 seconds
TestRunner_ioctl-tester       PASS      23.71 seconds
TestRunner_mesh-tester        FAIL      23.67 seconds
TestRunner_smp-tester         PASS      20.84 seconds
TestRunner_userchan-tester    PASS      17.63 seconds
TestRunner_6lowpan-tester     PASS      20.98 seconds
IncrementalBuild              PASS      23.07 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.253 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.049 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds


https://github.com/bluez/bluetooth-next/pull/479

---
Regards,
Linux Bluetooth


--===============6447675028888655231==--
