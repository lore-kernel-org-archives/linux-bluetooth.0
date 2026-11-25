Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624111;
	b=eAYe9khVU9xlVOyRgoA+6MCpVut2HTR2AHFRWieoKSSCy8oIu0H0Q/Ehi09ZDhtF0nhZ
	 I7M/dLxlOlEL4tar4noYJyHA0Z7oGDQoISsCMpNxEbQju8ZV7phP9sy2dabRqi7Vg0Ual
	 75Bvge9kU5eb76qafnhtEcIQgNJNaoLI3A07tnD1q2x2PzjFrCtRT2l5n0ZYJNmbGEmEQ
	 aSCl/jK3wxQ5f5+aT1mAHmRYnFMziOcZIihHrWV0XY/TVO5GFTwRLCAGApYU5bKr22ovb
	 v+LD8bGR9ZOMX4Fv5K38kpdJHA9jCzoDOsSdVNsIlyFUmlfhuH7Qid+YBm3M90350qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7XYzZSlM3O2BoehNjFHmoO37Rm46xkBI5D5iJuD3yRU=;
	b=GwAI0aLSMWORY31VJ+vuB+qvqDvGiRa7yUjFW7M2hlArvUXJbizeCEE80tvD33OJmBg+
	 9GBSBoJZbh7PqnP96g5pAOg63dxgjTB20gplPsnkuwQfUjgi9SAbmg6P2OcdU93/XDLQb
	 iiGcjdwqinsFoWU/qpbS77fVUrkxzhu7uu7OW6zJMy9PqULXMC8TEYDpjwKih6uazqyQz
	 xuXcKVdUPIRSuXV8d14FUiPq1hSX9ER/68wWllZcaPhd5EXJ1FIp5zXKDR88L0BUuA3in
	 gmOuN1MFlG7PpBpqH3SrThKutVLADDVCCSe/e6O+RkcsgbvEvmCJTRiGKObyyOH5kFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iLN8U/gH";
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5489606A332
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5489606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iLN8U/gH
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so4244593e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795624110; x=1796228910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7XYzZSlM3O2BoehNjFHmoO37Rm46xkBI5D5iJuD3yRU=;
        b=iLN8U/gHahzXAaiPB+9C1YZOQhwTyh1OACnT1ijaNfJ3iOrRgYGgx7fwYF75oooOIo
         k1SzWQ0Y7I8VVeOvZZ3fAKp1JPjdFC4/N7sKKEcxzRnBJqFU5cgFBclia3YVybejUpiP
         /ZYFtDVJiIth9vqtjYyLOm2oebnuTK0xYxI29sPMpXma6ZIqVjMzPiDQ9pfyHEE6+g0o
         V43HdVPJ+Wb++Vq7/tdvt3dajZNJ81UmxFWmAmktJefqZ8jQa8V5FZSx7ZPBBjkn5iaj
         d1d3PWbhpFhFQdRepIwRr7GiKiTAgbMhmy+846cqFimgZn7puHaB8/I3C4/embUkaoMg
         VKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624110; x=1796228910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7XYzZSlM3O2BoehNjFHmoO37Rm46xkBI5D5iJuD3yRU=;
        b=hL1hlAsRFj5A13dCFZKT36O+IHfa2b6DQz+3966KVCgbbWiwGsAylkklEUanE6ezMr
         waQswdu7suufN9+nU+IL8tjGyKeZUyK5oKOZBAQglLZdm9phkiXutxd5eUMoI5JSqyFJ
         WrNWBQqb1/unzHogykZsA3PSH3S5usAfZCR9vL6S/u0E0MlMacnb1W2YRaykjU02nhb3
         ts5VFzgPVR7ehBwbFbbE/uPRwQRvAIfKg7qqJszZjdBcQjudHZuha8kK7TFzpMCv+yBF
         s6elSrqhcQhoLAN1EOvBYSQB98PhYL8Prd1CzCFQeeKbn1FNnbYgDIhrWecPLjVFDq7f
         w5tg==
X-Gm-Message-State: APuU4Z9LbrPyLRCCA2CCSLN1wutDjzRFF8yqmbJfcJgdOXFkJnjuohLW
	3DDrkPTPcle8+7t/EPqVimJPqy9e+oFOnHwmDd+5uBGo5JcNpKSHb1WTyqRxig==
X-Gm-Gg: AZFdTZdwSivVzSPx8S3OK0ime/+XnjLwHu1kNwZvR9dIKzuwoXWvbmtTpWtFoCMF87A
	Bd8dDC7ELfeVUljX6LcF5fhcUhvI9lEkPCGLFW5sbSJz2E3iL0S1pg1NzNX9/q9zkh8n6V/0mCk
	1DQftzE+MTbrCwCYSnQgfqbn5EvwApQUMSP936PujRhiGB+pbKmx0yJgw2x8yTmo2j3mq6GLdyB
	p4vexpBz3b8DzQNrM7ftQQIXojCiPW68HQ8GHW9AugnLqQp7dRtS9DQunInijd0thydYFhdDgAT
	+syG16Yf5a5rmf5nF7L2HLQWzBATGPu6kQdt8YKLyQZm8aJ5RJO98cjoKH/8vef05wmHiHQeP88
	oCOHuQY2QmuXHSbBzC5e0q8Alxz4oYPD3SSorppnv2wXsuu/GrZzk5RNk4cGVFOjZ1jHHfopF3/
	PMix/eCY6Cc5HSqNJb507kO723g1Cro5s3ak9BO5ULseJg0p0LTtxWjo5XPMAV3327ZrvZtqrTE
	5id0hL5SgMrk6+r1p687+KhpKOo7+3XStEIRSWNWCS4lWWKzzXpUyM9c48hOMoy5HCu2HYXziwp
	tS8mZWDVZX1f6Ytrb5mqJq7e1Z5eOrEJ3Lz9MkOFQbEBqNR4VhHJsA8vyloBPyYWPZQHhGScysA
	Yy1FspinczZ7poTNQZkZdMSaHKeARAOgXFvRtSujjagKl83egG44+2lAbK8+1XYNFsiG02t3KCO
	7ILSiT
X-Received: by 2002:a05:6122:78c:b0:5ec:d84e:3833 with SMTP id 71dfb90a1353d-5ee8af37b8dmr11131708e0c.14.1795624109708;
        Wed, 25 Nov 2026 08:28:29 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5cd7c8sm17985305e0c.11.2026.11.25.08.28.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:28:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/5] emulator/btdev: Add btdev_set_link_key_type
Date: Wed, 25 Nov 2026 11:28:22 -0500
Message-ID: <20261125162825.1409753-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125162825.1409753-1-luiz.dentz@gmail.com>
References: <20261125162825.1409753-1-luiz.dentz@gmail.com>
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

Add btdev_set_link_key_type() to set the key type reported in Link Key
Notification no matter the type of the key pairing results in, so
testers can emulate pairing completing with a key that doesn't meet
the security level required.

Assisted-by: OpenCode:claude-fable-5.2
---
 emulator/btdev.c | 13 ++++++++++++-
 emulator/btdev.h |  5 +++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 1140acd90e7d..7c630718013d 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -214,6 +214,8 @@ struct btdev {
 	uint8_t pin_len;
 	uint8_t io_cap;
 	uint8_t auth_req;
+	bool link_key_type_set;
+	uint8_t link_key_type;
 	bool ssp_auth_complete;
 	uint8_t ssp_status;
 
@@ -1906,7 +1908,10 @@ static void link_key_notify(struct btdev *btdev, const uint8_t *bdaddr,
 
 	memcpy(ev.bdaddr, bdaddr, 6);
 	memcpy(ev.link_key, key, 16);
-	ev.key_type = get_link_key_type(btdev, bdaddr);
+	if (btdev->link_key_type_set)
+		ev.key_type = btdev->link_key_type;
+	else
+		ev.key_type = get_link_key_type(btdev, bdaddr);
 
 	send_event(btdev, BT_HCI_EVT_LINK_KEY_NOTIFY, &ev, sizeof(ev));
 }
@@ -9458,6 +9463,12 @@ void btdev_get_mtu(struct btdev *btdev, uint16_t *acl, uint16_t *sco,
 		*iso = btdev->iso_mtu;
 }
 
+void btdev_set_link_key_type(struct btdev *btdev, uint8_t type)
+{
+	btdev->link_key_type_set = true;
+	btdev->link_key_type = type;
+}
+
 void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states)
 {
 	memcpy(btdev->le_states, le_states, sizeof(btdev->le_states));
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 097021c01cc5..517c65a19cf0 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -90,6 +90,11 @@ const uint8_t *btdev_get_adv_addr(struct btdev *btdev, uint8_t handle);
 void btdev_get_mtu(struct btdev *btdev, uint16_t *acl, uint16_t *sco,
 								uint16_t *iso);
 
+/* Report the given type in Link Key Notification, whichever is the type of
+ * the key that pairing results in.
+ */
+void btdev_set_link_key_type(struct btdev *btdev, uint8_t type);
+
 void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states);
 
 void btdev_set_al_len(struct btdev *btdev, uint8_t len);
-- 
2.56.0

