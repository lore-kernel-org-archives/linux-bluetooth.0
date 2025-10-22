Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344C620ADD6
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156058; cv=none; b=F4V6nmuUzKa1qWn1U22bENnR4gmz8LJWHkZ/2N3VlmoQFdcj/BwpSEnhPAaq/Ae+VG86bY6JFZEE1qgygbz+KrhPkqqApewYWh7BbwQh2AbN1qsYz0KNxcO9gPLMAGUFxLKZf0WScfHc4AQURq7SXxfaKRos94qrudAIF1qVVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156058; c=relaxed/simple;
	bh=xBdxVqrEmso6MmGopgg38KKAkzGwEiJyUZAEQsS9Vig=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ri5BDTeIE862iBdbgiMbpn3E7zQs8VQutsTYsPQ0UhkjxJLtx36ZBLXipWTf10hxIg5hHYgYmbrrnDm9KbsZjXk9oINXxNn9MpzobWER/DvloiNDiQiFQBx0x/bc5z6hVfZgjkK0s4abCB+QLedsjL/KlyU5LTTWuSQ4vuqWYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU3SueRz; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU3SueRz"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5db1aa8c93eso726892137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761156055; x=1761760855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fBp0yEJeh/Kk2t5z0N7twi2GNHuXMKbFqDW/4zhYdMg=;
        b=dU3SueRzGa7RUdInq6dOLO9cdo6TNLBq7rwQVMVJC0JznDxFZvvMQt5Brb+rr2bCYS
         I+ZWJ1aQvigH1YgXaoNbeDoKMVcMWW+SYX/7eVKUp+qiCSTE6byoUFFruQmuhntYiMpe
         rzou1z51UK9mHYmYV35nuh9sHAHf3fboYDFuhJ2wGCMKQmSN5Om+0MfCAwoCgzJpzIbO
         9MKDvcCZ5q1nX6HGBpB86exrUBPGUsD5c/nIi2faWbzXM8mPH1QNfYWpDsCEJ6zugiNl
         SvMzpTQrakZKtiEzKdm/8DgreSHCQiAJ3FUjKxR5F8FyXCAj9F1YQbJ7MEAuAK3x3km7
         icrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761156055; x=1761760855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBp0yEJeh/Kk2t5z0N7twi2GNHuXMKbFqDW/4zhYdMg=;
        b=ujJ+TOdSAircnByk9D3SrzaHQrdOAmXshz3hL/hYyVoKmrbAnEhFmwpi4AAP14k8rW
         Og9mX/Yq1567+0gGXbhkGt0CT0jp4Pplymo1qhxndbhkO6NGIlkex1XyLpE+UwYS9cNA
         VKuqsSSE2LnvbjxZmRVhgDSxzGudk6dTmx8v0gCb8l3vnQdotXS3tkMbljqhHSA6hm0B
         Lhm7lIIqMb145mGYue676ZhfrTBPNXv/qZP54zsqiQKPPNkzmh+8XQveBH+MPdJdNXYV
         5UFdq2ggpUzLnY+Jdhv9+Ohuce4UOZpUj0sRP7MCk4GkAhCR2aahcT+zEAqvMU5xGEn4
         o4Xw==
X-Gm-Message-State: AOJu0Yyp+v/wHkj3m+t0kl6V9DR7Jn9ATO2vacBubmnLQVCOloHkSNPb
	L36BFik7N/C1VmDIPJOrdtKtb0iqTOzOanL0C+eTpbBfMrHlMeukxdX1hBnlHA==
X-Gm-Gg: ASbGnctUwEe4wvyOkmJHIqlfd2b91eDPCIuD2CWyoVGTJxKRjH2OdmbM5ZC7THM2HwF
	OxibEIaHomEMxcUCZygqeQ+RtXZCsY+AzRJfbuvsYmFyr5FEkO5FasOvtAnPmGlMkHzvMvwqU4w
	JhzBDuhRoyh3lZKnX78GskT7Qz9nQ94e6N0ww8NHwgEJ+051PAexxKMjj3ToamOe/UG6WOGj/+X
	wqpN82cbPOxlD0TZEOl1E3bIbANkuKP6yMQ4JpzZHxNf0GX+GosgORKPSG03aKI54KSwqBDksTs
	hdcC5R98uBkvoFwzYnTZYa3u80KJ5Uch7rpzVhd9ynWOIDN9RrGp0xL9ocNhlDm3XbVEIx0oS8m
	cV7zZuGwoKOR7GEuAAEelEPBhPLqvE8gGWxIHr2rNPA+f+pB6t/5aOdQ1y7+RAgIm70FzTshHh0
	KqaQgCu5YEWISwSg==
X-Google-Smtp-Source: AGHT+IHWJdJmeb7wei0axj7tpQW+kf3Da6fy/7LPfJnZkwODwR2lMQPAaWYEyo46REECWhr/UQWF6A==
X-Received: by 2002:a05:6102:5111:b0:5d5:f766:333e with SMTP id ada2fe7eead31-5d7dd5934demr5688680137.15.1761156055381;
        Wed, 22 Oct 2025 11:00:55 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d96c25dd39sm4973496137.10.2025.10.22.11.00.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 11:00:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Print data if LTV and data length don't match
Date: Wed, 22 Oct 2025 14:00:44 -0400
Message-ID: <20251022180044.1471032-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If data length and LTV don't match this should be made visible so
issues like the data coming as all zeros as bellow can be detected:

> HCI Event: LE Meta Event (0x3e) plen 50
      LE Periodic Advertising Report (0x0f)
        Sync handle: 64
        TX power: 127 dbm (0x7f)
        RSSI: -55 dBm (0xc9)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x2a

Versus:

> HCI Event: LE Meta Event (0x3e) plen 50
      LE Periodic Advertising Report (0x0f)
        Sync handle: 64
        TX power: 127 dbm (0x7f)
        RSSI: -55 dBm (0xc9)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x2a
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00                    ..........
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index dd808deaa79f..22708689fe03 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4133,7 +4133,7 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 		eir += field_len + 1;
 	}
 
-	if (len < eir_len && eir[0] != 0)
+	if (len < eir_len)
 		packet_hexdump(eir, eir_len - len);
 }
 
-- 
2.51.0

