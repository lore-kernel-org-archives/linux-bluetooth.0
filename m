Received: from mail-oa2-f34.google.com (mail-oa2-f34.google.com [74.125.231.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB853B2D1D
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Oct 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791139754; cv=none; b=euWHzyXYiLCr/4iXLwqMGLVs1K6WX5mjz/JbmclIa9M6fdOOHFaW0jqOPfj6KqQDhYrWYtdRZLANimlfU1T3CW2ogB5gCzN4i9XkFEwcGhOzICqB4OnyASWuMAKR6YRr42bB83VuICeuOC8WU6bUUJqOwKgO75sXYRqZ7n7dY30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791139754; c=relaxed/simple;
	bh=ovvzMuNKQJxZdOVfT04guJhmsSL9NP/LEuI3YXtrT0U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ufVZC4nyL1sxBr0/RvASwVBgoLSSFdEefcUZAswO6DsfEtSMQg2bqABxG/KK9UO4PzFrtauV1TkiEJfHKLag8QzEOGaamQsEnNmmLuNw5e27H+GdZ7vLfl7u5VR8AaTclmefCpGgZds1lBFQtyssDOw+5ysRe5Y/rogwUf+Zo4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxDQU+M6; arc=none smtp.client-ip=74.125.231.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxDQU+M6"
Received: by mail-oa2-f34.google.com with SMTP id 586e51a60fabf-49de2e8c135so726985fac.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Oct 2026 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791139752; x=1791744552; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=shnHAsSRcW56DwPANK32+EKbLPix/SjDZafuGvbhx2A=;
        b=rxDQU+M66GNjkAkUUS2ppbHOUllOTat90pGahX6YnN9NHtQylm71wABEr7YoHkvz3c
         xaZqHmyAwsyjWSoRxos9AjKjjowRajC4e6lIZ+npJVSfsLstOLg7ovl/GudMfTPfmwWm
         A+gsiixUb7HvMymzYrwvznm3ZSxe331XmOnwaI/cZkOXGDd1cIZdm5gUASpRs1RnSUYa
         0+mT3HfZe3/axvAijUMA6MuLghS8QKUgLt9QU07Vrqxu8FA1ilMbUMsG4RV6CRxfpBxt
         6thjQ1y1uek9seNwxsHSK9gRM4lnKOi05adxPSQNs34j7FNhqxuEC5ibWJQi6NeCz+pM
         nZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791139752; x=1791744552;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=shnHAsSRcW56DwPANK32+EKbLPix/SjDZafuGvbhx2A=;
        b=Zco+lJlIeZ6ytbcSN8AQbRH0yNFwA916q99LC766Fm9xkEShfvOOiNdTuvXWcexb8T
         mX/0pPXO7ZJwgo+fOcYj5rdOjCBp/LIOlVXWxBIR7sLGi2pIJ043+zjoxxvqVtL2G/0w
         CKxzqF1+cnFI1A+Erqq2WiHclIQ09ct8GmfGrnKP8xOkYKLpSXxCxLctRk+pSp8XWTgb
         SDJPaZiBPv9FgHTkNIjOYGb4MfTU01Ki43sx6XeZV4VRwdO+5RyTXD7W4tjIMNY9kkhv
         x03qsu8C7GX9UeiH5gUFz1Up9+1gHIrghp6DFIyGm6+WMyGRF54gqlJb9VBgqUFk8ip6
         iI8Q==
X-Gm-Message-State: AFq9FYKUtErbBY8gcFfWL4jNKo0RuhKZK/k1c7cBGXf9p/P967FmAIc5
	iv83K3jC7jK6HtQJL5E36yMNAac7pwLNVpXwKb0axCzkKSPWLz2LJjuhnHHd3a/5
X-Gm-Gg: AYBFou2UvQpPSORgn8Xt+MRtgQCMVDoFFSvWmcXDPVhLVU+GbI0xjJwOIp5rCE/QU6Y
	bN8p7JiyqsmfxdRB4qi1OSPWKCmOGanSlFHxrDLW1SuC8O0z9pOo6g8dPVwZm2ZXPlncr21NZHf
	DZMjuMM0geJn25sb6biImbcwZN4q6+K2b6ZOyxLGt1jbq+wDtQlv1WJ/ZU1w/hanJsp+dK3/t6D
	t5sg1UvqWmU+w7x13L10ZpTJx4pm+Pohx7hUZYWjY12UBFs1sU6HRd5yxuLs2R6XLE5GL38wZZq
	mKz/OfWGonm3XCaKqZR2m85AUPFuicZF/ihpiRyCBVAgOFe5P3M9sATEyDaCDsAjtDMxIboLYKu
	cHPM/FRkboTiNuH/RDC4303WzBAzYOWcN01iRN2JcxnLOacwM0TzQg02KVQMBWc5nZ+kKSnVgNf
	DDeQGMk6qY4Oq7hojWZQavvKLQnWWonPQerKd0gtrfQDayCM1kvzz+YLJSXQQpQxMKbJQ7Y6UQC
	RAznCU=
X-Received: by 2002:a05:6870:65a9:b0:45e:25a9:5455 with SMTP id 586e51a60fabf-49e15a1c9ddmr7224866fac.2.1791139751942;
        Sun, 04 Oct 2026 11:49:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.202.53.216])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16a4ecacsm7512195fac.1.2026.10.04.11.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 11:49:11 -0700 (PDT)
Message-ID: <6ac29fa7.7a6cdb81.1cef64.5ae0@mx.google.com>
Date: Sun, 04 Oct 2026 11:49:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8356953708793178778=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: hci_sock: Serialize dead-device detachment
In-Reply-To: <20261004162442.3968446-1-nicoyip.dev@gmail.com>
References: <20261004162442.3968446-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8356953708793178778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1179168/

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      17.93 seconds
CheckAllWarning               PASS      21.07 seconds
CheckSparse                   PASS      22.36 seconds
BuildKernel32                 PASS      18.78 seconds
CheckKernelLLVM               PASS      20.96 seconds
TestRunnerSetup               PASS      461.36 seconds
TestRunner_l2cap-tester       PASS      12.94 seconds
TestRunner_iso-tester         PASS      8.82 seconds
TestRunner_bnep-tester        PASS      2.76 seconds
TestRunner_mgmt-tester        PASS      54.49 seconds
TestRunner_rfcomm-tester      PASS      3.97 seconds
TestRunner_sco-tester         PASS      4.95 seconds
TestRunner_ioctl-tester       PASS      4.09 seconds
TestRunner_mesh-tester        FAIL      7.91 seconds
TestRunner_smp-tester         PASS      3.91 seconds
TestRunner_userchan-tester    PASS      2.80 seconds
TestRunner_6lowpan-tester     PASS      3.96 seconds
IncrementalBuild              PASS      18.58 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.709 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/855

---
Regards,
Linux Bluetooth


--===============8356953708793178778==--
