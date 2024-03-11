Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DDC45974
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171229; cv=none; b=flxVY476J/41OY8vpNeKsYVqbqCrBRHv5IKQrrDnCzLlCruRyHv+ET2JO/a2zt+3XOhMM3Hwzdj6V8loe/uz0C+fukzoY/V6667YruFChMoZ2w9cT4d69M8amenbckDeTzZInnOm7PVL4uhFN6yG8QqwTD6mlF1QWRFswddkCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171229; c=relaxed/simple;
	bh=FJ/HRZnMzLmJPNY/vcSUMoZXd6dp5jxLhEln9XfpPsI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tbjuSBwngEekmHdwWOQiqUBFob7FqtJ6vqREa2RFiHSKrXFHxWXAD+DNya6Jd0jqYGzMniS1tNWcBHEgUUtXr0amOXsE829lRNLtjFY9H2GjHV2Pr7OTDQz2lmFzWq5Ic0tMMlT99/GMLdq6zjVsklGoC2wnyuq2JiX11w0uohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcXDYd1o; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcXDYd1o"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-690c1747c3cso18543916d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710171227; x=1710776027; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/Al6zGpthwRRALkN2lbbL22v5jF6tQigBSoW3rSepKc=;
        b=EcXDYd1odHNJPlpaWQXXr0xDvtIXBKQbmFodmEsL3DM2IBGx43Oksc9hymyGbDjDb9
         e3caAJu9O8o3lZtToDCeTalzTVd8TX41GdFwKsRKu6r8eurApH4fuZ1tWiMqddVS6lYJ
         Qyiu61/m4yr34+XitkyMWG4pJ/z5FpfGP9xIfI/f3DRSkZfZI/AaTDMGstZuokaEl+Eo
         DuLn+/G1lKfqrxjZ2XwnOj7RDHuxR3ho2T30u8OOIufl0mymUEnofgM8uASRQ9wf6y6s
         OVh9YKssqt+k97Z8RzQuR0vjVLGRvFWtgURlvm73w0d9gFe+IcYzx40iFDedGRK+X5u4
         LEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710171227; x=1710776027;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Al6zGpthwRRALkN2lbbL22v5jF6tQigBSoW3rSepKc=;
        b=poRRg6O+8oy+0nf1J7moRqGGoJgmmMGLmIW4Qw1N2D2RZJdDV15ZlfM7P+NTzVH1Q8
         oWO4EVmq5SS5st6GxfTkKZE3UIs2q5VWINxbsY0VTV7RdqvuSAp/gLuIJvko68maiC/S
         v5V3N1wZfLoI9lOY1b6EWu/cBsIsbGahb1UWZuxuh1Vn1bJKWYHCP9VaLO8L0cSl/A1x
         nKuMvEPIIayjbaJJXa4vKdEFFfK4fY3MKhpDfd1/zKpItpSGkHhcxyoIy9ucV857vx5N
         NLIMqB9Hs/y1cBkWKFcQ7M9dER8T0dDktTLkTBz1aoLDJ5FooFkvEN0hIUqTSL8eURQi
         bIqA==
X-Gm-Message-State: AOJu0YwiXIpcNabL8x717vufXy9duKEBDj+l+HSPkM8LL+zqeWrYIiT6
	VXt7O2lmn085KKb2u2xhMCNbeoPt1UZNJpQC4NcrhTVrgY6ypVRqvtF1lNYO
X-Google-Smtp-Source: AGHT+IHEKMu9MjgLrLuKXfe84SthIoZ+SDlN4TxJI9gQEUFBJuVRUDbFru1XI9pCJD10myo8Ss4r8A==
X-Received: by 2002:a0c:df87:0:b0:690:b39e:bf0d with SMTP id w7-20020a0cdf87000000b00690b39ebf0dmr12514724qvl.8.1710171226943;
        Mon, 11 Mar 2024 08:33:46 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.119.26])
        by smtp.gmail.com with ESMTPSA id z4-20020a0cfc04000000b0069097b23cd9sm2717760qvo.105.2024.03.11.08.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:33:46 -0700 (PDT)
Message-ID: <65ef245a.0c0a0220.623e0.899b@mx.google.com>
Date: Mon, 11 Mar 2024 08:33:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5446683865108649364=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: btintel: Use proper prefixes
In-Reply-To: <20240311143703.751323-1-luiz.dentz@gmail.com>
References: <20240311143703.751323-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5446683865108649364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834337

---Test result---

Test Summary:
CheckPatch                    PASS      1.23 seconds
GitLint                       PASS      0.88 seconds
SubjectPrefix                 PASS      0.36 seconds
BuildKernel                   PASS      28.45 seconds
CheckAllWarning               PASS      31.07 seconds
CheckSparse                   PASS      36.61 seconds
CheckSmatch                   PASS      100.32 seconds
BuildKernel32                 PASS      27.52 seconds
TestRunnerSetup               PASS      524.60 seconds
TestRunner_l2cap-tester       PASS      20.49 seconds
TestRunner_iso-tester         FAIL      39.11 seconds
TestRunner_bnep-tester        PASS      4.98 seconds
TestRunner_mgmt-tester        FAIL      114.65 seconds
TestRunner_rfcomm-tester      PASS      7.52 seconds
TestRunner_sco-tester         PASS      13.11 seconds
TestRunner_ioctl-tester       PASS      7.89 seconds
TestRunner_mesh-tester        PASS      5.97 seconds
TestRunner_smp-tester         PASS      6.96 seconds
TestRunner_userchan-tester    PASS      5.12 seconds
IncrementalBuild              PASS      26.97 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed      10.209 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.167 seconds


---
Regards,
Linux Bluetooth


--===============5446683865108649364==--
