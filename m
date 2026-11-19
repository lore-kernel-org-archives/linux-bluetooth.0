Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072443;
	b=Doa3DxlbIhOZnBOcQ53manVcCn46E99GQTj2KjrcUJFlkYEIpHFpZBlDjl+OsZ0/q+bD
	 yhHUIdgglfkHSm03Uyw5YipiB7c8twMXMpHHpyJpQEwSrbIzurUxcwd8CJEQdbigFofju
	 OepaCvrNe+BeJZodsnnPa/6KmuT4+EXbqKCjoC8VVs2PnA+lSM5gLuA2YsDCK8v0tChKU
	 ujasJFYBA0nFv0Oht/3+aoZDYtEwpI53lXd9aCshi2duLIX5xNlh4fbT4WHwjDH+oe17c
	 OZXEB/Fznfi2GfciF+1J6RbZEU0985XD3SLvd+U9c5pbuPAhDeDUp7a73KekxJzpbXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dqQztl3ppOtgcOCmLsJPlTHZe0ZDQW0ApB6TA2G8Tok=;
	b=xpqu7NsBnATtyrOMXkanRow/lJrGzvVyQqojSPsEpPg3rNWBjerCA/weRuvwRLOvZfpu
	 5VEADUgxlcrPyPZ8J2aD+zTpEeGp9S2cuy4DlL+sMRYlS8DwNEKbyTA8jShwO6nEGX9lV
	 LGJt6ANvx3/L1ZhaNTEdHURPmCVYEzt7mQ5fieNqmxUP27bhhOa1+f1MTtnY7thOLcEyE
	 0/ae2SZPXnSrE/m9/JdrqD/Q0tCACow/4ZTmh4PdevhaREHQENi6R/XdWrZwBBImG4EzW
	 wgAiALjwJP8li+1R5Bjrt3eK1dsc6KzehW/sQTf1YuWHSqFtHSkf3jiAMFAunfafZhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GKvD0EoD;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C5D606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 07:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91C5D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GKvD0EoD
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb5e3cbf45so1296375e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 23:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072442; x=1795677242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dqQztl3ppOtgcOCmLsJPlTHZe0ZDQW0ApB6TA2G8Tok=;
        b=GKvD0EoDXHmx5LYGgWTmoyvDEttJsA+jUAQdIeNQkQXstDPMrDQApjgdhipSfqIn6a
         1ETctUgLf8uC9+UCyipK28HEu0deT49HvUjbjFug5FxUuEUzXmdT3pB0n8ijBFlRuI/8
         98Af+nfp0NZVOwKywExVhD5R+/Ij1IbKsKw3OBS1G16MZ2B/E7KFlvxis9W+ksruQ9fG
         MPs0ki5MRukcjO4E9EgNWtuwJeUv3wcEjPhpgwzVUUa7bx4Y6TSaBrgZVKoEInUfKNOR
         hD4bT+kx+v3f88DuJLXWmtzt3naD309Y72m0rUFUHJqHjlDPtF5JTIpO/zVvgfl4pAE0
         Drwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072442; x=1795677242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dqQztl3ppOtgcOCmLsJPlTHZe0ZDQW0ApB6TA2G8Tok=;
        b=U1+Sp2zT3Ofz/i8rsVvt7OjpeXCIBZdyWsMWu4VkJFb8z9jH73uOnjS915NYpfJZCl
         sOKwzUEJflDONfTt1uEhgj6RL2iAS6C1kK57wHRIVqwhcerxRIKTTMmhyVf3wifB8uUP
         IGD09L8HHbX1VjJyqO37Q9FGpEIFzImltfZ94kHjYekVKAalbGWnMHqLhxtbfo1OsOiK
         V5s/GX8G5zjZiJsn+QeGQXey+9Wjpvf6Ts4ShzQv7MfZ+rBk5D1dOu0IXSOfokTSIDaG
         i0568nfCuMmHvyjjlR8tDJuw+RBcsWwKdeWUnyVfYiprJfPfyfTO/HFcrpvGMy37kVjV
         xqVQ==
X-Gm-Message-State: APuU4Z/+fceSccnELR/rqJWITl+VqFU3jPIVaxeAVn5Wj/pM4FMf1DVj
	1ssaFKtoeA14buBiug4R9+JGaqDt3YAyT+uIEQVlhbGaILsiixOWzmQi6XTrS6+O
X-Gm-Gg: AYBFou1s+qpoeYrwovXuMIfpnsmaecNVYGGr1wtXXW4d8mK72b4MknYa4OvCuotGRt9
	uqOQqg/slxNI6SsHLydjD/8OQjGXta4ZoA7I0IZEEg3EH9eQSSsuku0g+DsVj/9TpVEhV1V0Tg4
	JBQsxQl5QNeFqAy5qkNG5l5OUnVwg945VBFrNZ9hUttocDBK5FXzAZ/2kKQWhBoJ5hSB5E6S7ad
	pWTR8GivcSmmUOjsGS7QPNWtQg7gdLJtSMW0HP0yqnWLYWDoa4Q4g+GB94fhS0aiTs97D+9xlTO
	S9v0E4pbAd8BzrfzfdZJXqaz1yOj40D9V+7R13ezb2RdYuBpaNzJKOXWECc94RLDU8AiuvBsFrq
	6npWgV6P4QXAal/slAv+OiJcICuXr5iTxAMsuz3+hc5uH8Ll2gFxL4BCRQYJrtYmLiLDJDSgMqa
	p4ejvx2qvvrdXBx2/RnVx5+9XR+mYQG8p4HfVybQy/y8QtI2QEHlw+CVlb0hk4CEFYcBC2epRTe
	8u9vHGPACAlao7qpC4jFrd5jbJhHxSY01qKwCCo4fP2CJ1mj6Pk4/l7hkNqE3prlAVnEu0eeFlg
	4o04PAOdmwNXULFMYayPbFHgmPyP6JR0FAA=
X-Received: by 2002:a05:600c:2158:b0:4bb:7ad8:99f2 with SMTP id 5b1f17b1804b1-4bb7d581cd3mr66600505e9.0.1795072441894;
        Wed, 18 Nov 2026 23:14:01 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85343607sm17549165e9.6.2026.11.18.23.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:14:01 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v2 4/6] monitor: Split LE PA Report decoding into helpers
Date: Thu, 19 Nov 2026 08:13:30 +0100
Message-ID: <20261119071332.32424-5-rolandschober1968@gmail.com>
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

Move the decoding of the reception information (handle, TX power, RSSI
and CTE type) and of the data (status, length and AD structures) of the
LE Periodic Advertising Report event into helpers, and the CTE type
names into a function of their own.

This is a preparation for decoding the events added by Periodic
Advertising with Responses, which carry the same information, and
does not change the output.

Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 80 +++++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 35 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index ee9e63496..9a3de9bc6 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13905,46 +13905,45 @@ static void le_pa_sync_evt(struct timeval *tv, uint16_t index,
 	print_field("Advertiser clock accuracy: 0x%2.2x", evt->clock_accuracy);
 }
 
-static void le_pa_report_evt(struct timeval *tv, uint16_t index,
-				const void *data, uint8_t size)
+static const char *pa_cte_type_str(uint8_t cte_type)
 {
-	const struct bt_hci_le_pa_report *evt = data;
-	const char *color_on;
-	const char *str;
-
-	print_field("Sync handle: %d", evt->handle);
-	print_power_level(evt->tx_power, NULL);
-	if (evt->rssi == 127)
-		print_field("RSSI: not available (0x%2.2x)",
-						(uint8_t) evt->rssi);
-	else if (evt->rssi >= -127 && evt->rssi <= 20)
-		print_field("RSSI: %d dBm (0x%2.2x)",
-				evt->rssi, (uint8_t) evt->rssi);
-	else
-		print_field("RSSI: reserved (0x%2.2x)",
-						(uint8_t) evt->rssi);
-
-	switch (evt->cte_type) {
+	switch (cte_type) {
 	case 0x00:
-		str = "AoA Constant Tone Extension";
-		break;
+		return "AoA Constant Tone Extension";
 	case 0x01:
-		str = "AoA Constant Tone Extension with 1us slots";
-		break;
+		return "AoA Constant Tone Extension with 1us slots";
 	case 0x02:
-		str = "AoD Constant Tone Extension with 2us slots";
-		break;
+		return "AoD Constant Tone Extension with 2us slots";
 	case 0xff:
-		str = "No Constant Tone Extension";
-		break;
+		return "No Constant Tone Extension";
 	default:
-		str = "Reserved";
-		break;
+		return "Reserved";
 	}
+}
 
-	print_field("CTE Type: %s (0x%2x)", str, evt->cte_type);
+static void print_pa_report_info(uint16_t handle, uint8_t tx_power,
+						int8_t rssi, uint8_t cte_type)
+{
+	print_field("Sync handle: %d", handle);
+	print_power_level(tx_power, NULL);
+	if (rssi == 127)
+		print_field("RSSI: not available (0x%2.2x)", (uint8_t) rssi);
+	else if (rssi >= -127 && rssi <= 20)
+		print_field("RSSI: %d dBm (0x%2.2x)", rssi, (uint8_t) rssi);
+	else
+		print_field("RSSI: reserved (0x%2.2x)", (uint8_t) rssi);
+
+	print_field("CTE Type: %s (0x%2x)", pa_cte_type_str(cte_type),
+								cte_type);
+}
 
-	switch (evt->data_status) {
+static void print_pa_report_data(uint8_t data_status, uint8_t data_len,
+					const uint8_t *data, uint8_t size)
+{
+	const char *color_on;
+	const char *str;
+
+	switch (data_status) {
 	case 0x00:
 		str = "Complete";
 		color_on = COLOR_GREEN;
@@ -13964,15 +13963,26 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 	}
 
 	print_field("Data status: %s%s%s", color_on, str, COLOR_OFF);
-	print_field("Data length: %u", evt->data_len);
+	print_field("Data length: %u", data_len);
 
-	if (evt->data_len > size - sizeof(*evt)) {
+	if (data_len > size) {
 		print_text(COLOR_ERROR, "invalid data length");
-		packet_hexdump(evt->data, size - sizeof(*evt));
+		packet_hexdump(data, size);
 		return;
 	}
 
-	print_eir("Data", evt->data, evt->data_len, true);
+	print_eir("Data", data, data_len, true);
+}
+
+static void le_pa_report_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
+{
+	const struct bt_hci_le_pa_report *evt = data;
+
+	print_pa_report_info(evt->handle, evt->tx_power, evt->rssi,
+							evt->cte_type);
+	print_pa_report_data(evt->data_status, evt->data_len, evt->data,
+							size - sizeof(*evt));
 }
 
 static void le_pa_sync_lost_evt(struct timeval *tv, uint16_t index,
-- 
2.47.3

