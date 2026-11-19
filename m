Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072445;
	b=KhpqqGifJ+RlJBSxdL2i4R2R+/ryAdGcX8xfflC7RU5GHKOZ8P3SAi5yo4xfNLCnitfX
	 Xbv5ekbt7tg8uVBljdDvtUEFTG6qvVZrEpeqQUDr3zKe7Fp2RqcFwYs7YKozsbyymae52
	 bRsQ8CxfTBXCpov83RtIHe5GEtqYYd/mD4duFx9AxTGdYvTbWX/yawrHauNtMQeydjq0y
	 CzPesI+vtisEjRw+I78/Fr8bVzm/90J3AZW4VNa7x8nCCkb3Exe75Qvl3EaR8fGWWfF9W
	 Xx58cDCnpBqisonUCj+3ndp/ubgI0BQQeTLoWXwLJCo/fqlNrQWIrrXkTm3ItEi6grA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5WlCUO5g/fMRbppqo2RAiZEc/rurNYZooax/yKNPFsg=;
	b=n+POdIxXnc1ZDmWIZsJzVh65PJ1oEToya0aI5DzQ7qn0aaKy1gvtpEXl7sDvio9QaIdX
	 wfE4ae7YUY0hhepSRkeyIVSBIDMfkMKAslEgWy2idm/LPj7RAce7cKtxOP/cN0yCcmkKn
	 iMfPYbM/v36wxPw+wcKLFeUlhfhiapIWDwzuTRYsye3pwszynCHrSOb4ReTLQlT3pu9co
	 6Si6PIjkE14HL1C8X0ve7fBla50qncTuNEFua+uo7Xe5JKqIWDD1SmRg8LsWwwfGX0P9e
	 zMDMxXpCLxxOx1W8MDVLE02gWEmlEP89ju5sY1/WVas8Lt92JYzABKwHY48k4/4FXtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjJYtvD5;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D72606A32F
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 07:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98D72606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjJYtvD5
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5348aaba5so1655545e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 23:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072443; x=1795677243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5WlCUO5g/fMRbppqo2RAiZEc/rurNYZooax/yKNPFsg=;
        b=fjJYtvD5hdMGy2rdmXrNUXDyeZdogLTZ5Ud8DUAQBpoeSamvVngp05WtpP1N1dyLdi
         VKh0N05BExt0xXZEaAoKi1F12L/0ZQoPlsxfihYtA0JDm7GoMekTOqiPUKhdFTa2ldxl
         dQfvQrxDM5WDCEhna3g8cMN3mrlo02Z5PAOSXwpFl+ReF6fOlrW/clBKHrQ+gxz0xtEs
         67W2uEF1Db/2AmDhh7WQhWyX45qxCSaYnDmbKg3HX3F90IY4QVGFT7341+Jj0JRuhNLQ
         hLADad925HxVkONNVUIN16gaHuG9XESKP3XqsmzVgs7a6XA1rwqRk9GTDRkWzUKEAnQg
         3zKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072443; x=1795677243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5WlCUO5g/fMRbppqo2RAiZEc/rurNYZooax/yKNPFsg=;
        b=sDdIZna7+W5kaSnQb5TMt5ZPwT5AsGsCghUJpAlCNs+RDiGWtsp/ImGODPkDPTHamr
         6Lw9D/h87qRW0QhV1iKT0egz+nMfR0z9neInjfpZxjHZuRMKjVS8BcVbYULJ9hbulaEk
         +kE2159HkK0Sa5sf++Uxy7Y42jXXhnTcdAX60eeFa+s4vgmlJyCMiEtyH2lCYrboxDCW
         rppEOJ7Vu/qmFebKUmN94rRT0Jz9hI1zqV5dU7ouubbf4OM636IRZ/NPt3iHuAQb6zsH
         vlcHJ2hAvEzwCiz3n79Y0/GA+PNm1bprKQQTEeo82xK5kl9QWP16Il+B5dLg/33iKkuy
         1C9A==
X-Gm-Message-State: APuU4Z8qfBmJk/rDYIgx9Afd/wJGwqi01/H2Jgqm/x+jMRaDqOQ8oQCd
	qzSMzH6D5V3oTB/5/ls3guERtTY8gZDRgnb3a+3qOcP3JZ/36RevkUfpg21/sHvZ
X-Gm-Gg: AYBFou0o6uYBeB0qJsdUnrmqY/vY+8v5c0cocQ+xf0dY1pCms8jyCyVHGPFFyFanf21
	NQxBIBZXzXeIsnBZ/U4fJhMWbgsVvK5x4ZkoC9HOuinwbvDd5FRHNNCaE58ON02PGwe8KPHnmBm
	k2T39Ax7BNb7ehW1mChLbAH8cy36h/V48x/bwhirzybPunlLM/C/JPaAx2SO3z8whNqqgyUJxaB
	lxKEBYzIkHYZNgVJ4FbaZQAbxyQAsZm4qKdukd82HqzmAdKXzRW2f7wFFNXqgSt+3ylE25klLZ+
	Fb7fSrKf3nTc10iQROPHR1tfpCe7G3XXwQEcIPB3tskVSbifTHyoDMsHXPrAayEsQE4XJY2k3vo
	R3GA1IkynRVbT+0Pi3w1CHJmaaz8H7yGF0v2TAaxFt9G9U83K6I2S/LRDuvt5eYHx00cGVCzg2c
	sjRI8knVj+HjCFd57+btXngPG5UPpD6asTpS5x/mSGSRXq0fFcK49OIhC9quDMqVa4yO44wddMt
	cQwKiRcTz3UgjHGwqmhH7Qt+OiiHAMWVneSGu1FQNw8Xu2Ink/fU5Hog4/VhU1e2l/yyRZmEjSk
	9pWPfRn/4udpOHib/Kbv/RcRejzaAjq47K8=
X-Received: by 2002:a05:600c:4c9a:b0:4a2:417:7db5 with SMTP id 5b1f17b1804b1-4bb7da06f7cmr54692975e9.2.1795072442832;
        Wed, 18 Nov 2026 23:14:02 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85343607sm17549165e9.6.2026.11.18.23.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:14:02 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v2 6/6] monitor: Add PAwR HCI events decoding
Date: Thu, 19 Nov 2026 08:13:32 +0100
Message-ID: <20261119071332.32424-7-rolandschober1968@gmail.com>
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
 monitor/packet.c  | 194 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 285 insertions(+)

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
index 6089dc061..1f942402f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13890,6 +13890,28 @@ static void le_enhanced_conn_complete_evt(struct timeval *tv, uint16_t index,
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
@@ -14118,6 +14140,18 @@ static void le_pa_sync_evt(struct timeval *tv, uint16_t index,
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
@@ -14169,6 +14203,10 @@ static void print_pa_report_data(uint8_t data_status, uint8_t data_len,
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
@@ -14198,6 +14236,25 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 							size - sizeof(*evt));
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
+	print_pa_report_data(evt->data_status, evt->data_len, evt->data,
+							size - sizeof(*evt));
+}
+
 static void le_pa_sync_lost_evt(struct timeval *tv, uint16_t index,
 					const void *data, uint8_t size)
 {
@@ -14280,6 +14337,119 @@ static void le_past_received_evt(struct timeval *tv, uint16_t index,
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
@@ -15434,6 +15604,30 @@ static const struct subevent_data le_meta_event_table[] = {
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

