Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE41DC64EC4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 00:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjCJAA4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 19:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCJAAz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 19:00:55 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91123E63D2
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 16:00:53 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id m22so1401928ioy.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Mar 2023 16:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678406452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CwwuvN2/fd3CFPcyFytkM67OmDcpA3Bq2U3hx1hICuM=;
        b=h5x2lS772DdPFHJeaPHBmALND5dQ+KUvsqeaZHaXKwPqfVMra/BwkHoyExk4IcPXDL
         4St68ZKITsEs2QzqJ4C2XGgHHQ2HMgJO5xd4Zza/hX2pzkqg8ex8uJOjWJHIRXJn1SZN
         JaPYYB2R9Bl2jDaQFkKOfvZcdlialoS6lewV+u4Tb9IlrssLRuMyVCQhaO0gKDgd33iZ
         Fogzip2FiFoKhyBeWEKajbgX8rxsQ5vtJ6ACdYbhStxz9FADP3HRl2/zdxR9PSAHgzun
         3G02tUA3vsE3wF5yTa2lf7hRQ4CZ/S7soJyB6aFT1kGQiGXUQr7wxhn8IqoozpjNxVHH
         gseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678406452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwwuvN2/fd3CFPcyFytkM67OmDcpA3Bq2U3hx1hICuM=;
        b=Bcz5dA/Ho6cBFkVFxmeHYYXUxzBox0LJ0WDNiyMlqHMTh7DZ3rN3qPjOoxnyW5QKUj
         VUJ0Fd/fcONz00FEJa3iqV4Zk4LLIFL3uuUpUXGjXhkSv4YTeP1aLW4o9S0okS6kdUvD
         I/rkkHbsIOE6wFsnGOGsO6xyltVIrFluQvXVhN1tLl+v1StsJsOjY1PsFunvqt8RHPv9
         Ss1+Xy+PhNLiWuSRGgk9GQKo4dx7v5CsxvLJiGFmoxCh8tqB2eUsJ0SB/aQRf/GkruNa
         TV/B2KOSV4Alv1EGc9LBQ/fkmV7NcY9S+XI/ccQvCOmXaaNrfNORLzTGC2sAVLACjuk7
         MLMg==
X-Gm-Message-State: AO0yUKVC32LaZrsRn3/XY1WLHlXe3W4ySBdVmAbh4191FkgaQeUjX1pe
        AdhYTaRPYd3ks5c8dtDRiu+itVlTEy0=
X-Google-Smtp-Source: AK7set/OQpZKCW3SPBmwIW6E25tlekgjA+Iu8odgpSdf4j/52LOPmKcZ8T+ueLeIBsmc/DeVpx4s1w==
X-Received: by 2002:a5d:8554:0:b0:744:b4c2:30fa with SMTP id b20-20020a5d8554000000b00744b4c230famr14428129ios.18.1678406452287;
        Thu, 09 Mar 2023 16:00:52 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w9-20020a927b09000000b00318ab825bb2sm185247ilc.35.2023.03.09.16.00.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 16:00:51 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] l2cap-tester: Add server tests for Ext-Flowctl
Date:   Thu,  9 Mar 2023 16:00:49 -0800
Message-Id: <20230310000049.3395992-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following tests:

L2CAP Ext-Flowctl Server - Success
L2CAP Ext-Flowctl Server - Nval SCID
L2CAP LE EATT Client - Success
L2CAP LE EATT Server - Success
L2CAP LE EATT Server - Reject
---
 tools/l2cap-tester.c | 287 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 246 insertions(+), 41 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 3f04640131fa..922533f34133 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -15,6 +15,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
+#include <poll.h>
 #include <stdbool.h>
 
 #include <glib.h>
@@ -81,6 +82,7 @@ struct l2cap_data {
 	bool server_not_advertising;
 	bool direct_advertising;
 	bool close_1;
+	bool defer;
 
 	bool shut_sock_wr;
 };
@@ -540,6 +542,64 @@ static const struct l2cap_data le_server_nval_scid_test = {
 	.expect_cmd_len = sizeof(nval_le_connect_rsp),
 };
 
+static const uint8_t ecred_connect_req[] = {	0x80, 0x00, /* PSM */
+						0x40, 0x00, /* MTU */
+						0x40, 0x00, /* MPS */
+						0x05, 0x00, /* Credits */
+						0x41, 0x00, /* SCID #1 */
+						0x42, 0x00, /* SCID #2 */
+						0x43, 0x00, /* SCID #3 */
+						0x44, 0x00, /* SCID #4 */
+						0x45, 0x00, /* SCID #5 */
+};
+
+static const uint8_t ecred_connect_rsp[] = {	0xa0, 0x02, /* MTU */
+						0xbc, 0x00, /* MPS */
+						0x04, 0x00, /* Credits */
+						0x00, 0x00, /* Result */
+						0x40, 0x00, /* DCID #1 */
+						0x41, 0x00, /* DCID #2 */
+						0x42, 0x00, /* DCID #3 */
+						0x43, 0x00, /* DCID #4 */
+						0x44, 0x00, /* DCID #5 */
+};
+
+static const struct l2cap_data ext_flowctl_server_success_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req,
+	.send_cmd_len = sizeof(ecred_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = ecred_connect_rsp,
+	.expect_cmd_len = sizeof(ecred_connect_rsp),
+};
+
+static const uint8_t nval_ecred_connect_req[] = {
+						0x80, 0x00, /* PSM */
+						0x40, 0x00, /* MTU */
+						0x40, 0x00, /* MPS */
+						0x05, 0x00, /* Credits */
+						0x01, 0x00, /* SCID #1 */
+};
+
+static const uint8_t nval_ecred_connect_rsp[] = {
+						0x00, 0x00, /* MTU */
+						0x00, 0x00, /* MPS */
+						0x00, 0x00, /* Credits */
+						0x09, 0x00, /* Result */
+						0x00, 0x00, /* DCID #1 */
+};
+
+static const struct l2cap_data ext_flowctl_server_nval_scid_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = nval_ecred_connect_req,
+	.send_cmd_len = sizeof(nval_ecred_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = nval_ecred_connect_rsp,
+	.expect_cmd_len = sizeof(nval_ecred_connect_rsp),
+};
+
 static const struct l2cap_data le_att_client_connect_success_test_1 = {
 	.cid = 0x0004,
 	.sec_level = BT_SECURITY_LOW,
@@ -549,6 +609,69 @@ static const struct l2cap_data le_att_server_success_test_1 = {
 	.cid = 0x0004,
 };
 
+static const struct l2cap_data le_eatt_client_connect_success_test_1 = {
+	.client_psm = 0x0027,
+	.server_psm = 0x0027,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.sec_level = BT_SECURITY_LOW,
+};
+
+static const uint8_t eatt_connect_req[] = {	0x27, 0x00, /* PSM */
+						0x40, 0x00, /* MTU */
+						0x40, 0x00, /* MPS */
+						0x05, 0x00, /* Credits */
+						0x41, 0x00, /* SCID #1 */
+};
+
+static const uint8_t eatt_connect_rsp[] = {	0xa0, 0x02, /* MTU */
+						0xbc, 0x00, /* MPS */
+						0x04, 0x00, /* Credits */
+						0x00, 0x00, /* Result */
+						0x40, 0x00, /* DCID #1 */
+};
+
+static const struct l2cap_data le_eatt_server_success_test_1 = {
+	.server_psm = 0x0027,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = eatt_connect_req,
+	.send_cmd_len = sizeof(eatt_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = eatt_connect_rsp,
+	.expect_cmd_len = sizeof(eatt_connect_rsp),
+	.defer = true,
+};
+
+static const uint8_t eatt_reject_req[] = {	0x27, 0x00, /* PSM */
+						0x40, 0x00, /* MTU */
+						0x40, 0x00, /* MPS */
+						0x05, 0x00, /* Credits */
+						0x41, 0x00, /* SCID #1 */
+						0x42, 0x00, /* SCID #2 */
+						0x43, 0x00, /* SCID #3 */
+						0x44, 0x00, /* SCID #4 */
+						0x45, 0x00, /* SCID #5 */
+};
+
+static const uint8_t eatt_reject_rsp[] = {	0xa0, 0x02, /* MTU */
+						0xbc, 0x00, /* MPS */
+						0x04, 0x00, /* Credits */
+						0x06, 0x00, /* Result */
+};
+
+static const struct l2cap_data le_eatt_server_reject_test_1 = {
+	.server_psm = 0x0027,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = eatt_reject_req,
+	.send_cmd_len = sizeof(eatt_reject_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = eatt_reject_rsp,
+	.expect_cmd_len = sizeof(eatt_reject_rsp),
+	.defer = true,
+	.expect_err = -1,
+};
+
 static const struct l2cap_data ext_flowctl_client_connect_success_test_1 = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
@@ -1689,6 +1812,89 @@ static void test_connect_2(const void *test_data)
 								defer);
 }
 
+static gboolean l2cap_accept_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	int sk;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	if (!check_mtu(data, sk)) {
+		tester_test_failed();
+		return FALSE;
+	}
+
+	if (l2data->read_data) {
+		struct bthost *bthost;
+
+		bthost = hciemu_client_get_host(data->hciemu);
+		g_io_add_watch(io, G_IO_IN, server_received_data, NULL);
+		bthost_send_cid(bthost, data->handle, data->dcid,
+					l2data->read_data, l2data->data_len);
+
+		g_io_channel_unref(io);
+
+		return FALSE;
+	} else if (l2data->write_data) {
+		struct bthost *bthost;
+		ssize_t ret;
+
+		bthost = hciemu_client_get_host(data->hciemu);
+		bthost_add_cid_hook(bthost, data->handle, data->scid,
+					server_bthost_received_data, NULL);
+
+		ret = write(sk, l2data->write_data, l2data->data_len);
+
+		if (ret != l2data->data_len) {
+			tester_warn("Unable to write all data");
+			tester_test_failed();
+		}
+
+		return FALSE;
+	}
+
+	tester_print("Successfully connected");
+
+	tester_test_passed();
+
+	return FALSE;
+}
+
+static bool defer_accept(struct test_data *data, GIOChannel *io)
+{
+	int sk;
+	char c;
+	struct pollfd pfd;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	memset(&pfd, 0, sizeof(pfd));
+	pfd.fd = sk;
+	pfd.events = POLLOUT;
+
+	if (poll(&pfd, 1, 0) < 0) {
+		tester_warn("poll: %s (%d)", strerror(errno), errno);
+		return false;
+	}
+
+	if (!(pfd.revents & POLLOUT)) {
+		if (read(sk, &c, 1) < 0) {
+			tester_warn("read: %s (%d)", strerror(errno), errno);
+			return false;
+		}
+	}
+
+	data->io_id = g_io_add_watch(io, G_IO_OUT, l2cap_accept_cb, NULL);
+
+	g_io_channel_unref(io);
+
+	tester_print("Accept deferred setup");
+
+	return true;
+}
+
 static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1707,53 +1913,24 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	if (!check_mtu(data, new_sk)) {
-		tester_test_failed();
-		close(new_sk);
-		return FALSE;
-	}
+	io = g_io_channel_unix_new(new_sk);
+	g_io_channel_set_close_on_unref(io, TRUE);
 
-	if (l2data->read_data) {
-		struct bthost *bthost;
-		GIOChannel *new_io;
-
-		new_io = g_io_channel_unix_new(new_sk);
-		g_io_channel_set_close_on_unref(new_io, TRUE);
-
-		bthost = hciemu_client_get_host(data->hciemu);
-		g_io_add_watch(new_io, G_IO_IN, server_received_data, NULL);
-		bthost_send_cid(bthost, data->handle, data->dcid,
-					l2data->read_data, l2data->data_len);
-
-		g_io_channel_unref(new_io);
-
-		return FALSE;
-	} else if (l2data->write_data) {
-		struct bthost *bthost;
-		ssize_t ret;
-
-		bthost = hciemu_client_get_host(data->hciemu);
-		bthost_add_cid_hook(bthost, data->handle, data->scid,
-					server_bthost_received_data, NULL);
-
-		ret = write(new_sk, l2data->write_data, l2data->data_len);
-		close(new_sk);
-
-		if (ret != l2data->data_len) {
-			tester_warn("Unable to write all data");
-			tester_test_failed();
+	if (l2data->defer) {
+		if (l2data->expect_err < 0) {
+			g_io_channel_unref(io);
+			tester_test_passed();
+			return FALSE;
 		}
 
+		if (!defer_accept(data, io)) {
+			tester_warn("Unable to accept deferred setup");
+			tester_test_failed();
+		}
 		return FALSE;
 	}
 
-	tester_print("Successfully connected");
-
-	close(new_sk);
-
-	tester_test_passed();
-
-	return FALSE;
+	return l2cap_accept_cb(io, cond, user_data);
 }
 
 static void client_l2cap_rsp(uint8_t code, const void *data, uint16_t len,
@@ -1844,6 +2021,8 @@ static void test_server(const void *test_data)
 	int sk;
 
 	if (l2data->server_psm || l2data->cid) {
+		int opt = 1;
+
 		sk = create_l2cap_sock(data, l2data->server_psm,
 					l2data->cid, l2data->sec_level,
 					l2data->mode);
@@ -1852,6 +2031,15 @@ static void test_server(const void *test_data)
 			return;
 		}
 
+		if (l2data->defer && setsockopt(sk, SOL_BLUETOOTH,
+				BT_DEFER_SETUP, &opt, sizeof(opt)) < 0) {
+			tester_warn("Can't enable deferred setup: %s (%d)",
+						strerror(errno), errno);
+			tester_test_failed();
+			close(sk);
+			return;
+		}
+
 		if (listen(sk, 5) < 0) {
 			tester_warn("listening on socket failed: %s (%u)",
 					strerror(errno), errno);
@@ -2066,6 +2254,13 @@ int main(int argc, char *argv[])
 				setup_powered_client,
 				test_connect_2);
 
+	test_l2cap_le("L2CAP Ext-Flowctl Server - Success",
+				&ext_flowctl_server_success_test,
+				setup_powered_server, test_server);
+	test_l2cap_le("L2CAP Ext-Flowctl Server - Nval SCID",
+				&ext_flowctl_server_nval_scid_test,
+				setup_powered_server, test_server);
+
 	test_l2cap_le("L2CAP LE ATT Client - Success",
 				&le_att_client_connect_success_test_1,
 				setup_powered_client, test_connect);
@@ -2073,5 +2268,15 @@ int main(int argc, char *argv[])
 				&le_att_server_success_test_1,
 				setup_powered_server, test_server);
 
+	test_l2cap_le("L2CAP LE EATT Client - Success",
+				&le_eatt_client_connect_success_test_1,
+				setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP LE EATT Server - Success",
+				&le_eatt_server_success_test_1,
+				setup_powered_server, test_server);
+	test_l2cap_le("L2CAP LE EATT Server - Reject",
+				&le_eatt_server_reject_test_1,
+				setup_powered_server, test_server);
+
 	return tester_run();
 }
-- 
2.39.2

