Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931411;
	b=4OO0pTRGBai0auK2JjEu4PWUXDFHX7/7zqsu+FKKbomC6aEMEZs5wzypdVDoOs6K2qQR
	 Y8DQEu4T6uZQ3PcqRCFkJ/MTzC0wkY1EHZmEhMhnKbj2Tvq7g8rrv1z3VClpGUXgNyvC3
	 T4q0DWylrB9r/wv8PXWfXFA2CbE0McGRRqaO2kylOWvUC5gNSrECCj6zdg0ZLjxL+qIEx
	 J/kJbfq+qKXBi85MeHjNiU3pXa2PEGTRR77/TUJOgkJiSYij0fKCiPKGg3anOtjG6pyfa
	 ErahQxQasdoMtonu31igpr+xgvFM3Y8WtbUz0mcZt78ucb+IlhnR9xS8TovCs19lCDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sNp8wU783bBeleVaRhrLzrBCm8t4j+Y2IKyKMU8Xdrc=;
	b=If+iUTuTh3G4tgb3Sph4wVHqPURdF+m6Hpn1lV6L+UGoXukf/DDgNEWawfrXnEvPwgeC
	 N4RpnznhxvT6Z8uEhZh3GfKTx9mYpRMqVKJqOeJamnKDX1qGVLz0jqcB48aDqxHt89Q4f
	 rCvwZ23b6/kf+0QrIPrbElA20OU+blhngecw9536Agu42Zm80iG/NxRXCiilmV8fJPoPL
	 e6gVpXvJ2KbOZCkOx/8W/ODKlAlQPk5BcGfERKY4Rb1F6a1KcQjEHQ849Gq95I3LRTR28
	 XJ1zJs2xqmI9v12DhfEG71/a+TYXmjdshVcyxd3gy5kUYw56MY4378aXeVIsfu0IxhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HJTfie2s;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D9606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 16:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 762D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HJTfie2s
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb7679f28bso1276855e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 08:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794931410; x=1795536210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sNp8wU783bBeleVaRhrLzrBCm8t4j+Y2IKyKMU8Xdrc=;
        b=HJTfie2suT0Hep/6JPyXLS9V7ZDcf0lquv2pndRsenbdGwIM0uneAml4enQnd29glZ
         HYh2ih8062Z7J86rQMYwG6If2KPoZSfy5Cz7BbdMobJ4fjDnMrP1KEOI2k749ewGKxft
         cgmscqGi8DxAJDO8yz2iacYZkk+wcSgngFOYidT4m8bO8ytgrqdTHJWf3E1Ozgotiu+K
         nLknXG4GYVP1fUk91lhBzgbbuyypXF/FJ/3Zc/VfDY6g1jQJxSXxXM1RE3jwfwyJDXjv
         xpvRzN39vkJfFNd55m/2EPfe299JJTjhaEWDcXcZgRdQ8VyhoSAeYx8vfvIfrTjW1Bo3
         NElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794931410; x=1795536210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sNp8wU783bBeleVaRhrLzrBCm8t4j+Y2IKyKMU8Xdrc=;
        b=e5zre9kdom1PI+4x3oEd96C2C6hBqRTPAIzjjydw2NZ3FbUyT15GBthC0oVdaP8fF/
         X0OHtemn9WKgNVqlz9F6Dyfjyqh+WNEWzsuDphUIUuqxI3b938BMcN8OVu0lHMRb6BG5
         lgTGtWLqPZPUUDjg9kyYw3hV0z6XRSGl/h9n/ml8KOHAKFrzDHt/c8QxO6kkp9T+GWnK
         OFvkYblvosbkM1EIUvlrKQ5x/3KffIuSXaaTc/nEx+5GEXaR4wVmNTyBa/ohOBcFfrWf
         yPooHOgofROIytVbZ+xZmjOQBPL4b82PylnhJnaOZxJArpf2bOwuWtiWJnmv+Efu+nRY
         D21w==
X-Gm-Message-State: APuU4Z/Esva0vcecLAY3flgGyU1cna/zv54DWbVM52yH8lQttJ6mMIeN
	YG8wYwAkT/sS6YhdgEl5Y5twNVd5Sx4XtjalERcvRMzzsmjOCc5Y7uDoh82wQg==
X-Gm-Gg: AYBFou3BdQcdInMwDfNJmmHQH1Cde1A+7IWC0I1DILL4JA9HvelwhynDFvEehepIQ+/
	Nk911GTV1Oak5ngDpnnOI6IAmF8C2MgOiVNRU49ByoVKvZy9iEvUk3Bjc25qDNhVOKQIP+HYIrQ
	wsrt25g/bMIGuRWXyCu2uWa+yvJ2gjGZvhJYzZnyax+BxcUbduQOVPxwzMLLPLWSzT1NnQVMZEI
	IEopry5YoP7LQx4ovuq7PHv+4K+DU8sNC2WIuCdzEoBdmO+1UZQWvboAsjZBjJojxCgPp3tn9zf
	TYz7jjIhIhk4dyNs/Li/kiuLTdaJ0TUM9vZcgHuKUvbunrHJYBBwpzS8xfQln/g+5fPMVe6CCuO
	r80KSrfrz9rK/clqyVkcPQsq1239UFMkdtmVWjYSvkAtNbrXD1gtzHDdMW2ScelB5K0vaG3wvCc
	5GDZ0magzDMFCS8GhgFRWOVcVM0UQ6qrSTV7UI/wg0fPfs213xmr+XcEQyQ7As6jom0I9n628Wb
	xZ5Dq7H3RBtE1Z7xE/r95l7YLOaKGTehNo7mwv/Z5rQRDVHTd7CIR+s1KpQciZ2c57aly/zuCMm
	YBr9mBHa69cKAHNBf7nDaIEs65wHlyWa2gzUhjw4/g0ocN6EOA==
X-Received: by 2002:a05:600c:8b74:b0:4bb:6a02:d42e with SMTP id 5b1f17b1804b1-4bb6a02d56cmr171462355e9.1.1794931409679;
        Tue, 17 Nov 2026 08:03:29 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b3a2:d500:342a:4be9:726f:4a50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7839c5c3sm75158285e9.12.2026.11.17.08.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:03:25 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ 3/4] monitor: Add PAwR HCI commands decoding
Date: Tue, 17 Nov 2026 17:02:39 +0100
Message-ID: <20261117160240.222556-4-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117160240.222556-1-rolandschober1968@gmail.com>
References: <20261117160240.222556-1-rolandschober1968@gmail.com>
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
index b31b8c31c..17af81a89 100644
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
@@ -8883,6 +9036,28 @@ static void le_ext_create_conn_cmd(uint16_t index, const void *data,
 	print_ext_conn_phys(cmd->data, cmd->phys);
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
@@ -12000,11 +12175,49 @@ static const struct opcode_data opcode_table[] = {
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

