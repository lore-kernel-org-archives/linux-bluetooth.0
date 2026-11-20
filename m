Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156751;
	b=t82VEXn1J0TG2VIPkWS2511wCBnfuaZAAhFij90gtb+Sl4g7d0Fgw11JX3pRIQZ3gBPa
	 8XGeY/tPp4VJ4w67lWfz8SWDCqhKVlu7kdFDun7txJygwEgaes8whaspWtx44xvNNb3nv
	 RDCzTCtBaZnbW0uj3iC1K7jBpO6xV9HqGV8w301MqD2QU7xJ7SRmTdegDe6olKAP36h7g
	 UAtF4AuN+AEkR9KnePpIZcdj2AUahhN4+yxbghqDYuPsiRDo9e/52Uy/9Nls2E3VnieFO
	 7wVia01QjlM+sQQcifN4mw70d+z/L0L7wQl/TKB0o/dgiZNCgcJhf2jjd+5ZDcXVFeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ifKT0LAVl9ox80nN8Fd1epW7ZsyJ3UxTB0AQFLfnMOs=;
	b=BMR5f+rmDCggNohYIhlJx3yeIG7GoFNqxfEAz+Ul0iMoLLS/rS04FnHTad8DY2thtntt
	 8R193vRbYBxd3KWmW7eDob9j/VqAhwR5HqtWfHv6fa6c+fLapypSUdxq1oUMaDBY4dheZ
	 57q9fLGD2N5tU+8IdZIidFy+hUW/hqcqSGiH9HTC6tmudlMWlrgn16es9YF/apVbwO7Ja
	 s+m/98wa1XtJ6LFfJlivmwc7oNhbPWDuOlIe9ul4X1FbdoOOch1/T62rzSO+gXIVtqdhW
	 NFSSpOnRs+kI+kF4tVbmdYSR8frgNKU9wYqYfQZfJpExEwzopKNypowKFSbZTJ+jfyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o1W7CZrb;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33425606A326
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 06:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33425606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o1W7CZrb
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a511d8a394so24387f8f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156746; x=1795761546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ifKT0LAVl9ox80nN8Fd1epW7ZsyJ3UxTB0AQFLfnMOs=;
        b=o1W7CZrb9dJjY1nSm5rP8rZIPaBHO6W6LlPQ4YBdnwvDpm/ezN1QFd7L1oZRUy2UkZ
         vVmyYCSetlsI2MkdmnWpxHgXglBAeYsPdepLEG4vvZNmYgH8sJ72eOoS4LP6N4937yFA
         U4CL6Q4iX1rb7bs0ZpOmFTw90WeVSPkfhaMgQJG172E3nyE52brZ9ElgKDVNO5h4bW7d
         cQSSkpA6HJ3IsylQzZDgd07Bu8p5+06m/FwUAnroNypQr+lrMtnJAm8bU7oCxvlcXU36
         FZkZOUCq+4QWG8clS1fKsRtO4S4klOTU/fPKQTYHo8r/8TFlWk7ooGUEDlI39M6+/+Xr
         dkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156747; x=1795761547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ifKT0LAVl9ox80nN8Fd1epW7ZsyJ3UxTB0AQFLfnMOs=;
        b=G20e0xeJ3fpfza5qytIxRd2Tqj30ga7qAKVR8Ho8lVTfTAcoj2VUCV3IntwDsXUKnF
         MdVFV2uwxSBpCRvwoyysVDpECMxtZuriB43l4aBX/NsruVq7O+bdDs0OdkbjitOzGemf
         ZTRDiGNHAgwpJEF9hRSGT0gABUXVlfnb/IFLm3Gpe315BMZ+uauWgx16MUSLq+NUuHUr
         ADUREx3p4ThF6U1n3t1acIhKJIewqOhR/PJPQE1Yb5kI8LjClcCaG/iiPkg4KQocIigr
         V2f5xSR0zGO4ldL+Un1U0WREACeOsXt/bG/VkKe9eLoqoTe1MYpOQGNDebkV06ikDVV5
         odoA==
X-Gm-Message-State: APuU4Z9XtKaOJNVHz5SQHNJI+OaJd5ZX9bB1JU6X4Gl8fYlqzfVLtK+R
	JkS3yDfkkHCFEC113VLm4sF1/5KjZIAzuJv56YmFPj/GBZZKqj40N74dzBhvZOIo
X-Gm-Gg: AZFdTZdLfE2Hv0F20uTzdOVrIOMvIxcSVm7if6qZj+C1FpSGaU07VOgpIpEwUxs6QX1
	YzaeVrnCU1X0ylO2l8vo0OsGCTCONmz9Evy8s27kj40mlj9CDI76HN81DoLIW6hYkkME8frVkKt
	zZ4Ge24/5l7Y+Pzgv9PD5xHx3zWybuEO23y3X6mYwIPldI185+1Pj8YJ/My28aL8ZzX/SvMu9s2
	AiBmTcwGK63U475o+97FR1mvlUfqwVVA67Os1Fy39wwoF1xBkoAR871KW5APKxzkZpgRJlzhSbL
	eH13r0sa1sCdmdekQNW45IKs9Ehkma3DZgt+FPi3r/Jm2gZ7Bce+RqkhEwVbEQlaFZXEyAaXBWY
	Qhsf4r2F0/DVcgoPV1fD1W0gaRm4tUuVldD3lW2me06WImsuHQHI/xZQSkIIeHS+Wr5+JTHrQ3Z
	+oZl+5bH4YORIaJasJVfbujwsm7OG8XibhvDrH2OCalcrbJvlFQQvbJU4Fxb6naDBLzmy43epAd
	gcZZVauJAYB1Exy40Urucc6Bqjc28Hxizi9faFZ69kNNOrt5nzO8fHxgk709PUShpLQna61XTzj
	mpzlfkq43u5I3Fc57foh9Q9M+4ldAzQrm8w=
X-Received: by 2002:a05:6000:184f:b0:4ab:cb33:9b87 with SMTP id ffacd0b85a97d-4abcb33a2e9mr3738739f8f.5.1795156746521;
        Thu, 19 Nov 2026 22:39:06 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm3685607f8f.16.2026.11.19.22.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:39:06 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v4 08/10] monitor: Split LE PA Report decoding into helpers
Date: Fri, 20 Nov 2026 07:38:54 +0100
Message-ID: <20261120063856.16585-9-rolandschober1968@gmail.com>
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
index 4b7a82ac0..22ec1f131 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13917,49 +13917,62 @@ static void le_pa_sync_evt(struct timeval *tv, uint16_t index,
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
-	print_field("Sync handle: %d", le16_to_cpu(evt->handle));
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
@@ -13979,15 +13992,26 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
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
+	print_pa_report_info(le16_to_cpu(evt->handle), evt->tx_power,
+						evt->rssi, evt->cte_type);
+	print_pa_report_data(evt->data_status, evt->data_len, evt->data,
+							size - sizeof(*evt));
 }
 
 static void le_pa_sync_lost_evt(struct timeval *tv, uint16_t index,
-- 
2.47.3

