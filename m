Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281EF3E866F
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350401; cv=none; b=WvuIz568s9hYPQi3YiSCpgx/elzXe5WJACIhtLvtuAhWr6DT4ByoNiFGjzmB4U8++B8zrWwTdicW6lc2EaAbB2clTCT3MhGELDelQDTcKeJ6+Rc3d5qW5AfHzuoaOnbZj2pAkX/rlN441ShX0nXw50ImEOc/CsGEBUv6/eff8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350401; c=relaxed/simple;
	bh=zKDHuyIlD0gQAc3z1t39tO1LRqw7avs83LIpdA9TMDE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lovhMBjYsHI8lhvYU3u7VNW5ntPtWL+vUKIHijBM8zFpJIXt6mUHyLo5KL3VZIMHVIefvX/DXhKCv/vsd8D8Iz2kif2IJvfbM0yEC7u2pL8kFndXbY3Dov7ygdnOx7UosFIm2LkABR2+VXS5ImPZ+RowFEUZyUYDy4rEYHEmv0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqYYfXKp; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqYYfXKp"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b69bf5638so13792281cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 04:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774350398; x=1774955198; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S0P6h8tdoDXl4qzzOGEO3QQE0EZfxmJDs4Tz1aA9mwE=;
        b=RqYYfXKp7D/WCr+Q2i4wOurz+Ams0avaGmbxn+mU7m2HqGRDoJfRqJli/s4sMg5hUs
         lPwbDY3L4E0ZkGo4acYkkobeQdufRomY6AlDGkM7M4KYJ+0Wjq0RYnjsUHGbU4FHejVs
         h99nlLmBY96eWr/AyIv2Gfv62VWdi2N5dR5vUmduL7fKgdzmw85/btCjz6ozB+waOyo5
         2st1QzFVInhkAVSwvJS8sUWFI6VCGBXIAVBr3L0qqLvo/6UvsAvec37fbuuzP91AK9B5
         lI7AmNSeEi7kZGiPhNmkBcYLkpQY3Upg0Yg7bwmSCkp+5sqSyG8wnLE3aJ7fVfx+52q7
         IdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774350398; x=1774955198;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0P6h8tdoDXl4qzzOGEO3QQE0EZfxmJDs4Tz1aA9mwE=;
        b=mgU+CY907980bIbTh7WGldWg3qRn7Bn/PADAlWumyBFhBHUFI9/wIRSKwIWqnCx03n
         Cz125YHIFgTj6OoRA2atPmjf6AH6JUvgki/j4aaK1Vw4aCSu1qvvvr83cSWjZ2L0dAEN
         a5TqFFmFkipdvbQWxF9+6Gmu5s31taghjGQsialkOyaY3Pm4px1dkJ0/DZDYM0jSJ4q7
         ziKXEzU31ET7PaYzFX7dgGlE4OG2sZWboWcTk+j2U/wZ4WESrE0V63gss0easrV1sFwT
         6nB0eZWfGeToeFyrgb4NaYSFqg75ABbw20nzpDMmMNK1RQZybGm+BN1XV4S+Zmll931b
         lEOw==
X-Gm-Message-State: AOJu0YzcE2pEa4RmqvRMVH5euEVBehaT6/BMFvH39Kd3csVtOxDNFBSN
	1UG+4yDfPLpM/MC7+ohk3FG5nMcC6JneZ+0cr16VV7Fbh561YQr0gxG56szDEg==
X-Gm-Gg: ATEYQzwBQ1MAOxJKzIc4jNp6a8Ngzt/2e6E3FmjoP+Wn500v3y9jFeQBaFDaedkh12a
	axQed2kukBxCmzrOFknQa4dtOYF1iII9Z5WngatuQIcFV5jEUzkmOl/ttQRJ9K0LHvKchMFhyd3
	04uw7APlWIh+9cwPph2LmbWyWbVGmHnZSHRkzMZqXKe9mJWr0EVzd7D2Vh4nxITqX6e/NpQ/PTA
	oMo0UcJiSM7pe4/VmULwcx4bqjcKPzHbRX2ChnHwvY34Ns86tNkYiry3ltx4sQc5rOhkegL8xtK
	OghYhZHt7gT6i9byTIZjf1SNPUoO3j+NlEiJ0AHv9azRl05WdXD8Ll4WdsfqT1yXByx9+ShINoX
	gxuCoO5hd/ujViV7BNKeORovHaDxJ7PNXuowyjDsWT1E6lz84f7VFjiDvKNn8aX4vvxCbVBl1fJ
	9GDNG57QPFP28tSs672Kao1I+miNaLEQ==
X-Received: by 2002:a05:622a:52:b0:50b:37d5:67a4 with SMTP id d75a77b69052e-50b37d57012mr234675211cf.27.1774350397530;
        Tue, 24 Mar 2026 04:06:37 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.122.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85214a43sm114579046d6.6.2026.03.24.04.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 04:06:37 -0700 (PDT)
Message-ID: <69c2703d.050a0220.d98ba.caab@mx.google.com>
Date: Tue, 24 Mar 2026 04:06:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8502160311247622868=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, berto@igalia.com
Subject: RE: Bluetooth: btmtk: add USB autopm support to btmtk_usb_setup()
In-Reply-To: <d854c37829bb084ddb1e60340de6b207505cfb5b.1774348119.git.berto@igalia.com>
References: <d854c37829bb084ddb1e60340de6b207505cfb5b.1774348119.git.berto@igalia.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8502160311247622868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1071561

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.35 seconds
CheckAllWarning               PASS      28.76 seconds
CheckSparse                   PASS      27.75 seconds
BuildKernel32                 PASS      25.28 seconds
TestRunnerSetup               PASS      562.72 seconds
TestRunner_l2cap-tester       PASS      27.55 seconds
TestRunner_iso-tester         FAIL      38.48 seconds
TestRunner_bnep-tester        PASS      6.23 seconds
TestRunner_mgmt-tester        FAIL      114.01 seconds
TestRunner_rfcomm-tester      PASS      9.83 seconds
TestRunner_sco-tester         FAIL      14.12 seconds
TestRunner_ioctl-tester       PASS      10.23 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.52 seconds
IncrementalBuild              PENDING   0.83 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.908 seconds
Mesh - Send cancel - 2                               Timed out    2.006 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8502160311247622868==--
