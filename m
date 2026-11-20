Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156748;
	b=UWdhgxOyYQ1GHe/PW+QwhW7C8hzaZkFwY7+/Nl/3zo7rEf6L01wPU0WcPFaEMfXIGpw2
	 ovcJqkwT7x8NvkxttsTYxHlJwW6cVaklf26WBUkpNGfUISFLJv1l9vFiQ2MHOz/SVp3Tk
	 ehzMlNMP8v/k7BbdqoOLZgpSKDC3J0QGpmUh1eTBO8Lp5LlLyvsBcUOSWKnNOf6jazpx5
	 ZrZ5kK/zjKtQ2kiHp5u2BMrEr7MmAUOmrTKieV/7+FG8rISdeVUrTQGUT7O3HCbJGYAnQ
	 n1NVpz5bZsT+dKQ0xWZetblVYtB8YzheScg6fsFmMIU9ufJ+KWj6lmla3XKb3PVtKkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I6QpFhJ8Je6rVlNRUS7opVEAqE15P1CpkC0bahNO6eo=;
	b=rOxzkoHmcySZvjVs4aIQfkU0JgiSL/BqDBKrtrRgvQHuvDZpF1D6V8V1k8QjW0pBsxvC
	 bzTIQAtplK3uWtr0dbV44Kehzy2h062vP9G0lDo48XehfEUrznJC8efKTu+mM0TJBPt+l
	 y0VKFmC74bJRKwZMEFXAGWlpn+WETk+8E5Eh9s3QFu8o8RwSifc0bCfrmenkEjWJcvC1q
	 6eD2eQkOd7ZmOa6Kg5hHYecutyIJgysoDp+1WyeQvcruJVJJ+7dwtmMwelAL1Xzo/aBvy
	 uBh0D/JT9cAEiTk9+/byk3mCRv1nViB59V381UgSL3OEmFumczaNdCiUNR0YA/tJEMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5yLwqBi;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD0260A2606
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 06:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DD0260A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5yLwqBi
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48df3912dd2so8546f8f.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156745; x=1795761545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I6QpFhJ8Je6rVlNRUS7opVEAqE15P1CpkC0bahNO6eo=;
        b=Y5yLwqBizJ79p4vBr1/Zq6N1g83MtuID6+VPWnMrJSssFoDSlObJGLwnoUNC+OG6DC
         PAtTDTrBMLwmC/O2F6JsJij98LPIwdDjEs2zkZSzXLi3uWUi0UPLA1U53PlGpNjBBY0T
         F/Fv+Po+flZobt492TUEt8f3yd0+3mZICdyc5TuT0YboAX3M5y3KmPI+H5lIBSdCXKj9
         fXzn10WmaEc3FEgXOF2cK8QjTta0OH+A4C8I+wn19RRbM9Cs+ztsppYAt3KuH7UPn0dc
         VQhbfPedGYHxRcqVEtU7pr4eGAY11+eZMWB/6qT/pcJ51F+k3tPE/zHRyla8EB0GdvVV
         oDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156745; x=1795761545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I6QpFhJ8Je6rVlNRUS7opVEAqE15P1CpkC0bahNO6eo=;
        b=fdm807vOmDze8+yE/bTBgruUNOJvcN7/lXFJ8MTN2wkf+BmsLLLo1k2IBMxUfVk1gj
         dX8xkNakLpyLpM+oHWYI9PkmEXW5TzWXtMogrON4DcFD/xw4pVO4xC5j0zR5/5oxTi2+
         ovO9Lz70H2Qxdvu4D1Z/DFQeb/sds2zNvVgy0TUQdjqVoEykpkXiJ0mMxN2mArBPfhqV
         6W9Q0SzcOO5rCzPZqJdS2oPIKa9h1kh7jUAaDLL2v0p0ncWJi61tT9A7oIlkRdAQShRd
         IP/Lvl2gqgOFPndO0BGp0LlTk00YlZpQDIcvx/ETb6ZnImk6snKMHfKH8uchhQjSvjuW
         WMBw==
X-Gm-Message-State: APuU4Z9x2e5BCE+s8KSRSdwiOA2yLngUDLgbVvQMOyXVY/rOGjhaYPA/
	qqfUFq4xWuT4tZ1ngiYZ09cx8691wtLqL5NIwPk+3hY5c6SLSE7m0J0Uf4No39eR
X-Gm-Gg: AZFdTZdMBNQ1GycH9LT2IeQtI0F+eXxs2IVVx9wRyPFQ2BqD7yD46ulI6124cyhvHHf
	USpt9tzhpZDNQfUU6MYd+Wb1eKtqGWXGgsdNDMXmP+uAfdM5U4VU09F1LrPHqnEGyXFqR4rjTZ6
	ceJwBcDJ0d0DF7D47XTuBua33/fVuDkSJeFdmHcZR/EtvyqCnGqbJRqzn2LjfhkT7VxMDar9rHL
	FL/w3xJOUQehLk1C5BxMVgZ2t4chypQmive0anTy8u/FZ/4Ur7PAyr5x2LRpFiha7ttLdeCUv0o
	FeETV41gHe+vmRE4OfjErTGMt/GX4NsJ7qZftr8KUwPHGeLaMFebaJvjdzocQCMDEDSiBukMBQk
	SSayOxMtS6Dz2wWfrjtBTCJFf+hQ5Oa5/WJgrqlyGTf0/XoLhhs4PAqMIRcdHNPXU1nA06P95Lr
	sm6fWo0QkC8JlAy3QRdncf/4lm4NzJ+Tn/1KtdNIysF4c2dmH7iZ+qrORDuZdErU0ChTMrUOXNC
	nKCO5e+EX5w9AnKEzqjaYrrehW/cHrsU29UR6s+eE+6vN8ZlnfAxwG81rZ5ir7R+3N4BsS4s37s
	MSemw4vzdyydMg5Eub/4+SFy9PiWFL1vxoNiMdJ94AtlgGpScs392PsB
X-Received: by 2002:a5d:5f88:0:b0:4a3:45b4:f0cc with SMTP id ffacd0b85a97d-4abb253e271mr3367571f8f.3.1795156745426;
        Thu, 19 Nov 2026 22:39:05 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm3685607f8f.16.2026.11.19.22.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:39:05 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v4 05/10] monitor: Fix TX power and CTE Type of LE PA Report
Date: Fri, 20 Nov 2026 07:38:51 +0100
Message-ID: <20261120063856.16585-6-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120063856.16585-1-rolandschober1968@gmail.com>
References: <20261120063856.16585-1-rolandschober1968@gmail.com>
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

The LE Periodic Advertising Report decoder prints TX_Power 0x7f, which
means that the information is not available, as a power of 127 dBm. It
names CTE_Type 0x01 an AoA Constant Tone Extension, but 0x01 is the AoD
Constant Tone Extension with 1 us slots, and it pads the value with a
space:

        TX power: 127 dbm (0x7f)
        CTE Type: AoA Constant Tone Extension with 1us slots (0x 1)

Decode them as the specification defines them:

        TX power: not available (0x7f)
        CTE Type: AoD Constant Tone Extension with 1us slots (0x01)

Fixes: 5441a5b91a08 ("monitor: Decode LE Periodic Advertising Report Event")
Fixes: f1354119897a ("monitor: Update periodic sync commands.")
Assisted-by: Claude:claude-opus-5-5
---
 monitor/packet.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index da4e8aa98..034a1e82a 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13925,7 +13925,10 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 	const char *str;
 
 	print_field("Sync handle: %d", evt->handle);
-	print_power_level(evt->tx_power, NULL);
+	if (evt->tx_power == 127)
+		print_field("TX power: not available (0x7f)");
+	else
+		print_power_level(evt->tx_power, NULL);
 	if (evt->rssi == 127)
 		print_field("RSSI: not available (0x%2.2x)",
 						(uint8_t) evt->rssi);
@@ -13941,7 +13944,7 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 		str = "AoA Constant Tone Extension";
 		break;
 	case 0x01:
-		str = "AoA Constant Tone Extension with 1us slots";
+		str = "AoD Constant Tone Extension with 1us slots";
 		break;
 	case 0x02:
 		str = "AoD Constant Tone Extension with 2us slots";
@@ -13954,7 +13957,7 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 		break;
 	}
 
-	print_field("CTE Type: %s (0x%2x)", str, evt->cte_type);
+	print_field("CTE Type: %s (0x%2.2x)", str, evt->cte_type);
 
 	switch (evt->data_status) {
 	case 0x00:
-- 
2.47.3

