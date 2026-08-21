Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FB837DE83
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787336969; cv=none; b=oaIUoj839nRZd141XFeY72nOenj+bIR9ZAS96hpL56qpNKNB2SECg37yarRTUQqOyccbpbXn8n/LsXWXDHzSChwkRp/SPJULKQzA1Y5WzV1b9P0a0y+0/rF6uBy0voBP/1Gc7wGhvSWTwE9PgOBcgrbNH45fN891OTZRIYRWtUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787336969; c=relaxed/simple;
	bh=pLLAwFkg3JqUMKVIvKhBlN98+rlmxSm3qcMrizEQPHQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uGDCoc8jXxLqarqlZatAuQcScaW97E+L/KIUbbUMgl7J69xrXzYNszsLxVIbj8u58qtQQOE/Nr3xW0NK1I46mCpSRe6AVxEqdFQzcADfkZp7LAUNkafenyXDCBpzqbQv3PtLw0uZlpKJpJ7EL+alQDAbbwdFZrz0sXN4Ffr9yPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qt4GIVvG; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt4GIVvG"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1313317a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787336967; x=1787941767; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kevgt3I2dPyULXBmhphcQCGo8g4xbm/pYMvblPxmt00=;
        b=Qt4GIVvGXKCOhmYpZuSM183LKjpxZcdnWOTrJzqzszp14g6uWZiHAYCNW7V51t7HJb
         Wp94d4PLI+BQcWRkcCHEpgJvpUgDABIG4J+oZ11vCvG6kk6BVemMRGrBqsB90gwd9qFq
         Ya2XGbLyLzrlC1Yt8OfWis0P/IP8g/CpzjxBBxtWGAGQ6l8jVeN/DigegWNPitN5mp0m
         SmPwM6eYRI3dlkGcqHUmj+hvDg/pcTVeJRv2TW7JvLpX5B4sxhMMy3zjXrSVVjHhk4LH
         zDk71WfbKDgRMt0MgjUbQpbvspmMJZPrg0tiz1YFELniesqNVTJo4w2kn0jNldd6g4HX
         7XFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787336967; x=1787941767;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kevgt3I2dPyULXBmhphcQCGo8g4xbm/pYMvblPxmt00=;
        b=WtvBcohdKz5Td0aZLeCAM2UAUhWxbkOtwnBwTvai6xnCCBSPh0oHkqqSHniiCr15xv
         +ZJKkeP4o+CguGWErhw2ddKLNAm54IdL/9ROjVVP7lBV/a3G4GRC0hPtDXHN7OeYeTYq
         Z5qBG7uvYonMBjZe6dG1ZtkbvG/xAG+IxrQsdwZntcQoJA4nu5h+Z1+/1mOdYV2bUvXp
         O9bbAULrtm7x02dcjjOYM7FYI610YB+VrxZTCxY/J30EIGMbynb40Dc60Xfv5L0FJ1de
         0VRuCvNX8v5erV2Q40smaCEEytGo3coRpEnq+K+y3ZRDCJ/XzQkK4MQGeQqG77iLaEKp
         /Nbg==
X-Gm-Message-State: AFuF++mA5EwjJAPRa3rx0FERGlZBFAwb98X9OiPj6+eMzVagmfFK3D4G
	m3UpR6bVOJJNE2DgefMcOYCoYUJasBB2oT+tZciWGZMCX5gwuxKBGFeIXeg1dw==
X-Gm-Gg: AR+sD11PvaC4b8GOJkYd2Ib+hWfyZ3rokQAHu6UA/qBbrhQVja3Mpwd65pJMoSKlKeD
	UMyMKDBhtIK9oFl8aL51a9jE5Ehy3qTgB+HxrHqa3YwIaQGXWVN3u7vvuDnNVKIho7EeIY8aevh
	lKLczP0kObLPRMPO05ZuoKqTRjFbBn38Wme8O59ucdNDiJPv5xjV3nt+WBu+joed59vdqBBC/qW
	CYMIeGKTZHVyva2q8C09pTI4RLbz4RrFolmgTT9QRJWU+N5Lp7e4fGJ8n9XqR9OLPYYJDcUNvOe
	yp2Hy0EonMYaw9L65zTZ5cOfu7ydp3SY11E6I0c75senPeeRJKBrmL15IxbdS0H599UDQ6AazDb
	yXoK3Em1RtdknaDoaNROM3R4Kuw5NY8sp7mSAvKIhIHXdofmnpwTcRXi/5wH3vk85dAqSa8yl79
	FPocG8988DEnSHjRyWNPl1AK2bcH7g0aRFoFq0pM2cYI4F/QRNTrqmFo+2upaMQzk3xUM4x7dF0
	4EZ
X-Received: by 2002:a17:90b:1b04:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-395c33406e0mr14051840a91.2.1787336967089;
        Fri, 21 Aug 2026 11:29:27 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.44.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4552234sm4126166a91.2.2026.08.21.11.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 11:29:26 -0700 (PDT)
Message-ID: <6a889906.daca6bb6.102cf8.02a1@mx.google.com>
Date: Fri, 21 Aug 2026 11:29:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1262060954706315385=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: RFCOMM: serialize session teardown
In-Reply-To: <20260821174514.3034851-1-nicoyip.dev@gmail.com>
References: <20260821174514.3034851-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1262060954706315385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149961

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      31.96 seconds
CheckAllWarning               PASS      30.44 seconds
CheckSparse                   PASS      29.59 seconds
BuildKernel32                 PASS      26.90 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      506.71 seconds
TestRunner_rfcomm-tester      PASS      26.24 seconds
IncrementalBuild              PASS      25.23 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/632

---
Regards,
Linux Bluetooth


--===============1262060954706315385==--
