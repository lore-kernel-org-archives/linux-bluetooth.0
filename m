Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DF812FF69
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780706674; cv=none; b=lyGw0HpWra6ix3FOWD/r2srPnd0XiUUcc+3r047WvW6Ms/Qj57Ja6SHV78+Ny75jVG+zV7geF5WsaomSEtwleIZNDxpEMDenFN6tXefiK4Y/6ZRaLIwRLJMN5mDKEsqSNju/Gh3XuceX5OaDIknP9bCiYM0wmn2hBS+ygIenTPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780706674; c=relaxed/simple;
	bh=7NfrHTjDZIaD4aFoWX+Fb1bH7nNoLeXC2H0jASF+/VM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mWqS+fFRbLXG4st2GrSqhBHIOOcJ18gsjO8Qm5bjHiWCsoyiEL8NRY4HbHj79F0lSv6QeY5K2xcCUdJp91NrpnZCjV/NNGm9cRi/FUi3foAQG7nP3lQLvrPZ7P/BfeB1pnlQijrhUCkOmDTbMs0VEEO9RHCJkCvE9ol5QxqXK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDS4WTMK; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDS4WTMK"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8cce26ee1e9so36398516d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2026 17:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780706672; x=1781311472; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bPEyge7IYplQIg2yzLvhbScUahl5/IC4r6DfkfjoDYs=;
        b=dDS4WTMKG2LDwAGZVg2tMabuz8fNZytA+RO9DYIvIv+YE15+THbKMY/zYEtIkpLk/E
         4TjdcKEhxgR96akIX6klRI0tTQBum6zfsy9vxqpkY5DlQwmxtD3tgkIs8hqcQnNrSBk8
         eHUy1ALF54W9nwRchdi8CEr58jVLKoa4JdDQY04y5RRax8adY3FeNdTrpIqRfp+V1RSE
         S2m8ING0DZkuRec2wuTC3VDjNe7iz4gctpxsAl4tZEX5r8v+NPPQ9M8us04HVgA6ueVF
         Z1BgnHE9uq+6RlDdRe9/dJooWmmJxjJb7GjXdQzCKYx6lo+E3rWplwsCKxUM888iNhPk
         J+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780706672; x=1781311472;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPEyge7IYplQIg2yzLvhbScUahl5/IC4r6DfkfjoDYs=;
        b=FfdG368tA+rW+F8ZuBZJ/rfmko0tGOPUykHPw3Wx8F4ak6LJ5AS2e09Vnqgd3vgqni
         7/ihv3DnRwzs73KQ/GvmWpPONSN6Wgt/leZp68fSDopBLEVjVkmmMXeZWkwr2tcWA7QZ
         1UYAE2LJJ+byv5CRBSgBjNqh2KmUaecFqYjD6PzIKaVlbaDww5gMzB4XcnBaPA5iMQlN
         GOmMmWVxAKlscgJXRpPXob6MKEbclhjWYcG9wDLzPde3SjeVYdqVuQZzzbsIf9s4fcZU
         4+WukvOIoKjFxRw0tV9qNcK7BU+oe9ol4HFhL8RCjpVUdV6VmqspsoAQhBV06Sjufa3D
         1QXQ==
X-Gm-Message-State: AOJu0YwHFb6ywQzMxEltXGWxyJClNJ+j33x1djM8cHshn+JyCDKy2HDI
	bzoFB4G0xED/j6nmkI7pRNUFwn4Bjc3I0+8sQJxMaJLrz2RqCd5I4SK4+6b9eA==
X-Gm-Gg: Acq92OHby+yqH/wVUR7L5P1NeD8+BDT3oGZeXwlCZG+16RDKM5Vq2tdNG6RhIuxsmDv
	QPiadSHVLC00BH2wVgK96pMZeks7miL+TLReBegyO1Da5AveJfTuHh1tjoIhrhZv5zrvLY0i3GV
	0nQ9yIzOyAG7tnAj/upLKrL/Q17+h+KrPjr/MM0djMGCO0yT5u+51M2hayjN7eBBJbFfPGUf1a+
	4MuNyA7c0JfmhRTPT7BC94gsnaAU851+39E6VkxHRiLiLuDkMxJmFAymCBSzUgJGhn+3Ys/3zip
	dutZ/tG7YvLRkmSNvx3ShItk6BFTUkAX5Zwclpp/vzp3ZzBGurqZhiSBHmQtU8mKjKT7FAVWtLx
	eUI/eE5A4LirHzK6AZdTT2rNb08o+di8+lC69eQ1dKa0MvQuqz84SDfRpTi8mGasPXBTuDPSGpP
	c9ovsOrMB9nQdf+zarAqvwysgvr7eSwdR/xgfTE9k6xlLnl4Hk
X-Received: by 2002:a0c:ebc8:0:b0:8cc:d06d:f8ec with SMTP id 6a1803df08f44-8cee5fb5d19mr81002226d6.1.1780706672479;
        Fri, 05 Jun 2026 17:44:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.188.87.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccda2601sm94571396d6.6.2026.06.05.17.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 17:44:32 -0700 (PDT)
Message-ID: <6a236d70.ff298dd7.3321df.1f58@mx.google.com>
Date: Fri, 05 Jun 2026 17:44:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1238146512998805157=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Add 50 ms delay before MAC init on BlazarIW
In-Reply-To: <20260606003637.94628-1-kiran.k@intel.com>
References: <20260606003637.94628-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1238146512998805157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1106883

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.07 seconds
CheckAllWarning               PASS      28.22 seconds
CheckSparse                   PASS      26.85 seconds
BuildKernel32                 PASS      25.06 seconds
TestRunnerSetup               PASS      531.09 seconds
IncrementalBuild              PASS      25.20 seconds



https://github.com/bluez/bluetooth-next/pull/290

---
Regards,
Linux Bluetooth


--===============1238146512998805157==--
