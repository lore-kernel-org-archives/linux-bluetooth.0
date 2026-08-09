Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A153D524B
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Aug 2026 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786293927; cv=pass; b=iOvLbyCdE9P7ha9YJpGpIgJkNCPfl2QWQ6uguX+r5fBk8IeSEWlqfMqO49tMWRboginukmnpgdXMWxKuXUwNRpATcqaa90NnxpIZioV3M/ZdR0O7kH6mPcBTiF1iwl99DAgIYJChn0FmxpegjVWDoTY9kz3mWm/jRxm76Pk55g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786293927; c=relaxed/simple;
	bh=6nsXfZy45HT6CBHYCx+oIjqwbKlFYl81NKv4gvmChT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a61WyHHXEFmLwhCl5RbfVPsbgSP2S7l5ywOr15i8q76NZT7tut9j1osgPByp4Fbaum5zjivud9LT+eaI6mmuKYb8tzSlCTloLsvwYcZlaI9RGFLuRMytwbqNzdDrXAsDzqFQzt9uBJA7fF/21bNozpesEWXz2P2SYGfe2d2IpcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=sqwThwBu; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="sqwThwBu"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hJ3dw7475zyVG;
	Sun, 09 Aug 2026 19:45:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1786293909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6w/TpEw0A3jImwxHVVxXlRHWp+J6Ntg1HrROaOsVbSQ=;
	b=sqwThwBumEDfV7sNc5CB8XejcHCY8TSci7CeXEM1Aa6IYwqrUdNGrOXdUdeWiqu/MD1L70
	Y8MEU8a0QDe9eHUq+cO9d/of7gX2YlVAaV58p/aLxjy2Jx4ARGq0BMuyqeRMQs/XQI6gX0
	SaW5AmQtGuW8namhWVoi98W8sc5YI8s=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1786293909;
	b=jQZPzT3he1YnO2+98bw/xrybn1g+t+l5Ke4PHb2DYGPZ2wTLfzv8I5edehIVg9jjerZhPF
	Kp6UkG+zP/7SmEaT5tIxqxDRvMmc87ecMZw/JGRDh5fsSXJBsRevDNNo8EvSumu1dzDKoc
	0BpAl5eh7fddv9/gxU+68o7enJfTWOo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1786293909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6w/TpEw0A3jImwxHVVxXlRHWp+J6Ntg1HrROaOsVbSQ=;
	b=PfENFyPRGITR1d809j+NncAXD9SgZ/RIPI6hcnr6Ls44HxZ7rOfvFsOvnE9y2NBazkhzIp
	Kv75C6SYhKVIcVioHDEDHJ6BRKkQ4PSJR7swsz5QY73dRCReGnege/G44vFi9iOXbi7BjO
	jEwmcEPKtO4Z+Rb6HVS7M/PVJs92Scg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] tools/l2cap-tester: add tests changing BT_SECURITY after connecting
Date: Sun,  9 Aug 2026 19:45:05 +0300
Message-ID: <b85da0d5625e37d6289be01e3b83663c115420df.1786293828.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that change BT_SECURITY value after connection established:

L2CAP BR/EDR Client PIN Code Change Sec - Success
L2CAP LE Client Change Sec - Success
L2CAP LE ATT Client Change Sec  - Success
L2CAP LE EATT Client Change Sec - Success
---
 tools/l2cap-tester.c | 107 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 100 insertions(+), 7 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 3011a811e..69c529aa8 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -127,6 +127,9 @@ struct l2cap_data {
 	 * The address is filled in with the client bdaddr at runtime.
 	 */
 	const struct l2cap_conn_subrate *conn_subrate;
+
+	/* Change security level to this after connecting */
+	int change_sec_level;
 };
 
 static void print_debug(const char *str, void *user_data)
@@ -356,6 +359,17 @@ static const struct l2cap_data client_connect_pin_success_test = {
 	.client_pin_len = sizeof(pair_device_pin),
 };
 
+static const struct l2cap_data client_connect_pin_change_sec_success_test = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.sec_level  = BT_SECURITY_MEDIUM,
+	.pin = pair_device_pin,
+	.pin_len = sizeof(pair_device_pin),
+	.client_pin = pair_device_pin,
+	.client_pin_len = sizeof(pair_device_pin),
+	.change_sec_level = BT_SECURITY_HIGH,
+};
+
 static uint8_t l2_data[] = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
 
 const uint8_t l2_data_32k[32768] = { [0 ... 4095] =  0x00,
@@ -859,6 +873,13 @@ static const struct l2cap_data le_client_connect_success_test_2 = {
 	.sec_level  = BT_SECURITY_MEDIUM,
 };
 
+static const struct l2cap_data le_client_change_sec_success_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.sec_level  = BT_SECURITY_LOW,
+	.change_sec_level = BT_SECURITY_MEDIUM,
+};
+
 static const uint8_t cmd_reject_rsp[] = { 0x01, 0x01, 0x02, 0x00, 0x00, 0x00 };
 
 static const struct l2cap_data le_client_connect_reject_test_1 = {
@@ -1187,6 +1208,12 @@ static const struct l2cap_data le_att_client_connect_success_test_1 = {
 	.sec_level = BT_SECURITY_LOW,
 };
 
+static const struct l2cap_data le_att_client_change_sec_success_test = {
+	.cid = 0x0004,
+	.sec_level = BT_SECURITY_LOW,
+	.change_sec_level = BT_SECURITY_MEDIUM,
+};
+
 static const struct l2cap_data le_att_server_success_test_1 = {
 	.cid = 0x0004,
 };
@@ -1198,6 +1225,14 @@ static const struct l2cap_data le_eatt_client_connect_success_test_1 = {
 	.sec_level = BT_SECURITY_LOW,
 };
 
+static const struct l2cap_data le_eatt_client_change_sec_success_test = {
+	.client_psm = 0x0027,
+	.server_psm = 0x0027,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.sec_level = BT_SECURITY_LOW,
+	.change_sec_level = BT_SECURITY_MEDIUM,
+};
+
 static const uint8_t eatt_connect_req[] = {	0x27, 0x00, /* PSM */
 						0x40, 0x00, /* MTU */
 						0x40, 0x00, /* MPS */
@@ -1848,11 +1883,12 @@ static bool check_mtu(struct test_data *data, int sk)
 	return true;
 }
 
-static gboolean check_phy(gpointer args)
+static gboolean check_phy_and_sec(gpointer args)
 {
 	int sk = PTR_TO_INT(args);
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
+	struct bt_security sec;
 	socklen_t len;
 
 	len = sizeof(data->phys);
@@ -1874,6 +1910,24 @@ static gboolean check_phy(gpointer args)
 		return TRUE;
 	}
 
+	tester_print("Checking security level...");
+
+	len = sizeof(sec);
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &sec, &len) < 0) {
+		tester_warn("getsockopt(BT_SECURITY): %s (%d)",
+							strerror(errno), errno);
+		tester_test_failed();
+		goto done;
+	}
+
+	if (l2data->change_sec_level && sec.level != l2data->change_sec_level) {
+		tester_print("sec.level %d != %d", sec.level,
+						l2data->change_sec_level);
+
+		/* Retry */
+		return TRUE;
+	}
+
 	data->step--;
 
 done:
@@ -1882,10 +1936,12 @@ done:
 	return FALSE;
 }
 
-static int check_phys(struct test_data *data, int sk)
+static int check_phys_and_sec(struct test_data *data, int sk)
 {
 	const struct l2cap_data *l2data = data->test_data;
 	socklen_t len;
+	bool changed = false;
+	int err;
 
 	len = sizeof(data->phys);
 	data->phys = 0;
@@ -1901,17 +1957,41 @@ static int check_phys(struct test_data *data, int sk)
 		return -EINVAL;
 	}
 
+	if (l2data->change_sec_level) {
+		struct bt_security sec;
+
+		memset(&sec, 0, sizeof(sec));
+		sec.level = l2data->change_sec_level;
+
+		tester_print("Changing security level to %d", sec.level);
+
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &sec,
+							sizeof(sec)) < 0) {
+			err = -errno;
+			tester_warn("Can't set security level: %s (%d)",
+							strerror(errno), errno);
+			return err;
+		}
+
+		changed = true;
+	}
+
 	if (l2data->phy) {
 		if (setsockopt(sk, SOL_BLUETOOTH, BT_PHY, &l2data->phy,
 						sizeof(l2data->phy)) < 0) {
+			err = -errno;
 			tester_warn("setsockopt(BT_PHY): %s (%d)",
 					strerror(errno), errno);
-			return -errno;
+			return err;
 		}
 
-		/* Wait for the PHY to change */
+		changed = true;
+	}
+
+	if (changed) {
+		/* Wait for the change */
 		data->step++;
-		g_timeout_add(50, check_phy, INT_TO_PTR(sk));
+		g_timeout_add(50, check_phy_and_sec, INT_TO_PTR(sk));
 
 		return -EINPROGRESS;
 	}
@@ -2094,7 +2174,7 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	err = check_phys(data, sk);
+	err = check_phys_and_sec(data, sk);
 	if (err < 0) {
 		if (err == -EINPROGRESS) {
 			g_io_add_watch(io, G_IO_HUP, socket_closed_cb, NULL);
@@ -2824,7 +2904,7 @@ static gboolean l2cap_accept_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	err = check_phys(data, sk);
+	err = check_phys_and_sec(data, sk);
 	if (err < 0) {
 		if (err == -EINPROGRESS) {
 			g_io_add_watch(io, G_IO_HUP, socket_closed_cb, NULL);
@@ -3157,6 +3237,10 @@ int main(int argc, char *argv[])
 					&client_connect_pin_success_test,
 					setup_powered_client, test_connect);
 
+	test_l2cap_bredr("L2CAP BR/EDR Client PIN Code Change Sec - Success",
+				&client_connect_pin_change_sec_success_test,
+				setup_powered_client, test_connect);
+
 	test_l2cap_bredr("L2CAP BR/EDR Client - Read Success",
 					&client_connect_read_success_test,
 					setup_powered_client, test_connect);
@@ -3332,6 +3416,9 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP LE Client SMP - Success",
 				&le_client_connect_success_test_2,
 				setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP LE Client Change Sec - Success",
+				&le_client_change_sec_success_test,
+				setup_powered_client, test_connect);
 	test_l2cap_le("L2CAP LE Client - Command Reject",
 					&le_client_connect_reject_test_1,
 					setup_powered_client, test_connect);
@@ -3466,6 +3553,9 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP LE ATT Client - Success",
 				&le_att_client_connect_success_test_1,
 				setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP LE ATT Client Change Sec  - Success",
+				&le_att_client_change_sec_success_test,
+				setup_powered_client, test_connect);
 	test_l2cap_le("L2CAP LE ATT Server - Success",
 				&le_att_server_success_test_1,
 				setup_powered_server, test_server);
@@ -3473,6 +3563,9 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP LE EATT Client - Success",
 				&le_eatt_client_connect_success_test_1,
 				setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP LE EATT Client Change Sec - Success",
+				&le_eatt_client_change_sec_success_test,
+				setup_powered_client, test_connect);
 	test_l2cap_le("L2CAP LE EATT Server - Success",
 				&le_eatt_server_success_test_1,
 				setup_powered_server, test_server);
-- 
2.55.0

