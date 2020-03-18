Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18934C4332D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C122076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXb/+X+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgCRVvd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:51:33 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:43676 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgCRVvd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 17:51:33 -0400
Received: by mail-pl1-f174.google.com with SMTP id f8so81435plt.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=y47JAL13kd9m3MR+MQoSfYse40ccLpnx6bG267K3WlY=;
        b=ZXb/+X+liM2sco8C1d/2QZ/c7VBuE8NfzGClghkiSlXGjkMdBuDVYpVOrSaVzYEAq4
         N2KEOlAtNhK1oA7xCX30pwg2Yt9rCBMLSS8hcttJfwCwoe5pyQHPIJbhIMhUhpV8KH6z
         kBPFCAhaOkGkSjAe5zZ3epN+IDWVpuglKtIx2Z/QgdKPbdkKsz8+/1lYSaz8enQ7OxY6
         odaH+1YB/02RJJmF7l2ochf29hz1rc3fFdBU80dkwKlc/LkoBtGKuh/jOx+qO6VxdFwd
         wJn5Bqa4I6J0524mrmPAcCUy/C+07Dn2VIxu7hSYhp5oyUgnKOBBkiFHW58Tj9Yg+NVB
         06WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y47JAL13kd9m3MR+MQoSfYse40ccLpnx6bG267K3WlY=;
        b=HI92uFL1M5Pd5rnmUDU31UCu8PdTmJ6Me3RQDIoQ9zwIRmueECdJ6JIT/L6pg1SGqD
         UukzIWl6350FaDPxi8WD3h1FBt/4xh0ciiWAGAd1CIxY71U7qiP82uTRdWdkmu9qSo+g
         ZHde5SGeE1LaAyithl+QZNh024yEfJa/n67RVomef9mUVl4iqHONBvrlIfO7TodViz6T
         QoaW/9ZSh2WavIpgLR/dNq2vuDZnRliVKrhCiZxEjvCTmPKP/H8FAaSOst2WyTznSddC
         8hGebLN16v7zyksKRPE9nD2lebsTF2gfJm26PBrdvFHd/T7vI/z+b20zW5IdEa1mtZ2P
         XZbA==
X-Gm-Message-State: ANhLgQ3+CV5yMJvMAodUvnn0lwocCVIPCLceOKI5yHyCR3K2/BowExoq
        eqG40dIGOFKRL5vLwxNnBq34u4CO
X-Google-Smtp-Source: ADFU+vtbucaoyNWDFQhijjtaNJe2PeBJu0uwAm16PZxISxuXlscWpsp7VAnKagfqfP9K1x+Bl2Rxmw==
X-Received: by 2002:a17:90b:d8d:: with SMTP id bg13mr271882pjb.29.1584568290213;
        Wed, 18 Mar 2020 14:51:30 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r13sm83709pgf.1.2020.03.18.14.51.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:51:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/6] tools/l2cap-tester: Add test for Ext-Flowctl mode
Date:   Wed, 18 Mar 2020 14:51:23 -0700
Message-Id: <20200318215124.21880-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200318215124.21880-1-luiz.dentz@gmail.com>
References: <20200318215124.21880-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds tests for Ext-Flowctl which uses ECRED PDUs.
---
 tools/l2cap-tester.c | 174 +++++++++++++++++++++++++++++++++----------
 1 file changed, 136 insertions(+), 38 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 945f82caf..ebbd29f11 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -61,6 +61,7 @@ struct l2cap_data {
 	uint16_t client_psm;
 	uint16_t server_psm;
 	uint16_t cid;
+	uint8_t mode;
 	int expect_err;
 
 	uint8_t send_cmd_code;
@@ -91,7 +92,7 @@ struct l2cap_data {
 	uint8_t *client_bdaddr;
 	bool server_not_advertising;
 	bool direct_advertising;
-	bool close_one_socket;
+	bool close_1;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -474,17 +475,17 @@ static const struct l2cap_data le_client_close_socket_test_2 = {
 	.server_not_advertising = true,
 };
 
-static const struct l2cap_data le_client_two_sockets_same_client = {
+static const struct l2cap_data le_client_2_same_client = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
 	.server_not_advertising = true,
 };
 
-static const struct l2cap_data le_client_two_sockets_close_one = {
+static const struct l2cap_data le_client_2_close_1 = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
 	.server_not_advertising = true,
-	.close_one_socket = true,
+	.close_1 = true,
 };
 
 static const struct l2cap_data le_client_connect_nval_psm_test = {
@@ -549,6 +550,49 @@ static const struct l2cap_data le_att_server_success_test_1 = {
 	.cid = 0x0004,
 };
 
+static const struct l2cap_data ext_flowctl_client_connect_success_test_1 = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+};
+
+static const struct l2cap_data ext_flowctl_client_connect_adv_success_test_1 = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.direct_advertising = true,
+};
+
+static const struct l2cap_data ext_flowctl_client_connect_success_test_2 = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.sec_level  = BT_SECURITY_MEDIUM,
+};
+
+static const struct l2cap_data ext_flowctl_client_connect_reject_test_1 = {
+	.client_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.send_cmd = cmd_reject_rsp,
+	.send_cmd_len = sizeof(cmd_reject_rsp),
+	.expect_err = ECONNREFUSED,
+};
+
+static const struct l2cap_data ext_flowctl_client_2 = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.server_not_advertising = true,
+};
+
+static const struct l2cap_data ext_flowctl_client_2_close_1 = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.server_not_advertising = true,
+	.close_1 = true,
+};
+
 static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -1031,7 +1075,7 @@ failed:
 }
 
 static int create_l2cap_sock(struct test_data *data, uint16_t psm,
-						uint16_t cid, int sec_level)
+				uint16_t cid, int sec_level, uint8_t mode)
 {
 	const struct l2cap_data *l2data = data->test_data;
 	const uint8_t *master_bdaddr;
@@ -1091,6 +1135,17 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 		}
 	}
 
+	if (mode) {
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_MODE, &mode,
+							sizeof(mode)) < 0) {
+			err = -errno;
+			tester_warn("Can't set mode: %s (%d)", strerror(errno),
+									errno);
+			close(sk);
+			return err;
+		}
+	}
+
 	return sk;
 }
 
@@ -1212,7 +1267,8 @@ static void test_connect(const void *test_data)
 		hciemu_add_master_post_command_hook(data->hciemu,
 						direct_adv_cmd_complete, NULL);
 
-	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level);
+	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level,
+							l2data->mode);
 	if (sk < 0) {
 		tester_test_failed();
 		return;
@@ -1241,7 +1297,8 @@ static void test_connect_reject(const void *test_data)
 	const struct l2cap_data *l2data = data->test_data;
 	int sk;
 
-	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level);
+	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level,
+							l2data->mode);
 	if (sk < 0) {
 		tester_test_failed();
 		return;
@@ -1256,29 +1313,40 @@ static void test_connect_reject(const void *test_data)
 	close(sk);
 }
 
-static void connect_socket(const uint8_t *client_bdaddr, int *sk_holder,
-							GIOFunc connect_cb)
+static int connect_socket(const uint8_t *client_bdaddr, GIOFunc connect_cb,
+								bool defer)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 	GIOChannel *io;
 	int sk;
 
-	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level);
+	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level,
+							l2data->mode);
 	if (sk < 0) {
 		tester_print("Error in create_l2cap_sock");
 		tester_test_failed();
-		return;
+		return -1;
 	}
 
-	*sk_holder = sk;
+	if (defer) {
+		int opt = 1;
+
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP, &opt,
+							sizeof(opt)) < 0) {
+			tester_print("Can't enable deferred setup: %s (%d)",
+						strerror(errno), errno);
+			tester_test_failed();
+			return -1;
+		}
+	}
 
 	if (connect_l2cap_impl(sk, client_bdaddr, BDADDR_LE_PUBLIC,
 			l2data->client_psm, l2data->cid) < 0) {
 		tester_print("Error in connect_l2cap_sock");
 		close(sk);
 		tester_test_failed();
-		return;
+		return -1;
 	}
 
 	if (connect_cb) {
@@ -1290,7 +1358,10 @@ static void connect_socket(const uint8_t *client_bdaddr, int *sk_holder,
 		g_io_channel_unref(io);
 	}
 
-	tester_print("Connect in progress, sk = %d", sk);
+	tester_print("Connect in progress, sk = %d %s", sk,
+				defer ? "(deferred)" : "");
+
+	return -1;
 }
 
 static gboolean test_close_socket_1_part_3(gpointer arg)
@@ -1457,11 +1528,11 @@ static void test_close_socket(const void *test_data)
 	else
 		client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
 
-	connect_socket(client_bdaddr, &data->sk, NULL);
+	data->sk = connect_socket(client_bdaddr, NULL, false);
 }
 
-static uint8_t test_two_sockets_connect_cb_cnt;
-static gboolean test_two_sockets_connect_cb(GIOChannel *io, GIOCondition cond,
+static uint8_t test_2_connect_cb_cnt;
+static gboolean test_2_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1485,15 +1556,15 @@ static gboolean test_two_sockets_connect_cb(GIOChannel *io, GIOCondition cond,
 	}
 
 	tester_print("Successfully connected");
-	test_two_sockets_connect_cb_cnt++;
+	test_2_connect_cb_cnt++;
 
-	if (test_two_sockets_connect_cb_cnt == 2) {
+	if (test_2_connect_cb_cnt == 2) {
 		close(data->sk);
 		close(data->sk2);
 		tester_test_passed();
 	}
 
-	if (l2data->close_one_socket && test_two_sockets_connect_cb_cnt == 1) {
+	if (l2data->close_1 && test_2_connect_cb_cnt == 1) {
 		close(data->sk2);
 		tester_test_passed();
 	}
@@ -1510,16 +1581,16 @@ static gboolean enable_advertising(gpointer args)
 	return FALSE;
 }
 
-static void test_connect_two_sockets_part_2(void)
+static void test_connect_2_part_2(void)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 	const uint8_t *client_bdaddr;
 
 	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
-	connect_socket(client_bdaddr, &data->sk2, test_two_sockets_connect_cb);
+	data->sk2 = connect_socket(client_bdaddr, test_2_connect_cb, false);
 
-	if (l2data->close_one_socket) {
+	if (l2data->close_1) {
 		tester_print("Closing first socket! %d", data->sk);
 		close(data->sk);
 	}
@@ -1528,7 +1599,7 @@ static void test_connect_two_sockets_part_2(void)
 }
 
 static uint8_t test_scan_enable_counter;
-static void test_connect_two_sockets_router(uint16_t opcode, const void *param,
+static void test_connect_2_router(uint16_t opcode, const void *param,
 					uint8_t length, void *user_data)
 {
 	const struct bt_hci_cmd_le_set_scan_enable *scan_params = param;
@@ -1538,23 +1609,24 @@ static void test_connect_two_sockets_router(uint16_t opcode, const void *param,
 						scan_params->enable == true) {
 		test_scan_enable_counter++;
 		if (test_scan_enable_counter == 1)
-			test_connect_two_sockets_part_2();
+			test_connect_2_part_2();
 		else if (test_scan_enable_counter == 2)
 			g_idle_add(enable_advertising, NULL);
 	}
 }
 
-static void test_connect_two_sockets(const void *test_data)
+static void test_connect_2(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 	const uint8_t *client_bdaddr;
+	bool defer;
 
-	test_two_sockets_connect_cb_cnt = 0;
+	test_2_connect_cb_cnt = 0;
 	test_scan_enable_counter = 0;
 
 	hciemu_add_master_post_command_hook(data->hciemu,
-				test_connect_two_sockets_router, data);
+				test_connect_2_router, data);
 
 	if (l2data->server_psm) {
 		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
@@ -1564,12 +1636,14 @@ static void test_connect_two_sockets(const void *test_data)
 						NULL, NULL);
 	}
 
+	defer = (l2data->mode == BT_MODE_EXT_FLOWCTL);
+
 	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
-	if (l2data->close_one_socket)
-		connect_socket(client_bdaddr, &data->sk, NULL);
+	if (l2data->close_1)
+		data->sk = connect_socket(client_bdaddr, NULL, defer);
 	else
-		connect_socket(client_bdaddr, &data->sk,
-						test_two_sockets_connect_cb);
+		data->sk = connect_socket(client_bdaddr, test_2_connect_cb,
+								defer);
 }
 
 static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
@@ -1727,7 +1801,8 @@ static void test_server(const void *test_data)
 
 	if (l2data->server_psm || l2data->cid) {
 		sk = create_l2cap_sock(data, l2data->server_psm,
-					l2data->cid, l2data->sec_level);
+					l2data->cid, l2data->sec_level,
+					l2data->mode);
 		if (sk < 0) {
 			tester_test_failed();
 			return;
@@ -1776,7 +1851,7 @@ static void test_getpeername_not_connected(const void *test_data)
 	socklen_t len;
 	int sk;
 
-	sk = create_l2cap_sock(data, 0, 0, 0);
+	sk = create_l2cap_sock(data, 0, 0, 0, 0);
 	if (sk < 0) {
 		tester_test_failed();
 		return;
@@ -1902,14 +1977,14 @@ int main(int argc, char *argv[])
 				test_close_socket);
 
 	test_l2cap_le("L2CAP LE Client - Open two sockets",
-				&le_client_two_sockets_same_client,
+				&le_client_2_same_client,
 				setup_powered_client,
-				test_connect_two_sockets);
+				test_connect_2);
 
 	test_l2cap_le("L2CAP LE Client - Open two sockets close one",
-				&le_client_two_sockets_close_one,
+				&le_client_2_close_1,
 				setup_powered_client,
-				test_connect_two_sockets);
+				test_connect_2);
 
 	test_l2cap_le("L2CAP LE Client - Invalid PSM",
 					&le_client_connect_nval_psm_test,
@@ -1920,6 +1995,29 @@ int main(int argc, char *argv[])
 					setup_powered_server, test_server);
 
 
+	test_l2cap_le("L2CAP Ext-Flowctl Client - Success",
+				&ext_flowctl_client_connect_success_test_1,
+				setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP Ext-Flowctl Client, Direct Advertising - Success",
+				&ext_flowctl_client_connect_adv_success_test_1,
+				setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP Ext-Flowctl Client SMP - Success",
+				&ext_flowctl_client_connect_success_test_2,
+				setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP Ext-Flowctl Client - Command Reject",
+				&ext_flowctl_client_connect_reject_test_1,
+				setup_powered_client, test_connect);
+
+	test_l2cap_le("L2CAP Ext-Flowctl Client - Open two sockets",
+				&ext_flowctl_client_2,
+				setup_powered_client,
+				test_connect_2);
+
+	test_l2cap_le("L2CAP Ext-Flowctl Client - Open two sockets close one",
+				&ext_flowctl_client_2_close_1,
+				setup_powered_client,
+				test_connect_2);
+
 	test_l2cap_le("L2CAP LE ATT Client - Success",
 				&le_att_client_connect_success_test_1,
 				setup_powered_client, test_connect);
-- 
2.21.1

