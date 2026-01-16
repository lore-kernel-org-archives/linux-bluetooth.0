Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3B306B02
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768595186; cv=none; b=cSh9uuM/WQgd0KJ1qoTR0MrFa83s5pyU1ZltEhmW2Mj+Or75Tg+Zm08xIP0YUmoUjPwvNRb0y9r81JrgAUXW7QRco7zFsoppLzuFRhIrs7jKkSaM8oHtRjgVAbciTgmDLYL/fXuW2AK5m3GejG6P4pr70CGstz2BXeAVwqXZ0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768595186; c=relaxed/simple;
	bh=i8YMa0CnpWTMOrY/24nFneSfg1mK5tnd+Tmxhni9OGU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z0y966AX+hTw5+gZa/lVub8nhBr6CI3fR64RAwwqBFymoSGVp5eMI+63b8UcGv8IWaEFgRYeGBR8hrSfhiGBTDY9rNFg56RMtk6/DRBihJsv2JJGZt+AQ19G0XStjggpsjtiHYm8BR4Gng8GZAj1iQ8s92lbc/2CtQ5CnWBUiSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzPZCpgf; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzPZCpgf"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5eeaae02888so729823137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768595183; x=1769199983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CXOk8yZ9Mwj8FNih2BsQFpDZeHbJo90BghW0BFqH03E=;
        b=jzPZCpgf7G9g+Ik7+rnIN0Qkb5PlRELxteIcsIjH1Uh1JlhWqzYJNWgwQSf7/WbZGj
         KCzguOpDunGIsypgVkmP4dsicNMNX0b9PtHrpSjepLYCsbOyiEiFzUXtCvn7M+3LW5ok
         usviqpc8JUEr+6j1ztf2tBiPCOgZh+Mk+8i6Y83DoRQeNNrRHbx7wOUph3GGPw0aTR5o
         IIltL9IiI09A6hFjNO2sMKEqUWca59efQtsotNSFE2z/q9q6T+D7PfN3YlgQXdcRqpNs
         indL5uYCLCMbNvGSJVEGbNL6Hj9WeIV0y12xUxz7lN8Vl+7zshpaOaulxpLCdWFDfevf
         Srpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768595183; x=1769199983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXOk8yZ9Mwj8FNih2BsQFpDZeHbJo90BghW0BFqH03E=;
        b=RXa2viLVSZEwPZJ5gr45uMbCeCKKqMRsGOnE1R0FUbqK8XngrudljMFsQU7jGxJa/m
         j9HGoitrbGjIysI9s3TUaS+CqX6zmzUqxZTNKd53v2lUup9wew+ogqLS5+ql1VeHGwAi
         KGLEXXt8xKkyw+o0zfEdp/XeqLS77H3UCeldmTiB6lU+fKzkZ9k2oKoejrLR90VaPQE6
         vtxXDWP/YStdXcsN7amihPUSVZsNsHvWHjwgiJdY2K81/OxQuRObgZT2LSsMyVbRwNBg
         WR1BpjjVVYL/qLSLMA7wKuvFa8pskueXatm8RgpZ3mQfD8HiTVDaoSiDfe4wBw/N/tNY
         k+GA==
X-Gm-Message-State: AOJu0Ywc5+m2Yb8L+DpK8CujVYODcPi6kxh2w8kyJJh/g2V/vJ5aTeoo
	6lAGEPrhoaIunOZiyJjptra4Th8oHlbAfeQIgiQcfafogWui97cOyZudclh/acqK
X-Gm-Gg: AY/fxX7UxSNYbpLwkN/YlxTqBLGmAsTO0wBJnINCAuO4jSr2j/CqZ+8aKYG+fTc9bh7
	tAJbg2mUyL9xqK0/qVmC5qWTBCKPDqq63JSbeAWrBQr/W6HxFI112puf0rQ43cCc9plIdxHWw7K
	ZjquZPKJH2JU2fXzKHI4ICRdZuIBaMHxX6EUQIPozMPKAfeFIt958gyZIiRhKP0waXGpTSa9ds+
	11jsM27IhUp5jLvrmHKopLCf94g0BtsklXGFmEAMAriK8rG5aFv7QxV2AchN8ZPCI9WqWA7X9v9
	NUM+dbdJZvvpbKNUMskGBgchsQDxpB2gm/JpDKf5FgKS66KZuvLpMPBbvhHBXUKwX8kGiVrNTsd
	Tbn+U3vrp1mAJ/KqlStn/1YmD+OzZQoYDPlWTo0voC4rx7uUM97+s7yJR2q4G38hlbEpb4KcBra
	QezQLdYhMMPoc9Y3twg3BZQuh0Dufir0C/XPnF7wzl9IsQU+H+JewaKfJhdZpCKZ34PALbhLpYm
	Q+fgkfkJXwextQK
X-Received: by 2002:a05:6102:290f:b0:5f1:4c53:3c21 with SMTP id ada2fe7eead31-5f1a551ef6bmr1123626137.24.1768595183300;
        Fri, 16 Jan 2026 12:26:23 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a694494asm1087569137.8.2026.01.16.12.26.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:26:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Make eir and ad print hexdump
Date: Fri, 16 Jan 2026 15:26:14 -0500
Message-ID: <20260116202614.1781836-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes eir and ad print an hexdump so user are able to identify
if there is text encoded into them.
---
 monitor/display.h | 51 ++++++++++++++++++++-----
 monitor/packet.c  | 96 ++++++++++++++++-------------------------------
 2 files changed, 75 insertions(+), 72 deletions(-)

diff --git a/monitor/display.h b/monitor/display.h
index ee076448cc31..5f83a9a18273 100644
--- a/monitor/display.h
+++ b/monitor/display.h
@@ -11,6 +11,7 @@
 
 #include <stdbool.h>
 #include <inttypes.h>
+#include <ctype.h>
 
 bool use_color(void);
 
@@ -76,18 +77,50 @@ static inline uint64_t print_bitfield(int indent, uint64_t val,
 	return mask;
 }
 
+static inline void print_hexdump(const unsigned char *buf, uint16_t len)
+{
+	static const char hexdigits[] = "0123456789abcdef";
+	char str[68];
+	uint16_t i;
+
+	if (!len)
+		return;
+
+	for (i = 0; i < len; i++) {
+		str[((i % 16) * 3) + 0] = hexdigits[buf[i] >> 4];
+		str[((i % 16) * 3) + 1] = hexdigits[buf[i] & 0xf];
+		str[((i % 16) * 3) + 2] = ' ';
+		str[(i % 16) + 49] = isprint(buf[i]) ? buf[i] : '.';
+
+		if ((i + 1) % 16 == 0) {
+			str[47] = ' ';
+			str[48] = ' ';
+			str[65] = '\0';
+			print_text(COLOR_WHITE, "%s", str);
+			str[0] = ' ';
+		}
+	}
+
+	if (i % 16 > 0) {
+		uint16_t j;
+		for (j = (i % 16); j < 16; j++) {
+			str[(j * 3) + 0] = ' ';
+			str[(j * 3) + 1] = ' ';
+			str[(j * 3) + 2] = ' ';
+			str[j + 49] = ' ';
+		}
+		str[47] = ' ';
+		str[48] = ' ';
+		str[65] = '\0';
+		print_text(COLOR_WHITE, "%s", str);
+	}
+}
+
 static inline void print_hex_field(const char *label, const uint8_t *data,
 								uint8_t len)
 {
-	char str[len * 2 + 1];
-	uint8_t i;
-
-	str[0] = '\0';
-
-	for (i = 0; i < len; i++)
-		sprintf(str + (i * 2), "%2.2x", data[i]);
-
-	print_field("%s[%u]: %s", label, len, str);
+	print_field("%s[%u]:", label, len);
+	print_hexdump(data, len);
 }
 
 void set_default_pager_num_columns(int num_columns);
diff --git a/monitor/packet.c b/monitor/packet.c
index 807d32e9b447..3ba33f8f3afa 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3933,13 +3933,16 @@ static void print_transport_data(const uint8_t *data, uint8_t len)
 	print_hex_field("  Data", data + 3, len - 3);
 }
 
-static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
+static void print_eir(const char *label, const uint8_t *eir, uint8_t eir_len,
+			bool le)
 {
 	uint16_t len = 0;
 
 	if (eir_len == 0)
 		return;
 
+	print_hex_field(label, eir, eir_len);
+
 	while (len < eir_len - 1) {
 		uint8_t field_len = eir[0];
 		const uint8_t *data = &eir[2];
@@ -4221,7 +4224,7 @@ void packet_print_rssi(const char *label, int8_t rssi)
 
 void packet_print_ad(const void *data, uint8_t size)
 {
-	print_eir(data, size, true);
+	print_eir("Advertising Data", data, size, true);
 }
 
 struct broadcast_message {
@@ -4273,41 +4276,7 @@ static void print_3d_broadcast(const void *data, uint8_t size)
 
 void packet_hexdump(const unsigned char *buf, uint16_t len)
 {
-	static const char hexdigits[] = "0123456789abcdef";
-	char str[68];
-	uint16_t i;
-
-	if (!len)
-		return;
-
-	for (i = 0; i < len; i++) {
-		str[((i % 16) * 3) + 0] = hexdigits[buf[i] >> 4];
-		str[((i % 16) * 3) + 1] = hexdigits[buf[i] & 0xf];
-		str[((i % 16) * 3) + 2] = ' ';
-		str[(i % 16) + 49] = isprint(buf[i]) ? buf[i] : '.';
-
-		if ((i + 1) % 16 == 0) {
-			str[47] = ' ';
-			str[48] = ' ';
-			str[65] = '\0';
-			print_text(COLOR_WHITE, "%s", str);
-			str[0] = ' ';
-		}
-	}
-
-	if (i % 16 > 0) {
-		uint16_t j;
-		for (j = (i % 16); j < 16; j++) {
-			str[(j * 3) + 0] = ' ';
-			str[(j * 3) + 1] = ' ';
-			str[(j * 3) + 2] = ' ';
-			str[j + 49] = ' ';
-		}
-		str[47] = ' ';
-		str[48] = ' ';
-		str[65] = '\0';
-		print_text(COLOR_WHITE, "%s", str);
-	}
+	print_hexdump(buf, len);
 }
 
 void packet_control(struct timeval *tv, struct ucred *cred,
@@ -6042,7 +6011,7 @@ static void read_ext_inquiry_response_rsp(uint16_t index, const void *data,
 
 	print_status(rsp->status);
 	print_fec(rsp->fec);
-	print_eir(rsp->data, sizeof(rsp->data), false);
+	print_eir("EIR", rsp->data, sizeof(rsp->data), false);
 }
 
 static void write_ext_inquiry_response_cmd(uint16_t index, const void *data,
@@ -6051,7 +6020,7 @@ static void write_ext_inquiry_response_cmd(uint16_t index, const void *data,
 	const struct bt_hci_cmd_write_ext_inquiry_response *cmd = data;
 
 	print_fec(cmd->fec);
-	print_eir(cmd->data, sizeof(cmd->data), false);
+	print_eir("EIR", cmd->data, sizeof(cmd->data), false);
 }
 
 static void refresh_encrypt_key_cmd(uint16_t index, const void *data,
@@ -7240,7 +7209,7 @@ static void le_set_adv_data_cmd(uint16_t index, const void *data, uint8_t size)
 	const struct bt_hci_cmd_le_set_adv_data *cmd = data;
 
 	print_field("Length: %d", cmd->len);
-	print_eir(cmd->data, cmd->len, true);
+	packet_print_ad(cmd->data, cmd->len);
 }
 
 static void le_set_scan_rsp_data_cmd(uint16_t index, const void *data,
@@ -7249,7 +7218,7 @@ static void le_set_scan_rsp_data_cmd(uint16_t index, const void *data,
 	const struct bt_hci_cmd_le_set_scan_rsp_data *cmd = data;
 
 	print_field("Length: %d", cmd->len);
-	print_eir(cmd->data, cmd->len, true);
+	print_eir("Scan Response", cmd->data, cmd->len, true);
 }
 
 static void le_set_adv_enable_cmd(uint16_t index, const void *data,
@@ -8071,7 +8040,7 @@ static void le_set_ext_adv_data_cmd(uint16_t index, const void *data,
 
 	print_field("Fragment preference: %s (0x%2.2x)", str,
 						cmd->fragment_preference);
-	print_field("Data length: 0x%2.2x", cmd->data_len);
+	print_field("Data length: %u", cmd->data_len);
 	packet_print_ad(cmd->data, size - sizeof(*cmd));
 }
 
@@ -8120,7 +8089,7 @@ static void le_set_ext_scan_rsp_data_cmd(uint16_t index, const void *data,
 
 	print_field("Fragment preference: %s (0x%2.2x)", str,
 						cmd->fragment_preference);
-	print_field("Data length: 0x%2.2x", cmd->data_len);
+	print_field("Data length: %u", cmd->data_len);
 	packet_print_ad(cmd->data, size - sizeof(*cmd));
 }
 
@@ -8233,8 +8202,8 @@ static void le_set_pa_data_cmd(uint16_t index, const void *data, uint8_t size)
 	}
 
 	print_field("Operation: %s (0x%2.2x)", str, cmd->operation);
-	print_field("Data length: 0x%2.2x", cmd->data_len);
-	print_eir(cmd->data, cmd->data_len, true);
+	print_field("Data length: %u", cmd->data_len);
+	print_eir("Data", cmd->data, size - sizeof(*cmd), true);
 }
 
 static void le_set_pa_enable_cmd(uint16_t index, const void *data, uint8_t size)
@@ -11619,7 +11588,7 @@ static void ext_inquiry_result_evt(struct timeval *tv, uint16_t index,
 	print_dev_class(evt->dev_class);
 	print_clock_offset(evt->clock_offset);
 	print_rssi(evt->rssi);
-	print_eir(evt->data, sizeof(evt->data), false);
+	print_eir("EIR", evt->data, sizeof(evt->data), false);
 }
 
 static void encrypt_key_refresh_complete_evt(struct timeval *tv, uint16_t index,
@@ -12025,8 +11994,8 @@ report:
 	print_adv_event_type("Event type", evt->event_type);
 	print_peer_addr_type("Address type", evt->addr_type);
 	print_addr("Address", evt->addr, evt->addr_type);
-	print_field("Data length: %d", evt->data_len);
-	print_eir(evt->data, evt->data_len, true);
+	print_field("Data length: %u", evt->data_len);
+	packet_print_ad(evt->data, evt->data_len);
 
 	rssi = (int8_t *) (evt->data + evt->data_len);
 	print_rssi(*rssi);
@@ -12345,10 +12314,9 @@ static void le_ext_adv_report_evt(struct timeval *tv, uint16_t index,
 						report->direct_addr_type);
 		print_addr("  Direct address", report->direct_addr,
 						report->direct_addr_type);
-		print_field("  Data length: 0x%2.2x", report->data_len);
+		print_field("  Data length: %u", report->data_len);
 		data += sizeof(struct bt_hci_le_ext_adv_report);
-		packet_hexdump(data, report->data_len);
-		print_eir(data, report->data_len, true);
+		packet_print_ad(data, report->data_len);
 		data += report->data_len;
 	}
 }
@@ -12431,8 +12399,8 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 	}
 
 	print_field("Data status: %s%s%s", color_on, str, COLOR_OFF);
-	print_field("Data length: 0x%2.2x", evt->data_len);
-	print_eir(evt->data, evt->data_len, true);
+	print_field("Data length: %u", evt->data_len);
+	print_eir("Data", evt->data, evt->data_len, true);
 }
 
 static void le_pa_sync_lost_evt(struct timeval *tv, uint16_t index,
@@ -15784,7 +15752,7 @@ static void mgmt_read_local_oob_ext_data_rsp(const void *data, uint16_t size)
 
 	mgmt_print_address_type(type);
 	print_field("Data length: %u", data_len);
-	print_eir(data + 3, size - 3, true);
+	print_eir("Data", data + 3, size - 3, true);
 }
 
 static void mgmt_read_advertising_features_rsp(const void *data, uint16_t size)
@@ -15828,9 +15796,10 @@ static void mgmt_add_advertising_cmd(const void *data, uint16_t size)
 	print_field("Duration: %u", duration);
 	print_field("Timeout: %u", timeout);
 	print_field("Advertising data length: %u", adv_data_len);
-	print_eir(data + 11, adv_data_len, false);
+	packet_print_ad(data + 11, adv_data_len);
 	print_field("Scan response length: %u", scan_rsp_len);
-	print_eir(data + 11 + adv_data_len, scan_rsp_len, false);
+	print_eir("Scan response", data + 11 + adv_data_len, scan_rsp_len,
+			false);
 }
 
 static void mgmt_add_advertising_rsp(const void *data, uint16_t size)
@@ -15904,7 +15873,7 @@ static void mgmt_read_ext_controller_info_rsp(const void *data, uint16_t size)
 	mgmt_print_settings("Supported settings", supported_settings);
 	mgmt_print_settings("Current settings", current_settings);
 	print_field("Data length: %u", data_len);
-	print_eir(data + 19, size - 19, false);
+	print_eir("Data", data + 19, size - 19, false);
 }
 
 static void mgmt_set_apperance_cmd(const void *data, uint16_t size)
@@ -16189,9 +16158,10 @@ static void mgmt_add_ext_adv_data_cmd(const void *data, uint16_t size)
 
 	print_field("Instance: %u", instance);
 	print_field("Advertising data length: %u", adv_data_len);
-	print_eir(data + 3, adv_data_len, false);
+	packet_print_ad(data + 3, adv_data_len);
 	print_field("Scan response length: %u", scan_rsp_len);
-	print_eir(data + 3 + adv_data_len, scan_rsp_len, false);
+	print_eir("Scan Response", data + 3 + adv_data_len, scan_rsp_len,
+			false);
 }
 
 static void mgmt_add_ext_adv_data_rsp(const void *data, uint16_t size)
@@ -16872,7 +16842,7 @@ static void mgmt_device_connected_evt(const void *data, uint16_t size)
 	mgmt_print_address(data, address_type);
 	mgmt_print_device_flags(flags);
 	print_field("Data length: %u", data_len);
-	print_eir(data + 13, size - 13, false);
+	print_eir("Data", data + 13, size - 13, false);
 }
 
 static void mgmt_device_disconnected_evt(const void *data, uint16_t size)
@@ -16966,7 +16936,7 @@ static void mgmt_device_found_evt(const void *data, uint16_t size)
 	print_rssi(rssi);
 	mgmt_print_device_flags(flags);
 	print_field("Data length: %u", data_len);
-	print_eir(data + 14, size - 14, false);
+	print_eir("Data", data + 14, size - 14, false);
 }
 
 static void mgmt_discovering_evt(const void *data, uint16_t size)
@@ -17081,7 +17051,7 @@ static void mgmt_local_oob_ext_data_updated_evt(const void *data, uint16_t size)
 
 	mgmt_print_address_type(type);
 	print_field("Data length: %u", data_len);
-	print_eir(data + 3, size - 3, true);
+	print_eir("Data", data + 3, size - 3, true);
 }
 
 static void mgmt_advertising_added_evt(const void *data, uint16_t size)
@@ -17103,7 +17073,7 @@ static void mgmt_ext_controller_info_changed_evt(const void *data, uint16_t size
 	uint16_t data_len = get_le16(data);
 
 	print_field("Data length: %u", data_len);
-	print_eir(data + 2, size - 2, false);
+	print_eir("Data", data + 2, size - 2, false);
 }
 
 static void mgmt_phy_changed_evt(const void *data, uint16_t size)
-- 
2.52.0

