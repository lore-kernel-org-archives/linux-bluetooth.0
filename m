Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3E3D6CA0
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938246; cv=none; b=Yt/sJPXXpCoWBLI5CEebHrIU0M2Q4atgdP6atTSwklB268Jg6WVij9KC3Vr2sHFLUUY5lpuZzVZaxvKzEXu8bvtD6acVh+cWhWjvzOTg2rUMNjtf5uDrGYhUMlx9aw+dsnHG4TEA6FeDL8TRerYuun1KVSGD/SrssaFAvaNdWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938246; c=relaxed/simple;
	bh=tg/wEZn274S4i3V8ecx68/rlCJX317fYC3aKsRRgYQA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ggQVxllgDlw2JF3fGDbOMgxMbddOpTAlH+8CEe2df9SzzK6myxaVs8Jm1cm09cmWCgQPQo7/UYBKHYENhE59dt/Dpeb75NxNt/CaVebzPFT89dslwmF4bzBPym++xmpqt3VG0GtazhPPzhIkVIVrtmX55xx+PrGUgX9A0xo8RQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd6XTN5U; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd6XTN5U"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89a07f66f4eso9811386d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773938238; x=1774543038; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fpv9AxMYrf7q861GWzk0FttqE2+lxpHGsfrSi4QJnV0=;
        b=Vd6XTN5UawMEM/R+AUtLvFB2wFuyxyYf9Z2yocebUcwKEBWw6u76qjLNgPvjROC7Eb
         Bm53C/iysi0YF+bRZazfaWN1W7fqxLtJ34uS3aHtnQUJPhoFAjUb2rbtH9djisyDDGaH
         Uk8/U9oDoF+KrEFmuLh0MJwWhCCOWooDoKn8x2gESImSoyLfpkzewyB/Xoyi4fV73OvM
         hiR2hDIVK+Egc2E2RToWixflzAYHxWsWHyW16JY8Oy99ITnWYzyrg7WWmjgXJff4FInT
         4AZGJDhSal46HPHJIdQQx+FWMMMf9gKcFV/luUQUM0CkZ8pxLF61mtcMLovh4UYkzGk2
         G3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773938238; x=1774543038;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpv9AxMYrf7q861GWzk0FttqE2+lxpHGsfrSi4QJnV0=;
        b=fy1gUIbElWsg6C+3uGt4DuuJ8imuPJxU/Fm05Lu9qbRO+MnxxtnNRjmqdMjdukm8gS
         nN9nFSWPSCBgWsW23X3k6ImJlCqSidS1y7u1ZGIKuOuOOPw6lYdfZjmAYUG5ivvWmvuJ
         YVfSQe7ShJvrPFZgp+R7ZrT4h2HLsIvyIWZop/IcQ/BTlcLDEZycu31xG2GE320FsPwW
         i9RfMSq8c/mTyRiwP+qYOiGuuG3onOXbP1iBgqsECHPwJZUd6Yli+TGMYF4PE+p/4SR7
         ez1BhOnmyBa1TLjFagwe/yvB6gKNMj4BraCfXweIg/ZXO4IbOHhq3ZaifLRJ5JAghwOZ
         wtHg==
X-Gm-Message-State: AOJu0Yz8wGz/Dk+JQZhsvVqtQu3BNfn3ya6Wcg6Udypbbj0i5nfv71Tg
	soSvT5ePk8GYNAQVc9Hn1EFcMf7+I0fUV1rcD3NPs6/LrYB0/tQn8Ko9ZP7M9g==
X-Gm-Gg: ATEYQzwvgmID06NcTSh1ykGDCDaMk/31iUC//Z09rhTLipjFNs9f1ujKBU5Kl5R8q4F
	9l5uJenlnrKUpUvgmXSY5+uFxXCPpkjFfAwtaEbR4fcV+GEikHOqKFp1/qCfozorvH62iRzu5DY
	MGM0HCl+iKnXGweJ0cUQUWZ1641e1Mfp7RoJMQga3I54f3LZ0G7bBlYT7vXc4AFDdZ++auo8/lm
	eXxd7IEUdNHEASZGGD5JiLCabhHQuzT3f6Lo4fvJkwtoxGsnoFycb22ORve7CdEcjinDklqITwc
	U+/uplKXl11K25yqN0duv6A63AY/ATK+BS5pmuy/f3wWGWRZTOYH5nbWJQTFJBJftJAA86j/S77
	Q4y2iEeFe5UbaoYplQ4//zelOu0jkZA4MTcNFOcdKUVFjdxDA9Z5GXHCHfMjEwquHM2o362edUQ
	MZQKrA6clMZeAlQFQXwH6Jl/g5yFac
X-Received: by 2002:a05:6214:4e02:b0:89c:4914:e977 with SMTP id 6a1803df08f44-89c6b5917bemr105710196d6.43.1773938238004;
        Thu, 19 Mar 2026 09:37:18 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.193.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85362bb7sm225656d6.40.2026.03.19.09.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:37:17 -0700 (PDT)
Message-ID: <69bc263d.050a0220.2a233.5168@mx.google.com>
Date: Thu, 19 Mar 2026 09:37:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6242641424370798334=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4] Bluetooth: L2CAP: Fix regressions caused by reusing ident
In-Reply-To: <20260319152247.13225-1-luiz.dentz@gmail.com>
References: <20260319152247.13225-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6242641424370798334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069350

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      27.87 seconds
CheckAllWarning               PASS      31.03 seconds
CheckSparse                   PASS      28.87 seconds
BuildKernel32                 PASS      26.53 seconds
TestRunnerSetup               PASS      579.91 seconds
TestRunner_l2cap-tester       PASS      28.10 seconds
TestRunner_iso-tester         FAIL      32.95 seconds
TestRunner_bnep-tester        PASS      6.44 seconds
TestRunner_mgmt-tester        FAIL      115.98 seconds
TestRunner_rfcomm-tester      PASS      9.66 seconds
TestRunner_sco-tester         FAIL      14.59 seconds
TestRunner_ioctl-tester       PASS      10.49 seconds
TestRunner_mesh-tester        FAIL      12.54 seconds
TestRunner_smp-tester         PASS      8.74 seconds
TestRunner_userchan-tester    PASS      6.91 seconds
IncrementalBuild              PENDING   1.03 seconds

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
Mesh - Send cancel - 1                               Timed out    2.758 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6242641424370798334==--
