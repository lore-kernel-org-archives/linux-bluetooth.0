Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8358326949
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537927; cv=none; b=ON4qWwzS0lUIuM1d6dfflMNrk0RwffOak5jZoKW3Z6dsfn6DzZhKSiR9mzxZ4pH5YUflCqGaz8SnpvtmXZffhsOJKy8YzOHqNyC/NDzqKgG1Dj0GNrSGk4WsSjqCiyfrf4YHwbPOUPIV+whrP1jMFvuWFOXtCyW+QCWxNmFWYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537927; c=relaxed/simple;
	bh=V06at2kkkwiRrCb6KCRXfi5l5QAS149Ho2mfoxKnEmg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cRvcrVkkZzjO98wtPoXEx69o3XPCtN54iZ6dQkF36MtrYHqqn0JKGWXXNv4hvgyTNCW1oy39YEw54YP9e4EJ1MdBpzTVcEtewar+YobbTvXCzEIl6rkf2Y9xnbAngB4MBPOOcZNlMl/l1AwLSMVGKC9aWHDfPFj6CXVy/j6rXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVwBc65v; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVwBc65v"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b785801c93so3906818eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769537925; x=1770142725; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oHlnd2tLvzTon/LFu6Q8G0RNkaiI8PMz1D0MRkn80q8=;
        b=BVwBc65vaM7ck/yHWA1tBzbxf3YgrvawRAmnPgJoRjUAndxQfBDECt1jBPKxdlGdE0
         U0cpeOuoJwLpqA/80nWXTFVMpgcgPiAfLgZb7PRnlvIxf4/5pM8T0XqQfg83Aiu1fSr/
         yhAxQhP+U9SrYoc83V5JoOvyLA561ZBGrtzNUE106nElmG+mTj9fd/kwv51Tw8QQKUjy
         Eb+AGwU/g2l3luw75v5+hwPe+rLGwFX4e1GPL2Y/37zJygvlwBBhbMyjWseynYdCC96d
         Yvi+MkErVq1JrCrJw2HwYAJgnlEK951vdgEwV/VEXCjYaCmUTr3Hr+7rU05NxqTBR8lX
         QeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537925; x=1770142725;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHlnd2tLvzTon/LFu6Q8G0RNkaiI8PMz1D0MRkn80q8=;
        b=rh1y167dqjqRKRobONb4EOwHfiTNY86py+muCbgtHpLDR2ACIa+CBozCqHnDrLv9G2
         2h8y2ImJ3gW496UxZcw5jzJjrcMdzTYoMrYu4X0QEVzADobQBg4GHiRJy3+t0WuJ7VrB
         iUYUY2j5FR6blhqpRmhNM/aD2X1x4vHTPN08bqB+2gYwnYpYqw3WdUev/eOQJCe6bKGn
         pzU86UkCkJyHXBwgoOZ4M6dfxRawD0T7Fx4tq9clyObQNMF0fvhCBzj6qEEH9cdz6+TO
         9FJ71xoqnm6FDDopN/HVFFUUnT1wEKFS9psOYXF2/UScLhSOGrJUn7IvpwlM3wJrw6FM
         o18g==
X-Gm-Message-State: AOJu0Ywa1AmBjcW8BOIZRQPf+VAfGx4LYTI0cWxHhaKC1V3HKci+DDDG
	VIsGEOYFAV9IOk5pyS/lR0ZJDfPe/YME9C9xuOUDsyV8IgAmERUE0gkSY3Gkl+ktuuE=
X-Gm-Gg: AZuq6aIPnUzWzpzII1wxh0Arl5yDG3ONrTHrNibMo+kl4tDWQ6OaC6Fv3JW0WmvQYMn
	OvMGKIwpjz8Shai4wxg6OeqLLmzrv9uCTOj5SkiSKuSnaML2XX8VDPE6xcwS/OCFajXzL9abIV0
	Ccm8GXvegZIqBDqQfffyLOBHLxDySBvyVXLNIKwe+FNC6COBLgeSgi+pBmpy/sjC0BjHDD0qQK1
	bRBSqSiWmFvH+0yJuEP8pdKSmPb0goNYr+7r9EGGfzVZFyPpsN95eq4r6Jyv7RdHWGXKqgYN796
	NSZZIfu09CPgqT4YTK0EV6JvKF6GGGg6IKpkbK0fiTKcS6DaiBtnbdLgW0Y0ZIp2QHmsQa6r1jO
	6vvhOBmkmxaq5yrnBu6DzOFs5M0LqmxDgEuXocj/TapsNKbJFCO4B0JDbO4sf0/EqaAnYO4s9nD
	A0KwY4ovkHaHWcJ/g=
X-Received: by 2002:a05:7301:1014:b0:2b7:857:db6c with SMTP id 5a478bee46e88-2b78d9e051fmr1410398eec.28.1769537924396;
        Tue, 27 Jan 2026 10:18:44 -0800 (PST)
Received: from [172.17.0.2] ([20.169.74.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b79c38714dsm291397eec.2.2026.01.27.10.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:18:43 -0800 (PST)
Message-ID: <69790183.050a0220.3ab2f0.2c94@mx.google.com>
Date: Tue, 27 Jan 2026 10:18:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5847152643120683175=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Add PICS and howto for the ScPP qualification
In-Reply-To: <20260127171335.151361-1-frederic.danis@collabora.com>
References: <20260127171335.151361-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5847152643120683175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047697

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      17.76 seconds
BluezMake                     PASS      628.38 seconds
MakeCheck                     PASS      18.02 seconds
MakeDistcheck                 PASS      219.98 seconds
CheckValgrind                 PASS      279.69 seconds
CheckSmatch                   PASS      312.56 seconds
bluezmakeextell               PASS      166.91 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      933.98 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5847152643120683175==--
