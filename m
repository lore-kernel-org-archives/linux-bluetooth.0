Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511BB13B293
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434312; cv=none; b=bp1L803F8Ahv4Il9xHownTwnvXqkQ4DNrxdCSyXUVhiOU2I4Pb/n4Z74O+/B0xlnYuLR8228esW3cMjei4LdnpJXF39iGa86Of2Ci/zCDj9LhootObvs2uRFUmjkyB5pWlRYxFdOcQ2TNnCG36rhxj75FS8Uw/D4w1z2dQwM9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434312; c=relaxed/simple;
	bh=NETR50f8a4732zrqWyl8sKaC87Oe9QxCmfmb0YrFGHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzd5QZ+vdzUZSKGn82SzBr9jL8HdunnINhC8osLuhBjFlHK3W25a+66snKE4dI+CQFupHZShM5po9ROnP7tr3TEOas8oyI8Pvg4KUXsDlaYGxpkXjD84DLVSwK1iMf6sTtlYkOxXUd07EI9VcX9KL0wk3fy2cGZCz3uxJbstPjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtu1SsGR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtu1SsGR"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37c867bd3e0so273219a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 17:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782434310; x=1783039110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NETR50f8a4732zrqWyl8sKaC87Oe9QxCmfmb0YrFGHY=;
        b=qtu1SsGRoZ49tabKAQViT/dZDHYWR4ammYa28X71UZ5+gMUIIVFQUG0TshoKJK97tY
         uy8Bv1nqxiAdnfZg2OOdflh1urpYW/G+UOWh13jus+BQSXRdqRgjpPl9K12AixUvlF9I
         Xw7fV1KqAwY64S+l4lflLQ+AU2qEcmGr+CTlRMqFtaDSrSGWkAhgz5mcw7YYKhwqiqhk
         kOjjsh4T5Rp1fVGDYAkGXooLXeie15sAB8u9rDiL48UiVtrw+2Ae/TiSL12PRNhnglBW
         +tB25Js3an2WhocqOanK3oyeNIcVj1T8NltcaqI9qLpq7VRBWNtia02bHyRsPSgnaPYz
         R8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782434310; x=1783039110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NETR50f8a4732zrqWyl8sKaC87Oe9QxCmfmb0YrFGHY=;
        b=YKDUTTknfryyNPaYwkcsycHqSGs0YhIsgCCbWH+cfcq+tX6dZcUurMmhwA7RLO8fOd
         qtalnBqHjPKgBFr8Sug8dotex5IXAf+QUCx0sjg0yosLiKDMQWD56PNiO5Q4dbX6e6ep
         NhxeDPwZnudB2pGmK3Dfi/AXvQ6XOhtcWlA5749uGBxqkj0pokceQA6W9ogmp1LVg+x/
         ojrSVvdKaygiGMxCsnZuNvbzgCwRc82PU1lCLP1W5n0Nie9WrLp2nvco5IQggVxFWJpr
         6XqeRTe4vXyXSmanq9MjxBulsKSPekRWG/QcpTiPOr6Kt5iP/DGizjLDoNLMJGLVGsRW
         usdA==
X-Forwarded-Encrypted: i=1; AHgh+RpQVYmdkNBfFxSYO2HCLMCR0Z/EyLWh2a5SJrbCT4R8VIf+rMqQ0wAIj7IgvxVqtGNYc5MEh6m2CzNQyThXIa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2wWP7t1qtSVvLGpR6ZvaHenY3CPu4skbXvNiAWyR36n5G6rj
	k88C4heXqr1/HV7+PemgYb75VUWwHgLDnV13316VP0QK4qClQ0GInvQS
X-Gm-Gg: AfdE7cmby66HCdgVkQwlgEbcPRINnX+cUs0GX7lza2BmUsLxvUk7+7hOfAl13DFzh8E
	iU6np1gzXHxwkQ77eyMGDE7Ae66Ft63mZ4xhp82R6+Ig6bWia5i+h9kcfRg+pq8d6W/HVbKreMD
	VnvgVMHrZ4uCNUR8fIrv+o7UKnxFbVgRcMF3Oa857fzX0hVdt2VlyEnnO6UQ6tORxwf4SJy48RG
	SLutPFJkUngr4p7mPiNZVzUIj0CRiaw3Q7gaG29hkl0aB3jMS+fazpAOwf0CW8rk9yWgCJXXWjv
	I7IM2PzIWhYDkMnQnxheuqIMgmCZxnyk6z1qC6moHRMOF7bg2lnsptYWsTWNbwFrgMSkwioDrjm
	I75ZN/kLpByOGYdSlBge6gArT7N4G+O2Y5HviA6FbdZD+va3YxPJ1qm7A18Scxj/ADHQQi5LLCs
	IPYpeAbSeFJ6L6TSdqWjGXbiKHbE5fCneqSz7+HojPrMcsPw==
X-Received: by 2002:a17:90b:558d:b0:37d:f91b:b540 with SMTP id 98e67ed59e1d1-37df9f6ed41mr4448075a91.8.1782434310431;
        Thu, 25 Jun 2026 17:38:30 -0700 (PDT)
Received: from BM5220 (123-194-40-181.dynamic.kbronet.com.tw. [123.194.40.181])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37df3dfd509sm2733183a91.10.2026.06.25.17.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 17:38:30 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: max.chou@realtek.com,
	hildawu@realtek.com
Cc: michail383krasnov@mail.ru,
	linux-bluetooth@vger.kernel.org
Subject: RE: RTL8852BE (0bda:b853) Bluetooth initialization fails with -16 on ThinkBook 14+ 2026
Date: Fri, 26 Jun 2026 08:38:26 +0800
Message-ID: <20260626003826.2883-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <b2bc01ba-edc8-4e73-9358-a3bf1d7c569d@mail.ru>
References: <b2bc01ba-edc8-4e73-9358-a3bf1d7c569d@mail.ru>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max and Hilda,

Could you please take a look at this issue? thanks!

https://lore.kernel.org/linux-bluetooth/b2bc01ba-edc8-4e73-9358-a3bf1d7c569d@mail.ru/
