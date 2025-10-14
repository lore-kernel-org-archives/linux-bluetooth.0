Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F79F1F63F9
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 20:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474056; cv=none; b=pWZAaGOV6C+mYjr4/JUZ61TfpjR1tBuDcVyqtn0aKMCROjgfXWLq19RQDHixxLPvxlT8DB2fAw0srA4YS1H31AhH801nIIN412+qeyISt6o64Hl71AkGNAdYhIJhgbESjZkHu4cx4zesLAQ/iCIsXnoUwiI4FUPIToyBX4AolfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474056; c=relaxed/simple;
	bh=aMMBBsxAgYjXh1BBnl/s1K/bYEQkycYI1ghOk3XPnRM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T1IAsM8KPxdiWlMTapudA80ktUcM6cx0SA4yv7K2DFxz9BlHvlqGrkQkfcMNf0xlfhksms/jBBc2NQmVLtuvxQrM54kNZuPeiwPKlSDi5JUm3MzHE3h9ovqKO23yg8OQoDoPO2DC1rxPiRGOZH8knaN/BjlEFfUKcbG1H+fVo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpnSNGA9; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpnSNGA9"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-930a1bb7b50so2042272241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 13:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760474053; x=1761078853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ag2iz1dpxt1ncilQ9K1pqh42Zq4SmOTgzkEz5rSFr3g=;
        b=TpnSNGA9wXXg04d0Qsk9D2QoBXLdQ+wgynzEiUkSyAlP6Pm50UEjXqaPnJLn38wEWV
         u8dkBGT4ewp6lXVgkCNgjGk6Vy2LRVDVd9visq571prnYu+IIQdfBo/fk5pdI9pbK7BE
         HFOP9JH+FFWe7Ag1ScwBIIvYV/ZTqcNVkisGLxiOAfTEoHna/7tjHlM6aMl08L9LS+Aq
         KWj55u1/N0JsKhCZ4EvqGcWq9y499kZlYJljVJ+wsq+jKVOklW3pKuXvXLAUZo8JTMJi
         UIT2S1tOqHFOA2Ia5eO5SHt7uPUX4S2rmQpr7NNQkUnzT7LPfSr8htzSDimk8i/39yyE
         c73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760474053; x=1761078853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ag2iz1dpxt1ncilQ9K1pqh42Zq4SmOTgzkEz5rSFr3g=;
        b=AC1NCFZG3XfSnQ0Q2QFCXm7+AMcT2YPKNPPNY+M5x/4XE6SkSpZhs3FZ2H+oDgwjrr
         zI/Is4cZLl8aLdueNL40pIWFWG5fx3jrdY4NFKJadYtt1Sd5G9dsgfV5ORfV7ysTy7az
         zTsIu2b9AirkeepSm/0f64+R0KkoqGdvQIiv9l6of8g7csfuPyM6xbu/3t4fKQUKv7gU
         kyfT65Lgnc4YlQ6TMRZE//lI+Xht28MTw9seAof7jkR5JkuiQajavCVoZFtBFX8NSiTH
         UZpsBslN90OnQf0bcNHfus+diMXcE4+4bN4qS3AuYH2iobIoHm0UBSINrvfE6Um+QuFS
         Yw+Q==
X-Gm-Message-State: AOJu0YyQx9EusKTKfBkSjjrAMoP+2KyH7RbYibCvl935sWbb26JKxGCE
	xltHzizT6o8y6xmYXt7oBYw9CtMEm/vyP3n2a2nRRSdbi9xhJ7/j0O/cYu8Fg1Dw
X-Gm-Gg: ASbGncu5ujXy+gttnsSzLrtYGyZ3UBIQ4yfsP1W4SbCAvVrqZcNkXVqTcaUPNkO399x
	p73apu77qsf8r87O0xz5Mv6g5LLGbsJ5Wo2hwCVdqYt/FaIFuy+p2S7em5a5mwezuw/OEb84s7+
	UXi2i8JJ34Hmt6P9SN/63OZFPjTm5/q5JmdFQzDyN5Kvv8jxyVJYwpA4RENcD9K/B2N2eSFCDF0
	KoK4c6B4J7YyZoFiK8EsGklyETFmCu8Il7dJQog8+6HfKtky4Y+8SgFimnQApFaUFTjbCmq5CgX
	rMxbiSARzEc0AQ+wD5rrhla0boBHZypudK7YgZSJFmHqCjeDCQkmMWM//YIpDVP1CNJq+B05L8X
	e4KRLqSb2NzW9fEL10LnsNoKmzKBZHWYvtwQzv7aWwiyMxK7vXXV1ZeZCNi590k9L7w==
X-Google-Smtp-Source: AGHT+IH7YtBAkRgnlp7O/5InTjFYAmmI9JyCmI8ZeByHECQJeZmL6a0UK/6g1SEbG7N7WgG6c8v8Bw==
X-Received: by 2002:a05:6102:d86:b0:523:22e2:e894 with SMTP id ada2fe7eead31-5d5e23ab9b1mr11923700137.28.1760474053136;
        Tue, 14 Oct 2025 13:34:13 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80a456csm4434116e0c.14.2025.10.14.13.34.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:34:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/6] monitor: Use PAST to refer to Periodic Advertising Sync Transfer
Date: Tue, 14 Oct 2025 16:33:55 -0400
Message-ID: <20251014203400.453454-1-luiz.dentz@gmail.com>
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
index 2b30e881a201..f7db1cbb88c6 100644
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

