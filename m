Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076202;
	b=wk2F8JxKMYlSYgizuOwQFyPMja8X98/LiOhVmcPmgKNFWCpgA9eT4mFEoEU5D3p+EJmB
	 QccI0PC1cmtj9Ru9k8p/LO977Org6dkV87kZoILEVi1FQowiSmA1u2u41LbwPFbl3i/9R
	 wYK5MdABAwCo+dFguGxt0Op+D9SkmRws7PlPFY2Gq4t9+kHVtMUP0mV24FOd1jNNgBRoZ
	 7LwJ3hFvkD9fVV0MmBrKELlwXOu7kO4LcWlzSNf/Ns2i2Rvp98yIk5eI3VaT3mbU3BhUT
	 C/ztReNlgTg9t90nf1wHXXQ2sStE8ljpp133z7ciGXOnz46dPwW348f8o+HSOZWc+Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3GVG1C0VFuOf5e2/RWTwBfJMJQFVw+GJ+1stSK0/3uo=;
	b=fU2zYLD3ZVe7gaIRqHEnF51veb12N5UDoNhgZXHyr+Mm4rbu8VdOZxwkKoegH4lhttcm
	 yfIGhqFq6GO7uT45ukAzNOb+WX90KcmGrYIlBMpP372X3ghr1zelEXjN5DxZuS11oOQLZ
	 irKTE1gjCjRkXqk8CKoXf7d6HBhn3cxjqq5tM75jtRBQEFrUKc+LgC7vC2kZ7E8Dyy3Ve
	 cp620i1hp9JEyYG4m+QKxRjobck70mE4jbn8bi5P02rWOycx2K/bVAnllRYCDytH7DloJ
	 FbgUxv1+nYT4zjQwsjrOtDkuYOG1zgPem3zQehfqZ1dsjQ2AUz/6PR3rB+/YDKdYAew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RZZoIdjz;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54106606A822
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 08:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54106606A822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RZZoIdjz
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b86bbbe954so303314a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795076201; x=1795681001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3GVG1C0VFuOf5e2/RWTwBfJMJQFVw+GJ+1stSK0/3uo=;
        b=RZZoIdjzrnEqaOYCThahVmB6Roh5O5gfDAp9t1aw45a4Tew2U7IkIUtWGoeRbUz0y2
         rqTgwghNP0U8HDR4WLZ8Rn3W3+vsUGPUZrE+7RycrWtRe6WmznYuFikMdK2GbAsL5Nwp
         2lV8IsdEXAEmU8eykv4/ZobplQrGVpPxyAZAjQa9f8jinK+NfDConncYAQlVzfXNw6dq
         02uFzJW7/NdDQKlRx3LusgvCOGimQjDGgkLbLK4xsBRYlJ2pvSpCfjkML4KGtbhL0nAm
         vc++1h9bRyKGrZ/tERkeoW987lBBjdFf/5tB57Es9BAvlmHW24oXON161DLcqmsAFVZv
         lNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076201; x=1795681001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3GVG1C0VFuOf5e2/RWTwBfJMJQFVw+GJ+1stSK0/3uo=;
        b=yrbr72O/sAlUndZ9yMW0l6toi3sZVeUfumpCwyr+hGDhn++o5nSw/RXzmH4mZwirQ6
         50E7hJDje5ijmGiBk8aX8pPwU+w1DBnxkiw4aiIhqgm4ZpWiYyjAnnwol2/LHctjTE7V
         U1LF+c/H9Pttjmtj+nR2mUWkpZ4pXxC2q1gHWm7DbIGAGhUSIMBHkGLCKeA+nmBrU+p8
         KI006hEy7hbqqvJzhP7d7u7R8VsYVAIt4LoS/YcfZk69/bwliMgOztiQFYLVVsKT2HED
         RNt3465yQvCk0wyuNh47rXfUtx9GXvmMuGwrhXC4+Dy4Kru7O8l/W9fFt1YjVekmf4x0
         1k3Q==
X-Gm-Message-State: APuU4Z+B5RWOCqPz6ILC3Rfl72g4FeFTntA18sX9AJRRv0Now79PFqhN
	6gHvErx2CDChzOrSP5bV3chhTvPiueMO7pdn4lMCxGG9HZKf7bgWpVwzrEXvxhLk
X-Gm-Gg: AYBFou2/FSkXTvb5T3CFsNxuYH1Pu1E+dIiXGo2GYgI7Z0PczNtUj20Kom+/lZJJ8dR
	YMwP3tyka9qEgpBhKXokKV7osz+EO4yt1pvkbXHreQkFMSawAAhUEQa8ykuvj4oWVD8EN7690TT
	yCgpy+KPfCIISTV2Zku3sayVmJLOHeZSnSpzDWf4TFwotqqbfpwXsNTEk4fTFpyeZAv01uwUK2Q
	FoXJQ8F+WPyKHU9lcM2mrIRDjxc9eFnH1ki5w7Zhnx879DR13GWGzbxnwQyq3NXqtoIs222a+na
	leVTn5X6fgR5Vus3wPrwk9fCEmB/QFWVwSZ0XiufA9vlvbMy2WXltQiovwssni+lm14MJC1qlfI
	HrTW6e5iNoE1wTsXhTRcdXSCbvEplFLTZUdzeBXE+5wT5xTK8GezKfSKGbjByv3/865Q96M8fxv
	fm7IRJRz4UKzXPYuQUOtohFLTexjj6rBEA89NytETw3uGk2Cp75PS6XWVGed/e9Ga7G4sn8Q5q4
	zE/rbKjusAstbMDG7+n+nQf+FIByDDTVFH0GvtXKKxVle6aWzE6u5gEMlWcCOXx6KjMRA2ovEvz
	dxdPNNz6i0p4aPaIlu6qRAZSGahpYxowpJ8=
X-Received: by 2002:a05:6402:a147:b0:6b7:9fa5:8ed6 with SMTP id 4fb4d7f45d1cf-6b887e83a46mr4377824a12.2.1795076200311;
        Thu, 19 Nov 2026 00:16:40 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a22e143sm2229580a12.29.2026.11.19.00.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:16:39 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v3 8/9] monitor: Add PAwR HCI commands decoding
Date: Thu, 19 Nov 2026 09:16:20 +0100
Message-ID: <20261119081621.112623-9-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119081621.112623-1-rolandschober1968@gmail.com>
References: <20261119081621.112623-1-rolandschober1968@gmail.com>
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

LE Extended Create Connection [v2] is matched with the events which
complete it like [v1].

The subevent data of LE Set Periodic Advertising Subevent Data is a
list of elements of variable length, each with its own AD structures:

< HCI Command: LE Set Periodic Advertising.. (0x08|0x0082) plen 15
        Handle: 0x00
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

< HCI Command: LE Set Periodic Advertising.. (0x08|0x0086) plen 12
        Handle: 0x00
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
 monitor/bt.h     |  84 ++++++++++++++++
 monitor/packet.c | 247 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 326 insertions(+), 5 deletions(-)

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
index fa19139d9..edf09ac10 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -230,6 +230,10 @@ static const struct deferred_data deferred_table[] = {
 	{ BT_HCI_CMD_LE_CREATE_CONN, 0x3e, 0x0a, PENDING_KEY_NONE, 0, 0 },
 	{ BT_HCI_CMD_LE_EXT_CREATE_CONN, 0x3e, 0x01, PENDING_KEY_NONE, 0, 0 },
 	{ BT_HCI_CMD_LE_EXT_CREATE_CONN, 0x3e, 0x0a, PENDING_KEY_NONE, 0, 0 },
+	{ BT_HCI_CMD_LE_EXT_CREATE_CONN_V2, 0x3e, 0x01,
+					PENDING_KEY_NONE, 0, 0 },
+	{ BT_HCI_CMD_LE_EXT_CREATE_CONN_V2, 0x3e, 0x0a,
+					PENDING_KEY_NONE, 0, 0 },
 	{ }
 };
 
@@ -8710,6 +8714,179 @@ static void le_set_pa_params_cmd(uint16_t index, const void *data, uint8_t size)
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
+	/* 0x00 is used by the events for trains without responses */
+	if (!interval)
+		print_field("Subevent interval: None (0x00)");
+	else
+		print_field("Subevent interval: %.2f msec (0x%2.2x)",
+						interval * 1.25, interval);
+
+	if (!delay)
+		print_field("Response slot delay: None (0x00)");
+	else
+		print_field("Response slot delay: %.2f msec (0x%2.2x)",
+						delay * 1.25, delay);
+
+	if (!spacing)
+		print_field("Response slot spacing: None (0x00)");
+	else
+		print_field("Response slot spacing: %.3f msec (0x%2.2x)",
+						spacing * 0.125, spacing);
+}
+
+static void le_set_pa_params_v2_cmd(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_pa_params_v2 *cmd = data;
+
+	/* The v2 command starts with the parameters of the v1 command */
+	le_set_pa_params_cmd(index, data, size);
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
+	print_field("Handle: 0x%2.2x", rsp->handle);
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
+		return;
+
+	print_field("Handle: 0x%2.2x", cmd->handle);
+	print_field("Num subevents: %u", cmd->num_subevents);
+
+	for (i = 0; i < cmd->num_subevents; i++) {
+		se = util_iov_pull_mem(&iov, sizeof(*se));
+		if (!se)
+			break;
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
+			break;
+
+		print_eir("  Data", se->data, se->data_len, true);
+	}
+
+	/* Fewer entries than announced, or octets after the last one */
+	if (i < cmd->num_subevents || iov.iov_len) {
+		print_text(COLOR_ERROR, "  invalid packet size");
+		if (iov.iov_len)
+			print_hex_field("  Data", iov.iov_base, iov.iov_len);
+	}
+}
+
+static void le_set_pa_subevent_data_rsp(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_rsp_le_set_pa_subevent_data *rsp = data;
+
+	print_status(rsp->status);
+	print_field("Handle: 0x%2.2x", rsp->handle);
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
+
+	if (cmd->data_len != size - sizeof(*cmd)) {
+		print_text(COLOR_ERROR, "invalid data length");
+		packet_hexdump(cmd->data, size - sizeof(*cmd));
+		return;
+	}
+
+	print_eir("Data", cmd->data, cmd->data_len, true);
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
@@ -8902,6 +9079,28 @@ static void le_ext_create_conn_cmd(uint16_t index, const void *data,
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
@@ -12019,11 +12218,49 @@ static const struct opcode_data opcode_table[] = {
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

