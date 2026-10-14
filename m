Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7532D0FC
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000265; cv=none; b=bI6r2g9e1mSjPaSWtXyEwkSnh3wsokl7rwlCXdFdZsQVNflRC/hCoH+nC3zHsXywr6MZGzolo/n2RbpWJYG+vb6a4/1xesF52R/gWkVhLL2NxqUgVM5bAv/Uo99dyhw/dRwWiCb6Bh36ZWNuWkOBvIj/Ik9tQ1bquth/VkkHcvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000265; c=relaxed/simple;
	bh=7FybBtKkUJP7s4rvraMKZTmRuih5TFYoczkSbYOKvTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a58YhVgEGliRz2GGUkQKlZmGEcExzs+ZH6xhIeUzNlPk/Jx3D1QXmSfCfJTo0xcTQKG3zOar4tcGmMuYQvdHj6SgQGzxNaLocvwdojeQoslC9aRVBBZ28SPYZVKGDO3r/qbr8voLu496YWEwHMISwnJbnnA2qkw72VwFIWVKkzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hl83wpqf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hl83wpqf"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c14a06c95so3502375f8f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792000262; x=1792605062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7FybBtKkUJP7s4rvraMKZTmRuih5TFYoczkSbYOKvTw=;
        b=hl83wpqfFtescdilSPZilWRgziTrwVU5BshAl1DmmMQlzl6+ktaK/z9pqmlWiR7JNS
         3TBBKbJxpCgougio0yObiwcbrc6FDSubXVM6XqSObHtCC0SBOcB7AtHFy1eIdxGm2Rpl
         Xd4kUZy5WP1W4vwyMixPkoh0qG3aNsqg2huPyrgItSQJqafppvRp9q6QK8E2op5ViQCP
         2wJJam8fJAn1u92fpM1Wc8P0EgITci6sxFtmzVnJtzcV6oqf1DBU8uNK12yRct6DnwbY
         zRrdSHX18H/3ZfZ84Be2GP47k2Phvp+UMDA3un9uV9T85TmvI7wb0E5XFWjeZ5ZKqEOX
         gRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792000262; x=1792605062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7FybBtKkUJP7s4rvraMKZTmRuih5TFYoczkSbYOKvTw=;
        b=ZdAG86rvyvLmEdQIFE8cvXWF0t0/9euSadCcL1DdUIyE6KUhX+rCR9ERyc/2q3BMLP
         qXs2pxLK74o2oltzXaiP1tnWnXAqLDvgccqKk4G3zBNYufFOA8zu0AmDsXTcUgnWDFNM
         IVOejxL9ihRf+JzDEZSws7sYiXR/AjMB7Z/GRqvCdgERkEfDQvun/R1z6LP9eOuPWt8e
         mTMG7wBH0OwtGiXyAQoNhcb+zUrjGsL0qyaXjRmem7f4WR/nk0zPxb9UmpB+Y/JyQNQO
         rC9Kxlm5SsrR5LtW0vt2Kki321ShiS3MrEZr+VYPfp/0VCTXyHJZ+z1PMeqOjuYz8EL6
         ZW2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxAWNwiLIF0SDJ1KcQliZPqNM9LVxrumT/yCc5K1nJ6ue/uTNjn2EJu66AcakpiVAfKRUIbq5OwS/EKkB907Wo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJia2B4d9dUyygZzCZys0CImtilVvXawJ0/jnA2lDLx1HjBHivJ
	tJCmu8os07aLfHEMtUWLjvRS5AcRW5c8EPphImTcG394B8ER/6lQUwZZ
X-Gm-Gg: AYBFou3ybETADRoitkGC/0qWrxntQFonrFpLsZFsOcd7LkPVtU/+xmDyXcqlQj8FCnP
	XtpVKHVq4vM7VGZ5xcOPUCy8lWxwE2b4ey/erMz0J2O2NEsgtMGoPHhMbpo+yJkNo37vJJ/pdyA
	NTqmCOcnwu7oxKhPWirEauhuM9XXshWLcw816hFv+jbxn1H6UvXekJIp9tYY6w5jDi0yrb8mkRP
	x6ahdt+eqPYmn8AZJjtQka2MiOEz8gveZZ3CdyMaGx3SHSPxB5M9Cs9LNykGHyTOYytLALoGwD8
	zGgScW/LG0r4mYCxbbKYicA96dD4bMYd6NOGr1gLx1+HbS1awYSFcTXr9vupE2/usjOmHFS9DMR
	wlS8kiDu7E36OAsgJm/5jQCMHps9MpclSHj+YbVBgKf639SQPGr3U7trYXwxtUW3m/vqt9c8R2J
	BIxxZIaM0TuJSTGPVRWhuGWM1KxOar9GcoZI44qysCS06PD1aDpFTbHbYUs2oAH4YUrwLRe9DTI
	/S0U5rDplWrAk5JU+AuCOJ8/g==
X-Received: by 2002:a05:6000:29c3:b0:48c:58d5:30fb with SMTP id ffacd0b85a97d-48dba7876bemr21587335f8f.5.1792000261965;
        Wed, 14 Oct 2026 10:51:01 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac37acsm13258365f8f.34.2026.10.14.10.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:51:01 -0700 (PDT)
From: Vladyslav Tymoshchuk <tvlad744@gmail.com>
To: Birk Skyum <birk.skyum@pm.me>
Cc: Vladyslav Tymoshchuk <tvlad744@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_qca: Reset the in-band sleep state on power off
Date: Wed, 14 Oct 2026 20:50:49 +0300
Message-ID: <20261014175050.21982-1-tvlad744@gmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <179199941686.68860.2209253288195283916@pm.me>
References: <179163212446.46972.2306254853726299632@pm.me> <20261014162025.3733-1-tvlad744@gmail.com> <179199941686.68860.2209253288195283916@pm.me>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Birk,

On Wed, 14 Oct 2026 17:36:59 +0000, Birk Skyum wrote:
> v2 takes your code, describes the AWAKE trigger next to the WAKING one,
> and carries Fixes: 3e4be65eb82c and Cc: stable. The code is yours, so I
> will add you as Co-developed-by, which needs your Signed-off-by. Reply
> with it and it goes in above mine.

Thanks for running the power cycle on the Yoga. It is good to know the
stale state shows up there as well.

Co-developed-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
Signed-off-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>

I wrote my version with the help of an AI assistant (Claude), so please
also carry an Assisted-by line for it, as described in
Documentation/process/coding-assistants.rst:

Assisted-by: Claude:claude-opus-5-5

When v2 is out I will run it on the Pad 3 (power on within 2 s of the
power off, and boots without local-bd-address) and report back in the
v2 thread.

Thanks,
Vladyslav
