Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769739;
	b=fKyrRN3FAVurYptRR6/Kh3Uv6BrUQSVbkuJ1J/yWRMWo0nrrA5SX9EvW8HRbvvp6xm6f
	 A5zHRdjAJp2FTjobLK10ZAXh1+8xaJRPnGl97dWn/ea+LKrwCRZoahEseHQ2lJ4BUt4rX
	 uFIwWu7bFpbBskAHVyJ9++xQb0AUJt/cf2pUE+W02Ngzza0p0SCSJXTTEJ1HuIEkEviD2
	 l6L1a68Yw0w5Ay8CUfynTj5jfZU3gWmAyrlo/WpW1cle8qS8D560u2LbenpPY0SdpvfnW
	 bu/oPbTAl1/Z6ykfB/x1h2McimgMDuv95orY692BDGRIHsaHVXatnv63ppg5iewunWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kubRkhm0m/C509e3jFutg79S8V4q3DZ3veA8BC3VikM=;
	b=SE3kg5hx1wTWJ14jeurdGhml9odzV8BARI9cRIDWofs4OdWt9JTcYm47SgymOxUDhF1o
	 U5uY/Q5VaejIG5vzbmJDdryV7u/ecs5HvmOuX4VhuJhyAUDy8cynJa4fYgFfnSrW3zUFw
	 hLHBE5cNc01TjVpQoXXMJpYZlst6kYi6LqVPb+WxRsWhB0M0iuY9qQzQLtNr3OhBJ9YhQ
	 9DfdSxPZi3k9N+LKap+AiKFD4yGmh+RlZp7eFVd8QJagXyBLB2DQmXHE+b1cDkcif5Mz2
	 xIB1rOcIOFkGOso8f8XNmmWWVOmeh1VYAvMZieBa/XjmtykhENgmLEFAZVDg0x/qK/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QyAmssu7;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C869606A32D
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C869606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QyAmssu7
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso17903855e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769738; x=1796374538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kubRkhm0m/C509e3jFutg79S8V4q3DZ3veA8BC3VikM=;
        b=QyAmssu7COw4YEcRQfuxeBHc6EU4cdIYQhCNqosphOFYb9Ogpe8g70r9Zaq0OFXzRs
         EBu/MIzRhcIaLOG+tXN3RG7ipEWIlYW64F2ocn+GuhwMmotwJMn4sHUXuSc0QAjezfzG
         67WKZ4UsXONFBA/rZLVwcrJ9DzK414zKXqLgc64uCK+4CA7ToLRvZ/3W5fiOuuKcDeru
         D7VwnZfa3c7SnGLPmiwQekYOMxhdIO6vAMSWwpgED5JnQhctMGW/oHWByVhaM0Vs22CP
         SHaRZcdNpGJEmjjAjseLA3w+P/0nh8gtMYdf2xlijIO9BjWUAuC4MEDt5BRU3kGDaJDC
         BUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769738; x=1796374538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kubRkhm0m/C509e3jFutg79S8V4q3DZ3veA8BC3VikM=;
        b=o6FRKK6n4UURLO/1qaRFDUlT+ob8jfhWbl0uxu80/PS4NlAm43OyBC3t0LAvygWTAd
         n6Uf2NnFGjialMMXEQFxT2UMfeqZLiE0VGbD/wIbkhXO47izc+Z87eF3iCgLuZQlFaC2
         qUa8M4o1g9AqHyTTnuxYeusPVF2F3fcSgzMVtzO6yw8KNTQImirc+B/y8tGUTxuG16Xd
         5gu+OE4Lx/0EU+dt6SMtp+f8vO5ApuIdK1CgatD1nzPePue65OSt2RJAK4G9ZEwIQiVS
         /Tf/4Hw6c0HA4CKd+ZVOcAlP/7L8knFxY/FWucVNzr3nVZNmwwQxIybyBlm+TSfcWlzg
         rBGA==
X-Gm-Message-State: APuU4Z+Dvr7wfPOvfbIY/GHTsZSnsdl22nHpXlwAyEmbK3u6XXjB+Krf
	di+VrQ02RytJprn9avW1hTn/MWsXnGvfeO8QgCWANytLDLtea5qlCyjEKG41iHXQ
X-Gm-Gg: AZFdTZdctRBpsAiU5PhcWVZcLA1J+dAtThlfYDMVPFll8hGFp4/B/wedwfWwW+RhyLG
	GxAsH3gbPHNMp6rJAbz5IjBTZB3QUz4Hb7M4w6N0dSSZjARgaq/PHFGnpUtp3ze0RcRLny8CaEv
	K81ZJkMKXMm5S8QqElUkgrX3BFht8wI2jp534UKqeP1DfUQpoElcINxjUwn1RYnt/mKUG+hYLTq
	AAgHaFl21vUIDwaNehtlxv8op11CzBnUdtel60fQg6TOAW+LZ2kDPKJJcsGTScSfzlJqErcGpC3
	7c0lfr/5SjwxzUr87bsNZIwL7r8o2JCLB2qzBU3W+SVchL/2kOa1/shOzqa9yIx7l2E9rCtHoFr
	3pYKVFg274bjYKT8zv/lGHXPekZkdEiBgIrRZndunExjQRgKS09yU3pJ0PEdqypBDRLRERaLg/7
	r6PDKLQSzTO8BLvEHf7zYRQ4dgRPydUIcHUjJLcWFltFTlSEY3Wd0YrQwrKXcCKDTbKxYd3YVZI
	+oKQz0PaD2jRNx3/pxf5nzNbkXqIpL2XVds3iA5RpcBv+jBrcEV5oxNwH2QA+A7yHCUQCcRdsBC
	OGqxrWan6cjmbguNV0DM36i4K+sljzAjiNzF
X-Received: by 2002:a05:600c:1088:b0:4a2:417:7db5 with SMTP id 5b1f17b1804b1-4bb887f43cdmr374046515e9.2.1795769737536;
        Fri, 27 Nov 2026 00:55:37 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm739587505e9.14.2026.11.27.00.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:55:37 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH BlueZ 2/9] lib/mgmt: Add periodic advertising and PAwR definitions
Date: Fri, 27 Nov 2026 09:55:18 +0100
Message-ID: <20261127085525.264299-3-rolandschober1968@gmail.com>
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

Add the MGMT commands and events for periodic advertising and Periodic
Advertising with Responses (PAwR):

 - Add Periodic Advertising Parameters (0x005d)
 - Add Periodic Advertising Data (0x005e)
 - Set Periodic Advertising Subevent Data (0x005f)
 - Periodic Advertising Subevent Data Request event (0x0035)
 - Periodic Advertising Response Report event (0x0036)

Assisted-by: Claude:claude-fable-5-2
---
 lib/bluetooth/mgmt.h | 74 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/lib/bluetooth/mgmt.h b/lib/bluetooth/mgmt.h
index af71be828..450d20afb 100644
--- a/lib/bluetooth/mgmt.h
+++ b/lib/bluetooth/mgmt.h
@@ -838,6 +838,49 @@ struct mgmt_cp_load_conn_subrate {
 	struct mgmt_conn_subrate params[];
 } __packed;
 
+#define MGMT_OP_ADD_PERIODIC_ADV_PARAMS	0x005D
+struct mgmt_cp_add_periodic_adv_params {
+	uint8_t  instance;
+	uint16_t min_interval;
+	uint16_t max_interval;
+	uint8_t  num_subevents;
+	uint8_t  subevent_interval;
+	uint8_t  response_slot_delay;
+	uint8_t  response_slot_spacing;
+	uint8_t  num_response_slots;
+} __packed;
+struct mgmt_rp_add_periodic_adv_params {
+	uint8_t  instance;
+} __packed;
+
+#define MGMT_OP_ADD_PERIODIC_ADV_DATA	0x005E
+struct mgmt_cp_add_periodic_adv_data {
+	uint8_t  instance;
+	uint8_t  data_len;
+	uint8_t  data[];
+} __packed;
+struct mgmt_rp_add_periodic_adv_data {
+	uint8_t  instance;
+} __packed;
+
+struct mgmt_pa_subevent_data {
+	uint8_t  subevent;
+	uint8_t  response_slot_start;
+	uint8_t  response_slot_count;
+	uint8_t  data_len;
+	uint8_t  data[];
+} __packed;
+
+#define MGMT_OP_SET_PA_SUBEVENT_DATA	0x005F
+struct mgmt_cp_set_pa_subevent_data {
+	uint8_t  instance;
+	uint8_t  num_subevents;
+	uint8_t  subevents[];
+} __packed;
+struct mgmt_rp_set_pa_subevent_data {
+	uint8_t  instance;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -1156,6 +1199,32 @@ struct mgmt_ev_security_level_changed {
 	uint8_t	tlv_data[];
 } __packed;
 
+#define MGMT_EV_PA_SUBEVENT_DATA_REQUEST	0x0035
+struct mgmt_ev_pa_subevent_data_request {
+	uint8_t  instance;
+	uint8_t  subevent_start;
+	uint8_t  subevent_data_count;
+} __packed;
+
+struct mgmt_pa_response {
+	int8_t   tx_power;
+	int8_t   rssi;
+	uint8_t  cte_type;
+	uint8_t  response_slot;
+	uint8_t  data_status;
+	uint8_t  data_len;
+	uint8_t  data[];
+} __packed;
+
+#define MGMT_EV_PA_RESPONSE_REPORT		0x0036
+struct mgmt_ev_pa_response_report {
+	uint8_t  instance;
+	uint8_t  subevent;
+	uint8_t  tx_status;
+	uint8_t  num_responses;
+	uint8_t  responses[];
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1250,6 +1319,9 @@ static const char *mgmt_op[] = {
 	"Mesh Send Cancel",
 	"HCI Cmd Sync",
 	"Load Connection Subrate",
+	"Add Periodic Advertising Parameters",
+	"Add Periodic Advertising Data",
+	"Set Periodic Advertising Subevent Data",
 };
 
 static const char *mgmt_ev[] = {
@@ -1306,6 +1378,8 @@ static const char *mgmt_ev[] = {
 	"Mesh Packet Complete",
 	"Connection Subrate",
 	"Security Level Changed",
+	"Periodic Advertising Subevent Data Request",
+	"Periodic Advertising Response Report",
 };
 
 static const char *mgmt_status[] = {
-- 
2.47.3

