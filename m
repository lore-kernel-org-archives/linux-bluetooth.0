Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7A21D3E8
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844223; cv=none; b=DZoRTIKvpgbV6Xe3R7H0ndJGECVHYQgwbVGCTfr+oGCK+0Tq514CmcjDMlMo9o+vy5+jSVkVXoBD/bBeZBz5E8GHop4KOn6L2P3pG3WHfPvtKLnD1ZLANrwZgBNt01BB4UqhB+0BbVdBXK84ASB6a9Jry6437XhC/ERG5dXDxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844223; c=relaxed/simple;
	bh=46jgwChTy9oouaOih4+ppJqjTTTcaRqhSu4DuvWDW8Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BfbhBMOF0YUJYeR+RJdgX0UmEknvc0TXIef8lpg/9Hs4A5Z5pucw1dlM3nMgEAsiwvfDtotniEKo8Kv3hbhgpc+BQlpyUH6aRJG8js/dUyHll3Z6/DntnvLaAS3lRJbaJ1LGUF+qqIPeJSDe8Y+eUevwXhO8/EKZQzZJGjJCfbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lrd0EO0A; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lrd0EO0A"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9350507caaaso419432241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761844220; x=1762449020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uL67FGCk/lr9u25lehd/nvHjiiHvswjlrIHTQYxUf7c=;
        b=Lrd0EO0APQAfYF+PujOxG4JEs7a5+c1fp46wVo/P911Rt1kxpUv4Btgad8buXs55FX
         TenvCjcZ2X6j7PDTjwPQZJf9yACK2nHRhSZ6NdvZVzsZ5SmEy4Ar+tixEjp/7xqUpi4w
         lBT7spRyaLsmMzb/NiWVGxFFQkhL+iChvvZdzo7MyZ2kmkoLjKiT1pDXpPnplC2eG71q
         H9/KlJoUmTGfThNGNZM/ul/fznPv3eLvOE76DEzyCsWtO5QLbNhfFD5UrQrdQAMET1iC
         fmkAOu3KRDR9ozudqROdb9gg0lCEqkAdrphOxtrfhQeM4NIc2oZMHW+WntaUFafYE6SE
         F87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761844220; x=1762449020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uL67FGCk/lr9u25lehd/nvHjiiHvswjlrIHTQYxUf7c=;
        b=rcwisCPKVi9DOEfgbLpyOBenS47DLcwDNhHOVpeWSj1kw1qcnfUNaXq2hfNkLuDC3F
         1bohonKfu27o+GEbrCjuMmgxF+eKbAs9wnLyLt1EQy+mtzIkORh5FaSDiTJOiBFpqilO
         vNH2A9s7xkIkdJAm99t4DxB1K/Nq+finWQgomCkrke17+cJ3Idx2nLg+w/+rxjwrTtvX
         b3VdygA+0XoBvDrT+UhTvYNbseZyE649Oh06Bh54WhNnhGoa16pMfxpXmWZpAhwFocx0
         jXnV5yA8Pu8PsGr96oi/dDaoef+y21Lzw1a3mVoC+3Eqbw8d9as2qeZgqXNE1N3zPIWV
         BalA==
X-Gm-Message-State: AOJu0YwnCGMVLYmrMN0mLFkJoLfPJioVlzpbvFcOBWVBctpTCLoopun4
	N89U6K1o8RG/za3SYZCi6SCMM2p68ULKjXPjGUC+EkipTZyl0x06QRXsXdKEYEq9
X-Gm-Gg: ASbGncu7esnSROxOgh5MNsJQzCUiC0fsoWYYrfPw/CcZfZi067z2alrs2CGngnKqhdf
	K5nOn0ml4H5HaztgAx3iKMkrVtEHwmuf0mblF+ksehLV+hMrqEV6GI+XFfjigs4VqKDOixgPGW+
	K0ZNsFm6XZYRQJb6Y7Cg3GWx1BREBxW1FOG0PbxB23FZ6Qfrv4rFywxO+voTluBuxomkHSGrbKX
	kp3suaZx6gLDWeShm37rrA0piFkF+zGlyOtyuphKPpsTV7lPxR9DWqYu9Kl6E5T8mrySMuRSaUy
	+hXMhUYC4/H2QsplvfxLsfzObxWHsZ1IsHOYdhcAScon/zaHsCxAmb7B8H3hRwNJ47EPQyLJ7yC
	sLpZ37zV/uvzkbNSuntBJ4qLKDTdNo/zXLNdaNCHMH5mRurnfBqpJSdJa9hVHudeP4DPxQHofgp
	kNcmPTcNpsje5YQw==
X-Google-Smtp-Source: AGHT+IGncBoumgMXTsQScLbqSxNVmtTsc/8kVR3QZ/irGl1MTWkFUkhFDIAkE8GdW7I9myjAxALNuQ==
X-Received: by 2002:a05:6102:cc6:b0:5db:26e6:68d5 with SMTP id ada2fe7eead31-5dbb12fbeaamr107316137.27.1761844220091;
        Thu, 30 Oct 2025 10:10:20 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5db4e4e3b4fsm6277463137.1.2025.10.30.10.10.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:10:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] monitor: Add decoding support for LL Extended Feature Set
Date: Thu, 30 Oct 2025 13:10:09 -0400
Message-ID: <20251030171009.253408-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for decoding LL Extended Feature Set introduced in 6.0
that adds the following:

Commands:

 - HCI_LE_Read_All_Local_Supported_­Features(0x2087)(Feature:47,1)
 - HCI_LE_Read_All_Remote_Features(0x2088)(Feature:47,2)

Events:

 - HCI_LE_Read_All_Remote_Features_Complete(0x2b)(Mask bit:42)
---
 monitor/bt.h     |  24 +++++++
 monitor/packet.c | 160 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 166 insertions(+), 18 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index ca91f7fefc84..9ca3e7c88fb1 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2952,6 +2952,21 @@ struct bt_hci_rsp_le_read_iso_link_quality {
 	uint32_t duplicated_packets;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_READ_ALL_LOCAL_FEATURES	0x2087
+#define BT_HCI_BIT_LE_READ_ALL_LOCAL_FEATURES	BT_HCI_CMD_BIT(47, 2)
+struct bt_hci_rsp_le_read_all_local_features {
+	uint8_t  status;
+	uint8_t  page;
+	uint8_t  features[248];
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_READ_ALL_REMOTE_FEATURES	0x2088
+#define BT_HCI_BIT_LE_READ_ALL_REMOTE_FEATURES	BT_HCI_CMD_BIT(47, 3)
+struct bt_hci_cmd_le_read_all_remote_features {
+	uint16_t handle;
+	uint8_t  pages;
+} __attribute__ ((packed));
+
 #define BT_HCI_CMD_LE_CS_RD_LOC_SUPP_CAP	0x2089
 #define BT_HCI_BIT_LE_CS_RD_LOC_SUPP_CAP	BT_HCI_CMD_BIT(20, 5)
 struct bt_hci_rsp_le_cs_rd_loc_supp_cap {
@@ -3990,6 +4005,15 @@ struct bt_hci_evt_le_big_info_adv_report {
 	uint8_t  encryption;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_READ_ALL_REMOTE_FEATURES_COMPLETE	0x2B
+struct bt_hci_evt_le_read_all_remote_features_complete {
+	uint8_t  status;
+	uint16_t handle;
+	uint8_t  max_pages;
+	uint8_t  valid_pages;
+	uint8_t  features[248];
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE	(0x2C)
 struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete {
 	uint8_t status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 22708689fe03..b4da6653f4a2 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2765,7 +2765,7 @@ static const struct bitfield_data features_page2[] = {
 	{ }
 };
 
-static const struct bitfield_data features_le[] = {
+static const struct bitfield_data features_le_0[] = {
 	{  0, "LE Encryption"					},
 	{  1, "Connection Parameter Request Procedure"		},
 	{  2, "Extended Reject Indication"			},
@@ -2806,9 +2806,24 @@ static const struct bitfield_data features_le[] = {
 	{ 37, "Connection Subrating"				},
 	{ 38, "Connection Subrating (Host Support)"		},
 	{ 39, "Channel Classification"				},
+	{ 40, "Advertising Coding Selection"			},
+	{ 41, "Advertising Coding Selection (Host Support)"	},
+	{ 42, "Decision-Based Advertising Filtering"		},
+	{ 43, "Periodic Advertising with Responses - Advertiser"},
+	{ 44, "Periodic Advertising with Responses - Scanner"	},
+	{ 45, "Unsegmented Framed Mode"				},
+	{ 46, "Channel Sounding"				},
+	{ 47, "Channel Sounding (Host Support)"			},
+	{ 48, "Channel Sounding Tone Quality Indication"	},
+	{ 63, "LL Extended Feature Set"				},
 	{ }
 };
 
+static const struct bitfield_data features_le_1[] = {
+	{ 0, "Monitoring Advertisers"				},
+	{ 1, "Frame Space Update"				},
+};
+
 static const struct bitfield_data features_msft[] = {
 	{  0, "RSSI Monitoring feature for BR/EDR"		},
 	{  1, "RSSI Monitoring feature for LE connections"	},
@@ -2819,20 +2834,35 @@ static const struct bitfield_data features_msft[] = {
 	{ }
 };
 
+static void print_features_subpage(uint8_t subpages,
+					const uint8_t *features_array,
+					uint64_t *features)
+{
+	int i, j;
+	char str[16];
+
+	for (i = 0; i < subpages; i++) {
+		for (j = 0; j < 8; j++)
+			features[i] |= ((uint64_t) features_array[i * 8 + j])
+					<< (j * 8);
+		sprintf(str, "Features[%u]", i);
+		print_hex_field(str, &features_array[i * 8], 8);
+	}
+}
+
 static void print_features(uint8_t page, const uint8_t *features_array,
 								uint8_t type)
 {
 	const struct bitfield_data *features_table = NULL;
-	uint64_t mask, features = 0;
-	char str[41];
+	uint64_t mask, features[3] = {};
+	uint8_t subpages = 1;
 	int i;
 
-	for (i = 0; i < 8; i++) {
-		sprintf(str + (i * 5), " 0x%2.2x", features_array[i]);
-		features |= ((uint64_t) features_array[i]) << (i * 8);
-	}
+	/* LE pages 1-10 are 192 bits (24 octets) each */
+	if (type == 0x01 && page)
+		subpages = 3;
 
-	print_field("Features:%s", str);
+	print_features_subpage(subpages, features_array, features);
 
 	switch (type) {
 	case 0x00:
@@ -2851,8 +2881,10 @@ static void print_features(uint8_t page, const uint8_t *features_array,
 	case 0x01:
 		switch (page) {
 		case 0:
-			features_table = features_le;
+			features_table = features_le_0;
 			break;
+		case 1:
+			features_table = features_le_1;
 		}
 		break;
 	case 0xf0:
@@ -2867,10 +2899,13 @@ static void print_features(uint8_t page, const uint8_t *features_array,
 	if (!features_table)
 		return;
 
-	mask = print_bitfield(2, features, features_table);
-	if (mask)
-		print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown features "
-						"(0x%16.16" PRIx64 ")", mask);
+	for (i = 0; i < subpages; i++) {
+		mask = print_bitfield(2, features[i], features_table);
+		if (mask)
+			print_text(COLOR_UNKNOWN_FEATURE_BIT,
+				"  Unknown features (0x%16.16" PRIx64 ")",
+				mask);
+	}
 }
 
 void packet_print_features_lmp(const uint8_t *features, uint8_t page)
@@ -3199,11 +3234,29 @@ static const struct bitfield_data events_le_table[] = {
 	{ 27, "LE Terminate BIG Complete"		},
 	{ 28, "LE BIG Sync Established Complete"	},
 	{ 29, "LE BIG Sync Lost"			},
-	{ 30, "LE Request Peer SCA Complete"},
-	{ 31, "LE Path Loss Threshold"		},
-	{ 32, "LE Transmit Power Reporting"	},
-	{ 33, "LE BIG Info Advertising Report"	},
+	{ 30, "LE Request Peer SCA Complete"		},
+	{ 31, "LE Path Loss Threshold"			},
+	{ 32, "LE Transmit Power Reporting"		},
+	{ 33, "LE BIG Info Advertising Report"		},
 	{ 34, "LE Subrate Change"			},
+	{ 35, "LE Periodic Advertising Sync Established v2"},
+	{ 36, "LE Periodic Advertising Report v2"	},
+	{ 37, "LE Periodic Advertising Sync Transfer Received" },
+	{ 38, "LE Periodic Advertising Subevent Data Request" },
+	{ 39, "LE Periodic Advertising Response Report" },
+	{ 40, "LE Enhanced Connection Complete v2"	},
+	{ 41, "LE CIS Established v2"			},
+	{ 42, "LE Read All Remote Features Complete"	},
+	{ 43, "LE CS Read Remote Supported Capabilities Complete" },
+	{ 44, "LE CS Read Remote FAE Table Complete"	},
+	{ 45, "LE CS Security Enable Complete"		},
+	{ 46, "LE CS Config Complete"			},
+	{ 47, "LE CS Procedure Enable Complete"		},
+	{ 48, "LE CS Subevent Result"			},
+	{ 49, "LE CS Subevent Result Continue"		},
+	{ 50, "LE CS Test End Complete"			},
+	{ 51, "LE Monitored Advertisers Report"		},
+	{ 52, "LE Frame Space Update Complete"		},
 	{ }
 };
 
@@ -9128,7 +9181,7 @@ static void le_set_host_feature_cmd(uint16_t index, const void *data,
 	print_field("Bit Number: %u", cmd->bit_number);
 
 	mask = print_bitfield(2, (((uint64_t) 1) << cmd->bit_number),
-							features_le);
+							features_le_0);
 	if (mask)
 		print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown features "
 						"(0x%16.16" PRIx64 ")", mask);
@@ -9167,6 +9220,41 @@ static void status_le_read_iso_link_quality_rsp(uint16_t index,
 	print_field("Duplicated packets %d", rsp->duplicated_packets);
 }
 
+static void print_le_ext_features(const uint8_t features[248], uint8_t pages)
+{
+	int i;
+
+	/* Page 0 containing bits 0 to 63 (octets 0 to 7) */
+	print_features(0, features, 0x01);
+
+	/* 10 pages of 192 bits (24 octets) each */
+	for (i = 0; i < pages && i < 10; i++)
+		print_features(i + 1, &features[i * 24 + 8], 0x01);
+}
+
+static void le_read_all_local_features_rsp(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_all_local_features *rsp = data;
+
+	print_status(rsp->status);
+
+	if (size == 1)
+		return;
+
+	print_field("Page: %d", rsp->page);
+	print_le_ext_features(rsp->features, rsp->page);
+}
+
+static void le_read_all_remote_features(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_cmd_le_read_all_remote_features *cmd = data;
+
+	print_handle(cmd->handle);
+	print_field("Pages: %d", cmd->pages);
+}
+
 static const struct bitfield_data cs_roles_supp_table[] = {
 	{ 0, "Initiator"	},
 	{ 1, "Reflector"	},
@@ -10629,6 +10717,19 @@ static const struct opcode_data opcode_table[] = {
 				sizeof(
 				struct bt_hci_rsp_le_read_iso_link_quality),
 				true },
+	{ BT_HCI_CMD_LE_READ_ALL_LOCAL_FEATURES,
+			BT_HCI_BIT_LE_READ_ALL_LOCAL_FEATURES,
+			"LE Read All Local Features",
+			null_cmd, 0, true,
+			le_read_all_local_features_rsp,
+			sizeof(struct bt_hci_rsp_le_read_all_local_features),
+			true },
+	{ BT_HCI_CMD_LE_READ_ALL_REMOTE_FEATURES,
+			BT_HCI_BIT_LE_READ_ALL_REMOTE_FEATURES,
+			"LE Read All Remote Features",
+			le_read_all_remote_features,
+			sizeof(struct bt_hci_cmd_le_read_all_remote_features),
+			true, status_rsp, 1, true },
 	{ BT_HCI_CMD_LE_CS_RD_LOC_SUPP_CAP, BT_HCI_BIT_LE_CS_RD_LOC_SUPP_CAP,
 				"LE CS Read Local Supported Capabilities",
 				NULL, 0, false,
@@ -12558,6 +12659,24 @@ static void le_big_info_evt(struct timeval *tv, uint16_t index,
 	print_field("Encryption: 0x%02x", evt->encryption);
 }
 
+static void le_read_all_remote_features_complete_evt(struct timeval *tv,
+					uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_evt_le_read_all_remote_features_complete *evt =
+									data;
+
+	print_status(evt->status);
+
+	if (size == 1)
+		return;
+
+	print_handle(evt->handle);
+	print_field("Max Pages: 0x%2.2x", evt->max_pages);
+	print_field("Valid Pages: 0x%2.2x", evt->valid_pages);
+	print_le_ext_features(evt->features, evt->valid_pages);
+}
+
 static void le_cs_rd_rem_supp_cap_complete_evt(struct timeval *tv,
 				uint16_t index, const void *data, uint8_t size)
 {
@@ -13325,6 +13444,11 @@ static const struct subevent_data le_meta_event_table[] = {
 		"LE Broadcast Isochronous Group Info Advertising Report",
 		le_big_info_evt,
 		sizeof(struct bt_hci_evt_le_big_info_adv_report) },
+	{ BT_HCI_EVT_LE_READ_ALL_REMOTE_FEATURES_COMPLETE,
+		"LE CS Read All Remote Features Complete",
+		le_read_all_remote_features_complete_evt,
+		sizeof(struct bt_hci_evt_le_read_all_remote_features_complete),
+		true },
 	{ BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE,
 		"LE CS Read Remote Supported Capabilities Complete",
 		le_cs_rd_rem_supp_cap_complete_evt,
-- 
2.51.0

