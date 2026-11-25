Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641135;
	b=fgIVk5cKQ2rVBZcrrJyFb9hTyG4PGc5dsIxMcu//rH4JM13NgXH/Yz5tUaSKkUDk7273
	 n3vJf9Cj1J6KJuBdP4Eu6Y9JIgh0cawYc+FgZmEJK7GbGQdVLAJqWdOKtLPs41eF+h8zC
	 tJsBuMcZ/xNnLzRhhYQGq/d+AOI9KbhwR+dZPV1Zu1WhdS3C6QBG3GBmg7WdwQLAVpVNf
	 TRA8Lc8+AtpjlvcZmxzmi3MpBtlZpJR2EKK37wnVYIzb0ZzRF4jLiB+ZwHPxOWmRN3/Q1
	 bUE64CFOdywLweHt+GPJi58QgP5amTfH3ToBYJxhWyCSle+CC9ZixZEksWfEjvMOXJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GDskPnUmu4oEs7fxWAxKHCtJtG44pW7Hj8zvStLcljw=;
	b=2cSYnlQ4q3FJw06HiTQjS366W05S4lc6KHPChErWaAnJiaHn32gcuqIpGgcJmFlsc0gS
	 aezqYxuQNyQZHp6hm0O/GUws4BbS4T55sk5KSM/41WgliF6LbRVUMgELvwqmyYxQ725Y5
	 i/n4Zg4JE+GFkr2cdBBJ65cM5CUfpROrE6DLyPLzF6Cn2aZ5D8/M65eq/pi5k//tNT+qT
	 ipHeJOkXpi9h4t4CRWlbD6heLy4m5BiPHXzotVB6GsyMyzV2iBpexDm1jN4/NtzYiQ5PR
	 8vmxRQp8ks9Rw5nfp2hyNO+a4YKizycCEdxuASOoJyCqGJt5o1AJ/cRay9SYgn1Q9tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ww2RJyWF;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C80E606A33E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C80E606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ww2RJyWF
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9906034086cso1738152241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641134; x=1796245934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GDskPnUmu4oEs7fxWAxKHCtJtG44pW7Hj8zvStLcljw=;
        b=Ww2RJyWFPOK/eYmGJv5i4FKIoTr98kIvrfHFv2GSTecsv0q0m6Gq9+2LORl27IKLqz
         XZhhlHwxIq4uh3TVsVsDnN4EeU1qH3tbmiARiGf/0l1BjKOHvJEdTFDoK6FyC7T5MPO8
         rBilurzzqIHjcQF0Ifd9/lGYkUbk+m5NGsNojiZm3882zTiavGx0mVquivEMl8zlhdsZ
         6CEgdWiGpk1H3qkgYTwEbtoQVh5UY5jbHuC+nMpuPjskLP9gbrxC8DrUqdp83I3MF4CC
         1aKYPAtPM5O4b5DOK9zCL7xkWp6fLFiJpszNs2efs8C0FYAKpQfEH24aF2eDVDm8+BK/
         00Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641134; x=1796245934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GDskPnUmu4oEs7fxWAxKHCtJtG44pW7Hj8zvStLcljw=;
        b=ag7FwVgzShN9x42WM0KY9IP5eYGWw/lmTFj48w9Qo8UpUvZYEe9x+5pxdCl1zZTE4R
         X0GFeY814h+5WelBiUuAX043ZLpEWDqhGvfw0AqG/9jvCHneT9KeEm2cE9fFEbAGMHXf
         IAhZClVluavsXL0yC14To42lDOiM1BqIehO4sFepsJMBmQSk2s1Ic5xz2+AB2WXEik7H
         oqojNd72gAi3U/p6YD5Q9tn8Bat4WydttVggip4dOxLrjLYoXPePyoMu170CrdkpURAq
         XHttt3E9yJ0X55hsY0ceB/v04ile1ZVscdDN8xcVjLKFJ9j8mvuJwD8kvKhF5anu0QK9
         jnQQ==
X-Gm-Message-State: APuU4Z9GL+1I+WqoKIc0p2Xg1bW9loSLw9CIGltFiNK2Ut5rUWOe5uQk
	phqa/zAQOX5DxAr6ZPh0vgTgWg7tA6UR88Mc7J9c+0ipYOVHnOta3FJfQuzVAA==
X-Gm-Gg: AZFdTZcDZVQiW3QOCmdi9Ty9L3bRDVX1Z5HqBmC0F0xqNYfIeFcg2ZRCJr2Dp9u1h6r
	pl0sIOmK7FM6EUDp1mm/U8hgizJhy8Ovh+69x5L2uP2GxiVNrJrVZv2peHeOypWJ8ep8uAqPNtF
	KDFJ+VTQ+IGXL3qQ8+6TUj35xk/+mLmeL0CVyXlcfsvnZmmXQfoD2NAUHZW9ZUjHmX48YBsG6o+
	ikNJx1KZ0cbP72BSX4ziSoJJQzrbRfcVjlRRCHx/72x3TWnbBIx2mhPsS/O8o4vwRn2g/pLsNur
	HT5SWSbj4vXsYMoszrToIiXVyk/nxRo+/9ZoRiI7ZcuJPBBgnQLZ8ff45KZoevb21HfaKH5gDip
	u/QpsrZHY4q5sPputBUsBmhbsOAvJ63jG24jmXxI9J+jb/hGQb6eoYfwlcsbiefNUbLGlOVwbdY
	Hu9yiuZfmC5tXGXou1Xa503DKhy0usoSVXPHmgbRcEn/U7nlEMTrzJrTToB4DSBE0/1H34/bwhl
	lhB/sBRYU4neZt+3UFMaDyCDfgSu8zaD2heYe10hSisxWBe4+zbNjTvPu1C8eDXtHIhx+5lVkji
	TzILQn5uBea6LmcBqSzHuS5XavLTrLU9322rtw3cTWGtyR75OZkp1lnWnYYZkCZw7xrw+0/jzga
	lTtCphI1Ru7NCjTwPhnsIH4AIZGqlkUeN0/z9lvQW1IzScycD+Gk1wpDyOvGP+ezDA3z9BU40ib
	pkNSY=
X-Received: by 2002:a05:6122:3b84:b0:5ea:e324:7c0c with SMTP id 71dfb90a1353d-5ee8af8d6fdmr10679761e0c.22.1795641134181;
        Wed, 25 Nov 2026 13:12:14 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b556db7sm18316369e0c.4.2026.11.25.13.12.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:12:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 2/4] Bluetooth: L2CAP: Fix leaking the socket of refused Enhanced Credit channels
Date: Wed, 25 Nov 2026 16:12:08 -0500
Message-ID: <20261125211210.1955598-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125211210.1955598-1-luiz.dentz@gmail.com>
References: <20261125211210.1955598-1-luiz.dentz@gmail.com>
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

When a deferred Enhanced Credit Based channel is refused, e.g. because
userspace closed it, while other channels of the same request are still
waiting to be authorized, the channel is kept in BT_DISCONN until the
response is sent so it can be included in it.

l2cap_sock_release() then calls l2cap_sock_kill(), but that does
nothing for a socket that is not flagged SOCK_ZAPPED yet, which only
chan->ops->teardown() does, and when the channel is deleted later by
the response nobody kills the socket anymore, leaking it along with the
references it holds.

Fix this by calling chan->ops->teardown() when the channel is refused
and not deleted right away, so its socket can be killed by its owner
once it is closed. Deleting the channel afterwards has nothing left to
do for its socket.

Fixes: 9aa9d9473f15 ("Bluetooth: L2CAP: Fix responding with wrong PDU type")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a15ffcdd1330..d39d8b8c47be 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -841,6 +841,14 @@ static void l2cap_chan_ecred_connect_reject(struct l2cap_chan *chan)
 	l2cap_state_change(chan, BT_DISCONN);
 
 	__l2cap_ecred_conn_rsp_defer(chan);
+
+	/* The response is only sent once the other channels of the request are
+	 * authorized or refused, so the channel is kept until then to be
+	 * included in it, but its socket has to be released now so it can be
+	 * freed when its owner closes it.
+	 */
+	if (!test_bit(FLAG_DEL, &chan->flags))
+		chan->ops->teardown(chan, ECONNREFUSED);
 }
 
 static void l2cap_chan_connect_reject(struct l2cap_chan *chan)
-- 
2.56.0

