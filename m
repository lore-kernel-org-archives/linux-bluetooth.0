Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717930171F
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765399805; cv=none; b=HvfKtPtzgp5xe0ct92++yfF41WC6HYFX6jbej63zr8/LysV2b50l5EjEz6cjwFNWRNkEhMEVPOKnqmom+ofQLGFVtZkdHGJfms+duAUKrwXTnBLLfRZZdEG8x/R/x5YPZWEArltiteUIeUDb9E1fBukocWGNLTVYomtDljx+7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765399805; c=relaxed/simple;
	bh=1Orh4UVZhZsUyXCDodJWs9DqpDU21z3G6p7zm5lXgSY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UZz7CLgiq9PzMI2fboYIxYZSet2U4uO1N/+V1KvnyUbEnFoNzrST39IopYwlMA8z981mVlq15nfdgk9fdQKG3dzqb010AYzxBC7uWCwzXzqLFGb1kAwpH/JyyY9sWoIPd6WgZQBjcTrcQ8basBEU7b7OsGtF/tFJugWSvuKCwyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iR3XVz+j; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR3XVz+j"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-55e8c539b11so187664e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 12:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765399801; x=1766004601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i1bZxqauGwvI6KbbyF0X6x2PkgsvZL9Dbo9wPOjZFGo=;
        b=iR3XVz+jQjUkJgC1YGhshN4Ta6xVpYM+MzLXIwj3r2hurnIjUrBQI4//W+nLqeABHX
         qSXvOulsaKkCFnkckkoyB7aB1z5CtDgDCK6FNmC4LdQWv2rHRimLjcLab5B5L0pKAnBq
         8JyMvCczMo7ywRmv6tw8h3bPuOi84izH3lQONKIHw0h8f3WYab3eaOdSsRBR2pfLYrsd
         GH5a4m2q+jlP9kw0bhBwTJybDGfzks9WiLtkMAa0gkM1tdmDkYA8rfOuQZnOV76xWyXz
         wI6VbH4nZar8Df8og2cdJMbwM+OroZfjcKaBXNL7oYG1fqJ393T+qFsB/U2xNgrYdO6u
         HWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765399801; x=1766004601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1bZxqauGwvI6KbbyF0X6x2PkgsvZL9Dbo9wPOjZFGo=;
        b=MrnAl5/wgCDukfeHUVvGhThdlY5Z5IFzINpDyc52I6nPIzyCC6j9NGfXemcvdLUG/i
         B7aQrIDJHNIXu0q8n7k9adYDz7EOMyu73RGruRdnbdDorrTPekC65BtvKuRykNljIC2W
         Gs9XKVZ2KI6JGsPVJNXnQlk6KkbXyMoR1RSiuZJlB3pZ9TNc6N9Zn9dBEo7cxU4tGX1O
         FAX2uHDpUZLFUfQhbQU5pBfdq5oGU+6Q9j/NaI8LPgqPMULRiBfbYLJutXiSV61h3Puq
         e6G9cYm+hRe/59qERQkIHF980k5Qcq7UGwcIuG2PCQnb4+zMrV3h9bBVFKFZXaXAC4FQ
         4Htg==
X-Gm-Message-State: AOJu0YwUhzF5V/MYb98bNF0vDrrvr26n7dycRX+bIlwkIR4rZujV4FYv
	DYgwtRNWYOeBKdU1ECjzNIxlqVYITSW34RUk5H74srcQwgn83BCHu0c74FsR/npF
X-Gm-Gg: AY/fxX7A2mCPCv79EjwnhC0TOrwsUpyxNADYm92HD1W93zmuGmdpnef5pLbP/sn+xm2
	n7eIhLVS3HAmF+2rSxxgLrg3HrKIvY9hHdHxwguLUv8vzjGnxPIavXlhGXRaLRQ8gLssKf3ismS
	oDgj05S/ca2VXS6CA5f9kjU6/RGdukPk4zDf4oAxjL7l2RoBGyGYaY8yOlowOjMFVhji4uZxF+a
	Bb8kN80Fs2vJ6B8Vgo+Vic2YdmuST0m0qP+sBU9dWiNQGIPuV2GINEg7XitcZoJq0hxhd0j6PNW
	IalxeY5UvAwSTd/xuOp8mmgW00LJqowEGR1dToLJ2m29MvRukpsNmI2ryFavzZ/OvFKi1d5qJ0a
	jXu+9hF7GwER2cF0BqmSOLmPUsk9bqPoaAnH7mtgkOOHj0/NsZh84Rk9lUx8or/KhsuRl1YU7Re
	/TWlTRRSbN1p/tqg==
X-Google-Smtp-Source: AGHT+IEpURQN46j7eiV3xL8RqZx4P5f6tLID0qmZLS2lES/LephHcnVNTdHu7Ot/3kCLNnpYMaPiiQ==
X-Received: by 2002:a05:6122:c85:b0:55b:6b20:a17a with SMTP id 71dfb90a1353d-55fcfb52d3amr1435953e0c.9.1765399801386;
        Wed, 10 Dec 2025 12:50:01 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55fdc5efb62sm53435e0c.4.2025.12.10.12.49.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 12:50:00 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] l2cap-test: Add tests for BT_PHY
Date: Wed, 10 Dec 2025 15:49:52 -0500
Message-ID: <20251210204952.153725-1-luiz.dentz@gmail.com>
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
connection supported PHYs:

L2CAP BR/EDR Client - PHY
L2CAP BR/EDR Server - PHY
L2CAP LE Client - PHY
L2CAP LE Server - PHY
L2CAP Ext-Flowctl Client - PHY
L2CAP Ext-Flowctl Server - PHY
---
 tools/l2cap-tester.c | 110 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index a9ab8b05166f..2706a4b33f7b 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -46,6 +46,7 @@ struct test_data {
 	uint16_t scid;
 	uint16_t dcid;
 	struct l2cap_options l2o;
+	uint32_t phys;
 	int sk;
 	int sk2;
 	bool host_disconnected;
@@ -105,6 +106,9 @@ struct l2cap_data {
 
 	/* Socket type (0 means SOCK_SEQPACKET) */
 	int sock_type;
+
+	/* Expected supported PHYs */
+	uint32_t phys;
 };
 
 static void print_debug(const char *str, void *user_data)
@@ -420,6 +424,14 @@ static const struct l2cap_data client_connect_shut_wr_success_test = {
 	.shut_sock_wr = true,
 };
 
+static const struct l2cap_data client_connect_phy_test_1 = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.phys = (BT_PHY_BR_1M_1SLOT |
+	BT_PHY_EDR_2M_1SLOT | BT_PHY_EDR_2M_3SLOT | BT_PHY_EDR_2M_5SLOT |
+	BT_PHY_EDR_3M_1SLOT | BT_PHY_EDR_3M_3SLOT | BT_PHY_EDR_3M_5SLOT),
+};
+
 static const struct l2cap_data client_connect_nval_psm_test_1 = {
 	.client_psm = 0x1001,
 	.expect_err = ECONNREFUSED,
@@ -556,6 +568,17 @@ static const struct l2cap_data l2cap_server_nval_cid_test2 = {
 	.expect_cmd_len = sizeof(l2cap_nval_cfg_rsp),
 };
 
+static const struct l2cap_data l2cap_server_phy_test = {
+	.server_psm = 0x1001,
+	.send_cmd_code = BT_L2CAP_PDU_CONN_REQ,
+	.send_cmd = l2cap_connect_req,
+	.send_cmd_len = sizeof(l2cap_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_CONN_RSP,
+	.phys = (BT_PHY_BR_1M_1SLOT |
+	BT_PHY_EDR_2M_1SLOT | BT_PHY_EDR_2M_3SLOT | BT_PHY_EDR_2M_5SLOT |
+	BT_PHY_EDR_3M_1SLOT | BT_PHY_EDR_3M_3SLOT | BT_PHY_EDR_3M_5SLOT),
+};
+
 static const struct l2cap_data le_client_connect_success_test_1 = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
@@ -675,6 +698,12 @@ static const struct l2cap_data le_client_connect_reject_test_2 = {
 	.addr_type = BDADDR_LE_PUBLIC,
 };
 
+static const struct l2cap_data le_client_connect_phy_test_1 = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX),
+};
+
 static uint8_t nonexisting_bdaddr[] = {0x00, 0xAA, 0x01, 0x02, 0x03, 0x00};
 static const struct l2cap_data le_client_close_socket_test_1 = {
 	.client_psm = 0x0080,
@@ -752,6 +781,17 @@ static const struct l2cap_data le_server_nval_scid_test = {
 	.expect_cmd_len = sizeof(nval_le_connect_rsp),
 };
 
+static const struct l2cap_data le_server_phy_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = le_connect_rsp,
+	.expect_cmd_len = sizeof(le_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX),
+};
+
 static const uint8_t ecred_connect_req[] = {	0x80, 0x00, /* PSM */
 						0x40, 0x00, /* MTU */
 						0x40, 0x00, /* MPS */
@@ -810,6 +850,17 @@ static const struct l2cap_data ext_flowctl_server_nval_scid_test = {
 	.expect_cmd_len = sizeof(nval_ecred_connect_rsp),
 };
 
+static const struct l2cap_data ext_flowctl_server_phy_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req,
+	.send_cmd_len = sizeof(ecred_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = ecred_connect_rsp,
+	.expect_cmd_len = sizeof(ecred_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX),
+};
+
 static const struct l2cap_data le_att_client_connect_success_test_1 = {
 	.cid = 0x0004,
 	.sec_level = BT_SECURITY_LOW,
@@ -936,6 +987,13 @@ static const struct l2cap_data ext_flowctl_client_2_close_1 = {
 	.close_1 = true,
 };
 
+static const struct l2cap_data ext_flowctl_client_connect_phy_test_1 = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX),
+};
+
 static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -1384,6 +1442,28 @@ static bool check_mtu(struct test_data *data, int sk)
 	return true;
 }
 
+static bool check_phys(struct test_data *data,int sk)
+{
+	const struct l2cap_data *l2data = data->test_data;
+	socklen_t len;
+
+	len = sizeof(data->phys);
+	data->phys = 0;
+
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_PHY, &data->phys, &len) < 0) {
+		tester_warn("getsockopt(BT_PHY): %s (%d)",
+				strerror(errno), errno);
+		return false;
+	}
+
+	if (l2data->phys && l2data->phys != data->phys) {
+		tester_warn("phys 0x%08x != 0x%08x", l2data->phys, data->phys);
+		return false;
+	}
+
+	return true;
+}
+
 static gboolean recv_errqueue(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1559,6 +1639,11 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
+	if (!check_phys(data, sk)) {
+		tester_test_failed();
+		return FALSE;
+	}
+
 	if (l2data->read_data) {
 		l2cap_read_data(data, io, data->dcid);
 		return FALSE;
@@ -2279,6 +2364,11 @@ static gboolean l2cap_accept_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
+	if (!check_phys(data, sk)) {
+		tester_test_failed();
+		return FALSE;
+	}
+
 	if (l2data->read_data) {
 		l2cap_read_data(data, io, data->dcid);
 		return FALSE;
@@ -2628,6 +2718,10 @@ int main(int argc, char *argv[])
 					&client_connect_shut_wr_success_test,
 					setup_powered_client, test_connect);
 
+	test_l2cap_bredr("L2CAP BR/EDR Client - PHY",
+					&client_connect_phy_test_1,
+					setup_powered_client, test_connect);
+
 	test_l2cap_bredr("L2CAP BR/EDR Server - Success",
 					&l2cap_server_success_test,
 					setup_powered_server, test_server);
@@ -2664,6 +2758,9 @@ int main(int argc, char *argv[])
 	test_l2cap_bredr("L2CAP BR/EDR Server - Invalid Config CID",
 				&l2cap_server_nval_cid_test2,
 				setup_powered_server, test_server);
+	test_l2cap_bredr("L2CAP BR/EDR Server - PHY",
+				&l2cap_server_phy_test,
+				setup_powered_server, test_server);
 
 	test_l2cap_bredr("L2CAP BR/EDR Ethtool Get Ts Info - Success", NULL,
 			setup_powered_server, test_l2cap_ethtool_get_ts_info);
@@ -2710,6 +2807,9 @@ int main(int argc, char *argv[])
 	test_l2cap_bredr("L2CAP LE Client - Connection Reject",
 				&le_client_connect_reject_test_2,
 				setup_powered_client, test_connect_reject);
+	test_l2cap_le("L2CAP LE Client - PHY",
+				&le_client_connect_phy_test_1,
+				setup_powered_client, test_connect);
 
 	test_l2cap_le("L2CAP LE Client - Close socket 1",
 				&le_client_close_socket_test_1,
@@ -2738,7 +2838,8 @@ int main(int argc, char *argv[])
 					setup_powered_server, test_server);
 	test_l2cap_le("L2CAP LE Server - Nval SCID", &le_server_nval_scid_test,
 					setup_powered_server, test_server);
-
+	test_l2cap_le("L2CAP LE Server - PHY", &le_server_phy_test,
+					setup_powered_server, test_server);
 
 	test_l2cap_le("L2CAP Ext-Flowctl Client - Success",
 				&ext_flowctl_client_connect_success_test_1,
@@ -2769,12 +2870,19 @@ int main(int argc, char *argv[])
 				setup_powered_client,
 				test_connect_2);
 
+	test_l2cap_le("L2CAP Ext-Flowctl Client - PHY",
+				&ext_flowctl_client_connect_phy_test_1,
+				setup_powered_client, test_connect);
+
 	test_l2cap_le("L2CAP Ext-Flowctl Server - Success",
 				&ext_flowctl_server_success_test,
 				setup_powered_server, test_server);
 	test_l2cap_le("L2CAP Ext-Flowctl Server - Nval SCID",
 				&ext_flowctl_server_nval_scid_test,
 				setup_powered_server, test_server);
+	test_l2cap_le("L2CAP Ext-Flowctl Server - PHY",
+				&ext_flowctl_server_phy_test,
+				setup_powered_server, test_server);
 
 	test_l2cap_le("L2CAP LE ATT Client - Success",
 				&le_att_client_connect_success_test_1,
-- 
2.52.0

