Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553470;
	b=tLwpC8+2CX5Qn9h/5e797C4FNhlxzmirSw0t6l6tRVXmpJ2oNo5ne0MzVvPSX10NpmX4
	 6H5BxdpkGZqUQg11yQGphmUmaSzC2OjnWjy6jN/Q9AiRnucwfQ7nr1Jne6dCjJ6sVupLE
	 l8ugNrwm39BjwN0Qd+snQJPt22z6SEfYO//H3+zdR3KLsA0/on6c/hn/Vg6xFgqJ8qVCX
	 rfo3r5yo7oPxbZaPg2VRrMU5yT3l+yvEsi/EKOI7dPvilUM84Zu3xZZUcpB0T/4BYCjlI
	 +f2yehMiYCQomo3rMimGwvuebPO6jJebOmqatYfuBQzSQpLQAisiUi8Q0+3hR0DMQew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7XYzZSlM3O2BoehNjFHmoO37Rm46xkBI5D5iJuD3yRU=;
	b=Kv08jmOThzQaF+HkVZ2fgzVynxnG8K0fJ5a5T9c8xQZyEit7eqK5YjhWaaXMg/VJXbod
	 H7/7gqI8CZ5cARbUGq+CzaeVPZA9pJDk1j1b6b48paKtsda+gux6ziGN0uUAW7/ppIRcd
	 UFpcSlD+1mHUIqiDQmRsm8oDhNnLUaaPhJvyrO/erYLVX+el4seXN1yDEw01o5bJtQHV6
	 p1+HkFJOEqCFpbIMljKRHNWsNkyWqb3lnSIUZooWZX0E1hf08bEo4ZkP0Xs/sjtzNGgoO
	 WjEEgY/BgDy8Wk9XRDn20/VWrC6HI3rY9W+4l4QA8Qzg3p4augvV1EpyU9ECe4VTEhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wIX0aD5N;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF00A606A327
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF00A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wIX0aD5N
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ec6f271883so3038596e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553468; x=1796158268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7XYzZSlM3O2BoehNjFHmoO37Rm46xkBI5D5iJuD3yRU=;
        b=wIX0aD5NrlXf70HgJ913eWRn93ZqKF1Q7/Ki/mJJAshco9k9h+7oMEoY8hAbHxyyJn
         bVUFYuAomJKwwJ1GBiQOnsdRAbudp25GSNAjvxnmCKS1L81lhmRESDQ/sv1pxmgKdCbW
         qsa06b8NSo44LElMdVndZnlBP0wlcgOVLHzlGL12I40Q+GvF3FSmMXezi9uL4srmt9K3
         QaJ5ais/GDBtDQyebZHEGRHrMAW3qoptwvdJhKuUjNtBtC5J7fg2NbBEgZXzqbNCjF5r
         GRGEhUb8X0oF+eKWTeuWObtyB/cn0uMpwK8uMyaCncS0GihvU+s8BVij9QWtF46toe1X
         zCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553468; x=1796158268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7XYzZSlM3O2BoehNjFHmoO37Rm46xkBI5D5iJuD3yRU=;
        b=NTeyO4bTwURv5HlDb5CG58rMez4+DSETKmAsZ7XnbOTNjfExtK9aC2u6FvSMl6F0jY
         equ4nhx3aSIJd1h6wQLNrMFEVgFbeGrxlydybd+g8t63MqAGYBV3DNWhliwhGTAiHbkd
         0LLj5DjHxY7jHhsMpUfKM2IbebVB8qaPybbv5a9aYuJoM89K1NpMe5MlSBjZChBRDTMl
         XIYhEXYL0au2Ue8rLwq3ajl/ifDkeXJ9CLfCh34vMPFDGe4kbWWFi8Tll1Rb7vAPybb9
         q85VPtKWxK+C+4384Z0YQONfdJghBKWFOHqUiq7TUAEsU/YodwgO+H4vSacEPVxj3zCK
         vGXQ==
X-Gm-Message-State: APuU4Z+JlDvF9yKUKmwx6ubq9+scpTmg8V1PgCzryeB8mms+tJ7OHeZ5
	nw+n/rTy4dB50VOUK8DSKTwusYBM4XZpnoRSyFy7xXi2I4Hos0BTlrBtiB1jRA==
X-Gm-Gg: AZFdTZeftHt39Z8X94ydCdLL+Le72xiPhir7oZRtPNt7T7MEprncqkMwhyI6qXIbJRZ
	UUG4LzEwUJvr2Q3764hINP3GU2AiYG/KhZQGhtD3QWqd+hvLNo9ocC538qNYCq/rxKaihjWr1tn
	tn0InVmaO455Hs3DbVBhYdhJ7/cmfwYVhxji6Vbz65Lvm54DtxQ6x3WWeBfHS3plletX6oWEiwr
	ILQhoD6P4xcwn+CmCKN0hx3btyz/Zb72u2RdKxTwm1bxmeZAIkgHFAlY6ePqv9HSpNIUNbP6PAd
	7hsUXZgFsEE+7HQyJERylEVA8iU/vvU4hLpErUseifwuYSArq0rtmwdFxtxn6Mv0Cbh0p9Ig2BX
	FyX88EmB61gHW0e3Kf92sq+1/mz/HO5QoC3HXKNPSdvpuw+rZ3CvivwX65fJc9L3UgslGeMogTf
	6TipZhmSnNF9We/t6eekQWKz05KELImNHHHti6bQhiXdM3A0JyOVBEhxINBjphRRegYK4ukxZ5u
	kfOfiaCuyZhzrHiQF8SpvZxG5fRmyk3x8w23QJ1ju4phUv0VfwDG1jS4UtFP8qJGVgJXRHKWRb2
	2RiwEfauBfRXEWUT1LEZfqcRm2UCZhwrvtBsC+/C5M2ySFdCLtIO0bQzr5qWr0j4nF+CdtGWNx9
	nztacGJTSVtKsvQogI58knXBt6iogPejcTrgdJEVQv0gir+jsatoj+SzlFPvEgv4Rdp40PW5zcu
	BbA0w=
X-Received: by 2002:a05:6122:3d10:b0:5c9:c60e:5cf5 with SMTP id 71dfb90a1353d-5ee8af2e0dcmr10118607e0c.19.1795553468470;
        Tue, 24 Nov 2026 12:51:08 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee91a4e0cfsm13929876e0c.13.2026.11.24.12.51.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:51:08 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/5] emulator/btdev: Add btdev_set_link_key_type
Date: Tue, 24 Nov 2026 15:50:59 -0500
Message-ID: <20261124205102.737384-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124205102.737384-1-luiz.dentz@gmail.com>
References: <20261124205102.737384-1-luiz.dentz@gmail.com>
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

