Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076201;
	b=X+V8lh1NG8qzXcgKmQXE59xem7rHok+6s2Z8eL+KQNi6b2592LDn1L9cHvSCXGSv1tjx
	 x1x3H11a7qZSfGimqmIE3fERYPGstYaA7mF0L9yaHrqHG2TwCIMWtFJA0U1uK30N2WfRF
	 6xs/ERtlRRgqQd8c/Txk+/mj4wV361Aw8vUAKSQXVYS8ZkMQ7N0FC83+ZIyL/wOjJkQ/5
	 0/jNGtxHf+Bplr1qeIWv0msO/E3Iw+5jvRLnhjvAjm+QliX5q61MeaoDOw+2ed58tEkQk
	 YKxviWsk+fupl3yt4P0esKU37c6l4MEDh8Ts8i6DCmTqapKa1WfqnyrESZl2UlGoPSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CAn6oGr5eOL7aLxaR54x4ekWb7RHJQkV2pFJqmz8Kak=;
	b=oCr4SLLZIYSqYXO84BRmtAnCvRAg79jsEbVbG1kO0HqLaxFDS9yKaECGg6TTKVJF9480
	 SmVX61U9ZI3JbH6qi+oElC9BBOMR6lpJSbmakroxiBcOw2t8P4AotFQNbWTNb0yYKIkqT
	 20FDH6OiIQcrPsjt7cdoWMQ6qmcCHXc+5B6aaFd4kyEytgvXJU/OlwhgCo3JwD44iMQey
	 Aq6JMVhAQPx4xwE13KPd9vB7LlHB9Xkvmv81LUuP2s4F5OpWmSE2KvdzMxZ/m+DyCv+6g
	 b0jKlEzpCc92QmHWxFQIaWF6YRdABL/64P9Oi4lAM8bMtAC6MH07TIajSKkwZ4rCG7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m46p9Edb;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7E0606A812
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 08:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B7E0606A812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m46p9Edb
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c50737c64c8so22570366b.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795076200; x=1795681000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CAn6oGr5eOL7aLxaR54x4ekWb7RHJQkV2pFJqmz8Kak=;
        b=m46p9EdbdfbXoSFRmc/o3FHIoJ6snC26Z1S5L0oCGaN3aDwTgD+WrW4PAWD1pT8QHU
         r5aluHi2euSTyJvjqfa1EmN01rp1Kp07SmFUumAt0istJhq8iwXvFcAVdToyn/gTqJwO
         a6LEUkCUo76U0ArPVV2dooWlCUNcdgtsqkteoDwWUTh0g/lLpeD1UP6qFbQEv7222u5h
         VyNTO+kDY7LuCNHTkMbzRQUKU/SPFr5W2tmShGfB2zWBLJefw+cY5HZRaDhjSTOOOE/a
         Y5TCQgR7yGCQM2Sw8cIYfu8Yk2xnccS5lMd0SHuqeBM6V1l7jMlYehcqHasN1HEMVisQ
         WUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076200; x=1795681000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CAn6oGr5eOL7aLxaR54x4ekWb7RHJQkV2pFJqmz8Kak=;
        b=V+8IUmh3+YwLAuOXcoV4FgAgINnb2r6U14n7KBi/Sn1XkmEcsQBFcMal1QplWGuy4E
         GOBiG1aIPk8/JUUIC72qjjbGvzKEQMeDcv79fC2S+L/cj3tkKYYhGsv/7CwKZlcdPqje
         qxjK5WqdCaZcTbFeEcEMi4BzTsYl7a7rLpWgRRNFkwaUJ8Qoi/mKXWByHK5JrxxnRsfZ
         3/rBz1uZSt4nAMp/b6F75vzGzFJrRO3EgbTgMyVEVAXD7YghPGtX7hFp7kIDvjqw/ZZf
         O5E4q8m5fpzlyDisw57EGqNmzeiXdocjtg+MfQTTe3V5+gFOsfOwWrWlcpTU3Rb925N1
         hITw==
X-Gm-Message-State: APuU4Z+yCztGxidW7yD9dpU/sUEfnHIVIB6FUp6U115YkGxcb8MBsL9H
	LCgs+N2aWJHXnDgBEJBR06fDuaL7mpAYxYEbVh48agtBhcgCZqeWtRv4ibR4OSJx
X-Gm-Gg: AYBFou0NYHDBqA+UoQXRFnzNm8VAdXgjgPZVQnWpH4z7NvFMO9NnRERxN09iMoM38FB
	+sNaSXTIiUcQ27aQ6cKnnM+8JRfU5dfZSf/qQLZvCv9XNjT/QimsP3xqjYljWmPie0E51xx/KM/
	Pl8lWKVZzQT6t4sXW4/igIx7j1j9P9P0jsRN1jh6oMIAg3IcvPIFwzozCZClPat051/rTurkb58
	HFZP8LngsbalSjkZ5oq9036DT+elCZEJXYtEipTG484cCOUEygUUMnwFK4TD08RSvD7I426GJ1/
	dD5xeSq7WgKetIG0G04TELT+epP5lJBy6C/e1n3rAOSdWeq4aBLg4Qv2XfAlERju/oPZZLjy4gp
	MHFUID+azk8n/cWROkWy8tdPu7vHwmTHDjnBhR5UPOKy+rapCjD/kyOe1eiqOUgfzHkmReRVJmy
	ADOl0EE8kpJ/OiE/SMFjCv8MKGwev8WmK1PWamYBdXzWqivWbaKPoxLhl4xugknEcworruuSKN3
	tVGIFzCG2+8hm+Huux03ZVSQVBdY3d941E50583uemmGmqcnw23mJMfe0DzdAAS9p3w5+8gqsV4
	25u3piNgA9kgnt3BMldS/U4cfCOKy28ROGY=
X-Received: by 2002:a17:907:9550:b0:c51:4fd:1aef with SMTP id a640c23a62f3a-c510e1501bfmr461555266b.2.1795076199543;
        Thu, 19 Nov 2026 00:16:39 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a22e143sm2229580a12.29.2026.11.19.00.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:16:39 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v3 7/9] monitor: Split LE PA Report decoding into helpers
Date: Thu, 19 Nov 2026 09:16:19 +0100
Message-ID: <20261119081621.112623-8-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119081621.112623-1-rolandschober1968@gmail.com>
References: <20261119081621.112623-1-rolandschober1968@gmail.com>
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
LE Periodic Advertising Report event into helpers, and the TX power,
the RSSI and the CTE type names into functions of their own.

This is a preparation for decoding the events added by Periodic
Advertising with Responses, which carry the same information, and
does not change the output.

Assisted-by: Claude:claude-opus-5-5
Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 100 +++++++++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 38 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 015392713..fa19139d9 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13916,49 +13916,62 @@ static void le_pa_sync_evt(struct timeval *tv, uint16_t index,
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
-	if (evt->tx_power == 127)
-		print_field("TX power: not available (0x7f)");
-	else
-		print_power_level(evt->tx_power, NULL);
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
-		str = "AoD Constant Tone Extension with 1us slots";
-		break;
+		return "AoD Constant Tone Extension with 1us slots";
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
 
-	print_field("CTE Type: %s (0x%2.2x)", str, evt->cte_type);
+static void print_pa_rssi(const char *prefix, int8_t rssi)
+{
+	if (rssi == 127)
+		print_field("%sRSSI: not available (0x%2.2x)", prefix,
+							(uint8_t) rssi);
+	else if (rssi >= -127 && rssi <= 20)
+		print_field("%sRSSI: %d dBm (0x%2.2x)", prefix, rssi,
+							(uint8_t) rssi);
+	else
+		print_field("%sRSSI: reserved (0x%2.2x)", prefix,
+							(uint8_t) rssi);
+}
 
-	switch (evt->data_status) {
+static void print_pa_tx_power(const char *prefix, int8_t tx_power)
+{
+	if (tx_power == 127)
+		print_field("%sTX power: not available (0x7f)", prefix);
+	else
+		print_field("%sTX power: %d dbm (0x%2.2x)", prefix, tx_power,
+							(uint8_t) tx_power);
+}
+
+static void print_pa_report_info(uint16_t handle, uint8_t tx_power,
+						int8_t rssi, uint8_t cte_type)
+{
+	print_field("Sync handle: %d", handle);
+	print_pa_tx_power("", tx_power);
+	print_pa_rssi("", rssi);
+
+	print_field("CTE Type: %s (0x%2.2x)", pa_cte_type_str(cte_type),
+								cte_type);
+}
+
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
@@ -13978,15 +13991,26 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 	}
 
 	print_field("Data status: %s%s%s", color_on, str, COLOR_OFF);
-	print_field("Data length: %u", evt->data_len);
+	print_field("Data length: %u", data_len);
 
-	if (evt->data_len != size - sizeof(*evt)) {
+	if (data_len != size) {
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

