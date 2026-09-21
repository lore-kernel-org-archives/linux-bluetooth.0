Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9F1CAA92
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991077; cv=none; b=fdxRzSXkpDVhbZ/brdCgUeGCfiYhsOj1jaIlkaqYH1MxpGKztGYxDP8sm8SIcEgIucnvzdOZbClUqE4pfP4omg9np0YQAPJkdl8Aw7GJ3EvpNh8fJ3uKZwvF6WtFDftF0Sw2Wq7b7Y9hw2dLP2JhuBZWln+/vmnExtgJr3D3EbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991077; c=relaxed/simple;
	bh=y3XlIrsvIdqUKW7kMBY2bN1VgEriEiPbixnA/AwqiSI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BPJPJXj3unRTPOUE8uks454bLDyEjo3/9y54F0qd8Be9DQZ2BiVDxhEEBqIhOLVjkqOoP3bcV5A5tQpdK5Fw1pwWUooCKe5nXGj9CcewPpcO5j2ZwAzYXG/ZCi8cFC5o/FLzDEt5TvL5junBv4uKyRSAtPsRCwVXxQKtcGWs3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWP6n0YS; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWP6n0YS"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a36887bso1476126b6e.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789991074; x=1790595874; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iC399ZF5xA633nIK/7n0mbYJgvJpdHpId9EFRhQw5RQ=;
        b=bWP6n0YS9ebBecBWj1ig7A8NVH50OwM193ttUqA03dEkqB+jCuBUS7ytK2L2Uqfk1X
         AJYsMOqaussgRFM/frzGwWnTSVpYmqne1Fk4XhcyEA5p5tEcXOOfjqAQ42L6Hxdq3jF8
         X+8N3e02+Da39Fzzx7AUKx66NFptoASeO8X2AXGVWG04Y8UxNmFwkt82dWlyw6OXK0L/
         nJPBgXxROrmG+QaZ8R9m2w8puXXgMaRnm/IrGdOgYFUVmvb+DF1bz1llMECQRdR0xVxM
         CYgQzSEWg1FYtIsP0uZd7mhO/c5bAQdf6AMslLxCt0bOe6uuauJ6Qw2RezSska+D/tu3
         V76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991074; x=1790595874;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iC399ZF5xA633nIK/7n0mbYJgvJpdHpId9EFRhQw5RQ=;
        b=aEkw09ga6brSwEooBMD7lzppkDsFQcB3OqlaAMhiVItPdE36HYb0n5MFHEBLF3UM1Z
         NzNSTE/6X9WRiWJr1bba0aufy+TghdOSIZtwZWrewTrwjeFCWguKdc2QgajubwclBbiX
         h16FWxXOYB1oMROSznPZeD5Ozoq1CTICnqOdoUUE4uKmg2Hj6uIjTWDKn/Ezl60s+kQO
         Xg5c/UTie4ROyit8dRw+OJ72bgy1f7cq6+1pIvHj7cRUS3Eo+UIL/qj4ZzQgC2yVXQxE
         MUU4Wk5aBbDKJColqs+o5XksP/i4H5jtSzzm1S24BzZMAaJRDyXU8tpBeofGa3Ow8e+U
         as+g==
X-Gm-Message-State: AFuF++lDJaT4pTMkMWNtZ9XGQwe8aSz+YKHP4GMUzQwEUoEqRVdE6OqK
	1R0GH99vnW5mKva8p7vI8FNLQGs7yXDoSQHqCMdmPPP9GJItE3RYzY78l9RLvQ==
X-Gm-Gg: AYBFou3IpEjtZJcWFwb4AfVZQGc0h3gPE7LmiX6AsMThnpHhk1cJcxYOZ9y4mkRTGEY
	oD3XoU4JmFh3V+iwbW9/Z19e9Ge+fP0xqgfZREqxXsJnDrIDj6zbGElBTfADwSdEqwwTfjaqneC
	1/pz1LJ2WEFkMdndHOQ+84A3clm9FJ2KRql0hEyBmEI2c773O2P7UlRbBLVUQIgWjJUR1pC3dV5
	6ae8ckWjY8zoRqnV9ZNuCaSap0i08FpZdhNYdM4WY4I+UYA2E2G6pG8yajmgHP5ltEwXt+DtTp0
	DQ1OLqjUKSPPUcYmq1A99G9tCx6HYjPSNl8MvRJnFB8zxqpL3uuMXprLf9ulMka1WKtIhLvjW9T
	apgU/Rk1CwivPiOZ03TowWniYYyOWnw1alCz8C2VD+jZ8ReR4RLOFkwYxXq7vhWOXE3l7I2gOPh
	wGI2PKLFc9WerkFJLQjXiMUV6y9zovrJpRCCVd4bA9sMWhLlRe9aemRqRNDgkhxCVjTT10+NyKL
	VWnwq/7
X-Received: by 2002:a05:6808:6808:b0:4bc:3b8f:2a38 with SMTP id 5614622812f47-4ccf977661cmr11789845b6e.43.1789991074394;
        Mon, 21 Sep 2026 04:44:34 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.214])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4cf3ef44580sm5831032b6e.11.2026.09.21.04.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:44:33 -0700 (PDT)
Message-ID: <6ab118a1.6510e82a.29e60.5c06@mx.google.com>
Date: Mon, 21 Sep 2026 04:44:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4154921050428468811=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yanli.yang@bedmex.com
Subject: RE: Bluetooth: Add AIC8800D80 support
In-Reply-To: <b6dc98c56da4c5ef8da3fad8004d6e0245a73b2a.1789974593.git.yanli.yang@bedmex.com>
References: <b6dc98c56da4c5ef8da3fad8004d6e0245a73b2a.1789974593.git.yanli.yang@bedmex.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4154921050428468811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1170116/

---Test result---

Test Summary:
CheckPatch                    PASS      5.29 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      1.00 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      28.40 seconds
CheckAllWarning               PASS      32.90 seconds
CheckSparse                   PASS      35.55 seconds
BuildKernel32                 PASS      28.49 seconds
CheckKernelLLVM               PASS      34.42 seconds
TestRunnerSetup               PASS      751.80 seconds
TestRunner_l2cap-tester       PASS      16.32 seconds
TestRunner_iso-tester         PASS      28.59 seconds
TestRunner_bnep-tester        PASS      3.14 seconds
TestRunner_mgmt-tester        FAIL      60.07 seconds
TestRunner_rfcomm-tester      PASS      4.45 seconds
TestRunner_sco-tester         PASS      7.54 seconds
TestRunner_ioctl-tester       PASS      4.62 seconds
TestRunner_mesh-tester        FAIL      8.76 seconds
TestRunner_smp-tester         PASS      4.67 seconds
TestRunner_userchan-tester    PASS      3.20 seconds
TestRunner_6lowpan-tester     PASS      13.28 seconds
IncrementalBuild              PASS      33.50 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC,v3,2/3] Bluetooth: dt-bindings: Add AIC8800D80

18: B1 Line exceeds max length (90>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.019 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.452 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/807

---
Regards,
Linux Bluetooth


--===============4154921050428468811==--
