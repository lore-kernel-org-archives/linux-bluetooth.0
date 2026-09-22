Received: from mail-oi2-f32.google.com (mail-oi2-f32.google.com [74.125.231.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACCD4746B1
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062874; cv=none; b=inn63QRFlAJkpyfWFomqWZN04iyDSvfEJxgiNj1fmtDpioqbdozfQ+jQOG4cB7u7M5engWO7bcqTc4y1k1ols7dSZzH3+ppi3ezymlOXeCS9hs/3QuGeJchYPuUgEn5LwkfmmebWfxbrZKzwU2qI9MuPGwmMePN7Xzl3bO0/2J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062874; c=relaxed/simple;
	bh=U3WsEWv7LCCqKVxrO2QGKtTKhF3FeHwBp7YQhrpGS40=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uelz8/AkhhfTgWZ+tFVwAKogaQs4ymcr6J9fmEZ0n+SVG5J8Gp4sNtiJ8NcZCd7P1hJ5aAzuj9N4ZSVoyJ1kRdBmwQp84hNnKujGuz6/LEvAeoK4Sz1xuSQLYP7q7CWuoUKJVri7XybyaNXqxh5A95Gq39hIgxeXCebn74O6zH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2yKZBbm; arc=none smtp.client-ip=74.125.231.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2yKZBbm"
Received: by mail-oi2-f32.google.com with SMTP id 46e09a7af769-7f4f0dd5507so1598516a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 00:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790062871; x=1790667671; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CSMEzNBzYDYsfJyjsKZiPs5Xjl9rWxMIOescc0mqu0A=;
        b=I2yKZBbmxldVocAEMSjUACsMKFx1BJR0EM7OD//lCFfcKuDGu0RB4YckVRay4kSeHc
         pIISZNrcmPtjlrBoLWeUKGTIJXmGc8mkznxob1jpWFGztFC2wVHQBvBlJ+e3smSJsC7J
         duA9WjJz54jU10LvCLwfq5fvhiboNysD1fyn67WyKTLecNwYQjj53mlgaITcFHKcJd20
         SkiYHKmawKL1lS5ws32BTtaKXU8yEyJVPx1bDPf28qhBchYFMn6nuLqAdzprcdkT+hej
         El6p0Ra9ukA4QAabzCw9n9WzanEuZ+8TC/5W5sUfR1YUMLK4TLSqWbbiAjo/MhvnqYc/
         56ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062871; x=1790667671;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CSMEzNBzYDYsfJyjsKZiPs5Xjl9rWxMIOescc0mqu0A=;
        b=L8tabeF0E+pI8xYjkPqGFroQv5i3qIvtZ1ik1baNmUOrJlx+jWeWk4q48iGD1yAN9H
         RAP2rZK3OsrErSKi6nrlfhXTyI35pdojp4H5OgztFHPVFiBoresIZUcZo2xAaNKzVMuR
         0SZo671/abBHaASH/eGXnETkKuX3qzuvrq6wjbDAIbAOiHgHTDHdNpUdCR9FRmI7fUH/
         o+Tcq7KnTK16irqj9VjKii6Bf7sHpHv2RTd6jkSCxj00vGJjMPc3nZa6Ro/4qD1SVRYH
         x4zffMjw67YZpHWoXd7ckTS6dwSMMM/hipNtL+dKLC/AdEe4KrqNN3cixH7Je+HSSUUb
         lz9w==
X-Gm-Message-State: AFuF++mzSxysFegkulLUCJwAPdrv3sIPuvDMvgL6chMCww2/2nM5iF1P
	cFlFx2vIDNbvWL0UJtGYgazvysD7aD8Bk3XkSJRSIAZStZJA2X7b4sLdXHLjgg==
X-Gm-Gg: AYBFou1HCO/E8cd6fCPll5RRoGwIaFHLgyJ4FDK/dTllijbKFUdFs4TSRr1sW5lKfI/
	8dGib+gWB/bIGrSrES3iIvy4eh9cbAxjgN1Hh7rYwYhDacVvSg8E9dr5Lrss8y0Apy/Ccp4D14w
	/ZKJ7eFGcTBssZGRLrGDVA3TSmwLlOmY9pG3f0eFA8HAvRKkzqP3b7V0pj4fzp3+oKPgY8EYGIg
	LcSVoB5pdjrhku+qbipQs+EQL3dBjyT/AuJSXFgS9NZ2qGrc5jIIXw+gusWCWd62awppoJzNf4y
	6tDKYcvj82Q4AM2GUQ/grNT6iaLK9fiVTt5cRuBMFiamyhaHdOBG3eztFpMrYMW0N7h6vqVNBKP
	QiJgAi80WHyje9gLPTWOxw75xb79l+QOU9M4pNC4uAfM7TJKl6XdGrWV1YyUq5d3slSw4XBEgMU
	6W/DIr3/aB7c5lwMyEYnIqxwwZ31+TUxYQCjdcYuWF/pGLog8fe0bN1IixIPw2iCf3GDjWD7jaa
	civNg==
X-Received: by 2002:a9d:4c8a:0:b0:814:aa56:6f34 with SMTP id 46e09a7af769-814aa5673e8mr1488421a34.30.1790062871338;
        Tue, 22 Sep 2026 00:41:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.238.82])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-814e6493352sm1149260a34.18.2026.09.22.00.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:41:10 -0700 (PDT)
Message-ID: <6ab23116.7fe089da.c68c9.6d6c@mx.google.com>
Date: Tue, 22 Sep 2026 00:41:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4615090993613507980=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: Bluetooth: btintel: security fixes
In-Reply-To: <b484c13e104eab61a42e319dd858bce971a8a8ab.1790053452.git.chandrashekar.devegowda@intel.com>
References: <b484c13e104eab61a42e319dd858bce971a8a8ab.1790053452.git.chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4615090993613507980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1171032/

---Test result---

Test Summary:
CheckPatch                    PASS      2.08 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.33 seconds
BuildKernel                   PASS      28.35 seconds
CheckAllWarning               PASS      32.16 seconds
CheckSparse                   PASS      35.56 seconds
BuildKernel32                 PASS      29.98 seconds
CheckKernelLLVM               PASS      35.27 seconds
TestRunnerSetup               PASS      760.21 seconds
IncrementalBuild              PASS      30.85 seconds



https://github.com/bluez/bluetooth-next/pull/812

---
Regards,
Linux Bluetooth


--===============4615090993613507980==--
