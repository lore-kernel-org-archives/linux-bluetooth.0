Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A01A9F96
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Sep 2026 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788637718; cv=none; b=IuqQJwLDEXPvsQ3F32RRpBvYdvhoW9qCOlGLlHWmR1bAP4NoPyYBmRaDRwgs6cjOxlIh7qg8JdW3w7N/RpZF1AQ7nr17y6dpl18I95lDBiPKc9xRGdmuEgu4D3Q16R1vWuGVP1RVb7HDpO3a+bqeExLYeq0Q5zhWpDdfi5hF8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788637718; c=relaxed/simple;
	bh=zZqRSdRVzBOcjcDUhtyUq1mpFZmKcLHBt8LfU9cEZio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXEyhr/0QCkyMiiRyRnre/c5nzUd8ylYWyvEk5VX6u2xacs+6oIi0Is2jz/io2fXyeMs4DoAds73fhgljzMCernbFYHqyfYjsAAH+w8ramtFaLb7ZomTSUb7kMEZLnroFpH11Ab4HvdTLDUUt6T4O7xP+MKDn+W392z4GspA77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcO3uWGw; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcO3uWGw"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5c2c46a428eso1837916e0c.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Sep 2026 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788637715; x=1789242515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AuWHZWx2knaUk2C1quRHTj7/UzJr/0Vfr5UpvPiZUWE=;
        b=NcO3uWGw7C/mkWfpRsqWuLZj59Kng4p59gUHWLnQskb9BCVfFP4AySLkMSrFkYb2+s
         1OHZth8tK8xX2p3/K9KkrjSp68CFKcnNOsLRE/gRUHIQiH2dpUO3FLcQYRG+qY0X1pDH
         ujHuJEIKM4Yc5uHJiJsO943+6U7EvHFhWgsSKVIP27vp+WDCw371ARP7EziMnoUY2zoX
         nrONJYDiSSeLWGI4y9+M96aCxh8Kf6RztRRqlQgpROlN69SwKwJhwMAy0pc62t/dAHA6
         d71/LjdeXw3qUqByPs4eaiNbot1SreeDgJkA9Pur9OdgoClxQNn26+4cc3BdKB3Ueb4e
         1ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788637715; x=1789242515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AuWHZWx2knaUk2C1quRHTj7/UzJr/0Vfr5UpvPiZUWE=;
        b=B137VDY5wqJhTzbmkZFKyaxj6cV5T2Ts1assk4YODuzOhf/i7PXlsJh86UOGVSTs04
         Wa3SD4SZWEYSjKtQWIU6xMefjWhe+r/49S4eNECIZb6Pyoa0N7eDQcn+b3CWk54N+j/i
         0dHsVVj9Wy3igQJFTZhqseBFr3B76lbGnxqUi8HmUj1JYMTd2PdnBXMC2sKTVn1JijsX
         ttSjnzdZYmk9DFcAyZiARmjthsrS+dscYFxw6zc4n9Q7f4O3PNEJkdPerd3mdUTrs6Wp
         uaVA/EAsEVXYXVe169l/guH/aqz3U5y4KaYD8cHinCT5YYQyl4jxcGPcTsWEJ4mxLJkX
         UGtA==
X-Forwarded-Encrypted: i=1; AKwUvBxzTjMEMtvISW3XyeD8u8Fvu0z1HDeVlhlbsrtTVwDuC0PTmKguUpjhbuge3a3B9eU1OSQf++XkGdyqy4C8GSM=@vger.kernel.org
X-Gm-Message-State: AFuF++lcgi5iOKgpcK6HVMn5JLeBC8LfmFwV4QzTMggsO2EKOFINSAJ3
	pwO/09ehnSXTX3JhhUsHemVre9RMwfHqroBDoEG4zfDA42Rqo24CMBsr
X-Gm-Gg: AYBFou11MQd6TI8H7l2FfPHF8A2Ad2aIRghh8GsqbkbElAlaBq+5+Uk352FO49cK7gq
	ryKxzX5nXHDGV3Tdc7/nEtOj106a0SZtNq9cST/WJ7UT39D7roK4ye2obuXttNB8dME60FH1yEJ
	if0QWiuB63bl0lOk6w7df3zn7GM0dNU+lhYZ8UcI1l6ORlnBqDelLn3aiaCwJ0YWDlfC1YepKjn
	47rxT4iMfML1roBRZ20joOgJ4ra8IC+2f3MkzypGSXe+hR9a8rnoldBEA2dhUoRkBBk1EguimJK
	T12+V8iKvUD/F8uwY4xabDEiF3RoNWJtySNT4pdS1EgQXajNtnZs1q59THO/jYKCgpDn4pvzILC
	bpkWe07xCXPAiwkkVHIFQutV5GIo7BA9+WVc79c8jdSs88OklUmdTyNtKEpb3gmgQbPnCJf+xNi
	4ZtN1EyX7P73oJHRUajIA086HvIqFZxWMWzq+9mNo1AHBwQCa254dQ8c5zGMzlY8Q=
X-Received: by 2002:a05:6123:22:b0:5c6:6c75:81c9 with SMTP id 71dfb90a1353d-5c7ed7ee91bmr5474604e0c.7.1788637715443;
        Sat, 05 Sep 2026 12:48:35 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ecac1033sm4678437e0c.18.2026.09.05.12.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 12:48:35 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] Bluetooth: bnep: linearize skb before sending
Date: Sat,  5 Sep 2026 15:47:25 -0400
Message-ID: <20260905194725.284347-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel_sendmsg expects contiguous data. Check the skb is linear
before building its kvec. Should be already linearized by the
stack, so this is defensive, but drops the dead block and the
FIXME.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/bluetooth/bnep/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 5a6a49885ab6..497eb1d2d6ee 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -457,13 +457,15 @@ static int bnep_tx_frame(struct bnep_session *s, struct sk_buff *skb)
 	}
 
 send:
+	if (skb_linearize(skb)) {
+		kfree_skb(skb);
+		return -ENOMEM;
+	}
+
 	iv[il++] = (struct kvec) { skb->data, skb->len };
 	len += skb->len;
 
-	/* FIXME: linearize skb */
-	{
-		len = kernel_sendmsg(sock, &s->msg, iv, il, len);
-	}
+	len = kernel_sendmsg(sock, &s->msg, iv, il, len);
 	kfree_skb(skb);
 
 	if (len > 0) {
-- 
2.51.0

