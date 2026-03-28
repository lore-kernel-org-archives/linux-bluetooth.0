Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB1626D4E5
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 04:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774671767; cv=none; b=cEdty+V6MFIKUxIgBQnqVKfw0huP92Dqm7q3Ek8omiuOTTBlP5Oy7pV3IHFy2W1z8vUpDnOOe42EQkYl5lGpAas73BlsvPEosVZNbcCG1OEKgUVLY3lIa6uhoL03jxLpn38HqXI04dvR3tgSwANnkZHClf1u4xzBLZvEhqRq3ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774671767; c=relaxed/simple;
	bh=MGMczpeWevF7nxo/8kE06/rub+LfxDVm0KFi0JNudGU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=alkiYH1WXj1KTJVWZI9Yr8CqirLP73hJWIFvnbO/LqlPI++15J/Ya4HfLQkFNVjRLOkTakZHG3zfc68SCA+uRjzU4gFd0yYFjKNfaHe1eSF/P8YbK2T18f7ePo3tS5TmNqenvDjjVAFNnuJ2eeK0Kqo4k+djlteF+wm1MVNQqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCoSwxD7; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCoSwxD7"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c107ef474fso5261194eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 21:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774671765; x=1775276565; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0aTyyS92lXmybQ+H26jn/TCwEJj2GjRynNnNuR+2vHY=;
        b=cCoSwxD7uv781Rkw6pCAvGoOKW3+CqapiW1LqyrmbrHLfenLkAYHl2V+9gPys5jhU+
         i2g7NEBlvZ4hpsw5x8JFEbBpTN0ysUBNY2u4lV+dQyshAF8VMFMwJX7lhD9wgnJfbDrn
         aibfveNo9VjLj1J7gIe1WyjbHNpH31gvycsWkUMouVN33Tz8TwbkMah/aF+b4oI+6Uk7
         ADRclYPEDN4q+l+g24WF3HrCvaLOUGgCMTM1QMfFgueebrAcZ9mDLoqikDPUUUWqJfKF
         ur5W9FbGH4sliBVy4iw8LRaIA0CvbZ6ehZu72FXMUqNuiEYmt1gz3nReeaaXvJd6Tg42
         +OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774671765; x=1775276565;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aTyyS92lXmybQ+H26jn/TCwEJj2GjRynNnNuR+2vHY=;
        b=GMujx1gNfgIWQoTPh13LMzDcbiuSH61K1+mUKcvOoq+oxXr2ZL9SlxhXPhwnuYzWuy
         81FGaKZ8u/fj7DgKjuwOvtEoBC+rW94C4s+c3+uuL3YYqJDl024jN5++d/5ccP8/j/TR
         ne2voC+9+GWW5hQ7N8qwHQMUgzEL2c18uteYMVGof26XfIgvNFhrHvndbakMwGv9GTB7
         4P3ipLmxg+32huH/+FaRnfdL7PKS223wAymSroZm3EUvCgNJwZ7Hvb+AuNGXIXqeSVOF
         56Z79Yur11O7u73jWmGJhOJdLWedWRyWSoLnCQwtSdHomlHNHB5ApgA/za4xSiOh+J4d
         0H/w==
X-Gm-Message-State: AOJu0YyB2ZsYF26HNDIkAlpkIuGSjZ4Wj0mzsmzhAH1GKty66u4/kLnb
	EbKIuUqO2eiMa29H4DxhqCJaPcEiQbY4Zu6lGqm8xIp+5brUDZHwbsuDB+ZyyA==
X-Gm-Gg: ATEYQzww9wEl7CDP+2lERJ8Bf4jBLgjo+qrgp/F2oKquRbtSlf4gh/O5g26EUAxvx6P
	NUDVDOTyTXN2Q0l7PzkPvEYNpy1dwuSdI8WwTQzipmB7Hu1kXEzzjHiMnuGcu61l8rJol7i/uZM
	xyA6AVrf9nYts9uH260JLLf222J69x4IoYSo5bR3Csa1W71ecS8MJOqCGyzKuXsA23pFC8jh1NG
	01MztWaZhMN7BvZkX09wIVj+omqSYBTgoc3Y10LuotQ4yQyhcGaESlzERaH7JneCQOngYLZema0
	zHfj1OaTsVemdsaGMaq6QM6ecTm7rGz5VtFDy8A3AeIdzsxF0fm6tk+MH7ahi3ZIPQuFP+7FvFX
	mGnxA7cHDJ8WNZPNhfy1XPvjlbxALk8lLj6uKbKoB620pkUY7wcjUyeFCAyo99Vjju9ZV68XA+L
	0PudO8Dm2dSMrbQF0Esqi5BWY6iU1xa7E=
X-Received: by 2002:a05:7300:e60b:b0:2be:a2d8:e9e3 with SMTP id 5a478bee46e88-2c185face1cmr2871660eec.29.1774671765095;
        Fri, 27 Mar 2026 21:22:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.109.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b2721sm1100327eec.14.2026.03.27.21.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 21:22:44 -0700 (PDT)
Message-ID: <69c75794.050a0220.afb36.820e@mx.google.com>
Date: Fri, 27 Mar 2026 21:22:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2212392155521377058=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nathan.c.rebello@gmail.com
Subject: RE: Bluetooth: ISO: fix NULL deref in iso_recv() ISO_END handling
In-Reply-To: <20260328035813.296410-1-nathan.c.rebello@gmail.com>
References: <20260328035813.296410-1-nathan.c.rebello@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2212392155521377058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1073872

---Test result---

Test Summary:
CheckPatch                    PENDING   0.51 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.40 seconds
CheckAllWarning               PASS      27.36 seconds
CheckSparse                   PASS      25.86 seconds
BuildKernel32                 PASS      24.35 seconds
TestRunnerSetup               PASS      533.15 seconds
TestRunner_l2cap-tester       PASS      28.29 seconds
TestRunner_iso-tester         PASS      40.09 seconds
TestRunner_bnep-tester        PASS      6.46 seconds
TestRunner_mgmt-tester        FAIL      114.08 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.40 seconds
TestRunner_ioctl-tester       PASS      10.28 seconds
TestRunner_mesh-tester        FAIL      12.38 seconds
TestRunner_smp-tester         PASS      8.73 seconds
TestRunner_userchan-tester    PASS      6.79 seconds
IncrementalBuild              PENDING   0.93 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 485 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Adv. connectable & connected (central) - Success     Failed       0.130 seconds
Adv. non-connectable & connected (central) - Success Failed       0.124 seconds
Ext Adv. connectable & connected (central)           Failed       0.176 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.182 seconds
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    2.646 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2212392155521377058==--
