Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010A73D9DD4
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400169; cv=none; b=UMPeA7R/LXkWJ20IvuHrf19QIT7huCk8Tjg4wY+ft7ZFQnToxKfmAD1uUfLY4VyIzlp/KsRsfGzx3VGfk53sEixtPkHnnaYPnSlqqBs9EPinRpxhBNU0piO8ybGNjjpSH3s/IGbMQXUwCD7w4rFXmgQv7pC2aEM0iICaSSkP8Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400169; c=relaxed/simple;
	bh=sdUPDnrlkMIdSZR/E8J43jOwPK6BXFFCjxyAsqi5xGQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=emIixw0vFAMkcVAE/wK02Cd/7MCOlp+tJBPf5qZn7x8vQfZ21hZIW9mpWkpI40q/vI3dk4S1ML+oJSaeNA0AsA7Xs4XjdTjusAMwxD+cpN3YI2zhxPafCH90dJH2gtqaWBmnih9CWsukJLL/F1C0eI7eE5Tu/CTsO42tU94Fa+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3PbbF+r; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3PbbF+r"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9156b74006aso124135285a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 04:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780400161; x=1781004961; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t/sD2o3zTigStzNKth0pXu4OTBXdfpH2FPz4Cr2b30c=;
        b=s3PbbF+roYco8Ox5RZbpr4By+d0NKVmI8cDYi72fxMplst6GcRjc5pRbOoQ1GeidD2
         BMcesOqfhx02Hf4fO1H4p0B8vYIxIkiyeG4v/6yBP3bRxhdDFprxZYU4Qu8gBifcBgj3
         sPo0sCBab70o4qeKoQedjJIkLUjML4tQg0dF3/8AXJEjZf5pgL4m7rPLt6qXUuHce05+
         0VTZflp+zWd+3jxoULOrUsa2IpevNmcLgfDT8RQRR8kBn1rl/61HX6Cd5yjYi8UOqpka
         fq5aECi9rIuFupqW/+c+AhDa+RQjfMLxUzDvA13jtivATJNoFv7qjdo/eY9+05T4/CsD
         W4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780400161; x=1781004961;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/sD2o3zTigStzNKth0pXu4OTBXdfpH2FPz4Cr2b30c=;
        b=WgygIxnxoVdu/RyKSbsCYEZFuPQ5cI3DH+btcxUF2Sj1zaZyu71/CY7GDUtA5JGs2h
         PC3SIC3C7VDT3CoZyeyinO9MsGLK4Ec12dJd62CY8cNi54h3R71/Y4TgM5vcTnYTNvjp
         Gg0Mr+EPRRf9yZ/h6IIoCZpdhUCvwWRK7IFvkWlPsmPZQUdwwlQKKGgy2qYxxNNHGJuo
         10ZKcocpFz/FtdFvOzTswU9KXMqqL2zvds5Dm2sGb2HPVu0yWsgB0Zi1QZBJYQGWi8EO
         2LxWhKTeEulCDShabhIoB2q8bQihEadU7W6cZ8pmc7r8SeZeMAufaK/dCshR3dBOX898
         SKAQ==
X-Gm-Message-State: AOJu0Yw4AvIxLaAksUmjdQN12W56sjQlJcTN9vHfneI2v5WIM7bjuOkV
	vDAEhn4QHQ3GH4lLNBj3BpLfoakiajlAM/GuZ6wzhZezksFX/Vd5kRunw2+hyA==
X-Gm-Gg: Acq92OEEL9PH59B3EdD2L6s9ZBgOj+SuyAh+AhmzjZbUJK10z/KPgaCsP8LGT2AJ164
	aEWnoInIweYX93BRcVqSA9XT7z5bgRz4GxkRfSf7le3U7nm6ctJHGzdOAYVpWSyowJA67C6Dhsa
	8Al6RMPMsWxd/1l6hfWGJYSLvdk8veaRm8QBhDm4AbkPSPQ3tHlQjAYjLDPrfLmhWocSSCIHXIr
	nb7+iPAoSjLxgr0NXzU14HYNuLAi3gZxblRNL0/xCIyaRXSQpbk1+7OYHk8EUbYjlU1Nictf1Je
	YOk20jqb9mKYOJjOwHSRWr6MyMOjE9HBqSaAktW6mjac/4mr/ZosJ64NDFyQHv7pGzlvldYyX29
	KaSD/nnGet/o62USDgI7oEGvgboTNN7FXeJ+ZXj/THsNXcSLLmLinwTfwq7kr417uxRHUsPigWU
	uil1RFQVpdoLSPyuGMrUaqWn+w92+3d/qAm8oDtePPtSw=
X-Received: by 2002:a05:620a:c4d:b0:914:c0ab:f1c1 with SMTP id af79cd13be357-9153da2be0emr2407268385a.49.1780400160765;
        Tue, 02 Jun 2026 04:36:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.205.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915741c9f06sm298335385a.23.2026.06.02.04.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 04:36:00 -0700 (PDT)
Message-ID: <6a1ec020.749c1c74.1f1c0f.5938@mx.google.com>
Date: Tue, 02 Jun 2026 04:36:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9046035781277968158=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liujiajia@kylinos.cn
Subject: RE: [v2] Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING
In-Reply-To: <20260602070032.51248-1-liujiajia@kylinos.cn>
References: <20260602070032.51248-1-liujiajia@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9046035781277968158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104423

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.13 seconds
CheckAllWarning               PASS      27.92 seconds
CheckSparse                   PASS      27.22 seconds
BuildKernel32                 PASS      25.43 seconds
TestRunnerSetup               PASS      522.36 seconds
TestRunner_l2cap-tester       PASS      57.70 seconds
TestRunner_iso-tester         PASS      76.39 seconds
TestRunner_bnep-tester        PASS      19.10 seconds
TestRunner_mgmt-tester        FAIL      208.55 seconds
TestRunner_rfcomm-tester      PASS      25.54 seconds
TestRunner_sco-tester         PASS      32.18 seconds
TestRunner_ioctl-tester       PASS      25.97 seconds
TestRunner_mesh-tester        FAIL      26.03 seconds
TestRunner_smp-tester         PASS      23.19 seconds
TestRunner_userchan-tester    PASS      20.07 seconds
TestRunner_6lowpan-tester     PASS      22.58 seconds
IncrementalBuild              PASS      24.00 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.237 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.593 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds


https://github.com/bluez/bluetooth-next/pull/272

---
Regards,
Linux Bluetooth


--===============9046035781277968158==--
