Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108589;
	b=5cB0tR+xAhzOclRgOCMC1B/Zn+422+NuRMvCBxBPrfB26/+c3oPqOvgIZ5Ire0Iibaxo
	 LLGAQSHPVJ5kMMOhT/TnmoToR8VivztPXw71/70Mzxxzb/yNA7HAObA46rT5UDruOCq+7
	 AWGqfwfLS7ETpotg2U3k8ZZyvp6choyfVia2BDz9uvgBX0ywCzvcAyg0yzdJas+6VpI1i
	 Xtxmm+qT3UkFPXi+HLEYm5IeEfERcm2qv7Zx2SBtwg5Jf9of5fRmKOPsHNSF6+Bgzvs1o
	 OZ/GPzHh/0i+IZ2WSRC1+puJc6BWcpjr6yZGECDfrbQeU+32MBMA4b+EqBDHHFx/LIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HIWMqrctC/KR5V+2yb9eluzuScmh4AUzrow8jrqvpiw=;
	b=N5Pvjdjv46OtXItdZqXpgSX8Ef6wgxUqjSXs7MuRLcu/0L7k0ZiI502mccyn0bkLjhAE
	 79dUmJRTnwN+RF7HgB7RVBxX7fM3onX8d+DHyVK1zaOkQrWGCdj9MMpQS5CQdpgDEMia3
	 AgLETguWuxy2F7hkQW2s4kAprYzsDRE46EwspQQFGErk4ypiwpn7f01JipxDrWizcb/Cb
	 fNE4V1yVH/UItvTmQ77QYDvaSZdH9gtoxDFW6aeUjZzGyAq3RSb9E6BTGiSgp4+EfSo7g
	 TUf5zYUp9jrbeqntJA0k4w/cDZCdAjTaX6K+svJey+5D7QVFShgQcmCTEYPn8sQZw2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xjvA1L0k;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8059606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8059606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xjvA1L0k
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ec690faf85so878057e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108588; x=1795713388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HIWMqrctC/KR5V+2yb9eluzuScmh4AUzrow8jrqvpiw=;
        b=xjvA1L0kxAhuInFZVbnf8RzyZ6VFUvdDGv95Ua9PQp/MyTXKdVJCHYfb2N5Ct//ILo
         Neho1CP5/DMoHsP0RcUG38VE4NNnlv8MNl6YHFeLwM9ViUWgMAAMPmPaGebTapRzJznP
         OprcRo7UyHjqaIY5eQ7egtyGYOBS9KZEQGEDme2LJixBPvBe/WXwWmcObjHWEctpKCqH
         +yrVBmYoA96SRYFIGbhrFbX99mKh66+im4bodgY6ZNd5ayFDnIkKtAzziPShz+zMHMR/
         OEq7QkDuhMaxUdgsTEffUNkHaSrM4DZNm1auB6guRZumOexp7+wlKDXG+45a5wtxigns
         FJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108588; x=1795713388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HIWMqrctC/KR5V+2yb9eluzuScmh4AUzrow8jrqvpiw=;
        b=G/wwk8X7KuQ3DZvjAPKCNCkuCRy5vx/OLA+FNugL+IyM7nQR/evca4KQqdGLy8CXhc
         R8mz9+Wnpx2oT9IVX7NII9zwAoQRI4MprXgGDZ1B9WkT79/hVydDpl/lTlTTq9ISb+o1
         sTjfuHIZKyWcgyw33hBAgg7jWgcdksaCfWmFx0wXPOPWOChu2+agQ3cVvISlw7DfZXzL
         aVto3EVI6W22i4wtUjw2tadzk236vMJyrI7Haz/wvEAUHgzlgib69yc3rEgDO3djNq5v
         xI7/G5BGe9SPaZ8K8UIHCwtfqsQ6IE6lPV8lvcePTVhqMA4bSi/zJLJMvfXBX/LuU0vv
         kRgw==
X-Gm-Message-State: APuU4Z9qFPqkyODprmH+vq7rgCUmYciFLnbb20W7Nzzjdjbz49BmlMki
	v2YGse6AtcJohGVAOaRh8Hs1IrzrR3S2dLVGjwz+gzGoiyMeXvPpxENhiONY6yttnd0=
X-Gm-Gg: AYBFou0NkP8nJktJebhO3tygPQhU5LEJIU0QloRtnd7jeHU0oQdfyPOS6UYitvBuiEr
	Zx66XQGu9Ffuw4VBTcLox/8gys0Dp9D5U/I6c1svM0RdfmlWgD5LVn4SYM2dahvMknkgf2RayLr
	DEXr5efq0WPjqDCWnAuzTU3GHpFFj69EbA9c1Zh4SwClxxbkPzDT/+nPWIZ134L5vZkaMSkrTNW
	LBjwqw2fMt2tv59k76BEy2my7Hbg5JX6xcsPQuZCBhiMyEg3UzAzEVYdcoqhNzdjCxBU5M+Tn42
	KTcCrE/uRp4VLFpt5XDGlZzcNrzNZZuZ9WJJ3SKenjIqnoyQzt8MXbiiGYaz3Y02JTt+Amom5UQ
	j3jDeWfDDBHykFx9nleMqmXBbX+anZp0uj8mvyRH4XBYW9yt1djvgCr+o594XxqU2n3/r9lwCHh
	JGD/9pvRZukERjcwFjKy3SDjbTkCV3swpsrvYWn3PdN1q6KotgXbigIHNIKbQyKeMFs1pXzr3X+
	oOZAdiXNrtbseZOIvVD+LfgjVz002HDBic5xyM8KsRYdWP53kt8BnDxdg9stXei9W/xtQXJ9dFs
	OkDIn1oEb9fieQL8Z4uOD8R9GE39qlKeMoJafHsfL9Iwttcamo1bDSQMmDPjxEB/QsquN2a/V49
	yYFK/ht4psqqE8Y5PL166CqvLXJK/FTJ99qYWv4YsGjOCkPNfBhCtucxJAp77fIdbBYo446iIPY
	fbFuI=
X-Received: by 2002:a05:6122:e26d:b0:5ea:f399:7820 with SMTP id 71dfb90a1353d-5ee8aefb9e9mr226903e0c.10.1795108587676;
        Thu, 19 Nov 2026 09:16:27 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 00/16] Channel Sounding and RAP fixes
Date: Thu, 19 Nov 2026 12:16:08 -0500
Message-ID: <20261119171625.1014004-1-luiz.dentz@gmail.com>
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

This series fixes the Ranging Profile Requester and Reflector setup
and RAS server issues found while running the RAP and RAS PTS tests
(Channel Sounding with a Reflector, peer-created configurations,
Ranging Data subscriptions, per-connection Ranging Counters), plus a
GATT database CCC state leak and a use-after-free in bluetoothctl.

v3:
- gatt-database: ignore device removal when the adapter has no GATT
  database (non-LE controllers).
- profiles/ranging: end an armed Reflector session when the remote
  procedure stops, so bluetoothctl and the daemon agree on the session.
- profiles/ranging: ignore Remote FAE completions of other links.
- profiles/ranging: also handle Encryption Change v2 and v3 events when
  deferring CS Security Enable.
- profiles/ranging: keep the setup state of a configuration the peer
  created before StartMeasurement() instead of resetting it to INIT.

v2:
- gatt-database: clear the cached state of both bearers of a dual-mode
  device when it is removed.
- shared/rap: keep the Ranging Data Ready and Overwritten counters per
  connection instead of resetting the adapter-wide state on detach.
- profiles/ranging: exclude armed Reflector sessions from the Active
  property.
- profiles/ranging: ignore Remote Supported Capabilities of unmapped
  handles, so one link cannot overwrite another's antenna limits.
- profiles/ranging: enter CS_STATE_INIT before the asynchronous
  capability reads, so a peer-created configuration is not rewound.
- unit/test-rap: add tests for the Requester Ranging Data subscriptions,
  the Real-time timeout and the per-connection counters.

Cheng Jiang (15):
  gatt-database: Drop stale device state for removed bonds
  shared/rap: Reset the readable Ranging Counters per connection
  shared/rap: Subscribe on-demand data with the requested transport
  shared/rap: Subscribe to Ranging Data when a measurement starts
  client/cs: Fix use-after-free in stop_measurement_reply
  shared/hci: Look up the connection handle on the right link
  profiles/ranging: Let the Reflector run the CS setup phase
  profiles/ranging: Let StartMeasurement() pick the Initiator for Both
  profiles/ranging: Take the CS role from Config Complete
  profiles/ranging: Act on a CS configuration created by the peer
  profiles/ranging: Keep a peer-driven setup from being rewound
  profiles/ranging: Defer CS Security Enable until the link is encrypted
  profiles/ranging: Choose the CS antenna configuration from both ends
  profiles/ranging: Do not start a procedure after StopMeasurement()
  shared/rap: Start the Real-time timeout when the procedure starts

Luiz Augusto von Dentz (1):
  unit/test-rap: Add tests for Ranging Data subscription and counters

 client/cs.c                        |  40 ++-
 doc/org.bluez.ChannelSounding1.rst |  25 +-
 lib/bluetooth/hci.h                |   1 +
 profiles/ranging/rap.c             |  39 ++-
 profiles/ranging/rap_hci.c         | 465 +++++++++++++++++++++-----
 src/device.c                       |   3 +
 src/gatt-database.c                |  34 ++
 src/gatt-database.h                |   2 +
 src/shared/hci.c                   |  12 +-
 src/shared/hci.h                   |   2 +-
 src/shared/rap.c                   |  98 ++++--
 src/shared/rap.h                   |   6 +-
 tools/hcitool.c                    |   3 -
 unit/test-rap.c                    | 507 ++++++++++++++++++++++++++---
 14 files changed, 1037 insertions(+), 200 deletions(-)

-- 
2.56.0

