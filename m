Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7E51531D5
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158967; cv=none; b=SLVt0SVQYeQHmMpsSdbycBIGQ19nlUOX2LvAP6PNa5eW/9P0xl6CGQFtHAv4lc4vaDVI06oqIohKQgIiyeeQOIWBE3UQbfGVDbAyJd+B2iJpyvFSRU+yMpc60EJiPeBizdlyViGcsQQkk5PchrKlDW2OKLOTfsMVHWDnmLSdOuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158967; c=relaxed/simple;
	bh=dwfiNpbR8FWRjhl6Cw1WWo060CRXwewsTEIL2noSUUs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6qx5UcwSSOoklgvj/CenGEPfQIj6GMaJx5exTca9hlrNIvI0PgrSlS46Qs9sPQ3ur2u9+SLix1w1/l4D3VfrMYmT9jkyVBbb+WQl1wdGhSJeIAtjg4AlYKOqKYxl2UqiYJ7tXNl4FwtJEhoY6yB6n/jELkGkCtsl1CPwX96hYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfYKa6Rd; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfYKa6Rd"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-52446b21cfdso2350440e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747158964; x=1747763764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrS4sJUQe/3hkfd2DxR7n51Q33ZKkGHBvxnddJ0p8vs=;
        b=FfYKa6RdQWcLyvFoGuHz4oBAN9O3mfutg+nJ8R7HfQe2XcUe+/Ei2mCWWVBbzRpnAB
         OG3cVc1J/71YYEfRLNImfeMch2v8uhobivob+aK/juVvXLxqRsqa1ZI+wgxjXLOLtAG8
         MEh8WIQbRhKv6rA+kVMi6kArH2e12TFLA9/o/SlNmVtEobF7DBd+CPslhjgCC2+BATl1
         jID7XaeBLNXGZ19uUf2DJzS6xwaRBqnJoU2QJLevriWpFFxZy+eQ6I6mEXp/HojnDxG9
         h6emYWp6g5pUGPDo0ciWIntBA2NditoxvVSqDWOKmcWlqiaq7s4njSFmlLP0HDBebyRg
         lk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747158964; x=1747763764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrS4sJUQe/3hkfd2DxR7n51Q33ZKkGHBvxnddJ0p8vs=;
        b=C2mlD33DbRoqmW8HhHB1kLoLd+5XqKitRU6msbTRY2wm/uNXTUdxNCuSYnCHkQ5Rwn
         opq1REcWgnQYKceImdIflj1yNihBQD0FF0ha++ZSL5Mt00ZDi/8PD/UcuFM0UiUL3Vxz
         CAQ/ZkPF8fXX/ZloPAoN6YV0XLq81r4Qy8r2w31roLa6t39p94IAizRRVvzGGlk+4hcn
         rgZhLC4+kGukvLS85cRxWZ1psEnBuOKuvAYvQR/aFxqWpkyZySZOzMjhzQZr+qMgOh/i
         MSSKlmHc5w3D3ukHYEQNi3HclHkQ2I3G5Nz9Uwe+uNkYFPV81ccdWQyd/YqB8MlW6VA5
         zXnw==
X-Gm-Message-State: AOJu0YxEisfm2fjjnb/0fZtWoWm3yUQW+j8ezdP6oaNnKFigXBrvzbQ+
	+ZbXPYWwk/zNbIG/j9NHhR65Vi1/rO/YbugjKqfbOUBZF4MEwIqnf1zcduX3
X-Gm-Gg: ASbGncsHHRQh4ILUVu8Lu+YCiCHckT7OzGTcihGybVPU7Fe+2o0zWmLDx33HkA/euDK
	6omVGxuumHXtXNnYSpCIs2xP/FpCNys3ZJXa+voh3mgEukaOk6r5QhZk78aDNCS8utvrmJbfAvD
	u55ta6NCDTitGuH8dPOpi6KPWDiUFzDg3XMDWxRnPMNRosZT1BfnCk36RL0xWhpFNm3XeK2MeoA
	+nm20hYbpi0+JlbcNt2MMXpVF37XjNyYgXq3O/I7Ka4e7BdABlIhv89VeKCcsD4zfSPpJ8GJT50
	3Nwq6/YaJsdX3Rla9KlkIsRarfwghNx9VcsLPS/7s7VJv6ZI4aFhVIVlPbf3YQwimW8wkFYuyYQ
	6OV/GBSkPEZvrziclkNp4
X-Google-Smtp-Source: AGHT+IELaOGtZv9Et+65DZkpkzSHtu8/2V35ygPaAQ60OVM/dh4+vJcA1Rf6KxkcdJjJpUK5ZbdMPQ==
X-Received: by 2002:a05:6122:32ce:b0:526:720:704 with SMTP id 71dfb90a1353d-52d9c6ab501mr349912e0c.7.1747158963736;
        Tue, 13 May 2025 10:56:03 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c53726493sm7937360e0c.16.2025.05.13.10.56.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 10:56:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] monitor: Add decoding for FSU command and event
Date: Tue, 13 May 2025 13:56:00 -0400
Message-ID: <20250513175600.1158690-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513175600.1158690-1-luiz.dentz@gmail.com>
References: <20250513175600.1158690-1-luiz.dentz@gmail.com>
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

