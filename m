Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795366300;
	b=hWPZFYDIPQZI2c3h9UFc639bZ+nAXS5TLE2XfnAoJNUtzyNCqpXaoVyj5p5QelQqXci9
	 My9/8WyHCPLHChHJqScwBpgBnOrFj0wXBPf0yY8pY2+9PGyFMpxt4bkTOwmxpT9vwb0fZ
	 ZFWmkacDGXhqOJttoHq5hXKYyem7DNkmWCV12k/tf4aAyhKQMz4Qk0BPAgcgd8bRXCuFF
	 ePKZsR/3ss5R58YTF0hps1DqnmiweKZyd+zK8AlJT1F1LgHmy/MPgtkiM0GR5RPRta9SV
	 o4v6/sfzpumxoRgE8sNnxyA3T/YRS6I1he6chYdLBUsewZf7eWUO/EDFj+tLOcc4w4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795366300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JhjjqIMQr865BkPmZwP0QzJcTeMGaFNRQc2pL8EXe1s=;
	b=J0UM5OAYipdAqu4twjqeoCXOY267MQN7mwaD+q3d2sYjfI+LWGCq1J1pdhn9YJzOgWae
	 GWkSEmDxUET2HDDB/pst4LEzqmHcp1/1BSxJLLNvhUg9gr4GqRcgZYjDt9GT0RA1T+oiy
	 kSAFHMNVCoO5Pjq9uVyl6XHBX8B47hQPuCkFah4nwLRbfiR0QoCv5asuqiREgKVm7bNjn
	 tLuf/LfwyVuy/b4GMkOIDM4ZvsBu9NMLkteYNa5l7u9t5QQhW6cCS1V9Y1ALLGcrJ+HmN
	 PXAvjAwR0JbjPXg+iOpqIUTz/2lICXyjFaAsAZHzoNfE2cqjgK1hv/3klnuMjWqGbTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IahtZRV3;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F16606A6A9
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 16:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F16606A6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IahtZRV3
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b335eeb340so20676907b3.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795366294; x=1795971094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhjjqIMQr865BkPmZwP0QzJcTeMGaFNRQc2pL8EXe1s=;
        b=IahtZRV33PqJpuVZt0B6+SNbzh040ajlspyzCn6wQ9BvfNJoScC2Vn4Vn9AQXVsDLO
         s83NPg9YGQBLZO2VBbFJyh5boDqhdRZRwKhl72KZbaW6FnHcScN/RdrdCe8J2k/TSFZM
         1TK3icec0TcURw4ZuKYQSmIPnSKX9W/BFqwWGqyTf42+7nNJ8orK0rtotBGcIWjBED+a
         c9lqmhD+FJlsnNqQswgw4+e5OztqxJrfh+PRWRbVFj4m3zIQ/pRgOycoMCxhFR6B5/15
         Y9WuzIrfeqsK5rfRILtz8hugUhU3gz0a67oCML5LfNIW4d7uFlmRhrpB7Q1QzsPpAhU1
         motQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795366294; x=1795971094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhjjqIMQr865BkPmZwP0QzJcTeMGaFNRQc2pL8EXe1s=;
        b=LRebJhCccRNyv5AxRCvUznprB/CgdsYdUijrw69llgCjD7erBHQFYRUr41eSZGO9fc
         4YoPtkl74aTdIX6PHdEgv8QA3j0Vjj08D4R5dKnCc9M0j2aE+rAbopeWsqU42P8nuORz
         2WPLeL20mzJV2DgzotGDeCTCWYyZoDiUppxtUwNgExd5R/pX295wZUb5ROzW2h9LyS6c
         XBAzHwr9+uNPeuwvRbfTqF3EjuscrRTxp7FStsOhN/SFAvd0KT5D1B+QFj0BRvT+yeGI
         kXzkXeq2VvFj+Nu51i/KyUhxIlp3BOv+i3/3JyATZPlA3rhH5Md3T7Xcn5PVyFnTK7gD
         /jVA==
X-Forwarded-Encrypted: i=1; AL+hErGpixPXNZ3o4zzYxpkSLtD4GFxuzIgNMUAx0BHWIkdwzgyvFxlaQ77hvFy1peKbjMe5ZU0PcUNDPVDchccPaQc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IyFfyfgTZZ5KxeUes8ZcHCm5g+6X4/lY1Tp04XcUEYp0lLWyS
	fJ3Ym0xH/Mo+UvNKMWHKu73oNMLJOk2yL033ZZpKcOMUN5UW10oWUWlt
X-Gm-Gg: AZFdTZe/MXCA8gU6nlnernFV5o2i1l+U6o3p9F0iWixGSy4+lqKflKMQ2wCkjWV9axD
	/GLG6XDZj/C6wi4VqQvsEcISNhGP/sxvxMsq1fPs0bQ2ytoEw+MJMAy569tEqRKJg3+hWFUgfxY
	1elQrmrALj3gLmxNWYI3T4FcPIV0657eQ6s6OSmYRs8Fs4QHSuP/l2dcKftcwuo4ALIWF3WihSE
	JKDDvRG8irqEfXa9/Krn49XmF/bqVIhGnPydDvXENgRBmozzCFJWuobZ1VDGaTFKNRrfHiAbjNx
	gpjiOnMnr/CB4BFSHoTtt+XlbSCVgApACEK7V6XPCm0M/qO8lD25HhklhBp73X+tk26LqkT+F/1
	vgW9IzuKdibkUT/vNphbxnK+ZrM0qqEkkXwUzxqvmyD+Fba1Fo4cWCUPQJf/tKzhQBR2HOF/qEj
	79zufE25+xNx94XhlQrkgY5JjrTuTR4Q1zanpWWGREnIGGK97W7oH3IIwOcgi8hSO6+qXiW0Wu5
	HsU9+DJce/azt45j60WOouJMYwBS6T26rsCJF+kFfraAHIEHhLCAIpntI8lon1I8drNcIcBYAVN
	Vplrne5tOOLO2SdVRbowblaq1qvC3EvB8QRfP+bLEHddH7UHo3HoIq8bQ+4GA0QCS1qOFrLdbWR
	EdD7+U56Q4U2slq7gqJE0AfqGH3O3/UyeHPbnKYRGOxCErIe8XPWf0jSNzJGmLS6VTJkcIYHQX/
	4hmKvS7I/7Kz81dINgVxpD7Az2W93cffEjbpT4c360Uur24LGpPB4hTSHxrNrxcdJsoHbBpA==
X-Received: by 2002:a05:690c:2a83:b0:8b3:5a91:61ce with SMTP id 00721157ae682-8b52031b979mr33704127b3.13.1795366294291;
        Sun, 22 Nov 2026 08:51:34 -0800 (PST)
Received: from localhost.localdomain (104-12-105-135.lightspeed.miamfl.sbcglobal.net. [104.12.105.135])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33e01e1sm4360057d50.23.2026.11.22.08.51.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 08:51:33 -0800 (PST)
From: Jason Perlow <jperlow@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2] Bluetooth: btbcm: Add entries for BCM4364B3 UART Bluetooth
Date: Sun, 22 Nov 2026 11:51:32 -0500
Message-ID: <20261122165132.14015-1-jperlow@gmail.com>
X-Mailer: git-send-email 2.50.1
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

The BCM4364B3 combo chip on Apple T2 Macs, e.g. the MacBookPro16,1, has a
UART Bluetooth controller that reports LMP subversion 0x3032 (001.016.050)
on some units and 0x305b (001.016.091) on others.  Neither has an entry in
bcm_uart_subver_table, so the controller is logged without a name:

  Bluetooth: hci0: BCM4364B3 Trinidad Olympic GEN (MFG)
  Bluetooth: hci0: BCM (001.016.091) build 0115

and the firmware lookup only tries the generic "brcm/BCM.hcd".

Add both subversions so the controller is named and its firmware is looked
up as "brcm/BCM4364B3.hcd" first.  Tested on two MacBookPro16,1 with a
v7.4-rc3 based kernel carrying an equivalent change, one reporting 0x3032
and one reporting 0x305b.  They now log:

  Bluetooth: hci0: BCM4364B3 (001.016.050) build 0082
  Bluetooth: hci0: BCM4364B3 (001.016.091) build 0115

No functional change is claimed: the controller initialises without these
entries; they name it and make the firmware lookup try brcm/BCM4364B3.hcd
first.

Signed-off-by: Jason Perlow <jperlow@gmail.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
Changes in v2:
- sort the new entries by subversion, between 0x2128 and 0x4119 (Paul Menzel)
- say in the commit message that no functional change is claimed (Paul Menzel)
- add Reviewed-by from Paul Menzel
 drivers/bluetooth/btbcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 065536d4ec76..def0853fd8ea 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -518,6 +518,8 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x410c, "BCM43430B0"	},	/* 002.001.012 */
 	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
 	{ 0x2128, "BCM4384A0"	},	/* 001.001.040 */
+	{ 0x3032, "BCM4364B3"	},	/* 001.016.050 */
+	{ 0x305b, "BCM4364B3"	},	/* 001.016.091 */
 	{ 0x4119, "BCM4384B0"	},	/* 002.001.025 */
 	{ }
 };
-- 
2.50.1
