Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792841096;
	b=jyFSq5OqVyB0VJ9ptuTxVefkpubav8rX4x+tUnPcbp9IJqemzux7yeMzVnanKTVTzs54
	 QvwPGK7xcVuzpxAeIBpcd5TQDel+cJk1imsmggyBqIxlXv4tKJA1SxQVnwKobEVbHMqC4
	 c9rUJPnGyF5T9RkvtYXPLeO2nSvuyV9uYL0cl7tAf16REGNasm7sZ+E118vCCT5j0xhDp
	 NKyrSWVwe5BmzLQ6zV6Th/Fpc7Jg/8R+iNDzBQmqv4BTyo8jGpGzb7GyXqwa/URbDopp3
	 1E8awoepk3Tq0cSdU/P+NokmwfO1kgz3/N6di/yZWpRx9lLabWwbnDHKHbyZuscH99Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ta/hufzKWtQdh9GqXfEiUQG+bNrs7dxExPKRK806f+k=;
	b=mhSZzuG0g4zDjDWwT2yOutsDPs1QS56ZLBUR6hr7PuVBcWEF/AFKHVKHLX6vJteE7Nfz
	 RvP0LPXzB4RgX0V8eSG7AYQCHB/vwbcQJKobL5uiaNRdwcCciVfzByrTPstfgcy6FHah+
	 m8zfJ56SB7TKhpaKu8FRd+bL1X5/pOFCBEq0PXSGliovfcZvhEK/FBkgIL2wzu6cEkzPQ
	 83l5ACAloMuXvm+BXosYS1tD6Kj9uicIolTuGBFmaJruBsmSM9UNLY+WqWj9JAJsy/MbG
	 kaClA2bb6/p2UWqsMpQzKwuAARaJ6IQ1jJTgIjEZgXdOduKDS07gC980eeu3uuO8ZNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fv9jnZeB;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1506E606A329
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 11:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1506E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fv9jnZeB
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b06c0794cfso13839557b3.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 04:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792841095; x=1793445895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ta/hufzKWtQdh9GqXfEiUQG+bNrs7dxExPKRK806f+k=;
        b=Fv9jnZeBiFs2yn7IXMRDPyfXcDs1/S5gu2RQ/QFkjVKtDS/JN6ckELHI6s0qOfBUid
         KEGcLFDiCS2C1gip+EpNNTK1yDwCqmtYMhF4+k1Jo1N/U/qUExikrqiCjJBN1e4BkbWY
         q43+/ACdEV9E3h5Q1Fjmw5N5DUefSjmiBmV+BT+md2CuAIdydCdZq5eBC5lZlqb34+6t
         Hc05NUjT2TjAgPfplw34pbVoEsJEuwi4pp/WxPa4MMA9St+6+gCPh5rPEbl2FrpQ4uk5
         q6vuGKIi0FcNz5Pb/bd1oPjMt466qyaBLKoGqIibPoxCUqJ2+BjyXHPDHmz5Hp/uyDJM
         h8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792841095; x=1793445895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ta/hufzKWtQdh9GqXfEiUQG+bNrs7dxExPKRK806f+k=;
        b=r9Nek1HQzX9N/ge0Sg/3M/wOcQX0UWehdWyGdtDBASxTdLsFHeyHNfAMTmT3r2Qi9z
         HACrqnAUFwbv2Abt920wcO0ORgD3omBm4yTwFH/fGJk9JC/hogFJvpjDkGR89PdQuGPc
         8ICtDfjedaN2yMHfGolSnGFd9oH0tLEPCuoZ1UqOyZfR4dvFSIhz6PNLY3iCSBf1P4y9
         Rx1mUWOKx7Zb7hy4uouU1A96LjQfLJSDJBgw+DNlfBtfW9ZHpm90mERgn+qQ45rEHFXC
         eqAaSlNWIt+9IbYnTYl+jCqx2mSnzTP1iFsULwKYPwqtvDdQr11/gFFlSKOfui3/Y5Q0
         +rRQ==
X-Gm-Message-State: AFq9FYJMcju0e8fcIGB/4wXw/auvXMyAcbHKgIeBxL6gTkbbtxwBHcMR
	WFE9w1ClqSNJ0RrKGGP8xV8LMrz0LXKdv339INbev9K/hANj2O1Qejo/LNYpx53OqoU=
X-Gm-Gg: AYBFou0Dw5CwtsaGg1Co3MKnZyb8FmDyBYe0VTUP8/EaBHlOm8EX5OiLt0f9nJOGRot
	5rK3KL29q49wWfyZqXY9im2pjv5XVzlXU0L9cEng0x9g8XVkfPLZhd0CPu6L4rQitjKYoPytuZu
	U0NEyz0xvs1ochtX/KWUejQICWXSmr7MO+EyP3V31Zs7kFaWDVkLspA/GDel2wcozEh0t8EJdSr
	E66v8bG4Y0itVTDWXxGLmnr9oHazoWJgwNMnrSjp72x5hny2eAZqkFKX9cCWytgbTA+MNyB25PK
	GzKFFa/ST0GJCebUwegMTqlkflqhZgNmbMS5zX8A7shaZRY0k0tsBBio3AAQOyKTaYE1GZrs82K
	YN+q7fJhAUYcIzIh+mowz2yCuyfrDmaChNaRB7WBk985VqB1bVXHVU0uiYHikQbYnFF+dfyqKKf
	o2LVH2Z7Ad1ZAn5ZhghCUKhMnq379Kf9SD8mFS0YCE3oA6zors6R8Zmwbrz0FadQ2xIR2a6sTtI
	vbCVvT9Hev/dUP1SHZgqTb2vF6J/kqNfQFBZ67avgEu9LapsEWzSbjRyT3JIKKKDPd9
X-Received: by 2002:a05:690c:c3c6:b0:873:5bb2:6c08 with SMTP id 00721157ae682-8b166c516dbmr10487707b3.50.1792841095062;
        Sat, 24 Oct 2026 04:24:55 -0700 (PDT)
Received: from WillzDenali.lan ([2600:1702:7a80:3c5e::dff])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a4626cbb4sm855725d50.16.2026.10.24.04.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 04:24:54 -0700 (PDT)
From: Brandon Williams <turbine.bmw@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Brandon Williams <turbine.bmw@gmail.com>
Subject: [PATCH 1/2] Bluetooth: SMP: ignore an all-zero IRK
Date: Sat, 24 Oct 2026 07:24:34 -0400
Message-ID: <20261024112435.247650-2-turbine.bmw@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024112435.247650-1-turbine.bmw@gmail.com>
References: <20261024112435.247650-1-turbine.bmw@gmail.com>
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

An all-zero Identity Resolving Key "indicates that a device does not
have a valid resolvable private address" (Core Specification, Vol 3,
Part H, 3.6.4), and a controller given an all-zero peer IRK in its
resolving list accepts only the peer's identity address (Vol 6, Part B,
4.7).

smp_cmd_ident_addr_info() stores such a key like any other, and
hci_find_irk_by_rpa() then resolves addresses against it in the host.
As the key is known to everyone, any device can generate resolvable
private addresses that the host reports as the bonded peer.

Treat an all-zero IRK as if no identity key had been distributed: do
not store it, and keep the peer's other keys under its connection
address.

Assisted-by: LLM
Signed-off-by: Brandon Williams <turbine.bmw@gmail.com>
---
 net/bluetooth/smp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 984b2d0b5e3e..fc75cf568471 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2624,6 +2624,16 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 		goto distribute;
 	}
 
+	/* An all-zero IRK means the peer has no resolvable private address
+	 * (Core Specification, Vol 3, Part H, 3.6.4). The key is known to
+	 * everyone, so storing it would let any device pose as this peer
+	 * with resolvable private addresses generated from it.
+	 */
+	if (!memchr_inv(smp->irk, 0, sizeof(smp->irk))) {
+		bt_dev_dbg(hcon->hdev, "ignoring all-zero IRK");
+		goto distribute;
+	}
+
 	bacpy(&smp->id_addr, &info->bdaddr);
 	smp->id_addr_type = info->addr_type;
 
-- 
2.56.0

