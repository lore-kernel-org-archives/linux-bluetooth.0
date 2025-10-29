Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26B7262E
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768996; cv=none; b=sxfAAOAC9N7Otozd6gu0COUR5DjN1uABl3B/RBxlPMaKHOVtBEAQj+IDfDKSmE/XnsNaAlbxWh5XgmuFHtFVhshiseh7jckY7Pu8jBMI6loNXWNguBjeMfkIkiTWy8hgbfYjN2Fzm4U0FLRTJSXSQlUOrSsIUkyTdPyUfMddOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768996; c=relaxed/simple;
	bh=CvN8+gOPKBqzzK/Lm5Oc/+S0Q2VksfkYNSyIxUUC5ug=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K4wXRrjONOvm6RpveuuaehVF+3E0yl0z49g50TxsdbTY7S8wyI6mQFpg03XqQOOKOlX6U223o/266ED2UciNaUj/K7Rq5wM+gCc2QCgggKc3iHbbABVqA5eLQA7olfysLCFS9vwM7w6No6YYZSY9HEe0KvMFbLn0vjZsZ+oS0Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHjAPFww; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHjAPFww"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-932bc48197bso148709241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 13:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761768993; x=1762373793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0G7hmQ17NzpuTMO5uWrsaj1+w+QCPoV76XNUqinlgEw=;
        b=AHjAPFwwixh4+U6ty1RbwLgO8V+rmxG+NwsmKb2pL5qWxOXT777+gkKS2z9BPQS/pz
         y0C/1yqGUPsVwxhNRZ24WjyMruno6nJ8EMpBwVkbZJ0/NX8sfdOn1GRXwbZRWzobj1M6
         yPqRmtLgtOxQw/vcgAYUVYCsAgq/2RgXv7AghiwSz9vHq6puq86mvOLf8bnHw6uZUNS0
         dbEeUsiSQae2GLe5YhZxi3FaPKtPZERMKl3pc2CANUHLNv2L62OE5oDtdPM2h28fFMhS
         tBfa2SpoGixS0W4sfwdjszZ/iXx49wHSPFWtqGHaoa0BdnqswEKlHzPALz0r6izFbxWa
         FODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761768993; x=1762373793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0G7hmQ17NzpuTMO5uWrsaj1+w+QCPoV76XNUqinlgEw=;
        b=qSqqvsrZomWGI9xgHAWzTYf/N+R5eZDru1hTo6z//f/42E3vn+acbxzzJb4xar5MMD
         8ghZEcDxdC5WO30GzLFqF8E7+lzgg6t8mBn977p/j6Y7s1D8rBGlqFSS3MHaDjfOzTWR
         78CI34UovcMmA2iQoVEQz4w8bvaPS8HbG+ABHjHBiTJgxDlm1RaCKHxALH4Lg23BdZQ5
         uSeZPcJadFM5l+JedvA3Zw5lLIf3TDJrKJF4AguoFjedTukD6Y+SreybEq6INb0wKvBM
         lViEQA6lP8Lv94sqyEsAwTLTR9+fwZE5qTMAcELDS8RFottd0YN+97/daOxs+1C6n+/8
         1T9g==
X-Gm-Message-State: AOJu0YwywT1McmAUvc9OdF+9GklNCyqfKY+k7DUvxtFGj6ZZTa6gRJV+
	qcHVaQF208D1DhgdKIaWMSdc/8U+TTdVZzK8HBCA1Wd2EVOG3FRc/RpXjiXS8A==
X-Gm-Gg: ASbGncsFB9WtNgWo6otkruIbfu5CB62l7BtOuhM1qfb8knjy0/y5LK9wYl7qdn9hWj3
	k4+MeuktMR5Ov4P0Nt+FTmHZuz7X/Eo+hyfF1WsmuXL2G1QskXWqcqWUybFRndAZL1C40z4F7fi
	Ac+4Nuabg8wK9nmn/H1uPfyBCW71GEe0R/wsLgx9RfUBnB2i2nfjMd6a4Toi2++aXOyIpgY0svb
	CJVCt48G4cQrW4N4hSovWcodvCyySfL2hlyuSYrqy3vezvpzTZuYpln1p+Wx6f/hJ5Bvsk/4E/p
	bx/gXnyfToJO2QJpu2/U0FxvFpgzdLZpEK3LWBfD2OxkEW5w1k2+IPOq8u44QxEj06EunBUSkNz
	dEwV9BhvAtUTanm7dRSKemW6z7Aa1Eec1Nac2AKrFLtwNpePaNQdxGHOfPQla0g5TjRdCic8jTJ
	pf6qA=
X-Google-Smtp-Source: AGHT+IE9Ns0NnOuy1P5uWWzIEQBr1cK8zPCPvr5yzCDed4ottF3R8wzoSvWUzkTdf6CVLFD9igSeOg==
X-Received: by 2002:a05:6122:3120:b0:557:2551:7e9f with SMTP id 71dfb90a1353d-558141bf8c8mr1744433e0c.14.1761768992548;
        Wed, 29 Oct 2025 13:16:32 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb06260sm5936764e0c.5.2025.10.29.13.16.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 13:16:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Add decoding support for LL Extended Feature Set
Date: Wed, 29 Oct 2025 16:16:24 -0400
Message-ID: <20251029201624.75933-1-luiz.dentz@gmail.com>
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
 monitor/bt.h     |  24 ++++++++++
 monitor/packet.c | 114 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 131 insertions(+), 7 deletions(-)

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
index 22708689fe03..60050129328b 100644
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
@@ -2851,8 +2866,10 @@ static void print_features(uint8_t page, const uint8_t *features_array,
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
@@ -3199,11 +3216,29 @@ static const struct bitfield_data events_le_table[] = {
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
 
@@ -9128,7 +9163,7 @@ static void le_set_host_feature_cmd(uint16_t index, const void *data,
 	print_field("Bit Number: %u", cmd->bit_number);
 
 	mask = print_bitfield(2, (((uint64_t) 1) << cmd->bit_number),
-							features_le);
+							features_le_0);
 	if (mask)
 		print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown features "
 						"(0x%16.16" PRIx64 ")", mask);
@@ -9167,6 +9202,32 @@ static void status_le_read_iso_link_quality_rsp(uint16_t index,
 	print_field("Duplicated packets %d", rsp->duplicated_packets);
 }
 
+static void le_read_all_local_features_rsp(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_all_local_features *rsp = data;
+	int i;
+
+	print_status(rsp->status);
+
+	if (size == 1)
+		return;
+
+	print_field("Page: %d", rsp->page);
+
+	for (i = 0; i < rsp->page; i++)
+		print_features(i, &rsp->features[i * 8], 0x01);
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
@@ -10629,6 +10690,19 @@ static const struct opcode_data opcode_table[] = {
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
@@ -12558,6 +12632,27 @@ static void le_big_info_evt(struct timeval *tv, uint16_t index,
 	print_field("Encryption: 0x%02x", evt->encryption);
 }
 
+static void le_read_all_remote_features_complete_evt(struct timeval *tv,
+					uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_evt_le_read_all_remote_features_complete *evt =
+									data;
+	int i;
+
+	print_status(evt->status);
+
+	if (size == 1)
+		return;
+
+	print_handle(evt->handle);
+	print_field("Max Pages: 0x%2.2x", evt->max_pages);
+	print_field("Valid Pages: 0x%2.2x", evt->valid_pages);
+
+	for (i = 0; i < evt->valid_pages; i++)
+		print_features(i, &evt->features[i * 8], 0x01);
+}
+
 static void le_cs_rd_rem_supp_cap_complete_evt(struct timeval *tv,
 				uint16_t index, const void *data, uint8_t size)
 {
@@ -13325,6 +13420,11 @@ static const struct subevent_data le_meta_event_table[] = {
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

