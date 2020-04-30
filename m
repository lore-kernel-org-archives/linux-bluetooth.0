Return-Path: <SRS0=orbE=6O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ED4C83001
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Apr 2020 06:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEDF2173E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Apr 2020 06:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmcDxDtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgD3GwK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD3GwK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Apr 2020 02:52:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C82C035494
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 23:52:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j14so6646246ybt.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 23:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=omzHo0koY7dcjx+Gzrl5mBh8dtsJ/ea8rdYZunB0qDw=;
        b=SmcDxDtnxUwDFpUGMwAWNq8361K6kvTNAut60UpERl17bvNUiyO1FaqVQYBTCvpn2H
         A5NsxKGbJYbhjGFTxGDRw8FiBdWXxLcvSeF+RCxAOpMkkQgsSyDsiU6is7IoJEgUXn+S
         aH2sCO3+ahnslMB2B4SsZzOXoAfSJFUxjn4hFlsWFQuHEtRK+WwUznB2h7AFddxkgYpF
         rq5ySd+/9Cz8xYKtaYoL9XmEoCCJXrb4F0dzZ9HjWrk1dCzbcD7oakLDGi/Q7BekWMNO
         ZbST4wF/jBCPdA7TncRUX+U5fQhNH2S4okjgLA28xZ0lGw+ukVjCbpVVlIxAVCaqTh1+
         ZTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=omzHo0koY7dcjx+Gzrl5mBh8dtsJ/ea8rdYZunB0qDw=;
        b=K9N0SmnjocxXKPG/tYqm9PeQ6sP803BAbBmepQCBTBZ5Rigi3EwOlLm2jc4J0Q1qNj
         CGzlB3lhVCieOnvgrHD/NwluX+txHymqXkGVtMeKL673vBCyQSioJq9mfjNGADm5P4u7
         VLkiiSYjDoLUs1JGKuXYBj9c7DlWkpZmg8qOPlPepLBW3mO59HbrdYPxpVNtV0Eu7DbE
         /2UcJ3VJZLtRBGqkF9uMn8BfOuW/U6vyC//N7aZphtUEXZD0CHX+CqGZ3BV2xQchPoJF
         TBgdkBP5uZ/JENG9Ixz3WDiajVnXi4OEeibYE/P9l06BKzgmODPBqQAW8eJ1PRUOj0vj
         BpnQ==
X-Gm-Message-State: AGi0PuZd6hvnzCgIEakmyrAtipWlzc+miJSeJISK3rgu4f5ZV17HxWdN
        4pq1zFcSioSuJUNLSwQyfnZkdktpzQ5StzDjwWs3/NzHos+BDjOUwXWKYoAhuiw8+YWVaMEKCaT
        HrBAnJ69zijgc5xWaUYtgn0aeFwKZiDH587kZnC0wGYmlwTY+XTFtuHwO5VWyUcTueMUeeUK2py
        JK
X-Google-Smtp-Source: APiQypIoOPMAoP2g4tr5v1LUKfZuEmUOwPozRtxSOvavAE3+fHliAacPfpuSDHQzpK/UzoXdjRz9Yz6tYvRU
X-Received: by 2002:a25:bd6:: with SMTP id 205mr3673988ybl.93.1588229527781;
 Wed, 29 Apr 2020 23:52:07 -0700 (PDT)
Date:   Thu, 30 Apr 2020 14:51:45 +0800
Message-Id: <20200430145105.Bluez.v1.1.I86c1e0e8933d92d8d76dcd95036bf325cfaeced0@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [Bluez PATCH v1] tools/l2cap-tester: Add test for waiting
 disconnection response
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This is to test the behaviour of L2CAP channel when closed with
shut_down(sock, SHUT_WR). In this case, we should wait until we
receive a disconnection response before raising G_IO_HUP.
---

 emulator/bthost.c     | 17 ++++++++++-
 emulator/bthost.h     |  5 +++-
 tools/l2cap-tester.c  | 65 ++++++++++++++++++++++++++++++++++++++-----
 tools/rfcomm-tester.c |  2 +-
 4 files changed, 79 insertions(+), 10 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 0fa283464..71d5f97bb 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -180,6 +180,7 @@ struct l2cap_pending_req {
 struct l2cap_conn_cb_data {
 	uint16_t psm;
 	bthost_l2cap_connect_cb func;
+	bthost_l2cap_disconnect_cb disconn_func;
 	void *user_data;
 	struct l2cap_conn_cb_data *next;
 };
@@ -1510,7 +1511,9 @@ static bool l2cap_disconn_req(struct bthost *bthost, struct btconn *conn,
 				uint8_t ident, const void *data, uint16_t len)
 {
 	const struct bt_l2cap_pdu_disconn_req *req = data;
+	struct l2cap_conn_cb_data *cb_data;
 	struct bt_l2cap_pdu_disconn_rsp rsp;
+	struct l2conn *l2conn;
 
 	if (len < sizeof(*req))
 		return false;
@@ -1522,6 +1525,15 @@ static bool l2cap_disconn_req(struct bthost *bthost, struct btconn *conn,
 	l2cap_sig_send(bthost, conn, BT_L2CAP_PDU_DISCONN_RSP, ident, &rsp,
 								sizeof(rsp));
 
+	l2conn = btconn_find_l2cap_conn_by_scid(conn, rsp.scid);
+	if (!l2conn)
+		return true;
+
+	cb_data = bthost_find_l2cap_cb_by_psm(bthost, l2conn->psm);
+
+	if (cb_data && cb_data->disconn_func)
+		cb_data->disconn_func(cb_data->user_data);
+
 	return true;
 }
 
@@ -2553,7 +2565,9 @@ uint64_t bthost_conn_get_fixed_chan(struct bthost *bthost, uint16_t handle)
 }
 
 void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
-				bthost_l2cap_connect_cb func, void *user_data)
+				bthost_l2cap_connect_cb func,
+				bthost_l2cap_disconnect_cb disconn_func,
+				void *user_data)
 {
 	struct l2cap_conn_cb_data *data;
 
@@ -2564,6 +2578,7 @@ void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
 	data->psm = psm;
 	data->user_data = user_data;
 	data->func = func;
+	data->disconn_func = disconn_func;
 	data->next = bthost->new_l2cap_conn_data;
 
 	bthost->new_l2cap_conn_data = data;
diff --git a/emulator/bthost.h b/emulator/bthost.h
index b5f36964d..2b347136f 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -100,9 +100,12 @@ void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
 							const uint8_t ltk[16]);
 typedef void (*bthost_l2cap_connect_cb) (uint16_t handle, uint16_t cid,
 							void *user_data);
+typedef void (*bthost_l2cap_disconnect_cb) (void *user_data);
 
 void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
-				bthost_l2cap_connect_cb func, void *user_data);
+				bthost_l2cap_connect_cb func,
+				bthost_l2cap_disconnect_cb disconn_func,
+				void *user_data);
 
 void bthost_set_sc_support(struct bthost *bthost, bool enable);
 
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 844ff2b46..1ef4e9213 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -55,6 +55,7 @@ struct test_data {
 	uint16_t dcid;
 	int sk;
 	int sk2;
+	bool host_disconnected;
 };
 
 struct l2cap_data {
@@ -93,6 +94,8 @@ struct l2cap_data {
 	bool server_not_advertising;
 	bool direct_advertising;
 	bool close_1;
+
+	bool shut_sock_wr;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -316,6 +319,12 @@ static const struct l2cap_data client_connect_write_success_test = {
 	.data_len = sizeof(l2_data),
 };
 
+static const struct l2cap_data client_connect_shut_wr_success_test = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.shut_sock_wr = true,
+};
+
 static const struct l2cap_data client_connect_nval_psm_test_1 = {
 	.client_psm = 0x1001,
 	.expect_err = ECONNREFUSED,
@@ -967,6 +976,27 @@ static void server_bthost_received_data(const void *buf, uint16_t len,
 		tester_test_passed();
 }
 
+static gboolean socket_closed_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+
+	if (l2data->shut_sock_wr) {
+		/* if socket is closed using SHUT_WR, L2CAP disconnection
+		 * response must be received first before G_IO_HUP event.
+		 */
+		if (data->host_disconnected)
+			tester_test_passed();
+		else {
+			tester_warn("G_IO_HUP received before receiving L2CAP disconnection");
+			tester_test_failed();
+		}
+	}
+
+	return FALSE;
+}
+
 static bool check_mtu(struct test_data *data, int sk)
 {
 	const struct l2cap_data *l2data = data->test_data;
@@ -1062,6 +1092,11 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 			tester_test_failed();
 		}
 
+		return FALSE;
+	} else if (l2data->shut_sock_wr) {
+		g_io_add_watch(io, G_IO_HUP, socket_closed_cb, NULL);
+		shutdown(sk, SHUT_WR);
+
 		return FALSE;
 	}
 
@@ -1214,6 +1249,13 @@ static void client_l2cap_connect_cb(uint16_t handle, uint16_t cid,
 	data->handle = handle;
 }
 
+static void client_l2cap_disconnect_cb(void *user_data)
+{
+	struct test_data *data = user_data;
+
+	data->host_disconnected = true;
+}
+
 static void direct_adv_cmd_complete(uint16_t opcode, const void *param,
 						uint8_t len, void *user_data)
 {
@@ -1254,13 +1296,18 @@ static void test_connect(const void *test_data)
 
 	if (l2data->server_psm) {
 		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+		bthost_l2cap_connect_cb host_connect_cb = NULL;
+		bthost_l2cap_disconnect_cb host_disconnect_cb = NULL;
 
-		if (!l2data->data_len)
-			bthost_add_l2cap_server(bthost, l2data->server_psm,
-						NULL, NULL);
-		else
-			bthost_add_l2cap_server(bthost, l2data->server_psm,
-						client_l2cap_connect_cb, data);
+		if (l2data->data_len)
+			host_connect_cb = client_l2cap_connect_cb;
+
+		if (l2data->shut_sock_wr)
+			host_disconnect_cb = client_l2cap_disconnect_cb;
+
+		bthost_add_l2cap_server(bthost, l2data->server_psm,
+					host_connect_cb, host_disconnect_cb,
+					data);
 	}
 
 	if (l2data->direct_advertising)
@@ -1639,7 +1686,7 @@ static void test_connect_2(const void *test_data)
 
 		if (!l2data->data_len)
 			bthost_add_l2cap_server(bthost, l2data->server_psm,
-						NULL, NULL);
+						NULL, NULL, NULL);
 	}
 
 	defer = (l2data->mode == BT_MODE_EXT_FLOWCTL);
@@ -1927,6 +1974,10 @@ int main(int argc, char *argv[])
 					&client_connect_nval_psm_test_3,
 					setup_powered_client, test_connect);
 
+	test_l2cap_bredr("L2CAP BR/EDR Client - Socket Shut WR Success",
+					&client_connect_shut_wr_success_test,
+					setup_powered_client, test_connect);
+
 	test_l2cap_bredr("L2CAP BR/EDR Server - Success",
 					&l2cap_server_success_test,
 					setup_powered_server, test_server);
diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index b20d70d58..2d3be27d8 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -548,7 +548,7 @@ static void test_connect(const void *test_data)
 	GIOChannel *io;
 	int sk;
 
-	bthost_add_l2cap_server(bthost, 0x0003, NULL, NULL);
+	bthost_add_l2cap_server(bthost, 0x0003, NULL, NULL, NULL);
 	bthost_add_rfcomm_server(bthost, cli->server_channel,
 						rfcomm_connect_cb, NULL);
 
-- 
2.26.2.303.gf8c07b1a785-goog

