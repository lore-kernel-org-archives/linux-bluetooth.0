Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156749;
	b=QuY7BvT5ch5fCxZI4n6MOdCYQuR4U9ecbZBmiBYSMBnO2U4v0PJxpsz8kRAEeyqcsojv
	 HI1zD1I0aRmYtMPvhoubxjbb0x5z153gvFtA8l1OiUQs06cd4ZQT2Nu4QsbroAE9XBktv
	 EX0S0kHjLrXRHR6mC4oYf9DNI2MPAUISUtdEE4gwvYbRw0+SsQz9zqr45UxGqR7WElDPG
	 2LdYBW0EtyC1z/sb8JolrozitWyb4SnQVqrQZ8zFKMSHBmUDnyxKTaIi7Mytb5oCCAdw4
	 CQ8yqsgPsJj62TiPzK4A6Y16ZpJkXRyEh4tZrlG+VDTy+8D/CDC6QEyx/1zHs+QvuJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V7a98rVQA40NEt/ZfYVaH8SmYZ0+JjVR8CGGjqJnohU=;
	b=RCawc1MwNd1pvNwfNp92uAFn9htJ3D8q7v8y4VB2Hgqw3j1ARN9t6Mfm6nOLS8EpQNF0
	 H7SmeWXB8oJM8t2Dsk/omD8ldK7RWPkb88CZ80L0oJjYgqA3RPbWMEnJRRwIyXR3pyvip
	 yj2T4LnvTBnuxK29Hh4auP1tA0e/B3OxfCqYd/gxHEEirAfCblKa9Xs9InS7NWoeQ+Uxh
	 QKWbZbwdlWcdBIwk3Nq2nHrzBBNOAWGwtJiNeOQ7YbzSyHmy/gfou53qbhsiJFk0DKjTg
	 KVGF4Ks7v9Kb/RiLBjgx/v2PXSUYoBj66xvdIEqh8OETlaLgWAtu8Rj3qRVeSBj4Rmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KPerRgkL;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CD960A260D
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 06:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20CD960A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KPerRgkL
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4a35df85cc8so18212f8f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156747; x=1795761547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V7a98rVQA40NEt/ZfYVaH8SmYZ0+JjVR8CGGjqJnohU=;
        b=KPerRgkLv9OY9PPDw7hSIX3YOy1rfVtTeMpkup/mRdoEFrm88Lhk/GPMJBSp3WaIyQ
         eqzIW3JJIFafCugWly2bnkrIxOIA9rAPnNOQGkDInQzYLyNOJJP73flX1zPDWd2UDCpP
         6Qe7hRHJxeJt8ysB7LKPbCVW0gd/iuomjT0SXLeCPhgu+qTbyGKjEZa7Ikhe3k54BCx+
         CAjbJswOsHMhCYi5WI0g81dmJzGl1mFiRgGPe/iOXgh8wQltGQxKfcyYUFwmWdXitWXD
         uCVQOn2Au+xtR/tVYckbpd/Y/rYdsNpl4FDdI6U8L0I64erHz2IhcQ5dPneyfkDNeeKU
         8EOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156747; x=1795761547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V7a98rVQA40NEt/ZfYVaH8SmYZ0+JjVR8CGGjqJnohU=;
        b=2TWhZje1y9yc6iBLnkD4rDQJLExHtNUcmMSiNYV5aKoMVoc6AbL0xmsjfr7NhOnOVX
         z7pl0PCTXrNMMCuh41ELKopzdJHNRmsWJPmyp4vSSkNjJU2IPJjbFbAEljp3r0DNunPk
         94ukxPNyav1F+ZZHAGqgJdfzdK303xbVVraBf0Jfvkv90T0Ic0FA/9k1X5VWAtcd7D7+
         XVMWhkBCjQ8tf3DH4M3DqdBozMDiIjTmKWH6Olvpu+5i8htm2LooWFcroQR6VAt84sxE
         L1fGybMEfGdOVEX/dgNUDFwk53WB25NBVXJlMnc+KcvYDrSWlPurQo/OdEKttFmvWUhs
         Q4Zg==
X-Gm-Message-State: APuU4Z8hqo+TVSo88NCd+YqxA7EWrg+quvtylvekkGb+fjvOOQTl1n1y
	UzPCHA0FJ6bw/DE2Ivl7C9pJJa9H/lX5H7MFimVGAN79Huq1eQG5CN98UzWssHE/
X-Gm-Gg: AZFdTZc2B0W2cobZk2IpX+8td41MQcphQYG1weY/FGvCQgzZKhoHkIgxPfFxPWq2mGY
	Bn99La1E2s0yMviSaBJ/Xk5TDXag9ShTNErdVgKQsihisDUkOYNqJceCfuPGVJKQef/lKLLnvvX
	zKmwHvwSxkgpw1gg4fxnDAnBIpO+VOngwLDxFnZdmvf054tBiFhuFJzJlxNw4mKkVs0qXBiAgQ3
	92hdUIqeQC6NmIC33d0keFq4IeefZ6zI98sKLkzAbnnC3xfYGG2SgIJ6ys2JzDNR/tkDNW6+nyy
	AXxWNgPQZRyCdI40ZqVlTMObLE5x7w/0WQ4070QKrcBCewFzq0dTm+i0MgJ1xPGlEdk35wEhCpg
	t3iAB4S9dArb5hFV9e36Y36EDtIbWuJlKN3PWwluwioTouiHzUlNTrcWjZIObIg3DOQEGZ9bi4m
	owI5nkpdIhnHF+81C0ldJJhLBGv5Cxw+oQA9GRUpxJI8chc/pwdD46e25y9j8DJle3JhiyQVxqB
	q4vKnY8luSGv4FUBtR0i2pGzR1Ppnhe+GgbmgV7h5RExPj15ZxdIDsKbwW8DfzgUnfw0Wx+ud+l
	ful5/q+b9JsZrcZcrmuqxtpQRNBlYXLD8Sh+QW0wtL0WdWRfZ+LCBzEU
X-Received: by 2002:a5d:5888:0:b0:49d:2e96:4d55 with SMTP id ffacd0b85a97d-4abb46bc931mr3391518f8f.6.1795156747352;
        Thu, 19 Nov 2026 22:39:07 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm3685607f8f.16.2026.11.19.22.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:39:07 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v4 10/10] monitor: Add PAwR HCI events decoding
Date: Fri, 20 Nov 2026 07:38:56 +0100
Message-ID: <20261120063856.16585-11-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120063856.16585-1-rolandschober1968@gmail.com>
References: <20261120063856.16585-1-rolandschober1968@gmail.com>
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
decoder and by the analyze mode, and is matched with the LE Create
Connection command which started the connection.

> HCI Event: LE Meta Event (0x3e) plen 4
      LE Periodic Advertising Subevent Data Request (0x27)
        Handle: 0x00
        Subevent start: 0 (0x00)
        Subevent data count: 4 (0x04)

> HCI Event: LE Meta Event (0x3e) plen 22
      LE Periodic Advertising Response Report (0x28)
        Handle: 0x00
        Subevent: 2 (0x02)
        TX status: AUX_SYNC_SUBEVENT_IND was transmitted (0x00)
        Num responses: 2
        Entry 0
          TX power: not available (0x7f)
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
          TX power: not available (0x7f)
          RSSI: not available (0x7f)
          CTE Type: No Constant Tone Extension (0xff)
          Response slot: 1 (0x01)
          Data status: Failed to receive AUX_SYNC_SUBEVENT_RSP
          Data length: 0

Assisted-by: Claude:claude-opus-5-5
Assisted-by: Claude:claude-fable-5-2
---
 monitor/analyze.c |   1 +
 monitor/bt.h      |  90 +++++++++++++++++++++
 monitor/packet.c  | 197 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 286 insertions(+), 2 deletions(-)

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
index 4c4df1d97..8e6e9aee8 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -234,6 +234,10 @@ static const struct deferred_data deferred_table[] = {
 					PENDING_KEY_NONE, 0, 0 },
 	{ BT_HCI_CMD_LE_EXT_CREATE_CONN_V2, 0x3e, 0x0a,
 					PENDING_KEY_NONE, 0, 0 },
+	{ BT_HCI_CMD_LE_CREATE_CONN, 0x3e, 0x29, PENDING_KEY_NONE, 0, 0 },
+	{ BT_HCI_CMD_LE_EXT_CREATE_CONN, 0x3e, 0x29, PENDING_KEY_NONE, 0, 0 },
+	{ BT_HCI_CMD_LE_EXT_CREATE_CONN_V2, 0x3e, 0x29,
+					PENDING_KEY_NONE, 0, 0 },
 	{ }
 };
 
@@ -13926,6 +13930,28 @@ static void le_enhanced_conn_complete_evt(struct timeval *tv, uint16_t index,
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
@@ -14154,6 +14180,18 @@ static void le_pa_sync_evt(struct timeval *tv, uint16_t index,
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
@@ -14204,7 +14242,8 @@ static void print_pa_report_info(uint16_t handle, uint8_t tx_power,
 }
 
 static void print_pa_report_data(uint8_t data_status, uint8_t data_len,
-					const uint8_t *data, uint8_t size)
+					const uint8_t *data, uint8_t size,
+					bool subevents)
 {
 	const char *color_on;
 	const char *str;
@@ -14228,6 +14267,10 @@ static void print_pa_report_data(uint8_t data_status, uint8_t data_len,
 		break;
 	}
 
+	/* Only the [v2] event, which reports subevents, defines 0xff */
+	if (data_status == 0xff && subevents)
+		str = "Failed to receive AUX_SYNC_SUBEVENT_IND";
+
 	print_field("Data status: %s%s%s", color_on, str, COLOR_OFF);
 	print_field("Data length: %u", data_len);
 
@@ -14248,7 +14291,26 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 	print_pa_report_info(le16_to_cpu(evt->handle), evt->tx_power,
 						evt->rssi, evt->cte_type);
 	print_pa_report_data(evt->data_status, evt->data_len, evt->data,
-							size - sizeof(*evt));
+					size - sizeof(*evt), false);
+}
+
+static void le_pa_report_v2_evt(struct timeval *tv, uint16_t index,
+				const void *data, uint8_t size)
+{
+	const struct bt_hci_le_pa_report_v2 *evt = data;
+
+	print_pa_report_info(le16_to_cpu(evt->handle), evt->tx_power,
+						evt->rssi, evt->cte_type);
+	print_field("Periodic event counter: %u (0x%4.4x)",
+					le16_to_cpu(evt->event_counter),
+					le16_to_cpu(evt->event_counter));
+	if (evt->subevent == 0xff)
+		print_field("Subevent: No subevents (0xff)");
+	else
+		print_field("Subevent: %u (0x%2.2x)", evt->subevent,
+							evt->subevent);
+	print_pa_report_data(evt->data_status, evt->data_len, evt->data,
+					size - sizeof(*evt), true);
 }
 
 static void le_pa_sync_lost_evt(struct timeval *tv, uint16_t index,
@@ -14331,6 +14393,113 @@ static void le_past_received_evt(struct timeval *tv, uint16_t index,
 	print_field("Advertiser clock accuracy: 0x%2.2x", evt->clock_accuracy);
 }
 
+static void le_pa_subevent_data_request_evt(struct timeval *tv,
+				uint16_t index, const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_pa_subevent_data_request *evt = data;
+
+	print_field("Handle: 0x%2.2x", evt->handle);
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
+		return;
+
+	print_field("Handle: 0x%2.2x", evt->handle);
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
+			break;
+
+		print_field("Entry %u", i);
+		print_pa_tx_power("  ", rsp->tx_power);
+		print_pa_rssi("  ", rsp->rssi);
+
+		print_field("  CTE Type: %s (0x%2.2x)",
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
+			break;
+
+		print_eir("  Data", rsp->data, rsp->data_len, true);
+	}
+
+	/* Fewer responses than announced, or octets after the last one */
+	if (i < evt->num_responses || iov.iov_len) {
+		print_text(COLOR_ERROR, "  invalid packet size");
+		if (iov.iov_len)
+			print_hex_field("  Data", iov.iov_base, iov.iov_len);
+	}
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
@@ -15485,6 +15654,30 @@ static const struct subevent_data le_meta_event_table[] = {
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

