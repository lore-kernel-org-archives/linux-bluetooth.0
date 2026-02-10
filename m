Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0A82DC782
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770722294; cv=none; b=lZLj9osM1JboTAy6AuAANCy0R8OH5N326nd78LTRojdUG2umjHqDOpIlrDbhTWLWkZd4CJ05dN7gjWLp7U1394hrKD29K4kOxArI5kGuAU0JVuWbLDSbmkUknQcLyzSxKQyOy+hYZ6MTNaZfxrr3mqBG8TgRBSBxQcRSV6Xq/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770722294; c=relaxed/simple;
	bh=GOMpaVyQDc1IIqd0AXWMAUCagbfZBCp7fFUizGtbav0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=j3rjGWLi9UWwqQhBMHS58FqmtqWUNdwokh8sUBTF8EbzQc/wfOB6XASAhlFVhfhIfGebQbsIaA8VH+RyO49UIfloodrQWEZvJjH2P5Yzm0apWvxr2kcMLyMhaHRlpWrUweb7uG5zusL5gdCUqNzXkf2Hq1yS1UGHBrLMUBRtVlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrjKr1P2; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrjKr1P2"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ba6ac358c8so883042eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 03:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770722292; x=1771327092; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4kMGLGEaG8bIHXSue2tQ+FX+/NdphoRdzFdIOyNDAgg=;
        b=DrjKr1P2WYoEeaexbUUWXRSDDHiNIsTwVfkgBedg0FCWaAazuGb6z7PgrshXSd4a+M
         yp0R+Qczh3GqoI1VwV5Csurerow0w5ZiGJTL04iZf7Z36Ad8WxakdZHlSsSIReL4mCsd
         cLaZFGIkEDQPBN9tlHqH0+sXz3ujNKtXsF1eke2UCJf+3u6LKhs8kgLaRZWTZCgzugx1
         XVCsgIum5jz8+7+IycLUeq9EYkP7jsOQxY79JPke58SK9PeoenE+JYlgHWBpssX1u4Se
         NUCrqT5MreVbs1IOxY8v+BneHKDZ5w0ETOyEQoUbbeowaPtJlPkhXDJDpNVWzWfgsa7L
         zc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770722292; x=1771327092;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kMGLGEaG8bIHXSue2tQ+FX+/NdphoRdzFdIOyNDAgg=;
        b=JAYv88e8j8yY8KTor9kJ955JDTK8PKHTduz/Oa1W0c7h6pwR+UBn39+HU+1j/zl9Sa
         cGq3fvW03jGZsrQoYQejgOKkK9cO3pWzPpmigvHSm8RusJgesESirdbUe1spMCaGWTfb
         I7PbE0+G4BUDDLRO51NxkEr0TyOdFozq6B7Q1TVxRtYA9tJowF4W5ZPqjc6lt/tihPI0
         7v0NpVb6XiWGaP0vj/KabsLzzxSaaTmeNuD8Z8ZYZPngqcMeFVH19XWXP1gaiMDuRyJD
         divrIpqOnkxqST83KH7kaOkLOSXIywQET5AEBnEEDjJlXY1WMvNkrh/Z9J/RyjiOhYqT
         pqGw==
X-Gm-Message-State: AOJu0Yz3Ek8uMXiA5IkiRXpyteV5XnuJiKqlLvMc76x2XV2J8pEF8wHf
	JdmU256nLhB/EA2KUM6eQDrKTBDLFEJrLrfxE/N0bSPC1dZqHTeHuGsXoosHBM+q
X-Gm-Gg: AZuq6aL02Cf0D1DGBp5AMtbwPUvaXp1ja4uDGSGESuhrreFkjNRVrta7FHgMAr6Npzt
	hTZMAUq/+U+e1StkmV/Z2vPznpU4CE35M2DgR4A5Ua3uLuZl0EfjhOzLBlM8O9nBc5uLvMKug/n
	RHU5MUXoXkzh8hAeE9FI41/bM4GU2RswGaZF6wjOeKh6gsnXGp63ULhlH8LapaL1uF+AI+Z/Xm0
	E0AhglB5/BFGqHgN6W7sE3GYDzIg5wLHj1qe2unYsPKDak9NTYIo6rTbXM/4UCnkl7huOe0OKgN
	js0JYirLUlRxdNVjXj5VGEPbNIU+2px/fSym474eUgVL6BaDREnBPTwBKYFw1ydUG/iiDe8B+Jb
	+oLHlEpPYeY84b+yypY77hQK6vyncQzgQC1t+L1gbX2qaQqKGhjIsR5s8drefEAWcNjLvwYoqpz
	P0gpnd5s9+MNKDi8e2VyrdNWCdvA9JvUo=
X-Received: by 2002:a05:693c:3104:b0:2b6:e793:caf7 with SMTP id 5a478bee46e88-2ba89d91a9amr729780eec.18.1770722291841;
        Tue, 10 Feb 2026 03:18:11 -0800 (PST)
Received: from [172.17.0.2] ([172.182.193.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c89695sm9321077eec.31.2026.02.10.03.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:18:11 -0800 (PST)
Message-ID: <698b13f3.050a0220.29bee7.b599@mx.google.com>
Date: Tue, 10 Feb 2026 03:18:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5676260422629489357=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,v2] emulator: Fix compilation on big endian systems
In-Reply-To: <20260210093254.3246483-1-hadess@hadess.net>
References: <20260210093254.3246483-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5676260422629489357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1052631

---Test result---

Test Summary:
CheckPatch                    PENDING   0.51 seconds
GitLint                       PENDING   0.54 seconds
BuildEll                      PASS      20.30 seconds
BluezMake                     PASS      658.81 seconds
MakeCheck                     PASS      18.54 seconds
MakeDistcheck                 PASS      251.17 seconds
CheckValgrind                 PASS      300.09 seconds
CheckSmatch                   WARNING   359.76 seconds
bluezmakeextell               PASS      187.40 seconds
IncrementalBuild              PENDING   0.45 seconds
ScanBuild                     PASS      1061.52 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:700:28: warning: Variable length array is used.emulator/bthost.c:701:32: warning: Variable length array is used.emulator/bthost.c:918:28: warning: Variable length array is used.emulator/bthost.c:952:28: warning: Variable length array is used.emulator/bthost.c:953:32: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5676260422629489357==--
