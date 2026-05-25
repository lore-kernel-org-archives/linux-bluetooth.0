Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104AF3EDAA3
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720626; cv=none; b=XnuKaDdHcuaRzfsXrai3klpTAFXhPlr53tk9w8P2rAWiPsMjoBJ35jZhtm2ljblZonVeqKTvmj9Eud90a02G2yunUB8g1N0Ef9m+NJ2YAcBvxS/Zmq1ecDfQmRts2YmoqWRkTVqvQ3lw7nRVAHfLYwHhI71DWjdg2PTHLVregCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720626; c=relaxed/simple;
	bh=uUOGge6hm2Qj+2UHmbMgL4wqzUwz1X7CDqbvgz4qMsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxSamI+vRplF6pmXa9fohkKTw5qvOPH7z7/jYpX378JV5xaUyebkgK/u1v0/abdrsFDtEoCcsHxeka2xRkv7cIxyQi+Dc7XoMDBltHVf+2SQjDBOUIsGCDDHCbbrkFd84gar6CyX8Ddyen15ObgrwLyHDD6xu5p5qQuujrLhaP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY3FcAIe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY3FcAIe"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49040362e4aso39684425e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779720623; x=1780325423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vztVGbCK6jC8394ALCzZO5oQ+baRPsPPpzoNx2v6wdY=;
        b=PY3FcAIecQ70DN4GS7wazdshy28LwB7wWDThL14BCyjIMm3VUCQRbWXXMCUE3Q0R6Z
         3jPT7ZMXiY4gMAxo3Mx+S517qQN9aEIVG6aAzY0GBfI2mbflmHuAOFKAWwLlUMr1esUM
         UxjH4hQme6Aq7tAd9zk/aXu8qddf1jTkz5jC6p34Hp6+2RkkvwB7xQfK0s14HHMVRyA6
         ohLEsIpxiayAxiG2+kRk1+obvF/oQg2+nfZxZbHX7rl4OYezphlDOOoEobfBUCeiMbAr
         ABAJrf/safUpsFQvdABuLD/qSEfj4h8c3xhIQnzvvPUCkdgsWZoDYRF0aoo/5SCDrhXc
         o/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779720623; x=1780325423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vztVGbCK6jC8394ALCzZO5oQ+baRPsPPpzoNx2v6wdY=;
        b=hj+SSqkHrVh107YoOCSfXB/VaytwmHM4AU7laxceT/gw3EQFJeMltuO80O1xhIebhn
         a4c3IYmFU9PkvNsOeCF8x7NSSUVmbWceRV2Ryxy93F/hxDDPkk24cfjjpAwy412NGW9f
         /rRhQtpa7yV2G3pE5kdmRsXlI2CiO4/U3GPmJiGrYCm6RuAb48PI+gJre9CMgBZ2cO4D
         RCuRx/PkTRjnXYvS+tuqymi0e6j7Bws3XcwVrkebHfPkPj8qcBONCJlBT1DBNF9PvfOn
         f8OlQ78XamLIlybTVw0xgTC1G7F6RLnll8AZV29kX/l/3U/1+fssMiyETYL3GqmW0imt
         f4eg==
X-Gm-Message-State: AOJu0YyKvjHOex/7F/jJc0n1k9CiJ/Z4p2Tm1Gf+hfgv2mdGtowEezbp
	607jWAJkMor6tlMkdgLiLIEIRkBNZNgKbv5u8twaDeqT+83a0/tOSsB28MLARpjPYSM=
X-Gm-Gg: Acq92OGRDLaFjT9E2fW/juroZ5gQzHL8XxRWmtDLPCogWKfmleAil3Mn2xX6ZNYhZEX
	uHIDDQ+jsdJEzc5LGnGCIXwA4MFr4gmoyKs0moHuDVi1Ky1nt3oZMgx89SS0EVri161wrAtshr8
	Sc4VGGqyQ3wxbqpR2qwhWpgAkSP79yNf5cZ5K8Fk32X8J3csIbTLhpkOZw61C7KdJux61K7dKwK
	gCADMZXebnnj8RDNTVc4gmPYZv2spuQjo2feOigVM0vID7WBbUsIJXY4kj/dn7VIhdPeV4H19KL
	Efh9Wof3Kz9OUnH8OIgXJ9xEMB6OiW/M0sSMgkJZdb9TMcjLR4njkp3ZuWKlUbv5poX2PE9v3TV
	qt9VA93Y0EOc2yfxrmOo8Ot2XNCkmjM8g6uupd4CGjlPE5Uu9zN6OjjO/LdQHq6pkXvHcoIXoT2
	lF6oQPlx6MZLs8LZovCjlFOpsRJ8ozs3ARJkDPadnEYQR2vhIXT4zYm7p2OgHm
X-Received: by 2002:a05:600c:46cb:b0:490:40f1:5330 with SMTP id 5b1f17b1804b1-49042482485mr250141255e9.6.1779720623276;
        Mon, 25 May 2026 07:50:23 -0700 (PDT)
Received: from bazzite.. ([141.195.57.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042cebaaasm88589125e9.36.2026.05.25.07.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:50:21 -0700 (PDT)
From: =?UTF-8?q?Tarjei=20Bitust=C3=B8yl?= <tarjeib@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Tarjei=20Bitust=C3=B8yl?= <tarjeib@gmail.com>
Subject: [PATCH BlueZ v4 0/1] Add configurable default LE PHY policy
Date: Mon, 25 May 2026 16:50:09 +0200
Message-ID: <20260525145010.154170-1-tarjeib@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524221421.258593-1-tarjeib@gmail.com>
References: <20260524221421.258593-1-tarjeib@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This adds an opt-in bluetoothd setting for the adapter's default LE PHY
policy.

v4:
- Replace the hard tabs in the changelog continuation lines with spaces
  to satisfy GitLint.

v3:
- Match the queue header include spelling in main.c with device.h to
  avoid the Sparse redefinition warning seen in CI.

v2:
- Check MGMT_SETTING_PHY_CONFIGURATION before sending PHY
  configuration commands.

Tarjei Bitustøyl (1):
  adapter: Add configurable default LE PHYs

 src/adapter.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/btd.h     |  2 ++
 src/main.c    | 63 +++++++++++++++++++++++++++++++++++++++-
 src/main.conf |  8 ++++++
 4 files changed, 151 insertions(+), 1 deletion(-)

-- 
2.43.0

