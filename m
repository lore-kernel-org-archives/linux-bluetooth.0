Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6733F38E
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929194; cv=none; b=VHnGcYRDnEk/m/W4fYIZl5ohh06hhnjL8mFAXA5R/sZtdDsUMfwOOVtMvkVOk6H2bKrzV4dcwfvddG3p39yhxkALtbrvdSgw2mqIMHFGHnOqtBpE3Q+FvjPSkCuz7Uk+R7uT7aYcbEo9F5iEbUSzIJbpUna5hQOoZh0oSb+UtCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929194; c=relaxed/simple;
	bh=dGOGw/dlmRz0kkCS85fvQE6TmknknQj2kRa4G54Vdnc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkELqRGl3hrYQSPx7mWCz/H1JuXlUJNCSsnvpHxeNPucE0cRYFVsvV4t9BNOJr/m8d2zPClTw/ekny7Bp4x2+0UrGf70O+V+p7pE4lscCk0UxGfZW9FwBNokK8eJZzx8uSg+hLMZ5qc5uKHmez5tWQi/Ocsj8byrRaE75AElg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsD5iYoj; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsD5iYoj"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-62f2eb2b67eso697119137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 14:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777929191; x=1778533991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXQiCrMQUsL+gzyGI7p2FtCaq5tvz0hUe7yzvt/AbSg=;
        b=PsD5iYojn8oG7W+/gCchKKp37BzC+6zBHqtBNiHwCyZCgsSc97DjIdnGb85J9m38fI
         5K4zWBQmf46aDlCBkqfTrc3vkEyUNaqo+EDMoIpHsc52WDvRQ7ZDCC1OV/RblcFyRwhd
         KzY+tkVqFjjnV/mt6MkMxyUFE7w0VBNQlYKw6skdY44IGZ7+FPx0PUItkk9VDQ2em3hq
         4/YWkkEP3G9yK6KTeRzjHSL2gnPXH3lxNCLp2HJSDtTtnS0AO2jU7dUZaF7er9T2hUJf
         8Q8A3HvSCG2JY+8i5RDSbYCOlF92TzlKP8yxefFkE8IWVnzilamMm2OXHX8aQ9bVBvhO
         XuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929191; x=1778533991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jXQiCrMQUsL+gzyGI7p2FtCaq5tvz0hUe7yzvt/AbSg=;
        b=PRtKsxTaUqSdkHFxCXRwoIP0p+94vtypazE4sKZdX/E08mJgnYMbTOrKNRp+gC7krY
         uG6TZkpnsJOW8fOPckOm6btSI/S2rSeT8RJy3zdAwceSiKcf5JPOw+C4zhMoiX2n1tCV
         WhVyA3oph4pZ+Khl7jl4ix8jiNOkDH1YXCPjr5b5pZlpHFXPxHB5P03C683BaEt8HbkT
         3HQKStYyWdBUfbcLY/zaX2tLFsv8dRCfPk4vXf68/NFkBTGHfDsF3f7pzW7aLwKdJ18r
         ej1WfH3R0MVdRtn28up/HxYQnY5TtgCNG5Uk0XA5VllXkQ6H+73Q+ZRckil3wQfbpfoi
         xDWw==
X-Gm-Message-State: AOJu0YzwAycVsbS5DPI7Dh+LLIIDl90OsOTrr62Yp8I/sbqWVcb32fId
	Y4EjYVFLrNhKti14g+tAe6K0ZFXoeDyB4wwrD3cztot+8bFEBismg2CPnkkBk5t7
X-Gm-Gg: AeBDiesnXYtEk6i1vsAMSdjDAXvrz49DwvQ2IqdBlpOO0jzEo5andM8ZQ/qxEncLnDX
	QIGzoRQWRGYc4P2084BbiVwiOf26giQzaWIk0SnuBo5AO2jbJsbPlBCLeGCQrKYLnQTV2nPd7+8
	Oy23SAvPt5VLxgMIPRvJtLZKbw1Zb/4lMPBvboLZ4LCLitIXsuOMrPuFuZBJcZqtUiwzOODtlPL
	alsNcTNhA67pOcMY+EAR3GPvJReUeATbazVv0Voi2EVYoOURg+kNMukhC7oyT8Ds8eGORbBTyY+
	3OikVDQoh+D4b7FaFGeSupI8lift8mAcgXE03faEbBTsxmDzYcHS+iowkweONHCku70llBPu3OK
	DVfLR1oKUcKNQ6Ygp+r8t7KePWhnh7rtjP9O6NH5ZxEITjUC0i+Uz5FME7fw7gfIPk0d0zrEz2n
	xR1AQZViS+Os8cYWZ1sliOP/3UkfsKW/wybMGHNvSQ+4ESaKF5BmqjnCDu9/THmPeEkGYF2Z6W+
	u69VOazBaJQot9I9RSg/fRerKwx
X-Received: by 2002:a05:6102:8028:b0:602:a05c:e9c7 with SMTP id ada2fe7eead31-62d85188c48mr4891637137.7.1777929190912;
        Mon, 04 May 2026 14:13:10 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95ce0894dc8sm5955368241.2.2026.05.04.14.13.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 14:13:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] monitor: Add decoding for Short Connection Interval feature
Date: Mon,  4 May 2026 17:13:02 -0400
Message-ID: <20260504211303.1081876-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504211303.1081876-1-luiz.dentz@gmail.com>
References: <20260504211303.1081876-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds deconding support for SCI related commands, command bits, event
event mask bit and feature bits:

Events:

HCI_LE_Connection_Rate_Change(0x37)

Commands:

HCI_LE_Connection_Rate_Request(0x20a1)
HCI_LE_Set_Default_Rate_Parameters(0x20a2)
HCI_LE_Read_Minimum_Supported_Connection_Interval(0x20a3)
---
 monitor/bt.h     |  54 ++++++++++++++++++++
 monitor/packet.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 147b76537e97..60fe2efbf143 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3196,6 +3196,49 @@ struct bt_hci_cmd_le_fsu {
 	uint8_t  types;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_CONN_RATE		0x20a1
+#define BT_HCI_BIT_LE_CONN_RATE		BT_HCI_CMD_BIT(48, 5)
+struct bt_hci_cmd_le_conn_rate {
+	uint16_t handle;
+	uint16_t interval_min;
+	uint16_t interval_max;
+	uint16_t subrate_min;
+	uint16_t subrate_max;
+	uint16_t max_latency;
+	uint16_t cont_num;
+	uint16_t supv_timeout;
+	uint16_t min_ce_len;
+	uint16_t max_ce_len;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_DEF_RATE		0x20a2
+#define BT_HCI_BIT_LE_SET_DEF_RATE		BT_HCI_CMD_BIT(48, 6)
+struct bt_hci_cmd_le_set_def_rate {
+	uint16_t interval_min;
+	uint16_t interval_max;
+	uint16_t subrate_min;
+	uint16_t subrate_max;
+	uint16_t max_latency;
+	uint16_t cont_num;
+	uint16_t supv_timeout;
+	uint16_t min_ce_len;
+	uint16_t max_ce_len;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_READ_CONN_INTERVAL	0x20a3
+#define BT_HCI_BIT_LE_READ_CONN_INTERVAL	BT_HCI_CMD_BIT(48, 7)
+struct bt_hci_le_conn_interval_group {
+	uint16_t min;
+	uint16_t max;
+	uint16_t stride;
+} __attribute__ ((packed));
+
+struct bt_hci_rsp_le_read_conn_interval {
+	uint8_t  status;
+	uint8_t  num_grps;
+	struct bt_hci_le_conn_interval_group grps[0];
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
@@ -4154,6 +4197,17 @@ struct bt_hci_evt_le_fsu_complete {
 	uint8_t  types;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_CONN_RATE_CHANGE		0x37
+struct bt_hci_evt_le_conn_rate_change {
+	uint8_t  status;
+	uint16_t handle;
+	uint16_t interval;
+	uint16_t subrate;
+	uint16_t latency;
+	uint16_t cont_number;
+	uint16_t supv_timeout;
+} __attribute__ ((packed));
+
 #define BT_HCI_ERR_SUCCESS			0x00
 #define BT_HCI_ERR_UNKNOWN_COMMAND		0x01
 #define BT_HCI_ERR_UNKNOWN_CONN_ID		0x02
diff --git a/monitor/packet.c b/monitor/packet.c
index 4697eea099a9..a0bf7a70987e 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2415,6 +2415,12 @@ static void print_rssi(int8_t rssi)
 	packet_print_rssi("RSSI", rssi);
 }
 
+static void print_slot_125u(const char *label, uint16_t value)
+{
+	 print_field("%s: %.3f msec (0x%4.4x)", label,
+				le16_to_cpu(value) * 0.125, le16_to_cpu(value));
+}
+
 static void print_slot_625(const char *label, uint16_t value)
 {
 	 print_field("%s: %.3f msec (0x%4.4x)", label,
@@ -3341,6 +3347,8 @@ static const struct bitfield_data events_le_table[] = {
 	{ 50, "LE CS Test End Complete"			},
 	{ 51, "LE Monitored Advertisers Report"		},
 	{ 52, "LE Frame Space Update Complete"		},
+	{ 53, "LE UTP Received"				},
+	{ 54, "LE Connection Rate Change"		},
 	{ }
 };
 
@@ -9836,6 +9844,89 @@ static void le_fsu_cmd(uint16_t index, const void *data, uint8_t size)
 	print_fsu_types(cmd->types);
 }
 
+static void le_conn_rate_cmd(uint16_t index, const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_conn_rate *cmd = data;
+
+	print_handle(cmd->handle);
+	print_slot_125u("Connection Interval Min", cmd->interval_min);
+	print_slot_125u("Connection Interval Max", cmd->interval_max);
+	print_field("Subrate Min: %u (0x%4.4x)",
+				le16_to_cpu(cmd->subrate_min),
+				le16_to_cpu(cmd->subrate_min));
+	print_field("Subrate Max: %u (0x%4.4x)",
+				le16_to_cpu(cmd->subrate_max),
+				le16_to_cpu(cmd->subrate_max));
+	print_field("Max Latency: %u (0x%4.4x)",
+				le16_to_cpu(cmd->max_latency),
+				le16_to_cpu(cmd->max_latency));
+	print_field("Continuation Number: %u (0x%4.4x)",
+				le16_to_cpu(cmd->cont_num),
+				le16_to_cpu(cmd->cont_num));
+	print_field("Supervision Timeout: %d ms (0x%4.4x)",
+				le16_to_cpu(cmd->supv_timeout) * 10,
+				le16_to_cpu(cmd->supv_timeout));
+	print_slot_125u("Minimum CE Length", cmd->min_ce_len);
+	print_slot_125u("Maximum CE Length", cmd->max_ce_len);
+}
+
+static void le_set_def_rate_cmd(uint16_t index, const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_def_rate *cmd = data;
+
+	print_slot_125u("Connection Interval Min", cmd->interval_min);
+	print_slot_125u("Connection Interval Max", cmd->interval_max);
+	print_field("Subrate Min: %u (0x%4.4x)",
+				le16_to_cpu(cmd->subrate_min),
+				le16_to_cpu(cmd->subrate_min));
+	print_field("Subrate Max: %u (0x%4.4x)",
+				le16_to_cpu(cmd->subrate_max),
+				le16_to_cpu(cmd->subrate_max));
+	print_field("Max Latency: %u (0x%4.4x)",
+				le16_to_cpu(cmd->max_latency),
+				le16_to_cpu(cmd->max_latency));
+	print_field("Continuation Number: %u (0x%4.4x)",
+				le16_to_cpu(cmd->cont_num),
+				le16_to_cpu(cmd->cont_num));
+	print_field("Supervision Timeout: %d ms (0x%4.4x)",
+				le16_to_cpu(cmd->supv_timeout) * 10,
+				le16_to_cpu(cmd->supv_timeout));
+	print_slot_125u("Minimum CE Length", cmd->min_ce_len);
+	print_slot_125u("Maximum CE Length", cmd->max_ce_len);
+}
+
+static void le_read_conn_interval_rsp(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_conn_interval *rsp = data;
+	struct iovec iov;
+	uint8_t i;
+
+	print_status(rsp->status);
+	print_field("Number of Groups: %u", rsp->num_grps);
+
+	if (!rsp->num_grps)
+		return;
+
+	iov.iov_base = (void *)rsp->grps;
+	iov.iov_len = size - sizeof(*rsp);
+
+	for (i = 0; i < rsp->num_grps; i++) {
+		const struct bt_hci_le_conn_interval_group *grp;
+
+		grp = util_iov_pull(&iov, sizeof(*grp));
+		if (!grp) {
+			print_text(COLOR_ERROR, "  invalid group");
+			break;
+		}
+
+		print_field("Group %u:", i);
+		print_slot_125u("  Interval Min", grp->min);
+		print_slot_125u("  Interval Max", grp->max);
+		print_slot_125u("  Interval Stride", grp->stride);
+	}
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -10907,6 +10998,21 @@ static const struct opcode_data opcode_table[] = {
 				"LE Frame Space Update", le_fsu_cmd,
 				sizeof(struct bt_hci_cmd_le_fsu),
 				true, status_rsp, 1, true },
+	{ BT_HCI_CMD_LE_CONN_RATE, BT_HCI_BIT_LE_CONN_RATE,
+				"LE Connection Rate Request", le_conn_rate_cmd,
+				sizeof(struct bt_hci_cmd_le_conn_rate),
+				true, status_rsp, 1, true },
+	{ BT_HCI_CMD_LE_SET_DEF_RATE, BT_HCI_BIT_LE_SET_DEF_RATE,
+				"LE Set Default Rate Parameteres",
+				le_set_def_rate_cmd,
+				sizeof(struct bt_hci_cmd_le_set_def_rate),
+				true, status_rsp, 1, true },
+	{ BT_HCI_CMD_LE_READ_CONN_INTERVAL,
+				BT_HCI_BIT_LE_READ_CONN_INTERVAL,
+				"LE Read Minimum Supported Connection Interval",
+				null_cmd, 0, true, le_read_conn_interval_rsp,
+				sizeof(struct bt_hci_rsp_le_read_conn_interval),
+				true },
 	{ }
 };
 
@@ -13400,6 +13506,26 @@ static void le_fsu_evt(struct timeval *tv, uint16_t index,
 	print_fsu_types(evt->types);
 }
 
+static void le_conn_rate_change_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_conn_rate_change *evt = data;
+
+	print_handle(evt->handle);
+	print_slot_125u("Connection Interval", le16_to_cpu(evt->interval));
+	print_field("Subrate Factor: %u (0x%4.4x)", le16_to_cpu(evt->subrate),
+					le16_to_cpu(evt->subrate));
+	print_field("Peripheral Latency: %u (0x%4.4x)",
+					le16_to_cpu(evt->latency),
+					le16_to_cpu(evt->latency));
+	print_field("Continuation Number: %u (0x%4.4x)",
+					le16_to_cpu(evt->cont_number),
+					le16_to_cpu(evt->cont_number));
+	print_field("Supervision Timeout: %u ms (0x%4.4X)",
+					le16_to_cpu(evt->supv_timeout),
+					le16_to_cpu(evt->supv_timeout));
+}
+
 struct subevent_data {
 	uint8_t subevent;
 	const char *str;
@@ -13566,6 +13692,10 @@ static const struct subevent_data le_meta_event_table[] = {
 	{ BT_HCI_EVT_LE_FSU_COMPLETE,
 		"LE Frame Space Update Complete",
 		le_fsu_evt, sizeof(struct bt_hci_evt_le_fsu_complete) },
+	{ BT_HCI_EVT_LE_CONN_RATE_CHANGE,
+		"LE Connection Rate Change",
+		le_conn_rate_change_evt,
+		sizeof(struct bt_hci_evt_le_conn_rate_change) },
 	{ }
 };
 
-- 
2.53.0

