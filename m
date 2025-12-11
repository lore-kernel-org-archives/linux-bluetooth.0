Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F7931A051
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765485581; cv=none; b=Wv2fs+UdD/zTzR9vOwi1fqzBLSFQjesBKTerqfzYMPKajKSzbNtt+1POp7zYatnwjj+VLUODO2hHExhofc8NNVHEPSH+++j6REgbb1Vbxds+duOFlOtS8zCfpxU2sii62ObdfNbO/OgS2OLCZA8WZK9xQyhcBTDcZ/V0chlcnMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765485581; c=relaxed/simple;
	bh=KmGBl/9eKmTStx6dI/8UEla8L4+CjKh8aa3gJhbuM3A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gqXaXY2u6/VSm+VJtGYc8UM+WrB3GqY8iqRFhyluiHIH/E5ug79dAmogvRSc7TEPvV0JrHgSSV7vBE2yKppVE1R6716au3FHethIAqy+Wxp8MqyfevGxuKwqUJMIlO3s72c6RXO5TBeAO3uZHsLETzKVcsxN3JHwhc2MaHL4XQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai7hCTZc; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai7hCTZc"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5dfa9e34adbso332572137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 12:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765485578; x=1766090378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7wwk5jUphdjG6DWuVJnJ75qx/mrEOf+sEoEOOxxkXo=;
        b=Ai7hCTZc1ll6CpWr74RFx+0HrBn4y63MJC2s7RdXVjH8s8Luj5IgjEIfjQfmzx/tsY
         pzEwsf5OaM/eBEZCqxvm5bdGK4osv/149YVkhJOruRtdHFq9jWsbYfljM8tQpNsKh6oa
         e6S0/nkA2R1qFqlOAr7XYgg+tSfiY/LcL3ApCEiZGGUBsHGlh14LpeLtHNb7aGEzPB7L
         7Dc+f22k/YjNfAnQ9AlnloA2iXsf6qnT6GqGi2WDe3U5zj5vrob3eGtIcr3993i/VQmV
         xObPUochTFZSm1nqbw9jImXWGM3wZDYyvLuHz71Oh13/ZWqu6sSEe8rghSak+YGujLMy
         hlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765485578; x=1766090378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7wwk5jUphdjG6DWuVJnJ75qx/mrEOf+sEoEOOxxkXo=;
        b=IPCkMu6mOwnTAnhbFf1XQapCLM588M5zda3vr7ULrECHEx4tjqMxcM+2euOyPQqO9N
         RzWvdShGoQ4BpDaDLs0yED+Z4H/YZHZyY9pOyvjZBEthCgmap/sD15rQfDmp+hflcKr1
         FKXIPZoQADmAbdId00hRLL0M02IIA/2J1MrjtPhNTSLA7LyBNJpeEvL+JmJuzaO0HWdt
         TYvLz87EUZirLtSbtvgjESxAwrnUMu7xtUH9lWDc2uNmdsJfGVKdTIx2S04pP5B9Kenl
         vG1tnLW9TZl6GL9pIK40pSn5Qg1nJufMJUOJpHOGUwRk2Rv5WFsf5CE5uhiaTZdt7yUi
         ASiA==
X-Gm-Message-State: AOJu0YwvbwN4tC1yJpYL0Fip98nyVKWRNMTAcCmu1WyIsEwabhx3dbhx
	C+40XTkVSKm1RmF3Bu5U7KakZHUkZ1E0eQwrwGBadZ3EocYEm+ScaBckYmftlSoH
X-Gm-Gg: AY/fxX7R4EgVtVcF5H+RjuOO60Q/SStlyf6qnYhOgyNm/p0+W9uMtSA3sZYBkRjkdua
	ubkVQpfS4pZbpafHWjUDbVbVpRL1IVnGmtiPPViYbQexVxk/8JKmUoNIGsg8xz0l2hq+xegZg7V
	F06LrjUVnQuN/ouEs2worMOPsCIQ0S9Lk/+ru7GAPg7Ijs+G6J5vukZRNcRQQ3vDjillPE/Akdx
	Q3CUvMAbvaVDh4nEt0zzkMm4ZjX9CX0To1MAco8IERE/Sazy9oD4ykn5W1bG8ZL+HDQd9cCUaZL
	vSLF4Nxhqc7++2d5CA9vyYeXsrGA474SmXmo7h6QI6u20uuNx4D7Bw1fjlREJnNENH/uftPE6IY
	B9vQNZejQwHX6fSoH1v8yGYMP+i27l8OLn2YOue1VQNIjk03OjcpCnoOD2VMgu4WIxeZLXo5FLk
	5S6tNtqiWFj20AIg==
X-Google-Smtp-Source: AGHT+IGBvaKCzMzqT4Q24ZYCbmUR14bY4Ywk39EIbeI0FtsLvhxOMEKToyYWuEzoBTW0TFJseSNWZQ==
X-Received: by 2002:a05:6102:c47:b0:5db:cfb2:e610 with SMTP id ada2fe7eead31-5e571eed98emr2854441137.41.1765485577962;
        Thu, 11 Dec 2025 12:39:37 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e7d0f25ce2sm1354714137.8.2025.12.11.12.39.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 12:39:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] l2cap-test: Add tests for LE 2M and Coded PHYs
Date: Thu, 11 Dec 2025 15:39:27 -0500
Message-ID: <20251211203927.527036-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following tests that uses BT_PHY to retrieve the ACL/LE
connection supported LE 2M and Coded PHYs:

L2CAP LE Client - PHY 2M/Coded
L2CAP LE Server - PHY 2M/Coded
L2CAP Ext-Flowctl Client - PHY 2M/Coded
L2CAP Ext-Flowctl Server - PHY 2M/Coded
---
 tools/l2cap-tester.c | 110 +++++++++++++++++++++++++++++++++----------
 1 file changed, 86 insertions(+), 24 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 2706a4b33f7b..4cb56e98078a 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -265,13 +265,13 @@ static void test_data_free(void *test_data)
 	free(data);
 }
 
-#define test_l2cap_bredr(name, data, setup, func) \
+#define test_l2cap(name, type, data, setup, func) \
 	do { \
 		struct test_data *user; \
 		user = malloc(sizeof(struct test_data)); \
 		if (!user) \
 			break; \
-		user->hciemu_type = HCIEMU_TYPE_BREDR; \
+		user->hciemu_type = type; \
 		user->io_id = 0; \
 		user->err_io_id = 0; \
 		user->test_data = data; \
@@ -280,20 +280,14 @@ static void test_data_free(void *test_data)
 				test_post_teardown, 2, user, test_data_free); \
 	} while (0)
 
+#define test_l2cap_bredr(name, data, setup, func) \
+	test_l2cap(name, HCIEMU_TYPE_BREDR, data, setup, func)
+
 #define test_l2cap_le(name, data, setup, func) \
-	do { \
-		struct test_data *user; \
-		user = malloc(sizeof(struct test_data)); \
-		if (!user) \
-			break; \
-		user->hciemu_type = HCIEMU_TYPE_LE; \
-		user->io_id = 0; \
-		user->err_io_id = 0; \
-		user->test_data = data; \
-		tester_add_full(name, data, \
-				test_pre_setup, setup, func, NULL, \
-				test_post_teardown, 2, user, test_data_free); \
-	} while (0)
+	test_l2cap(name, HCIEMU_TYPE_LE, data, setup, func)
+
+#define test_l2cap_le_52(name, data, setup, func) \
+	test_l2cap(name, HCIEMU_TYPE_BREDRLE52, data, setup, func)
 
 static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 }; /* "0000" */
 
@@ -704,6 +698,14 @@ static const struct l2cap_data le_client_connect_phy_test_1 = {
 	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX),
 };
 
+static const struct l2cap_data le_client_connect_phy_2m_coded_test_1 = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+};
+
 static uint8_t nonexisting_bdaddr[] = {0x00, 0xAA, 0x01, 0x02, 0x03, 0x00};
 static const struct l2cap_data le_client_close_socket_test_1 = {
 	.client_psm = 0x0080,
@@ -792,6 +794,19 @@ static const struct l2cap_data le_server_phy_test = {
 	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX),
 };
 
+static const struct l2cap_data le_server_phy_2m_coded_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = le_connect_rsp,
+	.expect_cmd_len = sizeof(le_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+};
+
 static const uint8_t ecred_connect_req[] = {	0x80, 0x00, /* PSM */
 						0x40, 0x00, /* MTU */
 						0x40, 0x00, /* MPS */
@@ -861,6 +876,19 @@ static const struct l2cap_data ext_flowctl_server_phy_test = {
 	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX),
 };
 
+static const struct l2cap_data ext_flowctl_server_phy_2m_coded_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req,
+	.send_cmd_len = sizeof(ecred_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = ecred_connect_rsp,
+	.expect_cmd_len = sizeof(ecred_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+};
+
 static const struct l2cap_data le_att_client_connect_success_test_1 = {
 	.cid = 0x0004,
 	.sec_level = BT_SECURITY_LOW,
@@ -994,6 +1022,15 @@ static const struct l2cap_data ext_flowctl_client_connect_phy_test_1 = {
 	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX),
 };
 
+static const struct l2cap_data ext_flowctl_client_phy_2m_coded_test_1 = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
+};
+
 static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -1007,6 +1044,7 @@ static void client_cmd_complete(uint16_t opcode, uint8_t status,
 	switch (opcode) {
 	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
 	case BT_HCI_CMD_LE_SET_ADV_ENABLE:
+	case BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE:
 		tester_print("Client set connectable status 0x%02x", status);
 		if (!status && test && test->enable_ssp) {
 			bthost_write_ssp_mode(bthost, 0x01);
@@ -1067,10 +1105,14 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_cmd_complete_cb(bthost, client_cmd_complete, user_data);
 
-	if (data->hciemu_type == HCIEMU_TYPE_LE) {
-		if (!l2data || !l2data->server_not_advertising)
-			bthost_set_adv_enable(bthost, 0x01);
-		else
+	if (data->hciemu_type >= HCIEMU_TYPE_LE) {
+		if (!l2data || !l2data->server_not_advertising) {
+			if (data->hciemu_type > HCIEMU_TYPE_LE) {
+				bthost_set_ext_adv_params(bthost, 0x00);
+				bthost_set_ext_adv_enable(bthost, 0x01);
+			} else
+				bthost_set_adv_enable(bthost, 0x01);
+		} else
 			tester_setup_complete();
 	} else {
 		bthost_write_scan_enable(bthost, 0x03);
@@ -1182,7 +1224,7 @@ static void send_rsp_new_conn(uint16_t handle, void *user_data)
 
 	data->handle = handle;
 
-	if (data->hciemu_type == HCIEMU_TYPE_LE)
+	if (data->hciemu_type >= HCIEMU_TYPE_LE)
 		data->dcid = 0x0005;
 	else
 		data->dcid = 0x0001;
@@ -1217,7 +1259,7 @@ static void setup_powered_common(void)
 	if (test && test->reject_ssp)
 		bthost_set_reject_user_confirm(bthost, true);
 
-	if (data->hciemu_type == HCIEMU_TYPE_LE)
+	if (data->hciemu_type >= HCIEMU_TYPE_LE)
 		mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
 
@@ -1249,6 +1291,10 @@ static void setup_powered_client(const void *test_data)
 				data->mgmt_index, sizeof(param), param,
 				NULL, NULL, NULL);
 
+	if (data->hciemu_type > HCIEMU_TYPE_LE)
+		mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+				sizeof(param), param, NULL, NULL, NULL);
+
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 			sizeof(param), param, setup_powered_client_callback,
 			NULL, NULL);
@@ -1266,6 +1312,10 @@ static void setup_powered_server(const void *test_data)
 	mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
 
+	if (data->hciemu_type > HCIEMU_TYPE_LE)
+		mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+				sizeof(param), param, NULL, NULL, NULL);
+
 	if (data->hciemu_type != HCIEMU_TYPE_BREDR)
 		mgmt_send(data->mgmt, MGMT_OP_SET_ADVERTISING,
 				data->mgmt_index, sizeof(param), param, NULL,
@@ -1403,7 +1453,7 @@ static bool check_mtu(struct test_data *data, int sk)
 
 	memset(&data->l2o, 0, sizeof(data->l2o));
 
-	if (data->hciemu_type == HCIEMU_TYPE_LE &&
+	if (data->hciemu_type >= HCIEMU_TYPE_LE &&
 				(l2data->client_psm || l2data->server_psm)) {
 		/* LE CoC enabled kernels should support BT_RCVMTU and
 		 * BT_SNDMTU.
@@ -1701,7 +1751,7 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 
 	if (l2data && l2data->addr_type_avail)
 		addr.l2_bdaddr_type = l2data->addr_type;
-	else if (data->hciemu_type == HCIEMU_TYPE_LE)
+	else if (data->hciemu_type >= HCIEMU_TYPE_LE )
 		addr.l2_bdaddr_type = BDADDR_LE_PUBLIC;
 	else
 		addr.l2_bdaddr_type = BDADDR_BREDR;
@@ -1792,7 +1842,7 @@ static int connect_l2cap_sock(struct test_data *data, int sk, uint16_t psm,
 
 	if (l2data && l2data->addr_type_avail)
 		bdaddr_type = l2data->addr_type;
-	else if (data->hciemu_type == HCIEMU_TYPE_LE)
+	else if (data->hciemu_type >= HCIEMU_TYPE_LE)
 		bdaddr_type = BDADDR_LE_PUBLIC;
 	else
 		bdaddr_type = BDADDR_BREDR;
@@ -2810,6 +2860,9 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP LE Client - PHY",
 				&le_client_connect_phy_test_1,
 				setup_powered_client, test_connect);
+	test_l2cap_le_52("L2CAP LE Client - PHY 2M/Coded",
+				&le_client_connect_phy_2m_coded_test_1,
+				setup_powered_client, test_connect);
 
 	test_l2cap_le("L2CAP LE Client - Close socket 1",
 				&le_client_close_socket_test_1,
@@ -2840,6 +2893,9 @@ int main(int argc, char *argv[])
 					setup_powered_server, test_server);
 	test_l2cap_le("L2CAP LE Server - PHY", &le_server_phy_test,
 					setup_powered_server, test_server);
+	test_l2cap_le_52("L2CAP LE Server - PHY 2M/Coded",
+					&le_server_phy_2m_coded_test,
+					setup_powered_server, test_server);
 
 	test_l2cap_le("L2CAP Ext-Flowctl Client - Success",
 				&ext_flowctl_client_connect_success_test_1,
@@ -2873,6 +2929,9 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP Ext-Flowctl Client - PHY",
 				&ext_flowctl_client_connect_phy_test_1,
 				setup_powered_client, test_connect);
+	test_l2cap_le_52("L2CAP Ext-Flowctl Client - PHY 2M/Coded",
+				&ext_flowctl_client_phy_2m_coded_test_1,
+				setup_powered_client, test_connect);
 
 	test_l2cap_le("L2CAP Ext-Flowctl Server - Success",
 				&ext_flowctl_server_success_test,
@@ -2883,6 +2942,9 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP Ext-Flowctl Server - PHY",
 				&ext_flowctl_server_phy_test,
 				setup_powered_server, test_server);
+	test_l2cap_le_52("L2CAP Ext-Flowctl Server - PHY 2M/Coded",
+				&ext_flowctl_server_phy_2m_coded_test,
+				setup_powered_server, test_server);
 
 	test_l2cap_le("L2CAP LE ATT Client - Success",
 				&le_att_client_connect_success_test_1,
-- 
2.52.0

