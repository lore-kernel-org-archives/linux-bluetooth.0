Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4F52BE32
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689284; cv=none; b=RVrMzjGOKIeNXyFoX+df+PO61WXtUGDErj15qcIE4z7uAHQfeR7eDbj+TNNN2sCt2YKn408xkJtJkWOFVbymxrGXTEtWyoGGyUcksCC31hJ1WxfePmI5lFgAwOotX6c3XWldSqk1pBLQ4HCjCT8F25Kn6LXPZ2ZEvuiuZSRfFz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689284; c=relaxed/simple;
	bh=hDQs7T11Iq+HPqkT3yKUSiIOsZkEOl2uAfbSIqWICcM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hjoPV8cUbaMyWUWDcJT+KUaElGBqWf4Jbo3gDnu5GDaPhZyFPONBYoXuA7RVZY15qrWRuryV0kSdtgAZFdukuO//yB8JnJ7O0V3cWBfzd08HcYU7VeyLjlCz+UExGdbYh4Owp17kQ3PxR7ODz1dsjKRhIxTDyKl2Oi5AIAYth84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rE+xs/cW; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rE+xs/cW"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91071ba92a8so18154186d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689282; x=1791294082; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ti4b1UVBRQwQ5jYLf+us6xchz9XGU2BudjQRmCysDfM=;
        b=rE+xs/cW8AILbm72gfp8s2IAhdT3F+7IKytAZy+T486PMhGxynRRr+jVD/SBUvTa9c
         S0LDhaK9SD9hPg66HtdB0QO7sfSsxVFORzXnVomFpUfkLHHOPicjtOzIM1SVGredRv8j
         FRvI1fYwdwY75IlsKt54oVOr/0dcdHIxVHOwYpRRASiUEppScp/lutQZKl+qcwTeqjfC
         UOZwyLTD/f2lF+WKMqDQ5CcqZ9S0XxLZ+mIsyQv7lMOHjuMptRuyPp5NauGfgcvZMRKn
         KkBN4WVnVIiJ4gI8y1o1O2TrVqTwflbRxX4vbaOrLje+VZsXLHSA1PTIKucXYb84gGwV
         2z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689282; x=1791294082;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ti4b1UVBRQwQ5jYLf+us6xchz9XGU2BudjQRmCysDfM=;
        b=hUdoPAUp3uu1p/9dgXiRtlPKvICajcl18wP7yHDIK74Mf9sUxZqQQIWas92kQo0yVm
         viyVO3EueSECw5HrtGcjPRcgTbarJJmnqa5BeA604pqwwVcvjE7voHS5D/2fGLJyhYNE
         Ujy3JH9/LGkzT/nls89KLiXbzHtggcgSVE+n7g354Y6Fr0Y//OQfXrBobLTOCXfidJFO
         K7tYwqv30PjRAU8jUddfF6tAH5QG+mK9CPAH2s87/ru1PoX2AhssKwmnPNz1hndm6CUv
         UTZvWVRKaREuDS7PFr0vBVaP0M4mXJWG10bBxwB070Gp7dGp1uAZzXs/rZUmQny/+3zn
         GfLg==
X-Gm-Message-State: AFq9FYJNRcFIFLdXPtzUZBc8kTnz12TC2/2ZFlwrtuBOHZq8estYpOiS
	/7nUR4WouT90oT01tjhHTO1OaJe/a7RJZjYJoC9WDR+1haUTbWC+RDNzMhAkFg==
X-Gm-Gg: AYBFou0ZhetNEXPLEUhS9OvgDQw5PwcEfyRbgwqyrnYi7weAI4ovQXHJ0tydDOF8hYh
	Ge58QARCsVii71u+2KmvjAChTkI518g7cwc/Q4AwMZ/5NA5INQnKa1ZTAWYAwM7T6C6qfSkyf1o
	QQbAQMQRlU63Ziej6leJzhwDaVCOD1VeuATTFH5iRHZcmMMJ530rhi+IlCYGjRsLkFfs9uhMM2o
	VwFApR9D8cPQSQYcs/FFo0Xm3EH45TKLoWzDcv3UjuACtvX7kVDtiHmyydigiqXez9hAJtOM85Q
	r6n2qc2D5VVZQ3UBJBLE7DLh+tK7cckHAs0wi+DikaXSf1T3665kco+27UP//czOX6+y9HZUgx9
	zZS3zWDuOaXHWK84htu1nRCK+icEcafQMNspCAC47XAcYKux3goEtGmPIi3cb2ComIlAoTsokpA
	bqV9dFmztr/gKPbGSygQwLdi0w9MiE2TECUZ8QnEDQoH3bkLzQBKa78Hioka8Rb+2GDYnTNrKyH
	6YJkg==
X-Received: by 2002:a05:6214:c67:b0:917:8cb3:f31a with SMTP id 6a1803df08f44-9178cb3f895mr23864596d6.40.1790689281832;
        Tue, 29 Sep 2026 06:41:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.93.132])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9178d3726b6sm10357246d6.39.2026.09.29.06.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:41:21 -0700 (PDT)
Message-ID: <6abbc001.2842b724.394609.9de0@mx.google.com>
Date: Tue, 29 Sep 2026 06:41:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2829466906803770881=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mikhail.v.gavrilov@gmail.com
Subject: RE: [v4] Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex
In-Reply-To: <20260929122226.98970-1-mikhail.v.gavrilov@gmail.com>
References: <20260929122226.98970-1-mikhail.v.gavrilov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2829466906803770881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1176103/

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.90 seconds
CheckAllWarning               PASS      34.12 seconds
CheckSparse                   PASS      36.66 seconds
BuildKernel32                 PASS      30.07 seconds
CheckKernelLLVM               PASS      36.83 seconds
TestRunnerSetup               PASS      799.74 seconds
TestRunner_l2cap-tester       PASS      12.68 seconds
TestRunner_iso-tester         PASS      19.07 seconds
TestRunner_bnep-tester        PASS      3.64 seconds
TestRunner_mgmt-tester        PASS      61.28 seconds
TestRunner_rfcomm-tester      PASS      4.49 seconds
TestRunner_sco-tester         PASS      5.62 seconds
TestRunner_ioctl-tester       PASS      4.68 seconds
TestRunner_mesh-tester        FAIL      7.84 seconds
TestRunner_smp-tester         PASS      4.37 seconds
TestRunner_userchan-tester    PASS      3.25 seconds
TestRunner_6lowpan-tester     PASS      4.42 seconds
IncrementalBuild              PASS      27.15 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.404 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/841

---
Regards,
Linux Bluetooth


--===============2829466906803770881==--
