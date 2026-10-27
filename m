Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122972;
	b=vApHooVVk7gbL3GK7oNoAvMs9Ia0nJHcnglQ+fpqujae6+jDY2YZYuQSOVS1CioUGXaQ
	 ewwjh8kDntPXP1cMjQeifanGmz9/pNwOePm5TovMLvM/iMLkGnP87TdAm/JVYXhXlrR4J
	 qxlW+v791Z+rPCKZ/C/+zuJ/wMHfFl0cSRcWA1PLMrRadJRwiXYY2u3I2N6dRn5q1DleZ
	 IYw4Xr2rZzih2pz97jtcqZyssrpzMBvQ0Sub3DWeXzBnG3cu7688FFpi8InJ8ZgN7WuL8
	 zK0npVH2mPrWnoYiJlXIsGU7yT7Erbr3Gr8Pl1KTaO3WdTloUteqGcYxX041WCuCEnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OMZXZFp+FLJnbZnmbY6rNaZptw3R4qiOb4FopHaArwc=;
	b=t/xRrpPm/QNLYWS/+fH868iExBrJHKakfF+qUjNYuEzjr7brTsbLQRcjMqpZLRt2jVz6
	 beaSUETLqT6HnxlKiset+sPlm3JL8OPgEmLuNCw4zwyaR4KEVZTXzJ/eU4gxq8aegmi32
	 PknBGAY2yNN7mikKg5Ycl0AlgUUmY8lAd6UBnMrLaRNwU4lPccBhsdlGOwJkU+sn7vbEv
	 7g997HaY9xlaT3Mn5KLwdXsKSO6FRW1EQQOR/eNU+jDtI/b8HWgXplRHRu4s3gaoM41ZE
	 xUp9R9SQ5rlkn2R+Av6P54c5zjNhOQozEGTgZlhx8ZI1Z/HqCgsgLjvmXxaE7RqR77Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=ZDikwBEz;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74625606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 17:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74625606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=ZDikwBEz
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a1947498bso284594eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 10:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793122971; x=1793727771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMZXZFp+FLJnbZnmbY6rNaZptw3R4qiOb4FopHaArwc=;
        b=ZDikwBEzdRacMqGaEWZ5v3aRYGqyAcqCeTB/xKSmKmz7M7MXLvYH3OfmOXQfFciY0B
         GW/e4Kr0zH4LZIZSVSg5yOws0eEVv9UsIfcGnDdp4ogGhyytGl35JohQHNnp4aSxOLbY
         w0T/0xdaNB1P9dcJGkzFwHJhr6OgpJ72YO/CmA24ckROx2+3xNb4TYKHZu5NNKTCcnRI
         LAgmzEaK+Yq2PnuEjUHSShdjBBB2APhztFGjL7J/kxLYnWeOinX6XP7U+T6UX4XYgbss
         8YNDTCvTqguD2JZL18a0M7zfyk3QfCPnEAsTIty6wjG8s4vmzcIh7iBaKO0wR0pDB82N
         0Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122971; x=1793727771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OMZXZFp+FLJnbZnmbY6rNaZptw3R4qiOb4FopHaArwc=;
        b=ma6QwguyH38EY5UIDWVnYQomQNZ/xDYiKU1JIVpsnYDP7Pec9BBiG6C3fg/W2yqv6Y
         b97jLRvAFcyI2fc7+JUyHdWaDeAvB7VisLjd6uUt/k5sc0wXJeGgksLeDcdgVT69P5mw
         wz4kExszn7c26qDhsG337uybq80/ZDP7bRrEHvZZE8Wx23f0xBBhbf+J0IYOtV1MboSU
         Ix7aMm2kJy8KYk6NgMaufkpEJvic+u7mi/B+flufKM1f0YLKu6QTPThurDz5l6sjyTSM
         KttAfWQpIQojdAYZeADYH+Zo3UaLAotk9fvw5WGhfVKT7WVL2mn3o7hApAEZE8GFOkVx
         gW4g==
X-Gm-Message-State: AFq9FYK0qEBb4l0hMHEtWz8UwDz/fng0kk1jFsrJqXJRK1B18vx6tMGM
	OYyujdYL0+uKKuE4tUitBRE2cAI/YlBI30aIYjP3ZAurPsJIl3g5UacemD803emzSZMUk3m8wsL
	5fdmeTsK+sQ==
X-Gm-Gg: AYBFou0QaPWk0M5E14+26ZALpo44N9OcgoI8Y7/rNvToeLklfwGUgIhAbrP4sjLO75g
	/TZhgncu3ei9ujWJn03x5Dj0sAvTGzge53NIxG4VDm2HTe31N2ArnH3dcnG/Fc5OWCjyMD3NV3t
	LSFkgeZBx35Voirdkg5zk9aYzVTT0gqvnHvYJVfcIygIXgvOO5LYMjDX5kabPucAW1dzz1M4o1n
	vCHOvNZT6puo64azE8tWCYvNW/mGGR0sOh88cNON9oGGpFfENkUcYz8yULHqdZ+mgBU/rxwy88k
	zwok8xR7cBHUKufTAebW7MXxm7BYu6mdKo/l73m5IkJI+m05gnF79Tie3T4z2qebAIpYlQiB/mP
	TRYqaM0LCKtYqZE0mX1eFwE+FKeNFTC8Tg92HL9V0o5hwxlCP3SA4ZLgytRuVvTpRnuJFptInn/
	dU67Mgptdzd2tYHrH7951jwtCWvKS2cfmmzNlvMRL0kynCMS144BWceOYNubVVzMxudNOXWgkzh
	B0sJjhzThZy77Iap8fXR/hAJXAS24K6MveH2VV5owvV4yuZUEzOvFztC97ldsHiQv+VTgksGOPL
	qQW1aCMP0EX6MqUCj6A6lltCNYJ7uEz2DcEewJ5PQBwpX6gNonm3qTB45gni9axQ1GFvYzZgG5c
	8GwQhXHUhyuntsAuFSTd1Pg==
X-Received: by 2002:a05:7300:22c1:b0:351:52ec:60ee with SMTP id 5a478bee46e88-36a2041d625mr196750eec.28.1793122971405;
        Tue, 27 Oct 2026 10:42:51 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daa3a8sm43627973eec.16.2026.10.27.10.42.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 10:42:50 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: Re: [PATCH] adapter: Fix Discovering staying true after a rejected stop
Date: Tue, 27 Oct 2026 10:42:45 -0700
Message-ID: <20261027174245.90680-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027160852.54689-1-kevin@simpleble.org>
References: <20261027160852.54689-1-kevin@simpleble.org>
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

Hi Luiz,

Please ignore this one. It went out by mistake, without the BlueZ
prefix, before the series it belongs to. The same patch is 1/2 of:

https://lore.kernel.org/linux-bluetooth/20261027171923.82919-1-kevin@simpleble.org/

Kevin
