Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189673;
	b=nT6UGnmzfulnwmISbG95c2xUaLcTjzcf/vAfCWqvxj19/0oRzneo68oWtETpAmR/z5PR
	 OZK+clHluDc5yCadcfbIgqTaH/NsF0F/ic7tzW2Syink8YCHTHk5R/P+F4TRmB/Ao/3Vk
	 ooJPQXt+/G1S/4A+d4iFQOWVmu8m1ujO8uUUv2kpEZIzupCWx5yURVIekHqZpENlD68Io
	 YiwcNwhqfCC6NJ980/Ec80mJ1lXZ5jGDkNzDewYJMaFR+ha5B3NAfx7fRAgRQ9Q/7OaR/
	 2HIR9J8izMJ0/Zz1bXkRhtiXMK8Xg9pd6MtzY8tjEJ0ierZfToUu083ZX4GZKJ8b0zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mgVL9ssLGPjBd5tkhUGbKch/V3vph/X4WGlrn7M8xvU=;
	b=qJ0OJf4EVvlf6ArAvfu7if/VOGGFVUj8/+C0cS3tTGY0iyG4s/nNDQ8Z65MhR0DmO/fq
	 G9gifhHXu1ylWPuxsyIqyDJw6bIk1iXwI716+pjiJw5widw/rAKtWXPzrme7JwtbXr3ho
	 5QVW9xIUCnL46JkjyofqbbnZReOOwd3LsHECqK4giiNCaCBl3VSUWivCU7fG2dvW1OKsj
	 QQfiBkXvdUajnVkIohTr/m2PKj5R4DnazELQiz2QrK/6uFkAVJDrofWXDnEDOfQmpAX1F
	 WKkjX+Blyp43LLMEcoi+EK5IefkaLb38Ykrpl4Zugt+AB4eJLnlmpv45kgfjox3Z35w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rn0wcgK4;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCB7606A33E
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 15:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CCB7606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rn0wcgK4
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9906870a9baso566961241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 07:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795189672; x=1795794472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mgVL9ssLGPjBd5tkhUGbKch/V3vph/X4WGlrn7M8xvU=;
        b=rn0wcgK4VmJl+ypyESg5j1UmaY9PDZDg08v4tFwUi0TUOY0Vg1G1Ilp6wr+KlLr6c/
         VwYyE2EXnJmioWBVlwVMKMGnzyOlrFDgBvw+cGnarD9Eqp+VaBJyFiim6hI7Xg4QnyG3
         ENirlcZu4RQbs3yrwrEuNWsXrTLAOBtXge1/6KtEAzIuEwEv8nxAqwd7aZSdsebBeZR0
         EdZCsWeuKtnmDvK8X3pfqC1ajXn3toVxOAdRJAj97REJW7MlLhid97v58QUUow9d+7xc
         bQkNN14E/6FYVAQSMILeCGnACj9sku0nj4oLTeyG4TbfUCIP49+MHzC5nDd7M34R33og
         9O5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795189672; x=1795794472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mgVL9ssLGPjBd5tkhUGbKch/V3vph/X4WGlrn7M8xvU=;
        b=MHRXbudQ+UcKuTkMzI/FhdqD+9pfk0OP9Z69Vif4jLZmgqeuc7v/2hq40F7cQDKsF2
         +YgflcG6kVGAkYSTz6rsGn2vmd/hsamfJxXyhrj5VeIf/5quknOWVFjsU5Jj5z7IUQQE
         JhXEagWgdKXfM2iDfVT7OkJuvHVRWAHy5Dx+VYXimT0NUWEO4tX7KqLf8K1g7TB1CNdQ
         pet28UwFq1Npqj698+7fLvIY+ycw0FSu3BWvS40c1mOc1E6LvP/mtcXAQ8cfFhrZQ1RI
         FGpYjGXSZLETJptngK7lAF9BQwNDok1XL3mFYl5E7aug7yqG6Jix6elLuUaQaUZz6+Bg
         6sDg==
X-Gm-Message-State: APuU4Z+C9wEDzSS0arre4W4+UCJUpLFIh7bNoU1l0jCrGougjB3+7EeM
	AtnMPj/MeqPx2EB3VITroFj5BrWahHR3SdjEFwufEEihOY7AVIDoAyK3Bb/KW4vM
X-Gm-Gg: AZFdTZeI8e81ex/XgqtXZls30yyaW8DSi7DVIOG7S0bgpym5N8ixRZD2bwN3WZRmHFl
	luBDmVV/bilWxfDu56X0TFn/sHPpctQGBm+tQDuOvqcXVi0w+ir7lSdf8+ey1PRkprsm4PGz3V0
	+fBtG2457sTKPvlm7ICR39YpTgAxTT7XyT2qQE4YdIhYg3l4HyAzO2WSzcRRwBsruAMK4A4QcW5
	O2crA74bC0LF9ZHaTNF6M5PCf0V6T9KuRRTjX+iatS8Asptnz8IlQ47/Q+1IAN8CpfUxKQs+s+9
	gxXPXBHZrYOMpfQubyTUxNPS1ow3QQn5bwlfptTTfJBdpxirD7jHBBiDm01qRGJIrpA895bayAr
	up97JcI/3qLfuypt69GnhqcJXIwD0YGKHJjBG4tj3VRXlkHud4WlbFsFdShbfUIR+J3HVKGW28E
	ccCsQlyczuBT7KrIZIXrDs7A+dl91sVAVY0Q4BRRiHcrJOVzPNHhmHkDcxf7oRgEPxZ+fkwQn/v
	N1UwC+YIU49jWMrG5E/C9ojz7q+TvB8JnsRBs2T/bUwN+9i2NQnPyW70O3Dx5NpiEZISv3Mwo8k
	llaTJcmCzjpXtjCPgQcb7KYSvNyZuq0qvDicaEMeUuiBFLJDC5Fy8Q6GuZFkO6kD1Mzi8EQprwj
	TOc/CTQvUZNwfvylN6y5MXQ528C9gzvnVUYzRhFL9oUEBr7XAwM4Ac7c1Kb6Ta/bhgCK5vNGBpm
	2K0cM=
X-Received: by 2002:a05:6102:3ca6:b0:7d2:7266:2c8a with SMTP id ada2fe7eead31-7d73968393fmr1665425137.32.1795189671902;
        Fri, 20 Nov 2026 07:47:51 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7b12eb7sm3358243137.0.2026.11.20.07.47.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:47:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/5] Add tests for security of deferred setup
Date: Fri, 20 Nov 2026 10:47:45 -0500
Message-ID: <20261120154750.1745643-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds tests for listeners using BT_DEFER_SETUP when the security
of the link changes, or is still pending, while a connection waits to be
authorized, along with the emulator helpers they need.

The following tests depend on the kernel series starting with
"[PATCH v3 1/2] Bluetooth: L2CAP: Fix accepting channels with
insufficient security" and fail without it:

L2CAP BR/EDR Server - Security Block Downgrade
L2CAP BR/EDR Server - Defer Encryption Off
L2CAP BR/EDR Server - Defer Early Accept

The remaining tests pass with and without the kernel changes, they
cover paths that had no tests: deferred setup with BR/EDR, LE and
RFCOMM, and a connection being blocked when pairing fails after the
request has been responded as pending.

With the kernel series a channel is refused if encryption completes
below its security level, so L2CAP BR/EDR Client SSP - Success 2, which
requires BT_SECURITY_HIGH, now sets an IO capability that makes pairing
result in an authenticated key.

v2:
 - Add L2CAP BR/EDR Server - Security Block Downgrade and
   btdev_set_link_key_type() which it uses.
 - L2CAP BR/EDR Server - Defer Success no longer expects a response,
   so it only passes once the socket is connected instead of passing
   with the first, pending, response.
 - bthost: A request kept while its response is pending is only called
   with Connection Responses, other requests may use the same
   identifier.
 - Set the IO capability in L2CAP BR/EDR Client SSP - Success 2.

Luiz Augusto von Dentz (5):
  emulator/bthost: Add helpers to test security of deferred setup
  emulator/btdev: Add btdev_set_link_key_type
  l2cap-tester: Add tests for security of deferred setup
  rfcomm-tester: Add tests for deferred setup
  l2cap-tester: Set IO capability in Client SSP - Success 2

 emulator/btdev.c      |  13 +-
 emulator/btdev.h      |   5 +
 emulator/bthost.c     |  86 +++++++++++++
 emulator/bthost.h     |   6 +
 tools/l2cap-tester.c  | 290 ++++++++++++++++++++++++++++++++++++++++++
 tools/rfcomm-tester.c | 146 +++++++++++++++++++++
 6 files changed, 545 insertions(+), 1 deletion(-)

-- 
2.56.0

