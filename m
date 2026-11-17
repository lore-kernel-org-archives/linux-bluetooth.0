Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931406;
	b=4S6H2mkv1K/J4QWxCdZER4RnJweLLd1aMP3encvbtN4ORXha7g9sPIYQjlzqA45bGNpJ
	 KYYRSFg/sUFj4xKu5LXWMn0eUW0YlmBes2HGmxpNmlnZl7VyAO1M9SwDgj1Z6sOxBtOq9
	 R9JEIjOV99PTl+qZae8fd2o/K0YfMvnWMiwk+p366knNezdjIyTT4jjXc0CCy/PoXRB4e
	 BtLhxaWtC6Qs8EF9uCjfRtmA5KH6mSgEYzSv5tW75k1A/aH6hAnmYY29zZJgOMSvXmOYh
	 xhMlfO9ouKRlOZWS4I1hLcIVYxeiZc7mnEI/FUyISzaVjk0U/CjoBL3vN1bMVFPKEgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r/eE6/aC4FksWw8IctQTFP5Edqp2kJgHXvjsm9ArGKg=;
	b=hfPeUyvGvt8rNLlaLRvo5VWymm6KNX0LaEmtCTvaOpCmGv68aqu4YNKJc3ikRG7qbnG0
	 Tt5nPufuNfX2d76wKi4/Eg+ODzyEwhPWtTonWgDzmbPw27n2LY7qycK98qK3Z/Feym9xw
	 zbBUR/B8eTrHwrzAGhEHkQPS96nhXDU2pO0piUad9pFGMgPwQHG4C+yOfZSHsqDTHN2NE
	 cHJhYG1HyDjoTfwLRDAqKjh+o/SUPa080YicvUwsA+GKRVH0tJkjkRfW8lW7vg+BIimC1
	 1xDFdDIeWE45P7F2a0umPgFUGza4rb1uQx+WeRF+WmreU+SKm6a8OoGQ9se5OSbK/rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0u/jlEHg";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77892606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 16:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77892606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0u/jlEHg
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb67b3a18aso1464365e9.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 08:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794931405; x=1795536205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r/eE6/aC4FksWw8IctQTFP5Edqp2kJgHXvjsm9ArGKg=;
        b=0u/jlEHgBG9HERpmZBu5sgFsIKd6yyLYed6kdfbgLqGY2e5Me0mEkBuxzezGDDmFmZ
         uK2ik7ee/knn33Vd9Letk3xfSGl5A5ZtV+cTQfcn7/gDQYAMle27SegyWvp9UtpOfQwb
         qIiTC+WJThTCrNNp79eNXVClFmPJSp+vSRezZKB22zhwyczuQ0U46dNeQz59yjEyr2MV
         Epn7g6BBVYZdXeWV0JV0rmA7/OnBvWUPg87lfuTqSMJy7Kfx/VIkO4l8UHixV2aZclCW
         xhPs8UvqJflHj8lG1UDCsosGnKhKjNn6+oZmYvR2upStOIDQwTO0PkbbWsfHT1vNQBkt
         slMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794931405; x=1795536205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r/eE6/aC4FksWw8IctQTFP5Edqp2kJgHXvjsm9ArGKg=;
        b=LTvAMY+w6UOvIiYX/8aFvpTcAg3d7hXrtkXWChUUzAoXRpO+PFA3WJdZF0dZFiEG4J
         jLVtGosVNCFGafldAf+noUIwXaWbKJzbYFhj8Qqmp7FZBIULBkpm41cUQ4AFgXPF0YXi
         UzlKa7w5wHrTwy9ipY8MhwsqGIIXT2MDPT8magaBYkv09MsoU3C12KwGw3Antg9o6JHE
         xidy4Dkaeml0uL0x1eXgBNAjBk7GBxUqd2+YtZ+JuMxM/adDmf/XMwEQGwY/4f+5bncL
         S46VWbxlJTX41JyEy3a5Yp+7IOqxYSt0Qg4qHet8Dc8K4tLsfQFwk9AUkEqLTlGz2kra
         jZEA==
X-Gm-Message-State: APuU4Z/YRO5TvQ1LV54rZ/i4mkrnnBQnx8HM+w8w2YGPzvPsOglwa2kY
	0pI2B5ecKQQoDILdUAQeD0h8b1Aqkz6d2whSSx0Nb/R9tsTI1ztZJkKYk5G/HA==
X-Gm-Gg: AYBFou2oekt576TkBU9P9OEyv3lsrGoLT8uJLHMRM8K03YDX941mUEs3dXLWVqwDLn1
	1ypF1q+OkZC1+8I9xbd7UYRncqg7jNsB8BSi23Z1q85eIhoJyUaPVtMvE2TO8GsjPnkzMZEMpVM
	U/vm5c7HW3d6vvc4ZjtMClM2+IvYCbjPdpYGWN3I4G21pgb4oi0qdqtE2SVo+Fl/KaDwrLzxfRf
	JtruTRo8dqFwfYWGntnwZHO1TQdeDB9+61fpHkp/MUKrIDgki8O03KSqhtULH/hABh5L+0ImNyK
	VcH2A0N+1g3AG06OOLDEujrZeXrgPhMTv5XxZb8ZhTDd/HnB4uU4SuWcfNQwLsTZB2zBWbUk7iz
	XD/6p5jbWAr8qyPonqXANBDvzZhBNCqTZ57dCUkp7/gl7Xop9orZUxDoqkcRbHRf/6/9Z3i0zSy
	YnkomV36NGt/nSiGXMjOhZkcGh+tn3FHJ9b1vsMlyyXn5ChsONcLRDWNFhvd7fxqPfal2mmHuwL
	24psCgP7h5srYd+WuYOFJDfWlb3vRDtYvNvmFVEuOqgNVBQmOVztvjfp1MbB/AmaCdvs6Ga0WOn
	OusSuRRDNWf/BWbEvI11ZpOf2P1UuIOxt8d/Q5zfVZ6MM1hMPQ==
X-Received: by 2002:a05:600c:a20b:b0:4bb:7ad8:99f2 with SMTP id 5b1f17b1804b1-4bb7ad89efdmr24165325e9.0.1794931404533;
        Tue, 17 Nov 2026 08:03:24 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b3a2:d500:342a:4be9:726f:4a50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7839c5c3sm75158285e9.12.2026.11.17.08.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:03:21 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ 2/4] monitor: Split LE PA Report decoding into helpers
Date: Tue, 17 Nov 2026 17:02:38 +0100
Message-ID: <20261117160240.222556-3-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117160240.222556-1-rolandschober1968@gmail.com>
References: <20261117160240.222556-1-rolandschober1968@gmail.com>
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
 monitor/packet.c | 75 +++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 4ff24092e..b31b8c31c 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13897,46 +13897,45 @@ static void le_pa_sync_evt(struct timeval *tv, uint16_t index,
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
+
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
 
-	print_field("CTE Type: %s (0x%2x)", str, evt->cte_type);
+	print_field("CTE Type: %s (0x%2x)", pa_cte_type_str(cte_type),
+								cte_type);
+}
 
-	switch (evt->data_status) {
+static void print_pa_report_data(uint8_t data_status, uint8_t data_len,
+							const uint8_t *data)
+{
+	const char *color_on;
+	const char *str;
+
+	switch (data_status) {
 	case 0x00:
 		str = "Complete";
 		color_on = COLOR_GREEN;
@@ -13956,8 +13955,18 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 	}
 
 	print_field("Data status: %s%s%s", color_on, str, COLOR_OFF);
-	print_field("Data length: %u", evt->data_len);
-	print_eir("Data", evt->data, evt->data_len, true);
+	print_field("Data length: %u", data_len);
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
+	print_pa_report_data(evt->data_status, evt->data_len, evt->data);
 }
 
 static void le_pa_sync_lost_evt(struct timeval *tv, uint16_t index,
-- 
2.47.3

