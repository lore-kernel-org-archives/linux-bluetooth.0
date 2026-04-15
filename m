Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FD82030A
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776238806; cv=none; b=W8kl7s2Ee7VEY4Up2ohbAWlm5yxGRJB48xOtq+4Go2119yqd9/pn0b73aTTZ+mEMXl/AxWdaxgVVMKqBsoJCZ9O33CHDNHu7Zu+z92dmdSIHOUXyb4bkMnByC6HyEA2VHuV4q2nbWt0jKI1tFEo1vAPtm3rDC307KjHDqK0rxfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776238806; c=relaxed/simple;
	bh=tPLw9qbzAemfUgqA4izHY6/BE7gyR5DLVQf7OdS244A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tylSqODcpCcYoQgRUhYeeHlPkGhzg/eidwjzMYrwwsQIJAP5wTIBjkJOeWjiCahqcB6dTR+x61oZiZewfreV5XQ2C9rEZCYkw8cVxRIrdTRUoETCr7TPQu8pnWnG45Or8YrAyOQehhorlemoJJ9+qTe/zO/B6xCwUIhn5WIkduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMMHK6nO; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMMHK6nO"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7d7dfe2d094so7077377a34.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776238804; x=1776843604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fZdqrI1Uj0KiuVPaiy/O4B7Ew0Gwh02eV0PF7Zf60tw=;
        b=SMMHK6nO/h7eRNcAYnUu7Ob/mCLEY6RwlTlG3HUau9StT0TSP3Aw/ejSRSenkX9CJT
         atDVoJPYHGQQalA32DyrDe0LwPdxTtdacSkJiOJamSK80SbsdK7GitWMcqv8aAEDSAFV
         9nRa96szpoWcu4NxJq4RA70t1zSe0AfKXdS39W9Ez8Zxhe+7EuM8HL7nhZVljf/srBTn
         io24W0NnMFx5UjAFSo+7GYoUXRVRiR8KF5ilq4lxYWpeu934kpV7YelBqa3weZdLzpRH
         JqtupVyWs/GmrhpUX6BJJahf9bBvU6baxTBUWHyNUW39fNeIM3KN/mmkAhUsepyKbouH
         eVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776238804; x=1776843604;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZdqrI1Uj0KiuVPaiy/O4B7Ew0Gwh02eV0PF7Zf60tw=;
        b=bVXzjMeccrWrsXY1+h1v/is9oHnHxeQbzIvaz402sn283FuyhWzalJ518V6XRs7AFs
         LyTrjQ/fi4jxo7r9QCZJLAsRkfF+Pwbjs2jVH6/Z7OtJk4d1rYN3poRgydXF+v95dczH
         cyjQqm7ghDDc7ZUeswMHNzJR3Y9BdS+9QJ3zpY0u5fXnabx1pla+OApxhjIV8DtJRC7q
         d8A4ySiAZrqOgFEkCqWX4POREaDCaErq8Kdnqill7DbCefPr2teO3NotVueC6M0oPkmM
         8sj/0LvLjAuc9/78ziBod8KMekcZndqzax9mtIeo/jNNgFyFTKtN7ri0ZjdVrVy3HbCt
         gB7w==
X-Gm-Message-State: AOJu0YwvNrH1v054BSN5aYZQmhoFEpZ/mTBEVsg6xtL5qsK8ra2KIfkH
	nE8IuMHkXxQElwkafgl8tnoUAz1fwg8vxVfk7+F6ko9cUJHX+RXnPI8RdQVIcD4W0+mpOzBLdfz
	08E8AmTBBoBBSOl1wmYh7aNy5oMYIN5bm7uNtgIlro9hWk187oMXkjBaAKUQ902UrYo/bqWVQdw
	M9Hc1bFdH1I74hV/QNi5HuJp92QRVsPx2sOphd0Sn4VJOM49bJMq2h1g==
X-Received: from oapn23.prod.google.com ([2002:a05:6870:2417:b0:417:2cf2:c606])
 (user=apusaka job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:8282:b0:7d7:419a:7ac8
 with SMTP id 46e09a7af769-7dc27ed0a35mr13437372a34.15.1776238803601; Wed, 15
 Apr 2026 00:40:03 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:36:45 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260415073940.739683-1-apusaka@google.com>
Subject: [PATCH BlueZ] monitor: Add decoding for Microsoft defined event
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Archie Pusaka <apusaka@chromium.org>

This adds decoders to MSFT LE monitor device event
---

 monitor/msft.c   | 78 +++++++++++++++++++++++++++++++++++++++++++++++-
 monitor/msft.h   |  1 +
 monitor/packet.c | 44 ++++++++++++++++++++++-----
 3 files changed, 115 insertions(+), 8 deletions(-)

diff --git a/monitor/msft.c b/monitor/msft.c
index 054f34006..d41f10d68 100644
--- a/monitor/msft.c
+++ b/monitor/msft.c
@@ -41,6 +41,8 @@
 
 #define COLOR_COMMAND		COLOR_BLUE
 #define COLOR_COMMAND_UNKNOWN	COLOR_WHITE_BG
+#define COLOR_EVENT		COLOR_MAGENTA
+#define COLOR_EVENT_UNKNOWN	COLOR_WHITE_BG
 
 static void null_cmd(const void *data, uint16_t size)
 {
@@ -299,10 +301,72 @@ const struct vendor_ocf *msft_vendor_ocf(void)
 	return &vendor_ocf_entry;
 }
 
+static void monitor_device_evt(const void *data, uint16_t size)
+{
+	const struct msft_evt_monitor_device *evt = data;
+	const char *str_state;
+
+	packet_print_addr(NULL, evt->addr, evt->addr_type);
+	print_field("Monitor handle: %u", evt->handle);
+
+	switch (evt->state) {
+	case 0x00:
+		str_state = "Stop monitoring";
+		break;
+	case 0x01:
+		str_state = "Start monitoring";
+		break;
+	default:
+		str_state = "Reserved";
+		break;
+	}
+
+	print_field("State: %s (0x%2.2x)", str_state, evt->state);
+}
+
+static const struct {
+	uint8_t code;
+	const char *str;
+	func_t evt_func;
+} evt_table[] = {
+	{ 0x01, "RSSI Event" },
+	{ 0x02, "LE Monitor Device Event", monitor_device_evt },
+	{ }
+};
+
 static void msft_evt(struct timeval *tv, uint16_t index,
 			const void *data, uint8_t size)
 {
-	packet_hexdump(data, size);
+	uint8_t code = get_u8(data);
+	const char *code_color, *code_str = NULL;
+	func_t code_func = NULL;
+	int i;
+
+	for (i = 0; evt_table[i].str; i++) {
+		if (evt_table[i].code == code) {
+			code_str = evt_table[i].str;
+			code_func = evt_table[i].evt_func;
+			break;
+		}
+	}
+
+	if (code_str) {
+		if (code_func)
+			code_color = COLOR_EVENT;
+		else
+			code_color = COLOR_EVENT_UNKNOWN;
+	} else {
+		code_color = COLOR_EVENT_UNKNOWN;
+		code_str = "Unknown";
+	}
+
+	print_indent(6, code_color, "", code_str, COLOR_OFF,
+						" (0x%2.2x)", code);
+
+	if (code_func)
+		code_func(data, size);
+	else
+		packet_hexdump(data + 1, size - 1);
 }
 
 static const struct vendor_evt vendor_evt_entry = {
@@ -313,3 +377,15 @@ const struct vendor_evt *msft_vendor_evt(void)
 {
 	return &vendor_evt_entry;
 }
+
+bool msft_event_code_valid(uint8_t code)
+{
+	int i;
+
+	for (i = 0; evt_table[i].str; i++) {
+		if (evt_table[i].code == code)
+			return true;
+	}
+
+	return false;
+}
diff --git a/monitor/msft.h b/monitor/msft.h
index e6e3019be..ff6c28011 100644
--- a/monitor/msft.h
+++ b/monitor/msft.h
@@ -187,3 +187,4 @@ struct vendor_evt;
 
 const struct vendor_ocf *msft_vendor_ocf(void);
 const struct vendor_evt *msft_vendor_evt(void);
+bool msft_event_code_valid(uint8_t code);
diff --git a/monitor/packet.c b/monitor/packet.c
index ff0b1cac2..02f69dfca 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -450,8 +450,10 @@ void packet_set_fallback_manufacturer(uint16_t manufacturer)
 
 void packet_set_msft_evt_prefix(const uint8_t *prefix, uint8_t len)
 {
-	if (index_current < MAX_INDEX && len < 8)
+	if (index_current < MAX_INDEX && len < 8) {
 		memcpy(index_list[index_current].msft_evt_prefix, prefix, len);
+		index_list[index_current].msft_evt_len = len;
+	}
 }
 
 static void cred_pid(struct ucred *cred, char *str, size_t len)
@@ -4359,7 +4361,8 @@ static int addr2str(const uint8_t *addr, char *str)
 			addr[5], addr[4], addr[3], addr[2], addr[1], addr[0]);
 }
 
-static int get_msft_opcode(uint16_t manufacturer) {
+static int get_msft_opcode(uint16_t manufacturer)
+{
 	switch (manufacturer) {
 	case COMPANY_ID_INTEL:
 		return 0xFC1E;
@@ -4374,7 +4377,23 @@ static int get_msft_opcode(uint16_t manufacturer) {
 	default:
 		return BT_HCI_CMD_NOP;
 	}
+}
+
+static bool msft_event_prefix_match(const void *data, int size)
+{
+	const void *prefix = index_list[index_current].msft_evt_prefix;
+	int prefix_len = index_list[index_current].msft_evt_len;
+
+	/*
+	 * MSFT event has one byte of event code following the MSFT prefix.
+	 * We need to check the event code is valid, as it's possible for
+	 * a vendor to use the same MSFT prefix but for other events.
+	 */
+	if (size >= prefix_len + 1 && !memcmp(prefix, data, prefix_len))
+		return msft_event_code_valid(
+				((const uint8_t *) data)[prefix_len]);
 
+	return false;
 }
 
 void packet_monitor(struct timeval *tv, struct ucred *cred,
@@ -10925,11 +10944,16 @@ static const struct vendor_ocf *current_vendor_ocf(uint16_t ocf)
 }
 
 static const struct vendor_evt *current_vendor_evt(const void *data,
-							int *consumed_size)
+					uint8_t size, int *consumed_size)
 {
 	uint16_t manufacturer;
 	uint8_t evt = *((const uint8_t *) data);
 
+	if (msft_event_prefix_match(data, size)) {
+		*consumed_size = index_list[index_current].msft_evt_len;
+		return msft_vendor_evt();
+	}
+
 	/* A regular vendor event consumes 1 byte. */
 	*consumed_size = 1;
 
@@ -10948,10 +10972,13 @@ static const struct vendor_evt *current_vendor_evt(const void *data,
 	return NULL;
 }
 
-static const char *current_vendor_evt_str(void)
+static const char *current_vendor_evt_str(const void *data, uint8_t size)
 {
 	uint16_t manufacturer;
 
+	if (msft_event_prefix_match(data, size))
+		return "Microsoft";
+
 	if (index_current < MAX_INDEX)
 		manufacturer = index_list[index_current].manufacturer;
 	else
@@ -13547,17 +13574,20 @@ static void vendor_evt(struct timeval *tv, uint16_t index,
 	struct subevent_data vendor_data;
 	char vendor_str[150];
 	int consumed_size;
-	const struct vendor_evt *vnd = current_vendor_evt(data, &consumed_size);
+	const struct vendor_evt *vnd = current_vendor_evt(data, size,
+								&consumed_size);
 
 	if (vnd) {
-		const char *str = current_vendor_evt_str();
+		const char *str = current_vendor_evt_str(data, size);
 
 		if (str) {
 			snprintf(vendor_str, sizeof(vendor_str),
 						"%s %s", str, vnd->str);
 			vendor_data.str = vendor_str;
-		} else
+		} else {
 			vendor_data.str = vnd->str;
+		}
+
 		vendor_data.subevent = vnd->evt;
 		vendor_data.func = vnd->evt_func;
 		vendor_data.size = vnd->evt_size;
-- 
2.54.0.rc0.605.g598a273b03-goog

