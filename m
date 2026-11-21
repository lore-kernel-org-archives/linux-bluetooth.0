Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294733;
	b=1ZU8Xy36dsTyxfhsAOWYe1hRcp0xKOcCzlA/PZRcHiYt/qMz7Gh1uYU0kIvsg18GiAdc
	 8SS7RTohuTy3qyjNNoqs1rZzJ3ZWHlisvlN0tg7nhHUIANFt4l6aepBY3IvP4mGlSbx41
	 qpNqmdFcBGgEfCvwcgObUhtopoVrPOJCu7aXCjuIuvQEDHQEGF0UN7EeNVgGRTdutFehW
	 LCmu7ohMMVgLevB7EwdEE3mKwjnUt89BP3XIX6eWMZR1Tcvl+85sdjMZR9e+PO4873j5Y
	 Ygyp50/rSHXDdvbJoNW3FJPCVpPhZakkiIMPaowS8sfSVOQKeMJYWkC0KfXdqeNBFbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BJMjy+qkiG25TJpPlqX22BQ8xRox52II9xsIHkh5OWE=;
	b=G6imfNixJyVDV9sarmtt0xbNIxwmCFtchYJYpXAGIigmLvUvxlwogFZTWFl8NsXFF86x
	 5rTHW1BQ2SvJHYapC/DZDu+PZjc4IwDAExoRAtM45msZ/5DdUB7v5IGJ9dNWx4zDZez9/
	 dAcmLX7OAIdzJk3BD+WLLWg2jExAqipWhe1fvcB3of29ZBZUWaVgHN5EGxJh1a6PwNO9k
	 NxplIJ2Z7exWVYkqWTirdAV79wZN5Gxv7B1vs7+1lhvRpWxAXfBGOW1sor9Xe+OUuMuY3
	 1NZBjKPyC0bwgJm37QE0fc7/i/IuCzBqDKhDsgnoFJ7i29yXXHNLCCBWixmEY2MntVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=03RaDG4v;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9C606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 20:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4F9C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=03RaDG4v
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so1261844a91.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 12:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795294732; x=1795899532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BJMjy+qkiG25TJpPlqX22BQ8xRox52II9xsIHkh5OWE=;
        b=03RaDG4vxoiGi7WNl/7oxckwHp1mPzQP6kCN/ZrhLpVX0mKtI5ueR6gFP9uIGFzNP0
         7Qw1xwb0bvoMw+zxfiGIMWo+iL1BGcUevgG6ZKpb+RT/yxQ5kOYCxOkeFsLyMj3pj76t
         UPq056YKjqEvJpZUkvR+DJ6SUjG+0M9uk6p1bhWfmbzQ1Y7FyQhxaieJ8yfBqTI839er
         9x4wik+UxA0tX3yP0qXCKWaGAP/HoNDyrRywizgIhC7bL8Lwu8FjXu7GOpMvD4zkO23o
         lK1etoBR8Gjvjl09beFWd0BiAF1HAJCAooD1vaS6pIqM4neIRWkPjAW01z3Y+BLthUE3
         g4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795294732; x=1795899532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BJMjy+qkiG25TJpPlqX22BQ8xRox52II9xsIHkh5OWE=;
        b=OW2dF4CDVXE6c91Rp8/Qc4YzQ5690/V8PxUm0a7IhT5sSrI+y3BmfoXgM8wxO+F5ZD
         RhxqRnKG395epd6fU36ImUbA6DPamC/myVrBTPQdRJ1RMSXnpBnTnyV637q5od4DIyON
         yHOjOn6QX7aHKCnuH6fQ4W51jW5Btb7RX8OpR8SvEKD6Q2SZ9yn1UVVKQ0Frnpg5R7SV
         u2BZfmjnfTKj1grqY+WBQhxp3Qq/aYVOd1aRQTIPD8WY5sd8ZjtMbZ2s1TM+b+oURf3q
         nwXMp3+gZhV7tjxm1p4T0fXN5Y6KFoYn70+A5sebOX1oi0l5pzWQG2/WCLSYuepz3QO8
         +17g==
X-Gm-Message-State: APuU4Z/NwgWlDkUrwSbl09AGkcHHZ2q6I6P/poRI1K2pz64th0GzPIl+
	hEc5slG19+8SkEkQwMonSzbYAzMR6AfSlu9Bj0rZFHlfBt4HxOBR/s6L4Vc3/Q==
X-Gm-Gg: AZFdTZcNDOHJM9HHG6O3RHKwcP/Kg1E15tajJ4+CAa2I+IpL+EJJKJhmT19rCkNsmvj
	3rWR4nVCpXvNYBmXv/REbu1HETWrugaNh9lozaeQjxmkAyG6RhqFP7GLTqlnusZQyY5ijP4XThY
	ffV4efsT3fJo85wJaK/J1Qu5CwqXMssTQKfr4UmaSCZmm/zS1OpqqKkNDdEeYS6T+xeOsFaIls2
	zcAcVUoFjRjjVVKhRT2xIfZJKdbjOcpnLCs1oiEUozYaT1Mh8oT1qPc12yaZh/NJFxXgyzCDFtz
	sOn18N2mXltmbmZ3pzfjYs217Wq8h3zJG1fsnbeRNlQPjHWg7hnCYgYJ2+X4cCQKpe2Js3kNTwa
	gPLO2wN4bPqPtw02PpOLMUg3+/9Mc63y1pw14P3qgTyNM/x3I49KLOwqNnvPoaK0v9at+elsV1s
	Y1aIPupv5UwQHCSMXlchW0goz7CVwE65ZpfTZ4tn+eVDjdNiqnZee/FvH22yd9YRuVadT37l4/q
	kKEyULoNcVfYbic+YX7DeE8oivBw9NCOTCFrsEIsjf1rRDvFR+zqESRfWHNjjmlRANpdsmsBNCf
	YEYjLls7fAHLlUlbwZhq+sbqn6JGY5lM7hgHomB9LHufgCr2ITY=
X-Received: by 2002:a17:90b:3d92:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3b41c9b2de6mr6166253a91.64.1795294732173;
        Sat, 21 Nov 2026 12:58:52 -0800 (PST)
Received: from fedora.tail791dd8.ts.net ([2601:1c0:4300:57a:5830:187:53e3:add2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b792474sm2751587a91.3.2026.11.21.12.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:58:51 -0800 (PST)
From: Dylan MacKenzie <ecstaticmorse@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dylan MacKenzie <ecstaticmorse@gmail.com>
Subject: [PATCH BlueZ 0/2] input: Do not re-page HID devices that disconnected on purpose
Date: Sat, 21 Nov 2026 12:58:33 -0800
Message-ID: <20261121205835.381239-1-ecstaticmorse@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The input plugin re-pages a HID device after its connection is closed
even when the link was terminated on purpose, which takes devices that
can be bonded to several hosts, e.g. earbuds, away from the host they
just switched to. Details are in patch 2.

Patch 1 keeps the reason of the last disconnection in the per-bearer
state of the device, patch 2 uses it to skip the reconnection when the
link was terminated by the remote device or by the local host. Link
loss keeps being handled as before.

One behaviour change to be aware of: the kernel reports Remote Device
Terminated Connection due to Power Off (0x15) as
MGMT_DEV_DISCONN_REMOTE as well, so a device with ReconnectMode "host"
that announces it is powering off is no longer paged if it comes back
within 3 minutes.

Tested with Pixel Buds Pro 2 (ReconnectMode "any") on top of 5.87.

Dylan MacKenzie (2):
  device: Add btd_device_get_disconnect_reason
  input/device: Only auto-reconnect on link loss

 profiles/input/device.c | 18 ++++++++++++++++++
 src/device.c            |  7 +++++++
 src/device.h            |  1 +
 3 files changed, 26 insertions(+)

-- 
2.56.0

