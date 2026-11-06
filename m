Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990038;
	b=kjAISIFjEm7JrqB1x9kiSZTVtQdKxLLHfe0/wdDg5JZNE08SDWh0SnI2bQAvr2AXTged
	 UAyXF7QWwqS2r9tnEiaBOMET9z7qisHnRVRPA3ntiPydvPXM+uGRYQrsT4yVxJkKDCBiQ
	 qLzxLDaXqkgIsdK0x9E837yWSjW1hXXxAW6rEDiHAlyipIe4yEp30oEpt54yKIYwljONF
	 hSUkb5Sdl51Rc9xoMqC26oWq1MywSvH3WCxPTWcbmSNViu5xwP7RPAv/H+fPAKZwUjVY/
	 2QHXLidhayismTt24OUi8nyOyfnczRAC1ZG3K3yrXIKn6kx1p9swQCcM62bhRxTnXWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QINQTLeTOiSeTKqoQRZKvI3jjZvMtzvJvNxdUETuiQ4=;
	b=3aM7DV1nniQ9GGqSYxapbGb7eWkxLnWefDtP7VoodRv9vndKfqqsfZyoVUO8ziAzm2Bp
	 k8O0U69OGyFtiaHHM1BCl/DXLIWg8y7vH7g6iez1S3Kjf3j3rvi1fzynlOpkejUJX6lF/
	 Q2h570eVksKcUtahdGzc9KC0qJ3M8Y6nMr0YhcjgHmBc0M5SAH6IYLg3OlrsMS0q0R4Xp
	 tCEs2gQWjNtY+tKqbWQdcq2EJMJn/dV3BYmwQMbJ6l+wu7jID4rOJPEWwt9WZy9fRCU1q
	 +ZgeW5TnNPuV4fs6alDY2uR9ke+GdVVPmvYhFX/tCVUIsy7GQ+8IlSA45o9LWHMNk+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DawpnZEC;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A403606A338
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A403606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DawpnZEC
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so721995e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990037; x=1794594837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QINQTLeTOiSeTKqoQRZKvI3jjZvMtzvJvNxdUETuiQ4=;
        b=DawpnZEC9rKh4opjHQCXGZ+2ABo8AteCieKqsCaQs1sPRoOIs0Uj5np3r7kTdxD8vf
         hd4iVcgl8d9nHCuqM7Q7mT8D3DjzLE6MVpXXYPmME/2IZzI0LtUm14bWvW2gFAWRRHoU
         TYosmvKhNSW4lsWJrUa5ZipUFOG0pSyUcQS0cqUZkM9rh8CdbvYAXPGBKTxaHyacGmki
         Bzv+yp1PJVoWNLwqas6vZVQTYNiAjn/g5j3L2gOlt/6SVJLkQJPFrPWCH7CWIKi8aU6O
         QShaBi1463cIX/RLtsVfxWAg2t6Qipddz0q+bel8ahlYEFB2mYHvyxFeA6JdYUJHr/bj
         jTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990037; x=1794594837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QINQTLeTOiSeTKqoQRZKvI3jjZvMtzvJvNxdUETuiQ4=;
        b=d54pwNcbPCaMPMivusrWQdQndvyzDbBHLPrQBWCefKhE5N4Nw948lXO2y03c+XsBl2
         hxNj8QT6tqGJ/VyI5pBn51+5j9aMiCKylxCDiQ8DWUATiknG/KpLaycswxYhUt7UWHZz
         weK05zoRUnVa1RxEyJg8cvYqmJvKlUfM/9jwfk+bKq/zaq3AaUaQ59G2AfzSyhsO8l6/
         DkuYB1VQl82DIILoU1C6pFG+odTF4Nx3eIuvTeGOvBK5xsOmCdg49oSLw/GUG6xx+vbO
         dVXzIH00f+FL4u2o21vIrRN7/k7WmcoPM1qacA1bzGKDeUub4sfPrCe89BYstVXypDTJ
         aWIw==
X-Gm-Message-State: APuU4Z85n2o9ImtwcDUfb8t2g9ByUYKJFrm4UlDwiIsmo4t0kPn/dpWP
	aL+a5cPXa/nttD9+oNevW9r/lv0AHldhHPLSPzdFHWorSbd8qzH2IKr5MlvTpQ==
X-Gm-Gg: AYBFou2+7cskN2jUonxx2HV3hZWGnfO9XDDLW62mMqDvBb2YWdp1D3FF6c+PI8uqOTb
	gHbFABpjKqmN7qVfSSOeIkyPPd55xd816WDUaFH/H42dGtGv5lBWTO2LU5tZK4huID2t0GoFC9Z
	fQHzSc70Wdf6dAwpZx3+C/cM5LcBE8lHTtrFcSUgoa+f1H3lf7qNAQdFCvbRH3Xf5wOcaV052kG
	3oA2f7LCAp3IjSbRFomw6urF3nBgkciiPwrycY05lW9sZVJ/Rxy2qCecryljr5p/7XgBAsUbPrK
	rSgAR+t9Qjsk9yjpUn8Cfmok/eUdnpiWetWGFyFvVQXPXEX1636hygLfuEZ1X/0LwDFL0YODhD8
	Wiu2gbqFCtvV/QuUhCqJnYPN8sPq8wTeOwMoKZiriJh8Rqwm5tpp/FkF52zd9zNYb4lLe1MPA06
	Kw3SXfqIKEV75OwDNuxB9+zttL96TkqgEihwfppWOqCNgfZCqa4yZ/fiBhQOzrouB/BnoIoSBg4
	Vpx53Ehbwi0I4u9qmwGev37EszjuBp07tAjy3Xem6DlUlLfBTf+fi/flDVaG4bPVOnZeRtJ8jHB
	bjWafxuc5PkKFugvTTusZWiGyK8+NCNmg8ymDmITdJEuj9/GLXaBx4pt6A5On1Lx8PgDbWm8xEH
	AeqD01Np5Afc6pf71q104eo0WTnsFt5WTvA7NxZAb2FuSYioBDQPCPIBtD9LN8HskMIZjvjK+QO
	NFtzY=
X-Received: by 2002:a05:6122:1353:b0:5c9:ae70:e784 with SMTP id 71dfb90a1353d-5ecc42dde86mr1794054e0c.3.1793990037409;
        Fri, 06 Nov 2026 10:33:57 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6774sm1910173e0c.3.2026.11.06.10.33.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:33:57 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 7/8] shared/gatt-client: Check value lengths before reading them
Date: Fri,  6 Nov 2026 13:33:49 -0500
Message-ID: <20261106183350.3155282-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106183350.3155282-1-luiz.dentz@gmail.com>
References: <20261106183350.3155282-1-luiz.dentz@gmail.com>
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

Check the iterator result when reading the Database Hash and avoid
reading the Extended Properties value when the response is empty.

Fixes: 0f67d5e2f19f ("shared/gatt-client: Read database hash if available")
Fixes: 6b3f0f3ab935 ("gatt-client: Read extended props on service discovery")
Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/gatt-client.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 4a8bdfc441d4..a923699b74bb 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -887,7 +887,8 @@ static void ext_prop_read_cb(bool success, uint8_t att_ecode,
 	if (!success)
 		goto done;
 
-	DBG(client, "Ext. prop value: 0x%04x", (uint16_t)value[0]);
+	DBG(client, "Ext. prop value: 0x%04x",
+				length ? (uint16_t)value[0] : 0);
 
 	desc_attr = queue_pop_head(op->ext_prop_desc);
 	if (!desc_attr)
@@ -1475,8 +1476,10 @@ static void db_hash_read_cb(bool success, uint8_t att_ecode,
 	if (!success)
 		goto discover;
 
-	bt_gatt_iter_init(&iter, result);
-	bt_gatt_iter_next_read_by_type(&iter, &handle, &len, &value);
+	if (!bt_gatt_iter_init(&iter, result) ||
+			!bt_gatt_iter_next_read_by_type(&iter, &handle,
+							&len, &value))
+		goto discover;
 
 	DBG(client, "DB Hash found: handle 0x%04x length 0x%04x",
 							handle, len);
-- 
2.56.0

