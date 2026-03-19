Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C60F283FE3
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 02:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773886627; cv=none; b=DfzZdmNZ/LQq4owyZXBYduD0iPjzfH0tv48EklZu06vapChKwqBjqhhIwn9kcO7sv90RiGBN86aseeKKkD0ldEC29ji4srV1xeKQfCM876hUgboSiYSU3chay1B1PlrkQq/bMi5kNKlLKSo/IXHiksbJz2EjPypaLisY+qzjrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773886627; c=relaxed/simple;
	bh=j1VvDSqldoXJD0KFKPBSlr6YuT13b43im6skX9C+qx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGjytcnUZQHHtkRqymVyS3DI9UyzcYPwAUi7Xjp/pRShO1fyC+kOzJrPP2p/KsOP/UD+56Acv628EjG+SZjwvNiRuYcyA7W9ExzAVAME5CJDNe5ZgSkiZjIyJjbGzE+2yLBAbzESf3XvgR0LG0YPddcUs7dKKudt0D0eBBKWe6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xesxen.nl; spf=pass smtp.mailfrom=xesxen.nl; dkim=pass (1024-bit key) header.d=xesxen.nl header.i=@xesxen.nl header.b=b6gCms0I; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xesxen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xesxen.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xesxen.nl header.i=@xesxen.nl header.b="b6gCms0I"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b979d16dd0cso25905266b.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 19:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xesxen.nl; s=google; t=1773886624; x=1774491424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=14r1BhZBaNOdJqj69vuFtAotPrO/aSWroP5fasxtKR8=;
        b=b6gCms0Iww6iZV10eUA6/77C7K9Gp24L0L+Cm9Jc92KJyL9mROZPmad5hzj5XKFNF1
         sGH1Urvjo5FRjpxIiknwlGVcVbeigxqh9nH3DRMg0c17zz7f3I3GTS/HNYuM5K+HxP5H
         ebFOHV2vr7eHbd8jW94vLFFxjwrdqgVXrX++Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773886624; x=1774491424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14r1BhZBaNOdJqj69vuFtAotPrO/aSWroP5fasxtKR8=;
        b=Ivda+DlctTpYvGMY0GujukP8bKK+YfSa5PgmDWJtykeG0SQYN2EVnlLUxE/7UVHVkw
         mPzP7XGk0Lpf4OfXNWjcQL8cxDMwzCNJMKhJRD2Cl8vUTELmBsCasdbRe2Ed0Q3uwwaV
         EDj2v8scckFU2KFRdz+1uXleUZ7SSuAwAIJ5P6uiQ3Kah9jHY9+K3mx7mtRR920P72bD
         aj6bLNgtO2RS5lKswdfb422tWJZYEkgVZ8l0kdHDuZRcOfo0Mgp0P42sO7rU77G3GL+Q
         OawdJkHfJHnp5icU9DD2NdwHhXOgWxykrkHtlnpcdVkkch97807q6VAUQC4/kN/JmZE3
         E9cg==
X-Gm-Message-State: AOJu0Yxt6Hfut7HpUuSfnYzIrOZIuO7WxcrNDV1DbQfxVSPNCeQYbljv
	gtuZillXdTSW2xr+PhPn9EJbdbbxvsoVzVBKDerLdns/Atkj1Kw3mCtGgzn7UIB5bhMHGSNfErM
	CA+ybYt8=
X-Gm-Gg: ATEYQzyHLntB3KwRoE/Slu2o+LBD8C5UJmwGHRQkN5QBsZsQd1g1Vs7rWttY4Stgebd
	Y2KuNOYNEoSNxz4cWiHjUlnTQLZUrYP3sz9o/GWiDoHx+VvVb7Y/JvRx4m6IQ/HWO/WIhlauuP4
	fnnIri/61kAcmbHIMXvn8D7Jnltu3SLwEhArY3L829DmeuIRBDg3Kc75ejhkZJxe5Ls1DnC4Zf9
	obh0IsPrj86wiHkB8S+Z/Scp5gFqZ5qJuVVqecsuPJ7PMGtOLmbhnu0Mykx+pefQ37ksfW0Bc1M
	hQanh8AMLpjdUpZjB7tA/eCNZu0OMWiSxXbpvwoVIFPQiJOQYT+jEMv2LouLB3xC3kXloPBNHT6
	a73T/BRxJqR39rtM9bcHmHOwjO9INA5ykNZW0P/2WVkIQf7Twoc4dNb/1H7+hB73ninbnx5XZ+L
	NTCHRhcvAV7CwK
X-Received: by 2002:a17:906:fe4b:b0:b8f:f08a:4b80 with SMTP id a640c23a62f3a-b97f47a69f4mr363746066b.3.1773886624189;
        Wed, 18 Mar 2026 19:17:04 -0700 (PDT)
Received: from tomoyo ([2a10:3781:4903:0:eca5:f23c:3275:af25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f142b8efsm377083066b.17.2026.03.18.19.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 19:17:03 -0700 (PDT)
From: Wouter <wouter@xesxen.nl>
To: linux-bluetooth@vger.kernel.org
Cc: Wouter <wouter@xesxen.nl>
Subject: [PATCH BlueZ 0/1] shared/shell: Fix SIGSEGV on invalid input
Date: Thu, 19 Mar 2026 03:16:44 +0100
Message-ID: <20260319021645.2137513-1-wouter@xesxen.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `bluetoothctl` when entering a space followed by a tab the CLI
crashes with a segfault. This patch fixes the user input handling.

Wouter (1):
  shared/shell: Fix SIGSEGV on invalid input

 src/shared/shell.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.53.0

