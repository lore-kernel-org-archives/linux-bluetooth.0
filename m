Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EDD2E22BA
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510463; cv=none; b=VaapdCJq7PZl0CYZFe8mMsYpd/Ol6LxR6QadVpH49wQw4T9wTWy4Qvxo+ZsstVYg8PBK5rvHfAlYKdLEWgIK1z5g4sl+LdpOVRYyURGe+LUQLOo5eHjddohTpBrxzheaN6N/OS3oOee5ZyQrWK7/mgSL7KZSSVGcN+a0Wllq/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510463; c=relaxed/simple;
	bh=oAR1URnNPH2eS2RtIFe4En7Jbii/zW1IdRoqDtLGjco=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZ1S2Ml1VGNpwmnXeAw+8ooJDu3So7cYBRV+nKqD2LNzWiHkHV+Ri4xYtiz/SrHDB6XpimYDZsPv8Da5EC+HmI+wsG/TxRVUMmNRTR0PFuywjEV1A1iXDb6clG96nRhm/3oN5NARPqurXwA5qVmbIBAQSZoqXWcTcNPsT7ERR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpnQYFWJ; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpnQYFWJ"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5636274b338so1120075e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 12:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768510461; x=1769115261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEtkl6IBgGOcg/HNydCp7KRkS0Gnvn1l7q8KFElfSwQ=;
        b=LpnQYFWJffy9rSQb+GKMvK6S8Pvc/8ah/NAZTykccul/gcDngeYRzk/huGVtCYFZ1o
         vuOT82GU+uehEaOR8ItQ60DOrO8DQAzy+iklPFqVmz3G5caJ53A14JUqtc46+nT/XSS4
         XRNkFfKAh0LjldxikeNHEeKC1T725b7vnh5YP8NAxx/2QlyYmABMLh2ZHlezo9kQr7Kq
         VojLY0ZzO1rgMODcPFNiOZhzw/i8bI6IY0xoIaq7UQhf0oPG8VmxKow22NSEKcR0xAX2
         DluoAlqZW9UskxVz5Xp2Z3Plih1gbYVaUMPf4ggdZzGh39w7OMKxFs16RKYyMMli84b1
         lDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768510461; x=1769115261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KEtkl6IBgGOcg/HNydCp7KRkS0Gnvn1l7q8KFElfSwQ=;
        b=MrNcEjI8MP5/3/DGQoXiwxa4I4OHxiDrkZeSH4TBXq3jzgLEHTagE5gmGw2w9Z2whl
         myK4HLnJ4RKQQB4gJLYsoI77v6tSxFPeiheZiMgGxdXGHicKFWVCkY/qSzBCw+9R84Uy
         7XPUow7RznGAwANff116024glO6BTesr3PRX5Cptnp48RguTPXW6wzuacBjMH2kowHK/
         73nBMIWtyfIkvg+nqX2fFCIq6GTmDGIh+U61EhQznTX3OmyaLTYI6vB+QbyH7WQ36Udq
         ikCJGb3PjceIKeKVvKu1dPjz4nndMQ06yJWu+aoohQweVsExJSwW1EC+NeUP7EjeY1H1
         354g==
X-Gm-Message-State: AOJu0YxKy6q3VM5lNnGFP06GBeuSRJK5T6ypLPHEDtprMM3OnjkGsLBN
	WPjqm6FHzi4TFOK57grlB14ZVQOngadN5D2uWLAa5zpDx9dnkF3ZcRZqSvVncwQ6
X-Gm-Gg: AY/fxX4djqf6YRBc3mkeUJr+sk/kG4rsBlN2/04mNymhSMl35Dky+xroEz9NnJ0E5YQ
	l+0Fjols1qLPLnin+/egnq59o/9/l6cF6s/c4je9J78yRK1nWdcNW69fxjkfwy0ek48ttwdKq6J
	ETYWxuRhBpTrGTO2ZX6yZbB6KnEgAVZoxefs/6d//NbPdcMjtixnVgC6Q6HJy5F15o+caSVL6SF
	sNqltheX8qS+2lBMjbHJuKT71z6i02Q8ouPpCHOITYaMPHEJSNC6wsJlqAy/gHYo5MqjbvH7cJW
	i9jiCud6PEeHFmJ9YYP6IKq/g6pTNIZ6jGPfDfV2VoY8nx6aT/aHOMRkbH6VTTofH3Ules8Cy8S
	pOGKnOobIbOlBTAmQS0OM9HSVZNvV41Dn87gJDY+b8bflHoKHEs75NTVHwc1WyTQIgaKnPzJJGP
	qFUVDRFDhWKhZsQ/aBQbWU+REBfxBUMu6jPhVV332WQrf4Ut0lv6zg8IwXOjz4/zSrLf2kxEYlR
	fdyZnfy86achXH8
X-Received: by 2002:a05:6122:32c7:b0:55b:9bf6:da7d with SMTP id 71dfb90a1353d-563b630806amr355394e0c.2.1768510460981;
        Thu, 15 Jan 2026 12:54:20 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b6ffda3csm167159e0c.7.2026.01.15.12.54.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 12:54:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/6] advtest: Use bt_crypto_rsi to generate RSI
Date: Thu, 15 Jan 2026 15:54:04 -0500
Message-ID: <20260115205408.1554101-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115205408.1554101-1-luiz.dentz@gmail.com>
References: <20260115205408.1554101-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_crypto_rsi to generate a valid RSI.
---
 tools/advtest.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/tools/advtest.c b/tools/advtest.c
index 8df6923d2f2e..706b2503b74c 100644
--- a/tools/advtest.c
+++ b/tools/advtest.c
@@ -75,37 +75,13 @@ static size_t hex2bin(const char *hexstr, uint8_t *buf, size_t buflen)
 	return len;
 }
 
-static bool get_random_bytes(void *buf, size_t num_bytes)
-{
-	ssize_t len;
-	int fd;
-
-	fd = open("/dev/urandom", O_RDONLY);
-	if (fd < 0)
-		return false;
-
-	len = read(fd, buf, num_bytes);
-
-	close(fd);
-
-	if (len < 0)
-		return false;
-
-	return true;
-}
-
 static void generate_rsi(char *val)
 {
-	uint8_t sirk[16], hash[3];
+	uint8_t sirk[16];
 	uint8_t  rsi[6] = {0};
 
 	hex2bin(val, sirk, sizeof(sirk));
 
-	get_random_bytes(&rsi[3], 3);
-
-	rsi[5] &= 0x3f; /* Clear 2 msb */
-	rsi[5] |= 0x40; /* Set 2nd msb */
-
 	crypto = bt_crypto_new();
 	if (!crypto) {
 		fprintf(stderr, "Failed to open crypto interface\n");
@@ -113,8 +89,7 @@ static void generate_rsi(char *val)
 		return;
 	}
 
-	bt_crypto_ah(crypto, sirk, rsi + 3, hash);
-	memcpy(rsi, hash, 3);
+	bt_crypto_rsi(crypto, sirk, rsi);
 
 	print_rpa(rsi);
 }
-- 
2.52.0

