Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1502264A7
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773603861; cv=none; b=pp36rdVb68BR9ysXKeBZd/7K59n9nrFADa8x+BNY3Zf24hBDOdgjJlLEW5CHk1410VDNumxU4dlo1Nhf0vP1I8nDqOn1XqkoNyNnez7JKpAcmGf3r3j54/nDdFH3C5PzytLBVsBaL2zDr9rbVW39ZqRi1jsa3cgSNmKt0SinFGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773603861; c=relaxed/simple;
	bh=P1+D8uHiITLRZsdbMyrnrhaZG1oJcsE6TYJjox6MOsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfynGSlK9h08FK6c7Rm7zntmQyKeIGtw/QWNPzkT9uH8uerOUqqqZT40hY/ElzUnsW3G3xkgAbdpdQpqYSN/KBVPwm4a4mbKldsTgYcI9gKUlT0gplfmJ+R1o5C1OGeZUwWvLxp9/BgHltsjzqJ2Vi9mEShcJCmahDG8RjmGN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuwNlOjQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuwNlOjQ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b7c2788dso2384430f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773603858; x=1774208658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1+D8uHiITLRZsdbMyrnrhaZG1oJcsE6TYJjox6MOsY=;
        b=BuwNlOjQ9uwSPE9YS740n4Lz6gcwDcjEd2lP2gSoDhcPEkA97X7f+tr0vMdq8/sCib
         V3hLbnX6MMFjK4s8FLGvlb8L3DVHPqL9j6V3qOT86/IIDKTooWOb9RYstXtdhzX3zJf7
         22IEX2hOOsMZ8Wt9j1JyaktQbiWgbLJikcahUhASRZcmtbr4XlIRuPYkdoxdaBsouJZ/
         vZEz4Fep3yeQxc70nPjO9QooIW8cETY2V0Z7h0WyeF4EsdK6fKfOL9AbNx9NrQXQuZtw
         RXxrIfwi68KFPX5K1lB+erKVTVkoS2DB0Lxd7iLNZ5vn7uxGVkA+XrG81r2aX9B2Ex4T
         Ml5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773603858; x=1774208658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P1+D8uHiITLRZsdbMyrnrhaZG1oJcsE6TYJjox6MOsY=;
        b=dO6z/rBn8p2DOyo6n/gZO9entLMY3In9Sfr8hZGXZ5ppb/5CeB8bRJFvLgv117Pv+9
         LZX5nUbaEn4bktX8diMpudUIWJDbm/RHSwJDVhG6GYVH82/i3qN57UhDLCPgh35CHcut
         jdIc0j/lxDPGDsuocHemtsmqM3Vwdz7gJuYBPP1atEIuTRxLI5btAuCU0SW5SlF6rs/E
         Z+VMyZxiAOYVNR8Dg57hqZqWm53p87ZBYAmsQeaRWepiVP4X78EFTfeGcjwIAlnYg5fH
         X4XSB0B7ifXeLo7gwK4RJZbVZGPyPhqx9gImuYnbclIXfptPd2yuBrSeN8vEAyOmsYbD
         pMNQ==
X-Gm-Message-State: AOJu0YzyWL/4dMwMteaD1EDwtewHOYDbVvrLZxiC3r4RRBd3uV2G8o8L
	ZrEx4TMs0XxnWflPmpUl5HD+sGD4nhCy7L+6UYFms0SJL+jD4y/h/oxZ
X-Gm-Gg: ATEYQzzggeSRojeAitP9UdYayAZXhu4qLlQQugYuThv3S8QQBaruY2C4DDm7KVKdUr/
	WJClmr4qevAGXo9iGXz2yciZ6HTbLFnydJ9j4x/vB2TKS4b6xJ1cgL3JYcjM8kmJaOWUY6qbZRa
	e04r3WGdHiIJitGy81VPI0o7+ZORemJsiSMqaojWu5Q977WRvooZF3uOXUotOHUFZbTbFqn/68J
	dJ3W4m+EqXd6ynzbN9nCrswKlbLIRb0gTeUASw1pHy2lcJyoXrtE+Qgo6bvzUDevo9jKA3cGpGe
	sgwdWLsvR0yr8wB3FltCI7eJjUSScE0m5dPSeTH1U5jcE4gFhEJumvKIK2qJOZ4BVWjQSa8y0pu
	6CNn1HNDDttSP7NNPkuxpcTM1boQRTbOFGbfdkFR79LAkJ5pb8lCLPaYxiIeo69PKrw6+dZQp1X
	adEq9F5rWpys0LsA9fOM4WfndlW2XKoTkc7RIjuxP0TrMMtjGBYY6hbKQrDAw+/IQv3XrGl0L6c
	WJbyxzWYqnlLw==
X-Received: by 2002:a05:6000:230f:b0:439:b6d6:723 with SMTP id ffacd0b85a97d-43a04dc3209mr19348293f8f.42.1773603857831;
        Sun, 15 Mar 2026 12:44:17 -0700 (PDT)
Received: from localhost.localdomain (141.red-83-46-201.dynamicip.rima-tde.net. [83.46.201.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3a09e453sm14261327f8f.0.2026.03.15.12.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 12:44:17 -0700 (PDT)
From: =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	luiz.von.dentz@intel.com,
	joanbrugueram@gmail.com,
	Linux regression tracking <regressions@leemhuis.info>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix not tracking outstanding TX ident
Date: Sun, 15 Mar 2026 19:43:36 +0000
Message-ID: <20260315194407.13904-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABBYNZL3W4+eF5ap7dS9ZSPmYkTLgmAEJ0H=OkC04x0LfXuqLA@mail.gmail.com>
References: <CABBYNZL3W4+eF5ap7dS9ZSPmYkTLgmAEJ0H=OkC04x0LfXuqLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

> > I had trouble connecting my Bluetooth headphones on Linux 7.0-rc1,
> > and a bisect landed me on this commit 6c3ea155e5ee. A revert fixes it.
> Weird, there shouldn't be any logical difference but perhaps it's
> device-specific. Can you collect the btmon traces? Actually it would
> be great to have the before and after traces for comparison.

I have attached btmon traces (bad/good) to the open Bugzilla bug.
(https://bugzilla.kernel.org/show_bug.cgi?id=221120), hopefully they
are helpful in diagnosing the issue.

I have also done experiments and found that the regression goes away
if the IDs are not re-used, for example by commenting out the `ida_free`
line, or by replacing `ida_alloc_range` (returns smallest available ID)
with `idr_alloc_cyclic` (returns all IDs before wrapping around).

Though I'm not sure if that is just masking a Kernel bug (e.g. IDs
getting released/reused too early), or if that's necessary for my
hardware to not get confused by the same IDs being quickly reused.

Regards,
- Joan
