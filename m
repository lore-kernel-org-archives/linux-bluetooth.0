Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20403E1CE0
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774347216; cv=none; b=SLLbPijn4VwG/rIdbAhse6c53VmydlxHLIS4gCYhaJMnBKUjlzK5h81E+S9tliM4e3VunX+loR5dbH01OM2iyk/PzTrUOu3oXIDdBY6kTWqt81/GjjDsqZYlfGfSimIWWwLabqjyIFD891L08TGaI/H6g2pXo2x89dlc9AvRggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774347216; c=relaxed/simple;
	bh=MKsCzwIPYO4SX0JbfauricYS13M/IVpg4EfClNdlM5k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ohZvzb4qFdUeEZo08V1qDBQTjB9JUiuQg8rnsPq73pClkA2y1hNOkokv/zEhvZaSXVdPErEfULg2neZimR7L5So4uwTuYH19N/+eaazKOkclmxe+dkhGzr6sqQ2DpWl4VXdcrQijAN3koO0dPJz86vku2pHtjX1qj2Tygm43foE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+7JzxiH; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+7JzxiH"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1271257ae53so1170034c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774347211; x=1774952011; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=alaePAkl6QDgj1HQywaoIsHdG1uspvSIjTss5t5NPNY=;
        b=Q+7JzxiHYXKoYQaap5GJOvT7Ez6olSr3esmZpo8TM6rpeum9cnjU+SU6eIJs+HVl8y
         8YGfMljEx9YN1N2DORP8EUPZ9Q6u1VSDYJ7bBNFdJ0K5DGpi1RtkDwTG0ykLD0+9tq8C
         SYRJeYN5bbgn6fdJeksY0VyPLIwm3jlh/YYEqLgXM9n3ZARVS6hulTKriZX2L9dCCIAU
         KZXLM0wECnLd74kYErOaqvNBWQexPD/7ZRzpVdeL0ysGyv4jZ5IUJdxtMeJ1FoqoMC3J
         Ea6yqmDMzkxNzNkQ/sdbdHAItLErrxRDK6Lve3BVBZQmIbL9yoBSozP8qY9hrSpFSLGF
         F33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774347211; x=1774952011;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alaePAkl6QDgj1HQywaoIsHdG1uspvSIjTss5t5NPNY=;
        b=CB6QN4DDnJeFLeXq+hEQdQI6PXPuNNIZr7RQCYDoXLDBtDZDgxKvuNumI+XoGk1sMB
         oB7MqWcLHDwmF4iq1lAdSCpsRJgZmr71J7mNAwzpo/BbFCcY5RroiG90rQqvniAs+u7u
         L3NVghLt5NKaiRPqIOD6GwUCivr7IXLhJJSJj+9PSSRAUIPs8rBnZCLX4qgm4JvFkMOF
         BPI3eQb4NVo5WYq/wPH9/h1fb8UxNzhjSWuLOhkRo8x/uIIt9o70I3yyKwm6/VFy4z4J
         yanuWtG9aOvDYgos4FbUGtibyqf6KWzkufzpwwAd5ntIlhsFz997ZV6Nl6TzFoQRFith
         aVcA==
X-Gm-Message-State: AOJu0Yy0p9YGsBlehCwaneM3J7PL/0Ay1OXmiLdIJEwxTCWTR4S4lS/E
	KAUmeQYBQ7THebG/uUJtgOx4Ed6TemivhN714FBpOP5lXt7dLF/5dYJKq2dqBg==
X-Gm-Gg: ATEYQzwQ3ABfOdWDSfACN7Hw8K+TRwpFuUk/plpEcer2IQ+REJZLM1pSBjnji//oFBJ
	p1pwx42XKoASF/dRCegnxpffDEIaqNYhiMxFnazkyefuYlLnGlWpJwy6ehpofObH325BlDY3xMW
	2KOffdfgRlGdHqLD6dIn648zBcYY+cxHcK2bpnuOQlMlGva1gTq5WQLc4c9PcO1BwgvAFEGmk7q
	jN/6cSNFUuKIfJUnKPC5QHQC4MsFBc6xj2PYPjVzu3I26WC/whvd4RgZ3Pj+sEMyzaBXzx+/HEO
	MkVRtsooG7JSwLIVDCmxIf6dIDIk7IRQzE7BxAKRaN9RqwiB+b44J2qbsGny3naAIUCnONQtn8E
	Ozo1lt5R8bFp6odlY6sSFnXOz/pbLWjHTFITvpgRq63bKRJp6yEp11/zHlc6kL3m05+y60hjHh7
	C2zlKfRY2oDAwVesOoShnyiWJhxiR3e5I=
X-Received: by 2002:a05:7022:68a3:b0:128:dab3:f528 with SMTP id a92af1059eb24-12a7267415cmr7344423c88.8.1774347210316;
        Tue, 24 Mar 2026 03:13:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.195.131])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a7330d1c5sm10519869c88.0.2026.03.24.03.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 03:13:29 -0700 (PDT)
Message-ID: <69c263c9.050a0220.38fdf9.1ca6@mx.google.com>
Date: Tue, 24 Mar 2026 03:13:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9015562048647882479=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: RE: Bluetooth: btintel_pcie: fix TX queue off-by-one
In-Reply-To: <20260324085152.74986-1-pengpeng@iscas.ac.cn>
References: <20260324085152.74986-1-pengpeng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9015562048647882479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1071503

---Test result---

Test Summary:
CheckPatch                    PENDING   0.55 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.28 seconds
CheckAllWarning               PASS      30.18 seconds
CheckSparse                   PASS      29.15 seconds
BuildKernel32                 PASS      26.89 seconds
TestRunnerSetup               PASS      587.68 seconds
TestRunner_l2cap-tester       PASS      28.58 seconds
TestRunner_iso-tester         FAIL      33.90 seconds
TestRunner_bnep-tester        PASS      6.61 seconds
TestRunner_mgmt-tester        FAIL      118.32 seconds
TestRunner_rfcomm-tester      PASS      9.80 seconds
TestRunner_sco-tester         FAIL      14.81 seconds
TestRunner_ioctl-tester       PASS      10.66 seconds
TestRunner_mesh-tester        FAIL      12.61 seconds
TestRunner_smp-tester         PASS      8.91 seconds
TestRunner_userchan-tester    PASS      6.85 seconds
IncrementalBuild              PENDING   0.56 seconds

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
Read Exp Feature - Success                           Failed       0.113 seconds
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
Mesh - Send cancel - 1                               Timed out    2.569 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9015562048647882479==--
