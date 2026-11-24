Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531614;
	b=bgkepxUkOx41zQvxZnQMAEOupon/LbDCOnm5+tmxh5Qd6d1Gx9nNApXUfq6T4p2i/5GG
	 EHJVz4wVe0WvN/WAsGGqKKXyYW0esHE40SVXkTkjB2dtlD1MXoniphiR+kLqF0JdmZU2Z
	 vlPwW3vry9sFUOdO1DOKD7pFDDlALIy5LU9hK2u8CqHSIQNA/y67YxBii70UUQP1Tefkk
	 N7x1P2F0FDHh0wqswVzZckxglt9Ns4l8HJ3t5UwOzTpLOZU+yXiflWK2uizPevniXySP0
	 dvAXl2Pjig6JpiLUytNgnZTrY9Ru9jy3Rls4J1znhkzIby/s2HYp0E6cc0mXsBkE8kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0mAJQG8ulHT90AuRb4hTHoYK+0v5iUp9TI0hCYb+ozQ=;
	b=DkhMvkEDQds07iO6TNe3/vBmWfltFbMnrHBzoOfjmpFbA6KmSiJbBI79aQ8qMU2LpnSE
	 FMmbch7j9JXfC7w4sM2ihFLuDLVyUrg7T3Sm1g4hf8oAxD7AL+BZmtxwXxKI1pmkVQ7Rj
	 TbLAQsc7WZm3ZNBlPiabbo+WRxjAazpffLZOLvjVlvcgK2vd89skh0AjYE4IIwzrkqJni
	 BqDBimWNSE4IPwfmZrCnFhcomo0gr3Q9piEQYwFjNHM9rve798xOttqA3u9CptLg7VenR
	 /vqX0pKUG8pLPRIWljci6jUGrov8xMYtIQYWT31b0pIL5A/VNGrcL36kQyFto6ThuyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=YpjSlduN;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA33606A33C
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFA33606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=YpjSlduN
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb61185057so30253435e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795531612; x=1796136412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0mAJQG8ulHT90AuRb4hTHoYK+0v5iUp9TI0hCYb+ozQ=;
        b=YpjSlduNP0BCI1csSWGLxsXCep8cQaUdBnyJxMCEXfP9BaV1pW0vaxPUEszsY6FxAx
         g1SuwHSYVzzZlgildW++4E/EzJG8Mxm5CgftK1fLsn6WymfKny0swy5hDCPc1uNONUxK
         xXnVki69je4cy0BIQyBBWtG8mOj3sruW8yGHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531612; x=1796136412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0mAJQG8ulHT90AuRb4hTHoYK+0v5iUp9TI0hCYb+ozQ=;
        b=C4KEOoGt2KSuSh9JYs9qRWAVw17tgszKnko9NpL3IaIdTkRvmioT2OBcDX8lD6YEK1
         xllA9h18nYNq7ulHi7MZvbsnBajBAgz2bKgMN/KqnElzM7cNNRsb6yKuTYUGGG4fb9tU
         SHRoysIN8KCEEIwadCiPclEPQFv8rmKbzyR/TuR+o/XmTFr2mZX4QfM1rKdaQBzrDugN
         EJkBciULtc85mJWyYx7qZm/ZJTvi7xkzz9OaBhBmUoFKNhNJKCpPvHGETqiWn4hmTMmo
         2D2lPEe+C1xgXZSIjL7273PSyHfGLGuaVEF8iowaMQauNnpOMW2+aFvt5AG+l/16hXFI
         erPA==
X-Gm-Message-State: APuU4Z+d0li6NtDOKF4MFdxwjCYpHHqt4EJKJrg2yHxXVJ/TFasjw3Ei
	B5GbkkMC1EHToX7oM82FVMgmW88j6qLVXNr+4mLTFoFJm1p/YoH0pNoaH8UevoDoRlCb2VxR7+Q
	4VFTQ
X-Gm-Gg: AZFdTZeMmuXmpeYj4BlYtco9c9bAQ7uF5QS3Gr5cEM9191iet8C6WUrdMXhrzGyuK15
	KKw03bIHF9oyxFNAf6oRSCKiVN4chtrAPZjAm5DAoBXKBNE3z4K7De6F8eviz846aSuyz5/SIWM
	nZAtZArCkNUXbl6NDj0tllq5rZyBXtJLpJjZ5bETek2ey7OCiIisKgb44d4CudLKtJQaH6ngK/Q
	KipsE5oI81eAftqy8uUMzMX2gf6R4uDaCY6nCjI7vHqQJJNouuogPkbB28Cb1uP0Y8sUfqnhhHl
	8cwCxuQPk8aXs91DQV99m0xxasCiXZZpvR9JSzMpqGfBFChstsjinhcF8kje/yptIuPJsPUpFjf
	e/XiN8IPdtzpEDL2m9fFYY+xKvTno719payHRbjOAypLWsGVDx1hfJUWA2veepE74wdnpbhcpcb
	TWMd9Gf/Q8BCvka6ma9QHNPCT66LDjCtn/NY6NmcwExr7JYI87ACSH+SkT6ewu2hv9MT+QZbuXT
	ETahtC3NzgiFDD4f82KV/F0kh2liDKLhsmjOsUpqV0b+CWO/zHaAjKGlziPWXxqULPptBDzrOMW
	Q4kMLT/KKT+4T56+yxLDYMnIbq1nQkQHoPgWTu3XliPh6fdT5w==
X-Received: by 2002:a05:600c:a51:b0:4bb:5f43:23bb with SMTP id 5b1f17b1804b1-4bb88828173mr288131755e9.33.1795531612170;
        Tue, 24 Nov 2026 06:46:52 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm29891561f8f.11.2026.11.24.06.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:46:51 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 5/8] gatt-client: Don't connect EATT on an ATT bearer over BR/EDR
Date: Tue, 24 Nov 2026 15:46:39 +0100
Message-ID: <20261124144642.298366-6-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
References: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
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

With Channels set above 1, btd_gatt_client_eatt_connect() connects the
EATT channels to the device's LE address also when ATT runs over BR/EDR:

  EATT bt_io_connect(<addr>): connect to <addr>: Invalid argument (22)

Only connect EATT channels next to an ATT bearer over LE.

Fixes: 45219190617b ("gatt: Enable EATT bearer support")
Assisted-by: Claude:claude-opus-5-5
---
 src/gatt-client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 2d58ee2e5..449f85fc4 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -2361,6 +2361,10 @@ void btd_gatt_client_eatt_connect(struct btd_gatt_client *client)
 	if (bt_att_get_channels(att) == btd_opts.gatt_channels)
 		return;
 
+	/* EATT channels are connected over LE only */
+	if (bt_att_get_link_type(att) == BT_ATT_BREDR)
+		return;
+
 	ba2str(device_get_address(dev), addr);
 
 	for (i = bt_att_get_channels(att); i < btd_opts.gatt_channels; i++) {
-- 
2.43.0

