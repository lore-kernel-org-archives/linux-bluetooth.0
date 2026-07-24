Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FB8456DF7
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920369; cv=none; b=az80n/+Smz6W72tCMd1/dQZhex+Ei0S9rkLcg1eEVJo+sm3YDwI7oBR/fL7G5u8Di4+tounbSNDU0pxjCcc31Rfze8JvgAiRPx+6i9I2d4fg/pVz7e5wZCmtqkJlCTtkxGurNpGpgkuQIkQ6eTm9EI506KE5/LedNIALiKFyQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920369; c=relaxed/simple;
	bh=L1icu5nIuGPMJkQS4/D56S605CWjO1xLOWQRRIGuM7U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPVJsqmD2pyD5zrl4+YOGCVrUe7mW5DlT6JF0a5z0Vqu+GTjFUFtf9aAn136dobgr4/z+3Ff6EEXb9dcEBZ28NFsOGymKojrgcpKca61mziJqCx9glyy5eSj5dzZLoN78vhp/bQfz7Jhx60wHtC44vwPoDL0VJhiXP5r3g27ugI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1dlnVbS; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1dlnVbS"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bfaf91daa2so225277e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920366; x=1785525166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8vTpEYMpCS8ekGY1AKDtSdw/dps8Bf7+8gUf3vjREXQ=;
        b=G1dlnVbSVNLRpgOaOvAi8m23yTV4PuNIQYglI/S7eJd7kilinq4ut07o1yzCmgw3TG
         28iNhl8XadbdqsjJXBklQCda7gquzKn5cVQHOWDOraIlbpr5yVx4leUjEH+9q5wunPY1
         mvtN4DnhUAEtsbCiyiVuFpA7o1mmAKcU/2eAXr1pOS0UIf1T3j41XSZi0qhehXRBTgPd
         9yxTe5sU0LKDhYqDs3/quY3e0J2QMw5PXEakfMmYm5dnPn1Zaut9bg7It8Osnyn2T1Z/
         BHjjBh2hkbxHUlT73pD1LptMmG18YId9s8Xhb7pepI2Fm+uiegLJTM3yWsoyz2K85jmp
         MTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920366; x=1785525166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8vTpEYMpCS8ekGY1AKDtSdw/dps8Bf7+8gUf3vjREXQ=;
        b=gDF4dL3JBw/EscdNV7B4hrnllK1xUMtSkNFZM/ImGaKGP+8EfXmitivKijWlFE/C0r
         bHw1XZ1Re1K9mbz9QRrKcMb6rSZXdzpIlbwvPYkANBG8mUfcDa3chmQO/E90k+R9FvqN
         k+3isFSLyA7jjLO0vPa8d3OuBr5wVCH/2cFhAl/2WfvgmEwzG+0SZmix1aL2OwEC8+h0
         nE7A26zCCREyhkseKDoQ6amyXG39DHd5ttBvpyKFB36Q2AndplqtV0Kv9krPHYqK42cO
         jM2I5lJBQcANOF5T7Jkyuak2sfp2d9MR7PjPm/pzXuIzSKmi+uQZg8/4C5KU5YIsDxX9
         DsBw==
X-Gm-Message-State: AOJu0YwZbtDCIw3FYdaczoZCDOtNfVEgN2JYNBS+DhdligCteZcqMq6z
	piRRerdAAuMZlYyrxVcKzCV5Jz0Sx+xOHUO6sF75MIOz/Hi4aDTYJ3g+M2iEvvUy
X-Gm-Gg: AR+sD13m9O7yYIlI92p2Gdm3HmhOJeeAJix56OHnw7jWRSRb/L8BmRcKY0fOgS7tejE
	/FsZ8AjX5gmaMfMfK0MtexyCbTDxjlZoorYuTGn9DMB3F/6XbMhqB/Vu06Qpww1quzGW72XEE8P
	bQa3KWIQd8cLRPhyvS0x8vjFHJ2OSLglbokchB5Grq6kUpEIcXtRTNt3HMFCTTfhVw0sD4iGDbk
	BiWsyAft9r1NlmlimPom3RAd/7wuGWKzUkWHopFTgqSZzPaXEF+ziU8Hy1SOU1Xgg+HnLTWyqOk
	H5fXMg8HoaVBpttFFTtc3KmMQ0d4hIAP+hCgCclwNhwpZKo5E5UY+eeULYLJZf3NAmFS64Bswep
	CAkeKD7HqGVKUc+a0oew1IGQSWaeJ627TQBHQWLWbWo0GPzZ6uOm6IQbMzcApPyWfoduhaCo742
	Ddeb1HWA/+HzAmoocy1EZZllYK1qZLCHAW19jQHVtXPvq3BPM38IyYoIXyz5CwxkXJSyorTAt0
X-Received: by 2002:a05:6102:5811:b0:720:7e04:b306 with SMTP id ada2fe7eead31-74d5dcbad78mr4569603137.5.1784920365528;
        Fri, 24 Jul 2026 12:12:45 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c8b921sm488554241.4.2026.07.24.12.12.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:12:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 10/12] l2cap-tester: Add SCI mode tests for LE client connections
Date: Fri, 24 Jul 2026 15:12:23 -0400
Message-ID: <20260724191225.1815634-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724191225.1815634-1-luiz.dentz@gmail.com>
References: <20260724191225.1815634-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add L2CAP LE client connection tests that load Connection Subrate
parameters (via MGMT_OP_LOAD_CONN_SUBRATE) before establishing the
connection, using the HOGP v1.2 recommended values for each of the
four HID SCI modes:

 - Fast: interval 1.25-5 ms, latency 0, subrate 1-4, cont_num 3
 - Default: interval 7.5-15 ms, latency 0, subrate 1-4, cont_num 0
 - Low Power: interval 7.5-15 ms, latency 100, subrate 1-4, cont_num 0
 - Full Range: interval 1.25-15 ms, latency 0, subrate 1-4, cont_num 1

Add the test_l2cap_le_62 macro (HCIEMU_TYPE_BREDRLE62) since SCI
requires a 6.2 controller. The subrate parameters are loaded with
the client's runtime bdaddr during setup_powered_client before the
outgoing LE connection is initiated.
---
 tools/l2cap-tester.c | 130 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 2771aee65814..88bfd71bf580 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -54,6 +54,16 @@ struct test_data {
 	struct tx_tstamp_data tx_ts;
 };
 
+struct l2cap_conn_subrate {
+	uint16_t min_interval;
+	uint16_t max_interval;
+	uint16_t subrate_min;
+	uint16_t subrate_max;
+	uint16_t max_latency;
+	uint16_t cont_num;
+	uint16_t supv_timeout;
+};
+
 struct l2cap_data {
 	uint16_t client_psm;
 	uint16_t server_psm;
@@ -112,6 +122,11 @@ struct l2cap_data {
 
 	/* Set PHY */
 	uint32_t phy;
+
+	/* Connection Subrate parameters to load before connecting.
+	 * The address is filled in with the client bdaddr at runtime.
+	 */
+	const struct l2cap_conn_subrate *conn_subrate;
 };
 
 static void print_debug(const char *str, void *user_data)
@@ -298,6 +313,9 @@ static void test_data_free(void *test_data)
 #define test_l2cap_le_52(name, data, setup, func) \
 	test_l2cap(name, HCIEMU_TYPE_BREDRLE52, data, setup, func)
 
+#define test_l2cap_le_62(name, data, setup, func) \
+	test_l2cap(name, HCIEMU_TYPE_BREDRLE62, data, setup, func)
+
 static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 }; /* "0000" */
 
 static const struct l2cap_data client_connect_success_test = {
@@ -654,6 +672,74 @@ static const struct l2cap_data le_client_connect_success_test_1 = {
 	.server_psm = 0x0080,
 };
 
+/* HIDS 1.2 recommended SCI parameters (see HOGP v1.2 spec).
+ * Connection intervals are in units of 0.125 ms, supervision timeout in
+ * units of 10 ms.
+ */
+static const struct l2cap_conn_subrate conn_subrate_hids_fast = {
+	.min_interval = 0x000a,		/* 1.25 ms */
+	.max_interval = 0x0028,		/* 5 ms */
+	.subrate_min = 0x0001,
+	.subrate_max = 0x0004,
+	.max_latency = 0x0000,
+	.cont_num = 0x0003,
+	.supv_timeout = 0x0004,		/* 40 ms */
+};
+
+static const struct l2cap_conn_subrate conn_subrate_hids_default = {
+	.min_interval = 0x003c,		/* 7.5 ms */
+	.max_interval = 0x0078,		/* 15 ms */
+	.subrate_min = 0x0001,
+	.subrate_max = 0x0004,
+	.max_latency = 0x0000,
+	.cont_num = 0x0000,
+	.supv_timeout = 0x000c,		/* 120 ms */
+};
+
+static const struct l2cap_conn_subrate conn_subrate_hids_low_power = {
+	.min_interval = 0x003c,		/* 7.5 ms */
+	.max_interval = 0x0078,		/* 15 ms */
+	.subrate_min = 0x0001,
+	.subrate_max = 0x0004,
+	.max_latency = 0x0064,		/* 100 */
+	.cont_num = 0x0000,
+	.supv_timeout = 0x04bc,		/* 12120 ms */
+};
+
+static const struct l2cap_conn_subrate conn_subrate_hids_full_range = {
+	.min_interval = 0x000a,		/* 1.25 ms */
+	.max_interval = 0x0078,		/* 15 ms */
+	.subrate_min = 0x0001,
+	.subrate_max = 0x0004,
+	.max_latency = 0x0000,
+	.cont_num = 0x0001,
+	.supv_timeout = 0x000c,		/* 120 ms */
+};
+
+static const struct l2cap_data le_client_connect_subrate_fast_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.conn_subrate = &conn_subrate_hids_fast,
+};
+
+static const struct l2cap_data le_client_connect_subrate_default_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.conn_subrate = &conn_subrate_hids_default,
+};
+
+static const struct l2cap_data le_client_connect_subrate_low_power_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.conn_subrate = &conn_subrate_hids_low_power,
+};
+
+static const struct l2cap_data le_client_connect_subrate_full_range_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.conn_subrate = &conn_subrate_hids_full_range,
+};
+
 static const struct l2cap_data le_client_connect_close_test_1 = {
 	.client_psm = 0x0080,
 };
@@ -1512,6 +1598,37 @@ static void setup_powered_client(const void *test_data)
 		mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
 
+	if (test && test->conn_subrate) {
+		const struct l2cap_conn_subrate *cs = test->conn_subrate;
+		const uint8_t *client_bdaddr;
+		struct {
+			struct mgmt_cp_load_conn_subrate cp;
+			struct mgmt_conn_subrate param;
+		} __attribute__((packed)) load;
+
+		client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
+		if (!client_bdaddr) {
+			tester_setup_failed();
+			return;
+		}
+
+		memset(&load, 0, sizeof(load));
+		load.cp.param_count = cpu_to_le16(1);
+		memcpy(&load.param.addr.bdaddr, client_bdaddr, 6);
+		load.param.addr.type = BDADDR_LE_PUBLIC;
+		load.param.min_interval = cpu_to_le16(cs->min_interval);
+		load.param.max_interval = cpu_to_le16(cs->max_interval);
+		load.param.subrate_min = cpu_to_le16(cs->subrate_min);
+		load.param.subrate_max = cpu_to_le16(cs->subrate_max);
+		load.param.max_latency = cpu_to_le16(cs->max_latency);
+		load.param.cont_num = cpu_to_le16(cs->cont_num);
+		load.param.supv_timeout = cpu_to_le16(cs->supv_timeout);
+
+		mgmt_send(data->mgmt, MGMT_OP_LOAD_CONN_SUBRATE,
+				data->mgmt_index, sizeof(load), &load,
+				NULL, NULL, NULL);
+	}
+
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 			sizeof(param), param, setup_powered_client_callback,
 			NULL, NULL);
@@ -3118,6 +3235,19 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP LE Client - Success",
 				&le_client_connect_success_test_1,
 				setup_powered_client, test_connect);
+
+	test_l2cap_le_62("L2CAP LE Client - SCI Fast Mode",
+				&le_client_connect_subrate_fast_test,
+				setup_powered_client, test_connect);
+	test_l2cap_le_62("L2CAP LE Client - SCI Default Mode",
+				&le_client_connect_subrate_default_test,
+				setup_powered_client, test_connect);
+	test_l2cap_le_62("L2CAP LE Client - SCI Low Power Mode",
+				&le_client_connect_subrate_low_power_test,
+				setup_powered_client, test_connect);
+	test_l2cap_le_62("L2CAP LE Client - SCI Full Range Mode",
+				&le_client_connect_subrate_full_range_test,
+				setup_powered_client, test_connect);
 	test_l2cap_le("L2CAP LE Client - Close",
 				&le_client_connect_close_test_1,
 				setup_powered_client, test_connect_close);
-- 
2.54.0

