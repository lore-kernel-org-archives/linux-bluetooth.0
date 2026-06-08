Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3C22423A
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909909; cv=none; b=SiI2qqqasl7rlFlr9eY8VnzvD5Y8Z0Si/vwNWOraJcYuxEWUAQ4/vDULy87WSsEhj2EFX8FRPdCr9f05jdVC1hxpnY5vplHltPnz+Rd+DuSK5H5XFEqQAR7Dv2Yt8OOE5mLd1kiZANbkJywoUX1WU9vRaMlWzBBSUK198h09vDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909909; c=relaxed/simple;
	bh=WqZ0/yRA+I0Hkh/jwm3Y2HqCCRdbnwG2pzRIyCmKnwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9X9fanKKiKJ9qpfEU4R0LivK/tfPssDCs8eZWHc1lHOu+hlz9tJ+5wbkfjud1J3OJ1GaLBJHNGFPuxkMMRXHasjAAVZc6zurLgCXPWttidSM7f6AClxyFY5PYnN6XrkEN4rhzGc7GMypSOqaiyNKkqjuGjuXpxero37kVGgZN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=lC4LB/dy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="lC4LB/dy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so22029575e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780909905; x=1781514705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IxKtvDwsFmlBq+8ZwoIuweomQQeZ8mvWlwV7JGjQD5k=;
        b=lC4LB/dyvnUTIVS3EUKl8OJ2r4YEaDzUneMFzyuHpW/Ch+SPdu26VErDJar/M3odY4
         qg8MJrd6oqC4WIsu7kLpeYBs8NIGAqFa/JqnxJDrS/NmSBMH9BxshDe+Hj0gyXB97ADe
         bBD3bb1gowCmB/EV4KQ1FVYeKtVRQErjWohyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780909905; x=1781514705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxKtvDwsFmlBq+8ZwoIuweomQQeZ8mvWlwV7JGjQD5k=;
        b=HIjOURvfqgBJAkc4RuRAaEU+lAPGpz43c0CtXQ74XQgVESjHC577YL1rEwReN/8yJz
         4GEl1+RjhCiMUzOVMF8IvASr/uPimeqyw/rTxiYWbs3wbRNrwVVhA/2Izt2wtPvG/VGa
         JPC1lTeFyTIX9z1pcF01L2a/NBniwoK5AjpPdwlqFPGPvzObJM6TC+Yhz/NEJE04094B
         zaIq5zPf1tDvgE7hBYsIgh1EUqOYPrNs1YQqeaTaTB9NgmaiRFqMMcAt6zVpkjeNbw9w
         Gut4mKyV4RbhrNlbulURCu+BFRjwS8x3P48AOlzo24eZXPlsnVrylpNFPt/WauFp8Xax
         qHDw==
X-Gm-Message-State: AOJu0Yw8zELoH2qPJwoJVFMNarwDWKSfIUlWYn195cVn9ZkclQYEWM67
	UxLTdvzLcEUjrgcAQ20I2f5gi24X6hT9LsATGNW9DV5tNXO/nTs5Aa+J1PpJB47YUr4ZsPlGpwf
	TU8ap
X-Gm-Gg: Acq92OHFEsm7Fx3wXaUpbygOxZvp5kTnk1R6IYqIbGysjZo/VvsUWNSdLTzV0xyJprF
	rJ3L+kdayt1CYrcI/GRcAC4VS6CXj0wS92fzhxQtwtSvICugsk8JVI58foPD5sDzAwkP8c1E7z9
	HMsX9uWOh9yfvMaRfmBpa+T4mO4bCjJDA5OYe6ugUpekUt/rlSSkPJ6fQjVztTw/iQ1SRpT8LPZ
	VOXTN5Me66EypZ/ehGdbshTUvYcAxjmSlnM5DD90Nu/bCC0FKRc3+n0ziVq4zUna5ZpMQriFQ6x
	1yg2LjaOmynY/2mvBFcbzC79vDeHOiK3kavNi6nxVNjFNQv5YDOP4bW5gT7tIFPvTjOVhUVw46I
	kiXoZnQPx/TeVwrR0fPXtWW8j/VcV1yKJ8B6Zb7X7g7HCQHao2PgQwUR9dTHu15WB4G2b7QD187
	7y2D+WI6y4sqrAl5MmuoGoKEew06w5jmgod5rVLnvQTSWC3RttAz3QbQ==
X-Received: by 2002:a05:600c:34d2:b0:490:bbc4:76a6 with SMTP id 5b1f17b1804b1-490c25eea30mr257528325e9.21.1780909905556;
        Mon, 08 Jun 2026 02:11:45 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm408587215e9.8.2026.06.08.02.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:11:45 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] hog: Fix starting encryption on some BLE remotes
Date: Mon,  8 Jun 2026 11:11:40 +0200
Message-ID: <20260608091140.3606008-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When BLE remote doesn't reply with Insufficient Authentication Error
encryption is not started.

Good remote:
< ACL Data TX: Handle 64 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x0021 Type: HID Information (0x2a4a)
> ACL Data RX: Handle 64 flags 0x02 dlen 9
      ATT: Error Response (0x01) len 4
        Read Request (0x0a)
        Handle: 0x0000
        Error: Insufficient Authentication (0x05)
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
        Handle: 64 Address: xx:xx:xx:xx:xx:xx (OUI xx-xx-xx)
        Random number: ...
        Encrypted diversifier: ...
        Long term key: ...

Bad remote:
< ACL Data TX: Handle 64 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x001e Type: HID Information (0x2a4a)
> ACL Data RX: Handle 64 flags 0x02 dlen 9
      ATT: Read Response (0x0b) len 4
---
 profiles/input/hog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index f50a0f217..845087c9d 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -189,6 +189,9 @@ static int hog_accept(struct btd_service *service)
 		if (!bt_gatt_client_set_security(client,
 						BT_ATT_SECURITY_MEDIUM))
 			return -ECONNREFUSED;
+	} else if (auto_sec) {
+		bt_gatt_client_set_security(btd_device_get_gatt_client(device),
+				BT_ATT_SECURITY_MEDIUM);
 	}
 
 	/* TODO: Replace GAttrib with bt_gatt_client */
-- 
2.43.0

