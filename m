Return-Path: <SRS0=nALV=6T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E46C47256
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 04:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6495206CC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 04:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3gctP73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgEEE3U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 00:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725298AbgEEE3T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 00:29:19 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C36C061A0F
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2020 21:29:19 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id p31so341901qte.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2020 21:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9gjjxlOgtpRMoa0zwm/oi7eh+qbv7I6Yrhzx9HCF+hA=;
        b=n3gctP73LFSKLfWbTYRhHEqttcmGfiTTrbfvA88VDT7c6cnjiS55HSmWfykrVnE7E0
         tZn0BtcXMBQ5D2Fw8NAzeHh5a0Ffn3QEeDU9tqMaJvPLm6mmZLN5gnt1z4PizJYA21DD
         Ci1weU9uuvlcf+8CpYawGlkkuywvPgIlPM7yTRvyYfdFeN8FGSPVac3pmAPo2YOZHptK
         FEyY9Ja6vYMKNgmAghadn4Z2YlHl3Fx1aEofH1HqajO7ZQA/jYu16/FRIl0Kday1WvWN
         QU1hqbxzoGAlkH4WnllIAjXNdgD+ZbsrFahicZ7EUR6UX4coEqGsUKlkSIbCbGT66vQg
         lv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9gjjxlOgtpRMoa0zwm/oi7eh+qbv7I6Yrhzx9HCF+hA=;
        b=F9CCHMObcJxTJxaRuuzO7GM0s24W3AsAnQ2MZ6gu2ST6qgoc8CjV0A4Jga4Zdz8bSO
         qEhyYk83uUxsgzx7lb58iLwtJrzdIFMtz9vY+4r9uXoxdiEPsgLYzf5MT58gMjRqi1Hb
         d3sZfNPfGksiS/MqAm2AY8K1DHXBKIpBGl8xwwmHrPwaqlijuBzTCZfkUoc565GJosqb
         tN9/QXhYiGgA/9kkwjQwVYtz1dzkrD6FIn2o8Ml1XHDD/fQAAC8M2pTC+6KweUHA+VDx
         VjSdlBOah2gvTc8xLEDXaMY6iLCiMritrFrmO2heYtLP35+zyG6+h2thpHHb1meWJ9je
         aq9Q==
X-Gm-Message-State: AGi0PubCRc4GNTiMN74E2QHMeImJtJC697rWrGb0o5GD3/aXpXfPomdL
        gBiMyw1V6VSUz0NxcBJn7hw4PZoXDEh66Q19wT+QdFMMuSooX3ZUyfeoDdgK+lKDoO4FV/jiXlS
        mnSBc0tQuTTPDM7qQF/h0ullfmE2uvOqQoJRtle5TNYsYBJbVBUQPBMMK61wFjK/mrFKcO4pwyr
        ki
X-Google-Smtp-Source: APiQypJfi2PLjFLl5gDhCFIWXjyb1Qpq+CPZkdYH7CI3oTpCzHdQciDqviyv9gkQmKNOPj57wGdjjqiNuGEc
X-Received: by 2002:ad4:42b1:: with SMTP id e17mr910052qvr.149.1588652958504;
 Mon, 04 May 2020 21:29:18 -0700 (PDT)
Date:   Tue,  5 May 2020 12:29:11 +0800
Message-Id: <20200505121918.Bluez.v2.1.I86c1e0e8933d92d8d76dcd95036bf325cfaeced0@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [Bluez PATCH v2] tools/l2cap-tester: Add test for waiting
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

Changes in v2:
- Fix compile error in android/tester-main.c

 android/tester-main.c |  2 +-
 emulator/bthost.c     | 17 ++++++++++-
 emulator/bthost.h     |  5 +++-
 tools/l2cap-tester.c  | 65 ++++++++++++++++++++++++++++++++++++++-----
 tools/rfcomm-tester.c |  2 +-
 5 files changed, 80 insertions(+), 11 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 3c5af299f..9a14b2899 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -2867,7 +2867,7 @@ void emu_add_l2cap_server_action(void)
 	bthost = hciemu_client_get_host(data->hciemu);
 
 	bthost_add_l2cap_server(bthost, l2cap_data->psm, l2cap_data->func,
-							l2cap_data->user_data);
+						NULL, l2cap_data->user_data);
 
 	step->action_status = BT_STATUS_SUCCESS;
 
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
2.26.2.526.g744177e7f7-goog

