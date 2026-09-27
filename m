Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C32FE56A
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790551413; cv=none; b=dvEfsMHGgSCduHOn9KtckhIf7gHIB0PTFkY+lWJ9vKEFLG4yG8FXZGFcGB3zpI9nUvKw6vBRTmDu50NDzxGuC2MA7XB6Fxch+21unxEOtp1+KQ+9nH+iQeYN0eUDvCidocBIYru/SUOFqLTBMXR9YyUCkEsGpwvy+4Xh8ZGfU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790551413; c=relaxed/simple;
	bh=0jAxb3xFF+2gK0KGPSuUOuKAI0nNrzC4U64jbh1qH/E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bPCEw4enYoyn3v2SGeXIiIYqmVAJTLfoHm3SbD5NjL9cpglf438iuC4RMti2S1SPc7+qRw7rGHDH/ZM1fVE7oDtg5xotHfJsYjQEk/haWOSTmNHQj8nPBrQMaaKI0qKQM3mcgrKg+WrBUEGyp/SKpKXIkXinnqygJD+fakNA4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/yFfVB9; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/yFfVB9"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so1244042a91.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 16:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790551411; x=1791156211; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kCHWTQO7aLDwtFzPNRyfXm80wQBZ0/KFIPPgu/pp08U=;
        b=Q/yFfVB9l/4dy5gRwx99k0bDpUUyfMk/tm6UuWSe6KzQCMC5C20tEvh9D4gjuVPX1E
         cRmvTPg1IoRkzEO037L4FnkAJ0UNvDLMeVYB9ROquyl42oSt+JWqV3gunzAFR9igyTm+
         aUcRyn3pIYTUtLl1vgYaUQgiWujUvsehmd566SUPqktp9gohuD7MIDztTx+h99zZCxst
         +JRvh3EXMumpKnivOmBmDf4Oo0l/PMuh5tEUnhios2kgzcIPcnxq4++Q14yJnJOQ+jS4
         kHwTCa0EyDvbvHRKyJH74tbDVk/5UWiCF+T/va9PYD/IovcKDTv2yrpPeQkSI797IkD1
         Clsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790551411; x=1791156211;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kCHWTQO7aLDwtFzPNRyfXm80wQBZ0/KFIPPgu/pp08U=;
        b=Lajx3mDA+oEFVPYsQoFD32OeneiHgYr22rddaynPrURkZyGfQQZJl0Z3nUk2nEkSGK
         dA2UdoGntih/0lKGg0DzcS80QCk01GR3R3iXF/+oSP27jpFzHcc+cABL4XK/q0+W6pf+
         KbWD/JOShdwoa4jPFcnfgI/7Z/AcSJZ0rCgUKCMqMp8ec8UUliRni8PXHfxBj4n9Bj0N
         fpL+iAqSEm9WdiBK7Yq+D5sp47yAwk1Ef/BuR+Jhrh2vKVO3Mz/cuOkes/MaC50VPAsM
         rUfbNBsRGQ36Yglzep41KD633WEBDwfFor/UF8OiwUIAB7xY7O/CvFI9syXDh3oxULh+
         Snig==
X-Gm-Message-State: AFq9FYKYbp2JOTPfOQilHtjzPnHC+VPL4NDsLEmI886XLE7uvO00b9Vo
	nFY2Ph9OaWegOlZXFYJocj2KbuPSxmOBwRLZJsKNMC9evC6mGwZuCNaczIF2Yw==
X-Gm-Gg: AYBFou26/k1hgVNtDDtQ2dhUcrrjVf2nLEBKw5mQZCkNDteM6w5ywEenxLb2cQBxBCW
	JG5NrjnwngIb0kuwEKkRhyQFnDByPx859xoqCkXVOitOwz3u2q/eJfkgppdeiPvGzZsm8WrAi0Z
	rGhPES5hft2xnxac4oelZkhUpz26eVcYgH3kGKALikzZJQ64n05PdyORz6RjBbS5Yet0c19d3fy
	EQQwODGc9l1lt56Lmwxit13nTqZlqjvQS4aqtylo6RyoldbI/F27RdC73TTnxNGXbZQ1+Q07oaM
	kGpX+L1CIxRATmxC71tcB8IvM7iVRG++T4HqS4otR0hKq40Ork2f0S8z2w8od+Y1c7IO1QZu8JU
	GyP+iqgx0T1Qtop1qQHAV0mQSMMqJn5imRlFgwCzvQSU+hxtoaiDrDnsu+6cC0rfE+CDFTU8lI4
	yOtoSXsdt5TkfXV7HcLWqqNCVCxgnQ7M3DgBfPfvFZTC4LP1R8EJnh8FdSv1rqy3vb27W6vZI1T
	C9glwwIfokFPmhqcA==
X-Received: by 2002:a17:90b:2647:b0:39e:4c80:f67b with SMTP id 98e67ed59e1d1-3a09875f8aamr9516736a91.26.1790551411519;
        Sun, 27 Sep 2026 16:23:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.115.228.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a2b1e4d5basm4927238a91.9.2026.09.27.16.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:23:31 -0700 (PDT)
Message-ID: <6ab9a573.cfd4e4b1.c02b7.8aed@mx.google.com>
Date: Sun, 27 Sep 2026 16:23:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7182220943679799438=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: RFCOMM: Fix initial port reference race
In-Reply-To: <20260926172723.2405885-1-nicoyip.dev@gmail.com>
References: <20260926172723.2405885-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7182220943679799438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174570/

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      30.05 seconds
CheckAllWarning               PASS      33.65 seconds
CheckSparse                   PASS      36.17 seconds
BuildKernel32                 PASS      29.39 seconds
CheckKernelLLVM               PASS      34.21 seconds
TestRunnerSetup               PASS      792.17 seconds
TestRunner_rfcomm-tester      PASS      5.62 seconds
IncrementalBuild              PASS      27.68 seconds



https://github.com/bluez/bluetooth-next/pull/824

---
Regards,
Linux Bluetooth


--===============7182220943679799438==--
