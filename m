Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD16A330B0B
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821777; cv=none; b=eCN+QiUFQdZhSi/bcGoJsJl36XyISCtLzofC4EY+fqDdDvWu9+19hQVU7uBBjzYWnFTCl1cGAA+1/JhGWlXz4XFghMkKVx29r8qEaU27XAc9A3/pWMmAn9vBLHn3vHeO1V/+1ly6cHYF9cTpED9/KWOxK9UfncfCDZ0mIqh1ePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821777; c=relaxed/simple;
	bh=uUVoKRdDlnx2bbN6z4zltsxVi/aVw1j//qSChX3LVLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/NujaZh8c5e9X4aOXbrrFZbwUwxQHzoPVWv+hJOAf3A43mLITfGQ9+gCbMTeMLs+J9/9iJUDH+i/sPA02M7Fr7gp8BG9/iRHz7aBssesZM5SzyqYkOiXGa3C/x5bbZeZLsghTIauJsDQ8HhQVGG+m7nWYyrY7ooOrUBjqsCv9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3bEgGfF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3bEgGfF"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954dff6536so19203915e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Aug 2026 22:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785821774; x=1786426574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uUVoKRdDlnx2bbN6z4zltsxVi/aVw1j//qSChX3LVLg=;
        b=O3bEgGfFh7uKNeCd/IEzoSNvyLoAx6qPZGu6A0UOD8B7Ftc3H2bfAWCeBlbdoIJvc3
         FREu78sTQD1dkdke1jpcKdnf/zKd7068+PJiSj5WhqdSsoHz9L4XYFEmVkWPNDieVdBm
         tr7eW995LRSwf+wwBNYUb50y+rNQcroVKdfsCU0pS5VQl3HFeiXDk8OVs/HP9kHCwEoX
         r0JHl5PRJIvzVhFxDp/LrKZ3PX3yrm5wn7AI6C+QkkVr/9D5gzOsgQWNLBy3EXxNpIU4
         Q+5yHmRR/zG+trodQF+nu+k/7YZDsSF8jIoD9kQ40PdmN/IyCWeeMfglkfd+KZKdnAl1
         AILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785821774; x=1786426574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uUVoKRdDlnx2bbN6z4zltsxVi/aVw1j//qSChX3LVLg=;
        b=Q3pkMvGy1lszzZ9+eWFq3yB1x+kzZq1BE/mFXRQI0J/O/azTx/h1NfG9dWh0w88khY
         7L6N9UhqQcZA/05CjpzO0yDv/FzZa/8AKhQdj/H3fnQE74z+kqORTiCIZJzHsc6yVFR6
         ZrFNwK2LhAAfP2uo5ABvVzT71ljdz30cs5tlWBv4QRNHU7CeYXM7+MM7ntlEmr+fIV6D
         lJvNKzWKvIK4ZlQlVpTI4OaQxCot53ebAwUI7Qm64FZkDJnJg2dD/TkWxW05W5Xya/7m
         Il/FdFoFk78KmOaYyk2Y2yHw7aQ+hGLUD3ib/NhEvKCqcp0lmD08EKQ6LT5Un7bEC9Y7
         RzTA==
X-Forwarded-Encrypted: i=1; AHgh+Ro54mIhgYCNJKWTD4JsJyPsF6HXOLQuXI/jnyhCF5j96+ufav7I2TQK2Eq1LExn07c3OTH2yd1YxSO6ORbRAqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9S0vJvGTullbWwLi3+mQB95LF2LsnBtUYCQ45PO8h3PdYpFxZ
	AgqnmY2UL3mjbEKk4tQAg4a2oa15lkYl+F1MqDsN3sLBOT4kaSIBEYAc
X-Gm-Gg: AR+sD11gpVinym191quRpJXcm4SIRHYGlNcpgYT3unksDFMuFFV5la2wJOlz7DtZNKj
	+jlIlE8giNvEjef3F22VD4VRv3DRvKqtUv0E2lY9rDgzNZu5kPz649pyYcrv9nologeFyYHNUkK
	Xkvgx2Z0445FD8qFDbTBzrV8RTKT46e0VrjyJRaGlFuAd4WgxS8cEZXZpmJVVKIeVZFDc98ZwFI
	6n+BxQEjosie05t7hLDgYfcu5WqYm/YHw+og7JPd/uhr6qYHV8iQ7Y9F81m1hBflIVG31BSfbr2
	0Gu4+RJW9vRZqDKtX3cx0M1NTYWvO+Y4XUS9Q4cqwXjqKf8HPspdHsXf/z4EeaYy8cDAWsdCsqm
	3vKkuS5d7Z9mI9ftJxtMcBbwWM5Ays+46O5btPGK32PTOPHdcEM9OP72J89lRoW9jJ6azzd1eHb
	RpAaXhPqqiUgK1V7/anV22k0Lc2pNP2J3OwTU1vNzyuhBFjfbAO24CsM/ZEkg4HMl3kbY=
X-Received: by 2002:a05:600c:154b:b0:499:49a6:4388 with SMTP id 5b1f17b1804b1-49949a643f9mr61634265e9.17.1785821773878;
        Mon, 03 Aug 2026 22:36:13 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0fca55sm58641705e9.13.2026.08.03.22.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:36:13 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: sashal@kernel.org,
	lvc-project@linuxtesting.org
Cc: alexevgmart@gmail.com,
	davem@davemloft.net,
	gregkh@linuxfoundation.org,
	gustavo.padovan@collabora.co.uk,
	johan.hedberg@gmail.com,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	oss@fourdim.xyz,
	stable@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.10/5.15] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Tue,  4 Aug 2026 08:35:55 +0300
Message-ID: <20260804053555.945430-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803203505.stable-0006@kernel.org>
References: <20260803203505.stable-0006@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Did you even build test this?

Yes, i did.
