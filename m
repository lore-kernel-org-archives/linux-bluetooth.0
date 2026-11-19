Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072444;
	b=4goduNpRo6esZhlUhX0u63SFA16BRpyFAkjPdObu/hJLE7wsA5AQmOOnBW9i2BcKcGHl
	 E1T/4gxL5shv1uMc5jK6LsmZ2e7F4P4AglsHqvnOuOBMG7DYaoY+18FMTXeOM4dwhTwrO
	 vW8RfGvzAIWYE+CNtgZ9xwM4EHU2P7LcxV6DdCAJ16xRJ4Y0c362c5g1baRJluy4q14Nl
	 glrL4yXAgDD3QI+JnURcZG/QvNmmOg+/ixQZCjvIfFj3mkvGNf5eEka4d9Ea+gsqWGrQF
	 3cTq3b2ytTxr+UJ0kA4zfTTF/Z14uFTyu138bo/ytWiaJ3vMEOwT+A+HSEYgxmLOEfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0PRIZNjurP3t+8mWplRJdPwjuqg4GLkRzdrRboYLECg=;
	b=dnvTsf7/K/Zq0060xFOrR06nME8HjiOMdS5WMqD9bJxDDi65ApuKXhZGMR3t3PBRCMyJ
	 xp2/17Gnqcncm8ZzaBMxvjAy2BvHrXKQb6GSj/NrU7caHVSaLH02GogY5aUjgHuc1ETEx
	 jKCLorVJ8vXTVwFteXyAAKA7MMF9LIwb6nxS3qZrxNmP0hFF3AjQ40lxb9AU7+jUaqri7
	 Lhgx5x+dxuXMfci5800lZVnyHo07McBjIu7wgMxzJPACD17QB7o0jj+H0G4HS673Y4EwU
	 MvyVROdQSUFtXwzAFAHGSw2A5Y/C3tiZAoETaVJDFyMUXIE7E6Gm8EhtFa3iFlUAtYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SlQYH7Wj;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7896606A325
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 07:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7896606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SlQYH7Wj
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a73fdd2966so1349805e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 23:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072442; x=1795677242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0PRIZNjurP3t+8mWplRJdPwjuqg4GLkRzdrRboYLECg=;
        b=SlQYH7Wjq2HdlTuYqen/E9d7syqcdkgXxSCDZ2DLIu+QxM/s2/DK4Ar2K6wtU/mbUb
         HwV3a7oKgGCpw8calCfIaAezZiNsEW+8CfE5pKYJ2xOc1jbNiAv7U2GlNid223p+SYGV
         GDbIYVHJrdnnJIkwav2M/rp0mnsYE4f3lT/ME0ZHvtt8CpTATENtTk4jdPJsBRVE/gIc
         1s8WMup/h3lxaJ0Eiz1cLXIgB95HWlQm/ZL2y9aLdouuVzj37V/g9GlqnoFy0mbzmrhz
         YxbQDUf1pS1lGQ+Dz3IrnkxL6RzQT3tl+DPLUWUjdwFHWZDQSsLKlVl4yTS5l3cTO9we
         yT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072442; x=1795677242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0PRIZNjurP3t+8mWplRJdPwjuqg4GLkRzdrRboYLECg=;
        b=cZYbuBtoNJfMsFNxzyInsHtq+v06cKmH1hjB0wNxK/5spYF99SX7Rm/j8kdV9YA7Ko
         +sCmTzTIPtXlgeqvQBtuG8exFLrnaaP/0NDVv+7GlRIzODoADdtl/HBDuMVW7TsZcZM5
         Ik0SSxDMJEEiMNzMEVGRvvFEqMd051pU9C9GSOtiq8PYcWFTakPR0itUVgKL8idTsCT0
         NE8FX4fjeiLao8cCPkT8VT+Q6OhjxJMnHvmjJHrJnaLX4bDS3yApS5sgosQRobBga12H
         K2CbQmxFfC8esxjHeB0NFRd5bvmvwg2MLGevZCdJDUBLG6u6Q2JuRR9rNIAexeAvVaV+
         I/VA==
X-Gm-Message-State: APuU4Z+goke4srmX2lbHrckMihQLQZ+0NSuIaPdWPrX7C3PBa4ttXn1F
	HYmTlbX2B7AT37LSqbNJYHt/AWHFJwJp2tyR5qCuMYRtHBGkhpaRJ0nH+s1v43zu
X-Gm-Gg: AYBFou3eN+l5j3zff6Iu5TpB6+6bk7C/Mu5bFYkFIrXqVfhJoeCH1jk2FHfIKJrCHj/
	IzSlEujoYs4eMwfNj+oCiKT9zu1UX7QiKBrU0i4utIbL1ZejjvGUyNXRp0XaPfZQ9tuT5XV4bgA
	em7SjzPItzb2f7lUdenqK6mhe53JOHY+DDDeKz0WnExBPQf9IRcXUxtbLEpa4Eq8aI1JKQqASgV
	8ALu1zlMufmGP4UWn0J+/LwhanXnVsYBgomD6p/MLLUXI2jWYJFL8kAT1vp9nP4KQv8bP5onBeY
	sb/vJTXEPsV8XIE/34YlTv04hYZ3EcoWymoWJDhZr4FtYjSoB66ErfkEHfJpKnDy1dxA8T1FrF4
	cbEOEjBc9x2rYjF2MOYzp663mifdOazN+Cx77wm2ydybBoFTxEsBi5E9RqEJqpGXveT3dk0ihB+
	4w9ib6wyGCb24NvNMei/sbHyeePkXRCSm1Oqam1TWqu6G70Im7BxbuWZ8v16ULMKf2wuxLW/3NO
	mRnka11Y1qlI3JidUoP1UQOQWUuxY2oNAiS0e1BOCXefbi+3nwUBX9OivoNv6wwH85aDR5G6IMr
	86vUQXSqyRhfKOj+zPSHIawhTWTGM40WYD8=
X-Received: by 2002:a05:600c:3541:b0:4bb:68ed:a356 with SMTP id 5b1f17b1804b1-4bb7d706b4cmr92332615e9.1.1795072442365;
        Wed, 18 Nov 2026 23:14:02 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85343607sm17549165e9.6.2026.11.18.23.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:14:02 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v2 5/6] monitor: Add PAwR HCI commands decoding
Date: Thu, 19 Nov 2026 08:13:31 +0100
Message-ID: <20261119071332.32424-6-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119071332.32424-1-rolandschober1968@gmail.com>
References: <20261119071332.32424-1-rolandschober1968@gmail.com>
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

Decode the HCI commands introduced by Periodic Advertising with
Responses (PAwR) in Bluetooth 5.4, which so far only had their names
in the opcode table:

 - LE Set Periodic Advertising Subevent Data
 - LE Set Periodic Advertising Response Data
 - LE Set Periodic Sync Subevent
 - LE Extended Create Connection [v2]
 - LE Set Periodic Advertising Parameters [v2]

The subevent data of LE Set Periodic Advertising Subevent Data is a
list of elements of variable length, each with its own AD structures:

< HCI Command: LE Set Periodic Advertising Subevent.. (0x08|0x0082) plen 15
        Handle: 0
        Num subevents: 2
        Entry 0
          Subevent: 0 (0x00)
          Response slot start: 0
          Response slot count: 2
          Data length: 5
          Data[5]:
        04 ff 59 00 01                                   ..Y..
        Company: Nordic Semiconductor ASA (89)
          Data[1]:
        01                                               .
        Entry 1
          Subevent: 1 (0x01)
          Response slot start: 0
          Response slot count: 0
          Data length: 0

< HCI Command: LE Set Periodic Advertising Paramet.. (0x08|0x0086) plen 12
        Handle: 0
        Min interval: 1000.00 msec (0x0320)
        Max interval: 1000.00 msec (0x0320)
        Properties: 0x0000
        Num subevents: 4 (0x04)
        Subevent interval: 100.00 msec (0x50)
        Response slot delay: 6.25 msec (0x05)
        Response slot spacing: 1.000 msec (0x08)
        Num response slots: 32 (0x20)

Assisted-by: Claude:claude-opus-5-5
Assisted-by: Claude:claude-fable-5-2
---
 monitor/bt.h     |  84 ++++++++++++++++++
 monitor/packet.c | 223 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 302 insertions(+), 5 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 59bc90ccd..b97592afb 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3032,6 +3032,90 @@ struct bt_hci_rsp_le_read_iso_link_quality {
 	uint32_t duplicated_packets;
 } __packed;
 
+#define BT_HCI_CMD_LE_SET_PA_SUBEVENT_DATA	0x2082
+#define BT_HCI_BIT_LE_SET_PA_SUBEVENT_DATA	BT_HCI_CMD_BIT(46, 5)
+struct bt_hci_le_pa_subevent_data {
+	uint8_t  subevent;
+	uint8_t  response_slot_start;
+	uint8_t  response_slot_count;
+	uint8_t  data_len;
+	uint8_t  data[];
+} __packed;
+
+struct bt_hci_cmd_le_set_pa_subevent_data {
+	uint8_t  handle;
+	uint8_t  num_subevents;
+	struct bt_hci_le_pa_subevent_data subevents[];
+} __packed;
+
+struct bt_hci_rsp_le_set_pa_subevent_data {
+	uint8_t  status;
+	uint8_t  handle;
+} __packed;
+
+#define BT_HCI_CMD_LE_SET_PA_RESPONSE_DATA	0x2083
+#define BT_HCI_BIT_LE_SET_PA_RESPONSE_DATA	BT_HCI_CMD_BIT(46, 6)
+struct bt_hci_cmd_le_set_pa_response_data {
+	uint16_t sync_handle;
+	uint16_t request_event;
+	uint8_t  request_subevent;
+	uint8_t  response_subevent;
+	uint8_t  response_slot;
+	uint8_t  data_len;
+	uint8_t  data[];
+} __packed;
+
+struct bt_hci_rsp_le_set_pa_response_data {
+	uint8_t  status;
+	uint16_t sync_handle;
+} __packed;
+
+#define BT_HCI_CMD_LE_SET_PA_SYNC_SUBEVENT	0x2084
+#define BT_HCI_BIT_LE_SET_PA_SYNC_SUBEVENT	BT_HCI_CMD_BIT(46, 7)
+struct bt_hci_cmd_le_set_pa_sync_subevent {
+	uint16_t sync_handle;
+	uint16_t properties;
+	uint8_t  num_subevents;
+	uint8_t  subevents[];
+} __packed;
+
+struct bt_hci_rsp_le_set_pa_sync_subevent {
+	uint8_t  status;
+	uint16_t sync_handle;
+} __packed;
+
+#define BT_HCI_CMD_LE_EXT_CREATE_CONN_V2	0x2085
+#define BT_HCI_BIT_LE_EXT_CREATE_CONN_V2	BT_HCI_CMD_BIT(47, 0)
+struct bt_hci_cmd_le_ext_create_conn_v2 {
+	uint8_t  adv_handle;
+	uint8_t  subevent;
+	uint8_t  filter_policy;
+	uint8_t  own_addr_type;
+	uint8_t  peer_addr_type;
+	uint8_t  peer_addr[6];
+	uint8_t  phys;
+	uint8_t  data[];
+} __packed;
+
+#define BT_HCI_CMD_LE_SET_PA_PARAMS_V2		0x2086
+#define BT_HCI_BIT_LE_SET_PA_PARAMS_V2		BT_HCI_CMD_BIT(47, 1)
+struct bt_hci_cmd_le_set_pa_params_v2 {
+	uint8_t  handle;
+	uint16_t min_interval;
+	uint16_t max_interval;
+	uint16_t properties;
+	uint8_t  num_subevents;
+	uint8_t  subevent_interval;
+	uint8_t  response_slot_delay;
+	uint8_t  response_slot_spacing;
+	uint8_t  num_response_slots;
+} __packed;
+
+struct bt_hci_rsp_le_set_pa_params_v2 {
+	uint8_t  status;
+	uint8_t  handle;
+} __packed;
+
 #define BT_HCI_CMD_LE_READ_ALL_LOCAL_FEATURES	0x2087
 #define BT_HCI_BIT_LE_READ_ALL_LOCAL_FEATURES	BT_HCI_CMD_BIT(47, 2)
 struct bt_hci_rsp_le_read_all_local_features {
diff --git a/monitor/packet.c b/monitor/packet.c
index 9a3de9bc6..6089dc061 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8710,6 +8710,159 @@ static void le_set_pa_params_cmd(uint16_t index, const void *data, uint8_t size)
 	print_pa_properties(cmd->properties);
 }
 
+static void print_pa_subevents(uint8_t num_subevents, uint8_t interval,
+					uint8_t delay, uint8_t spacing)
+{
+	if (!num_subevents)
+		print_field("Num subevents: 0 (no responses) (0x00)");
+	else
+		print_field("Num subevents: %u (0x%2.2x)", num_subevents,
+								num_subevents);
+
+	print_field("Subevent interval: %.2f msec (0x%2.2x)",
+						interval * 1.25, interval);
+	print_field("Response slot delay: %.2f msec (0x%2.2x)",
+						delay * 1.25, delay);
+	print_field("Response slot spacing: %.3f msec (0x%2.2x)",
+						spacing * 0.125, spacing);
+}
+
+static void le_set_pa_params_v2_cmd(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_pa_params_v2 *cmd = data;
+
+	print_handle(cmd->handle);
+	print_slot_125("Min interval", cmd->min_interval);
+	print_slot_125("Max interval", cmd->max_interval);
+	print_pa_properties(cmd->properties);
+	print_pa_subevents(cmd->num_subevents, cmd->subevent_interval,
+				cmd->response_slot_delay,
+				cmd->response_slot_spacing);
+	print_field("Num response slots: %u (0x%2.2x)",
+				cmd->num_response_slots,
+				cmd->num_response_slots);
+}
+
+static void le_set_pa_params_v2_rsp(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_rsp_le_set_pa_params_v2 *rsp = data;
+
+	print_status(rsp->status);
+	print_handle(rsp->handle);
+}
+
+static void le_set_pa_subevent_data_cmd(uint16_t index, const void *data,
+							uint8_t size)
+{
+	struct iovec iov = { .iov_base = (void *) data, .iov_len = size };
+	const struct bt_hci_cmd_le_set_pa_subevent_data *cmd;
+	const struct bt_hci_le_pa_subevent_data *se;
+	uint8_t i;
+
+	cmd = util_iov_pull_mem(&iov, sizeof(*cmd));
+	if (!cmd)
+		goto done;
+
+	print_handle(cmd->handle);
+	print_field("Num subevents: %u", cmd->num_subevents);
+
+	for (i = 0; i < cmd->num_subevents; i++) {
+		se = util_iov_pull_mem(&iov, sizeof(*se));
+		if (!se)
+			goto done;
+
+		print_field("Entry %u", i);
+		print_field("  Subevent: %u (0x%2.2x)", se->subevent,
+							se->subevent);
+		print_field("  Response slot start: %u",
+						se->response_slot_start);
+		print_field("  Response slot count: %u",
+						se->response_slot_count);
+		print_field("  Data length: %u", se->data_len);
+
+		if (!util_iov_pull(&iov, se->data_len))
+			goto done;
+
+		print_eir("  Data", se->data, se->data_len, true);
+	}
+
+done:
+	if (iov.iov_len)
+		print_hex_field("  Data", iov.iov_base, iov.iov_len);
+}
+
+static void le_set_pa_subevent_data_rsp(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_rsp_le_set_pa_subevent_data *rsp = data;
+
+	print_status(rsp->status);
+	print_handle(rsp->handle);
+}
+
+static void le_set_pa_response_data_cmd(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_pa_response_data *cmd = data;
+
+	print_field("Sync handle: %d", le16_to_cpu(cmd->sync_handle));
+	print_field("Request event: %u (0x%4.4x)",
+					le16_to_cpu(cmd->request_event),
+					le16_to_cpu(cmd->request_event));
+	print_field("Request subevent: %u (0x%2.2x)", cmd->request_subevent,
+						cmd->request_subevent);
+	print_field("Response subevent: %u (0x%2.2x)", cmd->response_subevent,
+						cmd->response_subevent);
+	print_field("Response slot: %u (0x%2.2x)", cmd->response_slot,
+						cmd->response_slot);
+	print_field("Data length: %u", cmd->data_len);
+	print_eir("Data", cmd->data, size - sizeof(*cmd), true);
+}
+
+static void le_set_pa_response_data_rsp(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_rsp_le_set_pa_response_data *rsp = data;
+
+	print_status(rsp->status);
+	print_field("Sync handle: %d", le16_to_cpu(rsp->sync_handle));
+}
+
+static void le_set_pa_sync_subevent_cmd(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_pa_sync_subevent *cmd = data;
+	uint8_t i;
+
+	print_field("Sync handle: %d", le16_to_cpu(cmd->sync_handle));
+	print_pa_properties(cmd->properties);
+	print_field("Num subevents: %u", cmd->num_subevents);
+
+	size -= sizeof(*cmd);
+
+	for (i = 0; i < cmd->num_subevents && i < size; i++)
+		print_field("  Subevent: %u (0x%2.2x)", cmd->subevents[i],
+							cmd->subevents[i]);
+
+	if (cmd->num_subevents != size)
+		print_text(COLOR_ERROR, "  invalid number of subevents");
+
+	if (size > cmd->num_subevents)
+		print_hex_field("  Data", cmd->subevents + cmd->num_subevents,
+						size - cmd->num_subevents);
+}
+
+static void le_set_pa_sync_subevent_rsp(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_rsp_le_set_pa_sync_subevent *rsp = data;
+
+	print_status(rsp->status);
+	print_field("Sync handle: %d", le16_to_cpu(rsp->sync_handle));
+}
+
 static void le_set_pa_data_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_pa_data *cmd = data;
@@ -8891,6 +9044,28 @@ static void le_ext_create_conn_cmd(uint16_t index, const void *data,
 	print_ext_conn_phys(cmd->data, size - sizeof(*cmd), cmd->phys);
 }
 
+static void le_ext_create_conn_v2_cmd(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_cmd_le_ext_create_conn_v2 *cmd = data;
+
+	if (cmd->adv_handle == 0xff)
+		print_field("Advertising handle: No Advertising Handle (0xff)");
+	else
+		print_field("Advertising handle: %u (0x%2.2x)",
+					cmd->adv_handle, cmd->adv_handle);
+
+	if (cmd->subevent == 0xff)
+		print_field("Subevent: No subevent (0xff)");
+	else
+		print_field("Subevent: %u (0x%2.2x)", cmd->subevent,
+							cmd->subevent);
+
+	/* The remaining parameters are the ones of the v1 command */
+	le_ext_create_conn_cmd(index, &cmd->filter_policy,
+			size - sizeof(cmd->adv_handle) - sizeof(cmd->subevent));
+}
+
 static const struct bitfield_data create_sync_cte_type[] = {
 	{  0, "Do not sync to packets with AoA CTE"	},
 	{  1, "Do not sync to packets with AoD CTE 1us"	},
@@ -12008,11 +12183,49 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x207f, 370, "LE Set Extended Advertising Parameters [v2]" },
 	{ 0x2080, 371, "LE Set Decision Data" },
 	{ 0x2081, 372, "LE Set Decision Instructions" },
-	{ 0x2082, 373, "LE Set Periodic Advertising Subevent Data" },
-	{ 0x2083, 374, "LE Set Periodic Advertising Response Data" },
-	{ 0x2084, 375, "LE Set Periodic Sync Subevent" },
-	{ 0x2085, 376, "LE Extended Create Connection [v2]" },
-	{ 0x2086, 377, "LE Set Periodic Advertising Parameters [v2]" },
+	{ BT_HCI_CMD_LE_SET_PA_SUBEVENT_DATA,
+			BT_HCI_BIT_LE_SET_PA_SUBEVENT_DATA,
+			"LE Set Periodic Advertising Subevent Data",
+			le_set_pa_subevent_data_cmd,
+			sizeof(struct bt_hci_cmd_le_set_pa_subevent_data),
+			false,
+			le_set_pa_subevent_data_rsp,
+			sizeof(struct bt_hci_rsp_le_set_pa_subevent_data),
+			true },
+	{ BT_HCI_CMD_LE_SET_PA_RESPONSE_DATA,
+			BT_HCI_BIT_LE_SET_PA_RESPONSE_DATA,
+			"LE Set Periodic Advertising Response Data",
+			le_set_pa_response_data_cmd,
+			sizeof(struct bt_hci_cmd_le_set_pa_response_data),
+			false,
+			le_set_pa_response_data_rsp,
+			sizeof(struct bt_hci_rsp_le_set_pa_response_data),
+			true },
+	{ BT_HCI_CMD_LE_SET_PA_SYNC_SUBEVENT,
+			BT_HCI_BIT_LE_SET_PA_SYNC_SUBEVENT,
+			"LE Set Periodic Sync Subevent",
+			le_set_pa_sync_subevent_cmd,
+			sizeof(struct bt_hci_cmd_le_set_pa_sync_subevent),
+			false,
+			le_set_pa_sync_subevent_rsp,
+			sizeof(struct bt_hci_rsp_le_set_pa_sync_subevent),
+			true },
+	{ BT_HCI_CMD_LE_EXT_CREATE_CONN_V2,
+			BT_HCI_BIT_LE_EXT_CREATE_CONN_V2,
+			"LE Extended Create Connection [v2]",
+			le_ext_create_conn_v2_cmd,
+			sizeof(struct bt_hci_cmd_le_ext_create_conn_v2),
+			false,
+			status_rsp, 1, true },
+	{ BT_HCI_CMD_LE_SET_PA_PARAMS_V2,
+			BT_HCI_BIT_LE_SET_PA_PARAMS_V2,
+			"LE Set Periodic Advertising Parameters [v2]",
+			le_set_pa_params_v2_cmd,
+			sizeof(struct bt_hci_cmd_le_set_pa_params_v2),
+			true,
+			le_set_pa_params_v2_rsp,
+			sizeof(struct bt_hci_rsp_le_set_pa_params_v2),
+			true },
 	{ BT_HCI_CMD_LE_READ_ALL_LOCAL_FEATURES,
 			BT_HCI_BIT_LE_READ_ALL_LOCAL_FEATURES,
 			"LE Read All Local Features",
-- 
2.47.3

