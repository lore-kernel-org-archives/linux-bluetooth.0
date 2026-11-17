Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931414;
	b=zgw3O0uM9pMr9LR0VfxfAhiKe0JkDGRE4Or6pdJUkHTKjs9bk1wdzhyA1RLB5yiptZDm
	 a5TuZf5Gu+Caf/aODU4cxlRX5EHMOdauNel8nX8wlUKdru+goDNBtjoJYPo7x/cS+FHjH
	 BTvcDj7KDA44PD701JbzCt+rUnguMaprQkElLTs6DbBbZSCsoW6I636Oma3tFjjI0XmId
	 LZy6r0oxHxJmTiBZQWdqtLQn4COU2rb3NgZCFYa0tOpX1RBg3oGprGQEsa+lJ2m9UTi7l
	 f0Qhfr4TT+7RnHY2rjCEORMNV6QV4rd6MspqD8Cb9fqJOjbym2RS09d+ag4bmu01gTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iqiT6BZnmusptmhgMhlG8X5aWhueINYljjickO/2E9Q=;
	b=l49bGfKYxYk8FyBGaocRn5Oy8aAuPMFImhNZ8cC+DWYU8UXygAzSMO5rK32RQjziR8wn
	 kx8BZsMLpuQpgqdps7MTPSBv7o6Zn7WuQCpLHc080tj6AyHruNgzi6A1zE/2sq3J/00jx
	 sBW3iuh6U0ydopAV7hquhi3KT/paKd7EVS98sEiADpVY1/7JHB7D7wFG1vejAD4T++Ba7
	 JQhEZuqL2frOw3WarQZr++I26xQBbGVYa7Vu3OSJ/xcil5+31w1v8K0w7Tu0hdRpd2kvl
	 yZqNra0AH75fyoXxkVbH+I3gHZOplMPtz4sjZJypfhHNawmOO0U47bF/eGMPy96khQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vn9Z9cni;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB8606A32A
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 16:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89DB8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vn9Z9cni
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb5e3cbf45so465e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 08:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794931412; x=1795536212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iqiT6BZnmusptmhgMhlG8X5aWhueINYljjickO/2E9Q=;
        b=vn9Z9cnicPd7DYo7s8vKiX0323FiRn+YPBYacUElqijOIbZIV7o2v8TeGdcLzLG57I
         n+m7d+ZxqJLr7iZdoTUBExlMK3yNgFkear+OaxUXdka8r36jOwE7fo2v4Yc3LL6CzNSz
         8XmFS3UBMjaYjGX4bqQI55eeEt8sRmX4bGjRBsrENcIhD7L1sv3stmipep4bQdlSgti7
         ZCEb1kU9ABqh1QzcL1yqD/AJYgmkb1gB7U1FlCllEDJNgdPlBD+Bfh1TXDOAqzL1ZgMk
         ZC22Tz+J9ucDdgY5x1ZiEcKU9SrGpps0FVqPmagTEDasYZ+gYV2BszDtjpOHa+UTlEPV
         87/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794931412; x=1795536212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iqiT6BZnmusptmhgMhlG8X5aWhueINYljjickO/2E9Q=;
        b=VrHIPkniBhFNmL/0b8sxcDo9aNkbb6Fa76UKR7YQucy1nAGmP2QIuAfPrInsstEWoh
         NTgDNRff3n8NPKeTOkHiUxuPnsV7UPa2jtCbdtNJS6EBLrGOpLYUKQWSZhPaHFyqHGpB
         rPeca/WMJ0XLUgRn7Q3+CL3T1nImjtzfxAT+XtaHB/P32+mGi5IEEZLnXPgo/PwN5R2m
         WcY+R7AI1KyztgZDKo30OvWsjlauv9eKzGM/Mu3lEawktXXZfkymjoFRvDs/NxtNR/I6
         4DcR5Z6q67tjXQ6jFg6egtMHlnRp7Ieav3vhZ6dojg5SBx4qsIhORCBfkwSAKuWm4iz0
         qo7A==
X-Gm-Message-State: APuU4Z//IqmfmvJ1HY9EcMhkZenKQss0BsNsviwUK7L6IaQMLHhq2q8c
	NrkcGx/YwCvOfW4GS3hzcb6FztkDjCxrgURO62zc9v1vEGV34/wjp+Oh9BQXkw==
X-Gm-Gg: AYBFou2OvIcPUoicZyh/lisWy60pwKR2wA4evXUdHlnltb214+5ywp8+26vQjSmhtX3
	2sliPMLgHt+EmkdzQAuZZwOZeMFFWpYWSjURZOuYFxD01QCH6KeCp5VI6vZgWS8fqipard3GdY2
	emWW/OodF6A0wUXIyOifwrjb3lFoiUSQrnJTGmheAENERKiylFuuhlvJ66YPh57SZxxSqL8wYAq
	pEB4Doo6IJ19nE9SjyqkWfi3RD+KnykoIgyFs0EbvfRlsXwEHXXwhGu4rhURJ82VucmDzPsPiHT
	blHFMHA4olxMp5HRlqMmw2n/YwkyhgUGUCB6Ut4IGoBx1jIe9WSO2h0AnWEY+hionW7Vchwss4C
	j3B0X/h+hquBmXyxlR8VteuOwLELXpRhtCMfR38pSWszDYHclzz5fRzAEmIDAadZxV5p3Zy/51A
	qkUxXTnaUdvj7StjfGcSkov2HYMNETKd3iK7Upt5sCZf0QvKkKHQYZcknH0g2f4WUPx1UMXhRXi
	VON171gWDifaoGYZGrvY6fBlfaP11a1Fi/MXMsP2yVAq6dIUlPnGRJTeIok9YeVJDfhODNDry0/
	PfYvNpZbLFKv9mAr0sD0BGlTgyFMpYDZiOXKyts0C85/NfKsX4Y=
X-Received: by 2002:a05:600c:3b83:b0:4bb:7ae0:30bf with SMTP id 5b1f17b1804b1-4bb7ae03105mr38241925e9.2.1794931411678;
        Tue, 17 Nov 2026 08:03:31 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b3a2:d500:342a:4be9:726f:4a50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7839c5c3sm75158285e9.12.2026.11.17.08.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:03:30 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ 4/4] monitor: Add PAwR HCI events decoding
Date: Tue, 17 Nov 2026 17:02:40 +0100
Message-ID: <20261117160240.222556-5-rolandschober1968@gmail.com>
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

Decode the LE Meta events introduced by Periodic Advertising with
Responses (PAwR) in Bluetooth 5.4:

 - LE Periodic Advertising Sync Established [v2]
 - LE Periodic Advertising Report [v2]
 - LE Periodic Advertising Sync Transfer Received [v2]
 - LE Periodic Advertising Subevent Data Request
 - LE Periodic Advertising Response Report
 - LE Enhanced Connection Complete [v2]

The [v2] events reuse the decoding of the events they extend, and
LE Enhanced Connection Complete [v2] is tracked like [v1], both by the
decoder and by the analyze mode.

> HCI Event: LE Meta Event (0x3e) plen 4
      LE Periodic Advertising Subevent Data Request (0x27)
        Handle: 0
        Subevent start: 0 (0x00)
        Subevent data count: 4 (0x04)

> HCI Event: LE Meta Event (0x3e) plen 25
      LE Periodic Advertising Response Report (0x28)
        Handle: 0
        Subevent: 2 (0x02)
        TX status: AUX_SYNC_SUBEVENT_IND was transmitted (0x00)
        Num responses: 2
        Entry 0
          TX power: 127 dBm (0x7f)
          RSSI: -55 dBm (0xc9)
          CTE Type: No Constant Tone Extension (0xff)
          Response slot: 0 (0x00)
          Data status: Complete
          Data length: 5
          Data[5]:
        04 ff 59 00 2a                                   ..Y.*
        Company: Nordic Semiconductor ASA (89)
          Data[1]:
        2a                                               *
        Entry 1
          TX power: 127 dBm (0x7f)
          RSSI: not available (0x7f)
          CTE Type: No Constant Tone Extension (0xff)
          Response slot: 1 (0x01)
          Data status: Failed to receive AUX_SYNC_SUBEVENT_RSP
          Data length: 0

Assisted-by: Claude:claude-fable-5-2
---
 monitor/analyze.c |   1 +
 monitor/bt.h      |  90 +++++++++++++++++++++
 monitor/packet.c  | 193 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 5d54ad61b..b16db8bd1 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -1171,6 +1171,7 @@ static void evt_le_meta_event(struct hci_dev *dev, struct timeval *tv,
 		evt_le_conn_complete(dev, tv, frame, &iov);
 		break;
 	case BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE:
+	case BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE_V2:
 		evt_le_enh_conn_complete(dev, tv, frame, &iov);
 		break;
 	case BT_HCI_EVT_LE_CIS_ESTABLISHED:
diff --git a/monitor/bt.h b/monitor/bt.h
index b97592afb..1231f3e84 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -4457,6 +4457,96 @@ struct bt_hci_evt_le_big_info_adv_report {
 	uint8_t  encryption;
 } __packed;
 
+#define BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED_V2	0x24
+struct bt_hci_evt_le_per_sync_established_v2 {
+	uint8_t  status;
+	uint16_t handle;
+	uint8_t  sid;
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint8_t  phy;
+	uint16_t interval;
+	uint8_t  clock_accuracy;
+	uint8_t  num_subevents;
+	uint8_t  subevent_interval;
+	uint8_t  response_slot_delay;
+	uint8_t  response_slot_spacing;
+} __packed;
+
+#define BT_HCI_EVT_LE_PA_REPORT_V2		0x25
+struct bt_hci_le_pa_report_v2 {
+	uint16_t handle;
+	uint8_t  tx_power;
+	int8_t   rssi;
+	uint8_t  cte_type;
+	uint16_t event_counter;
+	uint8_t  subevent;
+	uint8_t  data_status;
+	uint8_t  data_len;
+	uint8_t  data[];
+} __packed;
+
+#define BT_HCI_EVT_LE_PAST_RECEIVED_V2		0x26
+struct bt_hci_evt_le_past_recv_v2 {
+	uint8_t  status;
+	uint16_t handle;
+	uint16_t service_data;
+	uint16_t sync_handle;
+	uint8_t  sid;
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint8_t  phy;
+	uint16_t interval;
+	uint8_t  clock_accuracy;
+	uint8_t  num_subevents;
+	uint8_t  subevent_interval;
+	uint8_t  response_slot_delay;
+	uint8_t  response_slot_spacing;
+} __packed;
+
+#define BT_HCI_EVT_LE_PA_SUBEVENT_DATA_REQUEST	0x27
+struct bt_hci_evt_le_pa_subevent_data_request {
+	uint8_t  handle;
+	uint8_t  subevent_start;
+	uint8_t  subevent_data_count;
+} __packed;
+
+#define BT_HCI_EVT_LE_PA_RESPONSE_REPORT		0x28
+struct bt_hci_le_pa_response {
+	int8_t   tx_power;
+	int8_t   rssi;
+	uint8_t  cte_type;
+	uint8_t  response_slot;
+	uint8_t  data_status;
+	uint8_t  data_len;
+	uint8_t  data[];
+} __packed;
+
+struct bt_hci_evt_le_pa_response_report {
+	uint8_t  handle;
+	uint8_t  subevent;
+	uint8_t  tx_status;
+	uint8_t  num_responses;
+	struct bt_hci_le_pa_response responses[];
+} __packed;
+
+#define BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE_V2	0x29
+struct bt_hci_evt_le_enhanced_conn_complete_v2 {
+	uint8_t  status;
+	uint16_t handle;
+	uint8_t  role;
+	uint8_t  peer_addr_type;
+	uint8_t  peer_addr[6];
+	uint8_t  local_rpa[6];
+	uint8_t  peer_rpa[6];
+	uint16_t interval;
+	uint16_t latency;
+	uint16_t supv_timeout;
+	uint8_t  clock_accuracy;
+	uint8_t  adv_handle;
+	uint16_t sync_handle;
+} __packed;
+
 #define BT_HCI_EVT_LE_READ_ALL_REMOTE_FEATURES_COMPLETE	0x2B
 struct bt_hci_evt_le_read_all_remote_features_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 17af81a89..c2eae4c94 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13882,6 +13882,28 @@ static void le_enhanced_conn_complete_evt(struct timeval *tv, uint16_t index,
 				(void *)evt->peer_addr, evt->peer_addr_type);
 }
 
+static void le_enhanced_conn_complete_v2_evt(struct timeval *tv,
+				uint16_t index, const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_enhanced_conn_complete_v2 *evt = data;
+
+	/* The v2 event starts with the parameters of the v1 event */
+	le_enhanced_conn_complete_evt(tv, index, data, size);
+
+	if (evt->adv_handle == 0xff)
+		print_field("Advertising handle: No Advertising Handle (0xff)");
+	else
+		print_field("Advertising handle: %u (0x%2.2x)",
+					evt->adv_handle, evt->adv_handle);
+
+	if (le16_to_cpu(evt->sync_handle) == 0xffff)
+		print_field("Sync handle: No Sync Handle (0xffff)");
+	else
+		print_field("Sync handle: %u (0x%4.4x)",
+					le16_to_cpu(evt->sync_handle),
+					le16_to_cpu(evt->sync_handle));
+}
+
 static void le_direct_adv_report_evt(struct timeval *tv, uint16_t index,
 					const void *data, uint8_t size)
 {
@@ -14110,6 +14132,18 @@ static void le_pa_sync_evt(struct timeval *tv, uint16_t index,
 	print_field("Advertiser clock accuracy: 0x%2.2x", evt->clock_accuracy);
 }
 
+static void le_pa_sync_v2_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_per_sync_established_v2 *evt = data;
+
+	/* The v2 event starts with the parameters of the v1 event */
+	le_pa_sync_evt(tv, index, data, size);
+	print_pa_subevents(evt->num_subevents, evt->subevent_interval,
+				evt->response_slot_delay,
+				evt->response_slot_spacing);
+}
+
 static const char *pa_cte_type_str(uint8_t cte_type)
 {
 	switch (cte_type) {
@@ -14161,6 +14195,10 @@ static void print_pa_report_data(uint8_t data_status, uint8_t data_len,
 		str = "Incomplete, data truncated, no more to come";
 		color_on = COLOR_RED;
 		break;
+	case 0xff:
+		str = "Failed to receive AUX_SYNC_SUBEVENT_IND";
+		color_on = COLOR_RED;
+		break;
 	default:
 		str = "Reserved";
 		color_on = COLOR_RED;
@@ -14182,6 +14220,24 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 	print_pa_report_data(evt->data_status, evt->data_len, evt->data);
 }
 
+static void le_pa_report_v2_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
+{
+	const struct bt_hci_le_pa_report_v2 *evt = data;
+
+	print_pa_report_info(evt->handle, evt->tx_power, evt->rssi,
+							evt->cte_type);
+	print_field("Periodic event counter: %u (0x%4.4x)",
+					le16_to_cpu(evt->event_counter),
+					le16_to_cpu(evt->event_counter));
+	if (evt->subevent == 0xff)
+		print_field("Subevent: No subevents (0xff)");
+	else
+		print_field("Subevent: %u (0x%2.2x)", evt->subevent,
+							evt->subevent);
+	print_pa_report_data(evt->data_status, evt->data_len, evt->data);
+}
+
 static void le_pa_sync_lost_evt(struct timeval *tv, uint16_t index,
 					const void *data, uint8_t size)
 {
@@ -14264,6 +14320,119 @@ static void le_past_received_evt(struct timeval *tv, uint16_t index,
 	print_clock_accuracy(evt->clock_accuracy);
 }
 
+static void le_pa_subevent_data_request_evt(struct timeval *tv,
+				uint16_t index, const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_pa_subevent_data_request *evt = data;
+
+	print_handle(evt->handle);
+	print_field("Subevent start: %u (0x%2.2x)", evt->subevent_start,
+						evt->subevent_start);
+	print_field("Subevent data count: %u (0x%2.2x)",
+						evt->subevent_data_count,
+						evt->subevent_data_count);
+}
+
+static void le_pa_response_report_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
+{
+	struct iovec iov = { .iov_base = (void *) data, .iov_len = size };
+	const struct bt_hci_evt_le_pa_response_report *evt;
+	const struct bt_hci_le_pa_response *rsp;
+	const char *color_on;
+	const char *str;
+	uint8_t i;
+
+	evt = util_iov_pull_mem(&iov, sizeof(*evt));
+	if (!evt)
+		goto done;
+
+	print_handle(evt->handle);
+	print_field("Subevent: %u (0x%2.2x)", evt->subevent, evt->subevent);
+
+	switch (evt->tx_status) {
+	case 0x00:
+		str = "AUX_SYNC_SUBEVENT_IND was transmitted";
+		break;
+	case 0x01:
+		str = "AUX_SYNC_SUBEVENT_IND was not transmitted";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("TX status: %s (0x%2.2x)", str, evt->tx_status);
+	print_field("Num responses: %u", evt->num_responses);
+
+	for (i = 0; i < evt->num_responses; i++) {
+		rsp = util_iov_pull_mem(&iov, sizeof(*rsp));
+		if (!rsp)
+			goto done;
+
+		print_field("Entry %u", i);
+		print_field("  TX power: %d dBm (0x%2.2x)", rsp->tx_power,
+						(uint8_t) rsp->tx_power);
+		if (rsp->rssi == 127)
+			print_field("  RSSI: not available (0x%2.2x)",
+						(uint8_t) rsp->rssi);
+		else if (rsp->rssi >= -127 && rsp->rssi <= 20)
+			print_field("  RSSI: %d dBm (0x%2.2x)",
+					rsp->rssi, (uint8_t) rsp->rssi);
+		else
+			print_field("  RSSI: reserved (0x%2.2x)",
+						(uint8_t) rsp->rssi);
+
+		print_field("  CTE Type: %s (0x%2x)",
+				pa_cte_type_str(rsp->cte_type), rsp->cte_type);
+		print_field("  Response slot: %u (0x%2.2x)",
+				rsp->response_slot, rsp->response_slot);
+
+		switch (rsp->data_status) {
+		case 0x00:
+			str = "Complete";
+			color_on = COLOR_GREEN;
+			break;
+		case 0x01:
+			str = "Incomplete, more data to come";
+			color_on = COLOR_YELLOW;
+			break;
+		case 0xff:
+			str = "Failed to receive AUX_SYNC_SUBEVENT_RSP";
+			color_on = COLOR_RED;
+			break;
+		default:
+			str = "Reserved";
+			color_on = COLOR_RED;
+			break;
+		}
+
+		print_field("  Data status: %s%s%s", color_on, str, COLOR_OFF);
+		print_field("  Data length: %u", rsp->data_len);
+
+		if (!util_iov_pull(&iov, rsp->data_len))
+			goto done;
+
+		print_eir("  Data", rsp->data, rsp->data_len, true);
+	}
+
+done:
+	if (iov.iov_len)
+		print_hex_field("  Data", iov.iov_base, iov.iov_len);
+}
+
+static void le_past_received_v2_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_past_recv_v2 *evt = data;
+
+	/* The v2 event starts with the parameters of the v1 event */
+	le_past_received_evt(tv, index, data, size);
+	print_pa_subevents(evt->num_subevents, evt->subevent_interval,
+				evt->response_slot_delay,
+				evt->response_slot_spacing);
+}
+
 static void le_cis_established_evt(struct timeval *tv, uint16_t index,
 					const void *data, uint8_t size)
 {
@@ -15418,6 +15587,30 @@ static const struct subevent_data le_meta_event_table[] = {
 		"LE Broadcast Isochronous Group Info Advertising Report",
 		le_big_info_evt,
 		sizeof(struct bt_hci_evt_le_big_info_adv_report) },
+	{ BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED_V2,
+		"LE Periodic Advertising Sync Established [v2]",
+		le_pa_sync_v2_evt,
+		sizeof(struct bt_hci_evt_le_per_sync_established_v2), true },
+	{ BT_HCI_EVT_LE_PA_REPORT_V2,
+		"LE Periodic Advertising Report [v2]",
+		le_pa_report_v2_evt,
+		sizeof(struct bt_hci_le_pa_report_v2), false },
+	{ BT_HCI_EVT_LE_PAST_RECEIVED_V2,
+		"LE Periodic Advertising Sync Transfer Received [v2]",
+		le_past_received_v2_evt,
+		sizeof(struct bt_hci_evt_le_past_recv_v2), true },
+	{ BT_HCI_EVT_LE_PA_SUBEVENT_DATA_REQUEST,
+		"LE Periodic Advertising Subevent Data Request",
+		le_pa_subevent_data_request_evt,
+		sizeof(struct bt_hci_evt_le_pa_subevent_data_request), true },
+	{ BT_HCI_EVT_LE_PA_RESPONSE_REPORT,
+		"LE Periodic Advertising Response Report",
+		le_pa_response_report_evt,
+		sizeof(struct bt_hci_evt_le_pa_response_report), false },
+	{ BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE_V2,
+		"LE Enhanced Connection Complete [v2]",
+		le_enhanced_conn_complete_v2_evt,
+		sizeof(struct bt_hci_evt_le_enhanced_conn_complete_v2), true },
 	{ BT_HCI_EVT_LE_READ_ALL_REMOTE_FEATURES_COMPLETE,
 		"LE Read All Remote Features Complete",
 		le_read_all_remote_features_complete_evt,
-- 
2.47.3

