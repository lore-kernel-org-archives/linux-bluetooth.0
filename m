Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010729;
	b=KMvEG3URjmFyZ/lA0i99rIhJsyjK2Iog0Sh/STaYJe4W9CBI97YNIbMszL9zqQBZlA+/
	 589ak5NdhROIXvI6hfAUdDTPaLIjz/Dp2OWMMnHd14C4EbV9khfVsNFyo2U+uG7JeOfdQ
	 lkx4mlGRwHcucz22SfB3lPIVynV6f7fa0Peej7CTcXKYSVo/ENgpGBXZ8+WXoShuEZJK4
	 AGs+VD28F+ZmrjzLiY++ifPsw76P2fjgMl0NTY9bBJ3Bi/EryXD+xuBwZYd6UTx7bC5ss
	 wNWnutUNSfN5mLU31gLXwCl/vvfiYID8rDx2D9aCZDmMFOOgAAjhYndVYj8Br0GRLyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
	b=V0YBZQaLFW88VhCokJprxV2eOnPGfXTA86kbEbYeFg1s+OYd30XVb8vDLUEgENL9Klzf
	 dCAW+oHH1U7w8cdYTxfTQngRGOdjB1fLU9p5dQb3c/DYg5fPXqT/061v3bUv+hiV7zPKV
	 ALekx8T3tqHMcspV164jz1xEojd9YyFfcvT79D4jSpmPiQPnytuMP0pR6NDQDdUTK/A9O
	 HOua1kTrwp42AvV7QJHJyWVheEri3IK+wuDW+NE/ZstoeHcQeQigczJwsLKpUzJ3jePBd
	 vHQf7yVHJSZvQHClamOkbkFcVU/U3e/NBMXtV+ERoj2QB4Y+wgpm40OjuicYCqzw41g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AofXDO/4";
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757960A380A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4757960A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AofXDO/4
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7d2ca055399so278574137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010728; x=1795615528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
        b=AofXDO/4rWPjGYZNwNksasrFmvThu94c/95KpHLLp6cK3/RL3Ww4MjQ7euO5iuFKTz
         MOv+Tk/K6D71gDIhv8OyYtZotpVcu2jy0HvPvyqW7Qe2exwbUI6Bs5Z+p3/DIzdS+42M
         +TPE+PZVfWmZcjreLG3JDhqfztbBou6v7F0N7YhvQ2fr4paX/kLIrYaJ21dU9cETp+3w
         KuGBuvfRfOZlDAXELGTpAuJeEfB848U9shpRTvTCQrG9Kc9/NwtGsAgfs3s9NiW7vvxE
         nI57ymut6JOucwqMGYRReKhPRcwGTKtR/JM6dkJRzOm+8YGPZoI2796bqcNoz7uyjCsF
         aNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010728; x=1795615528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
        b=Mhawx2aO2O4utWvnXT2/rdZg9uct5unxYOkOSfsMV4ysX3kwS0d3u16OkIfya2M5Pd
         4+L5mkksJOVPBOrwpcOJrK+cM8SYyH2nwt3uBfTzZ2bBVLiu+a74ZEoU8m8PRvp6GoET
         DMkmJG/CpHyh051mE7LtktdBQ5X92ESgNrxJipBRvm34QHl9XK8XLhJPV2dGKLzIIBQF
         38ugWHhtPbLON0S2ZGANLIkLG2KCKrqz9UounfalWHWgWFSanqaMHfCb2+6+15I1Y2qq
         ORS+Ro7FK64/psqz9BzjtfoGzzslwjuvmr6VK+cXnHQlOXjXdicdLnrfrPU/D16gVQHV
         7t8Q==
X-Gm-Message-State: APuU4Z+MoblbqTOMFen1enIZzW7q8E69FCOOe29XVFv9rF4aU+35Tkck
	TNHhj7FdGCDLU76VcNpf9SZfpb7hHkhQbZ5DHECMxhQrptQcPl0CMs2zPckI9nCe
X-Gm-Gg: AYBFou2kyOESqC9vmCKdM/04TrL32Xs61yhPgDCL00qdUbIOVRLkbZTsZCxn2CFDVJ+
	kZTGRB7c6WFWS3W+z9SgDDg3u1pYL1hwNgaIB2uQxAmygXzBHZcJZFyAvcASla9pBk/5OKHOJ5k
	8CgCnTHktosyaabEOqXhpVrsC0sSwM7XB1GzKXHEDUHDxd6br7zJk2DzLIMEHEDOMpMG/uaN6gS
	qIYhWQhEJKxtEQtD1Ov3wbD1dZ+DFS20KwWnjsgbiraWxfQni8N4isTqmJ01h3fsb1b+0+nDFAs
	pQD7ECFVwbBedYCGt7z/Cge314J3E+yZ7peD/WQN4SKMBStANUj/TzN/rWidvR98gZd1m0jaYFL
	Mf62Liqo0TdRZ8zsr/PQm5tgfIV3GHvRHU2M6Z4gkvKcIxz7gTI6OnFE5ucw59OEJMqeji596bZ
	+Bzm/v8L5NvO3NXjAJYyLCDQO56Y268Pt2iGESrgBd3qHKxCsAzHXMUPwSgF3i2kM/WwUEBV1nL
	6qlZ7Mgk6O5CpRUJd8GJJDE7BCA7AuMJYM9hWJ56wR+dNLdPSC9uXfQRhSPjM+wi2mnar29Brw7
	6e8yvyiVrkNfhwyI+ovd8jemj9RlnPos1+gkacNd0WdNozcDF+mGXKy4wcyULpvcu91I5XDCEwi
	CYuvAg6oABzoSNmLsKlJYdaGyV583mn2RAKlmks+6+lmZktxiM9GMIqfLhq6i8bWC
X-Received: by 2002:a05:6102:6056:b0:7cc:c7aa:106 with SMTP id ada2fe7eead31-7d6ba41bff8mr686221137.18.1795010728009;
        Wed, 18 Nov 2026 06:05:28 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 09/17] Bluetooth: mgmt: Reject zero multi advertising rotation duration
Date: Wed, 18 Nov 2026 09:05:10 -0500
Message-ID: <20261118140518.59878-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118140518.59878-1-luiz.dentz@gmail.com>
References: <20261118140518.59878-1-luiz.dentz@gmail.com>
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

A zero def_multi_adv_rotation_duration makes
hci_schedule_adv_instance_sync() requeue itself with no delay, spinning
the request workqueue. Reject it in Set Default System Configuration.

Reported-by: sashiko.dev (linux-24ecb695-0c5c-408a-a016-a980c3115e95)
Fixes: 17896406ff35 ("Bluetooth: implement read/set default system parameters mgmt")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt_config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index 7a2cf893a515..51da6a7ac0de 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -281,6 +281,12 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * (32 bits), the one of the GFSK PHYs.
 		 */
 		switch (type) {
+		case 0x000c:
+			/* A zero rotation duration would make the advertising
+			 * instance scheduler requeue itself with no delay.
+			 */
+			invalid = !TLV_GET_LE16(buffer);
+			break;
 		case 0x0021:
 			invalid = TLV_GET_U8(buffer) != 0x01 &&
 				  TLV_GET_U8(buffer) != 0x02;
-- 
2.56.0

