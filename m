Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072439;
	b=isiQTdhlh71Q2B6bwtn3rFSTtI/vpB/3APdU6gCUJ/ougG3qwzcZRrCvguJANC4ZmZUO
	 fOzky7CmqUZv2lYeOY3Xlz8rwJrABWkZ1wYIFPF//Z9V6010nj4WWMrBDcf4gxFcSJaPo
	 EQKpx3EhSmGOhObSXHuN8eBrk07rd7owPhinjFSPLmdV+bW+IiW0yEGXPKOhsqtTNMKaT
	 mR5bR+8X0LuUAudYewlahOTTs66E/e8/e1D990HlUd2fMHoNX8Byla1+sp+7OUcEdt1HL
	 e+mS8JIARe3Qm1lMAuxJHaLxBbHd+er4Fcvwd4nHkdaB41NeK5m3bHxRCIU+VML5tXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hZCctNQK3cN5qV2Hx2SOGwUfxpcb935adt9+raA2U5A=;
	b=OBcOIRsyb+EaRro4hZytMpe8e+Z6VyBV8N1ReSImJqtaxd5O677dL1L4bjW0xT1fiDhN
	 rHMEcoUyTXHPhl7jYr5o3JJ85IcMpsL+Tu0jM06zBWiVxj0+Vura+jI22vjr2l11TWwvV
	 S27tgip0yZQBBjNGER3aiKhet1K1jExj4FupQu9EUpx6o9AOMBnaHIn4xm2xCp7ZfaGsr
	 66ZjxaSXTzQBrJ4KBEm4lSHWFgdaqXXz3IuMbVWKWdB6jDUrQSa4CMvg/dxfhklpOBMKD
	 2kGMmhsiYTxQ0TXdKMGJMf2G3aTxugfTWClPra16jjqU/zo86j0OCC0u7x+38o9s0jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=himIOP9V;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB4606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 07:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54BB4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=himIOP9V
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb609d9bf4so3017225e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 23:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072438; x=1795677238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZCctNQK3cN5qV2Hx2SOGwUfxpcb935adt9+raA2U5A=;
        b=himIOP9VW8dFI4Cb78UcSnYZ4hH4vw39/NkXWuIBcyRF356zskq4HKIRzWX04uJx+g
         Mxellf66zrBhlQqTkp/4thojyTydK7Ich/y0Tlqrmwhdr6jmFP54Cya2eWF3qmiZ9ISG
         vuu3JoSbiBWdYT7HuM5Pdlk3M2IyTDn65RqLIdozfDIHXA+k4axAtUvgofbNw9BdOS2R
         S+S0gSTu7wVLV0y+wmDIH89Am6kBuTkt5jXxjtGn9VpIaHF63jY4W5F/9qQV2T/V9TXx
         I39xHVoC31xh8UHKhIIZdXI+WKa39Go3HNdnq5iPiqmblZwhvREbc2CVZKYzldOs5H0E
         IZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072438; x=1795677238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZCctNQK3cN5qV2Hx2SOGwUfxpcb935adt9+raA2U5A=;
        b=gAptiKXcdugOTuP9uxOMBzJ2tp51A00mn7LuYcLauw9Som/b/TCxHynoCsEVf8WQHD
         ztySdjFn3JGOondDlsb0+PTop6ATqHWSBp1HbJ2YwyEzwFU6pN71hT/GCim40lL1IH3h
         Z2aXI+tooJT8mWqVZq9TNObVsIXUg8HwR61myDRX3FmOX1YeaEEIX9pgd5QHZwx8daIJ
         eNTq3VawCJ3uZP0geMnogrGQuSu4d84fZCQ+1F+U73k/7qejNHmHiT8Rb1LPwrsvvipy
         Jhh9I/T+eixyXo7rlo+2iVFTXiXvJTIUIHjwRjJwoAqzrEAvi/SIg2CIXiA2oZbDazMw
         FTuA==
X-Gm-Message-State: APuU4Z9F1PStE0opCZfdkCRaK15c7V8jpjUnPRoHV5A4uoci5pUdRT/7
	Qc/3uVv9+mMs8ulZQqOmg60eBZBvEoWpgoUIU7AhXOfEH4PkUkcdYvXP5l0Z32Qn
X-Gm-Gg: AYBFou1X0vVov2bTrxrkB1+gGat6P9lDQLdLHwl2vXkBIHe82lVZIFgPEjdcKAjsnbH
	suewUWswMhfO6HzTh2drLr70raCcEkKyjqp+K+1Wh+KuD2RJ0xPzWNZtDGKZvongvsFUkPz14/6
	QBiFY8MPLs6qnzEXBo2za/4e3TI4/pSuetiOduSIetht5xLDX1jUpAescJJul4eepFIHlDnIvL5
	mUCOFw/Jkigt+byM8mW9H+ItIxy43nUrXHLmnWIMhihr6p9eg2hx0NBJQ79DyslcwSQPDzg5Ms4
	7NdV3v25rWSzk459of2Kf+1YwYSaptDyTiORy6u9FNlti652fqGwCZ+pTc6ICqE96N+X4MQHAqs
	NRxmotdtlGem/C58FgwuDSG6pOTyJiqOZeApyGyFG+hk+UhLZlhNltyl4mAqgVNLejKyhhlE+sr
	ZHu8QfpSbvcbSuyBc3KgFW4HEH4t3SY4MXzRNqwJz9M3OHjYKf8LnkJiNIyE1faR864ECiGuTS9
	rMrtTAvqv/gTBpIKC5+R7uaOPjtekW0G8vHD3mQyl7Bxp0BR7bagZTMpIsIpr1HPQ7YkvOOi/Fk
	qJY+8PpaWGGVekqKK0SReZjWatNseD6Kv5wwwHA0HffNKrzXfvvufvSa
X-Received: by 2002:a05:600c:468b:b0:4bb:7ad9:301f with SMTP id 5b1f17b1804b1-4bb7da0c682mr95592775e9.2.1795072437405;
        Wed, 18 Nov 2026 23:13:57 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85343607sm17549165e9.6.2026.11.18.23.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:13:57 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v2 1/6] monitor: Fix handle decoding of status_handle_rsp
Date: Thu, 19 Nov 2026 08:13:27 +0100
Message-ID: <20261119071332.32424-2-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119071332.32424-1-rolandschober1968@gmail.com>
References: <20261119071332.32424-1-rolandschober1968@gmail.com>
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

status_handle_rsp() decodes the return parameters of commands which
return a Status followed by a Connection_Handle, but it only reads the
first octet of the two octets of the handle, so any handle above 255 is
printed wrong.

With LE Periodic Advertising Set Info Transfer returning handle 3585:

> HCI Event: Command Complete (0x0e) plen 6
      LE Periodic Advertising Set Info Transfer (0x08|0x005b) ncmd 1
        Status: Unknown Connection Identifier (0x02)
        Connection handle: 1

Read the handle as a 16-bit value:

        Connection handle: 3585

Fixes: b73d4bb9e3c9 ("monitor: Decode LE Periodic Advertising Sync Transfer command")
Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index eddf8706a..4ff24092e 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4976,7 +4976,7 @@ static void status_handle_rsp(uint16_t index, const void *data, uint8_t size)
 	uint8_t status = *((const uint8_t *) data);
 
 	print_status(status);
-	print_field("Connection handle: %d", get_u8(data + 1));
+	print_field("Connection handle: %d", get_le16(data + 1));
 }
 
 static void status_bdaddr_rsp(uint16_t index, const void *data, uint8_t size)
-- 
2.47.3

