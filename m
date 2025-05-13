Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0FA1531D5
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158893; cv=none; b=kbeJo+ksdEnb38em9W71YhuEKcbQsXBjD/LqdF+yBruB3RoAedn5Pi23dUx/Ypyw8yt4zK12SYJBy1t+WZrI7D9SHBw2y+4b0zCSzs983fsZaFcun2TMEYdXmWVkvxTMxS/Nun1MgqGmJuy+uDI6V1QkitS0y8Ih9whgIGWgQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158893; c=relaxed/simple;
	bh=dwfiNpbR8FWRjhl6Cw1WWo060CRXwewsTEIL2noSUUs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VKwRV6H8ctrQKAhPopVzAQedWkaTHkrHhzVkxuJSRTr42uMEz+wfG2mu75kcIgWOEWIEjjSdw1yd2od4mLD5zzo/JzzgO/rM+hLkTl1YJaRec+LxY5ksNMwmBI0AgSUScrOjm6VtdeOuATvje5JdGvGoAqJBR9Ky67WzLaSJgyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zkh7rx8J; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zkh7rx8J"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-52c764e94adso1076452e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747158889; x=1747763689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BrS4sJUQe/3hkfd2DxR7n51Q33ZKkGHBvxnddJ0p8vs=;
        b=Zkh7rx8J90fPIfsm8BWJ6QwsIKMQY0YP7nHD0fAScHhhbz2KHC4Mfm7bdQFL8EsoBd
         uTS4mTjQiuivfnkbCBlSnkLzrwsKRUcgIKEEWHWt6aUkZ0yVZEsfsCt5yrIZvuD/r8ge
         /Dc4wB04wyAiz8JdPInrU/7e74hpdM6v2lyw5DSWBXuE2HMn8FGPGKH83HIQ1byvFPXY
         IZIYvjibqhMipatX9jKCB21D63I2+ILE5kQJQbkjVyE1GbBPTFyv9S1jhIyqiNFuISB/
         hfOZ4ph9CUpnM1IoxB1yN1Q758yVTB46UPI3ptSknkpVC0uw4RkZr8TBKGvXSKcnS2+U
         9TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747158889; x=1747763689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrS4sJUQe/3hkfd2DxR7n51Q33ZKkGHBvxnddJ0p8vs=;
        b=wCng0lJZuX5xLj0iOhXPajO/sf+SQcGWqT2hhWe7dfgjTjc7WGjApnTdFnXaNvvenw
         agdn28YY46SpD1oPOegH0EAlyOJms6jXYiyyYnzDWVctn0r0EYCorKSPLipXh7hMQMlp
         capJJjptEFVo4hMDTcxxarJ0XZE4P6K7sHmCxfK4hCBsFSCTBzmejiL0MB+nld86h0cV
         3OU+kOhW9qPBV5CaizdQinzJqN2+iHBfExOOzk1nKZD0qVbrZpL2E1okA3XcgGZ6GdFP
         J9+YA20BDdL/UQrKVJR7cddvdRX5K56KOteBeHNVIrt5jc2BCmbSXCgqEKq2HYmWDlM+
         kQjw==
X-Gm-Message-State: AOJu0YxGVnN3FoDC844WeExXq6Ix4mnK5LPsNbLx+XJKjwdlrrtAx6pV
	ODSmOHuqaxkQuWizCIHECRNS4b08JypEOnyuNKAfM3dWYvf+5ZG6dr4o/oL9
X-Gm-Gg: ASbGncu+X87f8xd/5p0tuqlAkGrNYKP8RIrA2T6LOxN2Bf9RYbO9GnQNPX4b/BN5QBH
	8Z7czbmCL1EL3oVYHPzw9ToHhNJOGrKGSSeENGpB/VuwIQ12unQjKGQzQNY0W4/odIIzGg/eVAO
	xa3BuYt25TM+Vi1HwoQD+DcU1U1jgccwwcVKjerYi3upip6HNMovSYvhTxCB07dU/BGVvkkib6d
	v1q3BtkYHhHBXwdKluu2scMes0YIGu/abY36AkemDdhqahmE29HKNKtQKfZzsvXpYWvWr0Fw8S2
	PWJhu1W3ZFDaeyj89nE7qIvlNhWMHI466rC+3/NTad0U+bbOlZtBkmZ5dtUSnQIc3WPZjJ3pzAY
	R5VGPxSwKEKMsWriLYYsL
X-Google-Smtp-Source: AGHT+IHzEaFYCZUMZ7DoNmj09Q5x0ANWGaNZjQXyLTc9QK590svGO/M1QM0q3ke/NgsZmLWzY8/+3Q==
X-Received: by 2002:a05:6122:a18:b0:52a:ee1a:4249 with SMTP id 71dfb90a1353d-52d9c67f480mr360731e0c.7.1747158889377;
        Tue, 13 May 2025 10:54:49 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c5372f0e0sm7938621e0c.19.2025.05.13.10.54.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 10:54:48 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Add decoding for FSU command and event
Date: Tue, 13 May 2025 13:54:47 -0400
Message-ID: <20250513175447.1154655-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds decoding for FSU command and event as defined in the Bluetooth
Core 6.0 specification:

$ tools/hcitool cmd 0x08 0x009d 0xff 0xff 0x00 0x00 0x00 0x00 0x01 0x03
< HCI Command: LE Frame Space Update (0x08|0x009d) plen 8
        Handle: 65535 Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Frame Space min: 0 us (0x0000)
        Frame Space max: 0 us (0x0000)
        PHYs: LE 1M (0x01)
        types: 0x03
          T_IFS_ACL_CP
          T_IFS_ACL_PC
---
 monitor/packet.c | 107 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 94 insertions(+), 13 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index e16af112feed..149eabad0661 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7632,6 +7632,18 @@ static const struct bitfield_data le_phys[] = {
 	{ }
 };
 
+static void print_le_phy_bitfield(const char *label, uint8_t phys)
+{
+	uint8_t mask;
+
+	print_field("%s: 0x%2.2x", label, phys);
+
+	mask = print_bitfield(2, phys, le_phys);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+}
+
 static const struct bitfield_data le_phy_preference[] = {
 	{  0, "No TX PHY preference"	},
 	{  1, "No RX PHY preference"	},
@@ -7650,19 +7662,8 @@ static void print_le_phys_preference(uint8_t all_phys, uint8_t tx_phys,
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
 
-	print_field("TX PHYs preference: 0x%2.2x", tx_phys);
-
-	mask = print_bitfield(2, tx_phys, le_phys);
-	if (mask)
-		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
-							" (0x%2.2x)", mask);
-
-	print_field("RX PHYs preference: 0x%2.2x", rx_phys);
-
-	mask = print_bitfield(2, rx_phys, le_phys);
-	if (mask)
-		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
-							" (0x%2.2x)", mask);
+	print_le_phy_bitfield("TX PHYs preference", tx_phys);
+	print_le_phy_bitfield("RX PHYs preference", rx_phys);
 }
 
 static void le_set_default_phy_cmd(uint16_t index, const void *data,
@@ -9079,6 +9080,42 @@ static void status_le_read_iso_link_quality_rsp(uint16_t index,
 	print_field("Duplicated packets %d", rsp->duplicated_packets);
 }
 
+static const struct bitfield_data fsu_type_table[] = {
+	{  0, "T_IFS_ACL_CP"		},
+	{  1, "T_IFS_ACL_PC"		},
+	{  2, "T_MCES"			},
+	{  3, "T_IFS_CIS"		},
+	{  4, "T_MSS_CIS"		},
+	{ }
+};
+
+static void print_fsu_types(uint8_t types)
+{
+	uint8_t mask;
+
+	print_field("types: 0x%2.2x", types);
+
+	mask = print_bitfield(2, types, fsu_type_table);
+	if (mask)
+		print_text(COLOR_UNKNOWN_ADDRESS_TYPE, "  Unknown type"
+							" (0x%2.2x)", mask);
+}
+
+static void le_fsu_cmd(uint16_t index, const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_fsu *cmd = data;
+
+	print_handle(cmd->handle);
+	print_field("Frame Space min: %d us (0x%4.4x)",
+				le16_to_cpu(cmd->frame_space_min),
+				le16_to_cpu(cmd->frame_space_min));
+	print_field("Frame Space max: %d us (0x%4.4x)",
+				le16_to_cpu(cmd->frame_space_max),
+				le16_to_cpu(cmd->frame_space_max));
+	print_le_phy_bitfield("PHYs", cmd->phys);
+	print_fsu_types(cmd->types);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -10038,6 +10075,10 @@ static const struct opcode_data opcode_table[] = {
 				sizeof(
 				struct bt_hci_rsp_le_read_iso_link_quality),
 				true },
+	{ BT_HCI_CMD_LE_FSU, BT_HCI_BIT_LE_FSU,
+				"LE Frame Space Update", le_fsu_cmd,
+				sizeof(struct bt_hci_cmd_le_fsu),
+				true, status_rsp, 1, true },
 	{ }
 };
 
@@ -11857,6 +11898,43 @@ static void le_big_info_evt(struct timeval *tv, uint16_t index,
 	print_field("Encryption: 0x%02x", evt->encryption);
 }
 
+static void print_fsu_initiator(uint8_t initiator)
+{
+	const char *str;
+
+	switch (initiator) {
+	case 0x00:
+		str = "Local Host initiated";
+		break;
+	case 0x01:
+		str = "Local Controller initiated";
+		break;
+	case 0x02:
+		str = "Peer initiated";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("initiator: %s (0x%2.2x)", str, initiator);
+}
+
+static void le_fsu_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_fsu_complete *evt = data;
+
+	print_status(evt->status);
+	print_handle(evt->handle);
+	print_fsu_initiator(evt->initiator);
+	print_field("Frame Space: %u us (0x%4.4x)",
+				le16_to_cpu(evt->frame_space),
+				le16_to_cpu(evt->frame_space));
+	print_le_phy_bitfield("PHYs", evt->phys);
+	print_fsu_types(evt->types);
+}
+
 struct subevent_data {
 	uint8_t subevent;
 	const char *str;
@@ -11981,6 +12059,9 @@ static const struct subevent_data le_meta_event_table[] = {
 		"LE Broadcast Isochronous Group Info Advertising Report",
 		le_big_info_evt,
 		sizeof(struct bt_hci_evt_le_big_info_adv_report) },
+	{ BT_HCI_EVT_LE_FSU_COMPLETE,
+		"LE Frame Space Update Complete",
+		le_fsu_evt, sizeof(struct bt_hci_evt_le_fsu_complete) },
 	{ }
 };
 
-- 
2.49.0

