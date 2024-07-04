Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251BA1A0732
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075173; cv=none; b=OfHJ0jJShzTjl6UgHCXJep6amzgj+QkeM+BJE4nWWKAwvady6ZWObGqhikoLxcRHdJFEvhT/ce6X3qkgCFdCJVFZSUQGAB/BgEO4Dp2rARWQVhK1iaBLyDqPC0buuqT0K09WQxhOT36BaYfgfFrnHLv9VWwAydApjXNYpM1BWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075173; c=relaxed/simple;
	bh=ilKVY0CIsYRRUT3GNHs4VbyIVZEs1vIGg/AI7bkTlQs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AuPVr/7yv6gzO/rtVndKzeFgxZjISgpysG4ov24AhK0c6hTnTKoi/aPSGsaYTrv8kqsPqMlOYD90C9GVnQuvjOljU0PLxpEA9ho7sjpbiGcuQO7F/NH822I1J4SC3hLdvMc2b6teL5XSd5J/UPONUpAPq9R12oz4Yespf2fK6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaQymTDn; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaQymTDn"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b5e0d881a1so10992976d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 23:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720075171; x=1720679971; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QC878+ilsTJeJwlug1db2T2kn7QBeDJ8oSRN0KtRKHs=;
        b=HaQymTDnW+dzQR4Eey16QV4jZo1fHGntPO/it+ii0egPYwo2r1mCnce/9mqUNW0buo
         lXr0/jZCLu43QsoJboThUFxkrr6aLPAzzWamBnmw00j4E8CSUZxKcayozW2fJZRytvK2
         VICrZwdfpoeBbFacwpzuushg5BxAH/YDnMsWRBz6LWipr7F1YvugXzFJSRjUrTMUaaKY
         Kr8AW52M6zoHhP2oJO6tux7/5UO5PzPVNP7xPxNWW495y7pnsh1w8ZUdg6o3HZ665Wa6
         PCYQqmqtzpHxI3/KYw87wjcPEMoEV4z1jSHz3TXDK16pS/h5UK9mjf1HMH4HVM8hxIAF
         PogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075171; x=1720679971;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QC878+ilsTJeJwlug1db2T2kn7QBeDJ8oSRN0KtRKHs=;
        b=dHzOy1uCHTWzOipcTKpxPe2SbZIc0gX3UB+UCCJDi5+nRXrzQk6WIoAU0VsFTiVikZ
         QVrDOtej5zEE6nFw+H3sG0aaw+Qvh3LyVosS1dRcBcdCer6gR0Qj6sVL1CMsm0iWnFUC
         a0oeHmTDYim/WpmcKsgrtTtie2uHNeYLsUp+32dlGAByy+9lYA3eT4qncSVcb32P+z3m
         W3kaOLx5Idz8mDSW1K8a6tBsNFg8t7kL5eudLESTwuRQghO+vWDxmZaE3phWPUyUBxjH
         sEcxM6eJ2dXyzWIv0wcfoQqToPRQRlmQLrnFzxjkQIf+Kp5eoGrDWhvrQa1Robh8dKZ7
         36JQ==
X-Gm-Message-State: AOJu0YwjVNx/1UJi6un1fh5v39UBopkrng3QCreJvNt73GZ+FHQEPgoS
	zHhAWejwWMqXhDw1m8YOLPJxUleVuLJ99qSDAW6abrtlI0Mlx3ZcXgGozw==
X-Google-Smtp-Source: AGHT+IGVy3Uv9c+ep96Wjb4ZjhdrKRlcItxfOpB+TjNjdTO0pYN0Dev1XzNx6gUfdGBd+vTQL1Og0w==
X-Received: by 2002:a05:6214:f09:b0:6b4:e21c:d46f with SMTP id 6a1803df08f44-6b5ee63d9c9mr6238396d6.27.1720075171096;
        Wed, 03 Jul 2024 23:39:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e613de7sm61593406d6.118.2024.07.03.23.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:39:30 -0700 (PDT)
Message-ID: <668643a2.050a0220.5b478.a622@mx.google.com>
Date: Wed, 03 Jul 2024 23:39:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3351978780714020473=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: MediaTek ISO data transmission support
In-Reply-To: <20240704060116.16600-2-chris.lu@mediatek.com>
References: <20240704060116.16600-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3351978780714020473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868302

---Test result---

Test Summary:
CheckPatch                    PASS      8.26 seconds
GitLint                       PASS      2.58 seconds
SubjectPrefix                 PASS      0.99 seconds
BuildKernel                   PASS      30.28 seconds
CheckAllWarning               PASS      32.33 seconds
CheckSparse                   PASS      39.03 seconds
CheckSmatch                   PASS      104.20 seconds
BuildKernel32                 PASS      28.58 seconds
TestRunnerSetup               PASS      522.48 seconds
TestRunner_l2cap-tester       PASS      20.23 seconds
TestRunner_iso-tester         PASS      32.98 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        PASS      114.02 seconds
TestRunner_rfcomm-tester      PASS      7.47 seconds
TestRunner_sco-tester         PASS      15.07 seconds
TestRunner_ioctl-tester       PASS      7.91 seconds
TestRunner_mesh-tester        PASS      7.91 seconds
TestRunner_smp-tester         PASS      6.92 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PASS      67.83 seconds



---
Regards,
Linux Bluetooth


--===============3351978780714020473==--
