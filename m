Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC74357A37
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770841707; cv=none; b=CAv+s6MLC2bkGSnJxWA8ifffr0jyYTFu4Rd51YSJ8o1sO1fIPqZfv0qiItP5HkwgzEkdzgedix7JkNSYEruI8Scu0vAxsgcCnJl9dZN/ahEsaf3KlgSjhcLz7MCMsN3f47em2fT+YtdR0X529T6R5bAlYcAXfi9ujxulCySOQsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770841707; c=relaxed/simple;
	bh=Coi3us+ot8jIgSrwzRNCYjVRlizbUxJCdXKIs3gTSYI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=esE48Z+MaCiBlUcSQEyR+yZEBat6Nyzy0I15SqT+Zu9Pl3s59TZpY1tQIYgqha6VlS1AKwulOqxK553RrMYr52HtykHZw6Aq2hBY9jfBIwkxfULP8mM/I3iXNB4RO2s4D2RwifmB6GiLM+1eM0M+vJFzazDbKcB/rQ4IJCOYRTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGyedfel; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGyedfel"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5fae038b5fcso688460137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 12:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770841704; x=1771446504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQo/E/5/6CtQcIochehI+EyXSCmTJChU/KCOKiFab8Y=;
        b=RGyedfelUXuENyoJqUQbBhdEE3KUCoa7YoaxFjr9zw53m1SmLqqxPhWuLCBaYKJpas
         GpsRBI9JzzSw1hrd0ra/YlHIi0AJHG97SvniclODIc6N5CftB/LwbhiL5rbwtkwrr09A
         vX8f+gAJMotFHiZe0BGw6Ea3ZxssenMlze5+D5SjsoDn/OrCD93PNykIUqEInCBWTmwn
         m5uIfPPFkbO6p10DjFnjsE+X5oYxlHhxLNtUUlinVThby71CZw5ggN6YfsD0qhOiomaI
         Tj6H8oM+0if5Ls+doazhSXL098fcUj1FoE07AUZhdEb3Ga4uB+AzEiSB1/Ljd077HZg/
         tHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770841704; x=1771446504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQo/E/5/6CtQcIochehI+EyXSCmTJChU/KCOKiFab8Y=;
        b=XJhwDsZF9QfzmfcVKEu6OzFJ5RgyLVVN4LQLXqU+mTdnsVgzWFg3ewQ1UqRkI739iJ
         dj1fgIud3CAkJrqlnYYZyyupTizsJDs6dEJDjlcREfYXeDVtMTmUaMx6+xigi8hMCeKT
         itfRmuUXX1R3ZmLOR22GLMPhlRTErjKLzgMr9odWbIkv4pVS/MU1PtRKiqoE1mtmpY9H
         8qQLf/biIIQ04x8qmEK/syE0Ai3MMUmBOvn+o5GLKw5ML52jtGVmo++pNQOjPrRYEcgp
         MVH8NeK+36Tz4w4msUXLFsCRLV9+NEvgyW7vKjzqFZ6dWLsYeXBGkz1fAxpYtA61H43o
         x9CA==
X-Gm-Message-State: AOJu0YwYmNoJCfVQWXQI4LWZl/rijP47/Qqpf/ewzRDMYHIxbOe4UQmQ
	MmpjorcYIz0lIUf7XnDMz8hoxYYo5VwEMfrdA6BhPdzCuRkCKtGyMD1u2njT1hLfPZg=
X-Gm-Gg: AZuq6aJw8G70i2DNkBB+TitHLkZorw6m27Jexa2YTjMqVLKlyJndO47MUQF/OyvqdcC
	HeKO+p1QzhQgmbNTJWtIQF4rQzPHBTbRQLvXzYSrr3shHdpcwQrpLjYCA/oDzal92D0UaMaBl0F
	TU893ruPJ6tDTwhjzLztdUMtxgT4F3dhfOdjBuQNTzdi4TQQsRlxsRM9jHaeZPJdxelANVq9lYx
	DDIF2/K4rNVofox8N1QXD9lw7ws+iZ7RCuqmuEqJnwbe08kmcFDXSNBdXHqFK969vJhiFIFv+w+
	6pl6xxbeQx2RZIagroQqDoljtbZUcqZgxOYPn+IYwAS4TBsFnEuyTzwDemPjya+WhPlZpqLrnKv
	Cc/qKXTZnMndxIT4iZ6ddCGheD631gsP5mfXBrreFkqaUfRJ7jWjkFWgVaYwbEutR3yaYDz2CI+
	xqnbMgfdGqVTg3sSlKna/TdPwFtUjtYNuFJpsgE0mK3AiJ9bR76IZqNE32aCr43lw7ml9HHPB40
	JZbOOSUzZuYCN5Qow==
X-Received: by 2002:a05:6102:3047:b0:5fc:2b19:f7d9 with SMTP id ada2fe7eead31-5fdfbb9faf2mr220577137.29.1770841704537;
        Wed, 11 Feb 2026 12:28:24 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5fde87fc73esm1056067137.1.2026.02.11.12.28.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 12:28:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix response to L2CAP_ECRED_CONN_REQ
Date: Wed, 11 Feb 2026 15:28:15 -0500
Message-ID: <20260211202815.1464211-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Similar to 03dba9cea72f ("Bluetooth: L2CAP: Fix not responding with
L2CAP_CR_LE_ENCRYPTION") the result code L2CAP_CR_LE_ENCRYPTION shall
be used when BT_SECURITY_MEDIUM is set since that means security mode 2
which mean it doesn't require authentication which results in
qualification test L2CAP/ECFC/BV-32-C failing.

Link: https://github.com/bluez/bluez/issues/1871
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 390d25909104..9452c6179acb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5112,7 +5112,8 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 	if (!smp_sufficient_security(conn->hcon, pchan->sec_level,
 				     SMP_ALLOW_STK)) {
-		result = L2CAP_CR_LE_AUTHENTICATION;
+		result = pchan->sec_level == BT_SECURITY_MEDIUM ?
+			L2CAP_CR_LE_ENCRYPTION : L2CAP_CR_LE_AUTHENTICATION;
 		goto unlock;
 	}
 
-- 
2.52.0

