Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5277F394496
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786418891; cv=none; b=iNhwRcwQxc38CExQCDkGKlCOvgf91WRW24qCTcVPpCi2fb/FVsMmXX0FgpU881DXsls5qMg/s/nPj2LUUI6TPPs9L85yPm9MPTjE9+V5BVnOahzheR10vTQjSxrDjmPugZ4Gr/EDnueHPTu0fV5wjrJa3n0mFX82ZGnCVxrfFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786418891; c=relaxed/simple;
	bh=n35oIzTh8SACAuU0wX2d0y5TUvShgPlwU7+xyslre8E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H9m1upZVCU7eWqqTuxRpXVo29kl/ao2bey43SfWOwdX9p2bcFJg21lUcWUdtjlvNO9gGvx8IGzY3GrzgW5E0vSm9LJcNd64E5JT0uwo5zKAVfNZoQFbveIozwAbh04KptpiKuhtHDDNfgYmXryGQPg39qf5bEFdFrzQTgJR0GGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5q6V6fX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5q6V6fX"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cca0c5799eso25550225ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Aug 2026 20:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786418890; x=1787023690; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1R0D93cEVrdvuTHwnHMRyw2zK2a0o45qN8c16eyKSMw=;
        b=V5q6V6fXoDq4qYJZVGNSkz+T9W0lf7WUGrt7olx/i+qYC2ckE8xmuNqvNIapwKjeLE
         SOHqxiWPLbd2LsykIUT907iX3EXUQ6/7EzrBpcnA/hZtXeNxrf6U0zvEZekQdmaon1gy
         EdD5h5rMevV4fDRwO1jdilRCQaU+3w/vIoBbAwhUrQmPJpka4DE/Z4J6OxqY2L9n9S+F
         nVaeM6LIPevwH1iV522dZvfTEuhGV95vQta2VcDBzUlTgU7gD7lVLBwBSEAtkov6f7WQ
         bvFLt8A0/F8PmJ7y09/+2ExNGVjuJ/Owg+9+PNXYcMEKKWFI5kq9uqrxN80vIxEI02Sa
         iXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786418890; x=1787023690;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1R0D93cEVrdvuTHwnHMRyw2zK2a0o45qN8c16eyKSMw=;
        b=DmTAWY2qlrreD8/t4x7OkRHD+4S9SWGHYdHz3n5Uybvchzxsg1tsC3w5kPit6bWH17
         CCoFXlv4mKcBZTUDK68Fx9hzJFCmuBrOSdOTOk/dPruTiLfw95GrRIJrUOaUoIo0i4q/
         6YcGuWDUiLhUB2wmqvu9v5MIGdYqxlAf9ANAYtccuNbPg6N4QOXVJwivo9nADOzzWu1u
         4BdRU3HuzNyrLxm2BVvkdaRbK3oT4vbmApt9OIrO/M26BOjyD5SRuuecwZa+T4AZE26v
         STNuHLcW8P+3Mj0v+gSnakL4DAg7Wwdzk7Uk/w8RB443UX4mAhDrX950BN32Fdjxscmh
         C6ug==
X-Gm-Message-State: AOJu0YxBNv4yNIr2tNZ9DYRiMQfHvN3C476n0FU2o5EmsSEDvzSdgg53
	M3yznMpNM/3629fR4XPdU9PWvXdkrJ6uTVZT5PMKuPL/jUX+B+PXx65SH5Gk3Q==
X-Gm-Gg: AR+sD13TTAPdI1qQ+NyWXpVD5C22xbFyPRTY8rO2XqdpfFCGyBgWS/cw4/yBSu0cCY5
	YfPps5ka+1/OdnLJcSP0r8WWqlXWJcvsVAnHmEDZjzfLrwrhmvt8sfap7zaZIPau9VLpvFz+udw
	r1Q/KTodVt2D1bNM+VSQQQsn6M3Yw+jFUClHhP+NiRfkiUv3cX/TFu3BnKbK+HIO9Fs5QIcgmUy
	n2+gwJBMjdkfvXdZ1JDTJAZ2m3SEBrxxilXXjEpFNDboN69ezugGlJBbM7IR/sI7Cr2TRun5bpH
	jF//VYtKn/jVbX5L7cQMF0dygDgcpBzc7YVSq+bI8uDYoj9hfECAwdGB0m8Mcc3o3AESbFsPoHI
	4A3AzZjqD9kRe0mIghCReUZu4wPowXClM571psRpRoBRTiRabO+/uoQ8iMKsljflTM7wvx26DNq
	RrGf1Sf73tjh/2LIlTyY6sYbbdedNC6YjUODh9P2X/XNQSGYGebyGwxwb5wvoC5sUGYQ==
X-Received: by 2002:a17:90b:4d11:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-392ec59cafcmr179368a91.14.1786418889566;
        Mon, 10 Aug 2026 20:28:09 -0700 (PDT)
Received: from [172.17.0.2] ([4.155.111.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5190d05sm1704912a91.3.2026.08.10.20.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 20:28:09 -0700 (PDT)
Message-ID: <6a7a96c9.2bb73dab.28b2d.eb4a@mx.google.com>
Date: Mon, 10 Aug 2026 20:28:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6121363468193001262=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, daniel@makrotopia.org
Subject: RE: device_schedule_reprobe(): core helper and conversions
In-Reply-To: <anpxXANMYTlOHbPo@makrotopia.org>
References: <anpxXANMYTlOHbPo@makrotopia.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6121363468193001262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1143724

---Test result---

Test Summary:
CheckPatch                    PASS      2.79 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.77 seconds
SubjectPrefix                 FAIL      0.25 seconds
BuildKernel                   PASS      27.53 seconds
CheckAllWarning               PASS      30.70 seconds
CheckSparse                   PASS      30.35 seconds
BuildKernel32                 PASS      27.17 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      502.65 seconds
TestRunner_l2cap-tester       PASS      63.14 seconds
TestRunner_iso-tester         PASS      85.31 seconds
TestRunner_bnep-tester        PASS      19.27 seconds
TestRunner_mgmt-tester        FAIL      219.15 seconds
TestRunner_rfcomm-tester      PASS      25.44 seconds
TestRunner_sco-tester         PASS      31.90 seconds
TestRunner_ioctl-tester       PASS      27.55 seconds
TestRunner_mesh-tester        FAIL      26.88 seconds
TestRunner_smp-tester         PASS      23.87 seconds
TestRunner_userchan-tester    PASS      20.01 seconds
TestRunner_6lowpan-tester     PASS      23.47 seconds
IncrementalBuild              PASS      30.37 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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
Read Exp Feature - Success                           Failed       0.252 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.786 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds


https://github.com/bluez/bluetooth-next/pull/567

---
Regards,
Linux Bluetooth


--===============6121363468193001262==--
