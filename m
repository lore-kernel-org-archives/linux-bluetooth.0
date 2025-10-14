Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA609188A3A
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 01:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760405622; cv=none; b=DGIUiavl43tYkaiYI+/EUe9je9PsL2z/lztX5T4VobBqV7cqbGkcGCiWJRRNKDUVgka/cMe0bM4Z0FY9VorGxErsABcScmRqAOv/8pVhEiKA4aCBvXucYpBfY/d5s4qdvOHOgln7q9Xr+GUQUYnmh1SPwSuHuz05PoORJbnUzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760405622; c=relaxed/simple;
	bh=rcGzL1tYa61X47d/knh+ksN02boxoW7bHCgc2M98Vm8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ovd2BUTGJd/ipoGS6SGTPy4t+bn8BL0Z7NWUWJoQuOj+FYL7iQxkFlSmxJRHOFx7JoE8nQ1im6Mjh9F7RhLdSYhL/wIaAp+8J/oLR14mgbKf+nGs0tFDvgD/L1SG9kApX2CvwyFYCYO4tLafoXmG3C5UCCI18s6h/Ap1vOHPC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahr+Xsiw; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahr+Xsiw"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54aa6a0babeso4515065e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 18:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760405619; x=1761010419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cy1DOAZxW24eIrmMV+jK5et+70UEmME47a6FY2wI2f0=;
        b=ahr+XsiwaEFQsZ/q0T1TTus5VKTh2OC1HNokivH4DWuoVbdcipV7KDo+7AR37FYCXO
         zoaOsCtvWW8ZFSNP4iKiC++LjY7ywievbP3X/lvlFlC2VsoKaFqpfelawxYJ7ZbLcDbz
         uQAi0+Ahzkbez0wWmyX06rqqd6rTnRNz0NhlfeDaCy4f/TZv7jBfIXLd8yzLWTqadIrX
         I0BEBQUqTssEXi1o7D4xGRiY6L5MIdHhsRP8XGj37Pu3EA5+Z9DMapDNMfde6OMphbsv
         dleFp9bwnAzs4ENw8rERm28FqvrqsEN1VZG5yrWqlFAh9mN5NmJlCWcOAU0WU1mmZ+2e
         +T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760405619; x=1761010419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cy1DOAZxW24eIrmMV+jK5et+70UEmME47a6FY2wI2f0=;
        b=Pq5SW/Hah2JIrl+lmaiSAiJ0SXpTQU2se+YczsNjLFSipq+GNdkKBT39fNDNTq6FKw
         rlB8+bX8TeYJxy8PmtJJhXFT3bAe+/gA7Jnry2noZSNgVBOZu17Aq9AeivkuI3qyxkl3
         R7KSSblfUDvVKW2UmD1KEBy48F5NOck8wlPXkVRBicTcR0ju+doUXTEyrSha1JXsg4A4
         w9uRS/u2WPxiB6nqkhnxxPwCrndKRDXshNJvnysAUyQlrb9Aoc+2ohlxKxOGNRx+uleW
         JzUcksfKMb2ie1IrUjkHoBgCMR3Y7jzv4lIE01Aiz79YmxRRFU7QICU/uikFTRN6PhcH
         pM8g==
X-Gm-Message-State: AOJu0Ywt8dYzuUTQc++7ks8xsZ6E/Ha/14/aCPuiGyYSv30TyvRIELCQ
	oNUy5asJlpUSZXJ8B+XMh6FtsF4JsR9VwAuH9ft4kx3YzxsdXlXsv6lQVtIqed8z
X-Gm-Gg: ASbGnctcDV1i9WD8FvcW/9EBp65NruCoYrAG5xar1Vn/7cRQJywRZLCKBmWLWo6T7iZ
	f95zJ7/4/lFNr5bVZE9BG2uQiXboVTWIUcDXR9jNtaFkl/UfNFVMn9MWCY91emHZyz90oGTzTBZ
	ASUVqINxzmlpzrtCS6beLPVnpxHuPCnENKGYiU0QXzwR7iyzE74e/kiWTnBQuqt5oEIMNS0xiZM
	mfIPn+L9fy5J3cEh9GXZzKRLk7AoilUDMTbQSmuZ0Kurx51WD/q8ZeC3XneQgXwrNBVVThk7IUN
	JQDjX0R0+JM7FfEuvyu/r59BTaXuz0M35ADXwGe0dFZPJ7UuI2ZKe8Vya1M3fbCyK7QK7s+I+Tc
	3FHPQBdOclesxVcMtAA+mF3PPEfdHhF0qA9kAb6JKQC95T/lLwHcL5czZlhrh6LvCBh0x2JVynB
	sEEL+w/F3c0QGgXrCFjyY=
X-Google-Smtp-Source: AGHT+IGTeTOFOTJmrm9VkSjbJCIrsvyye8ncKb6+M8sEJKpjNZ5LJY5NUR5qoHgm/fumoD43+L7WyA==
X-Received: by 2002:a05:6102:3a0e:b0:51c:4443:16c7 with SMTP id ada2fe7eead31-5d5e2591dc5mr10318175137.6.1760405619046;
        Mon, 13 Oct 2025 18:33:39 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc7126c7sm3985806137.5.2025.10.13.18.33.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 18:33:38 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 8/8] Bluetooth: ISO: Fix another instance of dst_type handling
Date: Mon, 13 Oct 2025 21:33:08 -0400
Message-ID: <20251014013308.174151-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014013308.174151-1-luiz.dentz@gmail.com>
References: <20251014013308.174151-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Socket dst_type cannot be directly assigned to hci_conn->type since
there domain is different which may lead to the wrong address type being
used.

Fixes: 6a5ad251b7cd ("Bluetooth: ISO: Fix possible circular locking dependency")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 8f46a5cf22d2..aa63c8955a53 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2150,7 +2150,13 @@ static void iso_conn_ready(struct iso_conn *conn)
 		}
 
 		bacpy(&iso_pi(sk)->dst, &hcon->dst);
-		iso_pi(sk)->dst_type = hcon->dst_type;
+
+		/* Convert from HCI to three-value type */
+		if (hcon->dst_type == ADDR_LE_DEV_PUBLIC)
+			iso_pi(sk)->dst_type = BDADDR_LE_PUBLIC;
+		else
+			iso_pi(sk)->dst_type = BDADDR_LE_RANDOM;
+
 		iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
 		memcpy(iso_pi(sk)->base, iso_pi(parent)->base, iso_pi(parent)->base_len);
 		iso_pi(sk)->base_len = iso_pi(parent)->base_len;
-- 
2.51.0

