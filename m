Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DAF3382E8
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565082; cv=none; b=RUMO7B+1dYlPZDZ9eEEuDAaeeHUuGg4eHPlkgDGdmHhSl9IJd4kADyeyv/LPPmMtWUzXZ8zZcbj+guEZK+Z/jYhR54+99Ib3YJN/KYVut34u/WNqce0M0oyuAtaC1ij18i4dNzzOSzqkDnWaiGWSgFKYxbrMh7CFr2DiC7aBz/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565082; c=relaxed/simple;
	bh=v5qqv2rLZIH4pP9pnx5zTSH5vX5XIH6JbfKSf5gGXYw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nOf7G2SuBcIo1D2fuh0BMyE/ivx3elFT6mD7WCUsQnDvPZUfdFjHQqX/v05RsIYrcjMArxB4d2VbnjJIEV1qm75WvbpPv+RT6XAHx8rVsjfZDbO93a9Xg5Hv57XfempBf0epr4BBOM7SYWSUxhRbBKQVLIxoespGlXTg+9B3ji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY01XsYu; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY01XsYu"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a6ac6f389so16961936d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 15:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774565079; x=1775169879; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2h1619nho8zT0U/I3AspC1hp4MVUNEbbjiAJq3tRCM8=;
        b=hY01XsYuUVbBMcHm2kjNuGhLwKB5C9DdFJBUmSZrqz+JACxjWIG2zg7qBKEU1lc92h
         6eGiZERakJxh0rRt5hr5UzjFXpMFA3wvFI5aqiATZkoZ8vrEiEz1ARbivJ78fGLugHnx
         2prRACN7y3dVFLdPFZPiBVeEMskPos+TY/opbo3FXH8UFDRM8U8fJiVWmyZSnzABBfHg
         HTCks1N2UfVpd6EEvfyopp7DoKOcXtDVCeU1TMplA+W3Ul4pKBThgVPP0CXjYKUH8+a6
         ZCk8eZ5NgI+SatUdVaSPZKOztGSrtk3QEbpMSDRLIxg8QxN3lSzroOdNikPf3D4N6FGM
         CRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774565079; x=1775169879;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2h1619nho8zT0U/I3AspC1hp4MVUNEbbjiAJq3tRCM8=;
        b=tEeZENJ/COsNWxH6HC84D+FIax7iIASLCpxYj7uXKU9tzQQNmjmOs06nVPsqcWJqbm
         88H5g5fxzEEUw4MyLXtT7z3vVMEUu5XFN5ow52I9Cv9M9V5eujIxwGd2fvJmE4mHPQAM
         HOWHSMqczQ/pUMPiLE2JpizUR1ke0oyNUX9mQJV7ijtSjSroocSIAKIpEl4NYlwLHAO/
         JmTnav+QX5c0eLiU9sKWIZIfbQMR1M7+I6Ry3BHMfb480Z3S+gs1QAI99SH0L5J4ZDA7
         3ZLdPLXFv1wg+jTHXKA/anMcZ/1y4bg9LSEpu7w893m8DFDoUo6AAMBl7zgswpHBgEje
         Ad0w==
X-Gm-Message-State: AOJu0Yze9j1FszOHETsY2pS9+OB2ZhQ9abdeJiZtwOb9NxiVBIbRWWHa
	oJcyPBy2J6xKkuh4gsxos+PyuReO+UB6czgfwKkvihYBTVtYTK/SB8bOjTjE0Q==
X-Gm-Gg: ATEYQzwGCuAbYwlE65JUKLRn7At9f8xD0lWaQF2+oH286OUu12h7yNGiTmP8EI3Jyf7
	qxJ4jtp1wcEk4aOVPO2eVJLd33kvETKkDt3oW8cQ7sjgVSfJOvvIRK9yioMY53GWtL5l8i5UHZN
	SLeKOGFndwkIS/Ln833S8aKz1Khs8DCZmc60qsP+kB/a38cDuPMWUAslcqLC3ieHnPFZk9zhQvf
	c2cjLId7Dnj4AhgLKy91mhUvpTwygSnGT5snCNwRtYKjO/s/YYQUKKWUQ0IjVpcwDX7YCMMqu9n
	yiF2vOcxCb1MtCHZp9dhO/IY1hpDlMF6vwXtdCIspvdD2E6gLk95LxB12Coy564AfcJnpoVeLlC
	yB9afKsCAFoDXkFRrttcRgsf7D0KZAhfjlGogq6KK04YfMAyHfftfQO+ZE92KYDduKW9r6mJjrj
	j19OcpCPdvbmOHMpO0RghvMPUGnqvjFCYVPCZAonY6
X-Received: by 2002:a05:6214:21e8:b0:89a:157a:39a6 with SMTP id 6a1803df08f44-89ce8f96a9amr1827006d6.60.1774565079233;
        Thu, 26 Mar 2026 15:44:39 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.121.203])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5aa2999sm32546676d6.44.2026.03.26.15.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:44:38 -0700 (PDT)
Message-ID: <69c5b6d6.d40a0220.38aa09.6026@mx.google.com>
Date: Thu, 26 Mar 2026 15:44:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7302417914447257277=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, floss@jetm.me
Subject: RE: [v3,1/8] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
In-Reply-To: <20260326-mt7927-bt-support-v3-1-fa7ebd424323@jetm.me>
References: <20260326-mt7927-bt-support-v3-1-fa7ebd424323@jetm.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7302417914447257277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1073200

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.99 seconds
BuildKernel                   PASS      26.86 seconds
CheckAllWarning               PASS      30.12 seconds
CheckSparse                   PASS      29.18 seconds
BuildKernel32                 PASS      25.81 seconds
TestRunnerSetup               PASS      573.60 seconds
TestRunner_l2cap-tester       PASS      27.82 seconds
TestRunner_iso-tester         FAIL      38.78 seconds
TestRunner_bnep-tester        PASS      6.40 seconds
TestRunner_mgmt-tester        FAIL      116.99 seconds
TestRunner_rfcomm-tester      PASS      9.56 seconds
TestRunner_sco-tester         FAIL      14.26 seconds
TestRunner_ioctl-tester       PASS      10.17 seconds
TestRunner_mesh-tester        FAIL      12.46 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.74 seconds
IncrementalBuild              PENDING   0.51 seconds

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
Read Exp Feature - Success                           Failed       0.115 seconds
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
Mesh - Send cancel - 1                               Timed out    2.750 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7302417914447257277==--
