Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189675;
	b=G4d6u06PA2rrseiZqkh7wxOoOmMoO+xv9oMp2o6nrERtPKGl4bETUB/ryiSZ1OThU92q
	 KFrOVwk2QHQR8O/e24QCnhY6gJR9Z2hgemafSLPHTzymij6i2e2++tEMBEfdx/32feduO
	 wKdn+rqpUmTcvurXsdPsClJfgR4N449zXaL7DjOywqHIslmkGDbe2ppssW7tgnNva/3+p
	 ovKiAHn30Zjzpc/NQ7lvk99LtTRjA/AZxYvCPQlh2fNn5nNbjYQrsw1t+xgsNu7Z7YoEt
	 I+MLgZyvaBHYwAOldo0KoTBFs+GItdIckAuQuOx16U7N64RK5QHkHSaQ884kYj+98ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7XYzZSlM3O2BoehNjFHmoO37Rm46xkBI5D5iJuD3yRU=;
	b=anNzHhtAxoAnWSCccRXiqesqOcqgjFMnQRKQedvofvyDWTtJsVvWWctbUGBh2MKYRPMG
	 cJQJEIcbVD9SYLa8Jar2hny/J98xNFcu0szuVbocp0WNWqRzrR2xCiOs2iGF3bOvO2HUr
	 Bl884bFoBOezZOQJ9mliqGNoaELWDGvhxFYJthJa8+gyiOiaJUQX1zTkEbZl8wusnuwp5
	 323uFRylK10g7D+G49c7igW8tK4cn82Y/CnWkQW2e138SO5ZaBO4XaM+MxjVRMfWdA8Fo
	 3cBEqySWlKSKSudQMvgRnVeV/ety/LNDalzcXNs+D1hch9gNJjeCK0v2hh32mTXyKrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bJd+GHRq;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C11660A2616
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 15:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C11660A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bJd+GHRq
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99e0b1ee864so341363241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 07:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795189674; x=1795794474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7XYzZSlM3O2BoehNjFHmoO37Rm46xkBI5D5iJuD3yRU=;
        b=bJd+GHRq2f73xuZ67afoan1eYU4Gqk32qBRR1I+V3JGtaWrJ/aHsCI/C2qZ0/809YD
         Ku9tD/0aRkvP/yFaIfONbvScxmf7WmoPR5FKwtCKerElIp+A8IHi0jUKwKTQhjEUlD3V
         0/zOUz7x0yZziyX7m+J6JhyVvLxwF4l2FDLoIRG2RbM35hdTyVSG3ZAi+Tq4FrB/4cw8
         EHbHjwEGAdCeM1fYkK/vhO3l5uaTPlLI+T0bLcQNV55nJke2at9TG2BpabDX50C0eH/5
         Z1Td7x2wqEV2sPs6XEYSJ2Q2JubgPlzGGmXyofBpc0Ch5jvP+MTfPEB5XyMBOcPXWAjs
         LSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795189674; x=1795794474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7XYzZSlM3O2BoehNjFHmoO37Rm46xkBI5D5iJuD3yRU=;
        b=XYzLDKi4IcLxp2lTLgq5K5W/G/K+x6HKf9ae/UNwFHKEXBdJOg6CE0kq0/HNcBCaB0
         3aeovNgailgEx/I9zBInqM4sGD5k0CI9oHuZ/IDrLEZmsEVixQxwsKXQY8b0IAkqumKL
         EW+gtmsdU0GIXHZ0saGbxEUM/vXaZ2jNbkAOTX4hH7sOtldvZjaNcSiLdtYaSJri3tQm
         Ft8QsM2W77MpPRZvNTdtRLmX7f67e8cLOyhljRc+044xR3ci/0gVxoeuqpuH3x83ENOh
         5kydXawidAMNQ/0cqFU36hbXW9zrfR9T76fYUWUCJ7BZ3vo4/gHJdY3oyVvn4VQERlI4
         5+/Q==
X-Gm-Message-State: APuU4Z84IdweI2w0VcvfXABNyiS6+6e9qboDRvIa0RL5zVH9qTzpHGHE
	ZE7vGpSYFLed4/rH8PVbZOo6/1muMYw1CwJbuptsWomScehPYj4RkVixkPIaQ/pD
X-Gm-Gg: AZFdTZdI4BOcu5vMdTdagV1yDyeQajLQge4K7aA9bJiumBjMgR9EwbULI8JAf9CHOj5
	WBimfGeAqUTssW9SIWOiT/GP6aEc2erAzJP0Ops/6p6A5KCS3dkH07KeL3l2qF+2osdGOCkL2YV
	oKHP0smm8EmLHt8hNVaGFWtnVj9Hu5moY0n+7QLnJVXtziWHBW48nspS0NX6JutE6lvYJEJPYSv
	sGo4lRre6OMxccGHsOU63AmeU5s9MynQUva/tCeTgxnHL55J90RaG0MdYb01MNEw7UnrJZpCg/k
	fuzIQSgbMKauz4xXI7tDwb6lvigvJ2+Z7W7zQ8HXpiL3eqHOPukJ5+1etXGgr3NvrsvSXePy7nD
	d7+qOOt52gXxQUZfsAI2vcUdzE9ARSa2RFvrYVta8d8EeNqy9OZ7tv9X/xvDJu1hXyZyOBbNzdW
	MPExG+melFdbnHolRQb5TTHLoERj7KNX8zpaeaDJ4bsxz6zhQAiY2cEuTIJhWFfjZKdr3aY/PNw
	7wedavjGeVYMSBIJT3OR8eI3kEurq9WKa3h+QAQAxF61HVcbXuQNwT3xdD7nlc/t75lMX/cnUc5
	Ue9j/pXySi2ihbevYibqzWG+byxbkhdjBqa4t5YpU7LWkN1t9RKIvWckWd4UfjRZy+0Ufa1uyAT
	3n9f4YAUz28I9GopPwUTWYWrw4AnW0diiWM47mS99nFA+2Vt8nK5/BOCNTEzxiXjW+sFy21mDRM
	ei/DR0lQ56L9oNDSubMqlHIG4U
X-Received: by 2002:a05:6102:b04:b0:7cc:2fd1:7122 with SMTP id ada2fe7eead31-7d739462ae8mr1607276137.18.1795189673992;
        Fri, 20 Nov 2026 07:47:53 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7b12eb7sm3358243137.0.2026.11.20.07.47.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:47:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] emulator/btdev: Add btdev_set_link_key_type
Date: Fri, 20 Nov 2026 10:47:47 -0500
Message-ID: <20261120154750.1745643-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120154750.1745643-1-luiz.dentz@gmail.com>
References: <20261120154750.1745643-1-luiz.dentz@gmail.com>
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

