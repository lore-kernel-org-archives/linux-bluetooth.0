Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239111;
	b=N7Kb6M/2WZu1wz3Dw/AhcRJQdJTpcaOIutkdGCjRxxIQOO1biECffGLGa7B9tYNueSdD
	 pgPDmEkZKyA0qEmqhCoTgdXBkGWlHTz93AIUdh414Wi2vbPrZQNX94KXTxB36mOQ/oq74
	 khZoI7ac7pa/fr6SWrZsKssvpTvsSmD7Zpqb+4ESND4EjHHuMiqLceHQSX9mTBB3FV28U
	 jJdOCruqCTVUGO0SwaJYu9ctKXdIdRypcxUT3FneRhdwXwmCcm6iCdo41BfM+Mz+RxFox
	 8ayHHTJHHzih9L4Fkn5IQR+yMtOwYyYYX2KQzLVp1ptRHPojY/Qqw0V1tGWN+6iPK9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p6GpstJKGdUSihOi0IVinZjGy6xPwWTbwsHkjyuEDhI=;
	b=AKPXF78swftjCceODG5rOMuVFoiGVVJUvjwkNh2sDNGugqaY08Zhm/e+adhjD5y/zqxB
	 9bo5GPBBKBV8Dh3PVi1fogfmPM9yNWZ6t5TVEK014wG+k4T+3TmT31zPwAlgKpLK9CMfD
	 qXWqBz2Y/z6VYvFMhvkq+Tv6fuSqgE6+3os7H2YGZB4MYzgyvlSFChc45Lw8FBExhzrWL
	 Agukgy8qxxHaZuvwA7ep6GL+AasMCCIV/tAaVCE3LRkEG3UE/vSUeAbTUbWal5L0FymTj
	 nREmoTHZ0OjiWeyplMFl3zxo64MV+k9sMGiwqoPabLKGCLJCbo8cR0L/TKcU3X3Kxcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lg2ib6UE;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D47B606EEAF
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D47B606EEAF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lg2ib6UE
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7a6e560f580so705897137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239110; x=1794843910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p6GpstJKGdUSihOi0IVinZjGy6xPwWTbwsHkjyuEDhI=;
        b=Lg2ib6UEqzA+FlaxufCwa+AURdQ8IzM5J53FAuqcwyMucOVOfucjRJaG98WtfEaWzI
         nab0thfwntL7G0jbuAhA9x4rPdJir2sdp174sdlbcKylDJldoF0hsUeZ97kCzddDqvqo
         DJOj4q2G1JGXFykAD/1rCs8CR6JIE2bMfxtFdYUjI/yJpQHaOjHbB6sayJWn4vn8XNKl
         ii3AdQRCNgArsDOXCVNlEqW5lTt6NtyTq2Pwfqu8S9YzCoFQHgVOR+cBaYw2wy9z/YSs
         65ywYnxTDDfCjD5PFP4J277rRxVxkEgFGHAUEXtc5MOEDOHop4+uGXjMFyx2WoEh+FTn
         StGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239110; x=1794843910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=p6GpstJKGdUSihOi0IVinZjGy6xPwWTbwsHkjyuEDhI=;
        b=LrHmyEaxLie6wGdOItamR9qLmhE/ryttoKdBDM5N6hkSwAqLuqQSK5WDiCBIqmT/11
         ut5aW6EVzJEvF50fZ3C2aj/NETvQrSfkLdcn5NiK3lAxLJ9OLzNaD8Zao8Fg7gs3ille
         zbLw6MzWyXqaH1yUWUp3QFuBZXizgnSFETTuhZBOJ0iKiRMvZ+5+c7Qa0O7CviWZZMp1
         JFYdRUWaTDy7aK29L0UFxVezUPMzJj9fFX6UmTiPOI6HTPxJSJWs8HVexeb6OmmSzYZh
         i2yT0VDRzjGtm4mA4BCFb49TvOPEQmfK3KU1hbqXXTPytjaHKHoVs/5jjIXuVDxaeOg3
         4dFg==
X-Gm-Message-State: APuU4Z97iJZZCyPKj9Cqnl9IrRYBS/53eWzseVQjipolCiHtn6Sk7nlq
	NcFGtL7ne0o3sgKAPFNBFyRo76COZaDb8vp4tJw/Gmc7/1PIjhCrIbDyGj+rhA==
X-Gm-Gg: AYBFou3FM4DhqO3sUhSHfC0JAZ8OoIF1MdBbAdaw+L5kyu+KOwKC1U/ijSE15q/teyi
	3UjRKdC5nDQlWlbZ1SGR6KaKEfYzeydFGkH9W//H2ZqKsUxi8R2EYjIV2tiXS8fxKrpFxodYV2X
	rsmXR6zxE0SVVnidyUs+yKT0zCNOlbWp6uBWjCC4iUp36+Y9hk8VZ8dnl7N7hScE1gh+JqBhKmu
	SOhV1WSTzQBJLHUPgJ1w4uitf2juLbHGHh4PrJlu/E022Hqd4pxhFWq+Nn0wA0ly7gUbqi1+ufk
	nrGQxoOFuhfmIGQOXo6lJQ5XPsxlUaZKhMEerYwz77rIHvoD2ynSLZUQo2NBcQM2MRLNJ3MObQK
	V1G8GA+XQDtotGahsRRSnxg0vFvcgoLh72IQ/h/S7ZpsauLkjVUien9s/5DlS9DSZMIxBlWwzWs
	zm8dnXZkt748DYJu8k+yOPKUsWRCOb0hd0OZ9eBD1ZvN99+FiqeuXkFlUbaB1zDjmlOZt9d9jRJ
	DhFgiynsYmwMJfcEehQTxkW3j3hCDqCk7WgSNgrOeuta0OWZsbWVVucRE6w2LS6i+6OhpYytskm
	8Q6n9tm++a4dn5/zfxYOAoJB0R3O3Kj3ATB9MhOm5f6u3bNSdIXwyszSl7lrv0IUOKiXbrcYMBP
	XHQTvgi1p8pFy9HPZWqU+qZLcAdwvnsvIx/U3r8zkjOZdorKK/9woCR3py9bknpPPF+lqNglwyG
	rWzcE=
X-Received: by 2002:a05:6102:644e:b0:7b3:4199:2dd4 with SMTP id ada2fe7eead31-7d2db102581mr1589321137.20.1794239110252;
        Mon, 09 Nov 2026 07:45:10 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a60a83sm4097474241.10.2026.11.09.07.45.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:09 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 07/10] shared/gatt-server: Fix double response on prepare write failure
Date: Mon,  9 Nov 2026 10:44:58 -0500
Message-ID: <20261109154501.1362649-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109154501.1362649-1-luiz.dentz@gmail.com>
References: <20261109154501.1362649-1-luiz.dentz@gmail.com>
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

When storing the prepared data fails, prep_write_complete_cb sent an
error response and then also the Prepare Write Response. The error
response also used the response opcode instead of the request opcode.

Send only the error response, with the request opcode.

Fixes: 1ebfc68f ("shared/gatt-server: Request authorization for prepare writes")
Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/gatt-server.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index b63745c4df2e..4a6bdb4677ab 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1310,10 +1310,15 @@ static void prep_write_complete_cb(struct gatt_db_attribute *attr, int err,
 	}
 
 	if (!store_prep_data(pwcd->server, handle, offset, iov.iov_len,
-							iov.iov_base))
-		bt_att_chan_send_error_rsp(pwcd->chan, BT_ATT_OP_PREP_WRITE_RSP,
+							iov.iov_base)) {
+		bt_att_chan_send_error_rsp(pwcd->chan, BT_ATT_OP_PREP_WRITE_REQ,
 					handle,
 					BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
+		free(pwcd->pdu);
+		free(pwcd);
+
+		return;
+	}
 
 	bt_att_chan_send_rsp(pwcd->chan, BT_ATT_OP_PREP_WRITE_RSP, pwcd->pdu,
 								pwcd->length);
-- 
2.56.0

