Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769740;
	b=3uzE1bM4xwRKdvzVOImVcRgKhkpBe6FnYxA0HL7wNh80c5ZPt6EOlP2ZL1tNw1tfruiH
	 MI8ts2tbbzUXyGl/sUS3ZW/N2/R5bEYHt3RX5CTWPHeORMZ4hn2LmPns2kPPXTXOw7U2+
	 q6zjJ1h5C8+uoni7rSh3nFc5ahmefvYbI6VhBwk7E/Qe99+bejy9Xp0LGnwTbSOYXlMgt
	 6TX6j6fyz3xcbphlsFjxdcMHXiCEg9Sgezwk+8lpyPaPSpVmmNe/MTPZtfo1OHeqwGD/t
	 CrXFuReWghhGf3WTv9iwGPIXGUUtk15VTX4zeI6pnIHvxGWbdkMT3GoChnNevknxL/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2qWb9dMqXIQ3pPtaIuImVFX0gUrWC9x9aabsHQmedns=;
	b=iHr1RVcVcCACIwqD8GNA2mravIpORP9Xr3pN+r77BCF4OBfsorUtvNbYcO5BuZ1vKsAi
	 1vhbZm0AK2iIxQh4KvUnVACLikkBHKaDwsCgMqJEiiRobGQZhF9Y9iZjgVQNvPzP4eAid
	 iXZAA1qOgrfHmAYIwSQrprurAPPq4AQfcKIqBh8aUDLObdqrbotXAd6PGVMw6BtSZ3ieS
	 Bmly1B8+pMJ6CR+WuG4W/LXdSbjOHkGi4DjZu/wKUuj/6MAiz2Ps9L0Ryip1kHfZkquDu
	 bJjyg4D952jkMkc9i1E6j1gKNL/IclaEqAiKKlYkIeOPKDiHanWo0XKfsHMH/aqIErw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dt4CUDXu;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DF4606A32F
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98DF4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dt4CUDXu
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bbb0db845aso563615e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769738; x=1796374538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2qWb9dMqXIQ3pPtaIuImVFX0gUrWC9x9aabsHQmedns=;
        b=Dt4CUDXuaMgudQAF/bqtEpqBQowHavaVA2Hf8k89wg+vXB+Z5Xes0AoD7a0yMOGxKt
         YrMznycjNG0b8MDjp5agBYfA56fPQQceRlqFZJcg0B85dxn1GTBZWz826Pq+hQHOtRKH
         MPJ3cmnWdwJFFVfvTz5+mo1wPm/SaUfuEYNAyg1DGzOGxL1VYK6R6ZnUqJiPjTvW+HUD
         jssu4aLmdxRWAJz5cUqECop379IEXvFludOHr5wFft9+Tp+0XqbXLMdGRxhzjuLvkH5R
         JBUQ4BkCOxwMYvokOtLz/1AyMDdk1I0uSb7KbwcSWhioCj2uOFCJSM4qmI6x0zVTtFzc
         MpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769738; x=1796374538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2qWb9dMqXIQ3pPtaIuImVFX0gUrWC9x9aabsHQmedns=;
        b=OECiC9dAL/EW10JUFRhaJknAyPTN+Yi2WEXiwClC+5i5dD+Vm+pQc0tX4GE+vIBEho
         a3qyvbOFRQm8EqYMWOMcIN71UljZiMwwy5+720fvJMGC1Ld4wE2t9veRcjm0saal43Oq
         gVXccNa1WEHVxHsftiO/dmwTg3XYKlkZmLEeXIEAjKcW21Mlspeum4XPo5G3lx6aQXvI
         7kQEfDvMKWG9meWHVwNHCwQcPRn6JAN7YUichGMnTpRR4C1Xgz14Z9zauU8AVC5xpBOA
         2qOfTkovGC1yv3boWbBavbo2PYxM8PBCfGom85l7kULLO/gLGBkQQco6F6hfJI3gzPkX
         jCFA==
X-Gm-Message-State: APuU4Z85o5IK2lg8nJRfNOauuFeCo86sAdSrIcYlZAAj8+4yiJMybJmd
	fRAReWzNTgMCu7xewUgavuJ4ew20DGEQtA/RAMMWvhZMBo0bhB7NU90Zm8vrhFH3
X-Gm-Gg: AZFdTZeIh9qxF0oE8SKmcBxP2Bx6EnllFRr7gDo42FNikBUApuWUcVxdP+j+UeKqfwA
	mfsAKXjyf6nwSAZ6HuA1a+I6nCjpvxkpuipmhFhPJsP107eccnL5hboaiiS68w5H0rfdx9wVmrC
	YFovHBNACZ6XJx7X9BbS3tFXMHWhDiFWrUR8OHRBC8yBt4AsZZIpbeYvJfeycAlCACK4FhBRUP0
	Ur7OT60SU347oMJ+hzEW5mNtTZZyuH2jB2ABcu+vrd4352uEwiT6/HducAMVqHuDa1OSYZz/ta/
	f4b/1vgD24AoslT3KDTKlJwknBEjYgvEdVc/zawx6Q8l/sOQfzBlvmr4ylY/Te5OW/NBxxoGhG0
	F1ztU7UUf8AI3jE6+N7KhYXpqxOJw6eBmDBwUyeGFhEKqj4pcYKfEYyK1ho4JDUobUrJ5QLnZAs
	Maxpr5zo6imBBztgXKhNyou+vZr80LSB0Nktj646SPN6YlRpW+t47Xvka8oCsgrznucrv73fBlE
	f1Wmv9WBJ0uy4Emm2uuXXpt0JaM50aRUOTxBRTXmn+CuHR/CMhYAtB+l+L11C7TcDIbCd83Yh5u
	iGpJoWYEveTzJSEt2pMrcv3k3YF4vEfEZpY=
X-Received: by 2002:a05:600c:1113:b0:4bb:a9f6:8bbe with SMTP id 5b1f17b1804b1-4bba9f68bc2mr78838215e9.0.1795769738000;
        Fri, 27 Nov 2026 00:55:38 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm739587505e9.14.2026.11.27.00.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:55:37 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH BlueZ 3/9] monitor: Decode periodic advertising and PAwR MGMT commands and events
Date: Fri, 27 Nov 2026 09:55:19 +0100
Message-ID: <20261127085525.264299-4-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127085525.264299-1-rolandschober1968@gmail.com>
References: <20261127085525.264299-1-rolandschober1968@gmail.com>
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

Decode Add Periodic Advertising Parameters, Add Periodic Advertising
Data, Set Periodic Advertising Subevent Data and the events Periodic
Advertising Subevent Data Request and Periodic Advertising Response
Report:

@ MGMT Command: Add Periodic... (0x005d) plen 10  {0x0001} [hci0] 2.520884
        Instance: 1
        Min interval: 318.75 msec (0x00ff)
        Max interval: 318.75 msec (0x00ff)
        Num subevents: 5
        Subevent interval: 60.00 msec (0x30)
        Response slot delay: 10.00 msec (0x08)
        Response slot spacing: 10.000 msec (0x50)
        Num response slots: 5
@ MGMT Command: Add Periodic A.. (0x005e) plen 8  {0x0001} [hci0] 2.811226
        Instance: 1
        Data length: 6
@ MGMT Event: Periodic Adverti.. (0x0035) plen 3  {0x0002} [hci0] 2.764373
        Instance: 1
        Subevent start: 1 (0x01)
        Subevent data count: 3 (0x03)
@ MGMT Event: Periodic Advert.. (0x0036) plen 16  {0x0002} [hci0] 4.669477
        Instance: 1
        Subevent: 0 (0x00)
        TX status: Subevent was transmitted (0x00)
        Num responses: 1
        Entry 0
          TX power: not available (0x7f)
          RSSI: -59 dBm (0xc5)
          CTE type: 0xff
          Response slot: 0 (0x00)
          Data status: Complete (0x00)
          Data length: 6

Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 204 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index eddf8706a..1ecbe8050 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -18436,6 +18436,99 @@ static void mgmt_hci_cmd_sync_rsp(const void *data, uint16_t size)
 	print_hex_field("Response", data, size);
 }
 
+static void mgmt_add_periodic_adv_params_cmd(const void *data, uint16_t size)
+{
+	const struct mgmt_cp_add_periodic_adv_params *cp = data;
+	uint16_t min_interval = le16_to_cpu(cp->min_interval);
+	uint16_t max_interval = le16_to_cpu(cp->max_interval);
+
+	print_field("Instance: %u", cp->instance);
+	print_field("Min interval: %.2f msec (0x%4.4x)", min_interval * 1.25,
+								min_interval);
+	print_field("Max interval: %.2f msec (0x%4.4x)", max_interval * 1.25,
+								max_interval);
+	print_field("Num subevents: %u", cp->num_subevents);
+	print_field("Subevent interval: %.2f msec (0x%2.2x)",
+			cp->subevent_interval * 1.25, cp->subevent_interval);
+	print_field("Response slot delay: %.2f msec (0x%2.2x)",
+			cp->response_slot_delay * 1.25,
+			cp->response_slot_delay);
+	print_field("Response slot spacing: %.3f msec (0x%2.2x)",
+			cp->response_slot_spacing * 0.125,
+			cp->response_slot_spacing);
+	print_field("Num response slots: %u", cp->num_response_slots);
+}
+
+static void mgmt_instance_rsp(const void *data, uint16_t size)
+{
+	uint8_t instance = get_u8(data);
+
+	print_field("Instance: %u", instance);
+}
+
+static void mgmt_add_periodic_adv_data_cmd(const void *data, uint16_t size)
+{
+	struct iovec iov = { .iov_base = (void *) data, .iov_len = size };
+	const struct mgmt_cp_add_periodic_adv_data *cp;
+
+	cp = util_iov_pull_mem(&iov, sizeof(*cp));
+	if (!cp)
+		return;
+
+	print_field("Instance: %u", cp->instance);
+	print_field("Data length: %u", cp->data_len);
+
+	if (iov.iov_len != cp->data_len) {
+		print_text(COLOR_ERROR, "  invalid packet size");
+		print_hex_field("  Data", iov.iov_base, iov.iov_len);
+		return;
+	}
+
+	print_eir("Data", cp->data, cp->data_len, true);
+}
+
+static void mgmt_set_pa_subevent_data_cmd(const void *data, uint16_t size)
+{
+	struct iovec iov = { .iov_base = (void *) data, .iov_len = size };
+	const struct mgmt_cp_set_pa_subevent_data *cp;
+	const struct mgmt_pa_subevent_data *se;
+	uint8_t i;
+
+	cp = util_iov_pull_mem(&iov, sizeof(*cp));
+	if (!cp)
+		return;
+
+	print_field("Instance: %u", cp->instance);
+	print_field("Num subevents: %u", cp->num_subevents);
+
+	for (i = 0; i < cp->num_subevents; i++) {
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
+	if (i < cp->num_subevents || iov.iov_len) {
+		print_text(COLOR_ERROR, "  invalid packet size");
+		if (iov.iov_len)
+			print_hex_field("  Data", iov.iov_base, iov.iov_len);
+	}
+}
+
 struct mgmt_data {
 	uint16_t opcode;
 	const char *str;
@@ -18719,6 +18812,15 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x005C, "Load Connection Subrate",
 				mgmt_load_conn_subrate_cmd, 2, false,
 				mgmt_null_rsp, 0, true },
+	{ 0x005D, "Add Periodic Advertising Parameters",
+				mgmt_add_periodic_adv_params_cmd, 10, true,
+				mgmt_instance_rsp, 1, true },
+	{ 0x005E, "Add Periodic Advertising Data",
+				mgmt_add_periodic_adv_data_cmd, 2, false,
+				mgmt_instance_rsp, 1, true },
+	{ 0x005F, "Set Periodic Advertising Subevent Data",
+				mgmt_set_pa_subevent_data_cmd, 2, false,
+				mgmt_instance_rsp, 1, true },
 	{ }
 };
 
@@ -19383,6 +19485,104 @@ static void mgmt_security_level_changed_evt(const void *data, uint16_t size)
 	mgmt_tlv_list_free(tlv_list);
 }
 
+static void mgmt_pa_subevent_data_request_evt(const void *data,
+							uint16_t size)
+{
+	const struct mgmt_ev_pa_subevent_data_request *ev = data;
+
+	print_field("Instance: %u", ev->instance);
+	print_field("Subevent start: %u (0x%2.2x)", ev->subevent_start,
+							ev->subevent_start);
+	print_field("Subevent data count: %u (0x%2.2x)",
+			ev->subevent_data_count, ev->subevent_data_count);
+}
+
+static void mgmt_pa_response_report_evt(const void *data, uint16_t size)
+{
+	struct iovec iov = { .iov_base = (void *) data, .iov_len = size };
+	const struct mgmt_ev_pa_response_report *ev;
+	const struct mgmt_pa_response *rsp;
+	const char *str;
+	uint8_t i;
+
+	ev = util_iov_pull_mem(&iov, sizeof(*ev));
+	if (!ev)
+		return;
+
+	print_field("Instance: %u", ev->instance);
+	print_field("Subevent: %u (0x%2.2x)", ev->subevent, ev->subevent);
+
+	switch (ev->tx_status) {
+	case 0x00:
+		str = "Subevent was transmitted";
+		break;
+	case 0x01:
+		str = "Subevent was not transmitted";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("TX status: %s (0x%2.2x)", str, ev->tx_status);
+	print_field("Num responses: %u", ev->num_responses);
+
+	for (i = 0; i < ev->num_responses; i++) {
+		rsp = util_iov_pull_mem(&iov, sizeof(*rsp));
+		if (!rsp)
+			break;
+
+		print_field("Entry %u", i);
+
+		if (rsp->tx_power == 0x7f)
+			print_field("  TX power: not available (0x7f)");
+		else
+			print_field("  TX power: %d dBm (0x%2.2x)",
+					rsp->tx_power, (uint8_t) rsp->tx_power);
+
+		if (rsp->rssi == 0x7f)
+			print_field("  RSSI: not available (0x7f)");
+		else
+			print_field("  RSSI: %d dBm (0x%2.2x)", rsp->rssi,
+							(uint8_t) rsp->rssi);
+
+		print_field("  CTE type: 0x%2.2x", rsp->cte_type);
+		print_field("  Response slot: %u (0x%2.2x)",
+				rsp->response_slot, rsp->response_slot);
+
+		switch (rsp->data_status) {
+		case 0x00:
+			str = "Complete";
+			break;
+		case 0x01:
+			str = "Incomplete, more data to come";
+			break;
+		case 0xff:
+			str = "Failed to receive the response";
+			break;
+		default:
+			str = "Reserved";
+			break;
+		}
+
+		print_field("  Data status: %s (0x%2.2x)", str,
+							rsp->data_status);
+		print_field("  Data length: %u", rsp->data_len);
+
+		if (!util_iov_pull(&iov, rsp->data_len))
+			break;
+
+		print_eir("  Data", rsp->data, rsp->data_len, true);
+	}
+
+	/* Fewer responses than announced, or octets after the last one */
+	if (i < ev->num_responses || iov.iov_len) {
+		print_text(COLOR_ERROR, "  invalid packet size");
+		if (iov.iov_len)
+			print_hex_field("  Data", iov.iov_base, iov.iov_len);
+	}
+}
+
 static const struct mgmt_data mgmt_event_table[] = {
 	{ 0x0001, "Command Complete",
 			mgmt_command_complete_evt, 3, false },
@@ -19484,6 +19684,10 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_conn_subrate_evt, 18, true },
 	{ 0x0034, "Security Level Changed",
 			mgmt_security_level_changed_evt, 8, false },
+	{ 0x0035, "Periodic Advertising Subevent Data Request",
+			mgmt_pa_subevent_data_request_evt, 3, true },
+	{ 0x0036, "Periodic Advertising Response Report",
+			mgmt_pa_response_report_evt, 4, false },
 	{ }
 };
 
-- 
2.47.3

