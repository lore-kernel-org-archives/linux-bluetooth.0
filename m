Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076012BE05B
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508255; cv=none; b=stiFm3XvuHH402xsVB7rpmS9gRSUuf2cIRsq5i940LHf27zrKrMiiTV7MdqbYyu0uVLKzTcux3nUgNY248oYz0a3oOZuKXm29bJER2LRf6bZcrpuVBax+KGcdorH+M3ar0nNmhM2QDw9WQkyVyJ+alR6dRZktDEXxMwFVVcSyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508255; c=relaxed/simple;
	bh=WkNjkc5i+a+jJ4WDC9ug6dmT7bBDHKVCAOxkZzEE06o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=W3a6Wiag1HpKrNTpK82Dpd29m6C7LfLEd97HASXnrwPRftDSp/sM1Qt+V8ftIiomE/q79qcXaeA71fNojSudHoAlJOZYVlyhreYE/x4XCcHVRUEw6yAQ+hn/6xonsUCMSn7sDKUodCX0vHIsl3AhOgy9dF1PYbLpeKEZ5glcAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0CPejdm; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0CPejdm"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-574d36a8c11so959521137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Oct 2025 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759508252; x=1760113052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ1ebOs2U7ppZGBvKs/XLjqQ7kyUc70w96ZrhXZAVkw=;
        b=I0CPejdm52VwjyQwTCGolTtUXAhFjNCqn1QFbjGanpkzF1DZZTzCr586KuLKOPv+J+
         MjBLw6+WmSf+gjyAs3Ht09Ggle/IjRQIUkAvnfMcxE+5Wwvrfx0flsaEgdVTHFAPx9+9
         9CVnsnlh3IDHkbiKZfEZdkw6/XlITX2xlGJvucYMu4v6steYF67FbUTdfxHmZtiKPpt1
         uxeR+zMkOC1/yolqLdp0YERD8G41sHT9ZgmWI0kal/BIMBCIwWPvcI/3SzysCkaqk7zM
         ngmlYiadEzydyjgt6Oi/rdaJ+oVIFRwQo0FrFbwdyHqihU+U7D3Z6eWytRvRB23w7LCC
         oICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759508252; x=1760113052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ1ebOs2U7ppZGBvKs/XLjqQ7kyUc70w96ZrhXZAVkw=;
        b=bjuq902gU5Dosng73Dp//L25i4bIRzQ6CyStMQuWQs4XZR3cc8JaMbR2Dqdx0K+QO5
         ULfaCrXE0nJz6oPyXi3muZz8nK0C0PC1p9c+4lcGImJc/WCSFAI3GhjgDZha6mGnE099
         GHIiLPgAKtsJWFfPlNyOF3IFWIBXpLFpZ1VOA+N7wWIjY3E+iFBkP9A9ecm0UBVgz9nE
         VMbuR0Bs2WwPu2GdqYewhz3b8HlaMoppn61J6r03mAN8Sk5cJjcd9l7dXUYU3QTQyLcJ
         15UNQN8OgSei9NaPZes91MZa0n+g/MvWRufTxTg7+2Kaw/PZUAMVx0jSj7DJ3A2eboGJ
         4zvQ==
X-Gm-Message-State: AOJu0YzQHxbg5rVzzsYC8yDlXsZPDCTpT24m7xVHSKbiAY10l0Fy0pMb
	eEfksNNT5yJd4G6jvdxcdy9/E2OzXbl+PnItSl9FVR838erwEqztR4aGp08pnioC
X-Gm-Gg: ASbGnct2qtB8i7JmeeexB9nmhCayzku1puLXv5Fd+elPknH5qtMttTqj76lohJmQcXV
	kOX1FV0sRsf7WWm0UA4AdJk0a8KtjFeA3QmuEE0Au7j0Ouu0jPodhBZDib6RBIE9fzs0PbcBQGs
	9Hjby6ZBEap0Zv0dPuzX97/00dCfUHKK/nIvGYNaQDTBx2Kj3T4hPXe4U4zb7VQQnuoTGXcJ8jK
	Hf/5clHfi2QyVE+r0D+bsxA1jie7a8m7Ix92O+Co3ZhiRvRYL5KMI6bKkYvCiefHKHiuguV/psw
	LY/kP9Juu7A3El+MiMFSsGdZneBHFaXtw9CGcvH5rxOYT6iWcxfZ8TE+aRBVU/Uw5jhgo7BRhJ5
	C6le8BfLE4BHL1/bCymN/6YOl18BK9oaHY/YGH66o5VWe6Vp/IE5K/cgNWikM8cVVQGK+bN8XTf
	4WIAG5UwTxXdjUnw==
X-Google-Smtp-Source: AGHT+IGI1IMc4iOpnEz63rfH6k+leWObByP3iLGcmPdoFkkBmhjffldSxo/yBWUEn5esPfhWWrxqMA==
X-Received: by 2002:a05:6102:e10:b0:5d4:e01:169 with SMTP id ada2fe7eead31-5d41d001146mr1214802137.13.1759508251952;
        Fri, 03 Oct 2025 09:17:31 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d40c4eb764sm1364253137.1.2025.10.03.09.17.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:17:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] monitor: Use PAST to refer to Periodic Advertising Sync Transfer
Date: Fri,  3 Oct 2025 12:17:19 -0400
Message-ID: <20251003161721.508678-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This simplify the command and event names and their structs to just
use PAST in place of other terminology currently in use.
---
 monitor/bt.h     | 39 +++++++++++++++++++++++++++------------
 monitor/packet.c | 41 +++++++++++++++++++++++------------------
 2 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 0e80ad2a2d6f..ca91f7fefc84 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2630,22 +2630,32 @@ struct bt_hci_cmd_set_pa_rec_enable {
 	uint8_t  enable;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_PERIODIC_SYNC_TRANS		0x205a
-struct bt_hci_cmd_periodic_sync_trans {
+#define BT_HCI_CMD_LE_PAST			0x205a
+struct bt_hci_cmd_le_past {
 	uint16_t handle;
 	uint16_t service_data;
 	uint16_t sync_handle;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_PA_SET_INFO_TRANS		0x205b
-struct bt_hci_cmd_pa_set_info_trans {
+struct bt_hci_rsp_le_past {
+	uint8_t  status;
 	uint16_t handle;
-	uint16_t service_data;
-	uint8_t adv_handle;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_PA_SYNC_TRANS_PARAMS		0x205c
-struct bt_hci_cmd_pa_sync_trans_params {
+#define BT_HCI_CMD_LE_PAST_SET_INFO		0x205b
+struct bt_hci_cmd_le_past_set_info {
+	uint16_t handle;
+	uint16_t service_data;
+	uint8_t  adv_handle;
+} __attribute__ ((packed));
+
+struct bt_hci_rsp_le_past_set_info {
+	uint8_t  status;
+	uint16_t handle;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_PAST_PARAMS		0x205c
+struct bt_hci_cmd_le_past_params {
 	uint16_t  handle;
 	uint8_t   mode;
 	uint16_t  skip;
@@ -2653,8 +2663,13 @@ struct bt_hci_cmd_pa_sync_trans_params {
 	uint8_t   cte_type;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_DEFAULT_PA_SYNC_TRANS_PARAMS	0x205d
-struct bt_hci_cmd_default_pa_sync_trans_params {
+struct bt_hci_rsp_le_past_params {
+	uint8_t  status;
+	uint16_t handle;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_DEFAULT_PAST_PARAMS		0x205d
+struct bt_hci_cmd_le_default_past_params {
 	uint8_t  mode;
 	uint16_t skip;
 	uint16_t sync_timeout;
@@ -3865,8 +3880,8 @@ struct bt_hci_evt_le_cte_request_failed {
 	uint16_t handle;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_PA_SYNC_TRANS_REC		0x18
-struct bt_hci_evt_le_pa_sync_trans_rec {
+#define BT_HCI_EVT_LE_PAST_RECEIVED		0x18
+struct bt_hci_evt_le_past_recv {
 	uint8_t  status;
 	uint16_t handle;
 	uint16_t service_data;
diff --git a/monitor/packet.c b/monitor/packet.c
index d5d906091adf..2d865eea1659 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3192,7 +3192,7 @@ static const struct bitfield_data events_le_table[] = {
 	{ 20, "LE Connectionless IQ Report"		},
 	{ 21, "LE Connection IQ Report"			},
 	{ 22, "LE CTE Request Failed"			},
-	{ 23, "LE Periodic Advertising Sync Transfer Rvc"},
+	{ 23, "LE PAST Received"			},
 	{ 24, "LE CIS Established"			},
 	{ 25, "LE CIS Request"				},
 	{ 26, "LE Create BIG Complete"			},
@@ -8596,18 +8596,18 @@ static void le_pa_rec_enable(uint16_t index, const void *data, uint8_t size)
 	print_enable("Reporting", cmd->enable);
 }
 
-static void le_pa_sync_trans(uint16_t index, const void *data, uint8_t size)
+static void le_past(uint16_t index, const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_periodic_sync_trans *cmd = data;
+	const struct bt_hci_cmd_le_past *cmd = data;
 
 	print_field("Connection handle: %d", cmd->handle);
 	print_field("Service data: 0x%4.4x", cmd->service_data);
 	print_field("Sync handle: %d", cmd->sync_handle);
 }
 
-static void le_pa_set_info_trans(uint16_t index, const void *data, uint8_t size)
+static void le_past_set_info(uint16_t index, const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_pa_set_info_trans *cmd = data;
+	const struct bt_hci_cmd_le_past_set_info *cmd = data;
 
 	print_field("Connection handle: %d", cmd->handle);
 	print_field("Service data: 0x%4.4x", cmd->service_data);
@@ -8628,6 +8628,10 @@ static void print_sync_mode(uint8_t mode)
 	case 0x02:
 		str = "Enabled with report events enabled";
 		break;
+	case 0x03:
+		str = "Enabled with report events enabled with duplicate "
+			"filtering";
+		break;
 	default:
 		str = "RFU";
 		break;
@@ -8636,10 +8640,10 @@ static void print_sync_mode(uint8_t mode)
 	print_field("Mode: %s (0x%2.2x)", str, mode);
 }
 
-static void le_pa_sync_trans_params(uint16_t index, const void *data,
+static void le_past_params(uint16_t index, const void *data,
 							uint8_t size)
 {
-	const struct bt_hci_cmd_pa_sync_trans_params *cmd = data;
+	const struct bt_hci_cmd_le_past_params *cmd = data;
 
 	print_field("Connection handle: %d", cmd->handle);
 	print_sync_mode(cmd->mode);
@@ -8650,10 +8654,10 @@ static void le_pa_sync_trans_params(uint16_t index, const void *data,
 	print_create_sync_cte_type(cmd->cte_type);
 }
 
-static void le_set_default_pa_sync_trans_params(uint16_t index,
+static void le_set_default_past_params(uint16_t index,
 						const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_default_pa_sync_trans_params *cmd = data;
+	const struct bt_hci_cmd_le_default_past_params *cmd = data;
 
 	print_sync_mode(cmd->mode);
 	print_field("Skip: 0x%2.2x", cmd->skip);
@@ -10492,17 +10496,17 @@ static const struct opcode_data opcode_table[] = {
 				le_pa_rec_enable, 3, true,
 				status_rsp, 1, true },
 	{ 0x205a, 326, "LE Periodic Advertising Sync Transfer",
-				le_pa_sync_trans, 6, true,
+				le_past, 6, true,
 				status_handle_rsp, 3, true },
 	{ 0x205b, 327, "LE Periodic Advertising Set Info Transfer",
-				le_pa_set_info_trans, 5, true,
+				le_past_set_info, 5, true,
 				status_handle_rsp, 3, true },
 	{ 0x205c, 328, "LE Periodic Advertising Sync Transfer Parameters",
-				le_pa_sync_trans_params, 8, true,
+				le_past_params, 8, true,
 				status_handle_rsp, 3, true},
 	{ 0x205d, 329, "LE Set Default Periodic Advertisng Sync Transfer "
 				"Parameters",
-				le_set_default_pa_sync_trans_params,
+				le_set_default_past_params,
 				6, true, status_rsp, 1, true},
 	{ BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2,
 				BT_HCI_BIT_LE_READ_BUFFER_SIZE_V2,
@@ -12383,10 +12387,10 @@ static void le_cte_request_failed_evt(struct timeval *tv, uint16_t index,
 	print_field("Connection handle: %d", evt->handle);
 }
 
-static void le_pa_sync_trans_rec_evt(struct timeval *tv, uint16_t index,
+static void le_past_received_evt(struct timeval *tv, uint16_t index,
 					const void *data, uint8_t size)
 {
-	const struct bt_hci_evt_le_pa_sync_trans_rec *evt = data;
+	const struct bt_hci_evt_le_past_recv *evt = data;
 
 	print_status(evt->status);
 	print_field("Handle: %d", evt->handle);
@@ -13283,9 +13287,10 @@ static const struct subevent_data le_meta_event_table[] = {
 				le_chan_select_alg_evt, 3, true},
 	{ 0x17, "LE CTE Request Failed",
 				le_cte_request_failed_evt, 3, true},
-	{ 0x18, "LE Periodic Advertising Sync Transfer Received",
-					le_pa_sync_trans_rec_evt, 19,
-					true},
+	{ BT_HCI_EVT_LE_PAST_RECEIVED,
+			"LE Periodic Advertising Sync Transfer Received",
+			le_past_received_evt, 19,
+			true},
 	{ BT_HCI_EVT_LE_CIS_ESTABLISHED,
 				"LE Connected Isochronous Stream Established",
 				le_cis_established_evt,
-- 
2.51.0

