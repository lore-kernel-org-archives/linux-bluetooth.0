Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213607;
	b=Ns4dBjCOQ5jLcGIPnvPEBA9jUC55DIRFGFCVJD9VluDdaTOgqRcyVkaKbmMDKpMkcV27
	 Cue5h3wKfZTy019MIylYQmjPAXwqp/a989Q7v3/YHcLGuetfVnam/lP4ypvAnP3C5K9O2
	 uCX5YqV1sNnUPlRCbi31hS+6pxW3ckd+lak3GzaqwgeDaH0Xyaq+KL3PO8N35ohJUHiYW
	 LGuK1+qxjIYmmm0i3JUwEfhDQOjU/lu2Jx30zI0D8J8NmY7lgUoJ8uSCHbInE0NMPDngu
	 YcRSsTZKo11d1fYTPKz8gDhT8vWpOGBj1rVwH3N2RPYrATe5L67CgTIkZyjeFMwatXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3V+HVypldNzo11w0bqpA0iQ7+Jer4tTEa/Eelyx5n+Y=;
	b=RcF6MtesTkF5TM9dcWK+xGJpQbJhrhr3GaMHVv2N0J86qnTd8fCE7MeBt8ZRj44DSXMl
	 BJrtIH2/Y1k2wgmumR8VxfWMZiGoFtsVaZnCBMBH4scQx8ThPzrcxHoDwPi61HTPSiDmX
	 fVt/ksu5Op4BokTggPo5tTbeiauv17r6Ivq1GkxmOS8zKrKS/uKgFbPgy1zWqpSLwAW2E
	 0XWfPGaiM7y0cXKWGMzEhp9Eodf0K7IaBjhHogcPG/WnSiOtGRDnVYUhbCdPtHJJuIsDf
	 S/Ciqh8sPlXceJyl2WUwPUEQnUXm9MKQks/j4u7RQGZwV8FMjm+bf+GwQ+slXuWaVrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Z99pM9/W";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0B606A680
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 22:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F0B606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z99pM9/W
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a68f888a41so969255e9.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 14:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795213605; x=1795818405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3V+HVypldNzo11w0bqpA0iQ7+Jer4tTEa/Eelyx5n+Y=;
        b=Z99pM9/Wt39sQbFlBncavq3TS9juQ/BH9/tJD7cnQ8rk8F68VI6h7H5VoUNa42eBZ/
         qlKxQqyTlfqk/XoVNr9yvB+uRso+PrYhA8I6eHXo9w5reGsotNJRxVqYkUhpeDC2xwp8
         0Q9ZIJbLU8CLhD/3QE8IL9AqUgP+ZCFutka40+j5sSYtEZv8QoLHFV1VynNGk6u8/0xg
         u2AgsqSrGv4Ecnua4ofL7UrCadN8p76Ew4y8tbyAVf3DruILe1wPSbmslu70qI+ZRnOG
         GDTAK5spcixckZrtN5MYHvkOxsSnbaDi1omcXgxIPr9FQ5mVfJO6uInHcfGRAWgaJNIP
         rZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213605; x=1795818405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3V+HVypldNzo11w0bqpA0iQ7+Jer4tTEa/Eelyx5n+Y=;
        b=nz2yMONcjO6++rgM46bUDtpvFgHBIp7JeAp4j428AS3+s09Em7WYaNujM25Bde/Rew
         O7QcxSmVLr+Yo9LfESyIoTvGupBsvFzBk06KHTYhv2Qkg2YRWKTSKmaeCwh7apcUQPOI
         CTTikZVMPkq7DJYhUmzigHK8N+7yscNB97LZbA5Npu7RK0FDrKKh7z4D3Q4t7V/sbv0R
         k458n9JQVslmIfldoh0u3e7fwDyAGxu3valbqpAj/DvuODG3NanvSyCxukkCWWaJ6aN9
         tgeXRieWJApLM/Uc4qdGuI12kBYryoy1sLXzaqAU6DppaEWxZW85kvwclRJcr0LcVLdn
         C65A==
X-Gm-Message-State: APuU4Z/OxI3z917VZc2arfJGdM7txUkACX5EkFjLYjDpNqVoI+NpdDKD
	W1WIrRmfUum028QWveOqXCvvAPDwPp9wsOCnbdK6jQhRErU2XQiBg3TF3k+aTg==
X-Gm-Gg: AYBFou2OUNsNxjxgvMLWJUxXJdUlpOsBX8vIlhGFvdftRiVpjw1bA4t1b7WOrYqSyDa
	pqcmuipjugqBFm9LdmAv0TNPt7cMuhiVpEdL44ICvxlEDSCGzdxWG9iBaxOTxX9QhvTht4SZG4F
	unVVktWCSOzbpYmCRgB945qNhxp5gCEr/4axOGi1DNlL/fq+iOZWjEr0PFVIWZX9Z0XEUTcI7Me
	nwp4INXyO370TRWVJ+NhuQu9rtzhA60xrLAn6WXtAEOOajRz68y8+/tE1/2l/PX6kr0kP9ASUTn
	3fRO7aYRcpzD4dXcY269ctGb6WYB4y5YvGRpkG36taMwRSUPJciwcE05qA3I6Yu685A8ps5Nrii
	vNLHbqgFMRVvIjIkU81daq08ez5JPPg970bmPYU0ruiX0sGraSkNPespJI9pix3Jf3i26+Tfuyr
	gPTr6wE1TvlTYj788+DCsnTME+w4DuR1EuUJwrIdovPSQBn7VXhseXzkZdfuu5G3DYeRDgwa1hE
	jYiUeiLa1tJPHMi3LNOOuT4fS0V6ATMMs8hG+FCHkjnWTFTV/IyPTjODTeF9R7xLWSiKiaZCC6f
	SjaYQ6BssfU6Kyd/FbT89wphB+Y6JTAq6rncwhG/GC7VKuCbbIb04rX4u5F5IKzBonoq9Q==
X-Received: by 2002:a05:600c:217:b0:4bb:6a02:d42e with SMTP id 5b1f17b1804b1-4bb887f3fb8mr71412125e9.1.1795213604634;
        Fri, 20 Nov 2026 14:26:44 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b39e:f00:df5c:2a51:ff8a:45b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm23698785e9.2.2026.11.20.14.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:26:44 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ 4/5] monitor: Fix reading beyond the Apple manufacturer data
Date: Fri, 20 Nov 2026 23:26:23 +0100
Message-ID: <20261120222624.150321-5-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120222624.150321-1-rolandschober1968@gmail.com>
References: <20261120222624.150321-1-rolandschober1968@gmail.com>
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

print_manufacturer_apple() reads the type before it checks that there
is one, and prints the identifier as a string although nothing
terminates it, so up to 98 octets which follow the AD structure are
printed with it.

Check the length first and print the identifier with its length.

Fixes: 35b0d0c7c281 ("monitor: Decode Apple identifier and iBeacon data structures")
Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 6646dc147..042a2ecb6 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3763,18 +3763,16 @@ static void print_fec(uint8_t fec)
 
 static void print_manufacturer_apple(const void *data, uint8_t data_len)
 {
-	uint8_t type = *((uint8_t *) data);
+	uint8_t type;
 
 	if (data_len < 1)
 		return;
 
-	if (type == 0x01) {
-		char identifier[100];
+	type = *((uint8_t *) data);
 
-		snprintf(identifier, sizeof(identifier) - 1, "%s",
+	if (type == 0x01) {
+		print_field("  Identifier: %.*s", data_len - 1,
 						(const char *) (data + 1));
-
-		print_field("  Identifier: %s", identifier);
 		return;
 	}
 
-- 
2.47.3

